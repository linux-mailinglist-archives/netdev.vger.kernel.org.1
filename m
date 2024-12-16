Return-Path: <netdev+bounces-152169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A50C9F2F8A
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 12:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 751E6169D15
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 11:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6625E207675;
	Mon, 16 Dec 2024 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="a/psRVI6"
X-Original-To: netdev@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C8E204F90;
	Mon, 16 Dec 2024 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734348616; cv=none; b=BVPKHoAsgqsPvcSzxwoGK4XtBu/Z6Zy77ARIsdu8iWO7exO4uIXx0NFWRCoZ76uXvREMnMcTS3MFBlZye6crd6FnOWIJY4PP7DVh58i9SiYXJNPOU1phvdgJYa3GetFeXiVVCO1j4VHx2ibT2YeB5VN/3Gqc1y3JL61YbXhYllQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734348616; c=relaxed/simple;
	bh=sKafKTrf9LAdZ9BgdUJ967oC4MBmXTpZpAe5oxO1A/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XWoLuI0AqOP+IJi/tGkYG9yOxvcbmDcZLRUaHFqE8v23CeKKe1juJkT993uRgelmKYAPXCjLmAEMihpLeV/WVOmIBX4+P7w3b0POXxjnzrEWexTDMjNavzlckEasJiYzPhlkjx6zSfGpmlc+K8Sy3Dyg7CvuSyp6vauKQCbYZ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=a/psRVI6; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734348609;
	bh=sKafKTrf9LAdZ9BgdUJ967oC4MBmXTpZpAe5oxO1A/U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a/psRVI6dOk0OUmnIK9Bsc5J9v32iRRIq90T3yw3Ny59IeNxuy7crSZH8GxtBRjl4
	 N/6kHom7mpZsVVf2cDizjbLqQd/nvKcSDr48FSAt2jQRpJJEEMNjDRzzoTYdRKiZMS
	 lPGLesG/MQG0wBoDZFUt+l7adT7GW8g3WnSNDd4Q=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Dec 2024 12:30:10 +0100
Subject: [PATCH net-next 3/5] wlcore: sysfs: constify 'struct
 bin_attribute'
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-sysfs-const-bin_attr-net-v1-3-ec460b91f274@weissschuh.net>
References: <20241216-sysfs-const-bin_attr-net-v1-0-ec460b91f274@weissschuh.net>
In-Reply-To: <20241216-sysfs-const-bin_attr-net-v1-0-ec460b91f274@weissschuh.net>
To: Roopa Prabhu <roopa@nvidia.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Kalle Valo <kvalo@kernel.org>, 
 Manish Chopra <manishc@marvell.com>, Rahul Verma <rahulv@marvell.com>, 
 GR-Linux-NIC-Dev@marvell.com, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Shahed Shaikh <shshaikh@marvell.com>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734348609; l=1358;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=sKafKTrf9LAdZ9BgdUJ967oC4MBmXTpZpAe5oxO1A/U=;
 b=gGkG+VPJm4mN0LELAZJKMBJ8ArdFEHk8sS8xi184dchQWntIgwDx/kZOUjOe5Mnj6yvFaFFxp
 AByBciprnLdB7xeNM1W2Q0cwD90cI26jJoekl7UUmV7lA169GNyzfsw
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/net/wireless/ti/wlcore/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/sysfs.c b/drivers/net/wireless/ti/wlcore/sysfs.c
index c07acfcbbd9c8179bd312840efda43e7e9c5e6a0..7c57d4c8744ad5d19f11c5765cc7bf27aadbf740 100644
--- a/drivers/net/wireless/ti/wlcore/sysfs.c
+++ b/drivers/net/wireless/ti/wlcore/sysfs.c
@@ -88,7 +88,7 @@ static ssize_t hw_pg_ver_show(struct device *dev,
 static DEVICE_ATTR_RO(hw_pg_ver);
 
 static ssize_t wl1271_sysfs_read_fwlog(struct file *filp, struct kobject *kobj,
-				       struct bin_attribute *bin_attr,
+				       const struct bin_attribute *bin_attr,
 				       char *buffer, loff_t pos, size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -121,7 +121,7 @@ static ssize_t wl1271_sysfs_read_fwlog(struct file *filp, struct kobject *kobj,
 
 static const struct bin_attribute fwlog_attr = {
 	.attr = { .name = "fwlog", .mode = 0400 },
-	.read = wl1271_sysfs_read_fwlog,
+	.read_new = wl1271_sysfs_read_fwlog,
 };
 
 int wlcore_sysfs_init(struct wl1271 *wl)

-- 
2.47.1


