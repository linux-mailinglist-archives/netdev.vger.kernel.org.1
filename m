Return-Path: <netdev+bounces-301017-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Db59DOEAOWoBlQcAu9opvQ
	(envelope-from <netdev+bounces-301017-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 11:31:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FA76AE3CF
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 11:31:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301017-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301017-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 403D030C7AB1
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 09:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BE53A05F2;
	Mon, 22 Jun 2026 09:20:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FCC356772;
	Mon, 22 Jun 2026 09:20:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782120023; cv=none; b=Jb7sD6woGhCp2qqOkoLW2k2+cpHVhe8N1wtkG/5Qg+fZdoEq6INRcOJIpUIEI2hivDwnH9xJAZip9gOH7BnXVYHY1y6fc/P9ywkqPugij11MuQSl6MXxH/iSO36ZZepDUcep/su6L+lZ7K9RDJIiL4ZWnJkMSMvNLpx681BjHxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782120023; c=relaxed/simple;
	bh=jsbsYpLrNq4V7qq+WOyrPMxgrzakuow/6sMDxaTx2ws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dOWaL/gY+s6xEUpT+BRIMuEOcuEzpBsWOXK0DjiphYD9ZNG/G0060XDBDiDnq86UQJD4P3xJplMpuq0aO21SJ888gLVr3DMAkxGsXLzt5eXU6ol6L1jaXl0QhinFzMNNVpsYvfcomYUsJgxCEVplMDB4ANfjZaHpVBwIXgKGVFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7C0661A02FB;
	Mon, 22 Jun 2026 11:20:08 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4E2F41A0307;
	Mon, 22 Jun 2026 11:20:08 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0F8E81800071;
	Mon, 22 Jun 2026 17:20:05 +0800 (+08)
From: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	horms@kernel.org,
	shuah@kernel.org,
	vladimir.oltean@nxp.com,
	vinicius.gomes@intel.com,
	fejes@inf.elte.hu,
	xiaoliang.yang_1@nxp.com
Subject: [PATCH net-next 3/6] uapi: tc_act: add tc_frer UAPI header
Date: Mon, 22 Jun 2026 17:21:15 +0800
Message-Id: <20260622092118.6846-4-xiaoliang.yang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260622092118.6846-1-xiaoliang.yang_1@nxp.com>
References: <20260622092118.6846-1-xiaoliang.yang_1@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:horms@kernel.org,m:shuah@kernel.org,m:vladimir.oltean@nxp.com,m:vinicius.gomes@intel.com,m:fejes@inf.elte.hu,m:xiaoliang.yang_1@nxp.com,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[xiaoliang.yang_1@nxp.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301017-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[xiaoliang.yang_1@nxp.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A7FA76AE3CF

Define the netlink attribute layout and enumerations for the FRER tc
action (IEEE 802.1CB Frame Replication and Elimination for Reliability).

The action is split into two functional sub-commands selected by the
TCA_FRER_FUNC attribute:

  TCA_FRER_FUNC_PUSH    - Egress: sequence number generation and R-TAG
                          insertion. The action inserts an R-TAG with
                          the current sequence number into the frame
                          before passing it on. When chained with
                          "action mirred egress mirror", the mirrored
                          copy already carries the R-TAG, so all
                          replicated frames on different egress paths
                          carry the same sequence number without any
                          additional shared state.

  TCA_FRER_FUNC_RECOVER - Ingress: duplicate detection and elimination.
                          Multiple ingress filters can share the same
                          recovery state by referencing the same action
                          index, implementing Sequence Recovery across
                          ports (IEEE 802.1CB Section 7.4.2).
                          When TCA_FRER_RCVY_INDIVIDUAL flag is set,
                          the action uses private per-action state
                          (Individual Recovery, Section 7.5).

Statistics attributes map directly to the managed objects defined in
IEEE 802.1CB Table 10-1.

Signed-off-by: Xiaoliang Yang <xiaoliang.yang_1@nxp.com>
---
 include/uapi/linux/tc_act/tc_frer.h | 89 +++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 include/uapi/linux/tc_act/tc_frer.h

diff --git a/include/uapi/linux/tc_act/tc_frer.h b/include/uapi/linux/tc_act/tc_frer.h
new file mode 100644
index 000000000000..241e90827e26
--- /dev/null
+++ b/include/uapi/linux/tc_act/tc_frer.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/* Copyright 2026 NXP */
+
+#ifndef __LINUX_TC_FRER_H
+#define __LINUX_TC_FRER_H
+
+#include <linux/pkt_cls.h>
+
+/* Base parameters passed in TCA_FRER_PARMS */
+struct tc_frer {
+	tc_gen;
+};
+
+/**
+ * enum TCA_FRER_* - netlink attributes for the FRER tc action
+ *
+ * @TCA_FRER_FUNC:             Functional sub-command (tc_frer_func).
+ *                             Mandatory.
+ * @TCA_FRER_TAG_TYPE:         Redundancy tag type (tc_frer_tag_type).
+ *                             Mandatory.
+ *
+ * Push-specific attributes (TCA_FRER_FUNC_PUSH):
+ * Recover-specific attributes (TCA_FRER_FUNC_RECOVER):
+ * @TCA_FRER_RCVY_INDIVIDUAL:  Flag. Force Individual Recovery.
+ * @TCA_FRER_RCVY_ALG:         u8. Recovery algorithm (tc_frer_rcvy_alg).
+ * @TCA_FRER_RCVY_HISTORY_LEN: u8. SequenceHistory window size (1-32).
+ *                             Maps to frerSeqRcvyHistoryLength.
+ * @TCA_FRER_RCVY_RESET_MSEC:  u32. Reset timer in milliseconds.
+ *                             0 disables the timer.
+ *                             Maps to frerSeqRcvyResetMSec.
+ * @TCA_FRER_RCVY_TAKE_NO_SEQ: Flag. Accept frames without a redundancy
+ *                             tag and pass them unconditionally.
+ *                             Maps to frerSeqRcvyTakeNoSeq.
+ * @TCA_FRER_RCVY_TAG_POP:     Flag. Remove the redundancy tag from
+ *                             frames that pass the recovery function.
+ *
+ * Read-only statistics (filled on dump, IEEE 802.1CB Table 10-1):
+ * @TCA_FRER_STATS_TAGLESS_PKTS:       frerCpsSeqRcvyTaglessPackets
+ * @TCA_FRER_STATS_OUT_OF_ORDER_PKTS:  frerCpsSeqRcvyOutOfOrderPackets
+ * @TCA_FRER_STATS_ROGUE_PKTS:         frerCpsSeqRcvyRoguePackets
+ * @TCA_FRER_STATS_LOST_PKTS:          frerCpsSeqRcvyLostPackets
+ * @TCA_FRER_STATS_RESETS:             frerCpsSeqRcvyResets
+ * @TCA_FRER_STATS_PASSED_PKTS:        frerCpsSeqRcvyPassedPackets
+ * @TCA_FRER_STATS_DISCARDED_PKTS:     frerCpsSeqRcvyDiscardedPackets
+ * @TCA_FRER_STATS_SEQGEN_PKTS:        frerCpsSeqGenPackets
+ */
+enum {
+	TCA_FRER_UNSPEC,
+	TCA_FRER_TM,                       /* struct tcf_t */
+	TCA_FRER_PARMS,                    /* struct tc_frer */
+	TCA_FRER_PAD,
+	TCA_FRER_FUNC,                     /* u8: tc_frer_func */
+	TCA_FRER_TAG_TYPE,                 /* u8: tc_frer_tag_type */
+	TCA_FRER_RCVY_INDIVIDUAL,          /* NLA_FLAG */
+	TCA_FRER_RCVY_ALG,                 /* u8: tc_frer_rcvy_alg */
+	TCA_FRER_RCVY_HISTORY_LEN,         /* u8: 1-32 */
+	TCA_FRER_RCVY_RESET_MSEC,          /* u32 */
+	TCA_FRER_RCVY_TAKE_NO_SEQ,         /* NLA_FLAG */
+	TCA_FRER_RCVY_TAG_POP,             /* NLA_FLAG */
+	TCA_FRER_STATS_TAGLESS_PKTS,       /* u64 */
+	TCA_FRER_STATS_OUT_OF_ORDER_PKTS,  /* u64 */
+	TCA_FRER_STATS_ROGUE_PKTS,         /* u64 */
+	TCA_FRER_STATS_LOST_PKTS,          /* u64 */
+	TCA_FRER_STATS_RESETS,             /* u64 */
+	TCA_FRER_STATS_PASSED_PKTS,        /* u64 */
+	TCA_FRER_STATS_DISCARDED_PKTS,     /* u64 */
+	TCA_FRER_STATS_SEQGEN_PKTS,        /* u64 */
+	__TCA_FRER_MAX,
+};
+
+#define TCA_FRER_MAX (__TCA_FRER_MAX - 1)
+
+enum tc_frer_func {
+	TCA_FRER_FUNC_PUSH    = 1,
+	TCA_FRER_FUNC_RECOVER = 2,
+};
+
+enum tc_frer_tag_type {
+	TCA_FRER_TAG_RTAG = 1,
+	TCA_FRER_TAG_HSR,
+	TCA_FRER_TAG_PRP,
+};
+
+enum tc_frer_rcvy_alg {
+	TCA_FRER_RCVY_VECTOR_ALG = 0,  /* IEEE 802.1CB 7.4.3.4 */
+	TCA_FRER_RCVY_MATCH_ALG  = 1,  /* IEEE 802.1CB 7.4.3.5 */
+};
+
+#endif /* __LINUX_TC_FRER_H */
-- 
2.17.1


