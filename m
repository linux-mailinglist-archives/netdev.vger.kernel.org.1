Return-Path: <netdev+bounces-95622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA868C2D9C
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 01:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE10D1C214BB
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 23:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DD24F1F2;
	Fri, 10 May 2024 23:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unstable.cc header.i=a@unstable.cc header.b="J0lxu//r"
X-Original-To: netdev@vger.kernel.org
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484B413D25B
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 23:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.3.242.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715383785; cv=none; b=TspQtV/9WBt7ofa6f/4Kpy6xQfUsFGpGlvtaYatEmE8XgoX9F9c+51I7ioWws4zLL7WvruRkOyyK/PypLLek9rWd62axfZWzNC5iIp/ljO5hqg2dkeQubIs23XG0SDK/nLykLaJ8Y9ToIAt2f1qOH8D0swutstSAtO/3UA8LaPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715383785; c=relaxed/simple;
	bh=Y2hrMTtaGgbmOFyyuMfCTd9+VOT60OILgWJWOdClOcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K4ED3yptr3NHLbvJjHsCcQMzPDtScyoIc6fHSJeSIKHnwt5biIa72i/6GwHepB+jbeLERodkJLv0+OQhosuUFTsdNCJWZf0DGDXQVB7F8TCNsDtpDLQVj3vZ059W1mofXhsN9wvG9bmrYSExo7nWHyQ6EuRlx9uyTfIpsP7VnIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unstable.cc; spf=pass smtp.mailfrom=unstable.cc; dkim=pass (2048-bit key) header.d=unstable.cc header.i=a@unstable.cc header.b=J0lxu//r; arc=none smtp.client-ip=212.3.242.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unstable.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unstable.cc
Received: from smtpauth1.co-bxl (smtpauth1.co-bxl [10.2.0.15])
	by wilbur.contactoffice.com (Postfix) with ESMTP id 3A6D933FD;
	Sat, 11 May 2024 01:21:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1715383288;
	s=20220809-q8oc; d=unstable.cc; i=a@unstable.cc;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding;
	l=1423; bh=hr9wQVtOA52p0p2DIFLfBgFtIR6CZzFY0vvEmSO+yKM=;
	b=J0lxu//rrWoU9Rysh/wkezwkjrRkfHYiFlcgSUstMuq84G+7UVCabYg4/7rUDReq
	z4DBJUB9AlQ5a3Bb8U1QeuRYK3KE+edX6wIqk7LMhbiSRysYRZsnO2iro3wTXECqc33
	MRGM59Li1KfnyQ9iCY+qZ0TP7FybfAZNmJ39xOMjdg5KsXwKDpRl4XRmYol3YJJlAf7
	laHlyTI1LPJLsFOU5WbIGnT+ouUR5N4KzOCiVmWgpi0D6jxULOIrKkYPmRnFzM+nWam
	sIIRnWdbq5AKdzDgkKGO9W+4Sv2+f5y+RvfVFE6zaXLm0wOlhso2cR2HPkxz5QXrG0z
	pGjY7E4HKg==
Received: by smtp.mailfence.com with ESMTPSA ; Sat, 11 May 2024 01:21:26 +0200 (CEST)
From: Antonio Quartulli <a@unstable.cc>
To: donald.hunter@gmail.com
Cc: kuba@kernel.org,
	netdev@vger.kernel.org,
	Antonio Quartulli <a@unstable.cc>
Subject: [PATCH] ynl: ensure exact-len value is resolved
Date: Sat, 11 May 2024 01:22:02 +0200
Message-ID: <20240510232202.24051-1-a@unstable.cc>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-ContactOffice-Account: com:375058688

For type String and Binary we are currently usinig the exact-len
limit value as is without attempting any name resolution.
However, the spec may specify the name of a constant rather than an
actual value, which would result in using the constant name as is
and thus break the policy.

Ensure the limit value is passed to get_limit(), which will always
attempt resolving the name before printing the policy rule.

Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 tools/net/ynl/ynl-gen-c.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index c0b90c104d92..a42d62b23ee0 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -413,7 +413,7 @@ class TypeString(Type):
 
     def _attr_policy(self, policy):
         if 'exact-len' in self.checks:
-            mem = 'NLA_POLICY_EXACT_LEN(' + str(self.checks['exact-len']) + ')'
+            mem = 'NLA_POLICY_EXACT_LEN(' + str(self.get_limit('exact-len')) + ')'
         else:
             mem = '{ .type = ' + policy
             if 'max-len' in self.checks:
@@ -465,7 +465,7 @@ class TypeBinary(Type):
 
     def _attr_policy(self, policy):
         if 'exact-len' in self.checks:
-            mem = 'NLA_POLICY_EXACT_LEN(' + str(self.checks['exact-len']) + ')'
+            mem = 'NLA_POLICY_EXACT_LEN(' + str(self.get_limit('exact-len')) + ')'
         else:
             mem = '{ '
             if len(self.checks) == 1 and 'min-len' in self.checks:
-- 
2.43.2


