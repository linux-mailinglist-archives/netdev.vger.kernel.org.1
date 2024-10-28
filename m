Return-Path: <netdev+bounces-139503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAC09B2E48
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 12:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FB8D281138
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 11:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870791D8A04;
	Mon, 28 Oct 2024 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oGr09lNp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B061D88CA
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 10:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730113166; cv=none; b=kshRoCmbzph0xW9KjxQ/VPudQH7KrqnH+z/JVXj8XvfrYK6KIdjEt/oKUz/pU2epco4IHulmxYthiz/kVfHK9vjvIoroT5nlWzN+m29raqs14auz5fgI+3lCZ5Mh6S1U4lytcVyQr9alSyuocmLBHzFXMYM84SX/5iehk1oHXJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730113166; c=relaxed/simple;
	bh=3WNIz9CBumBGYrQn3zQyAt8oGW5m6Cywud9YFlm003Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jQtSl+MVf6HvWnwb5pC+Ibjioii5rmodG5xhBXFP76XFLQfCOxT+Y8jJQhE12Ktg7YW42va1KUTPn9VE9iAf+EumohoQqs5Ki9Cb7IZd7GMeElEn0De0AC/ktTANZ+9ixG6KzScUAmjEItswvSc3KRUbdDudnHXvv17elOyFkQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oGr09lNp; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730113164; x=1761649164;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3WNIz9CBumBGYrQn3zQyAt8oGW5m6Cywud9YFlm003Q=;
  b=oGr09lNpW9FXRROcTB9GhcUP3fi5Y5/+lTvQ+TuoDnFiasFGBHA8m8aE
   X+il/8eQrGEsaRIhExlbvVLZo9W7PQEoSMSAO9GX5OiF5oes65QZCdVhj
   9o4PzIo0+jwLFmDphQze8zwognDtCvFW2lDwo6Q7tShISWhYP80nVIgug
   4ZlijNNPxubW7dnbgqa1cbiG560Ixaxd+f6JSuoDdVNPnhiJIq2S0hJp7
   fuz89bAjhIkOVT/LAPifDS6sUvDBD8C4JzNN/VxN6ljF88Qe2V6HPHe8B
   fJCzpUd2t2eGNw1T3bC9BYewlCRhWXByokMlUiPS+olVFOZOk+SgFFPuL
   Q==;
X-CSE-ConnectionGUID: QtXKDLslTR6XKgfucXO26A==
X-CSE-MsgGUID: kb8G5tJyQb2q1lkw3hxpwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="17339466"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="17339466"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 03:59:23 -0700
X-CSE-ConnectionGUID: lUAShk6GSrG4Pop881gKpg==
X-CSE-MsgGUID: Vbf0X2bAQGW+xsLHFWU2tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="81904693"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa010.fm.intel.com with ESMTP; 28 Oct 2024 03:59:22 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 7F3D527BC4;
	Mon, 28 Oct 2024 10:59:20 +0000 (GMT)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: david.m.ertman@intel.com,
	netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-net] ice: change q_index variable type to s16 to store -1 value
Date: Mon, 28 Oct 2024 12:59:22 -0400
Message-Id: <20241028165922.7188-1-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix Flow Director not allowing to re-map traffic to 0th queue when action
is configured to drop (and vice versa).

The current implementation of ethtool callback in the ice driver forbids
change Flow Director action from 0 to -1 and from -1 to 0 with an error,
e.g:

 # ethtool -U eth2 flow-type tcp4 src-ip 1.1.1.1 loc 1 action 0
 # ethtool -U eth2 flow-type tcp4 src-ip 1.1.1.1 loc 1 action -1
 rmgr: Cannot insert RX class rule: Invalid argument

We set the value of `u16 q_index = 0` at the beginning of the function
ice_set_fdir_input_set(). In case of "drop traffic" action (which is
equal to -1 in ethtool) we store the 0 value. Later, when want to change
traffic rule to redirect to queue with index 0 it returns an error
caused by duplicate found.

Fix this behaviour by change of the type of field `q_index` from u16 to s16
in `struct ice_fdir_fltr`. This allows to store -1 in the field in case
of "drop traffic" action. What is more, change the variable type in the
function ice_set_fdir_input_set() and assign at the beginning the new
`#define ICE_FDIR_NO_QUEUE_IDX` which is -1. Later, if the action is set
to another value (point specific queue index) the variable value is
overwritten in the function.

Fixes: cac2a27cd9ab ("ice: Support IPv4 Flow Director filters")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c | 3 ++-
 drivers/net/ethernet/intel/ice/ice_fdir.h         | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
index 5412eff8ef23..ee9862ddfe15 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
@@ -1830,11 +1830,12 @@ static int
 ice_set_fdir_input_set(struct ice_vsi *vsi, struct ethtool_rx_flow_spec *fsp,
 		       struct ice_fdir_fltr *input)
 {
-	u16 dest_vsi, q_index = 0;
+	s16 q_index = ICE_FDIR_NO_QUEUE_IDX;
 	u16 orig_q_index = 0;
 	struct ice_pf *pf;
 	struct ice_hw *hw;
 	int flow_type;
+	u16 dest_vsi;
 	u8 dest_ctl;
 
 	if (!vsi || !fsp || !input)
diff --git a/drivers/net/ethernet/intel/ice/ice_fdir.h b/drivers/net/ethernet/intel/ice/ice_fdir.h
index ab5b118daa2d..820023c0271f 100644
--- a/drivers/net/ethernet/intel/ice/ice_fdir.h
+++ b/drivers/net/ethernet/intel/ice/ice_fdir.h
@@ -53,6 +53,8 @@
  */
 #define ICE_FDIR_IPV4_PKT_FLAG_MF		0x20
 
+#define ICE_FDIR_NO_QUEUE_IDX			-1
+
 enum ice_fltr_prgm_desc_dest {
 	ICE_FLTR_PRGM_DESC_DEST_DROP_PKT,
 	ICE_FLTR_PRGM_DESC_DEST_DIRECT_PKT_QINDEX,
@@ -186,7 +188,7 @@ struct ice_fdir_fltr {
 	u16 flex_fltr;
 
 	/* filter control */
-	u16 q_index;
+	s16 q_index;
 	u16 orig_q_index;
 	u16 dest_vsi;
 	u8 dest_ctl;

base-commit: 93e5920e5193241cb05caaa6421365fd8800f1b4
-- 
2.38.1


