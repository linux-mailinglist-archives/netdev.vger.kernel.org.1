Return-Path: <netdev+bounces-241491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE5DC8470E
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 11:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD473B20F5
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 10:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C1D2FE050;
	Tue, 25 Nov 2025 10:20:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DE22F5A1E
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764066004; cv=none; b=mf5lr5hH5ZiOognCPsgk2o3f2GifYAam6kDZPxJ1gb6KH51js03FS/lrged4T9QeJEo8XcZsJEzqRwc86J8qHqCvONSPbWoIU/HF04hrFQZX4/cTcEfwSa+xlfYY7Jh3nrecNhYlRUiYDCv5FQnS2BztJtDnpwSKdTgRGkkBS40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764066004; c=relaxed/simple;
	bh=Q0AZpTNUFttrJLNx9FvORT21hZNYuuTH+qlH8H7VieA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nMNgtcLUM7CmdaU7HrDcH3Df5WDUxa3y/bv4dzPlQwmmXaczvyqykA0oeVI24zdgs0abejnKeUW/XmCNECYfpTKDMgKx+/PfhlW6btbM5eMimE7ab9xTRdDww5dduSe2VfjgrxScoiyDeo+xV5ilj/Ce32PffiCZpB+xbo7r/sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7c75387bb27so1597522a34.1
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 02:20:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764066001; x=1764670801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8Yu7gPJkUQ7vuyCmZzm/NNLqbPOpqaQrxUJ4JkhHxnk=;
        b=PPnAtmI8nU8fki2DjRg+ouvVMCg5h0aI4cnLwIsmbnpCh31YTrvf8XOV6Ula9JgbQz
         EPssquWTQ3jSW00llaohgzNFQ1IUjOGU0dv2PcCKdlFEvK5WsXkT3xRHm8TdDBUXpu4l
         BOzjo8+L3HdS5Ant1qs4BZeVj3oBK6I5zkFWeQKZbzs1+WMM2xjS2qtxuDO734IBIjO0
         dlzEF4P8MfalSwR0uHjObCh6eRuBj/w8S7oOcNSy4cXHVu/zICKaGzGBoUxuM8UxcvaQ
         YI6UZy4mlw01VgGaZpnWWLcQ0A2BEoAie6ajv4YWuLCSy4I/K0Qaxfv9AUKGsUT/aHws
         nYdw==
X-Forwarded-Encrypted: i=1; AJvYcCWgRTmr2b0/oGr2njBiuXGNRJ/Ao3PA2y5rvbUSfgtY8DeeKtjrD337/JoA16dl3DPf6tJOBsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLZOnllOCJuRTvhAcscWUo25x49OSkywzO2Hnj3NT+hZO3V0Aj
	5Kji049Yi5PDeWttQEQuYvsYDUOIZEUyAwH1iy7+PsHKLeonoABbM6LdIqfbdQ==
X-Gm-Gg: ASbGnctuCjcHBFEoQhVn4UTltPMzzsPCtNxWSyEVqcMZTxZxF5gzE5ghKz5neFNW/co
	ivQ09yBa9yeHoV1tJfiO5HSur1dbOVpEEsQeljFuEPOkfEJ8nndp3am6Nwhp9uhqE/u+i7mqxiV
	dvieAYIwK5ehr/94QWV1kDlZMhp0lgVEV0zqaokRRH7RGH0b6fEtL9zlMN0HUdXsN41uDIEwj8/
	ZOunVn0q5fnNkXnFA2FzVE7T95M55YEQiv+x+xacZWTYHzv5s66wVEKZSv7Qgu6IWNSuKOK7cj5
	zVhWpYS1Otc6ACUzuUMNhuBkujzK0jjgmUgU73oaPP2b109jwgUqEvrcJw8PxgtT50wnNiwgwjk
	Md+UZAw3EDs2wFGgVH2NabA/uVM+461zzX/d9T7Gzf96ZkyvruqijKi8m4A+DG60SEO+umuOQ22
	8zhB9/bYwr3483CA==
