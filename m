Return-Path: <netdev+bounces-145626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA939D028D
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 10:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EDBF1F224E8
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 09:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1263B49627;
	Sun, 17 Nov 2024 09:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="nxCPSZ9p"
X-Original-To: netdev@vger.kernel.org
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [178.154.239.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C92DDD2;
	Sun, 17 Nov 2024 09:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731834335; cv=none; b=uaFVSyGDzljxZqgmEWGs+R1msOPVVt0TzhWPQfWBJ6uXayL82+3VWDL7vOeVxkD4LChy1LW6NtdI3+8ElSMFS2+beeaUXnXuMeZKqrWDN5MwlXhdtkH3DsdVWmyT6rf9XUHVwGgcierh8KP/xdYHyjGLYmRuB6li1qVMI0sUJyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731834335; c=relaxed/simple;
	bh=21Ja/cW+nuYGvUjhuMbMplc1F2C3v6Jt1NUkmdyCWxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uVIUObcsJtbz2jjag7AMu5+M1SXBULk3XrnMRUrWadJHp1pf4uYqO7dIRX/rIblIuD0l7iwQ6CEIKa+49cj8K2GvwCfCHcvEvJyqZJen2Ij7k4hueWcYPy3ogDd3BaforZX6KtptxhyZwI1xUztM4A6soeNT9LEYkk/K/Tppn4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=nxCPSZ9p; arc=none smtp.client-ip=178.154.239.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:5c05:0:640:fb47:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id 5F42160C79;
	Sun, 17 Nov 2024 12:05:23 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id L5LP4n8Oq4Y0-NMAcqhFJ;
	Sun, 17 Nov 2024 12:05:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1731834322; bh=9DY/S36QSTTF6M19/iItAnGmg366WApJ9ys6nHJqW9g=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=nxCPSZ9pSGUhe45L+iylBUI2wbHxCPqY9EZoUZ61EWEmOlJ5KTopWTrs9N6O1MPcQ
	 nx5Ko964NaSsS+iJS9gW1oJbhKZIYc6IqgfqmnJTlVhIhfCVL+mkNxlvlLUcasrIEF
	 HSVsGX0ACBj1VQfwS6AsnKQCeH9Xduu1kY+K3W2I=
Authentication-Results: mail-nwsmtp-smtp-production-main-85.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Stas Sergeev <stsp2@yandex.ru>
To: linux-kernel@vger.kernel.org
Cc: Stas Sergeev <stsp2@yandex.ru>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] tun: fix group permission check
Date: Sun, 17 Nov 2024 12:05:14 +0300
Message-ID: <20241117090514.9386-1-stsp2@yandex.ru>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently tun checks the group permission even if the user have matched.
Besides going against the usual permission semantic, this has a
very interesting implication: if the tun group is not among the
supplementary groups of the tun user, then effectively no one can
access the tun device. CAP_SYS_ADMIN still can, but its the same as
not setting the tun ownership.

This patch relaxes the group checking so that either the user match
or the group match is enough. This avoids the situation when no one
can access the device even though the ownership is properly set.

Also I simplified the logic by removing the redundant inversions:
tun_not_capable() --> !tun_capable()

Signed-off-by: Stas Sergeev <stsp2@yandex.ru>

CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: Jason Wang <jasowang@redhat.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>
CC: "David S. Miller" <davem@davemloft.net>
CC: Eric Dumazet <edumazet@google.com>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>
CC: netdev@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 drivers/net/tun.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 9a0f6eb32016..d35b6a48d138 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -574,14 +574,18 @@ static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
 	return ret;
 }
 
-static inline bool tun_not_capable(struct tun_struct *tun)
+static inline bool tun_capable(struct tun_struct *tun)
 {
 	const struct cred *cred = current_cred();
 	struct net *net = dev_net(tun->dev);
 
-	return ((uid_valid(tun->owner) && !uid_eq(cred->euid, tun->owner)) ||
-		  (gid_valid(tun->group) && !in_egroup_p(tun->group))) &&
-		!ns_capable(net->user_ns, CAP_NET_ADMIN);
+	if (ns_capable(net->user_ns, CAP_NET_ADMIN))
+		return 1;
+	if (uid_valid(tun->owner) && uid_eq(cred->euid, tun->owner))
+		return 1;
+	if (gid_valid(tun->group) && in_egroup_p(tun->group))
+		return 1;
+	return 0;
 }
 
 static void tun_set_real_num_queues(struct tun_struct *tun)
@@ -2778,7 +2782,7 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
 		    !!(tun->flags & IFF_MULTI_QUEUE))
 			return -EINVAL;
 
-		if (tun_not_capable(tun))
+		if (!tun_capable(tun))
 			return -EPERM;
 		err = security_tun_dev_open(tun->security);
 		if (err < 0)
-- 
2.47.0


