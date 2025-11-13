Return-Path: <netdev+bounces-238376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD615C57F43
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 15:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F48A3A85E1
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 14:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48972C3254;
	Thu, 13 Nov 2025 14:23:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F372877D5
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763043818; cv=none; b=OVdvde5lNkJTLmk60y1BPN9j4/Dgs4gbFcNVd3OWK5gVpqz2+6pa9U1aukaqBGV4qMgCBP+f1hzI91LrdTJJBrb5tB0Y5kLEHJW/VF4+EsY7CZ0szrYG8knmVESsDc56zX/L3GUaNFcflDhOprR97SxablmgcPr45coa9090vZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763043818; c=relaxed/simple;
	bh=z39FuBLfVxg3dxedOWkc+Ia06tLSL22bXsDqvmAO158=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YjQ/gtrSSm3/Ufb5p3W4uThvWXUQZPfUERY2o3AZzmCyj5xbw4m07ljcuMIuqMLULh8Bv/Ecxu4nA90B+hWa0fT5wssU/NkhrNNWcZoX3e9AegkIQeoWCxNHnbxiDAZHqOXhFZEQN0aZVk6JYMscTa1ChEmygVDjuAUM6bTBLAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7c6d3676455so291810a34.2
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 06:23:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763043815; x=1763648615;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5iHf7lLF0gP9n63yXvZFud60lOk/rnCTC36lz7B8T0=;
        b=jjUSE8V1vvbp08d1wvtovWLjYuKsBLFAntz5FsSFLptSMQNqwd3d2Lhbmk2YJgvcgi
         WMaRiEeJWsU0n3aBp98LpR+XJY1PgCS+4KT84X61gwVNv/dbH4g807njsOgOz8GOi15L
         mkSrIwzrFowoSQaWXnTezRRLIM/dw6UvgbVCeZE3EGsMi1xhjwv3dbwoRSb2Gz0cwcuU
         mzVhcHOv6Eb92o8/BYTYcIL41VD/xlIEIsxDgpswNKntsG4jYliJZM9A4CEpKUASubVK
         I5UovuuxTX94DENm8+ncLZaZS+PHUxvxAY5snpgvcWjx/81LlWhRJiS0FfpYivFK1cPj
         fQgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVblxLgN3WiWq6PV1lfWKO9X8Ou2ubFZgNucKPUvXJueyOjEpyhlICnbfVYcRHelrQRUxkDGaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdKPG0pB9DoPxtMDoE88aLB+uLOHTTA0AIwbCdKSBVD/IL9vH+
	9DsH0Hjk+HZugfCH0ItOlQY8RbheZlFQnANBCvbmuZl05XYDYnEr+1TP
X-Gm-Gg: ASbGncvXjxMT+qKXNABdqzWiie9gYCm/VhERtmGMhyBgVKTq6tyfpO2WN81SMjNbP/y
	gi6E+3zJoE06RDuD649Wx9nZw4TU1ArbcHDhTPwOPRQW2F2cxAUdWBJ/TFraE6v6B5Q5RPc1Lvu
	izf5GZ2sYxTRTQPSy6PFwU87BnnvJsfbeFbgr3ZOHDvpRbo4UD0MewyRn7uD6tnyrwtGzXpCZhF
	YtYNqCM1lrDkS2s+MpUbFBCSKlyPZCviJ9eJ/zhd1y3Ro84Jj3stluIwcLXGpZ+McZSCzX3fzSI
	LgECF2fkLxduaoOL73kob+0MI8ysqICz2ZRNKnhZV7xp9XqUYxtkEZpEr/pd8tj0xMQEiMu+L6W
	M2tizBDFJfwJJUKqWoTsRcDM3FYfSvj1KKa0HLwXsO0Tgfwecr3XURZhee/TV9cbPB0dldKn0pb
	eeNsA=
X-Google-Smtp-Source: AGHT+IEgT8+wwHcUmw+KwdvrC6zpX82dQU5Au6rcvd3OQYcE1aD4NgPaTo8lH5fXD4y/lfrV7Jwu+g==
X-Received: by 2002:a05:6830:410c:b0:7c5:3798:fa52 with SMTP id 46e09a7af769-7c72e361474mr4284504a34.17.1763043815343;
        Thu, 13 Nov 2025 06:23:35 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:53::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c73a392f65sm1233807a34.17.2025.11.13.06.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 06:23:34 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 13 Nov 2025 06:23:29 -0800
Subject: [PATCH net-next v2] net: ixgbe: convert to use .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-ixgbe_gxrings-v2-1-0ecf57808a78@debian.org>
X-B4-Tracking: v=1; b=H4sIAODpFWkC/3XNQQqDMBBG4auEf22Kk9KIrnqPIkXNGGcTSxIkR
 bx7IfuuH3zvROIonDCoE5EPSbIHDMo0Css2Bc9aHAYF05oHERktxc/89iVK8ElbWuzakevIzGg
 UPpFXKdV7IXDWgUvG2ChskvIev3V0UO1/zIM06d62TPfe9t06PR3PMoXbHj3G67p+2w1edbUAA
 AA=
