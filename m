Return-Path: <netdev+bounces-281947-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJ8aAbHQ8GnDYwEAu9opvQ
	(envelope-from <netdev+bounces-281947-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:22:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F165487BAF
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F71D3046E94
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C583AE709;
	Tue, 28 Apr 2026 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YctFGuwM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAD41A3154
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777389686; cv=none; b=nk7JuYjxV69A8OezW5hXnPbAMWipIK4O2pxAiz0MT6kfHjUP6CfietbTHpjkosv9Hi+K+2V+h8wLQeKN9JZwQQ2Sw24yGreqWk9kCPO9PeuGeLBwTwZwSBZSy8FJww3SjgO/Kr+1k0f5eDZg9N+mvtrbgG97pKTvSwYU0ybWgOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777389686; c=relaxed/simple;
	bh=x07HGKZEzRj5S25MHa2Crkr0Cx0GRKohZOXw8kMpeyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDi/TsWKLuI6bTOQCtI68ahkhWXGgISnjg4wCJLCO+6bLe2RkutuuFdWD5+FNWsZX2EJJkyOoT2c1O47yN/afsZdw4NBDJMjTQMwlBLO6wS0JMqrLIBqROHWuFPcJCXvaOafUu7ONakvpASHaynJa9q9ylkLtm3mGrheBE6RHog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YctFGuwM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777389683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CUPVCQ0fKLZQVWNiqTpyYC1oYD+WOT/Mvzkhwn1usB8=;
	b=YctFGuwM/PmylUnNsB8wv6gWxXVBX/G83jXaUoyLpvzP8lIcQLGrFCCtqFnEy7RGbPV9Nk
	ZuxVBMWnifcFKJGc+slfsYW0lHHTy0fm4+GMO7jdN9EspgANkbQKu8TaMO9f4XQug6cyf6
	4/TpFq2S6jLqlZAkX+AO9L07NGSOPsQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-d9gi1r6SPVu9UBTX5m0rWQ-1; Tue,
 28 Apr 2026 11:21:22 -0400
X-MC-Unique: d9gi1r6SPVu9UBTX5m0rWQ-1
X-Mimecast-MFC-AGG-ID: d9gi1r6SPVu9UBTX5m0rWQ_1777389681
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 340C01956056;
	Tue, 28 Apr 2026 15:21:21 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.49.234])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 66872195608E;
	Tue, 28 Apr 2026 15:21:19 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH iproute2-next 1/2] dpll: add ps unit to phase-related pin attributes
Date: Tue, 28 Apr 2026 17:21:14 +0200
Message-ID: <20260428152115.2815860-2-ivecera@redhat.com>
In-Reply-To: <20260428152115.2815860-1-ivecera@redhat.com>
References: <20260428152115.2815860-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: 6F165487BAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281947-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Display phase-adjust-min, phase-adjust-max and phase-adjust values
with ps unit. Add DPLL_PR_PHASE_OFFSET macro that properly formats
phase-offset as fractional picoseconds by dividing the raw kernel
value by DPLL_PHASE_OFFSET_DIVIDER.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 dpll/dpll.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/dpll/dpll.c b/dpll/dpll.c
index b6ba3283e0ba..e8056ff6a24b 100644
--- a/dpll/dpll.c
+++ b/dpll/dpll.c
@@ -410,6 +410,21 @@ static __s64 mnl_attr_get_sint(const struct nlattr *attr)
 		}                                                              \
 	} while (0)
 
+/* Phase offset - JSON prints raw sub-ps value, FP prints fractional ps */
+#define DPLL_PR_PHASE_OFFSET(tb, attr_id)                                      \
+	do {                                                                   \
+		if (tb[attr_id]) {                                             \
+			__s64 val = mnl_attr_get_sint(tb[attr_id]);            \
+			lldiv_t d = lldiv(llabs(val),                          \
+					  DPLL_PHASE_OFFSET_DIVIDER);	       \
+			print_s64(PRINT_JSON, "phase-offset", NULL, val);      \
+			print_string(PRINT_FP, NULL, " phase-offset %s",       \
+				     val < 0 ? "-" : "");                      \
+			print_s64(PRINT_FP, NULL, "%lld.", d.quot);            \
+			print_s64(PRINT_FP, NULL, "%03lld ps", d.rem);         \
+		}                                                              \
+	} while (0)
+
 /* Generic version with custom format */
 #define DPLL_PR_ENUM_STR_FMT(tb, attr_id, name, format_str, name_func)         \
 	do {                                                                   \
@@ -1507,8 +1522,7 @@ static void dpll_pin_print_parent_devices(struct nlattr *attr)
 				 " prio %u");
 		DPLL_PR_ENUM_STR_FMT(tb_parent, DPLL_A_PIN_STATE, "state",
 				     " state %s", dpll_pin_state_name);
-		DPLL_PR_SINT_FMT(tb_parent, DPLL_A_PIN_PHASE_OFFSET,
-				 "phase-offset", " phase-offset %" PRId64);
+		DPLL_PR_PHASE_OFFSET(tb_parent, DPLL_A_PIN_PHASE_OFFSET);
 
 		print_nl();
 		close_json_object();
@@ -1592,10 +1606,13 @@ static void dpll_pin_print_attrs(struct nlattr **tb)
 
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


