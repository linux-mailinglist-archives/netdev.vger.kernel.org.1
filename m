Return-Path: <netdev+bounces-227838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB482BB8779
	for <lists+netdev@lfdr.de>; Sat, 04 Oct 2025 03:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E03519C5537
	for <lists+netdev@lfdr.de>; Sat,  4 Oct 2025 01:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889B412E1E9;
	Sat,  4 Oct 2025 01:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fJ8htmBn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC56E60B8A;
	Sat,  4 Oct 2025 01:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759540307; cv=none; b=D2Qm9X9oqi/LZ+tMu3a4q2fvSEnQhb8dNOl/TlNub45ARkESQYjrGOMZPOrYUOYJkarnh+E24KaZCej8robolJZBYibD1cdGrf8c3J53W6VzhnQR0skCQGD4oghCnGgpzp3p6muVmkCBhruHJ2KDuITI30Ok/z8QQ+gvRS46Yfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759540307; c=relaxed/simple;
	bh=/nvbjXQhHGoPrj6j5QCUqDUp1UeAzBBe3M8LhztO918=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jkc04YI7LiRyEx224yXcok9/RBS7guPs0msvn6IgDGAKSbX8PIWJdHEd2mkPbGfQTAnLjJe+Wd0rUWPDF3kzUX65UblGJDUTBTQ9coFtvyFeUZk0betxvtOlt3GOpu+NEGrMbNJaKN88iK9jZOl/UU+/5FYR2f3WYGAq2mW/1Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fJ8htmBn; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759540305; x=1791076305;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=/nvbjXQhHGoPrj6j5QCUqDUp1UeAzBBe3M8LhztO918=;
  b=fJ8htmBnoiD+Pf633vgVYOu2wH9nEwUOaoIPyhXF8vgACykDY0WBzv9C
   KmRnevB0AfgSwbTG4ospvNUT2M4MyIn4WFUuEQKkWx1eOCHmeN5rmA5pP
   voHVkfFPM2dU2DH1P7hr/u0zAaPlyCCPfjnSeSdYg19iWmbsraHK32R0I
   k/hIB0rn+QhvP+LSSOQ10rNdtGBE+JwuEnDuYHo69U9EBE6kpygAR8VZW
   J1J4Z+qImGmINuccU4y3BFhTG9iAcRgZtuN3gYyPPTPH1N6blwjYaVEuJ
   f51MjepODjRLmVNrvXtsaFwQ685Ftq5Xsi1EGV3vHV9P7FdhIzocidcVa
   Q==;
X-CSE-ConnectionGUID: MMZXDIy4QHqwNMwJCepBDw==
X-CSE-MsgGUID: I2xwcgjTQKyt7XXG5PS/YQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65650010"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65650010"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 18:11:43 -0700
X-CSE-ConnectionGUID: G9KVYypUQA69GqeoQPIzYg==
X-CSE-MsgGUID: qT1tqsntSLq4DFXsoiuzgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,314,1751266800"; 
   d="scan'208";a="178543203"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.70]) ([10.166.28.70])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 18:11:43 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 03 Oct 2025 18:09:44 -0700
Subject: [PATCH net v2 1/6] idpf: cleanup remaining SKBs in PTP flows
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251003-jk-iwl-net-2025-10-01-v2-1-e59b4141c1b5@intel.com>
References: <20251003-jk-iwl-net-2025-10-01-v2-0-e59b4141c1b5@intel.com>
In-Reply-To: <20251003-jk-iwl-net-2025-10-01-v2-0-e59b4141c1b5@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Emil Tantilov <emil.s.tantilov@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Sridhar Samudrala <sridhar.samudrala@intel.com>, 
 Phani Burra <phani.r.burra@intel.com>, 
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>, 
 Simon Horman <horms@kernel.org>, Radoslaw Tyl <radoslawx.tyl@intel.com>, 
 Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: Anton Nadezhdin <anton.nadezhdin@intel.com>, 
 Konstantin Ilichev <konstantin.ilichev@intel.com>, 
 Milena Olech <milena.olech@intel.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Samuel Salin <Samuel.salin@intel.com>
X-Mailer: b4 0.15-dev-cbe0e
X-Developer-Signature: v=1; a=openpgp-sha256; l=2261;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=oKXqI4YTMQx2dy9Gya7ZUcsXVqRMlRSihLt9ec21Nbc=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhowHJb5zdA7/lbG0/5NhcWULa2+ap5p/4131Lf2FvtsdT
 i/fFVjVUcrCIMbFICumyKLgELLyuvGEMK03znIwc1iZQIYwcHEKwESUehn+GXTPWBLMdfX5ZiHr
 HrfozsNVeQZz/26xyKyWs87RX39ei+Gfdk70k3BeQSu+B37TX/F/Zli1WmbLmuhNi07t8FG99HA
 +KwA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

From: Milena Olech <milena.olech@intel.com>

When the driver requests Tx timestamp value, one of the first steps is
to clone SKB using skb_get. It increases the reference counter for that
SKB to prevent unexpected freeing by another component.
However, there may be a case where the index is requested, SKB is
assigned and never consumed by PTP flows - for example due to reset during
running PTP apps.

Add a check in release timestamping function to verify if the SKB
assigned to Tx timestamp latch was freed, and release remaining SKBs.

Fixes: 4901e83a94ef ("idpf: add Tx timestamp capabilities negotiation")
Signed-off-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_ptp.c          | 3 +++
 drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
index ee21f2ff0cad..63a41e688733 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
@@ -855,6 +855,9 @@ static void idpf_ptp_release_vport_tstamp(struct idpf_vport *vport)
 	head = &vport->tx_tstamp_caps->latches_in_use;
 	list_for_each_entry_safe(ptp_tx_tstamp, tmp, head, list_member) {
 		list_del(&ptp_tx_tstamp->list_member);
+		if (ptp_tx_tstamp->skb)
+			consume_skb(ptp_tx_tstamp->skb);
+
 		kfree(ptp_tx_tstamp);
 	}
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
index 4f1fb0cefe51..688a6f4e0acc 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
@@ -517,6 +517,7 @@ idpf_ptp_get_tstamp_value(struct idpf_vport *vport,
 	shhwtstamps.hwtstamp = ns_to_ktime(tstamp);
 	skb_tstamp_tx(ptp_tx_tstamp->skb, &shhwtstamps);
 	consume_skb(ptp_tx_tstamp->skb);
+	ptp_tx_tstamp->skb = NULL;
 
 	list_add(&ptp_tx_tstamp->list_member,
 		 &tx_tstamp_caps->latches_free);

-- 
2.51.0.rc1.197.g6d975e95c9d7


