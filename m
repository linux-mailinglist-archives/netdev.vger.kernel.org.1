Return-Path: <netdev+bounces-107778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EE291C501
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 19:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B8631F21524
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 17:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5F51CCCAC;
	Fri, 28 Jun 2024 17:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=o2.pl header.i=@o2.pl header.b="Stcy3Gxs"
X-Original-To: netdev@vger.kernel.org
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA90F1CB30C
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 17:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.222.135.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719596127; cv=none; b=gSjVudDwRMP9/OL4Z4OcCtnCjNjXkaqh0Ae4zXnWcAd72+eZFjEhvrs177Io4aYK8Q+Exj9UiLmI8jGg8F/3Im/mDg/oMipWWuLG2rKY0P32SjgglBS0L5VT5mWqaZ1X/glhREpMfOljrBRE1qm7XUWFhQnz1mpyAiN/jESTyg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719596127; c=relaxed/simple;
	bh=gsjx+rV4N04Kl1WCHhlJ4tV+7/Ofpag9Hxxm1AzjwuI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BrB/U1RGkbjQ/QdY0X2E9SY8cupQ6WP3nBNagMRjItzWIvvMOYZI3X8L9HLXzYYpMONPnFOkB4TJXkd92fJuzRjCWSwVnXcPQm0Pipk2CWt0vXmyCnNPu8m3w/MO0kdbNnUPqttuyCXicFFx/ASSZQR6aYsXvo6YO7blZbJJyX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=o2.pl; spf=pass smtp.mailfrom=o2.pl; dkim=pass (1024-bit key) header.d=o2.pl header.i=@o2.pl header.b=Stcy3Gxs; arc=none smtp.client-ip=193.222.135.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=o2.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=o2.pl
Received: (wp-smtpd smtp.tlen.pl 31124 invoked from network); 28 Jun 2024 19:28:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1719595722; bh=3R3PzXR8vg7/jMKEJYNILWpXdgNz/HP2r5QHUvDEtaA=;
          h=From:To:Cc:Subject;
          b=Stcy3GxskXr+IeTaF3EhBAn1RRn/sPKyXx/B9eKg9SWNyv16jfShJON1A/XLr8Kfj
           4G8l0Uz5Kjja3U0If6cfe7UOzFIEmVxNIlCNgf6ZXblfthQzPTcdXceHx3sHb/gOc+
           resX7SFr5I8rymY0825le39pFlfarhYhAN80mQFk=
Received: from 95.49.236.131.ipv4.supernova.orange.pl (HELO ARXL0208.home) (cosiekvfj@o2.pl@[95.49.236.131])
          (envelope-sender <cosiekvfj@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <davem@davemloft.net>; 28 Jun 2024 19:28:42 +0200
From: =?UTF-8?q?Kacper=20Piwi=C5=84ski?= <cosiekvfj@o2.pl>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Kacper=20Piwi=C5=84ski?= <cosiekvfj@o2.pl>
Subject: [PATCH] net/socket: clamp negative backlog value to 0 in listen()
Date: Fri, 28 Jun 2024 19:28:36 +0200
Message-Id: <20240628172836.19213-1-cosiekvfj@o2.pl>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: o2.pl)                                                      
X-WP-MailID: 7c6cc2d9ab1e5ffadeab9a5258382423
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 000000B [sTOU]                               

According to manual: https://man7.org/linux/man-pages/man3/listen.3p.html
If listen() is called with a backlog argument value that is less
than 0, the function behaves as if it had been called with a
backlog argument value of 0.

Signed-off-by: Kacper Piwiński <cosiekvfj@o2.pl>
---
 net/socket.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/socket.c b/net/socket.c
index e416920e9..9567223d7 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1873,8 +1873,7 @@ int __sys_listen(int fd, int backlog)
 	sock = sockfd_lookup_light(fd, &err, &fput_needed);
 	if (sock) {
 		somaxconn = READ_ONCE(sock_net(sock->sk)->core.sysctl_somaxconn);
-		if ((unsigned int)backlog > somaxconn)
-			backlog = somaxconn;
+		backlog = clamp(backlog, 0, somaxconn);
 
 		err = security_socket_listen(sock, backlog);
 		if (!err)
-- 
2.34.1


