Return-Path: <netdev+bounces-52299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6FE7FE31F
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 23:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 252802821AC
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 22:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03823B1B6;
	Wed, 29 Nov 2023 22:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="e3Wfw5lx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D94198B
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 14:24:49 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d01c45ffebso3140825ad.1
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 14:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701296689; x=1701901489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nkjwf60hOQWmCO9wJUuBcwdkxaN20yzfTfsYdyEt6b4=;
        b=e3Wfw5lx9+Z9mcTqPC5ur7+2t/bdm86ClSLUqmv+rk8LfKhOhwEuXIEDWF3bOKv4al
         whUn1CL7QXRq0j1D4cehIZgvLWZcC60Z89YOB1W5pb2C1Nv99rNHuhAKjD2b48TT+Vsq
         5qRojGKwmk4HnimwS1hMK8+vkW6oR1xaJ67S07dAw0sG8HPSdPy0t3H4z4LKUa1l3Zo4
         nw/O6lDOLtrZgx/WH/ogv1Syr6o6CcZFx2IAXughjfXwPnXt5RnXkKeojgdQS780jsK9
         DcOolm3f23uG1ARO26NqSMr6Afof+mk717R8elQDLl8+uMmOdQsXXAAHaVwbtinHJsfQ
         +pwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701296689; x=1701901489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nkjwf60hOQWmCO9wJUuBcwdkxaN20yzfTfsYdyEt6b4=;
        b=Y+m6N1ybMTwTqXwAXig1wqTqWd4PzsDXqBdWfWHo+MKunwIsUicSDYlVrccADKUX2C
         Hz8WHEeYhTe9f6nvV605gNJuwJoaJN9sxestYkKHoaHoHGGZVOIoENiW/tfw22l23YYf
         JUtuvpJo0AJOsb+y2wKW35gQC2t10NPYJtzPj/yLClgh6Lu7rKaMJkXJMqQact5eqku/
         nuj9oTLGdLM9rxfKRIjtDoeTgV9eoeaXjiuxEzKECrfSHNv4HnwNXZXTigaD3581ZeQ+
         xvWk3ljgMD/yM5hu7+/L0xKrgCV93fE2j4al0a+sawciN0zjgHusbFHQa4qhJqGg1BbJ
         w0vA==
X-Gm-Message-State: AOJu0Yz/6ni5K62PORqKBZdYOdBtq0G7+3vm2eocH1wgNseIM3A0C2fb
	09rY3U1RxtM/Bg7in2pegfgancdXKGuGw2U4w5w=
X-Google-Smtp-Source: AGHT+IGpZNbjdUjvjMHf2+Bo0Y2uskqFlYzxCP56cmcZoiUvM/fR6Dh5tXuBNfRJ7dEB7q25WMWekA==
X-Received: by 2002:a17:902:e54b:b0:1ce:6589:d1c0 with SMTP id n11-20020a170902e54b00b001ce6589d1c0mr25126311plf.46.1701296689128;
        Wed, 29 Nov 2023 14:24:49 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id l8-20020a170902f68800b001cfb971edf2sm8663697plg.13.2023.11.29.14.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 14:24:48 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	linux-kselftest@vger.kernel.org,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 1/4] selftests: tc-testing: remove spurious nsPlugin usage
Date: Wed, 29 Nov 2023 19:24:21 -0300
Message-Id: <20231129222424.910148-2-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231129222424.910148-1-pctammela@mojatatu.com>
References: <20231129222424.910148-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tests using DEV2 should not be run in a dedicated net namespace,
and in parallel, as this device cannot be shared.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 .../selftests/tc-testing/tc-tests/filters/tests.json        | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/tests.json b/tools/testing/selftests/tc-testing/tc-tests/filters/tests.json
index 361235ad574b..4598f1d330fe 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/tests.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/tests.json
@@ -48,9 +48,6 @@
             "filter",
             "flower"
         ],
-        "plugins": {
-                "requires": "nsPlugin"
-        },
         "setup": [
             "$TC qdisc add dev $DEV2 ingress",
             "./tdc_batch.py $DEV2 $BATCH_FILE --share_action -n 1000000"
@@ -72,9 +69,6 @@
             "filter",
             "flower"
         ],
-        "plugins": {
-                "requires": "nsPlugin"
-        },
         "setup": [
             "$TC qdisc add dev $DEV2 ingress",
             "$TC filter add dev $DEV2 protocol ip prio 1 ingress flower dst_mac e4:11:22:11:4a:51 src_mac e4:11:22:11:4a:50 ip_proto tcp src_ip 1.1.1.1 dst_ip 2.2.2.2 action drop"
-- 
2.40.1


