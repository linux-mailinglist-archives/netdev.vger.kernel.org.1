Return-Path: <netdev+bounces-260891-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJ8cJuDZnmkTXgQAu9opvQ
	(envelope-from <netdev+bounces-260891-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 12:15:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EA319650E
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 12:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E27F430160C9
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E42393DCA;
	Wed, 25 Feb 2026 11:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNgDjIEB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D5D393DDE
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 11:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772018138; cv=none; b=eRT6fMsiN4eYZxOuUZpy2grH6HCVCeXt6efHtR0kFtgrbLjt4pDWfPjpMVXUnXqYJsvQ7rHw5wjFh8Cak985dXvby7z/zj4zN7wbCsD8XFsKzfjZIyDXE8OKx193adlF41CysQGQhTrMIVNBam9lP57DQrZXQ1UpyxzUwh6Saw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772018138; c=relaxed/simple;
	bh=ngMIJOMRnJXLYEUhjLgmW0+cnyNeco/cgTA/LjKrN4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GhhcPpGXYbqgjyn+wPQT2WxAA/1rUU/MUBZ4BUuxBX+/FXcxo4kulV/plaCOdxIx2nt/U7F5FVAxPNwWDUJmE/ydcicWfc+cM8AsxUY9TtejIwsddjlUDHcxo9bjwZfWfrGJH1w4kzDn+a5YUWboFQ7cYIpBoWvwPRELqX2/EO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LNgDjIEB; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-45f09874c4cso4066297b6e.3
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 03:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772018135; x=1772622935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KCzNXohVpDD6xCDz15ty9eD9uNVVw6l0koWlP3YqGoU=;
        b=LNgDjIEBXWQKdyfrrBOX6MDFztAyhCSz2+giXWVQQI+OXmd7i0rn7K4/S47DIKNW/f
         0Yu6tH0b9b6lV+4Xmf+GLHIoZfvbPyf+30MJlefV2rPaKGQ6jKM2VNIPPZWg9hNNqmH/
         7S2487M9WNwlcVOIemMGOGv3wfUNQWcIvPqC5YesMd6os6FfSiUNEUf99okfuHqN+2Ty
         x7GSc8DC9ePaXrArAE6QsEzimO8krOD/eeV6Iq0R1dT6UrxxjuQ1lfE4UdQR8dQykunZ
         96WH3D816IGtBDUMtRsZNVRQIYYjsqCrMcfKtjxo/0+7C/FR5/r1GFK1CqehxCWenJSR
         qWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772018135; x=1772622935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCzNXohVpDD6xCDz15ty9eD9uNVVw6l0koWlP3YqGoU=;
        b=s8IS6lQBeI7Xly1ne2FHSw0LGCD8fXPE0IEAcs/I3nXNIDm4d4OXY3xnlnSRv57//p
         W+UsvqiUFVp97o1Ury9Er9lydy3DGovoDUxwG2ZPdGoCfozlR8yCfYBY26RVBZ0fLIv4
         GJvYuhLiC7vUCIyVYVjIJZ+VDmH3MB6vu8M5CgQht/7UIUJ/s1mzKbwhk4qBoJgIC3W4
         k1swtUmgx2vrrnpKSw5aPHbknLw8+m+JHKqMPVP4DibpdZjhy+h1AGtZ86MKbMxCEgji
         18bbbGYctP6NdmpzVqOQmdwpPHFi0F7czksS2wWEQlGLVyR46ly/70qqebwYINrMZqiN
         5pMg==
X-Forwarded-Encrypted: i=1; AJvYcCXrfF38hC+9eekMdhaTgXf+87cetQCV3HcNglXmuhlONkZGJT/8rXwZUkrdaoJ48kA44+82sOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSb6hkrlc885k3v2f8V79n9sV0ORPP2AbGWl+xTiY05i4NIcoN
	QPR9dd2EBuPp7bgwyJZ++Lh8N16YsAwqkSOGEwvJaotTR8OpiphicyLg
X-Gm-Gg: ATEYQzzdQT3pUdK8/PbxDyILiElQcvqq7RGiLmgGlJl644J45Dht7cmwxiIsKfiZoCg
	m1s0eV+jXUDZzWFyPrkigMiSo/jQvMD4ham4nQ1UP2APR+dhtvBbQMu8+jQdAe9AxEiu6hj3NNa
	K1Dpaak/KOO+YsCp2x1+LJiM2F+RwFUrFUFcKw9nitzsKLUPWPJm0fg0otD7MzO1n/4QLTfsqbC
	5On0h3VXKfAtA9PnUkCt124VormzoUAN4uDuseALUZaIhxodBC+zhEu6VgNFMAxd7XFGXC6wxrp
	ZVJem0WoprI5LnYaIe68gvZKPX9G5X8cv1akpRD5QbHkiCAZa1iihsiKCrqUnRm1hC+pzkoTKBX
	Z+i/4fshWwF9Q2H16V8Ti/wLORYdFLR+/jzQ0bs755Qlj9WP7FH4Ia7hygNMDy8HBRNkU/crgfz
	eu2NTL64yy/pdgGF7/E4P/SvoH4zimaiyvG9yJDlUBEBeqEUgbqjPQYLnQCUYtQte9lHIJgQWqr
	KGSJxq5jtxzmpoPaRFY61M=
X-Received: by 2002:a05:6870:328f:b0:409:61b0:fd28 with SMTP id 586e51a60fabf-4157b1ccb7fmr9403756fac.46.1772018135281;
        Wed, 25 Feb 2026 03:15:35 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4157d34a224sm13053927fac.17.2026.02.25.03.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 03:15:34 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: Shuah Khan <shuah@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Cc: linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH v3 v3 1/2] selftests/harness: order TEST_F and XFAIL_ADD constructors
