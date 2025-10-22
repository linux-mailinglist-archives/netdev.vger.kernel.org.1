Return-Path: <netdev+bounces-231861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 34295BFE011
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 21:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2EA44FDD15
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 19:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F33351FAC;
	Wed, 22 Oct 2025 19:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLvgQVsV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BCF351FA0
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 19:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761160641; cv=none; b=XPoIyiA4f2A85lSkOld9pdMx9U0Jw3aigLCxz7etgR6cDRc1+hcP34chwgnwfSTakUcy6ulfa2K0KQDQ10v7a1rP6rbKiPKPt49f4duzage4vuETvufBiS11JUnRaQSzypgvwYoIv5sSgO7ko78GmF22Im2aafRHqgZwa3MwW2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761160641; c=relaxed/simple;
	bh=mUN3BTWKGPONvfCEKmAW81IPY0gWokVgHv/p/7PSRpc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+Oxnsah8qyT841H8AyIW8+lVI86RD6FSugMfKsXL+sBoRsuuJScP3SXuiQNew3P3xacK/yBupowWvN+/oUaHTnwAnF37fA2bHOHGMhjQXXeTCSi4GWrgVWyI00Rm1/fmk5DfvfTj8PYy6jfn6YUh+7WF4925FLpho+zmnupTO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLvgQVsV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96932C4CEF7
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 19:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761160641;
	bh=mUN3BTWKGPONvfCEKmAW81IPY0gWokVgHv/p/7PSRpc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=iLvgQVsVtTaUAZSRbra7DTaMbmH0t8jsOILqHgn1zGD+xQVQB70goJz/wN8D/QQ/s
	 M//jwcPyyWp/etJlZIRelTWDqEmPpogxSFkmaIt1BptOmeoHdcGH2TsFrOPhKUeqV+
	 853JVRfmNP8vPA2gjeqkdRnGRdvZZwDqjUxK9c2yKtzfSGKNnpdYxQpWIHafIJdlQX
	 KTzNCcHsD6WRXZpbUNlAq3f/6FdJyeR42CqHdyP/PbAM5Qx6j6AdGB1DD8bgxpUN/Z
	 YhQjh270coguyi064HyDDdwF/zDrVMpH3Ju9SHvtFegUQDQbrUHf3hCBEXVDy0Es4X
	 KWa60QVkIOmpw==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Subject: [RFC 14/15] net/rds: Use proper peer port number even when not connected
Date: Wed, 22 Oct 2025 12:17:14 -0700
Message-ID: <20251022191715.157755-15-achender@kernel.org>
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

From: Greg Jumper <greg.jumper@oracle.com>

The function rds_tcp_get_peer_sport() should return the peer port of a
socket, even when the socket is not currently connected, so that RDS
can reliably determine the MPRDS "lane" corresponding to the port.

rds_tcp_get_peer_sport() calls kernel_getpeername() to get the port
number; however, when paths between endpoints frequently drop and
reconnect, kernel_getpeername() can return -ENOTCONN, causing
rds_tcp_get_peer_sport() to return an error, and ultimately causing
RDS to use the wrong lane for a port when reconnecting to a peer.

This patch modifies rds_tcp_get_peer_sport() to directly call the
socket-specific get-name function (inet_getname() in this case) that
kernel_getpeername() also calls.  The socket-specific function offers
an additional argument which, when set to a value greater than 1,
causes the function to return the socket's peer name even when the
socket is not connected, which in turn allows rds_tcp_get_peer_sport()
to return the correct port number.

Signed-off-by: Greg Jumper <greg.jumper@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/tcp_listen.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index f46bdfbd0834..db87a3e1bd5c 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -67,7 +67,11 @@ rds_tcp_get_peer_sport(struct socket *sock)
 	} saddr;
 	int sport;
 
-	if (kernel_getpeername(sock, &saddr.addr) >= 0) {
+	/* Call the socket's getname() function (inet_getname() in this case)
+	 * with a final argument greater than 1 to get the peer's port
+	 * regardless of whether the socket is currently connected.
+	 */
+	if (sock->ops->getname(sock, &saddr.addr, 2) >= 0) {
 		switch (saddr.addr.sa_family) {
 		case AF_INET:
 			sport = ntohs(saddr.sin.sin_port);
-- 
2.43.0


