Return-Path: <netdev+bounces-236029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 215E6C37F3A
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 22:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 404AF3BCE26
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 21:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C001635A129;
	Wed,  5 Nov 2025 21:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UGEcbkF7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74E2359F81
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 21:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762376841; cv=none; b=t8tkwkNEAHUbeoJ8WtciWVILhvH9tRX7OYyvCIrv52l6uwI+Re/FWzEpqkS5VmW2tvNpW0F6aj6nqbyWfRto31I3m9DxUd9+pmwVZutdYZ1ER19raMWRX5NYa7H3rqrLv3lM9gvUbNIoJfhgjPf8XEAiSGUfqWbm90yZhxvqqTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762376841; c=relaxed/simple;
	bh=rlMhcEHMRWJ0HSNJoLa1bFGn5gmg/hAuctVLfT//Ub8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ITyHUo3lC/Kdl+mDGOJVhLFLv8HlknWcu0fk2Jq6cwSO6UYyXk6PLIJ8DJXAU3d70nxuuYc54xkTz7Iiovv4Y5MNsxb0PDcrSIawcgj7Rwh475GhJQue5bgnA2JjbEFFD+hTgkavIfkFlc99z7EiK7cPeunCkH/Kp1KFHOog3Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UGEcbkF7; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762376840; x=1793912840;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=rlMhcEHMRWJ0HSNJoLa1bFGn5gmg/hAuctVLfT//Ub8=;
  b=UGEcbkF7DovNYxdfmPmc/PLbXGGzmCFJKDNe4W0esJFBmMct7XjtQAiE
   ch0QEZfqhKMxn6455oixmvVZttuzfKM32yrmpoW2x6d+vOn22kv9g75UI
   UeqI0OlCd1QC63LkU6YfLb7jIyeboXsaiCr4gWqpXMfZCK4cODBQgjqOy
   v8JzrSbKgy9QjKPcTmrVPEcc3qBcxkTZVnfHfVmBO4MSl2GSaLz+M3V3b
   pBhgoZxlXg+9t443ntWaB2hRu2Qau4SNAAVc07B3S/BHa/Upi3NJKy0SN
   5lsug/Qwl75yTNFAfHdhgddnXS/o88P08TCpZkuZ5JHFfsJTvoguAzSAW
   A==;
X-CSE-ConnectionGUID: 0q/T9uT0SsuyyVWDqiF1Sw==
X-CSE-MsgGUID: tXOWIlnqQiG5p7rlcvGOcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64201028"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="64201028"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 13:07:13 -0800
X-CSE-ConnectionGUID: dhRbpRO6RnOfVTw/RWWiCw==
X-CSE-MsgGUID: mmkvBiQVSReCUkTHh2IkjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="187513278"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.90]) ([10.166.28.90])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 13:07:13 -0800
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH iwl-next v2 0/9] ice: properly use u64_stats API for all
 ring stats
Date: Wed, 05 Nov 2025 13:06:32 -0800
Message-Id: <20251105-jk-refactor-queue-stats-v2-0-8652557f9572@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFu8C2kC/4WOy27CMBBFfwV53UGeGTuPrvgP1IUTT4pbmkBsU
 iqUf6/JKkKiXY7unHPvTUUZg0T1urmpUaYQw9Dng142qj24/l0g+Hwr0mRRYwEfnzBK59o0jHC
 +yEUgJpci1FISNmxa0agyfcpf4bqY9yp8H6GXa1JvOTmEmOGfpXLCJf/XPiEgVGVtrTdSs212o
 U9y3LbD171s4VHzX7wGLIwn8ZWtm2LF3zdNtN5RPvdQ3uGdCKNl6ow8enjloeq5h/Mez2XHjow
 rGrP2zPP8CziWF3CYAQAA
X-Change-ID: 20251016-jk-refactor-queue-stats-9e721b34ce01
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Mailer: b4 0.15-dev-f4b34
X-Developer-Signature: v=1; a=openpgp-sha256; l=4932;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=rlMhcEHMRWJ0HSNJoLa1bFGn5gmg/hAuctVLfT//Ub8=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhkzuPVXffx+xjLj160Z6V8p5F+OfN7775q1zUj0fWKKTo
 3z8sXtmRykLgxgXg6yYIouCQ8jK68YTwrTeOMvBzGFlAhnCwMUpABNhkGJkeFtTHvL//Eu9E6n/
 /b5mSipMvnJK64NWcczJqgtnHbk6XRj+h3sIFT1wTLHo2+M49cEkk5R932oF+e6a231Qn6DHJi/
 KDgA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8