X-Google-Smtp-Source: AGHT+IFYidAJStx/3yLbtUGaORWltJ3sPJCt+ub5ZDeRVPCOV25y2qZl0pgExiFfidEWvGeNPQgc7Q==
X-Received: by 2002:a05:6830:a90:b0:7c7:1c77:f107 with SMTP id 46e09a7af769-7c798cc684dmr8246144a34.34.1764066001247;
        Tue, 25 Nov 2025 02:20:01 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:5b::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c78d400b2fsm6117096a34.22.2025.11.25.02.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 02:20:00 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 25 Nov 2025 02:19:49 -0800
Subject: [PATCH net-next v2 6/8] igc: extract GRXRINGS from .get_rxnfc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251125-gxring_intel-v2-6-f55cd022d28b@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1918; i=leitao@debian.org;
 h=from:subject:message-id; bh=Q0AZpTNUFttrJLNx9FvORT21hZNYuuTH+qlH8H7VieA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpJYLIRfG2UeA7ILtyLTVPFkpMX69FPiKLhzY5p
 DWiH7FBcluJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSWCyAAKCRA1o5Of/Hh3
 bSZhD/0emHaiSZYsdU/B4gJdVA27ND+ZjOBWi7ZzZhXpt8NirHhjrt/kqoyxYR1506PQIgx/jU6
 oUVL46lADAMbXim0ui+0FungfV0L2yXRUjnLeFppXmp8FYKQsPjXECqKklesgdCEIgMqQQA/11C
 6MKn367INNE2kOXJh0gFA7vFNaCGPy7PLjJl8tYwMCNwSGPnVzLxRkHFs1GEpfrbXyyvRE13hu6
 23Ggl111gePbkwJAknUfY7f69TKJRX0dn/gh1WJK2nLoJ1yJfq8GMan2LQ9DO4e3VWTdmbjrskn
 5UVh0ISbounYP5X6ubpGJ6REPB8GbSv1smiqZXajN8YOYlRCMWHccfoIoxhGwo7MLCT3o1Nnc4A
 hvYIoFjn7Ai3TmE/25WDGgDIyB76QbmawwUflu12uk2CEXHJG4TVox6YuO6OSNVB56rLFpMTRJs
 /8NsrYNcrwIoSFVPuAq4xlR3UBn4MXWTgwNAusTs9cR6D8wVR7YuMAWTIhNISTw1y0yJvTZEwNX
 KEYUx3JddG/X+SjcSrf92w99XvLHsi50gAQ2lQZEQChr5FujdTussekfS+sXd6DKcO1g2K8eWHT
 UWaI0+z0rGeXJMEkgl+Jc65mQL3J0ph9iO07RaFv2LR69kfcW15lnZK6pW4yOKnpwCI6I5UNPJk
 dKfM//WFoI/ROig==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
optimize RX ring queries") added specific support for GRXRINGS callback,
simplifying .get_rxnfc.

Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
.get_rx_ring_count().

This simplifies the RX ring count retrieval and aligns igc with the new
ethtool API for querying RX ring parameters.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index bb783042d1af..e94c1922b97a 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1091,15 +1091,19 @@ static int igc_ethtool_get_rxfh_fields(struct net_device *dev,
 	return 0;
 }
 
+static u32 igc_ethtool_get_rx_ring_count(struct net_device *dev)
+{
+	struct igc_adapter *adapter = netdev_priv(dev);
+
+	return adapter->num_rx_queues;
+}
+
 static int igc_ethtool_get_rxnfc(struct net_device *dev,
 				 struct ethtool_rxnfc *cmd, u32 *rule_locs)
 {
 	struct igc_adapter *adapter = netdev_priv(dev);
 
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = adapter->num_rx_queues;
-		return 0;
 	case ETHTOOL_GRXCLSRLCNT:
 		cmd->rule_cnt = adapter->nfc_rule_count;
 		return 0;
@@ -2170,6 +2174,7 @@ static const struct ethtool_ops igc_ethtool_ops = {
 	.set_coalesce		= igc_ethtool_set_coalesce,
 	.get_rxnfc		= igc_ethtool_get_rxnfc,
 	.set_rxnfc		= igc_ethtool_set_rxnfc,
+	.get_rx_ring_count	= igc_ethtool_get_rx_ring_count,
 	.get_rxfh_indir_size	= igc_ethtool_get_rxfh_indir_size,
 	.get_rxfh		= igc_ethtool_get_rxfh,
 	.set_rxfh		= igc_ethtool_set_rxfh,

-- 
2.47.3


