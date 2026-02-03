Return-Path: <netdev+bounces-256236-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IpfOuPKgWl1JwMAu9opvQ
	(envelope-from <netdev+bounces-256236-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 11:16:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E04D76CA
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 11:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9BF7300340A
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 10:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765D139C65F;
	Tue,  3 Feb 2026 10:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gx2M9chN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB4D39B4B8
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113680; cv=none; b=GENXoYAOlOwBjuYa4AYCe+6vaChRWv88dJO8WGRbFZRXSPIY69cfRhOS22mLKxZyEGyX/fUGxm2AwGqmsYLPP9z9ZeDEGTf38zLIs2ks01CmeYLkfdqu7UUsqHsxUH5d2KcbgC6msyb5Paj7s4tPJwCZw9w6gNk26xNC6WV+9bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113680; c=relaxed/simple;
	bh=hCBZUXXbH1zr5vJOBc7LjfftAkVp4OdDtuBnafO+vaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C0egg3/SFgb0MX4aXsYPRD9FRZ2mUR2nrX9d+EpbQiSt4xCOXWSenQJt44sbzuxbZmAHaFYv5FFZLrJhrDq6SEYuzlra9a0pcPK3lDQkbzN/BF3hfkd3pV98IvC3Y9Df2+dQefpynW3DbewmA1bxxd/CeIzxHUBLISJ0VLAa/XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gx2M9chN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770113677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/QaNIh2EPUuTgOS5CbRZUN1O44b29XrvjQT/ZlRF9lw=;
	b=Gx2M9chNqUKSj+khfcILdkfA805WZqVONLEQdGO6tSv/j24zF4pDqbv2vC3VFtaa+DTkdO
	9ggdC3klLz/hobBVR21PYRfkomSP6/cT+9lCeDZupZDsUOX3ar08JdIMGCYoTg4xRzyofl
	YiqGX+EviRl1XDZVvnWbHE3K+SoFofw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-TufCk8y_O3aHIQBTEJkw9w-1; Tue,
 03 Feb 2026 05:14:33 -0500
X-MC-Unique: TufCk8y_O3aHIQBTEJkw9w-1
X-Mimecast-MFC-AGG-ID: TufCk8y_O3aHIQBTEJkw9w_1770113672
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D34F11800357;
	Tue,  3 Feb 2026 10:14:31 +0000 (UTC)
Received: from p16v (unknown [10.43.3.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EC9E919560B2;
	Tue,  3 Feb 2026 10:14:29 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH iproute2-next] dpll: add support for fractional frequency offset in ppt
Date: Tue,  3 Feb 2026 11:14:21 +0100
Message-ID: <20260203101421.367965-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256236-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[host:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0E04D76CA
X-Rspamd-Action: no action

Add support for the DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT attribute
to the pin print attributes.

The logic ensures that in standard (human-readable) output, the legacy
fractional-frequency-offset is hidden if the new ppt (parts per trillion)
value is present, preventing redundant information.

However, the legacy attribute is still printed if:
1. The output format is JSON (to maintain full data availability).
2. The new PPT attribute is missing (backward compatibility with older
   kernels).

Human-readable output example:
==============================
[root@host iproute2-next]# ./dpll/dpll pin show id 5
pin id 5:
  module-name: zl3073x
  clock-id: 5855731461854439600
  board-label: TCX0
  package-label: REF4P
  type: ext
  frequency: 20000000 Hz
  frequency-supported:
    20000000 Hz
  capabilities: 0x6 state-can-change priority-can-change
  phase-adjust-min: -2147483648
  phase-adjust-max: 2147483647
  phase-adjust: 0
  fractional-frequency-offset-ppt: 3003980
  esync-frequency: 0 Hz
  esync-pulse: 0
  parent-device:
    id 0 direction input prio 14 state disconnected phase-offset 0
    id 1 direction input prio 14 state disconnected phase-offset 0

JSON output example:
====================
[root@host iproute2-next]# ./dpll/dpll -j -p pin show id 5
{
    "id": 5,
    "module-name": "zl3073x",
    "clock-id": 5855731461854439600,
    "board-label": "TCX0",
    "package-label": "REF4P",
    "type": "ext",
    "frequency": 20000000,
    "frequency-supported": [ {
            "frequency-min": 20000000,
            "frequency-max": 20000000
        } ],
    "capabilities": [ "state-can-change","priority-can-change" ],
    "phase-adjust-min": -2147483648,
    "phase-adjust-max": 2147483647,
    "phase-adjust": 0,
    "fractional-frequency-offset": 3,
    "fractional-frequency-offset-ppt": 3042863,
    "esync-frequency": 0,
    "esync-pulse": 0,
    "parent-device": [ {
            "parent-id": 0,
            "direction": "input",
            "prio": 14,
            "state": "disconnected",
            "phase-offset": 0
        },{
            "parent-id": 1,
            "direction": "input",
            "prio": 14,
            "state": "disconnected",
            "phase-offset": 0
        } ]
}

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 dpll/dpll.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/dpll/dpll.c b/dpll/dpll.c
index 9dc3f8db373d..624567c2a826 100644
--- a/dpll/dpll.c
+++ b/dpll/dpll.c
@@ -1261,8 +1261,11 @@ static void dpll_pin_print_attrs(struct nlattr **tb)
 	DPLL_PR_UINT(tb, DPLL_A_PIN_PHASE_ADJUST_GRAN, "phase-adjust-gran");
 	DPLL_PR_INT(tb, DPLL_A_PIN_PHASE_ADJUST, "phase-adjust");
 
-	DPLL_PR_SINT(tb, DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET,
-		     "fractional-frequency-offset");
+	if (json || !tb[DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT])
+		DPLL_PR_SINT(tb, DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET,
+			     "fractional-frequency-offset");
+	DPLL_PR_SINT(tb, DPLL_A_PIN_FRACTIONAL_FREQUENCY_OFFSET_PPT,
+		     "fractional-frequency-offset-ppt");
 
 	DPLL_PR_U64_FMT(tb, DPLL_A_PIN_ESYNC_FREQUENCY, "esync-frequency",
 			"  esync-frequency: %" PRIu64 " Hz\n");
-- 
2.52.0


