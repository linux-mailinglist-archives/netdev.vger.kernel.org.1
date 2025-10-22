Return-Path: <netdev+bounces-231857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FB2BFDFFC
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 21:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F08474FB618
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD5A350282;
	Wed, 22 Oct 2025 19:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmopBKIp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2766F34EF1D
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 19:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761160640; cv=none; b=mokjOdWX+BQf+HI8QUj+mHcJA+BCLh3lMj8zmNgaTJvu6YDUONzEd3q9SCF4EX4PgVZRNjwxHR7NPLgZ6r8s0/g0mflK4DSqiLThww75TCpzBvYk3hJEAnD629ToWPnQwXYsvrgsgrjQ2zbCj99WTDDfvxA72ztwI/dviO25hVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761160640; c=relaxed/simple;
	bh=FxllRejIcnms8GxCuRN/I8ILMk4Bv/XPojvDZNA0ymo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+udI7tSsZ9Pd6I7dNPxw0/ahYAIOICIPX3OMolwYMYS7oM5BXmS3arSI3pYmJQ1cKMEDOWM9mG84+yLLVTSUb2uCjx2x5A8wfV9Mvy4hjlOk639M34ODJSCkiNm7lP6Na8ipHT28pLN16gYHNwPafzq7Bro4/FgBzS7k1nTfvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmopBKIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE3BC4CEFD
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 19:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761160640;
	bh=FxllRejIcnms8GxCuRN/I8ILMk4Bv/XPojvDZNA0ymo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HmopBKIpegFd8ZZU0xMEYFycMHBe879xY/6rkUspUIhLoD1KbGdlRNL9X0opBLgwd
	 j5EoF2/tD+8h+eW1wPF9TE31X0WXjwOKjRCWxo3GVzigTy4L2Q6d+KY+wWIUF4m9My
	 lNkPpaZHk+04pisH5FI1dpK78+hMvfuHf3goiTgwzN6NXu7JYfdbQHyNQxuAPXyArs
	 VKzSTfV7s6rxHJdZxR5vvwLzLjiJ00up+DrQTXkVGnkQJs1xJV968USIMm0FclrkTd
	 7PRDPejNbR2T77gqftR+UGhaGDMoWncPpcu/KPOpX9gFyiyE2bEOxXeRqNbvhZYVeW
	 UKmQI77kHxvTw==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Subject: [RFC 09/15] net/rds: Kick-start TCP receiver after accept
Date: Wed, 22 Oct 2025 12:17:09 -0700
Message-ID: <20251022191715.157755-10-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251022191715.157755-1-achender@kernel.org>
References: <20251022191715.157755-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gerd Rausch <gerd.rausch@oracle.com>

In cases where the server (the node with the higher IP-address)
in an RDS/TCP connection is overwhelmed it is possible that the
socket that was just accepted is chock-full of messages, up to
the limit of what the socket receive buffer permits.

Subsequently, "rds_tcp_data_ready" won't be called anymore,
because there is no more space to receive additional messages.

Nor was it called prior to the point of calling "rds_tcp_set_callbacks",
because the "sk_data_ready" pointer didn't even point to
"rds_tcp_data_ready" yet.

We fix this by simply kick-starting the receive-worker
for all cases where the socket state is neither
"TCP_CLOSE_WAIT" nor "TCP_CLOSE".

Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/tcp_listen.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index b8a4ec424085..3da259f3a556 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -291,6 +291,8 @@ int rds_tcp_accept_one(struct rds_tcp_net *rtn)
 	    new_sock->sk->sk_state == TCP_LAST_ACK ||
 	    new_sock->sk->sk_state == TCP_CLOSE)
 		rds_conn_path_drop(cp, 0);
+	else
+		queue_delayed_work(cp->cp_wq, &cp->cp_recv_w, 0);
 
 	new_sock = NULL;
 	ret = 0;
-- 
2.43.0


