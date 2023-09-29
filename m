Return-Path: <netdev+bounces-37139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2EE47B3CE3
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 01:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 80B90282206
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 23:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AD26727C;
	Fri, 29 Sep 2023 23:06:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1AA47369
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 23:06:47 +0000 (UTC)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7FFDD
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 16:06:43 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-278eaffd81dso5321815a91.0
        for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 16:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1696028802; x=1696633602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B9vBj/XqXdCg6y/PwdE6HuNug0gddzTjmPZv3RLwNYM=;
        b=pqLfabI9j1l4W1u/Ihse2TBCqHtdIox3lSEzDUTFrG8POR3nguEAltM9utHv2uExH0
         dFBcvJlmEXsV0SBApVbLoUdNQZ/jG+knnuH6mQuFHW4dB/eGIb1x3m5XkIeflOUvFz18
         07zLvviUlj9k8cxTRyStH0Q3VcQj1sSdU+in/MM8MvMxM21i15wv2aw0OHPo0LOiwGx1
         q05Wj8Wz0/6RtLHnufyzw16z4OKlhA9jHY7KBeVnQ4YZGoSB3wwMkOrUy//amOGiMgzs
         /2TWu2FdUaHZ+Nr3v0oRT7pAnULAOxxKAqWjUc5vbzeYM7EBzXahnX+E4hI0dFqVc/b0
         IqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696028802; x=1696633602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B9vBj/XqXdCg6y/PwdE6HuNug0gddzTjmPZv3RLwNYM=;
        b=KSYNLxnnPi82OGnGaJzrcoICHeB+zkWt6R8txvsnByP/NaM+5cT1w+Mauzc4fGwOW9
         2yu9GC7INBisrSRSf4QAbFfIJ5u5Q10/D4dClxPAbyqxEyTsW0SFceGFD66RS5Kn+DSL
         ucZ6Q0N8333DpH60CvsnzbNYbY9EQv3krNhriuJhvVnmtqKA/syROQrgXkb18SWSQt7i
         ABouvq/37uyjuGsWBrhAPGoGqYaWJgVBUk0HPoekXjNTynMm5ddABCYKeicX2k4zVqlI
         ItS0QoK1SOxal41NLsEztv/JPqazJdFBedIVr4MWvULAe3COwqAILchN3ga09uV0SmKj
         YfDg==
X-Gm-Message-State: AOJu0YwM/5q4WxE8LS+LJTQsQ8umrmDs+aJQjjStb+gwUaq0JfQxJu7L
	oep05+9muMHSDD4xiLe7Z77H45Q1kESvuZTnjC0=
X-Google-Smtp-Source: AGHT+IH5A/RQliYtL/kVU34g5f+iClP+p4egfRuy2AdoqKQlj44nWQfcHyUYlcdxmjWtc90buXCIJw==
X-Received: by 2002:a17:90a:d515:b0:276:c6b8:eaae with SMTP id t21-20020a17090ad51500b00276c6b8eaaemr5236936pju.7.1696028802116;
        Fri, 29 Sep 2023 16:06:42 -0700 (PDT)
Received: from hermes.local (204-195-126-68.wavecable.com. [204.195.126.68])
        by smtp.gmail.com with ESMTPSA id a8-20020a17090a740800b002636e5c224asm1977803pjg.56.2023.09.29.16.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 16:06:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2] Add a security policy
Date: Fri, 29 Sep 2023 16:06:29 -0700
Message-Id: <20230929230629.66868-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Iproute2 security policy is minimal since the security
domain is controlled by the kernel. But it should be documented
before some new security related bug arises at some future time.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 SECURITY.md | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 SECURITY.md

diff --git a/SECURITY.md b/SECURITY.md
new file mode 100644
index 000000000000..d5a7775fc147
--- /dev/null
+++ b/SECURITY.md
@@ -0,0 +1,21 @@
+# Security Policy
+
+## Reporting a vulnerability
+
+The iproute2 suite of utilities is tightly coupled with the Linux
+kernel networking. Therefore the bug reporting process mirrors
+the Linux kernel. Most security problems reported related to
+iproute2 are really Linux kernel issues (a.k.a Shoot the messenger)
+and are best handled via
+[Linux Security Bugs](https://docs.kernel.org/process/security-bugs.html).
+
+For other issues please report bugs to netdev@vger.kernel.org
+and include an example script.
+
+## Supported Versions
+
+There are no official "Long Term Support" versions for iproute2.
+The iproute2 version matches the Linux kernel versions.
+There will be occasional maintenance releases for serious
+issues if found. Users who need support are encouraged
+to use the version of iproute2 found in major distributions.
-- 
2.39.2


