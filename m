Return-Path: <netdev+bounces-150096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1769E8E22
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 09:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D793281D69
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 08:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A156F21B913;
	Mon,  9 Dec 2024 08:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="MebMzUEP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F4921A948
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 08:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734408; cv=none; b=gMoX+l3fJv2+WB1b96QKzvSejDeFV8EB+fDX/+ZLI3hcWKsrZnFWCcEGM1gqZuJzPyQwob1Vp2tbrDjPQtXPa2/BMDBOiz8BipjcVDaRstNcORUyGYUFQyfaepJvk312m7iEZufsfCqJ8sZZ8pWpfRI7Tb0MsjFrL4Q/Ektx4/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734408; c=relaxed/simple;
	bh=W5T+iVYKaPmO/gOfKB0RnKXCUMfDvh3g/zI0cvgMIlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=akcpzGX+djFCvUuEXOtymqrmgt9NlbOMI1XgTzf2iv56S1+0ZUazBHOCdzrPXe1t/2NTjhyENjpF2r0LynLlvIRQvA0qQwRPwbJtbh4SBhxrBQXPqKH8N6Bkjquu4B0VEp2LKJI2U+HobRc3LiKU4ecWLhaNmJY6hEKDSvM6e7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=MebMzUEP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434f7f6179aso6946695e9.0
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 00:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733734404; x=1734339204; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jb7KHSQUPGhy5o0HEst1Kbqk3ULde1AaGrsUDUj2wbI=;
        b=MebMzUEP/A5z1l4aKsmrs85+rnhNLfub0ejeWL5gIliX5MRsB0Yv0HHU/7qpEWXTwC
         hVEbmwHu0xf9ZfFtSYdl489ry2qB9F0C9UV7R5Nkmwk95X4Li+NabCRM+dTt/iv3KPu7
         eflU+GrU2Zd1PlsBLWqbbxo7vLcI2RVZ0tBj4Zb6BVvRXgUcE7FIPOY8A6OoL49mfysK
         h0GDzpv3xxy6ygso9fqwWGhcO2yIEKPizvI36XwR271XgURqcpuag38jvARR1iEwVVsJ
         mssCussGI9JJrwW1gZ7qJ+99HGli1wjZaZF6rv/5Eu/oPA2ZEBjV5Pbsz+lJz0X47wge
         Yuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733734404; x=1734339204;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jb7KHSQUPGhy5o0HEst1Kbqk3ULde1AaGrsUDUj2wbI=;
        b=gGRNBNy17YR+84E73haWIeGvhYxqb19cwoC2lPcOLtw+rFcoj9WxvlCu4pnPqkjVIe
         s/htGxeiPJXOkWFKN9ISwAS9AA/nbAl/tmkm+i9HPcIWBkC1TXj3hJCCMpcKop1KMHN0
         J01k4XH2DYkM6H9JFOwtByoDv8cIYJx76EqRd/oRguKgFbegElibAU+0iRBMzuivW3rE
         +n7OZc1/1EaNjox++1TQ4XFsrhWsN1Ogytdh+tKSPgvQhKism+uKcNq0AU0jbUuAaoN+
         I7KKDgbfRBhRbYh91yL2mk56MPOOKUJSMrSkFqJTDnp+cOlDAWI77oMbGrLHNu7Nmed0
         ZUWQ==
X-Gm-Message-State: AOJu0YztBRnSfR/itzXYP6b5q6a+1Lcqgd8uuCqTGstJmtHDX22ETF0g
	5apu7GBRn2aunP+X/oVAKTSdXazIHKsvSvXxkqIIuBYnh8U8yUYdoLZzvRnNg7xn9iWKOtecifc
	M
X-Gm-Gg: ASbGnctBRgG+l1UGDEiu014BegfOHKTKlcO8tXIZQT48bVAvOlMg1SfXWbTNA8VXxrs
	FktOaJFEH1/pN2k60GxDTtEDGLraJbg6TWtZq9eywjnuRrJEEcOtGp85+egJP3C+dGygNC26vFl
	tVhL8ktYWZjM+TxZ75RvRsXgJvKde2ThzhROi839pMoc29PIwLiRsm2yAi3iXNO81mhIZ6gfHCT
	dXskzDrIoUHUCwTqUmJVvR+CVnn4XuCUGfjVL4dcai4Njr6LetoDIFnfLPa
