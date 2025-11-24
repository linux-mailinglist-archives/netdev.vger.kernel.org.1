Return-Path: <netdev+bounces-241264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8E5C8210D
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 19:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B20E3AE655
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 18:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED3F31987D;
	Mon, 24 Nov 2025 18:19:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F276F301039
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 18:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764008354; cv=none; b=aKtD7RU9bwojVB+tbgx4TeOFvxYto2avq2SSl5RMujqIuNZB4HwbGDXH1Y2CVlr0w6T3S/0v9apysgnK5CEaGkeDujkyLCPUxPSqhmlooHkRFhTZYHutOOcxi9t6NyzgkvnrGZQ22Smeqlp7KAYn1EpMAzG4RIuILVhOi91c/1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764008354; c=relaxed/simple;
	bh=qyn3+OM6gW+LptphPH5lcjCWQP2TbmlmG+01o20pfas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GghF8SlhUeeJHuKG0TlpIiaTHiU3dQ78HfNyKMmbQL7FwC5B5qJz+sM8HioZrM2IAB6WNJ7MPLAc0YzQe4sWzuL+ueE/qn1EKaCiqvNSVnfCxbNkxEt1CSWC80/WcLdYSjkntDgP/Po/CAQ+Iiz7xSv1+mURuMJHwXMeNlbFnxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-3e3dac349easo3680456fac.2
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 10:19:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764008352; x=1764613152;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gbEeLqMCDoMefCg+D9jqJ+f4KL/vbktt64C5t0GzptE=;
        b=vz/5P2q7Q9LsGwVvAgnvturzrXBA/jDeMoK5XwrwIbI0H40K5onQ0cyNdaxr+J6noh
         VizccCt+S9kNiS8WiQMmWSnudWaGNsILyVLOTTDpSyOixftFPOAj0kpSRjzn0SE+aBc9
         VNBnmp/qF0hws6H5cXcBIZzZYfptqFSr+XQ+lZSKQReS7096r/WbfJ6V9tdLbz39WlJz
         0JrUMuuMY/yfEb25EDZwfe84CiCLniI6Kq5x7OpGLmGhCyxrWwkQTENdJnhBQOcX3c/9
         WpDjREYwXr+kH6P23MPBIWs24EbGeUNbhWmfVTb2T/nvrdpPFAlgouNI3wOBpxEhnz/N
         4cdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXKgyAupVJgUzrm2g+dnF9oPhufoDIQ1dVOdhna24NOfe4ErXILEb/zmG9oMM0qRZFe5gjLRM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMiIfGiO4zDd1DFJZkAWXjs3z5eOd4uTqRunRedM57FDhhJ+7M
	8oTMzLVopw4WSM8Q9Rrxn6N+ZboWSUL/SzEv51VoPCcG4fnUzsDw5GAQ
X-Gm-Gg: ASbGncuTLZZAXBQ+ECZ2IC63Yl5Qz8TangH3Uq/nT2u+kVo8h8tKrBSTrxftxW19sXt
	WBWywMAYhLMPP57rl9lkUICO6P2Aun9sD8+a08afZrr5GnV2Yz3ot8bNczey/TzOUiJmukuG0V2
	y92KTFvHKbmm/bCrYZWnb5miz/Xpxo6EJY2fZ+fCSDxkpBsipPFiqDiN0shPDFGrx5TTru2mvRX
	dMi5yk1Jm88jzDl/aaMFBYKkwlIRIUus2k2tfeNPcIMSPJPjqoFOLBvJzAjJXczmFx+doV1KnW5
	Ut5Jkpz7wNaoVjCVlyz4h4aIDpswfODrwNMzE6DWTEeZ+1Vy+ODS8+Rb16AYrCf4jQK758GMEGf
	/vnUYQGrTXMvDCCRP5qlWevX5hhhoXsvApUzhd5zxeYFDa2AG5opoE5rTgGT35TQx8yENIha++I
	nRY5Doo6v3nJ2n
X-Google-Smtp-Source: AGHT+IE6Mu3l5ANyvT9QThE8SydVVSYRpMvq+pGBbEfK9IU5hBmSEG/FxTUOjL7wFsByBjmawtmwqw==
X-Received: by 2002:a05:6808:3190:b0:44d:a817:2d72 with SMTP id 5614622812f47-45115b3f5dbmr4091306b6e.60.1764008351502;
        Mon, 24 Nov 2025 10:19:11 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:8::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-450fffbb78fsm3962205b6e.15.2025.11.24.10.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 10:19:11 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 24 Nov 2025 10:19:05 -0800
