Return-Path: <netdev+bounces-259868-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +K7cK+DSmmlQkQMAu9opvQ
	(envelope-from <netdev+bounces-259868-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 10:56:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C377E16ECD5
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 10:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E638E300B44E
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 09:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADACC221D89;
	Sun, 22 Feb 2026 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRTI++s3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F18D29CEB
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 09:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771754203; cv=none; b=uLdagnbi4BqPnRi2RyPJJwEA+Na87K/D7MCsG0ep+HjjRiMG0QEa150Eo9iIND169a/6Nw3WSQbD67GjffSw8VFdyoZ0UtcuFyUi8xfTSJ0jyHyrgLkyXrUd0vMHRVqweu4yTVrnzzzxwczzpJpRmjCrIF5ktE6AigSG+jaNTmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771754203; c=relaxed/simple;
	bh=mE4O0BtV173/rmaxbBM547I7Ypc4pHP28K3lvpHQstg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XfVOgTxrVpnuYzQwA8caDS+dibDOvgXYFzs9qlJAJjxAWKvO1uo1JSuhc7Ew+xejrpIkb6yKkRBOZwHN4jeVHR/W1Oq19MclHppJJVVzfcORK+4PLrMEdhtYNVOI/cISPxbOTBMPgw4AvaxpQKmoWrtyYmALtmvAp5bbVYvAQnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRTI++s3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a871c8b171so21299145ad.3
        for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 01:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771754201; x=1772359001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=maJ0fqFSfWgbQUTbt8pkn0t5Je6F2vvbc8i45PZOpsQ=;
        b=TRTI++s3CYiq5yWozRp0iOJ6q6mXRpJmd/GT+XJgquYkrQhPIZFgowlu+1vPfjzuO+
         L07qOranodNaLwQzjgiqvZgH0gUM/vgsyr6HOaZof51MzSNwVP1EpzPaa7Op6Ujg2cla
         hih7sFwPm6cWGDefhzrF5G365aaXphBEpbJVpRcA722xrlfqnr4QxScnJe9Ll6/bP9eJ
         lRLB19BabL2JVIyGZXZoc/AVmh9QTuQKS82Hd0C9xzXWjHXvbuBUt5eXqh/V0PXCdn8k
         CgRAEjsRpccm1W7QkB6F/Vu8jtREChQx164M51K2mug/mQSe9dsWMPKg3htRfmHkmX7H
         O+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771754201; x=1772359001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maJ0fqFSfWgbQUTbt8pkn0t5Je6F2vvbc8i45PZOpsQ=;
        b=izZsGhsUH/4OjsefeUGvYymKuHFVjVajlpH7/AVYz5K5D9Qe2Fhg/tyH8F9RC3zKK8
         5uv7ycYWHBowwU1rwrPVmNqZ3xBT+Fct4W2vJDXapyIGMCWFbTbQfigWj5aPhQTxuRN9
         OCMimD4dO+h30yN9gIkuvGGFH1XyvcwvB9qmW+4r4/Cil4jqCGRY7Uo0+ic7W+7tFeka
         LRX+ggEMvMunshq6+vHGFsiNyvXQsccxmjIid+JSTjcGPO6NwXJSgF4UXF3gsKq1OkUV
         h0jfVek94e9PeYJwehc9dM/v6QNmrIe28nvr9HEFrwDpJ1fGk23+HyE91il3vjjSXKb8
         798g==
X-Gm-Message-State: AOJu0Yxbt/aB7Fi6VPQhZLSFaH90xlAxJO8KiuBOexxLYZq5BFyl8XhH
	CSbXxQgcnl4j6lJoh/1Z+XsklS20msvRD82m00oMI9NJY4+KeE8SkYff
X-Gm-Gg: AZuq6aJOAvu13vbcpTQlxikKKtD+kc1QmDmjjcgoEHl9FS8TN6Bn8ZCko4Dz0gWCXa6
	MZKt5J6kUNdiZHo85t8k3kiPAnST6X6YOnfE+oM9OX726aC+HI7v8eTcJOCmOhmnoG68FckwU5h
	mW5le5qe7xH11SAGqCRgpim3GWtGUXqs1S8/cNPGTkHbc7i2RZroD5Cjblw5LvSgkJjbZ4mNz0m
	B09oPnKctYsqr9f9bZ5KYUAE0dDOZDlHOykuiPdPr568/rv6DHrH7IvY3F0qT0CEW73ny4MHZEG
	5Ixe2N+yd5NNj4zy0eFzqPiMDF3fcWzn+rjuoO/hxhSIp2qtwxZeXJmXnTQVH4CYUaACBWbdrCV
	yUsGwOScIyGvIyrBq7cjfNGITTVtvQ40lc/omAhKAu/wvTwrQpAy64v/sOpFaWb/uZ42iT5V/wP
	d9YS6iQ0h8D12MTaveR1cMFKJ+OKrGRqpma77KbzwIRwDIylPBJQaSGj81ww==
X-Received: by 2002:a17:902:e787:b0:2aa:cfee:a47c with SMTP id d9443c01a7336-2ad7456550emr45059005ad.52.1771754200580;
        Sun, 22 Feb 2026 01:56:40 -0800 (PST)
Received: from strange.. ([2405:201:e066:f03e:63d0:17e6:9d20:6b06])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad75054aa3sm43939045ad.89.2026.02.22.01.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 01:56:40 -0800 (PST)
From: mr.navi8680@gmail.com
To: jhs@mojatatu.com,
	jiri@resnulli.us,
	shuah@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Naveen Anandhan <mr.navi8680@gmail.com>
Subject: [PATCH] selftests: tc-testing: preserve list order when removing duplicates
Date: Sun, 22 Feb 2026 15:25:36 +0530
Message-ID: <20260222095536.17371-1-mr.navi8680@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-259868-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrnavi8680@gmail.com,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C377E16ECD5
X-Rspamd-Action: no action

From: Naveen Anandhan <mr.navi8680@gmail.com>

Using set() removes duplicates but breaks ordering.
Test output should be deterministic, so replace with dict.fromkeys().

Signed-off-by: Naveen Anandhan <mr.navi8680@gmail.com>
---
 tools/testing/selftests/tc-testing/tdc_helper.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tdc_helper.py b/tools/testing/selftests/tc-testing/tdc_helper.py
index 0440d252c4c5..e06f03c0fb5d 100644
--- a/tools/testing/selftests/tc-testing/tdc_helper.py
+++ b/tools/testing/selftests/tc-testing/tdc_helper.py
@@ -16,9 +16,9 @@ def get_categorized_testlist(alltests, ucat):
 
 
 def get_unique_item(lst):
-    """ For a list, return a list of the unique items in the list. """
+    """Return unique items while preserving original order."""
     if len(lst) > 1:
-        return list(set(lst))
+        return list(dict.fromkeys(lst))
     else:
         return lst
 
-- 
2.43.0


