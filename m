Return-Path: <netdev+bounces-259869-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCL+IivmmmnImgMAu9opvQ
	(envelope-from <netdev+bounces-259869-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 12:19:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1599C16EF4D
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 12:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBB033012E9D
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 11:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5A222CBE6;
	Sun, 22 Feb 2026 11:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxxpkEY8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CD41514F8
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 11:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771759141; cv=none; b=tfKmYTqzgxHQdSnSEV3y+7qbscrK7oFBZhO5FYOz2oIjKRLOTedmsiJr8LtyUlt2XeWBvppS6Rc95NeXY44sow/uxqtkgOY/QCcTMwVCYnGmJAdKWV4FtYDYT4TfPW5lvcFwDBAuztRhrV3g96EZxfOoH+WpxCLsRzoMgowr+mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771759141; c=relaxed/simple;
	bh=wpldMA3YF/ASlxPzZrURIJ5XvFFGmSrDWKj35Wv1nIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r7gdc0xvk/QByaot0vcIxwxxxutZ2zxNnd+gDo1K0bKyPSZgiiGPsC9pZk3u4Cdh4dLM21dX0XhbvDkcSbeDmzcYGQihDF2uNLRirgWMsFwT1ZAyjLGjhoXIqzFiBapgAckQlnzOv4T3PX/odj/MvQk9+YFW1yXF4svxRursBT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxxpkEY8; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2bab70f8c8aso3208548eec.1
        for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 03:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771759139; x=1772363939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=42QsmadCxy1ROcAjHdieyR34TL6njWgc3QuJFUWLep4=;
        b=hxxpkEY8W0KafdUv+vPmQH6azp10PIgzfuHm0Ih1Uv5cI24nTNiCD9OAfqgqTIlmHh
         nDUY89T/SrD3K2N73OoYrEB7/TMMe2ZyJ/+etIKyAt8NZHZlPdul1KEdiwNXOVusgXrO
         nO9XBb8J4jLn6HMPmJT2NVj6TwrDTLR8mbbCiNR+VzpvC9dWEegBthavC8q1YagfrFkf
         7BqweQVfI0+r6XB7NWA1bo8kVERFVTYSA7h9oUIYKsBZDsMgh0jqe5LRoXxUKYDNzf8I
         yybmwRb3JWiGa08Fhi3ebz0dL+bV4FZBZjLaBMy6uKcUoifbXMZ+XoZJl4c7FgQoSVtJ
         D5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771759139; x=1772363939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42QsmadCxy1ROcAjHdieyR34TL6njWgc3QuJFUWLep4=;
        b=lakqoxuP29AuZcuOdHQN5n35IBkupJTH0aEL0SyJLpdHKzdwUINsTIhD4XWanUJ/kb
         zRQ1DIMm400DsTe9JBbgIMnfMXQiDIzSohpJkpy7Syw/Bf3xpauRt/HFcrHCAJAcGloi
         ZVOyusJOuOW4rwEZKc0XzE189ua+1YR8ec2axu3HydnqqjxilDvxA29w6+XxWsN7rR+2
         beCNVeB/mZx+1Vb7I5BSbcEondWpPlgSYHToSzfZR4msT2HJtpJ0guoEarhvoqkijDP5
         Anfgg5V29KYvrVU/g0VfZiw7ysgRnFansOx243bp2ldY3SeY2aAU+z4dtwDW8OESjh86
         42zA==
X-Forwarded-Encrypted: i=1; AJvYcCUaxck77JdnTMxQXuBKfWgrUvBU+t5cjpiDyesv4GfqQsSvy4y79HzRDJmPJC6W2RFQr+AH8Ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRQZyM9ApxuiUnhZHwnRagfvyA2CB50KQ7W+y10Ih+WwcuIDe7
	zIvmjPmcaUOHdWuMc/FO3ex4iqAJDRVeUOxoCO3p56+0jmYm5luDlYPA
X-Gm-Gg: AZuq6aKbzNCdDbyCqEJIJwbBFQULg9l3Aty5nLOhhDsNIH8+00woCwEskILjcWyWL9q
	rXvLSomyHnxitepvSGODZvSIdqvtYc6QXMrNeHGE/LlzJZYYcnt1ZLb4MXVB4O++jYzy1ICi3h/
	4L1+Udtw2VwZgIxVABIvhb/6a7OTdUnjmOqv1wjGoPZkjYtV6A5I9bWBS+jDysWzydVn+UlT/Ul
	yn+vL3xq3B7uJk/Xv1Bb4vUQxUp8h4P4QHCmMt5QgonrYVgRM8MoLmoSbvta63mSDjmXAH6o876
	r484zHQvEuQDH/JObpK6qZGJ2xUWlpzQOkSwLHhFgzTjubPDCskwqxc9yR0J2t9KTUR87kNQ8Ti
	BhLwxb6LUXbu26xGLcD8plR8piU4Ncj/LRGdVtpv/Om4O7BdTGTrIJIoLAY8DrMLuzX1jx1R/7y
	UInz2IV/Ck5ve3DHXkxf/DskilQ6wfnbQ2rejIqWlSEUHveFW3KtiLzaErLux5FXEBTbhuAQ8nw
	Rt1g3T+pzH7NlK3hJxSwYI2SXXXNAgvJA==
X-Received: by 2002:a05:7022:e23:b0:11b:9386:826c with SMTP id a92af1059eb24-1276ad8a737mr2512246c88.41.1771759138999;
        Sun, 22 Feb 2026 03:18:58 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1276af9f74bsm4437200c88.15.2026.02.22.03.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 03:18:58 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH 1/2] selftests/harness: fix XFAIL_ADD matching when test metadata is not initialized
