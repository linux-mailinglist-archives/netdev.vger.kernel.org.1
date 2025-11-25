Return-Path: <netdev+bounces-241487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1067DC846FC
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 11:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 30B484E8F2E
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 10:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAC12F25E0;
	Tue, 25 Nov 2025 10:20:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C672EF665
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 10:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764066000; cv=none; b=e7OrazUG96SgJDKtIg9lwkdMSLNeL0Gv2/ufkyqm1Hf4FKpOwrY0bHbwRDgo3QH8dDN3g+P/w3648uLf7KztG5TGOdkPh0ZzlC8BHCSqFBesuu3MU45nLImDKalNMXiDLlIgZxL8CzbIHIoU5i4mEuCNrtrqQJVVnzqN1VYWKpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764066000; c=relaxed/simple;
	bh=3i7C7WKxlPKP4f0VTj5obFFhyx8DsVbLTl7zSEWQvvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Drt18lxzCatx91XikSjja8nyyWaHkrq97MFLrD4yu2sS/AzVwhI6RpX3K4pBnS9+wPCzdnS1pCwNqIXMjWKRuxNuYb6GvILXmI/gCAqbWNGS5mtedNkBiAVkOvNQMohcc8Y1XdFxD9e/MEmHKjANjprM0NDJtUoNN/+veLGHCTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3e8f418e051so3120147fac.3
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 02:19:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764065996; x=1764670796;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ev1qL0vgRlnaty2XtQ6L8S4d7iM08dylTBEfHI0VuIk=;
        b=f08eS34Y2L1FdP4ZxBIAfkg4mfzbjCQI9AYj+mt+ezW6UXIHqATa6xcgj9TudjVxjT
         96bCR6wS9cDdLoHK31mimNiSWUiY1X4faCvRrhO7QWbFNXOeUalIZ/EJXVBiaa7lAxdU
         MZJTdWPRxgYsRDLKG59x1hN+M7z79VqmEW6Lpf9ZFRg6yTr+ylTHIcAOTnFxvYuf+6nf
         qslFC+JyRQTBUi7QRTWK1CIPylzrn8ZES2yEEVFlHrZCjKF1GjCYpeHmiem55fFJoesa
         dXTlG9jx+dFDn1MJ7yX31Ekn9cSMQDMCFMOgQnSza632U2lCwhesZ8X2yRC5rzsoLGlT
         Ygqw==
X-Forwarded-Encrypted: i=1; AJvYcCULNgB7gR2t9PcVaVE7/EwMnBrhtpCtM3loS3kqLXYqLoTNuQVtVnyCNouGxcLubiXl842xIEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSitf5i4SbQpoPaUJLBwTo0YJnO+9eL/GI3+gnvn7OZrrLLAnr
	BSm5jCi07eAO+bIOrf3P8ACE9ZPEm1Jnu00utcbQ6+76BHvHAHdLn1+X
X-Gm-Gg: ASbGncslrrKBLCEDAmfSO85e6h3WyvuwWior6xRpm9VUjrQSY3x1V3eMH4E+C1/Qlqg
	4Qx9WDW8Znzr74oKJfcQeXYw/cIqLlQ1lgtJSiwgKcvhTQXl2IQh11vTjSH7PUmFJS07FNMa0iB
	29QYG1GaTjjZvy1PMwuU2sFrKjcSFYcKDEyY5DsQxC/kfcn6aOsRSpQR8CSdEhr9ppOz2i4OhCa
	b+yqOyiUG0b0d+wj/3Dq6L/uVLNj4DK8ymg7PBTCkGB+gd5W1bjkKaQw18M1sNnOqkGC8hrjam8
	QUzjPPMAE+IOziQgPrLgkQgvzoPVPHGgJwsKzIH65ELJa87ZUHPdtqu3rqmTnyZDlPSMbMD4Emz
	bjB6wcYORGw0qsI3i6OaHVJ6dgdJYtVIUCDKbbFwPWenLZyFtN975GLLWWmrJ9O6z1X0ViWzssj
	JA6iLLE3ZtxiC8yQ==
X-Google-Smtp-Source: AGHT+IFBHj5AHiLPFSozWaRHBF9ntqn5K9eCGUcsuxG5NUpa2ycHn2Q/uRMEEg5Cb/MN6mcrbNf2fA==
X-Received: by 2002:a05:6808:1919:b0:450:f3e4:eb05 with SMTP id 5614622812f47-45112d150ebmr6096325b6e.64.1764065996364;
        Tue, 25 Nov 2025 02:19:56 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:48::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65782a6c8f3sm4126405eaf.7.2025.11.25.02.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 02:19:55 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 25 Nov 2025 02:19:45 -0800