Date: Wed, 25 Feb 2026 19:14:50 +0800
Message-ID: <20260225111451.347923-1-sun.jian.kdev@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-260891-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,google.com,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 04EA319650E
X-Rspamd-Action: no action

TEST_F() allocates and registers its struct __test_metadata via mmap()
inside its constructor, and only then assigns the
_##fixture_##test##_object pointer.

XFAIL_ADD() runs in a constructor too and reads
_##fixture_##test##_object to initialize xfail->test. If XFAIL_ADD runs
first, xfail->test can be NULL and the expected failure will be reported
as FAIL.

Use constructor priorities to ensure TEST_F registration runs before
XFAIL_ADD, without adding extra state or runtime lookups.

Fixes: 2709473c9386 ("selftests: kselftest_harness: support using xfail")
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
v3:
  - Move KSELFTEST_PRIO_* definitions above the TEST_SIGNAL() kdoc block.

v2:
  - Drop the lazy string-matching approach.
  - Use constructor priorities to enforce initialization order.
  Link:
    https://lore.kernel.org/all/20260224113859.12345-1-sun.jian.kdev@gmail.com/

v1:
  Link:
    https://lore.kernel.org/all/20260222111846.12345-1-sun.jian.kdev@gmail.com/
---
 tools/testing/selftests/kselftest_harness.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 16a119a4656c..4afaef01c22e 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -76,6 +76,9 @@ static inline void __kselftest_memset_safe(void *s, int c, size_t n)
 		memset(s, c, n);
 }
 
+#define KSELFTEST_PRIO_TEST_F  20000
+#define KSELFTEST_PRIO_XFAIL   20001
+
 #define TEST_TIMEOUT_DEFAULT 30
 
 /* Utilities exposed to the test definitions */
@@ -465,7 +468,7 @@ static inline void __kselftest_memset_safe(void *s, int c, size_t n)
 			fixture_name##_teardown(_metadata, self, variant); \
 	} \
 	static struct __test_metadata *_##fixture_name##_##test_name##_object; \
-	static void __attribute__((constructor)) \
+	static void __attribute__((constructor(KSELFTEST_PRIO_TEST_F))) \
 			_register_##fixture_name##_##test_name(void) \
 	{ \
 		struct __test_metadata *object = mmap(NULL, sizeof(*object), \
@@ -880,7 +883,7 @@ struct __test_xfail {
 		.fixture = &_##fixture_name##_fixture_object, \
 		.variant = &_##fixture_name##_##variant_name##_object, \
 	}; \
-	static void __attribute__((constructor)) \
+	static void __attribute__((constructor(KSELFTEST_PRIO_XFAIL))) \
 		_register_##fixture_name##_##variant_name##_##test_name##_xfail(void) \
 	{ \
 		_##fixture_name##_##variant_name##_##test_name##_xfail.test = \

base-commit: 7dff99b354601dd01829e1511711846e04340a69
-- 
2.43.0