X-Change-ID: 20251112-ixgbe_gxrings-61c6f71d712b
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Paul Menzel <pmenzel@molgen.mpg.de>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2893; i=leitao@debian.org;
 h=from:subject:message-id; bh=z39FuBLfVxg3dxedOWkc+Ia06tLSL22bXsDqvmAO158=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpFenm/V5RXfe69npzg+IrvANAHPqq3r8iMqJgy
 EdiqapJhV+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaRXp5gAKCRA1o5Of/Hh3
 bdqwEACcfIVaC73zFQumgX1I6zM7QPZrgZ0fPnN7CpNKfOP1+P/kBANZvn6BWg9/TjIl8fHGwX0
 IAfdbD2vTfcBg6axmc1U/+ogjVFpN6OaZFihMtypmlafWGhj35oYstjrzEJsuXogQFn+lGa45gP
 l01qTdZ4hkKbIikbQQ/wbjOSPLC0vYwVvdfCkI5DsI6UovrpMIpZvxCbtTrV02R2Z9TGwZB3BPx
 KppudrAGq8NpeTmBTsZaV4nA2zmAzgACfSBoG9t/J/bXYI/nur3aoQ92FzMx2nBWQKSNfD4SoEL
 TRxX0yeVrlnD+H8yOBdTamBfMPl5LdryUacDnzIS7HDAG6G3LxgEvcQAqoEW9h6hCGH0EerIT0D
 gijW6YB0h4nCRHqqjrd4c/ZnaiMhm2vWv+fzQH3L41X+kPhY3KyJApW3Lhe2kf6xuL0b+s14DSJ
 qH51uTzUBgOq4r+7//w6OwD5dpb/3rCr1KbnS7dXmvHyXK0qLTZFpp/Ckvl8mUpfRDawf7xFGXK
 cxC2wBWqQwJCEO9MJgy1kVGd6Pi9+fN2AIbVBRr2IQDxGcIcKtz+49kyRQdWiprW8OI5CJUII5L
 BpMDxrVObPqcdlUfjhPWxauBhvciXpXfGllnV8W2ho5ug+c2Aqt4lFv+Z1E7fl19Uhe3rI4/Vmx
 zk41pITloaoJWvQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Convert the ixgbe driver to use the new .get_rx_ring_count ethtool
operation for handling ETHTOOL_GRXRINGS command. This simplifies the
code by extracting the ring count logic into a dedicated callback.

The new callback provides the same functionality in a more direct way,
following the ongoing ethtool API modernization.

This was compile-tested only.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Explictly describe that the patch was compile-tested only.
- Link to v1: https://patch.msgid.link/20251112-ixgbe_gxrings-v1-1-960e139697fa@debian.org
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 2d660e9edb80..2ad81f687a84 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -2805,6 +2805,14 @@ static int ixgbe_rss_indir_tbl_max(struct ixgbe_adapter *adapter)
 		return 64;
 }
 
+static u32 ixgbe_get_rx_ring_count(struct net_device *dev)
+{
+	struct ixgbe_adapter *adapter = ixgbe_from_netdev(dev);
+
+	return min_t(u32, adapter->num_rx_queues,
+		     ixgbe_rss_indir_tbl_max(adapter));
+}
+
 static int ixgbe_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 			   u32 *rule_locs)
 {
@@ -2812,11 +2820,6 @@ static int ixgbe_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
 	int ret = -EOPNOTSUPP;
 
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = min_t(int, adapter->num_rx_queues,
-				  ixgbe_rss_indir_tbl_max(adapter));
-		ret = 0;
-		break;
 	case ETHTOOL_GRXCLSRLCNT:
 		cmd->rule_cnt = adapter->fdir_filter_count;
 		ret = 0;
@@ -3743,6 +3746,7 @@ static const struct ethtool_ops ixgbe_ethtool_ops = {
 	.get_ethtool_stats      = ixgbe_get_ethtool_stats,
 	.get_coalesce           = ixgbe_get_coalesce,
 	.set_coalesce           = ixgbe_set_coalesce,
+	.get_rx_ring_count	= ixgbe_get_rx_ring_count,
 	.get_rxnfc		= ixgbe_get_rxnfc,
 	.set_rxnfc		= ixgbe_set_rxnfc,
 	.get_rxfh_indir_size	= ixgbe_rss_indir_size,
@@ -3791,6 +3795,7 @@ static const struct ethtool_ops ixgbe_ethtool_ops_e610 = {
 	.get_ethtool_stats      = ixgbe_get_ethtool_stats,
 	.get_coalesce           = ixgbe_get_coalesce,
 	.set_coalesce           = ixgbe_set_coalesce,
+	.get_rx_ring_count	= ixgbe_get_rx_ring_count,
 	.get_rxnfc		= ixgbe_get_rxnfc,
 	.set_rxnfc		= ixgbe_set_rxnfc,
 	.get_rxfh_indir_size	= ixgbe_rss_indir_size,

---
base-commit: bde974ef62569a7da12aa71d182a760cd6223c36
change-id: 20251112-ixgbe_gxrings-61c6f71d712b

Best regards,
--  
Breno Leitao <leitao@debian.org>


