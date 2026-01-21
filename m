Return-Path: <netdev+bounces-251794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gELJD6GFcGkEYQAAu9opvQ
	(envelope-from <netdev+bounces-251794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 08:52:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F245311D
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 08:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AA6E24A5317
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 07:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A3044B67E;
	Wed, 21 Jan 2026 07:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="PMVIdk8M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E702438B993
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 07:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768981906; cv=none; b=Ryx57ciPyyzb4kNh+rqxD0Hhy5oNKtu81dnveL8Q0vt4A3vS87IaMQ5eMqCVMbwMkBspVkxKUN3g7M/UrA+2VI8sIjOn7wVdtiE/NdgEX+UADS9YQgRJomCawUoc2OaWzMjc3hzyxHwGfZyCs7J6hk3x+9NmDLYoQtGfjqUU49w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768981906; c=relaxed/simple;
	bh=3Wvto2L/i7ELb+RtswT4bkc5TiCycoPC0QPWQTZpVJw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BRx2G17bH67L+ayVV3jlqEMLO/0ezBprHphi82enFcfz4HEq4Q/9Hzw86K5TVph7ixLE6YOsaWwHS3dfCVFKnBSQSATU2IBE2N8orW2wu0auOVLFDRytOMq/ACKpYjCufPZsHE6mBdJYl3uL8RaefXl9zRh7C4PONsdor6vWfMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=PMVIdk8M; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AD063400DF
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 07:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1768981895;
	bh=mwIPbOci5oaCyF1RQyLgWXCMn5I/M1luBxKEhZcFZB8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=PMVIdk8M5nP6R6TQOkf9K3W+c2O7BRLDw9uPgHWeeuQdfhqmCXm3N3B9jWHqRxTsN
	 pyrig7sSr9nGypAGkOS1UUfZrR11+f7ypQ/jABQb3bhjclT68hKw0urWJW1sgnZEQt
	 U1+gy/2xtc5eDtOV/lwmgLnbqcH/QRJiRqghvsoem8cA7Xb1eSCIgSxxzmF6y4K8za
	 TH3jgbn5yiScO599fIqy/IBYUYQ8xK1PIzZoIRCywUIuh6Vnh0xLQgRgObq9nmEEP8
	 siboIVmfb+TVH//AmVfV6tGljRJiYOoCc2LM25n3fOoJF/rsPjpH6iwJ3HLCHNY18w
	 ndCOshDuYlzPhxr08CxmwyC5q7+CkO4Fq0+YvFngKYEnBjjQ5SKoiqgru2R8yOJWbq
	 22eSVwBUj4H2u3zd0HE16buJaJH9GkniVK2QN2zi/A5/1nPkL9USjV9u+LYAdaCbpe
	 sV+gHtw1cTYx1FqvuIEwUD3RvX6JbYIy31MU4f1+ztFswegTNLAMy36+1bfkbMWMbN
	 vAdbtRy32lwKCZ9vZnmQn0it6gqaU7uI7+7ndv9zCfFRb51XkqCxIKHIx7XCeah1wD
	 iS8HodvdF9uv2z6KtafDEziArjHqB7J71s4uOmUpoVXLMuNXsnPj8rVJsUuaVuawmz
	 u4V7hpcUph5qMgqBginW5vPs=
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47edee0b11cso35290695e9.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 23:51:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768981895; x=1769586695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mwIPbOci5oaCyF1RQyLgWXCMn5I/M1luBxKEhZcFZB8=;
        b=Jjr/NwsCnRfgAwR4KetdPyC0rypLtAU55Ufixvuivr6DEHhsqego89HzA2OW/ikLzT
         gsMfNZAv3Qle0DG+adnSGlHJNSc7gMCwL6eSMm3W+Q6JDAumy3UOhGjfUH6pT1yqYtrf
         SydKZj/1FT6/ZilgQnTEIGO53ngVKNU1tcaxZAnNrs8+2H+ozL8kNINinWEbWV3k0mUK
         cu5KjmNLy6SInjNqL4yEpnHW09DW+8VBfQ4hrJJkDpfY+0xLsSHBb22CIEWS6qEuaR/j
         Ew/UiL2hHX5GaOZJ5IR9iB6hdI9RDlaNZS3UnMtF1g/guc9+oVROg1vwMdmxX5jIuJz8
         OCwA==
X-Forwarded-Encrypted: i=1; AJvYcCXTasHpPJDXP03pqDvbpajQ7HLcGq6Rsgn2kiiDtkfHpLC2T1pO8WQUIxUEAuCg7/tubxwRe3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxeIHE4686k2cA6EKPYK5m627dTHk0SjaB+XCHEAJmyp9Om76s
	5ObO5QwotTdgWQcR4RXqb0F22ffVTqBaTtM2QzsLxs3kpam8/lcKdY+qBQzv1y4/TIBGkjkVkZS
	vcEEIZ7MH8SCXBDvKR7Wo+XEcQtxxCEg4LT2wqylbaR1vDYzrE1FfltqojYdk2FWOEYqg8LphEA
	==
X-Gm-Gg: AZuq6aJPfr2vJNEes2icGqCwW6t+xiPpMYprb+lAsTBHBz0CSkYTJGDQseKwLfRs/GC
	IjQr3Mm+ZNnIuA4jufnYalt2FmpNHZ9pXVmLzxeeWhWbixuwz1die3UhQFhighS9OoqcgWu3ZnX
	J7Tpg1oa6B8QQ6CsIyQYaxUUK0ro+S+wv2WErw8OjhQbJGYp4Eyhg83Bzt9hi4LWOSBGovne2Zb
	y9qsta0Y519h6h6QT1a/MQI2rc522+HgUE/Q8lIK3O8ZmPNuimX86bOdS+pN7jGVKy6TFQXhovi
	J/NqjKseVdOYNeuuV7TRfreDtbdMEalCeOSPQoUJWx3NSdawCYy6cMnVaQFz9jhR/JsDDY9gp+f
	9R4jtKVjAkWbsdGmL2a8AhVxKDg==
X-Received: by 2002:a05:600c:4e90:b0:47e:e20e:bba3 with SMTP id 5b1f17b1804b1-4801eab54ccmr222724575e9.7.1768981895243;
        Tue, 20 Jan 2026 23:51:35 -0800 (PST)
X-Received: by 2002:a05:600c:4e90:b0:47e:e20e:bba3 with SMTP id 5b1f17b1804b1-4801eab54ccmr222724165e9.7.1768981894784;
        Tue, 20 Jan 2026 23:51:34 -0800 (PST)
Received: from localhost.localdomain ([103.155.100.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f428ac749sm356728735e9.5.2026.01.20.23.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 23:51:34 -0800 (PST)
From: Aaron Ma <aaron.ma@canonical.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ice: Fix PTP NULL pointer dereference during VSI rebuild
Date: Wed, 21 Jan 2026 15:51:06 +0800
Message-ID: <20260121075106.401770-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aaron.ma@canonical.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-251794-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	DMARC_POLICY_ALLOW(0.00)[canonical.com,reject];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[canonical.com:+];
	PRECEDENCE_BULK(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:email,canonical.com:dkim,canonical.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: D5F245311D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix race condition where PTP periodic work runs while VSI is being
rebuilt, accessing NULL vsi->rx_rings.

The sequence was:
1. ice_ptp_prepare_for_reset() cancels PTP work
2. ice_ptp_rebuild() immediately queues PTP work
3. VSI rebuild happens AFTER ice_ptp_rebuild()
4. PTP work runs and accesses NULL vsi->rx_rings

Fix: Keep PTP work cancelled during rebuild, only queue it after
VSI rebuild completes in ice_rebuild().

Added ice_ptp_queue_work() helper function to encapsulate the logic
for queuing PTP work, ensuring it's only queued when PTP is supported
and the state is ICE_PTP_READY.

Error log:
[  121.392544] ice 0000:60:00.1: PTP reset successful
[  121.392692] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  121.392712] #PF: supervisor read access in kernel mode
[  121.392720] #PF: error_code(0x0000) - not-present page
[  121.392727] PGD 0
[  121.392734] Oops: Oops: 0000 [#1] SMP NOPTI
[  121.392746] CPU: 8 UID: 0 PID: 1005 Comm: ice-ptp-0000:60 Tainted: G S                  6.19.0-rc6+ #4 PREEMPT(voluntary)
[  121.392761] Tainted: [S]=CPU_OUT_OF_SPEC
[  121.392773] RIP: 0010:ice_ptp_update_cached_phctime+0xbf/0x150 [ice]
[  121.393042] Call Trace:
[  121.393047]  <TASK>
[  121.393055]  ice_ptp_periodic_work+0x69/0x180 [ice]
[  121.393202]  kthread_worker_fn+0xa2/0x260
[  121.393216]  ? __pfx_ice_ptp_periodic_work+0x10/0x10 [ice]
[  121.393359]  ? __pfx_kthread_worker_fn+0x10/0x10
[  121.393371]  kthread+0x10d/0x230
[  121.393382]  ? __pfx_kthread+0x10/0x10
[  121.393393]  ret_from_fork+0x273/0x2b0
[  121.393407]  ? __pfx_kthread+0x10/0x10
[  121.393417]  ret_from_fork_asm+0x1a/0x30
[  121.393432]  </TASK>

Fixes: 803bef817807d ("ice: factor out ice_ptp_rebuild_owner()")
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c |  3 +++
 drivers/net/ethernet/intel/ice/ice_ptp.c  | 26 ++++++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_ptp.h  |  5 +++++
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 1851e9932cefe..2f5961573842d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -7814,6 +7814,9 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 
 	/* Restore timestamp mode settings after VSI rebuild */
 	ice_ptp_restore_timestamp_mode(pf);
+
+	/* Start PTP periodic work after VSI is fully rebuilt */
+	ice_ptp_queue_work(pf);
 	return;
 
 err_vsi_rebuild:
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 4c8d20f2d2c0a..8e5d93acaf108 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2817,6 +2817,20 @@ static void ice_ptp_periodic_work(struct kthread_work *work)
 				   msecs_to_jiffies(err ? 10 : 500));
 }
 
+/**
+ * ice_ptp_queue_work - Queue PTP periodic work for a PF
+ * @pf: Board private structure
+ *
+ * Helper function to queue PTP periodic work after VSI rebuild completes.
+ * This ensures that PTP work only runs when VSI structures are ready.
+ */
+void ice_ptp_queue_work(struct ice_pf *pf)
+{
+	if (test_bit(ICE_FLAG_PTP_SUPPORTED, pf->flags) &&
+	    pf->ptp.state == ICE_PTP_READY)
+		kthread_queue_delayed_work(pf->ptp.kworker, &pf->ptp.work, 0);
+}
+
 /**
  * ice_ptp_prepare_rebuild_sec - Prepare second NAC for PTP reset or rebuild
  * @pf: Board private structure
@@ -2835,10 +2849,15 @@ static void ice_ptp_prepare_rebuild_sec(struct ice_pf *pf, bool rebuild,
 		struct ice_pf *peer_pf = ptp_port_to_pf(port);
 
 		if (!ice_is_primary(&peer_pf->hw)) {
-			if (rebuild)
+			if (rebuild) {
+				/* TODO: When implementing rebuild=true:
+				 * 1. Ensure secondary PFs' VSIs are rebuilt
+				 * 2. Call ice_ptp_queue_work(peer_pf) after VSI rebuild
+				 */
 				ice_ptp_rebuild(peer_pf, reset_type);
-			else
+			} else {
 				ice_ptp_prepare_for_reset(peer_pf, reset_type);
+			}
 		}
 	}
 }
@@ -2984,9 +3003,6 @@ void ice_ptp_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 
 	ptp->state = ICE_PTP_READY;
 
-	/* Start periodic work going */
-	kthread_queue_delayed_work(ptp->kworker, &ptp->work, 0);
-
 	dev_info(ice_pf_to_dev(pf), "PTP reset successful\n");
 	return;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 27016aac4f1e8..428f7f79343a7 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -317,6 +317,7 @@ void ice_ptp_prepare_for_reset(struct ice_pf *pf,
 void ice_ptp_init(struct ice_pf *pf);
 void ice_ptp_release(struct ice_pf *pf);
 void ice_ptp_link_change(struct ice_pf *pf, bool linkup);
+void ice_ptp_queue_work(struct ice_pf *pf);
 #else /* IS_ENABLED(CONFIG_PTP_1588_CLOCK) */
 
 static inline int ice_ptp_hwtstamp_get(struct net_device *netdev,
@@ -383,6 +384,10 @@ static inline void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 {
 }
 
+static inline void ice_ptp_queue_work(struct ice_pf *pf)
+{
+}
+
 static inline int ice_ptp_clock_index(struct ice_pf *pf)
 {
 	return -1;
-- 
2.43.0


