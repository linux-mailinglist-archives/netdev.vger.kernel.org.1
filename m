Return-Path: <netdev+bounces-286497-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAxjCMOGAWpOcQEAu9opvQ
	(envelope-from <netdev+bounces-286497-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:35:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AC15094D5
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BC823300C312
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 07:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117F238239E;
	Mon, 11 May 2026 07:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lI8EAFcD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D673806CC
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 07:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484899; cv=none; b=fdPHo6h3Oa30dU56nivX7/mQIDVKQvZH59OphIPwNpJzNZ6kdJ/4vZjw7QC8X4Iq+iqLdqizXm6NGw4VrXR1rZ7ph/w5btFA4hrlEHWEi56LyMGUMBPKnD2aLHW5JqbaDiMm2LdWHsfauJ6qqFIij2rAufyv6/gsbKFEXA3d+pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484899; c=relaxed/simple;
	bh=V/FqnKuLf5ly7IGnIqtIrW8gjqh4B9YtBRmcrjcAOKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e2GhX4Y9tWATC+WDSTGwGqqOdY9zNVAzv0ShHP4vEDP+wMaMIRyfmuLGalRgvpNFx9QY04lFNKoDrH8PMZ1/S5IYxKwzUoGRmQJtORbIYRxfvShc0i1jaWNLpDwIwFzfIdVzpRoA0fyX4IHhcsVS1L/lv4fTRlqnO5KYMSUeY/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lI8EAFcD; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778484898; x=1810020898;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V/FqnKuLf5ly7IGnIqtIrW8gjqh4B9YtBRmcrjcAOKg=;
  b=lI8EAFcDD918fQJu9pgIWA7bAH3lv1ko7wvP+m8mepqvVlOpEZ8VMYgc
   VBOuSWAfWLycZBR/HfQdAYPLihiWsA3DVktcdAgxXLwCm1xkdf+IB07EH
   1/fDoPlDCzPjtEdaQK6QaWAvj7hhqv3cKQoGx31x5jxInGCMqNiDJ1rPK
   3Cb5waMgyCHfydvBgNFlKCHrl5Grz0krg51RY667MpmREZTY5Zmhts2xk
   3jdzQViq+a5Ch35n93dhTLSKS86eEzBfhShOvHr4rl1eNmVnRqiN2Z9wW
   9EKHPE/QNeyiaRtHGJ/HixErp0L88OB5VD1m5QHRXcd6fVeIoK661fFdX
   Q==;
X-CSE-ConnectionGUID: 2cVyJ0AjQxyokut/cIxfoQ==
X-CSE-MsgGUID: lJ8o2EB3QeK02r7heFJO4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="102030053"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="102030053"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 00:34:57 -0700
X-CSE-ConnectionGUID: zn7NNtibSluMa6GYVt0IrQ==
X-CSE-MsgGUID: sE7shOsJSwi1A6usA1va/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="241735131"
Received: from pae-d-dell-r7525-263.igk.intel.com ([172.28.191.240])
  by orviesa004.jf.intel.com with ESMTP; 11 May 2026 00:34:56 -0700
From: Przemyslaw Korba <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	aleksandr.loktionov@intel.com,
	arkadiusz.kubalewski@intel.com,
	Przemyslaw Korba <przemyslaw.korba@intel.com>
Subject: [PATCH iwl-next] ice: add rx timestamp tracepoint for debugging
Date: Mon, 11 May 2026 09:36:34 +0200
Message-ID: <20260511073657.1073780-1-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B6AC15094D5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286497-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[przemyslaw.korba@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add ice_rx_hwtstamp trace event to help debug PTP rx timestamp issues.
The trace captures cached_time, ts_high, and the extended ts_ns value in
ice_ptp_get_rx_hwts().

Enable with:
echo 1 > /sys/kernel/debug/tracing/events/ice/ice_rx_hwtstamp/enable
cat /sys/kernel/debug/tracing/trace_pipe

Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c   |  2 ++
 drivers/net/ethernet/intel/ice/ice_trace.h | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 691f05c62d4e..07e621813ff5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2333,6 +2333,8 @@ u64 ice_ptp_get_rx_hwts(const union ice_32b_rx_flex_desc *rx_desc,
 	ts_high = le32_to_cpu(rx_desc->wb.flex_ts.ts_high);
 	ts_ns = ice_ptp_extend_32b_ts(cached_time, ts_high);
 
+	ice_trace(rx_hwtstamp, cached_time, ts_high, ts_ns);
+
 	return ts_ns;
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_trace.h b/drivers/net/ethernet/intel/ice/ice_trace.h
index 4f35ef8d6b29..3cb8c6ea03cf 100644
--- a/drivers/net/ethernet/intel/ice/ice_trace.h
+++ b/drivers/net/ethernet/intel/ice/ice_trace.h
@@ -241,6 +241,24 @@ DEFINE_TX_TSTAMP_OP_EVENT(ice_tx_tstamp_fw_req);
 DEFINE_TX_TSTAMP_OP_EVENT(ice_tx_tstamp_fw_done);
 DEFINE_TX_TSTAMP_OP_EVENT(ice_tx_tstamp_complete);
 
+/* Trace event for Rx timestamp */
+TRACE_EVENT(ice_rx_hwtstamp,
+	    TP_PROTO(u64 cached_time, u32 ts_high, u64 ts_ns),
+
+	    TP_ARGS(cached_time, ts_high, ts_ns),
+
+	    TP_STRUCT__entry(__field(u64, cached_time)
+			     __field(u32, ts_high)
+			     __field(u64, ts_ns)),
+
+	    TP_fast_assign(__entry->cached_time = cached_time;
+			   __entry->ts_high = ts_high;
+			   __entry->ts_ns = ts_ns;),
+
+	    TP_printk("cached_time=%llu ts_high=%u ts_ns=%llu",
+		      __entry->cached_time, __entry->ts_high, __entry->ts_ns)
+);
+
 DECLARE_EVENT_CLASS(ice_esw_br_fdb_template,
 		    TP_PROTO(struct ice_esw_br_fdb_entry *fdb),
 		    TP_ARGS(fdb),

base-commit: 5c0d2ac5900d689d422a31cd45073175150c0a39
-- 
2.43.0


