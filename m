Return-Path: <netdev+bounces-116618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB48B94B281
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 23:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D8501F21BD5
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 21:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E11214F108;
	Wed,  7 Aug 2024 21:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPuLzSmB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02CC146596
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 21:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723067918; cv=none; b=JEHyA8Zxhlt2grGXiCgiE7m/viLQT4ZwgvvaShA4ygEA8vXbqBAAkWJ2akTVcCprQtrpR6iy+I4bl9EJNFmpcWxUSv4cXd+qb3xwIR7NQoO4SH0u3QHPPhhxmd9W1+B/BVGQ0vo+0T78fOJGqejsUP6dsTs5qms9ifscUFfKDBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723067918; c=relaxed/simple;
	bh=w4UEgS7jPtJ5eiwQE5K8al0nueN8YxdHHASw09qZykE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UUd+ycSOvVKIhFJrKhAdUo3OWFmNLf3qNBulMt5NXbMvNlVt/TZ4Ca5YxMmiodDnNJlXmsZgnVleFTNJRjRB5XoJMUB3CkE90m14xFSCaNHdsFbcGO2LLbeAfGr5cnKyW50vfpu/T7rNgtWR13MuBs4zNbCHwn6taiKqEnCixP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPuLzSmB; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d2ae44790so286575b3a.2
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 14:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723067916; x=1723672716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PW2c39H3/4psoeqSJL0Jcxi9WDL3+vttT00VLjCJf4w=;
        b=aPuLzSmBrlce/lX0IJDN8kVM0F0OyixxoMRxYfZUpy1oHP75fPYbEPSyq2Xibubhwf
         NU1NUUTdwv8n5KZAMi6pzSAt4koad0vUryiWtNdd/XgZStvgK/wnVqmyC16PeH7w7xA0
         xqYKjibjfcLrTsMkl90LFm3LP76vfKdduGjsynstyFg9zfW9XC7LDP1I6FnnytdvvAZ1
         PWblc0Ww331KnuVxm7BbmEYAovSFF7oeEUq8IEnuPj3LOkUF3ORIl8+uTy7WJe6RQW6e
         PLMVJQpmcC27SqCSJnQzi7rLiaFnIsL9pvor2KjKUHG1sp0YPCVzfg83M7v3qMdlqA7I
         sAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723067916; x=1723672716;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PW2c39H3/4psoeqSJL0Jcxi9WDL3+vttT00VLjCJf4w=;
        b=uT/P8rlo+VJIpNgwgAuzfPcK6amZx4u1sTh7VSXPkJUS2Ha5DVQeWMpD7tTO2cPfGm
         dPlXhBmcdTUF4jnDle1eq3XbV7SvzwQMWlJk/K8b0Xu3Xaur+lPT7GykWC3SNTUV6MXi
         53mFtegcNmYApRK3ovuGhlXchQFTb12sRbAVXnUNr8ND+KlYG8QIrEZhf33ub/wtCtyd
         ah9INLC2aantFvfiR7OMpzpjVpg3vEscEKOdlS9iceA68F2QnAbUy+fwP7aDjZN8oyWM
         BikQHLhkjPc2MtETes+F7m3eHTypHAArKJV+zMuKq/Ae4jR1SDslhe2j9U/wqh3f192O
         Zc9A==
X-Gm-Message-State: AOJu0YzXYwzN4U8jDzBeHP6bVQcvW2pHKdzwF8lyWc6ISxhlaJdgI9QP
	j9nAP3NDOFNiPIHsPoViWcZB7XWTtTDoz6Se/oTll31Ymu0I+9XPxiq+ig==
X-Google-Smtp-Source: AGHT+IF/9pulvLQZUciXSTzmXeirVWY1QN9FNKd0LeDDFT0BIhypjVOzsTMJn4QAVBivvmPrBveIvw==
X-Received: by 2002:a05:6a00:4b02:b0:705:9a28:aa04 with SMTP id d2e1a72fcca58-710cae2823amr42491b3a.23.1723067915779;
        Wed, 07 Aug 2024 14:58:35 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec0611fsm8858140b3a.44.2024.08.07.14.58.35
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 14:58:35 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v2] net: ag71xx: use phylink_mii_ioctl
Date: Wed,  7 Aug 2024 14:58:27 -0700
Message-ID: <20240807215834.33980-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

f1294617d2f38bd2b9f6cce516b0326858b61182 removed the custom function for
ndo_eth_ioctl and used the standard phy_do_ioctl which calls
phy_mii_ioctl. However since then, this driver was ported to phylink
where it makes more sense to call phylink_mii_ioctl.

Bring back custom function that calls phylink_mii_ioctl.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 6fc4996c8131..e252eca985b1 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -447,6 +447,13 @@ static void ag71xx_int_disable(struct ag71xx *ag, u32 ints)
 	ag71xx_cb(ag, AG71XX_REG_INT_ENABLE, ints);
 }
 
+static int ag71xx_do_ioctl(struct net_device *ndev, struct ifreq *ifr, int cmd)
+{
+	struct ag71xx *ag = netdev_priv(ndev);
+
+	return phylink_mii_ioctl(ag->phylink, ifr, cmd);
+}
+
 static void ag71xx_get_drvinfo(struct net_device *ndev,
 			       struct ethtool_drvinfo *info)
 {
@@ -1798,7 +1805,7 @@ static const struct net_device_ops ag71xx_netdev_ops = {
 	.ndo_open		= ag71xx_open,
 	.ndo_stop		= ag71xx_stop,
 	.ndo_start_xmit		= ag71xx_hard_start_xmit,
-	.ndo_eth_ioctl		= phy_do_ioctl,
+	.ndo_eth_ioctl		= ag71xx_do_ioctl,
 	.ndo_tx_timeout		= ag71xx_tx_timeout,
 	.ndo_change_mtu		= ag71xx_change_mtu,
 	.ndo_set_mac_address	= eth_mac_addr,
-- 
2.45.2