The ice driver has multiple u64 values stored in the ring structures for
each queue used for statistics. These are accumulated in
ice_update_vsi_stats(). The packet and byte values are read using the
u64_stats API from <linux/u64_stats_sync.h>.

Several non-standard counters are also accumulated in the same function,
but do not use the u64_stats API. This could result in load/store tears on
32-bit architectures. Further, since commit 316580b69d0a ("u64_stats:
provide u64_stats_t type"), the u64 stats API has had u64_stats_t and
access functions which convert to local64_t on 64-bit architectures.

The ice driver doesn't use u64_stats_t and these access functions. Thus
even on 64-bit architectures it could read inconsistent values. This series
refactors the ice driver to use the updated API. Along the way I noticed
several other issues and inconsistencies which I have cleaned up,
summarized below.

*) The driver never called u64_stats_init, leaving the syncp improperly
   initialized. Since the field is part of a kzalloc block, this only
   impacts 32-bit systems with CONFIG_LOCKDEP enabled.

*) A few locations accessed the packets and byte counts directly without
   using the u64 stats API.

*) The prev_pkt integer field is moved out of the stats structure and into
   the ice_tx_ring structure directly.

*) Cache line comments in ice_tx_ring and ice_rx_ring were out of date and
   did not match the actual intended layout for systems with 64-bit cache
   lines. Convert the structures to use __cacheline_group instead of
   comments.

*) The ice_fetch_u64_stats_per_ring() function took the ice_q_stats by
   value, defeating the point of using the u64_stats API entirely.

To keep the stats increments short, I introduced ice_stats_inc, as
otherwise each stat increment has to be quite verbose. Similarly a few
places read only one stat, so I added ice_stats_read for those.

This version uses struct ice_vsi_(tx|rx)_stats structures defined in
ice_main.c for the accumulator. I haven't come up with a better solution
that allows accumulating nicely without this structure. Its a bit
frustrating as it copies the entries in the ring stats structures but with
u64 instead of u64_stats_t.

I am also still not entirely certain how the ice_update_vsi_ring_stats()
function is synchronized in the ice driver. It is called from multiple
places without an obvious synchronization mechanism. It is ultimately
called from the service task and from ethtool, and I think it may also be
called from one of the netdev stats callbacks.

I'm open to suggestions on ways to improve this, as I think the result
still has some ugly logic and a fair amount of near duplicate code.

I have included the cacheline cleanup in ice_tx_ring and ice_rx_ring here,
but that could arguably be split to its own series. I only noticed it
because of attempting to move the prev_pkt field out of the ring stats. I
replaced the comments with cacheline_group, but I did not make an attempt
to optimize the existing cachelines. Probably we should experiment with the
method used in idpf with the 'read-mostly', 'read-write' and 'cold'
groupings, but doing so will require a more thorough deep dive on
performance profiling and tuning.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes in v2:
- Fix minor typos.
- Link to v1: https://patch.msgid.link/20251103-jk-refactor-queue-stats-v1-0-164d2ed859b6@intel.com

---
Jacob Keller (9):
      ice: initialize ring_stats->syncp
      ice: use cacheline groups for ice_rx_ring structure
      ice: use cacheline groups for ice_tx_ring structure
      ice: move prev_pkt from ice_txq_stats to ice_tx_ring
      ice: pass pointer to ice_fetch_u64_stats_per_ring
      ice: remove ice_q_stats struct and use struct_group
      ice: use u64_stats API to access pkts/bytes in dim sample
      ice: shorten ring stat names and add accessors
      ice: convert all ring stats to u64_stats_t

 drivers/net/ethernet/intel/ice/ice.h          |   3 -
 drivers/net/ethernet/intel/ice/ice_lib.h      |   6 +
 drivers/net/ethernet/intel/ice/ice_txrx.h     | 135 ++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h |   2 +-
 drivers/net/ethernet/intel/ice/ice_base.c     |   4 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  30 ++--
 drivers/net/ethernet/intel/ice/ice_lib.c      |  61 ++++++--
 drivers/net/ethernet/intel/ice/ice_main.c     | 201 +++++++++++++++++---------
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  45 +++---
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      |   4 +-
 11 files changed, 331 insertions(+), 162 deletions(-)
---
base-commit: c5acd2847bb5371988d6b5c165b0776967cc7da2
change-id: 20251016-jk-refactor-queue-stats-9e721b34ce01

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>


