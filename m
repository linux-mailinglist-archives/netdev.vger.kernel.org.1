Return-Path: <netdev+bounces-206445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25904B03293
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 20:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF5E17AAC7
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 18:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43661991B6;
	Sun, 13 Jul 2025 18:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qiEMY0Vi"
X-Original-To: netdev@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFF52E370F
	for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 18:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752429702; cv=none; b=mWAHW1YDuGRikP9xhNKBILKDnD2YwJwgFr+/c7RdnvdBhPnEJbav9/aHuoMt5EAbCDrk67OmwBLd6O1R4V/tJIq1+DI49LiKPDLX2sxiid8XMWiu1ywoVl0OjksOM7HcCfc5ph6JY/3DVKAFxKR+K1SwxlyEwehEBez15XiX9jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752429702; c=relaxed/simple;
	bh=p9hwId6PXUzaYbBiEhyhODus2NORbs661RdDVBddeG8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YgHY5jJR9haiKeBgu++U0w9EcrgqyET202PxSPpXLUqDamtshygM6V5ltRWXT6lZKkrKbC78NGFMERTqZAIB6w5KyldyWxFMp1qF/avw/Ce9MyDMaM3O+YaWwKG/1jNhKD7cAmjH96sY/KXHbTmJqZYBttNqhs7vGFZv08MgLVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qiEMY0Vi; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=jl72u5vNCVM5mUST/eG0kwtw7loUA0OWBRfKo2uc48U=; b=qiEMY0ViW+bcuf9p25nn/DYyQo
	RI5fK6vcRCQQMdqurpELHb6JYSo2zqhoeiuMrbZbI7iBiFBnq0YkcFyxaP8dlKrfE7k1TOCKbFeXz
	YbB/BplJynFnBO/vdeoYIdelJwDNo008qylEg0rK7c+i+ILsGVsGHpo+iSJbWlpEbadKfSOqh62ub
	VloeUzNpQQA4rp4lE0vTp9iPvoZwSBb2VDcTxBauszGAO19ZuCbPdv8Uum0LCngKnENAlB0f2gMHM
	wG4Pb8/5LL+nJ9hl/kSwg2705HUZXiQzSMQC4K6Dp7CnmFr8cSzyaQp2JjVsW2k4zl9BT1r5rtQTz
	4005DJvw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ub114-00000000mEy-0WpP;
	Sun, 13 Jul 2025 18:01:34 +0000
Date: Sun, 13 Jul 2025 19:01:34 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Allison Henderson <allison.henderson@oracle.com>
Cc: netdev@vger.kernel.org
Subject: [RFC][PATCH] don't open-code kernel_accept() in rds_tcp_accept_one()
Message-ID: <20250713180134.GC1880847@ZenIV>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	rds_tcp_accept_one() starts with a pretty much verbatim
copy of kernel_accept().  Might as well use the real thing...

	That code went into mainline in 2009, kernel_accept()
had been added in Aug 2006, the copyright on rds/tcp_listen.c
is "Copyright (c) 2006 Oracle", so it's entirely possible
that it predates the introduction of kernel_accept().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index d89bd8d0c354..af36f5bf8649 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -105,10 +105,6 @@ int rds_tcp_accept_one(struct socket *sock)
 	int conn_state;
 	struct rds_conn_path *cp;
 	struct in6_addr *my_addr, *peer_addr;
-	struct proto_accept_arg arg = {
-		.flags = O_NONBLOCK,
-		.kern = true,
-	};
 #if !IS_ENABLED(CONFIG_IPV6)
 	struct in6_addr saddr, daddr;
 #endif
@@ -117,25 +113,9 @@ int rds_tcp_accept_one(struct socket *sock)
 	if (!sock) /* module unload or netns delete in progress */
 		return -ENETUNREACH;
 
-	ret = sock_create_lite(sock->sk->sk_family,
-			       sock->sk->sk_type, sock->sk->sk_protocol,
-			       &new_sock);
+	ret = kernel_accept(sock, &new_sock, O_NONBLOCK);
 	if (ret)
-		goto out;
-
-	ret = sock->ops->accept(sock, new_sock, &arg);
-	if (ret < 0)
-		goto out;
-
-	/* sock_create_lite() does not get a hold on the owner module so we
-	 * need to do it here.  Note that sock_release() uses sock->ops to
-	 * determine if it needs to decrement the reference count.  So set
-	 * sock->ops after calling accept() in case that fails.  And there's
-	 * no need to do try_module_get() as the listener should have a hold
-	 * already.
-	 */
-	new_sock->ops = sock->ops;
-	__module_get(new_sock->ops->owner);
+		return ret;
 
 	rds_tcp_keepalive(new_sock);
 	if (!rds_tcp_tune(new_sock)) {

