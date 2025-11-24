Return-Path: <netdev+bounces-241267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2142EC82113
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 19:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8DC84E5950
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 18:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D15F31B11D;
	Mon, 24 Nov 2025 18:19:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FA531A7ED
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 18:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764008358; cv=none; b=EOzpySwKK1+fm/EUc8jlFySMjyXAiferFk6LrGgbSHEobOgldiGJVwK7bujg9vz9ZDdaGk/TbBKP91wufekwo+HLG/hUoOJq+T2+fqQl1u3Mp9n5zXfcedEP/EjKowrxXmhDePJQnMp+EWHolE5lXBrJfL/J4NJZ1E9F0UAM2wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764008358; c=relaxed/simple;
	bh=hYkHdy6E073gG8/8HYCpA5Ni92JYVnpQPGGEfFxBtiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SKdYdWULaO04/D7BcPUQdqvhKajZ6df/Qcd9AZJwtZq0fONhGVdZ5/0LTmcm3BYC/pFdOIXgZMtj1e5dv5ZtdVTh97XT31Xcms6JZSvh3O3mVfdN9KCHaXzK9fmmGhQFIUOOuyU4AAKhDigzhe8qjImfb4FTpu7uRUb27fmEgZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-450b8afe3e0so2201001b6e.0
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 10:19:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764008355; x=1764613155;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9iprVTNk6cZAkMWJ9/9S/EGM0b2WsW8vk/nq2Pv03p0=;
        b=r+VcpGCURcVkAwCVedJsmDgYr5qe5jxYHhL+wtEyyI+VXnuv2I+/JxvsBWn7/ELSBT
         PbYaYcU0QP/EQRMwu+AEW685IpGww+Mnsd2UhsFuQ9+DolUtBM2GEWKHdmYrTvHJoE8a
         BuojcynBnSN7ZJDw5mXz3jYffxKY0rAmWP3kO2AdZPffKFIS5cQSlr0/OiWmb7J6YgZN
         +/gJ7v+1FeQ/2QvBk4nHpiMwwWt/m0+KLRDCMCajwehDh0a136oudlkQPZUjAK03MG3Q
         CmmWVl76Y5r8M62gqUCCmN2S6Gc/K5eFgniW6tcGNzm1mxVP22YH71ywMsjC6hKQNhuo
         +eLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsxFoLQEvHYXBZkR/JCFmNQSPhzNYAiwUxnvI9e8/MEhxXCsTJR2UWBZeSBLZt3p1lOcIrKgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPgZtGaq3/3ztL/mFnOfVXq9/KvZKH1gE1hXd1B+9WGiX6qGNo
	E1lnwvYIPexmtPu4/HO+okZaqM1TuUdGEgBj1dJ+kNC/AJRtLXLMQOfR
X-Gm-Gg: ASbGncuN/XESBf/PlJOW1Paln9S8NFHM05IMitr7Ql9VU/IZJeSUflYFGn2f+g7I2nz
	YKDss8YWf7lLvevX7UuyfC+3DEmzlFIoT5zRL+6AOXQd1L/YC21w5BGM3jadgeLQdEOpisHKpEx
	VGiMZQK670SsFjUBgaf5NuWhB+puXn0B7yyRWLi6zLRai8s2QHrdG6kmGQOHwftZOA/NWPeYAz8
	5tY9vnEtv0Tp/FQZ751KS7TD92tqWLdSntkTt30k9QOUXRTFi+/vdeKAoQ9mLp4SfJNPtWhjahk
	In4iQOREP0/k5jc1QQhZhgRuz9RHBO4jCU60nEYbaz4xBfWJj+8KvNSiL3soNGh3D7FN1uNF0rt
	1OdZfBcdudeheY+5OoJoyjFz1Ej6YdegiThR2XEo4V8IAm2uhkOzo+7d2NdjVHg4+FyfmCqt3OT
	yA6rlujmCIbr7q4tkoeRj4LWo=
X-Google-Smtp-Source: AGHT+IEqHSydC4Hu/p5OXPbR7yBJvx2DQQ26Hmkiiu+GKXn+q0F3MLWMxPqPNgqwKUq4B1htfY/jqw==
X-Received: by 2002:a05:6808:6909:b0:450:4a1a:f2fe with SMTP id 5614622812f47-451125636d5mr5002081b6e.0.1764008355458;
        Mon, 24 Nov 2025 10:19:15 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:5::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65782a6c8f3sm3705269eaf.7.2025.11.24.10.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 10:19:14 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 24 Nov 2025 10:19:08 -0800
