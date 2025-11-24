Return-Path: <netdev+bounces-241266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DA3C8211C
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 19:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A1B13AF12D
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 18:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAD531AF06;
	Mon, 24 Nov 2025 18:19:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C59A31960F
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 18:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764008356; cv=none; b=Ts/VqgopfUVOKJQfSE4R84fMmFB8kxuWePPNYxtHjubLxKaVf8WOYsChHgCpUHoAX5PuF1sSYL053BAhOJpSXCTOLVJccuBL5zAzWuw7uwjWOThayHh8fvZcP0dN6Fi8rtIugcqEpgl+n17FKFxSbqw+A62L0Ggx475ZqAmbToI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764008356; c=relaxed/simple;
	bh=+491Or4K+VhrXnrrDRxg/WQ8CB07m+mcC02v5a0qyfc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WeaGvsuSKcRh4JEbKKDZAUG5dyDAzDcW0Hp8EeoqURuIth0JiwBy0e0hrWaHwMGUgZ6lSkjcL0XTs9Ml1p3mC8u1iaw20XRn0SZvjG1HoMfzwptIvan62pOUvPJbHwvRO1ZQiayDHCw78gmbQI47JaK6+dBc/mMPxcRXnQzj3Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3ec96ee3dabso4042542fac.1
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 10:19:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764008354; x=1764613154;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fx59kZobOiLlkjIJkhyrAD4JK62swHthcfDZB+hD/ag=;
        b=UeCEnTV0wiZFX2/cB5VyenDYaf6um/q0bV8tdQGt0P0Ox49pJ9nEV8akiYPPlbgan+
         bAwm+UPSN122qmyVNhfA6CmO0iBzdohfGfTCuyey+ojG1vB42rtGSm3oShc1/qpU3OHB
         s3XJrdx6+Hu19gW9ul6z2ZT7+M9PHY9dr3+t3YrTEYF2Ji6eCbUgZU1vj2snLwOf0mKy
         NWLoSR8R+jQIjpuOpYouyxjGxk+QQWN8avMU+1lW170BZtUdotMYzUXUNhnTA4nCIV3R
         XL15nGn0O0GAo1rVh3HYVHLi4GbEz22s3g7llEPFG5j9lSKsd8kfLQBV5OCI+MwCuPfy
         2KvA==
X-Forwarded-Encrypted: i=1; AJvYcCWmzSyMcOHTMmVXTNc2UrlYPXBooldMgCrEhDnnWVuGK8Z6F64pdQCTkEEdaAQZOzl4cwyVDBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVGeRQ9tIxlyiF0CBq6sfNOurGESw680yh5oFWYON7ek6m1SEy
	ERLYm/mOS6/0y6TWOai6vDqcd/p9VrabSd/o7IjXkpYMctlYaJGkRJsK
X-Gm-Gg: ASbGncsaBURlK9KMvOulYzqHMXf+gLfNxftO+fTKwTMEuR8NfvCw5X+wti07eMHZUzf
	piuVPdDfvh5F3VzimjsmSk5K3bna2Ksmd0zJY/x5DaHfrSksXWAUgQj7dHuuGD9/Dd8xLpCTGz4
	31ojUFQKFS2J5d92EALbNtjzASS7nQ7UjQGlmy8HeK1FG/3PJH2fZ3PqxDsJsrUK56+xgGpxxnH
	5BfZrqOtaXGpGFHiNGSkrL24E2mhh8cVU69t1hXPScFD7QvHphmv2d2XSwPqlqASWFlV7mHT56J
	jy427a81udUWfHk/o8EY4MWmCeCEuiab7/QGl5PZKagYhI3vfEjMTV1W2lhDvQ3KZ0aw0l7IQhv
	GHd8FwX2z4GqUvNy7+5TpTyKkRjuDjCLW2RDGHOr8B35xNLezD/tKX+PPQSQj/VrRwO89//Fkm4
	J4NPjRDuyXnsTBPCo2Yt8FWJ4=
X-Google-Smtp-Source: AGHT+IEwktVlSteATKeuEe8h/9QjcpnuzOQ2EefOvhCo3grua4HzWEU7FL3f7+OF8FxvOlsqkr/Ozg==
X-Received: by 2002:a05:6808:6d85:b0:450:c09:92aa with SMTP id 5614622812f47-451159c8719mr4723518b6e.12.1764008354294;
        Mon, 24 Nov 2025 10:19:14 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:7::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65782831ed6sm3739360eaf.0.2025.11.24.10.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 10:19:13 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 24 Nov 2025 10:19:07 -0800
