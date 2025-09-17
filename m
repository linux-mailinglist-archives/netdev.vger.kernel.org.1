Return-Path: <netdev+bounces-223930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24980B7D638
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 060D33AF3B3
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 09:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30936352068;
	Wed, 17 Sep 2025 09:58:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AB9350832
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103104; cv=none; b=XKhscaxbyM+Nt7JV5Q5NWFSgHwDLS26EdNIG6vyowI5CuRmDuog8oXPPEmmjXQK3j5Z1DaqsuunHcG9DoeKV5zhrIfN0DPmh5acTAbBLTn3ZSsgJatTlc6NSt+PIEuGlb6gUULuRZdJafr5l8+qdyUduEJQWOIE241gfdVDx9cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103104; c=relaxed/simple;
	bh=4qXNf5FPKeqB6oI1PmmIoli/4B/k2fYlPhoDMAj4Ltg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WR2cJTTSkdxmscbnLyoeO5VYg2JtyDIcsc2w5Urbp3gKz05jdiCuuiM/OecuGOXUMgvv3foBY4fPu+7intDeBG931Sv1TsjJX8l13hUuYrLajyqXiSBrtzbS/rv+2i4yjdRDVebS+VBTUtYj4dwT4idxSofZyAkQ7rPW9W9BoiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b07883a5feeso1113721366b.1
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 02:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758103100; x=1758707900;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AEyyDJEjHIGcptoyVMY30XDmajElEFVLCjxYGTHfuEc=;
        b=VqqwpE/jMv2w0TSMaUxly6dP/gm9Y2Ofv4yzdreQrDl6ktvKGIi1U4fWVgY4amAwk1
         UPcyUjjGk6tHsfqeRSRH2tuAKdIUG1mdmghtItceKS44STKWWqbO8FMU4Fr/cxR6AZZQ
         DiGOIJIIL1yCyWrsvV01ytteNcqbTLWXsWXwTCZdDh+mMYrqLQ7m20NF5sIF6aWxOvtb
         CTT53zsbLapppEL1U3GN/tMRtAuQd0ZnbQMpS0gtqmHaEK4YKmB5BdDTGMdDg6Gy0wZM
         OKdtymFRayA6vroYuE+rBu4kAnANHsSJMrFj03tHG6qtoJivU83LW88ZIJOxMEsrcKdt
         /ebg==
X-Gm-Message-State: AOJu0YwtzuM2T0VpW0ochq4HuvMoFWHOx99fAxgwiu0am82Mk2zOlz4T
	CS+VdS2PMgPP2CTksYQnGm+l2lr0FeyB7WvnOCt6ViaPHjabs+3+f8yKXwZSOA==
X-Gm-Gg: ASbGncsUlm6LAS0D+55Jn50J3prqGPbmLIToMsnLgrpG5bkSeHGsQiGENgtfIpXGAzY
	J5MR+kHnRlcAAfT9rvdVqQHUgtApcNlKlb3W5EZ8VbQ0U4TqSICqFd+FmkpHibQfZ6yvq8kKbUW
	2nXeZpr943gFXrv6SLeBHB/6Uhy3CCsLS7JN9IrByDxxvfn7AR/muYqnbfjnbcFGLW/0C4lfGHr
	UBd+6XiGgriTzo+IRdWV19YXMZ9YoEXRSDd2jCyPY0Gi1X5TR6VFLmzFBmOpNJz0zbz2bLciKUT
	IqAxk6blOekkrC+oKI64lSPsr1v86HoJ2Xe/aj1dO5wZfq+PFeqM57wb0+5Zlp/jiBPhvp91pGO
	Horf3HQnC1kBRsg==
X-Google-Smtp-Source: AGHT+IFmKSMVHhuFIvQinupVyiUNckMKMb5lWYss0WThxAB0V4vANhmyHX6vXQLprkM//2EeY/ySKg==
X-Received: by 2002:a17:907:3c88:b0:b0c:a265:c02c with SMTP id a640c23a62f3a-b1bb5e572e9mr222242866b.12.1758103099498;
        Wed, 17 Sep 2025 02:58:19 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:42::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b31291b0sm1343812366b.34.2025.09.17.02.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:58:19 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 17 Sep 2025 02:58:09 -0700