X-Google-Smtp-Source: AGHT+IH9p2YXjKh9qdWSHXE+iUtKj8MI/pG4r7tSRsmfsK1vGrxYN+BzekS1qChz2l9T3F27QrGHtA==
X-Received: by 2002:a5d:588f:0:b0:385:f9db:3c4c with SMTP id ffacd0b85a97d-3862b33e5c1mr8913576f8f.9.1733734403812;
        Mon, 09 Dec 2024 00:53:23 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:c60f:6f50:7258:1f7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38621fbbea8sm12439844f8f.97.2024.12.09.00.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 00:53:23 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 09 Dec 2024 09:53:30 +0100
Subject: [PATCH net-next v14 21/22] ovpn: add basic ethtool support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-b4-ovpn-v14-21-ea243cf16417@openvpn.net>
References: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
In-Reply-To: <20241209-b4-ovpn-v14-0-ea243cf16417@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1699; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=W5T+iVYKaPmO/gOfKB0RnKXCUMfDvh3g/zI0cvgMIlg=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnVrAUmSZWsTZrSHxW0eF9nx/U37XlgjUXw/O11
 cLF156aAUaJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1awFAAKCRALcOU6oDjV
 h11/B/9DpBcicI3nmOt/Q4ST0qkqmgNt37hc/xvXzhZzFoXkc49s6vE5vGO+NaPlbg4zf9jo8OG
 Au983v1naB7Md4Fe8IUTRmtQAeb2ZW7TuzWG/8tSuPo3IRuO6hCE+OOt+y+WbCRMgoiQb4y2BkF
 eOWe/KJoijDEtKQM7oO/3v7wHC3JHYXTtoajy5NVvTTKB7XK3o6QmGZcFBPp5Re/17WVIp8e4A2
 0ReidfRFgqpuGx5+n6uZrNsg9vZnlrq4NqNB3Z01mOVbKojp8Dvj+qMqTJ58mydne0tEWplT7bS
 w9HhiaWHS48At6cRCyaen0x1gSMBQm0M5cOCX2GgHg2NaGW3
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Implement support for basic ethtool functionality.

Note that ovpn is a virtual device driver, therefore
various ethtool APIs are just not meaningful and thus
not implemented.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ovpn/main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 6b3a59e75e5aa918b28957c073990be9fb1d2124..6a828728d4f98f84e39ea429a8b76069c6d83e69 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -7,6 +7,7 @@
  *		James Yonan <james@openvpn.net>
  */
 
+#include <linux/ethtool.h>
 #include <linux/genetlink.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
@@ -94,6 +95,19 @@ bool ovpn_dev_is_valid(const struct net_device *dev)
 	return dev->netdev_ops == &ovpn_netdev_ops;
 }
 
+static void ovpn_get_drvinfo(struct net_device *dev,
+			     struct ethtool_drvinfo *info)
+{
+	strscpy(info->driver, "ovpn", sizeof(info->driver));
+	strscpy(info->bus_info, "ovpn", sizeof(info->bus_info));
+}
+
+static const struct ethtool_ops ovpn_ethtool_ops = {
+	.get_drvinfo		= ovpn_get_drvinfo,
+	.get_link		= ethtool_op_get_link,
+	.get_ts_info		= ethtool_op_get_ts_info,
+};
+
 static void ovpn_setup(struct net_device *dev)
 {
 	netdev_features_t feat = NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_RXCSUM |
@@ -104,6 +118,7 @@ static void ovpn_setup(struct net_device *dev)
 
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
+	dev->ethtool_ops = &ovpn_ethtool_ops;
 	dev->netdev_ops = &ovpn_netdev_ops;
 
 	dev->priv_destructor = ovpn_priv_free;

-- 
2.45.2