Subject: [PATCH net-next 3/8] ice: extract GRXRINGS from .get_rxnfc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-gxring_intel-v1-3-89be18d2a744@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2097; i=leitao@debian.org;
 h=from:subject:message-id; bh=+491Or4K+VhrXnrrDRxg/WQ8CB07m+mcC02v5a0qyfc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpJKGdlls4uF2OD5ZflG+F0iwa41aeAgQ4Ihuwn
 hGFDZDhfa+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSShnQAKCRA1o5Of/Hh3
 bb0ZEACJSTnwfdl5b4X6VciykMnuVqqwIXsWYeW0iyZYWA9qWLshkLMVysv0F6xh78Fa+xLzn7H
 AmrmhIacyMhiNi2INrkHO2iGdkP9/KbDFMCg1Pheai7btan8XjGK8+DSdrE2zabVLtikuc38322
 4muERaehJd1zzkYBhkWXRlruHYk4EvVFi9EYNsaeKi1mVaHdOLaXIWtW4jpKvHdowexCoGw8xkE
 N6bOLRzAE8qIi0B0p1ojfNKOikTbFFYlNBTurzKhGdMZb7ZgECg0tr9POBJvFwyorAiTF3lQ8hq
 AqoywzO1XZ7UvngnxRVrvpzxyJfU+a0AmUZHZaf2cEVLpNpms9mW6PmAdUYmee97ZwySLpRlMBc
 dbrxZEHwuB/Zie+8hy1teQ7vqb+w8c7H1bmqiFBw9gJI2HTtncCHJXJX5yPMe4hYmccwvm6VERg
 hs+c8ong69DQniXIgykU+jXCmT6iuD5LzqvkkuCq/dQgnWu/51pYcWr8oiHTnHNaKLkkBlfHmSa
 EnB8iDRFWjq23HhYBFbCQ2zSjZ5gvmqi3eq5szqZB4VDtg0XDcpGDerMz4Sm3wP0OREancJ9R2B
 HTfzJy35UWSwPFwyX01b8xXawoFKvDSSKuXf3ibTtaoaF7G6UtOzBBMClWonAanHisiUArwbxgx
 K1QAoeOOOkg3fPw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
optimize RX ring queries") added specific support for GRXRINGS callback,
simplifying .get_rxnfc.

Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
.get_rx_ring_count().

This simplifies the RX ring count retrieval and aligns ice with the new
ethtool API for querying RX ring parameters.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index a1d9abee97e5..adb6e10ccb1b 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3083,6 +3083,20 @@ static int ice_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
 	return -EOPNOTSUPP;
 }
 
+/**
+ * ice_get_rx_ring_count - get RX ring count
+ * @netdev: network interface device structure
+ *
+ * Returns the number of RX rings.
+ */
+static u32 ice_get_rx_ring_count(struct net_device *netdev)
+{
+	struct ice_netdev_priv *np = netdev_priv(netdev);
+	struct ice_vsi *vsi = np->vsi;
+
+	return vsi->rss_size;
+}
+
 /**
  * ice_get_rxnfc - command to get Rx flow classification rules
  * @netdev: network interface device structure
@@ -3103,10 +3117,6 @@ ice_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 	hw = &vsi->back->hw;
 
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = vsi->rss_size;
-		ret = 0;
-		break;
 	case ETHTOOL_GRXCLSRLCNT:
 		cmd->rule_cnt = hw->fdir_active_fltr;
 		/* report total rule count */
@@ -4853,6 +4863,7 @@ static const struct ethtool_ops ice_ethtool_ops = {
 	.get_sset_count		= ice_get_sset_count,
 	.get_rxnfc		= ice_get_rxnfc,
 	.set_rxnfc		= ice_set_rxnfc,
+	.get_rx_ring_count	= ice_get_rx_ring_count,
 	.get_ringparam		= ice_get_ringparam,
 	.set_ringparam		= ice_set_ringparam,
 	.nway_reset		= ice_nway_reset,

-- 
2.47.3