Subject: [PATCH net-next v2 2/8] iavf: extract GRXRINGS from .get_rxnfc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251125-gxring_intel-v2-2-f55cd022d28b@debian.org>
References: <20251125-gxring_intel-v2-0-f55cd022d28b@debian.org>
In-Reply-To: <20251125-gxring_intel-v2-0-f55cd022d28b@debian.org>
To: aleksander.lobakin@intel.com, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2184; i=leitao@debian.org;
 h=from:subject:message-id; bh=3i7C7WKxlPKP4f0VTj5obFFhyx8DsVbLTl7zSEWQvvY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpJYLIkIZHrCNVt2InqazbIwEgJO57onj7C+BuT
 j9j6CLnX9qJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSWCyAAKCRA1o5Of/Hh3
 bQ+oD/9EbaUQfykt99NhcVKbXM6HAwxijuvKLLPjhCOVON+bxERVgo+//umDkG3hSFCTkg5qx9s
 zWpGsCNkJFxFCpcF0BmP9EAn0CAdnlBn75QxEi4/RlVYKecqEW7oB/cct4Q0wNcw8ilTKAw+Sxq
 ryvQTRMn8IBBclGQAg7a4EmITq/sTf13WO2HNjSombXZKD9byz4IgN9bnQoYj8dI+Pu40kVLs4f
 pC5zvi0GkvPGjiQQ+mIHatvzj0dZOFg8BVLzMgEGMNtQupydoWN4u5vy7gxZudjtIM7QAmUjUmu
 OILpoxNvPVbKWqTkqJf70V3AVhxP69z/pEabqn2C6msu3fsei0eIISS3DHu7ym3i8MRmhA7P2EB
 jLnsxemyENdeASWvtozEm4KIZIF8HQvpOhLatLDBn/wQ7SIfytJUTDhBit0boyZ8UjV4TKypsLW
 Cf7Gch06WdkhKMbt9Kbky9odcF+4A9I8pEY7aisLj/D+Ooi6Xb+zj2opl4FJu/MzPUdu3cO3LSB
 nzYW2W/nQVeLIAwZIOV7mH3P2u4pWsziNMoG0sjptWZ9AzBPwvdzgGGWDc51qzGZdBWuYZBhVLv
 WTN+D4rPBlSx99pGJuzOtav9Rwz+tjCnu9uWrPnlIKCZGrlxLDuKrFwZPPCPV4NyJWWAVWqlr/H
 11mQ3GmGPFk/zbw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
optimize RX ring queries") added specific support for GRXRINGS callback,
simplifying .get_rxnfc.

Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
.get_rx_ring_count().

This simplifies the RX ring count retrieval and aligns iavf with the new
ethtool API for querying RX ring parameters.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
index a3f8ced23266..2cc21289a707 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
@@ -1638,6 +1638,19 @@ static int iavf_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
 	return ret;
 }
 
+/**
+ * iavf_get_rx_ring_count - get RX ring count
+ * @netdev: network interface device structure
+ *
+ * Return: number of RX rings.
+ **/
+static u32 iavf_get_rx_ring_count(struct net_device *netdev)
+{
+	struct iavf_adapter *adapter = netdev_priv(netdev);
+
+	return adapter->num_active_queues;
+}
+
 /**
  * iavf_get_rxnfc - command to get RX flow classification rules
  * @netdev: network interface device structure
@@ -1653,10 +1666,6 @@ static int iavf_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 	int ret = -EOPNOTSUPP;
 
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = adapter->num_active_queues;
-		ret = 0;
-		break;
 	case ETHTOOL_GRXCLSRLCNT:
 		if (!(adapter->flags & IAVF_FLAG_FDIR_ENABLED))
 			break;
@@ -1866,6 +1875,7 @@ static const struct ethtool_ops iavf_ethtool_ops = {
 	.set_per_queue_coalesce = iavf_set_per_queue_coalesce,
 	.set_rxnfc		= iavf_set_rxnfc,
 	.get_rxnfc		= iavf_get_rxnfc,
+	.get_rx_ring_count	= iavf_get_rx_ring_count,
 	.get_rxfh_indir_size	= iavf_get_rxfh_indir_size,
 	.get_rxfh		= iavf_get_rxfh,
 	.set_rxfh		= iavf_set_rxfh,

-- 
2.47.3


