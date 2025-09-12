Return-Path: <netdev+bounces-222645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F62BB55404
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 17:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 585481D6544C
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 15:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37C023C8CD;
	Fri, 12 Sep 2025 15:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="PEpCrSVE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA472DC796
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 15:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691983; cv=none; b=CcS/5NLPGM3ojbfteuwtaAdfVDQ3C69F64gsC0CwlqX2z6b6IURKchswzcd/X/6yLCNF+b3FoH7QpKkBkG15RFqwTWPOJuxFgAuRhdAwQVRoHBqRHHdvW6Kde2VxWSHRwsUAQP2xbJBjAg0XB0VC2fV1OvUEYIV2muhmqBl1kks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691983; c=relaxed/simple;
	bh=aMJa9oZ3pgFQEW5OEDvLDxpyNjF59IWxhaPUdKXbpV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gyvHrXoqJHy+n9IiQUM7lhX6HDNTjiSlL9RCstWyDt94NSV9n33J3XA4+CXlTG+cE7/BncaJHUJZ9kdxtm5g5Q1rRGQKUXlIOY3eqMag4RzYnG5omSMwxQ4pBWoJmApktF7DyNuhIbFyUKLqy92g2WwcIMkpspdwiBHSNv0lxgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=PEpCrSVE; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77616dce48cso562291b3a.0
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 08:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1757691981; x=1758296781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iW4NQ202TOw2a2kO7yB0nznXX0xc1K8o0mtMbmBURsA=;
        b=PEpCrSVEtMfdnbC7IK7Cy5GIuZ24fpSSre1UE00zfX97Rw76hm1eo3qd+D0YpJCQZH
         PSQsieZUZc27Rlzdqsz5bKMLoyi0pbIzxmUZhipLjaUs/7ew+IK9eiKRrPs1v98vryx/
         gw+gL48+v/+q6KSjYPQ8qgvzout0IPJgJK5w7Gs0lSO4b2fee/7eTgBYslECxcblMzuF
         e4yljgvilzq4YsZ+QHnkMkidIplpbqzFSXLCwSJklgjduY02YyPyZWksM2W8MWt1H27/
         SjS3dSd2BLyruPANnktYWAT5HdfmQzmfcFZBtEiTvY6NGRR+Wav7rEgY/mXzPzxvxXNk
         5QUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757691981; x=1758296781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iW4NQ202TOw2a2kO7yB0nznXX0xc1K8o0mtMbmBURsA=;
        b=BxCJffWIy306I588CktA6SsMqGr4uFrsOwY608YtNPFfsn7QY9Qa7Yvr2YPIxrFaCZ
         WRWFhbXQhcv9omTmzxN2oF5nQoWBuZ/miHaN5Qvoj5p+BwddELhzqGC4E7HQLjS4A6Hv
         a0RUmefJNcXK0lAjDrUU93lK9HXboJo/6rnGOxYJOpxSSwSkMv1xjsNqbUN4OprfXn4t
         6qF6L+/5tUzOsOWXfMmDskhwLdDILV2Hye21uJb7cOPrHqpqRieYMgg4amseV4hwE2D9
         miV0awHZoHTBLUAeUoFCWc+vb7q75gz87D9OTIu2oeCyrAfWCxVBtAvk4E5CBrRHBwoM
         wirQ==
X-Gm-Message-State: AOJu0Ywwsiy62LXAviqrnlIzo8+Tz9JaXQM0KMaR+9sS7of8zLDw5Eel
	JaSxFReIsvFmF+/Bj2bDCaEDihmitrRQDlFxTiJgXNsFtZpCS5b8KzMGI0qK4odNlA==
X-Gm-Gg: ASbGncu5aVX6H6NiAE5ggwwKPmsKN5n4OEkPh4GTVKztRhWlBlrY+FTEIONWgrPCHYE
	osOQxyiZbLS8QUUUN3JNcUdAL4WiAfyVNGxFratropBHg4ZAg0bmyXMg5ARu0s7ZWVNqW7ZwItn
	GzB/fc8bIaqKisFNOZHVdRyZxidHT/hBWHG05H/XZ5NWE+53VVK++O8zLdBPGzIYNujhf7iti1H
	Zxuapcx3kjVCD/xhuerwMfvHrwYvm9n/yiRKKsUCAoLbB/duh2wsS01Dc525wvftA+/Qv8iZ4I7
	GwQ/lbtcxHAPokZtTFZj7R5qK2+QLyMCT4Hp7YqKC8xR7Hgtd2xj4m+tocSams9H6YGD+lPlT3a
	PZDfgToVi6xe3kKoGZCNpnHDjXJqRZYqAuIApEYWT+Q3uOAAmR9zZetT/
X-Google-Smtp-Source: AGHT+IF74v5t/pY7dfzcFuCbh2RjfZyzF8cFuBP5XSg1CQUupmj/3eZ4op3W7n6eAsK1n58vv7fBAQ==
X-Received: by 2002:a05:6a00:10d0:b0:76b:dd2e:5b89 with SMTP id d2e1a72fcca58-77612061016mr4715045b3a.6.1757691981407;
        Fri, 12 Sep 2025 08:46:21 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:14d:5c54:6272:8d46:e95e:2df2:85e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607c472ccsm5936822b3a.98.2025.09.12.08.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:46:20 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	jay.vosburgh@canonical.com
Subject: [PATCH net-next] selftests/tc-testing: Adapt tc police action tests for Gb rounding changes
Date: Fri, 12 Sep 2025 12:46:16 -0300
Message-ID: <20250912154616.67489-1-victor@mojatatu.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the tc police action, iproute2 rounds up mtu and burst sizes to a
higher order representation. For example, if the user specifies the default
mtu for a police action instance (4294967295 bytes), iproute2 will output
it as 4096Mb when this action instance is dumped. After Jay's changes [1],
iproute2 will round up to Gb, so 4096Mb becomes 4Gb. With that in mind,
fix police's tc test output so that it works both with the current
iproute2 version and Jay's.

[1] https://lore.kernel.org/netdev/20250907014216.2691844-1-jay.vosburgh@canonical.com/

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 tools/testing/selftests/tc-testing/tc-tests/actions/police.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/actions/police.json b/tools/testing/selftests/tc-testing/tc-tests/actions/police.json
index 5596f4df0e9f..b2cc6ea74450 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/actions/police.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/actions/police.json
@@ -879,7 +879,7 @@
         "cmdUnderTest": "$TC actions add action police pkts_rate 1000 pkts_burst 200 index 1",
         "expExitCode": "0",
         "verifyCmd": "$TC actions ls action police",
-        "matchPattern": "action order [0-9]*:  police 0x1 rate 0bit burst 0b mtu 4096Mb pkts_rate 1000 pkts_burst 200",
+        "matchPattern": "action order [0-9]*:  police 0x1 rate 0bit burst 0b mtu (4Gb|4096Mb) pkts_rate 1000 pkts_burst 200",
         "matchCount": "1",
         "teardown": [
             "$TC actions flush action police"
-- 
2.51.0


