Return-Path: <netdev+bounces-176888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D34AA6CAC1
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A87961B8185D
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A3122FF20;
	Sat, 22 Mar 2025 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="HTEpk2Ky"
X-Original-To: netdev@vger.kernel.org
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DA122FE07;
	Sat, 22 Mar 2025 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654452; cv=none; b=LdPZf/FKQOPYVjmTLVujr5fsRGobDTcRAHxfHI5elgCCdSdcTCKxJwt/QNBI8Eu7yfmiWN4yQ92Jobjd3/HeUfXOdsANh77rtsqFJygk7WKTA39ihUv/TFkiuOPmy90VamBMQ5dOkU4E1H7H3qje86e62NdxnolfNYzYyTnhRAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654452; c=relaxed/simple;
	bh=UbaU2Yq8pWWAB2+Sv7dghfP6ZsjOYUmwtm9fTAxyYtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NOQ2Dps9wmrECyZYHok+pLbL8oxTqqsbJUng0emHGFdqGbUaUV0Sy4ORPLeKejKuVxhIBINus9/aCcFsh+rpygMDPa8lJkzPytfXdPikrRPdLDl1EE0Z7DKTS5dlp51sLHz6QOtvth+GlZqYdG2gxi8Qrerq0op7OuNeKU1G9PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=HTEpk2Ky; arc=none smtp.client-ip=178.154.239.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net [IPv6:2a02:6b8:c37:f37c:0:640:1e45:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id F095160B49;
	Sat, 22 Mar 2025 17:40:48 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id keNKkuWLaeA0-4lIQk6Vj;
	Sat, 22 Mar 2025 17:40:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654448; bh=z/NR5H2N5ep07HsGrGNuf9TDnQNmA80l0yERkvqeWAg=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=HTEpk2KyVfT8XYsohGgJbmo+HyKDP/u/ggUbb6eCUhrJXE2l/kTgf5kpPaSlC3Phd
	 Jtbz5AOV6GPiIsNFobz/1/NKXTeO3QAyyaOSjnteECrTzBiBI6eguVcGY45UEJaa1M
	 yEwQ2MPpUazOHKDvhNk9sKQykeEuRwhK7bk0aHlk=
Authentication-Results: mail-nwsmtp-smtp-production-main-73.sas.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 23/51] hdlc_fr: Use __register_netdevice
Date: Sat, 22 Mar 2025 17:40:46 +0300
Message-ID: <174265444685.356712.759621883553836976.stgit@pro.pro>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <174265415457.356712.10472727127735290090.stgit@pro.pro>
References: <174265415457.356712.10472727127735290090.stgit@pro.pro>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The objective is to make dependent devices share
the same nd_lock.

Finaly, taking nd_lock should be moved to ioctl
caller, but now we can't do this at least because
netdevice notifiers are not converted.

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 drivers/net/wan/hdlc_fr.c |   18 ++++++++++++------
 net/core/dev_ioctl.c      |    1 +
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wan/hdlc_fr.c b/drivers/net/wan/hdlc_fr.c
index 81e72bc1891f..93c61083de76 100644
--- a/drivers/net/wan/hdlc_fr.c
+++ b/drivers/net/wan/hdlc_fr.c
@@ -1106,7 +1106,9 @@ static int fr_add_pvc(struct net_device *frad, unsigned int dlci, int type)
 	dev->priv_flags |= IFF_NO_QUEUE;
 	dev->ml_priv = pvc;
 
-	if (register_netdevice(dev) != 0) {
+	attach_nd_lock(dev, rcu_dereference_protected(frad->nd_lock, true));
+	if (__register_netdevice(dev) != 0) {
+		detach_nd_lock(dev);
 		free_netdev(dev);
 		delete_unused_pvcs(hdlc);
 		return -EIO;
@@ -1187,8 +1189,9 @@ static int fr_ioctl(struct net_device *dev, struct if_settings *ifs)
 	const size_t size = sizeof(fr_proto);
 	fr_proto new_settings;
 	hdlc_device *hdlc = dev_to_hdlc(dev);
+	struct nd_lock *nd_lock;
 	fr_proto_pvc pvc;
-	int result;
+	int result, err;
 
 	switch (ifs->type) {
 	case IF_GET_PROTO:
@@ -1272,10 +1275,13 @@ static int fr_ioctl(struct net_device *dev, struct if_settings *ifs)
 			result = ARPHRD_DLCI;
 
 		if (ifs->type == IF_PROTO_FR_ADD_PVC ||
-		    ifs->type == IF_PROTO_FR_ADD_ETH_PVC)
-			return fr_add_pvc(dev, pvc.dlci, result);
-		else
-			return fr_del_pvc(hdlc, pvc.dlci, result);
+		    ifs->type == IF_PROTO_FR_ADD_ETH_PVC) {
+			lock_netdev(dev, &nd_lock);
+			err = fr_add_pvc(dev, pvc.dlci, result);
+			unlock_netdev(nd_lock);
+		} else {
+			err = fr_del_pvc(hdlc, pvc.dlci, result);
+		}
 	}
 
 	return -EINVAL;
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 8592c052c0f4..dc2a0f513bac 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -496,6 +496,7 @@ static int dev_siocwandev(struct net_device *dev, struct if_settings *ifs)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
 
+	/* This may take nd_lock. See fr_add_pvc() */
 	if (ops->ndo_siocwandev) {
 		if (netif_device_present(dev))
 			return ops->ndo_siocwandev(dev, ifs);


