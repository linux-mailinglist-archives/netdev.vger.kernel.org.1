Return-Path: <netdev+bounces-268214-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNjLJLI1uGkDagEAu9opvQ
	(envelope-from <netdev+bounces-268214-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 17:54:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC38A29DB28
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 17:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFA92309B435
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 16:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4C43CEB8F;
	Mon, 16 Mar 2026 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="QtrDs+XG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f99.google.com (mail-wm1-f99.google.com [209.85.128.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD8232548B
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773679784; cv=none; b=PQEIIkkVWHTzk2r4wSL5i6mOyZ3Y0TII7xupRBeHtejZpXX7/K7NZkqbpWFpUHpRMBWBAL+nZD2dFEqRDPJu7lvY8am/bEuFdl2ehbDsi5MJfnyBgnuRP+556qmMFDjDzZOHvFfxjOLV8mgprJcuYZzu+/VYzbZNifG57qcmlUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773679784; c=relaxed/simple;
	bh=KiBVHnyid/175KoQibneA2tjHy3gP6LEhUa0zYra11c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k1nrT9d2cZF2ApP7Cxi2Kdwf30TGT8RviBhG4I1rKbBUOdogC7wJEAvGSB/kwlf3GRxpZdciRMq1V3lS8IB4lIqEr76m0SHTfSXmQLM/4QYC1bMCu82ZEoJHbYGiHHG8bLF9dWdJnLM58sjHv2HY52Bcvh3XT9kH+9s0OUPNlIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=QtrDs+XG; arc=none smtp.client-ip=209.85.128.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f99.google.com with SMTP id 5b1f17b1804b1-48539cbb7b1so28248835e9.3
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 09:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1773679781; x=1774284581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSfZnsUZ5ZrY37SobT5lyXeDO7LsprFFC3V8XppCRdM=;
        b=QtrDs+XGgRfBHqGv3L62ZrtMYgWQbJyZsFBCfokMBNy5tJbXgVyj6yIY5JPzks7m1D
         smjrTGQ95CAthIRkLzBZWOXVtKsgzWQi70y8C0AvUirTfUuC7v2f026z3SdkIs+7iHIq
         AZHxFaU1CJy9s57nMPdrlEIbnPzbI8oF6UKcB6kgHNouenaw2zFnAgWn/45KvCo6YS9K
         YiyRSLFd79nMExodFQpQRz/cCEaI2HeMAyH9w2bhrWDbve7n42p7R7j0qCDkNxyOfM3g
         XrSpZeJXTTVbCHdyxtBlROXeecIgfULVA2OKqnKH5dtNE60RLWXkT0H17zfL6053mnHQ
         ovkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773679781; x=1774284581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BSfZnsUZ5ZrY37SobT5lyXeDO7LsprFFC3V8XppCRdM=;
        b=E2CBsa8ZWjENY267BbMJuM3Ryt6FUoKtFpt3VhhK+05RipH8TPlLo0sCEHa3BW0BPw
         /T9oem4/OkTgynodu+rGG7RbUXf735lOavSHLFg+aaGaAgsClqJLs4WTVkBbP6wZTglU
         mIYrR2lBHeDdw/sud3nCf8j51lFrzbqBiA5L9C61GVcM099poKYGnReHCBOI+Di2YTLu
         n3tgsu41tKbs2ct6MXP/A6aQNINSt58IMnBqLSxVozeYrCdv4pw9dPC/rab/w0kHDHN3
         YT/6M4As5i/1DDQIqQV4FBHG+zDdRkAkQHvHhgU4GhAw5UUBY8qVn37aC+AitiaoE/gN
         Pnfg==
X-Gm-Message-State: AOJu0Yz5+aZ0+J8Sq8wovCHpUPp5xx+9NA5OuSY1bjkOb6oI+fQ5PPbP
	6Xaj5ZnPeqY4Yp1WevJpqnfY5vgIRyL1jUFxkENBn21/wgK5iwCwK3pa7cABd4s1Cw2UXjMYc44
	xztOxeRn+qh6kh2uf3otYSPJJPX2/dD9tBcqU
X-Gm-Gg: ATEYQzwZNe6hbL51SyULhQ0UTafVXnVmqIvImRgIb/g+5laMNNufRBPxNTIMK/26007
	muj29mzgrUmj231uewd/+mnv/nxG4e2iOZekCNLzG64XV0rXNIPmoA9euzMZjQ16pjMaV0yEAc+
	392za8W+t3T+upHeHWGhALrYC9daMAYI5mC1Huxpr1KbSieeDvlCq0qcTDHOo+OS6cgm9Lw3on1
	uAOxF9csSziNCpf7XS+WJdNugmmoJXqsBQGLRY49UDv2JlICr6FGxS8PbYVYGhuSZ9t11y7Kkvd
	HKuBUz9/vu0/l/TsQ2fAsXwCf6ebbYepwrnYcv+bP0EFkXbdFWfD/rk0jOHlbeYzKgPE/B3SWiV
	+88wMHwhuhX9j3bAW8mqY3nf9pcBq5lUqvu5Gkf4TgkpLhCw2j5xg0WcehnudGwVEJxWhCt0wAA
	==
X-Received: by 2002:a05:600c:8b82:b0:483:709e:f239 with SMTP id 5b1f17b1804b1-4855a8d6c53mr215449065e9.22.1773679780865;
        Mon, 16 Mar 2026 09:49:40 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id ffacd0b85a97d-439fe1faf0fsm615780f8f.20.2026.03.16.09.49.40;
        Mon, 16 Mar 2026 09:49:40 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from localhost (kadavar.dev.6wind.com [10.17.1.232])
	by smtpservice.6wind.com (Postfix) with ESMTP id B981719FB7;
	Mon, 16 Mar 2026 17:49:40 +0100 (CET)
From: Justin Iurman <justin.iurman@6wind.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	andrea.mayer@uniroma2.it,
	justin.iurman@gmail.com,
	nicolas.dichtel@6wind.com,
	stefano.salsano@uniroma2.it,
	paolo.lungaroni@uniroma2.it,
	ahabdels@cisco.com,
	Justin Iurman <justin.iurman@6wind.com>
Subject: [PATCH iproute2-next 2/2] man8: update seg6 encap documentation
Date: Mon, 16 Mar 2026 17:49:07 +0100
Message-Id: <20260316164907.1255510-3-justin.iurman@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260316164907.1255510-1-justin.iurman@6wind.com>
References: <20260316164907.1255510-1-justin.iurman@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,uniroma2.it,gmail.com,6wind.com,cisco.com];
	TAGGED_FROM(0.00)[bounces-268214-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.iurman@6wind.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,6wind.com:dkim,6wind.com:email,6wind.com:mid,encap.red:url]
