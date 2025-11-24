Return-Path: <netdev+bounces-241271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DB369C82128
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 19:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA7344E7C75
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 18:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1CE3203BE;
	Mon, 24 Nov 2025 18:19:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D131531D375
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 18:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764008362; cv=none; b=AaAq8HxCLPZxZE39w/wvdqvuelHTqJuhM4iNW0wvPA8ENuyB34MR7DqDM9DLu/kjqYYJGIFE10LN/pwxKkumpVFyfWZIyG7JkHkIB8fAHTxx3SVeVltbL49ufkz+PBjc3n+ZKrIrzSQ+E0taD5gvmh8AyDnrh980Iz7v52lY6sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764008362; c=relaxed/simple;
	bh=+tr0rXCH3AppraOpbUulaj+yjW39IimK04ZXWNj9Ab8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jHVHa1ZoqbrioCmZtZ40rCvhuaKKyjgwxYZTIYHtjVvsIs/VG1txmUXTuVDLe6mrySAhcN/TbUgXowOQD4dXypPVlb0uBOj5AforGEUCT6kI/Nz6BIVv4nPneysxB1bsnrmZvmWNBm3D9YAQZy4arLs2ZWAeXxrGZQevc8X0p8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-3d70c5bb455so1644795fac.1
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 10:19:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764008360; x=1764613160;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fm7T4kYpemJMMvjDtiDQYS0ccg85PvSfsO/Tmuk9TY0=;
        b=Mp09pClV3hd5f8Jz//n6kMRwxPDsc2APDssJ0h+MdZGvt71roCKHRY8ILDCBfsDzxU
         kH5SHFgr1SHeX5zmMrcbICXz86FX73HNwON7tNmcRa908M+IviV9bfx41U0+cSLUXROL
         neNAQs2mlldr+LUNb4cJkeiVfF60RQejCl5PNEUBq+XR6+c0WkgG/Scr5hEtbVVpIOTZ
         hLqp7o/2ww064eB8xUF64FgE9bmevLp1fuBBH44OSrTddpm7cBFIT1EkPWSuDYJE6AMB
         H/VVrWQkzzrNB02xm3t3GrqEnUhawPzloRpj4tA21SukxADRw/c6XbqA4CAx7jB4uq6W
         d+4w==
X-Forwarded-Encrypted: i=1; AJvYcCU41GG7KkKVARajzzK/45L6q6emjGmRY4Dh0nFu04IfFBqrfm4kI6DgxECRIyaM8MhplymPTfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMrdC5g+6pg6kfkFvfYbIOVBAn+Dx7sG4mgMrQW11zNKZMo6Of
	dAs7inKnLPmUzEYcJLnEcIHXNF5/jVohUeFir6zpFlAijpx8ElD315YY
X-Gm-Gg: ASbGncs7620WL5Wxezq3Gb7tRyGz86tYzYdfKaqqkwYt+wVjxuSxDwGxdjYsPUqoPSp
	2FOWRbCcoZnGGOF5cKk5B1hCGX74Ep+CfcTjWBzeAVUl/7zDfmEPcCiQWCi8TMg6QWanzfcN5rt
	IMNNpDp3SJKOLAh8ax87bpSwHd2UvB1TvtmO1a99cgXSI9MtGuDBtKcaPmxcqTinCCKD7U6nvXm
	+73t95L/0ZliuabfXBi3mvbkx5/F2eDqLmBBGyA1BwGQehzF/lPI6/yWy+GmN0BgOHfL24Oyogg
	lQ3hCnEEGw0TSW4JltR06ywU6nJUta4Ih6udQLyXBB1A5DRD3mMbEtlxobDvShfx+rus7iEuPXC
	MbiEAmvk0xkiSb94OGg6+QYwc6FqShb6JlmTE/503sWsioa+k+SYfuVaiakeLSS5vJ8dd8jh+ba
	JkKXDwrkC7E/7azg==
X-Google-Smtp-Source: AGHT+IHk6DmiZ9rpOaxacJxdWVhUPb7ROk8BC/Lrjvw36nO5cYN272dniKUvdPt3nFoemdv0k23irQ==
X-Received: by 2002:a05:6871:a509:b0:3ec:3464:6a01 with SMTP id 586e51a60fabf-3ecbe2e2531mr4998928fac.22.1764008359961;
        Mon, 24 Nov 2025 10:19:19 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:5d::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ec9c2cf16asm6481464fac.5.2025.11.24.10.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 10:19:19 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 24 Nov 2025 10:19:12 -0800
