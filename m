Return-Path: <netdev+bounces-283952-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EAuFtzJ+Gls0wIAu9opvQ
	(envelope-from <netdev+bounces-283952-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:31:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D154C164E
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5280300ADBC
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 16:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D68D3E3DBD;
	Mon,  4 May 2026 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYnyKAKN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94E23E4C7A
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 16:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777912227; cv=none; b=aapHzhObnV6xyVS51L70jX3I0jMaA5vBiB9M2OnHkhE+tqN/uou4K6OxFNr0tRN2sPt1QLxPSaWAP63gSs/H0tkZ2XGqVj/rgAio0KN+eAM5PtUyb+xmzniBCMdezpt5irgjfuAYokmm52Lk/4vSmmHuAR5QogZsNZJKDpaBCBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777912227; c=relaxed/simple;
	bh=Zr0FSOeNg/otAI19G7/HBdtSNwFcpJA+mlAvGORJG1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g05gy2ikWgIi3Jv6L0KZVoBCCe0xXZaGhabV7DL3Kb7gOHpF6f2wpQg7F2pLhIZRyfRrQPEbnWdRRFjYmQOZWKctQ1mqku8UE7RmJA3TTvB/4Ao9Dtk3mjoPYpkUv0rFu3fTxGgILlgebeLE1GjudpIfG/jSr/FwxsH/jyaIrwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYnyKAKN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777912223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bK5U80438IEpWRoTKF0zE1rtE23u+leDsGkKv8PM3+A=;
	b=JYnyKAKNWaEPLoRQWW42j+xUZwfpEFVgYWNPs8ZlHWLHokVu7Oy4jBpxdI1Y+UcRC2lTfg
	1Jl2zGfuj9k7k8u8Esd70IevYeoUAucue8J/WGy9KdsFjrPYTZ4apvVryAsQ+FXwaRWtMX
	rr8LYeozxBh8tzXlLBF1f8oqIHBYzCU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-Ab_Z1JHYOnCWcfUR6jPySg-1; Mon,
 04 May 2026 12:30:20 -0400
X-MC-Unique: Ab_Z1JHYOnCWcfUR6jPySg-1
X-Mimecast-MFC-AGG-ID: Ab_Z1JHYOnCWcfUR6jPySg_1777912219
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54A521800265;
	Mon,  4 May 2026 16:30:19 +0000 (UTC)
Received: from p16v.luc.cera.cz (unknown [10.44.32.88])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B631819560A6;
	Mon,  4 May 2026 16:30:17 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next v3 1/2] dpll: add ps unit to phase-related pin attributes
Date: Mon,  4 May 2026 18:30:13 +0200
Message-ID: <20260504163014.416317-2-ivecera@redhat.com>
In-Reply-To: <20260504163014.416317-1-ivecera@redhat.com>
References: <20260504163014.416317-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: 59D154C164E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-283952-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]

Display phase-adjust-min, phase-adjust-max and phase-adjust values
with ps unit. Add DPLL_PR_PHASE_OFFSET macro that properly formats
phase-offset as fractional picoseconds by dividing the raw kernel
value by DPLL_PHASE_OFFSET_DIVIDER.

Reviewed-by: Petr Oros <poros@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
Changes:
v3 - macro DPLL_PR_PHASE_OFFSET replaced by function
     dpll_pr_phase_offset
---
 dpll/dpll.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/dpll/dpll.c b/dpll/dpll.c
index b6ba3283e0ba..1c5d2b1b7f28 100644
--- a/dpll/dpll.c
+++ b/dpll/dpll.c
@@ -455,6 +455,24 @@ static void dpll_pr_multi_enum_str(const struct nlmsghdr *nlh, int attr_id,
 	print_nl();
 }
 
+/* Phase offset - JSON prints raw sub-ps value, FP prints fractional ps */
+static void dpll_pr_phase_offset(struct nlattr *attr)
+{
+	__s64 val;
+	lldiv_t d;
+
+	if (!attr)
+		return;
+
+	val = mnl_attr_get_sint(attr);
+	d = lldiv(llabs(val), DPLL_PHASE_OFFSET_DIVIDER);
+	print_s64(PRINT_JSON, "phase-offset", NULL, val);
+	print_string(PRINT_FP, NULL, " phase-offset %s",
+		     val < 0 ? "-" : "");
+	print_s64(PRINT_FP, NULL, "%lld.", d.quot);
+	print_s64(PRINT_FP, NULL, "%03lld ps", d.rem);
+}
+
 /* Print frequency range (or single value if min==max) */
 static void dpll_pr_freq_range(__u64 freq_min, __u64 freq_max)
 {
@@ -1507,8 +1525,7 @@ static void dpll_pin_print_parent_devices(struct nlattr *attr)
 				 " prio %u");
 		DPLL_PR_ENUM_STR_FMT(tb_parent, DPLL_A_PIN_STATE, "state",
 				     " state %s", dpll_pin_state_name);
-		DPLL_PR_SINT_FMT(tb_parent, DPLL_A_PIN_PHASE_OFFSET,
-				 "phase-offset", " phase-offset %" PRId64);
+		dpll_pr_phase_offset(tb_parent[DPLL_A_PIN_PHASE_OFFSET]);
 
 		print_nl();
 		close_json_object();
@@ -1592,10 +1609,13 @@ static void dpll_pin_print_attrs(struct nlattr **tb)
 
 	dpll_pin_print_capabilities(tb[DPLL_A_PIN_CAPABILITIES]);
 
-	DPLL_PR_INT(tb, DPLL_A_PIN_PHASE_ADJUST_MIN, "phase-adjust-min");
-	DPLL_PR_INT(tb, DPLL_A_PIN_PHASE_ADJUST_MAX, "phase-adjust-max");
+	DPLL_PR_INT_FMT(tb, DPLL_A_PIN_PHASE_ADJUST_MIN, "phase-adjust-min",
+			"  phase-adjust-min: %d ps\n");
+	DPLL_PR_INT_FMT(tb, DPLL_A_PIN_PHASE_ADJUST_MAX, "phase-adjust-max",
+			"  phase-adjust-max: %d ps\n");
 	DPLL_PR_UINT(tb, DPLL_A_PIN_PHASE_ADJUST_GRAN, "phase-adjust-gran");
-	DPLL_PR_INT(tb, DPLL_A_PIN_PHASE_ADJUST, "phase-adjust");
+	DPLL_PR_INT_FMT(tb, DPLL_A_PIN_PHASE_ADJUST, "phase-adjust",
+			"  phase-adjust: %d ps\n");
 
 	if (json || !tb[DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT])
 		DPLL_PR_SINT(tb, DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET,
-- 
2.53.0