Subject: [PATCH net-next 4/8] idpf: extract GRXRINGS from .get_rxnfc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-gxring_intel-v1-4-89be18d2a744@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2377; i=leitao@debian.org;
 h=from:subject:message-id; bh=hYkHdy6E073gG8/8HYCpA5Ni92JYVnpQPGGEfFxBtiE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpJKGdu6j0EG9hbb9HyGyHW5oZXkG7YcVlwfpm6
 JLDKhlV3RyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSShnQAKCRA1o5Of/Hh3
 bR2TD/9T7TRemUBszcJz9c2nkROusEWKpX8iOtapjlin15Nh/mqs9JgiO/aLqRjnqGM9P9q7ilt
 CcMzA8av79+TwfbDG3EaeqfMM+frCGLmMJoNB1AIj9FyvsHedQL7Y2fOhmhXBqFC8+LUXENIIrB
 wISjYIqHW3cpuqR62A9ld2EmjAvFUjcYsAPqXoxaTswhRmbRM0xuirGS+0BX+2F8BYoH0fivTcA
 XL+k5liPVynjkXvHoho9lIj/zjJSGjx8FQfE9/Dup9tDXssj6AijrJhj4H7nXNwf23R2IGhY5KY
 m49cYq+KWlwQBTRNEI5/0cBRK7qy8IkcFK3nIqa5+7b3RtbRjOQtXF1ASHanLAe7PipM7QSuyL+
 PWMhyZX4vT+ZxUc44BUad4VgNPzYjtX8dGaNzhXJqbdspN+aOlLyOoqVmtz5y25meNHPQROeHuW
 FtOtc7dv4Vgqe+kVfjIIJ+rMXSiPNcme02JhDdSKlyr5Skmd76lZjoL85ALEcmDtX7ippDdTGw1
 oNCCKJXl490ovhGAp5Z9RjKeozCxe6bW5MBRQ+LHGQVZ3Vw9CZwTG83i07TSoIiGOdO2F4kKCfo
 ddj9c/6cvVNCMPyYT26Ei9fJ12QPWypIs4a2efgTkuDWVIQz6R0Wj0KVFzMWFmx8q3Kwae7Y/wZ
 yCD9h7LkNZ2pSfw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
optimize RX ring queries") added specific support for GRXRINGS callback,
simplifying .get_rxnfc.

Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
.get_rx_ring_count().

This simplifies the RX ring count retrieval and aligns idpf with the new
ethtool API for querying RX ring parameters.

I was not totatly convinced I needed to have the lock, but, I decided to
be on the safe side and get the exact same behaviour it was before.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index a5a1eec9ade8..1b21747b8b13 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -5,6 +5,25 @@
 #include "idpf_ptp.h"
 #include "idpf_virtchnl.h"
 
+/**
+ * idpf_get_rx_ring_count - get RX ring count
+ * @netdev: network interface device structure
+ *
+ * Returns the number of RX rings.
+ */
+static u32 idpf_get_rx_ring_count(struct net_device *netdev)
+{
+	struct idpf_vport *vport;
+	u32 num_rxq;
+
+	idpf_vport_ctrl_lock(netdev);
+	vport = idpf_netdev_to_vport(netdev);
+	num_rxq = vport->num_rxq;
+	idpf_vport_ctrl_unlock(netdev);
+
+	return num_rxq;
+}
+
 /**
  * idpf_get_rxnfc - command to get RX flow classification rules
  * @netdev: network interface device structure
@@ -28,9 +47,6 @@ static int idpf_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 	user_config = &np->adapter->vport_config[np->vport_idx]->user_config;
 
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = vport->num_rxq;
-		break;
 	case ETHTOOL_GRXCLSRLCNT:
 		cmd->rule_cnt = user_config->num_fsteer_fltrs;
 		cmd->data = idpf_fsteer_max_rules(vport);
@@ -1757,6 +1773,7 @@ static const struct ethtool_ops idpf_ethtool_ops = {
 	.get_channels		= idpf_get_channels,
 	.get_rxnfc		= idpf_get_rxnfc,
 	.set_rxnfc		= idpf_set_rxnfc,
+	.get_rx_ring_count	= idpf_get_rx_ring_count,
 	.get_rxfh_key_size	= idpf_get_rxfh_key_size,
 	.get_rxfh_indir_size	= idpf_get_rxfh_indir_size,
 	.get_rxfh		= idpf_get_rxfh,

-- 
2.47.3


