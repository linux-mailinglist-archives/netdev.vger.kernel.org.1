Return-Path: <netdev+bounces-240261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F3830C71FD5
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 04:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE76F4E3DE5
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 03:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271112C15AE;
	Thu, 20 Nov 2025 03:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="SiJTE7SN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0D717BA1
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 03:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763609422; cv=none; b=gFNvixWwYZPc52ZfJa3eB//eonf/eGDXY7xJljFyKG2ltvznNHZW7147Wa1xTipf3PcG06GAKjK5f7oCxdc9nybg7//J5GUO8K2L1x23inKzK+VeoZIec7l8nZ51wuFaV8ZhhwZjuPZHThKye01asYwakos0OSethPjtwLKPicA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763609422; c=relaxed/simple;
	bh=PAATiqi3UKhKZ+HqavPuhnlh9ijEDEj+1KYd+/Qhusg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0jaBPziMDAoj0JVaFrdPx+mGXraEmhAeQN18cQNtvHIDtpW4UqO6WWyvS4L8KbiA7x3TiGRtr5sapB0Z1ERoLPR9M3BETd1V+xHEqvkhMM7/4WIQNwOvNJJ6mnuwbHmc879nlUc2LY5tzDqGcWVp4RfzH3X2xa2mnCnUgcEqDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=SiJTE7SN; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7c6da5e3353so314480a34.3
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 19:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1763609419; x=1764214219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyvn6/lp4QcS2i59sxPm3qxXA9YF0xAQWyQ1vGU4RKE=;
        b=SiJTE7SNoBXAmULjfcLK1JcPxDWGr0EzCO6/kttHDBLS2v1kBNX7PdxY6Wxh5dKkio
         vCMy1GiDEUbMlivTfB1ZDFfvbCc7mF6kLHtAI3SJSbr8XLN2rMWMMES+CPMzRH84vySr
         ltGvqyMO+aGzomSpm+kDy594TMcS3AYjokhr6Viw4xN+QrR0xs2tep32/6cUkgAe+9JZ
         DfE1qjEIedg0DJ86vjnrqwA6pyTCJmrxIw51WDsDj3kRnSoAi0n9XgjhLxkBTnZXrxtp
         TAIDwFavN9ow5KsfmqA66Qklkwes+DcFf+r3u2g8oEw+RNxcUKAdSGvjiDMWXYGhmA+N
         qIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763609419; x=1764214219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eyvn6/lp4QcS2i59sxPm3qxXA9YF0xAQWyQ1vGU4RKE=;
        b=Q/8mFOmg7bMTLh1JgNP51zv3cn/t5Dww3nMf/2PCIrlOwCSfEweVerpkYyHBIrfpuZ
         IzdpfEHphDUjcoVYhg2QSrNpaVIVsjERPJaZ4/qXYFIvY5rbc74omd0rHPBqDfEyc4nO
         828eQXSAQlNaQib9H9tGo7QVIewQ+9j914wBx8+suwrX+9yRi/0JgMdYGe9nYltWJB+0
         HSxzGDB4G9gTY4EMUaQM5Pbenf04hlpfgPUmh9TwKY4pnU2Agrjx/OJQTlXJrGRrzlTt
         f4k4pf8QLOopIh/C75y0DSw+no6u8xtxfCalXwnXUqWZzElE61MOd+aqo5vgLIisWoSv
         49rA==
X-Gm-Message-State: AOJu0YzIonBGejJjVCsiBwExKsfy+2+qy4xIVUXOwF8xD34UoQa1VR62
	filj26O2ztm0sTiH+PUs8k7L4OMfQPlkQwaPzHAZ/E96bYlcokRy2KzplPeXboI8Ky3gUeOxgE7
	hWstW
X-Gm-Gg: ASbGncu5NdrWBuyfjV3MQclLQvQYIzECsWZWD2yUKn7dXIay1horhD4Qsg2inRW1ta6
	IFH+06E9ahYhye0bkAkhgL2SWhiMf+GSDVLudOwYx6VRo5EsQKI+VJl75ho2g/VcoMhxTwgzvQX
	xcmXoL8U8FVCdRhjf9/sGXzH7HhClchorVDKmZpi18SX5BuHWGlSKBvEOpS3fkbz51kcgKIeo+U
	JzKRQrhHJc+0bnh91PtkQmSD2j6I+ARO8lz1f+tYaWxSk4J+o3h6hDW9LTJZah0hRTxc4O6wteK
	Oz/F/LnXeBscYiurmlnPOwdKBOGnn70bbSrZjCDhZR7lQDECcSve26BgkEyj4OgITK/nzYQg5TH
	RqKLp/myIa2gUEf9dUL6Dp8bEwOhmPBMJke6MnddUloAV7TST21O/19U8YN/fBlxu+X6bWSYaLQ
	9p5SczkMx5G193LJ2WXvmcXxwfP7oKIETRg7tjtLWAUA==
X-Google-Smtp-Source: AGHT+IE/oMBeWhkU25csovul9F5yXj4EGxHBUJRPFJGUF1n8JMWzH6k8uEkbjff4SQc87v3c/JC7PA==
X-Received: by 2002:a05:6830:6619:b0:7c7:5f79:40ca with SMTP id 46e09a7af769-7c78d2e147fmr995319a34.29.1763609419495;
        Wed, 19 Nov 2025 19:30:19 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:71::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65782a52997sm472620eaf.5.2025.11.19.19.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 19:30:19 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH net-next v1 1/7] selftests/net: add suffix to ksft_run
Date: Wed, 19 Nov 2025 19:30:10 -0800
Message-ID: <20251120033016.3809474-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251120033016.3809474-1-dw@davidwei.uk>
References: <20251120033016.3809474-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I want to run the same test cases in slightly different environments
(single queue vs RSS context). Add a suffix to ksft_run so it the
different runs have different names.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 tools/testing/selftests/net/lib/py/ksft.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 83b1574f7719..e364db7a69f7 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -136,7 +136,7 @@ def ksft_busy_wait(cond, sleep=0.005, deadline=1, comment=""):
         time.sleep(sleep)
 
 
-def ktap_result(ok, cnt=1, case="", comment=""):
+def ktap_result(ok, cnt=1, case="", comment="", case_sfx=""):
     global KSFT_RESULT_ALL
     KSFT_RESULT_ALL = KSFT_RESULT_ALL and ok
 
@@ -147,7 +147,7 @@ def ktap_result(ok, cnt=1, case="", comment=""):
     res += str(cnt) + " "
     res += KSFT_MAIN_NAME
     if case:
-        res += "." + str(case.__name__)
+        res += "." + str(case.__name__) + case_sfx
     if comment:
         res += " # " + comment
     print(res, flush=True)
@@ -220,7 +220,7 @@ def _ksft_intr(signum, frame):
         ksft_pr(f"Ignoring SIGTERM (cnt: {term_cnt}), already exiting...")
 
 
-def ksft_run(cases=None, globs=None, case_pfx=None, args=()):
+def ksft_run(cases=None, globs=None, case_pfx=None, args=(), case_sfx=""):
     cases = cases or []
 
     if globs and case_pfx:
@@ -273,7 +273,7 @@ def ksft_run(cases=None, globs=None, case_pfx=None, args=()):
         if not cnt_key:
             cnt_key = 'pass' if KSFT_RESULT else 'fail'
 
-        ktap_result(KSFT_RESULT, cnt, case, comment=comment)
+        ktap_result(KSFT_RESULT, cnt, case, comment=comment, case_sfx=case_sfx)
         totals[cnt_key] += 1
 
         if stop:
-- 
2.47.3