Date: Sun, 22 Feb 2026 19:18:46 +0800
Message-ID: <20260222111847.692325-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259869-lists,netdev=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1599C16EF4D
X-Rspamd-Action: no action

XFAIL_ADD() registers expected failures using constructor order, but the
associated struct __test_metadata pointer may not be initialized yet.
As a result, xfail entries can end up with a NULL test pointer and never
match at runtime, causing expected failures to be reported as FAIL.

Store the test case name in the xfail entry and fall back to name-based
matching when the test pointer is unavailable, while keeping the original
pointer-based matching for compatibility.

Fixes: 2709473c9386 ("selftests: kselftest_harness: support using xfail")
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 tools/testing/selftests/kselftest_harness.h | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 16a119a4656c..1082024b2d77 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -860,6 +860,7 @@ struct __test_xfail {
 	struct __fixture_metadata *fixture;
 	struct __fixture_variant_metadata *variant;
 	struct __test_metadata *test;
+	const char *case_name;
 	struct __test_xfail *prev, *next;
 };
 
@@ -873,19 +874,19 @@ struct __test_xfail {
  * to fail. Tests marked this way will report XPASS / XFAIL return codes,
  * instead of PASS / FAIL,and use respective counters.
  */
-#define XFAIL_ADD(fixture_name, variant_name, test_name) \
+#define XFAIL_ADD(fixture_name, variant_name, tc_name) \
 	static struct __test_xfail \
-		_##fixture_name##_##variant_name##_##test_name##_xfail = \
+		_##fixture_name##_##variant_name##_##tc_name##_xfail = \
 	{ \
 		.fixture = &_##fixture_name##_fixture_object, \
 		.variant = &_##fixture_name##_##variant_name##_object, \
 	}; \
 	static void __attribute__((constructor)) \
-		_register_##fixture_name##_##variant_name##_##test_name##_xfail(void) \
+		_register_##fixture_name##_##variant_name##_##tc_name##_xfail(void) \
 	{ \
-		_##fixture_name##_##variant_name##_##test_name##_xfail.test = \
-			_##fixture_name##_##test_name##_object; \
-		__register_xfail(&_##fixture_name##_##variant_name##_##test_name##_xfail); \
+		_##fixture_name##_##variant_name##_##tc_name##_xfail.case_name = \
+			#tc_name; \
+		__register_xfail(&_##fixture_name##_##variant_name##_##tc_name##_xfail); \
 	}
 
 static struct __fixture_metadata *__fixture_list = &_fixture_global;
@@ -1233,7 +1234,10 @@ static void __run_test(struct __fixture_metadata *f,
 
 	/* Check if we're expecting this test to fail */
 	for (xfail = variant->xfails; xfail; xfail = xfail->next)
-		if (xfail->test == t)
+		if (xfail->test == t ||
+		    (!xfail->test &&
+		     xfail->case_name && t->name &&
+		     !strcmp(xfail->case_name, t->name)))
 			break;
 	if (xfail)
 		t->exit_code = __test_passed(t) ? KSFT_XPASS : KSFT_XFAIL;

base-commit: 32a92f8c89326985e05dce8b22d3f0aa07a3e1bd
-- 
2.43.0


