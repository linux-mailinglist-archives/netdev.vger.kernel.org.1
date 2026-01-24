Return-Path: <netdev+bounces-253053-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCuXN0yBdGl96QAAu9opvQ
	(envelope-from <netdev+bounces-253053-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 09:22:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCEA7CF9A
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 09:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 72A483003802
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 08:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4806928980E;
	Sat, 24 Jan 2026 08:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atbeYRUr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29720184540
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 08:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769242948; cv=none; b=K8nOCN2CGaiF1LdOtKCOE8I6Gs/OPEGUI4TttC1bHfSuUUKIph4ZrwyIk0/kY+QsevMXDj609+Xq8GWTBZ+QycQe1U3SHzl3R1CiBphm3uYfjPNAljJVnVjqHKW5NbDvOTw3HV72/b1vo3D6NAquEsboqQk0i5dsEPoMf4Oo4Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769242948; c=relaxed/simple;
	bh=4sLGIDfXd1xIm3LJxngk2dLM3NG/bVlSBj6Kjj7ew4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EP1xIMRZeqlFSPsPuYD9UHLF2S/IeUKYJGtghyMuRCM3eifyvnnt/A9YQ8KIymDLeiGBGjvEdZWlJk3AoIa47BcTgr4znErFGWyp3lS6D5K6on7YoAKynHRB0PJFlDLydm+ZK+LOpBmgXmOz9cdXuz9Gt6V1sqrIZh1LjJN1Cv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atbeYRUr; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2b71557299dso4210625eec.1
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 00:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769242945; x=1769847745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LW8OCt4Vo19miV6OizeNdC9eiKKm2vvykQCHxibPDrA=;
        b=atbeYRUr2U7FIUkwqeTbazPV6lBeCc8C73AJV++EnDgzjM/evnbfEg7YzbOh9QnVqJ
         knKZKR+zHoRoDWnz+QH/2g/kSqA/jrXq3TcrrDhAPGWcDFRXc9nebY0gqBhGcjC9XdZo
         tRuYcd/xaNVzlnMBaYotxWVew6X9VlOIIA1YoyPLL2aHvB2VR5ou7StR/k8pBAA24x9M
         uIGZH0Lxj9E7kgV7zptkJNSH4v5OYL7381UnoRFP2upABxi8327zFbsr0B0P842VJeXx
         QSid4z+KEOLa+RIjPr+0uJ776w90LWiKu+8KnFT1u/j5WO1/ViS9Vz19nWyR3FCsp4uf
         oA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769242945; x=1769847745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LW8OCt4Vo19miV6OizeNdC9eiKKm2vvykQCHxibPDrA=;
        b=LJjwXv5W4Fmr/e7UpTP4OfjYTHGuDQBP9ly+efLAi8jMtxVM764AhAaVy0ut+Rktja
         5lYHKhXFjai+A6X+CtFuOWm5tl9xjGR1i2hs8Su2yyySK/fjdJpF4Y2yDSdlxue5p69b
         O6jDYfy2Z9qseeAUUZAKT2LXp7L/pHlpFE0AN8Yk/7RsBAw0R7Gr1BvVbaWjNWqsa0ZX
         Oe7PdYHz7N/VMdW17dOV6/IN1lL+FNw+eLnmR+syfIbZcNL1WgV7oBstVlJ1dXfpbMZ3
         imT7fc1WiqsNBHUXbZs9YTxgRgTTzYqClHTHKQzK4cq9C2/4ADZv9kkc+hD+3fCKox2P
         c2Mw==
X-Gm-Message-State: AOJu0Yy/rNZOqgUHxDjM0tfiofO+6BTSYWTd5KwlYD9pvTVyPhvNKuzf
	bh5oYo4RaNd6CX3l/PcazGK5TasX+5JROe9WZMLkaIqW6FgorLsI+ALCElzfCOOA
X-Gm-Gg: AZuq6aITLcin+3eJ40CzfINAkKpJzk5Jp5fJrvxGiXZ47cVR1JFC7j9RwDMzROQhpdE
	06HGmNp/IUjER3fMTJ/KNOW/urZFdu0KAqei1Xf+n2+OkE74P+J6Fqr60oDE4S8e/K5fJKUPitH
	3lMw6FU3rB6GWf/tpeRQ0Jl8LtHK8VpwRGsch2IKCTFlJO6GxprJuci8eFm8hGsE+Btt9Cp/fTv
	ULbqECnjhF3TSakR289UTBKn0nB10OUG8OOCvhRiOW1O135Zx1+5i+CBni05SpwqB08mLh4fiuw
	RdPmGse4s4ulmlmj75t4peggee3IH8w/DNFoJqDaW7r4COhWUYaCijNVMfJugoy/bSNFThO81pE
	ZZU5YRwS1amHqJrbzF+EGM++y/H7dGSGuTKKwq4ezuAYPIBW0lgRmLGm63kFjs91Xrl/ZEg+Y0M
	+uJpcPTw9Iqci57X5nVB7xerEHLFj6ZRs8okrEIiKP29K3A9dp9X3w1FT602dCur4+EB+DlX6At
	z5USHzjpZmjLCi4jmMHBpR4QpUo3AZfoeFqZHCkVlQ4gebnOsk2WbRg+mYRtOk1TStRI6mylkte
	yFTs
X-Received: by 2002:a05:7022:4184:b0:11b:c1fb:89a with SMTP id a92af1059eb24-1247dbf817bmr3268608c88.32.1769242945142;
        Sat, 24 Jan 2026 00:22:25 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d91ca0fsm7966297c88.8.2026.01.24.00.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 00:22:24 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Korsgaard <peter@korsgaard.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Max Schulze <max.schulze@online.de>,
	=?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>
Subject: [PATCH net-next] net: usb: replace unnecessary get_link functions with usbnet_get_link
Date: Sat, 24 Jan 2026 00:22:06 -0800
Message-ID: <20260124082217.82351-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,korsgaard.com,pengutronix.de,online.de,piap.pl];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-253053-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1BCEA7CF9A
X-Rspamd-Action: no action

