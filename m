Return-Path: <netdev+bounces-179917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9552A7EE5D
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 576653AE54C
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37472571C8;
	Mon,  7 Apr 2025 19:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="GkzAe42M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9020E2566F2
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 19:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055263; cv=none; b=mw+Ur5cS0LJhYaPvClXrn8NfOQaIvPeSoDAvcZRz5ofJA+FZDL17gUIWR9d45p353fkkL45f4dcfpSqIuR2w2ENdw1Lh1iSDClCad6fbJwLskpp/3iiH41NgW0jZvJt6XZBVReWLeZiDs3Jgf4Z1ZkES3BmsZwGujMusnTEcELs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055263; c=relaxed/simple;
	bh=p7EPARGgj7SOAKKN0dz6NdkgyLuHiOXuH0ISCFXsGr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rKBmgH4M2cW5PMnM2v3WVZyfLyH5iuvmnk1RZcqM+A6OnBWPitDdY88hpNqAHLJI9MjOZgaIsAbzaAakIhh/BC0Y2TKMNUu9+bozMjwtX6YfSZoOENtNNeHim0FR31JlOq09OaqBz7uBkfUx7fglY0I17tYiV6ekb1ZGpnUoYag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=GkzAe42M; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfe574976so32949235e9.1
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 12:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744055259; x=1744660059; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bTG+JAVhy7g/2FYXf9MXw9ym7I0+fhRPbhOjScULiXA=;
        b=GkzAe42MZ6LkN010siMdmp6Kk3vnTevThskm4FyFjHCs09IdM8nPx2p37sNbB5sjGo
         GtV0E/XkhOx22OBR9EQw9DbyLFrYoU4W0EdkcbySG+wqkkgqdHqwlB3Q9ojl/kdFnJTT
         J6J3ket6CFKW+A8o3ccGVkBfO0FGvuxcPJC2WNTJq1YlDtE+AEFEa4rshInrSHVXRe21
         +kXrr183ucyuYPTL95I1+/DNtnw9sBkV4bLKJ8GRyTLO5rVmZbDy45ONA2/XFH/Z3mxm
         djYkP10j9avXP0EofvaDAvmHuQtPcWpJzWuTiFeQtzsG4q+yvp2MB545KU/zmPq3w9qU
         8OMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744055259; x=1744660059;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bTG+JAVhy7g/2FYXf9MXw9ym7I0+fhRPbhOjScULiXA=;
        b=p4U8dS023cjoBXOxQ41qwAcd4boDQ/vZjLfYQFeeSUv/zTWfQqBhK123uOyXYLiZIV
         0df0y5fzAHYaZzhRw0f7b1rU+G83nlfCs+ox2oWQOq/1XVPUc/UqEHB2d9xJeU5h5GCL
         q4i/bRv35ybI0GiCFWDOGO+rwr41yDsoF4y5OyKpqXzABnuYeq78k7/N1XUHrxJ2IIwt
         AjQQ1QYDDZ2osyy1DhYQgE4k2AVZJfI/e4I5DNcx1aa20pGPP+RHIyaF/ZBSedGfTl1Z
         32KH/zt5OifmXSv8vK0oInQxFwLhX+kkNSrUlQxU1IK6dxRkl1dWGi3iU7RqUK1p5neH
         Gs0w==
X-Gm-Message-State: AOJu0Yz6+stHJ70ChedLmu1EnGD44v+w4V5yoL16Iv1M/g/xJRN8qcLD
	Z09Fqzz8B709wP1Rp2XSjHw+5yBxgtX5+XdYmzRMjRCYvxbC8w7LO3Up0Y0xIHx4kFlIZDz+WRh
	CYFtOTdQHIi1i7sDhXLPN08BiTWXmUvcDi29429Q/V6sL+2k=
X-Gm-Gg: ASbGncubRN5/X1QXFhAoKklMuwrEPPIv6loScAnWjgSUVDTzvvEn+WJuACYFCxKpO6e
	CcYBD24Yvc0icMa3uV2x/FrvmYdkcfHzwVSRO8sEMm7Z+AvSybMkRaDbhXPN6RaYaWhjZEyReY5
	ghU/o520SUDddoOvwPTlonvIHKECkHOJ3veqN5Mn2KlHCqdKN9fqs0i1fJQHlh6pdzUtIDFdSz+
	a3eGFHWZga2/s5NjpXi2UIYHlaQn5bmKwXVVZvSM3zqGA/biXVCOJlKy2tKseMzTNz+FLOhLFNV
	YoZJpqTOHuIXrJZsRSV2Z70MO6HDK2m4+ZOtMgGAbw==
X-Google-Smtp-Source: AGHT+IHUnyV/qcdqTJGnAyZy+o0NAwfkJ+ys74RDBYpD0u8Kn3sHuMI34ZodEx+o7T4wQu4mhztvTg==
X-Received: by 2002:a05:600c:1d9a:b0:43c:fe90:1282 with SMTP id 5b1f17b1804b1-43ecf81c644mr120676795e9.7.1744055258867;
        Mon, 07 Apr 2025 12:47:38 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:fb98:cd95:3ed6:f7c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec342a3dfsm141433545e9.4.2025.04.07.12.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 12:47:38 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 07 Apr 2025 21:46:30 +0200
Subject: [PATCH net-next v25 22/23] ovpn: add basic ethtool support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-b4-ovpn-v25-22-a04eae86e016@openvpn.net>
References: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
In-Reply-To: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1680; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=p7EPARGgj7SOAKKN0dz6NdkgyLuHiOXuH0ISCFXsGr8=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBn9Cu2WZQMtfAcsWAzhebYq0vvAVfJfrL6ViK8u
 QB1uGOplo+JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ/QrtgAKCRALcOU6oDjV
 h1oNB/0eY1nmLk0nKIzQhmCvdsCiXTSJJxKA8lJ9d7PHWt+OxZDjTOY3v9cPn0duB0bssgYbLgj
 hb3wSr0XpNak4C83rwJ6xc711gCzn4q/4Z7Tlb2qoYywVqDfJQ7lWZVIdBVFzEvdbhPKg28f1uv
 isfPWZVIGN6zgPzDKpiRfnMdn8Yc3dBcARKJV+mohlv5Yp0/LWoNZBeR0El+nBWRO9/0ZShkBXb
 MZQ2NWm9teg+mmYrovjPmjS7fQ/TCJ3lk3fZFWRVVXD7TaMGBHSgHQP2enwqXdf6bv0edPx2m8L
 6RvFNdTBfq12B0yeLUDuWj4SUiMS0vjdq/AtJnRDwCUU7r/x
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
index 0e016d39c95e52515437313064e892aa3038adad..46abbbed384a4a98e87fadf5a3d749adb78d1de2 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -7,6 +7,7 @@
  *		James Yonan <james@openvpn.net>
  */
 
+#include <linux/ethtool.h>
 #include <linux/genetlink.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
@@ -135,6 +136,19 @@ bool ovpn_dev_is_valid(const struct net_device *dev)
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
 	netdev_features_t feat = NETIF_F_SG | NETIF_F_GSO |
@@ -144,6 +158,7 @@ static void ovpn_setup(struct net_device *dev)
 
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
+	dev->ethtool_ops = &ovpn_ethtool_ops;
 	dev->netdev_ops = &ovpn_netdev_ops;
 
 	dev->priv_destructor = ovpn_priv_free;

-- 
2.49.0