Subject: [PATCH net-next v4 2/8] net: ethtool: add support for
 ETHTOOL_GRXRINGS ioctl
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-gxrings-v4-2-dae520e2e1cb@debian.org>
References: <20250917-gxrings-v4-0-dae520e2e1cb@debian.org>
In-Reply-To: <20250917-gxrings-v4-0-dae520e2e1cb@debian.org>
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 kuba@kernel.org, Simon Horman <horms@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 Lei Yang <leiyang@redhat.com>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2335; i=leitao@debian.org;
 h=from:subject:message-id; bh=4qXNf5FPKeqB6oI1PmmIoli/4B/k2fYlPhoDMAj4Ltg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoyoY2AU9fNvTISS+beBqpJEDcxAHhVAhTAHCq9
 srn6uWzgxqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMqGNgAKCRA1o5Of/Hh3
 bav/EACG9P0Yxm8JP5TFsL1itesM8mMX5t+D87Z7fjw6n/bPC8stKFKiHf4HO5v6ao/MvPQu0c6
 a49OqGLI01YJ+gEMnKPZ0s0AaOGZsscXy9tIxTG+1SFZ3IThHyVa8bA7suuTJ00vfXfBxinTG6N
 /vQjRj4a+IA60KFNI89/iBpirfrMMsnSdDNMmPXcs6bQycFimuQEs8RZpCJC1JJxoT4Z4reolko
 ajaTnJ8EXw+lhqb4nx6wk8fDbuepbVVhkajeE0mSoNQz4hFJ69fc+stXB6qnluuG+XrvwisMhMw
 MgNzQVN+4DdcfxRZ+EJOWzGKyhg47SyLTZDKO+NwvJT0Wm9hFXDlAxWg0427Ba2zwPssv9vWFRT
 SyMaxhyNbAmHzZjndir82/49HKpIy9yGo2Nw/XyZLy740CSoZUnBLmxgykZf0P09szeo3s+yp1V
 9CnOZipMsiD4/cHsLlnIgZZOlrl5V2SJ+1uJ1LIolKgGdajfCzotoOWJC9Uqo85dIYaeKifvtbG
 lU07fl8zCdwmRGI8hFt6PGiQotMAlaWXNnAQ2WQdEKAQ/VlDuQe9npNeKy5cgN3GwD7pgN4PjIz
 RTZ2eRKu1NI8kZU9/pDXFoCiz7JRobHeYh4xaE2Fir85ZF8XlLt2dCrZUkgXEHIp92TG2Fnna2r
 ajP6h36DirNPoVQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This patch adds handling for the ETHTOOL_GRXRINGS ioctl command in the
ethtool ioctl dispatcher. It introduces a new helper function
ethtool_get_rxrings() that calls the driver's get_rxnfc() callback with
appropriate parameters to retrieve the number of RX rings supported
by the device.

By explicitly handling ETHTOOL_GRXRINGS, userspace queries through
ethtool can now obtain RX ring information in a structured manner.

In this patch, ethtool_get_rxrings() is a simply copy of
ethtool_get_rxnfc().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ethtool/ioctl.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 15627afa4424f..4214ab33c3c81 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1208,6 +1208,44 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 	return 0;
 }
 
+static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
+						  u32 cmd,
+						  void __user *useraddr)
+{
+	struct ethtool_rxnfc info;
+	size_t info_size = sizeof(info);
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	int ret;
+	void *rule_buf = NULL;
+
+	if (!ops->get_rxnfc)
+		return -EOPNOTSUPP;
+
+	ret = ethtool_rxnfc_copy_struct(cmd, &info, &info_size, useraddr);
+	if (ret)
+		return ret;
+
+	if (info.cmd == ETHTOOL_GRXCLSRLALL) {
+		if (info.rule_cnt > 0) {
+			if (info.rule_cnt <= KMALLOC_MAX_SIZE / sizeof(u32))
+				rule_buf = kcalloc(info.rule_cnt, sizeof(u32),
+						   GFP_USER);
+			if (!rule_buf)
+				return -ENOMEM;
+		}
+	}
+
+	ret = ops->get_rxnfc(dev, &info, rule_buf);
+	if (ret < 0)
+		goto err_out;
+
+	ret = ethtool_rxnfc_copy_to_user(useraddr, &info, info_size, rule_buf);
+err_out:
+	kfree(rule_buf);
+
+	return ret;
+}
+
 static noinline_for_stack int ethtool_get_rxnfc(struct net_device *dev,
 						u32 cmd, void __user *useraddr)
 {
@@ -3377,6 +3415,8 @@ __dev_ethtool(struct net *net, struct ifreq *ifr, void __user *useraddr,
 		rc = ethtool_set_rxfh_fields(dev, ethcmd, useraddr);
 		break;
 	case ETHTOOL_GRXRINGS:
+		rc = ethtool_get_rxrings(dev, ethcmd, useraddr);
+		break;
 	case ETHTOOL_GRXCLSRLCNT:
 	case ETHTOOL_GRXCLSRULE:
 	case ETHTOOL_GRXCLSRLALL:

-- 
2.47.3


