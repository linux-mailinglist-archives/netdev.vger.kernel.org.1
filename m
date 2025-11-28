Return-Path: <netdev+bounces-242557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E1EC92154
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 14:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 585A24E38D1
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 13:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3392532C948;
	Fri, 28 Nov 2025 13:11:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EE9302140
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764335517; cv=none; b=efVVCB3DZGbexyCGCKPJMiTgDFROsRzIg0bBJXioSQfkFehcYMJ7CqKlgMlQagTpL5VIeUd+yrLsLYQUHXpmxNTa/MKbj4bvyzAsYNayI7T64MAFTJuJVauQzCPjuI5hpC6MEOxa02DI2hKPBdnGXm3TnpSg7q4z+PGs8/lj8Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764335517; c=relaxed/simple;
	bh=CZtYG+v51umTKq+EUEZdPSfD+cLS70zLo9KxgodZhEk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nY1278IFMHsqgSC1MFvk/O4KCE6WQlEzg5lSC9m/HuxkZwh6xjSnDpdoKvNaq7j8NiEUobyyfJzoSB+jxtTwf9eFbkdP+CckfsEGkpp6JyFLHvTsbcFXl0i09tTZG3JiR03a9+YiFYcdIzzQA3Qeik8AggVTdzxTsSD2mx7oVKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7c6da5e3353so1176123a34.3
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 05:11:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764335514; x=1764940314;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1Ws+64tDZ1NawiccgOINKTEQFjVR5AX3Ovp0pOwcfDA=;
        b=JrFBFgePdXtnRzE0Q/yosBHSRZ/lQGWLh8tIzRB9vYnFLoXIgtLuMOwiKlQzre/6oB
         fIGoXS6Fypy0PcgO7lbCZeMilLzF1O3sU0TkGwGLUyYbaYNgmylRYW7MbfSB5nfYgjMh
         HNw3BLzPL8mfeEbaH93a+IyAt663KvCieb977060PuY+nVYNIDw4Ffr5bmE/RPr2K2Ad
         xQJDtAzhVuVlT06U6H0xRoYiDteW9XllrUG+2FL76lf4R2DGYNp74bLBNyiWmouywbMT
         4bjdYMGiXw1H1FWlPhOnDPnRCdlUZ19QHhnwjoMXPdOeH+ydTRB7NSOle9niBv1KYyPa
         53/w==
X-Gm-Message-State: AOJu0YyIlJHd2joU7PzSMmdNM+WIbaDcXcIyPWNm7AVrLUnQ8ZoJ+1S6
	bxHLw6Ut+qwmVHh5rlVc1TBhbm5ugE0S+TGbiQl0vN1gX/lrQyzuwQKU
X-Gm-Gg: ASbGncsk18ge/S09l6QB6iOaat+l3g5iBF6lTnepUVffa4X6GjElpdWCyo50mjlOfVs
	umV2qjYh44mfreRLcLgkGRvTN7cws+ALgCCXpq11S4vObNP7SmciHZFoZ/znx67R82QdTVOB5Il
	P8AI7A1RWRZnQHO2/PpbVaLW0nVPMFJl+SyEEaEPmvCPVktQ0lO/6n0A9NaBI687TBJW7OJrpeE
	z41cGhilc2/5xMSmzop7B33P9xwvIxD1mjsGW9lb6Ha0TyruBsKfnQlkn9vHG6fZEpqzaTvklcr
	eI+ZVl4ma+x3Tp1qrQHOZN8jQnyzkzliz+yMcD4dkFukz3Ph/iFzGgc003XdB71u6SQzO0ymKMc
	0vVvxK6cJMsX42m0DtE/VCvCMT2/prIElNdQGeXwMeCmSuOwCMSw5AwLU5cPRJL0a4jUJLBnyJw
	nM4zQj84CxW1iX
X-Google-Smtp-Source: AGHT+IEgl8gjrsk4JsjIK4DYaxFmEftv3fqxBhJyfVyr6YWaXxtVod4kuEHssBMt6l++8++WJT6VhA==
X-Received: by 2002:a05:6830:4386:b0:790:710f:60e3 with SMTP id 46e09a7af769-7c7c43809ffmr7586357a34.23.1764335514394;
        Fri, 28 Nov 2025 05:11:54 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:9::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c90fe15847sm1504747a34.25.2025.11.28.05.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 05:11:53 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 28 Nov 2025 05:11:45 -0800
Subject: [PATCH net-next 1/3] net: gianfar: convert to use
 .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-gxring_freescale-v1-1-22a978abf29e@debian.org>