Subject: [PATCH net-next 8/8] fm10k: extract GRXRINGS from .get_rxnfc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-gxring_intel-v1-8-89be18d2a744@debian.org>
References: <20251124-gxring_intel-v1-0-89be18d2a744@debian.org>
In-Reply-To: <20251124-gxring_intel-v1-0-89be18d2a744@debian.org>
To: aleksander.lobakin@intel.com, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: michal.swiatkowski@linux.intel.com, michal.kubiak@intel.com, 
 maciej.fijalkowski@intel.com, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1896; i=leitao@debian.org;
 h=from:subject:message-id; bh=+tr0rXCH3AppraOpbUulaj+yjW39IimK04ZXWNj9Ab8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpJKGdghtwLmciShpO+hE5nMVvZSncmpHb5w+dv
 GWfQi0xDpuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSShnQAKCRA1o5Of/Hh3
 bbtbD/0Vk0xiqTFHZzmeMTEhz0ob741q7xVzRMymgLSJXw7eSNIwOzXeIVsoN3wJ/mVaMB28xsm
 mjRUf4HqK0HA2pmdVUi+MZVXG4LD63Qt3XWlj8oyb0iIrSuwpY02UGWkWN0Ry4FjMLuRHwLO6QF
 FrHGwuBCoFbZ+M8aE64uqAF/rRaTX97ZTY6/o4gPfkxtzfJJ99lr/DP1xQgjr5rM0Xb3wXu01W8
 03mGJTg4lGgp8NLBE/6WSRLgyuQE0KpEJDg60iQgfC86R/ysrNoGmV4Fsa1LmOsLE2xeZtiPCB2
 HBye5VM4ciChfusUhN7wpnWbtRsz6esv+FcgFHZhzLp7v4BNDDd0EOCODb8mjPmOOKDs4Wp22ra
 xwuyupifJ4y9SUS5dPuMa8bAOQboHmzh4bym61lUWT0RCv96W46gOkRSGuhZvj9ACgkr2pLLNL2
 AzaVSl8R6D/iqC2G9bGsdpKbLjoMP6hx8BNt1DNEpwN7Le8TSolSaOTBWmvDu3/9zkCWLKdUQOz
 sm/XBYxY1JXuaVG4w8cl6WzPRcJ0p+Br8RxPJvasxn7whhRR5kAv3Za5rwaNwf7Zf/tuBmhzP3x
 9VMdP5qSjtqjOe8fijA4LXqYTJcRdaaGkA1L2dJNBeJSR6Y38KqEscHc/x3tXN1hAGZqVMHDT1/
 5EJWH6oCFLFcX4Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
optimize RX ring queries") added specific support for GRXRINGS callback,
simplifying .get_rxnfc.

Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
.get_rx_ring_count().

This simplifies the RX ring count retrieval and aligns fm10k with the new
ethtool API for querying RX ring parameters.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
index bf2029144c1d..76e42abca965 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
@@ -734,22 +734,11 @@ static int fm10k_get_rssh_fields(struct net_device *dev,
 	return 0;
 }
 
-static int fm10k_get_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd,
-			   u32 __always_unused *rule_locs)
+static u32 fm10k_get_rx_ring_count(struct net_device *dev)
 {
 	struct fm10k_intfc *interface = netdev_priv(dev);
-	int ret = -EOPNOTSUPP;
 
-	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = interface->num_rx_queues;
-		ret = 0;
-		break;
-	default:
-		break;
-	}
-
-	return ret;
+	return interface->num_rx_queues;
 }
 
 static int fm10k_set_rssh_fields(struct net_device *dev,
@@ -1160,7 +1149,7 @@ static const struct ethtool_ops fm10k_ethtool_ops = {
 	.set_ringparam		= fm10k_set_ringparam,
 	.get_coalesce		= fm10k_get_coalesce,
 	.set_coalesce		= fm10k_set_coalesce,
-	.get_rxnfc		= fm10k_get_rxnfc,
+	.get_rx_ring_count	= fm10k_get_rx_ring_count,
 	.get_regs               = fm10k_get_regs,
 	.get_regs_len           = fm10k_get_regs_len,
 	.self_test		= fm10k_self_test,

-- 
2.47.3