usbnet_get_link calls mii_link_ok if the device has a MII defined in
its usbnet struct and no check_connect function defined there. This is
true of these drivers, so their custom get_link functions which call
mii_link_ok are useless. Remove them in favor of usbnet_get_link.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/usb/asix_devices.c | 11 ++---------
 drivers/net/usb/dm9601.c       |  9 +--------
 drivers/net/usb/sr9800.c       |  9 +--------
 3 files changed, 4 insertions(+), 25 deletions(-)

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index 232bbd79a4de..c73cf52a65a8 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -97,13 +97,6 @@ static u32 asix_get_phyid(struct usbnet *dev)
 	return phy_id;
 }
 
-static u32 asix_get_link(struct net_device *net)
-{
-	struct usbnet *dev = netdev_priv(net);
-
-	return mii_link_ok(&dev->mii);
-}
-
 static int asix_ioctl (struct net_device *net, struct ifreq *rq, int cmd)
 {
 	struct usbnet *dev = netdev_priv(net);
@@ -116,7 +109,7 @@ static int asix_ioctl (struct net_device *net, struct ifreq *rq, int cmd)
    devices that may be connected at the same time. */
 static const struct ethtool_ops ax88172_ethtool_ops = {
 	.get_drvinfo		= asix_get_drvinfo,
-	.get_link		= asix_get_link,
+	.get_link		= usbnet_get_link,
 	.get_msglevel		= usbnet_get_msglevel,
 	.set_msglevel		= usbnet_set_msglevel,
 	.get_wol		= asix_get_wol,
@@ -986,7 +979,7 @@ static void ax88178_unbind(struct usbnet *dev, struct usb_interface *intf)
 
 static const struct ethtool_ops ax88178_ethtool_ops = {
 	.get_drvinfo		= asix_get_drvinfo,
-	.get_link		= asix_get_link,
+	.get_link		= usbnet_get_link,
 	.get_msglevel		= usbnet_get_msglevel,
 	.set_msglevel		= usbnet_set_msglevel,
 	.get_wol		= asix_get_wol,
diff --git a/drivers/net/usb/dm9601.c b/drivers/net/usb/dm9601.c
index 2b4716ccf0c5..5540f7ec4906 100644
--- a/drivers/net/usb/dm9601.c
+++ b/drivers/net/usb/dm9601.c
@@ -266,13 +266,6 @@ static void dm9601_get_drvinfo(struct net_device *net,
 	usbnet_get_drvinfo(net, info);
 }
 
-static u32 dm9601_get_link(struct net_device *net)
-{
-	struct usbnet *dev = netdev_priv(net);
-
-	return mii_link_ok(&dev->mii);
-}
-
 static int dm9601_ioctl(struct net_device *net, struct ifreq *rq, int cmd)
 {
 	struct usbnet *dev = netdev_priv(net);
@@ -282,7 +275,7 @@ static int dm9601_ioctl(struct net_device *net, struct ifreq *rq, int cmd)
 
 static const struct ethtool_ops dm9601_ethtool_ops = {
 	.get_drvinfo	= dm9601_get_drvinfo,
-	.get_link	= dm9601_get_link,
+	.get_link	= usbnet_get_link,
 	.get_msglevel	= usbnet_get_msglevel,
 	.set_msglevel	= usbnet_set_msglevel,
 	.get_eeprom_len	= dm9601_get_eeprom_len,
diff --git a/drivers/net/usb/sr9800.c b/drivers/net/usb/sr9800.c
index 57947a5590cc..ee8c6c9d3962 100644
--- a/drivers/net/usb/sr9800.c
+++ b/drivers/net/usb/sr9800.c
@@ -478,13 +478,6 @@ static void sr_get_drvinfo(struct net_device *net,
 	strscpy(info->version, DRIVER_VERSION, sizeof(info->version));
 }
 
-static u32 sr_get_link(struct net_device *net)
-{
-	struct usbnet *dev = netdev_priv(net);
-
-	return mii_link_ok(&dev->mii);
-}
-
 static int sr_ioctl(struct net_device *net, struct ifreq *rq, int cmd)
 {
 	struct usbnet *dev = netdev_priv(net);
@@ -519,7 +512,7 @@ static int sr_set_mac_address(struct net_device *net, void *p)
 
 static const struct ethtool_ops sr9800_ethtool_ops = {
 	.get_drvinfo	= sr_get_drvinfo,
-	.get_link	= sr_get_link,
+	.get_link	= usbnet_get_link,
 	.get_msglevel	= usbnet_get_msglevel,
 	.set_msglevel	= usbnet_set_msglevel,
 	.get_wol	= sr_get_wol,
-- 
2.43.0