References: <20251128-gxring_freescale-v1-0-22a978abf29e@debian.org>
In-Reply-To: <20251128-gxring_freescale-v1-0-22a978abf29e@debian.org>
To: Claudiu Manoil <claudiu.manoil@nxp.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Ioana Ciornei <ioana.ciornei@nxp.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Wei Fang <wei.fang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1895; i=leitao@debian.org;
 h=from:subject:message-id; bh=CZtYG+v51umTKq+EUEZdPSfD+cLS70zLo9KxgodZhEk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpKZ+XYiy9nO1IgJzH22i4LrieODa4xNDr9G2Dr
 ODhcJJgzPGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSmflwAKCRA1o5Of/Hh3
 beHqD/9K4lb8U6+g1KmKvt5ihwvxD5pTy5FHJyIErxaMfkKOjZS+KZEzjJmLBaB+dTJ1pHksj0G
 rqxDhTYiqOcRDFiLOZxIYPBp0AcvabxGyiNcAdsh13/R7AKTakG12VQeqgJpCuUuJwnrvs1zb6X
 JiHq0QTslGjmivzO3U3V8qH9h+9thNQe7vf2cXicnJKiDlbDLIZcvs0duUgAFTrLieTIw7N9MOx
 JGUbz444LduaHs33BTcJ5KC5NPV9ng4vbLm2Z7ef/5GSANs/WGQS/undOwVs7iSPuJ2Y31iiYiV
 4b44Bw2lZdEZA+MvV1dNoMiNs5Rd9rNIiFJt1YStIrd8fVSCiiTOYxLg37dO4vu5mo3cCj8Hq9c
 90DOZTdDn+D6CF5X09ZZS3v/CDbL6b52edpYrsq5S0Pi76h3neQL5w7t3p8Uu7tlEsa8Kp16VF5
 L5hv+nZwoL2WVt95oO7EOBW7peiXXEw+2f2xqIgmFRhuZHITyC4DzQfw8NBp7WtGlsVF8NdrO6d
 LMb311hR3FsXbngDgalMnQg2OJ8KWbT/lvbEt6jbpqTVx8DKB2sV8Zi8qh/DxrjICXddG2WtHf8
 O3lyNztAXgfxRE7ZihWgUV4bgEaDK7HxQvpHrLpoA1H8BTB/SruCFc1RuFlvx/WM+rTEMFQxCD0
 L+CKSWXTWeUQ0NQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Convert the gianfar driver to use the new .get_rx_ring_count
ethtool operation instead of implementing .get_rxnfc for handling
ETHTOOL_GRXRINGS command. This simplifies the code by removing the
ETHTOOL_GRXRINGS case from the switch statement and replacing it with
a direct return of the queue count.

The driver still maintains .get_rxnfc for other commands including
ETHTOOL_GRXCLSRLCNT, ETHTOOL_GRXCLSRULE, and ETHTOOL_GRXCLSRLALL.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/freescale/gianfar_ethtool.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar_ethtool.c b/drivers/net/ethernet/freescale/gianfar_ethtool.c
index 5fd1f7327680..6fa752d3b60d 100644
--- a/drivers/net/ethernet/freescale/gianfar_ethtool.c
+++ b/drivers/net/ethernet/freescale/gianfar_ethtool.c
@@ -1431,6 +1431,13 @@ static int gfar_set_nfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
 	return ret;
 }
 
+static u32 gfar_get_rx_ring_count(struct net_device *dev)
+{
+	struct gfar_private *priv = netdev_priv(dev);
+
+	return priv->num_rx_queues;
+}
+
 static int gfar_get_nfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 			u32 *rule_locs)
 {
@@ -1438,9 +1445,6 @@ static int gfar_get_nfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 	int ret = 0;
 
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = priv->num_rx_queues;
-		break;
 	case ETHTOOL_GRXCLSRLCNT:
 		cmd->rule_cnt = priv->rx_list.count;
 		break;
@@ -1519,6 +1523,7 @@ const struct ethtool_ops gfar_ethtool_ops = {
 #endif
 	.set_rxnfc = gfar_set_nfc,
 	.get_rxnfc = gfar_get_nfc,
+	.get_rx_ring_count = gfar_get_rx_ring_count,
 	.set_rxfh_fields = gfar_set_rxfh_fields,
 	.get_ts_info = gfar_get_ts_info,
 	.get_link_ksettings = phy_ethtool_get_link_ksettings,

-- 
2.47.3


