Return-Path: <netdev+bounces-241235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E57C81D12
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 18:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59AA63A89DF
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 17:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A738314D1E;
	Mon, 24 Nov 2025 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fJ8SFr/N"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D5E314B61;
	Mon, 24 Nov 2025 17:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764004068; cv=none; b=k38J663G/K/mrJcKG/k7fzufkd3Am30vILZZ9o2GVBhrRYVISih3wd6DZfC14iPM0JdsQi+G1LCDjGk4VPpN6R4VDFwrhss+xbwWtw5kINiohPi4e+QjGNHsptS/2R9AtWk5UcGuWt1vhOBn0bbDC8lWndD6FGE7BEF4m7fbh1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764004068; c=relaxed/simple;
	bh=sgaKmsLcJdRp2lwCT8p7j/CIA3OHxc4UJJjuxYQK+qA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WMHHFD5x/cPp9Q8a470H/1ySaCyz6I6KGOBQ3pcJGDMcyQF1L8fjHLDbiPCGDZbeWi2f0Gic5uFcAyJaZjemfXneemxbqqIHnnoRUNjZFIubSI16jY6wBkr+MheGovc5DvCi79QXr+nOtyMcvVqRDVb0Wj7TCI6eIJuhmXZOk2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fJ8SFr/N; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764004066; x=1795540066;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sgaKmsLcJdRp2lwCT8p7j/CIA3OHxc4UJJjuxYQK+qA=;
  b=fJ8SFr/Nka0F8BwTDuN4IA7ICcMfGn3o+/Awu72ikKo11whDLrMYLxk6
   W0GK9vCKCKzolrJs8cPdL/PVzZGfUGhhgjG2toSqfTWeusbl26DtGR2cy
   Iv2S8qc5ADFyLjW+gqcLkUsnRc67rBn5dNUihDbJ4gG1wZpqLBIaAsRLv
   WlJZDsJAOU8hOoDC7glzPO1xxCfvpbnwxUR1ITEsZrRe40pD4DazkjFF8
   EXznxbsQbFHn8JhWf9XJMk3p3ESZylMn6Lao3OBW/uXRXGWleqsI3DGWa
   uqqZUGnFepqSuqbRF1RnnuDM+V52bEUu/SEP8gWWdTmbcn6w+l2fDHFKE
   g==;
X-CSE-ConnectionGUID: xw4MxxBrTPSOZsYvON8+Vg==
X-CSE-MsgGUID: 8G3KkscqRuiJ0ICu+IsNpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="76624263"
X-IronPort-AV: E=Sophos;i="6.20,223,1758610800"; 
   d="scan'208";a="76624263"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 09:07:42 -0800
X-CSE-ConnectionGUID: z01ubougQoSeAkqOXtwOIQ==
X-CSE-MsgGUID: 5RI1lQkfTQuxcKbwgOc2wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,223,1758610800"; 
   d="scan'208";a="192398148"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa007.jf.intel.com with ESMTP; 24 Nov 2025 09:07:39 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jakub Slepecki <jakub.slepecki@intel.com>,
	nxne.cnse.osdt.itp.upstreaming@intel.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] ice: fix broken Rx on VFs
Date: Mon, 24 Nov 2025 18:07:35 +0100
Message-ID: <20251124170735.3077425-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the tagged commit, ice stopped respecting Rx buffer length
passed from VFs.
At that point, the buffer length was hardcoded in ice, so VFs still
worked up to some point (until, for example, a VF wanted an MTU
larger than its PF).
The next commit 93f53db9f9dc ("ice: switch to Page Pool"), broke
Rx on VFs completely since ice started accounting per-queue buffer
lengths again, but now VF queues always had their length zeroed, as
ice was already ignoring what iavf was passing to it.

Restore the line that initializes the buffer length on VF queues
basing on the virtchnl messages.

Fixes: 3a4f419f7509 ("ice: drop page splitting and recycling")
Reported-by: Jakub Slepecki <jakub.slepecki@intel.com>
Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
I'd like this to go directly to net-next to quickly unbreak VFs
(the related commits are not in the mainline yet).
---
 drivers/net/ethernet/intel/ice/virt/queues.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/virt/queues.c b/drivers/net/ethernet/intel/ice/virt/queues.c
index 7928f4e8e788..f73d5a3e83d4 100644
--- a/drivers/net/ethernet/intel/ice/virt/queues.c
+++ b/drivers/net/ethernet/intel/ice/virt/queues.c
@@ -842,6 +842,9 @@ int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 			    (qpi->rxq.databuffer_size > ((16 * 1024) - 128) ||
 			     qpi->rxq.databuffer_size < 1024))
 				goto error_param;
+
+			ring->rx_buf_len = qpi->rxq.databuffer_size;
+
 			if (qpi->rxq.max_pkt_size > max_frame_size ||
 			    qpi->rxq.max_pkt_size < 64)
 				goto error_param;
-- 
2.51.1


