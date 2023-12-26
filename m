Return-Path: <netdev+bounces-60314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1DC81E8BF
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 18:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B151C214E2
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 17:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DE74FF74;
	Tue, 26 Dec 2023 17:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L7m4xtHy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A394F8A6
	for <netdev@vger.kernel.org>; Tue, 26 Dec 2023 17:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703612497; x=1735148497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hd4t9O4EFGN2KuIO/IJRTFr1E4+m/Du78LBa35WSVSw=;
  b=L7m4xtHyCQeexBa8kK6V0ToIzyQbtYo6YWq43YPNFw0nuc2rLJNSIInw
   7t19ZO719T51snbsXohKT+P0+ge8Xo4a3IjLfjnl2A/MDAxh3RhupLNlP
   nUbElji5eNP9HE2Q3BuoQHSUW4y3RMWJXdMW1BrzFZtNZBXGUkvMVGTWn
   xizUQiEdZxjGjuPoSnizdJQVeSP79jSgbK3cJdMdkHYpkzknWCVEoOsdn
   7cEjp0aMtrKEqLIkgoYMseAbWwc9nueN18LlR+07IWUZQpMeHPtrcmY7n
   9DIpSgGL61yB5NL1cC6BJEvfPIJcB8rQFQh4P1YekqR0ajAs4ilypS6TP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="396099067"
X-IronPort-AV: E=Sophos;i="6.04,306,1695711600"; 
   d="scan'208";a="396099067"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 09:41:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="868638789"
X-IronPort-AV: E=Sophos;i="6.04,306,1695711600"; 
   d="scan'208";a="868638789"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Dec 2023 09:41:34 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	anthony.l.nguyen@intel.com,
	willemb@google.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Simon Horman <horms@kernel.org>,
	Scott Register <scott.register@intel.com>
Subject: [PATCH net 1/2] idpf: fix corrupted frames and skb leaks in singleq mode
Date: Tue, 26 Dec 2023 09:41:23 -0800
Message-ID: <20231226174125.2632875-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231226174125.2632875-1-anthony.l.nguyen@intel.com>
References: <20231226174125.2632875-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Lobakin <aleksander.lobakin@intel.com>

idpf_ring::skb serves only for keeping an incomplete frame between
several NAPI Rx polling cycles, as one cycle may end up before
processing the end of packet descriptor. The pointer is taken from
the ring onto the stack before entering the loop and gets written
there after the loop exits. When inside the loop, only the onstack
pointer is used.
For some reason, the logics is broken in the singleq mode, where the
pointer is taken from the ring each iteration. This means that if a
frame got fragmented into several descriptors, each fragment will have
its own skb, but only the last one will be passed up the stack
(containing garbage), leaving the rest leaked.
Then, on ifdown, rxq::skb is being freed only in the splitq mode, while
it can point to a valid skb in singleq as well. This can lead to a yet
another skb leak.
Just don't touch the ring skb field inside the polling loop, letting
the onstack skb pointer work as expected: build a new skb if it's the
first frame descriptor and attach a frag otherwise. On ifdown, free
rxq::skb unconditionally if the pointer is non-NULL.

Fixes: a5ab9ee0df0b ("idpf: add singleq start_xmit and napi poll")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Tested-by: Scott Register <scott.register@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c | 1 -
 drivers/net/ethernet/intel/idpf/idpf_txrx.c         | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index 81288a17da2a..20c4b3a64710 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -1044,7 +1044,6 @@ static int idpf_rx_singleq_clean(struct idpf_queue *rx_q, int budget)
 		}
 
 		idpf_rx_sync_for_cpu(rx_buf, fields.size);
-		skb = rx_q->skb;
 		if (skb)
 			idpf_rx_add_frag(rx_buf, skb, fields.size);
 		else
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 1f728a9004d9..9e942e5baf39 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -396,7 +396,7 @@ static void idpf_rx_desc_rel(struct idpf_queue *rxq, bool bufq, s32 q_model)
 	if (!rxq)
 		return;
 
-	if (!bufq && idpf_is_queue_model_split(q_model) && rxq->skb) {
+	if (rxq->skb) {
 		dev_kfree_skb_any(rxq->skb);
 		rxq->skb = NULL;
 	}
-- 
2.41.0


