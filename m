Return-Path: <netdev+bounces-121550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B1F95D9F5
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 01:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0B0A1F22E26
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 23:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9740F1C871E;
	Fri, 23 Aug 2024 23:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="JHs52yay"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-9.cisco.com (rcdn-iport-9.cisco.com [173.37.86.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7244F1C8FB0
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 23:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724457340; cv=none; b=pFdqiEV0z+hVK5a5qfGQIEZ6azpEH5N3c2h0ucwKWXSDZMVhGP4S4WUJoTKRRZAuxdGVQQCennA+sXTO9O/0Fu2Irl7WREdDMxs4WfyQfjVLtBihWGtUMNwxxkr7JnpgPdsUGoHdNWw8iZAu0WBlTnlHq/p9RuqviJ9ccgo7Y2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724457340; c=relaxed/simple;
	bh=K/rjaVAb4bx0RjNU54IejR3b1eDm5mMKVS8t4eJuQ8w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ai2AcSHp05OkHVC/Z15Aoi1ppTplCHEtIfOYBeWp6c5oZHU8t7Lngx+IJqDB72zp7XXBhsuLmys7WVPwoGEr3LsP69pEFjbs8VhE2yTBjW6yEC6QNyQeQjCwbqWIe02vq98ek1zhrVB6s2ERP7PcKPwZ9rsyIm9YO7DSCVZw3zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=JHs52yay; arc=none smtp.client-ip=173.37.86.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3494; q=dns/txt; s=iport;
  t=1724457338; x=1725666938;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cJ6hrh2gCf/HJiABNYtYKMxufMtVhFbvYzdXi3Dcg3U=;
  b=JHs52yaykz4qoGEJvhZJOeODP74bAGEpRICA/o22Dhsr8tC2DPgxRUit
   GDKLG7fF20ZEXjeOBuMGVZwraA4GS2jMvEtCPkyZGjtWOKncE7A1MSgxw
   MT8A/pUUnPTGm2siK9ouL3VEMwvyY6GN0IQTWVgt/d3X8JnU0R0QfZ15c
   Y=;
X-CSE-ConnectionGUID: dtD3GCZWQ0i5KkBZdT6Xzg==
X-CSE-MsgGUID: LmGTlLQSTaSy4VDu1Q/cSw==
X-IronPort-AV: E=Sophos;i="6.10,171,1719878400"; 
   d="scan'208";a="249387281"
Received: from rcdn-core-8.cisco.com ([173.37.93.144])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 23:54:30 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-core-8.cisco.com (8.15.2/8.15.2) with ESMTP id 47NNsU5t008610;
	Fri, 23 Aug 2024 23:54:30 GMT
Received: by cisco.com (Postfix, from userid 412739)
	id 3A83420F2003; Fri, 23 Aug 2024 16:54:30 -0700 (PDT)
From: Nelson Escobar <neescoba@cisco.com>
To: netdev@vger.kernel.org
Cc: satishkh@cisco.com, johndale@cisco.com,
        Nelson Escobar <neescoba@cisco.com>
Subject: [PATCH net-next 0/2] Expand statistics reported in ethtool
Date: Fri, 23 Aug 2024 16:53:59 -0700
Message-Id: <20240823235401.29996-1-neescoba@cisco.com>
X-Mailer: git-send-email 2.35.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-core-8.cisco.com

Hi,

The following patches expand the statistics reported in ethtool for the enic
driver:

Patch #1: Use a macro instead of static const variables for array sizes.  I
          didn't want to add more static const variables in the next patch
          so clean up the existing ones first.

Patch #2: Expand the statistics to include per wq and per rq statistics in the
          ethtool output.

Example output after these patches:

# ethtool -S enp1s0
NIC statistics:
     tx_frames_ok: 23093667316
     tx_unicast_frames_ok: 23093667263
     tx_multicast_frames_ok: 47
     tx_broadcast_frames_ok: 6
     tx_bytes_ok: 34011338518116
     tx_unicast_bytes_ok: 34011338512894
     tx_multicast_bytes_ok: 4970
     tx_broadcast_bytes_ok: 252
     tx_drops: 0
     tx_errors: 0
     tx_tso: 22435852597
     rx_frames_ok: 36167593711
     rx_frames_total: 36178256385
     rx_unicast_frames_ok: 36178256384
     rx_multicast_frames_ok: 0
     rx_broadcast_frames_ok: 1
     rx_bytes_ok: 54176088602603
     rx_unicast_bytes_ok: 54192231882399
     rx_multicast_bytes_ok: 0
     rx_broadcast_bytes_ok: 56
     rx_drop: 0
     rx_no_bufs: 10662674
     rx_errors: 0
     rx_rss: 36178256124
     rx_crc_errors: 0
     rx_frames_64: 262
     rx_frames_127: 401677158
     rx_frames_255: 3113
     rx_frames_511: 6153
     rx_frames_1023: 12325
     rx_frames_1518: 35776557376
     rx_frames_to_max: 34359738368
     dma_map_error: 0
     rq[0]_packets: 15203911650
     rq[0]_bytes: 23018700775410
     rq[0]_l4_rss_hash: 15203911388
     rq[0]_l3_rss_hash: 0
     rq[0]_csum_unnecessary: 15203911388
     rq[0]_csum_unnecessary_encap: 0
     rq[0]_vlan_stripped: 15203911650
     rq[0]_napi_complete: 32258306
     rq[0]_napi_repoll: 218149461
     rq[0]_bad_fcs: 0
     rq[0]_pkt_truncated: 0
     rq[0]_no_skb: 0
     rq[0]_desc_skip: 0
     rq[1]_packets: 401675700
     rq[1]_bytes: 26514408889
     rq[1]_l4_rss_hash: 401675700
     rq[1]_l3_rss_hash: 0
     rq[1]_csum_unnecessary: 401675700
     rq[1]_csum_unnecessary_encap: 0
     rq[1]_vlan_stripped: 401675700
     rq[1]_napi_complete: 180387886
     rq[1]_napi_repoll: 0
     rq[1]_bad_fcs: 0
     rq[1]_pkt_truncated: 0
     rq[1]_no_skb: 0
     rq[1]_desc_skip: 0
     rq[2]_packets: 20562006510
     rq[2]_bytes: 31130873649489
     rq[2]_l4_rss_hash: 20562006510
     rq[2]_l3_rss_hash: 0
     rq[2]_csum_unnecessary: 20562006510
     rq[2]_csum_unnecessary_encap: 0
     rq[2]_vlan_stripped: 20562006510
     rq[2]_napi_complete: 35277758
     rq[2]_napi_repoll: 301947558
     rq[2]_bad_fcs: 0
     rq[2]_pkt_truncated: 0
     rq[2]_no_skb: 0
     rq[2]_desc_skip: 0
     rq[3]_packets: 7
     rq[3]_bytes: 655
     rq[3]_l4_rss_hash: 7
     rq[3]_l3_rss_hash: 0
     rq[3]_csum_unnecessary: 7
     rq[3]_csum_unnecessary_encap: 0
     rq[3]_vlan_stripped: 7
     rq[3]_napi_complete: 6
     rq[3]_napi_repoll: 0
     rq[3]_bad_fcs: 0
     rq[3]_pkt_truncated: 0
     rq[3]_no_skb: 0
     rq[3]_desc_skip: 0
     wq[0]_packets: 1156987579
     wq[0]_stopped: 0
     wq[0]_wake: 0
     wq[0]_tso: 499172850
     wq[0]_encap_tso: 0
     wq[0]_encap_csum: 0
     wq[0]_csum_partial: 657814425
     wq[0]_csum: 304
     wq[0]_bytes: 32563518059466
     wq[0]_add_vlan: 0
     wq[0]_cq_work: 3638574289
     wq[0]_cq_bytes: 32563517667582
     wq[0]_null_pkt: 0
     wq[0]_skb_linear_fail: 0
     wq[0]_desc_full_awake: 0



Thanks,
Nelson.

Nelson Escobar (2):
  enic: Use macro instead of static const variables for array sizes
  enic: Expand statistics gathering and reporting

 drivers/net/ethernet/cisco/enic/enic.h        |  38 +++++-
 .../net/ethernet/cisco/enic/enic_ethtool.c    | 114 ++++++++++++++++--
 drivers/net/ethernet/cisco/enic/enic_main.c   |  89 +++++++++++---
 3 files changed, 211 insertions(+), 30 deletions(-)

-- 
2.35.2