Subject: [PATCH net-next 1/8] i40e: extract GRXRINGS from .get_rxnfc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-gxring_intel-v1-1-89be18d2a744@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2090; i=leitao@debian.org;
 h=from:subject:message-id; bh=qyn3+OM6gW+LptphPH5lcjCWQP2TbmlmG+01o20pfas=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpJKGcksVSeweu7eDKv6ShFxzUvSTfALUH5CVWW
 GfDuy1SeEuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSShnAAKCRA1o5Of/Hh3
 bauaD/4zj5yGV8OcVz5s608QCdT695aPqYXDfWgxXA+RiERkarEXki+rxOZY7N2HFbzrJseRE0V
 2MfqP/024vKVlvRRBMLDhcNmaCz3wiOvvpk8KVjErdu4a6K9ISSakqkW9gcPEz1aYHEVZdafXeZ
 ayeURdiYNVzYQw20ru6sfTVVAjd83bkr7hFZ9E5RL21A0INjiWuHRVb4wgCkU3O7uKtxyJyxV0i
 UeVYTkDnuIcOnQiTNLm9NYapENOeFiFrDY6Ih/AaApLMwtCd74o919jLmxTJ4313AMAccCoNhe+
 qAyDuE+eAbW7FGnPXI747kq+KxCCaHl7k8EL/B4KQ46NeXWtrJ5HY+ZOKrfSMovdudYxRCJeGUR
 qKzZrm/g74UVmz++5lUz+qBHRDsqohjlMi8eM2BIIPICtC7SpAKHGqs5UPp3lovH7ThucoDLbdU
 XjIyxON/wp2z5xOz2JfV/BLzlQv15Yi8T30V6QxTUhA3DMwo6JAMhXgCxzZ5poV8cD8AArm8f6J
 bieaTJmeuILfKai2eHIh7qhlvRsfJJKIUq+pSu5F7EskxMJm33EAOlA0gZn6owLSHwioR8d34lh
 VHFK+jq+TlZsxuyF8KjvdHtqZnBCpFCXOZFk/EhIPVzRrUey7vu4FL0ffU+xszkN9tQ49qtkDW4
 EhUZZ/DRi0oI8qQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Commit 84eaf4359c36 ("net: ethtool: add get_rx_ring_count callback to
optimize RX ring queries") added specific support for GRXRINGS callback,
simplifying .get_rxnfc.

Remove the handling of GRXRINGS in .get_rxnfc() by moving it to the new
.get_rx_ring_count().

This simplifies the RX ring count retrieval and aligns i40e with the new
ethtool API for querying RX ring parameters.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 86c72596617a..64d0797f5f5e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -3521,6 +3521,20 @@ static int i40e_get_ethtool_fdir_entry(struct i40e_pf *pf,
 	return 0;
 }
 
+/**
+ * i40e_get_rx_ring_count - get RX ring count
+ * @netdev: network interface device structure
+ *
+ * Returns the number of RX rings.
+ **/
+static u32 i40e_get_rx_ring_count(struct net_device *netdev)
+{
+	struct i40e_netdev_priv *np = netdev_priv(netdev);
+	struct i40e_vsi *vsi = np->vsi;
+
+	return vsi->rss_size;
+}
+
 /**
  * i40e_get_rxnfc - command to get RX flow classification rules
  * @netdev: network interface device structure
@@ -3538,10 +3552,6 @@ static int i40e_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 	int ret = -EOPNOTSUPP;
 
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = vsi->rss_size;
-		ret = 0;
-		break;
 	case ETHTOOL_GRXCLSRLCNT:
 		cmd->rule_cnt = pf->fdir_pf_active_filters;
 		/* report total rule count */
@@ -5819,6 +5829,7 @@ static const struct ethtool_ops i40e_ethtool_ops = {
 	.set_msglevel		= i40e_set_msglevel,
 	.get_rxnfc		= i40e_get_rxnfc,
 	.set_rxnfc		= i40e_set_rxnfc,
+	.get_rx_ring_count	= i40e_get_rx_ring_count,
 	.self_test		= i40e_diag_test,
 	.get_strings		= i40e_get_strings,
 	.get_eee		= i40e_get_eee,

-- 
2.47.3


