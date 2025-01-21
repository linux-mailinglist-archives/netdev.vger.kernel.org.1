Return-Path: <netdev+bounces-160067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79059A18041
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 15:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F373E3A3F5D
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 14:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8FB1F3FF3;
	Tue, 21 Jan 2025 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="PemGF11Q"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2061F192A
	for <netdev@vger.kernel.org>; Tue, 21 Jan 2025 14:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737470690; cv=none; b=b6Zz1qCh5s5HmrSm3bd6iSAqkIgGWl2PojG4SQD4RXNVMpUC7inJq36Uwmw6sg9YS3MI1iGxsu97xyhCUSBIzxiyUEU2rXbjVnGkTNRASZuDJHHIwEzaR8AK3mpRYlTW04RFEoZnIN00aJn9704MaAK1zOftC+6uEGZO471uHmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737470690; c=relaxed/simple;
	bh=cTxfqQumWrX9p9vgoH+bzHQWknxGEW2vBnnzq/xe8M0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gb4CZmk5A0hc+rb7+MTWTCW/ArUZ5uRZOpFCmW+579VT1B6qoZps8jzrh16RgsdTyHPDK0hY9xFdQ+mrZQDGowyYfXsMbojx5+Urrc0JeOMPcURNGlVZg0qkm04csDStanJuenL77u2EHZO1dIENN+2taNHQaaf3L0iZkdtpSwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=PemGF11Q; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1taFUf-000mDI-5V; Tue, 21 Jan 2025 15:44:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=gTVgLxbsCTs6/l5ZkRIXt43+EVx3CmI11pzEhSVDs3Y=; b=PemGF11QuncODYIZiZ2OkQ+py7
	EnqhYxfUFXMGVg7TsnBJ2XpwRp7Zr6dmh7ed8/id4pccfToOqtMfiS31ZLEUBlYwNzEZ/yLgx8KnH
	U1mRau25eQ4pr86ksTV9Fsw4Y9ek5l4M862ynTJVSlf8HNZrWIAr3htmWI75MHtz+sZo+FDTVqev5
	4AseJp2Dtik8sZSRErsJf5xDEJh3GKSquCnBhTt4glHCgAiFKtjMQTgApX62rP3EJFXIkObbwhqKr
	iQ467PnWhL/hwU4qvkgG2yNtP16kSS1KbNUTKOU+pBRT2melnN1onA3Ytnot5PVUwfppFMsQt148e
	O/jTM3Ww==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1taFUe-0007Kr-9t; Tue, 21 Jan 2025 15:44:40 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1taFUQ-00AHot-Td; Tue, 21 Jan 2025 15:44:26 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Tue, 21 Jan 2025 15:44:03 +0100
Subject: [PATCH net v2 2/6] vsock: Allow retrying on connect() failure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250121-vsock-transport-vs-autobind-v2-2-aad6069a4e8c@rbox.co>
References: <20250121-vsock-transport-vs-autobind-v2-0-aad6069a4e8c@rbox.co>
In-Reply-To: <20250121-vsock-transport-vs-autobind-v2-0-aad6069a4e8c@rbox.co>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, George Zhang <georgezhang@vmware.com>, 
 Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>
Cc: netdev@vger.kernel.org, Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

sk_err is set when a (connectible) connect() fails. Effectively, this makes
an otherwise still healthy SS_UNCONNECTED socket impossible to use for any
subsequent connection attempts.

Clear sk_err upon trying to establish a connection.

Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/vmw_vsock/af_vsock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index cfe18bc8fdbe7ced073c6b3644d635fdbfa02610..075695173648d3a4ecbd04e908130efdbb393b41 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1523,6 +1523,11 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
 		if (err < 0)
 			goto out;
 
+		/* sk_err might have been set as a result of an earlier
+		 * (failed) connect attempt.
+		 */
+		sk->sk_err = 0;
+
 		/* Mark sock as connecting and set the error code to in
 		 * progress in case this is a non-blocking connect.
 		 */

-- 
2.48.1