X-Rspamd-Queue-Id: EC38A29DB28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Include "tunsrc" in the man page.

Signed-off-by: Justin Iurman <justin.iurman@6wind.com>
---
 man/man8/ip-route.8.in | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
index aafa6d98a4c2..9f29fd436f59 100644
--- a/man/man8/ip-route.8.in
+++ b/man/man8/ip-route.8.in
@@ -240,7 +240,9 @@ throw " | " unreachable " | " prohibit " | " blackhole " | " nat " ]"
 .IR ENCAP_SEG6 " := "
 .B seg6
 .BR mode " [ "
-.BR encap " | " encap.red " | " inline " | " l2encap " | " l2encap.red " ] "
+.BR encap " | " encap.red " | " inline " | " l2encap " | " l2encap.red " ] ["
+.B tunsrc
+.IR ADDRESS " ]"
 .B segs
 .IR SEGMENTS " [ "
 .B hmac
@@ -893,6 +895,15 @@ applying the reduced segment list. When there is only one segment
 and the HMAC is not present, the SRH is omitted.
 .sp
 
+.B tunsrc
+.I ADDRESS
+- IPv6 address of the tunnel source (outer header), not used with inline mode.
+It is optional: if not provided, the tunnel source address is chosen based on
+the per-netns configuration ("ip sr tunsrc set ADDRESS") or, if not configured,
+it is dynamically resolved. If provided, it takes priority over the per-netns
+configuration and dynamic resolution.
+.sp
+
 .I SEGMENTS
 - List of comma-separated IPv6 addresses
 .sp
-- 
2.39.2


