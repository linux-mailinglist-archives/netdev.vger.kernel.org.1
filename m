Return-Path: <netdev+bounces-176620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5825A6B1A2
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 00:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EC8D188E7DD
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 23:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD3522B8D9;
	Thu, 20 Mar 2025 23:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHh8oKcQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A2E22B8B8
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 23:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513163; cv=none; b=L166zEBDIAnhWI2Hyxk+Uyur1HXS/BCotlTSmJQWsB0mMjv7AfNH5fei2oID0pRJhezlmiG2aIebTEiJEsmLKc4xTIuVcs9mf49i7nhPIFfSXSLbThdlen4MELfDMq0P2mf58oE7ZiyH779u88WArg25zzWAOXyvfa5kFQ+ntQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513163; c=relaxed/simple;
	bh=/1sqmZmhR34/BnGPvqdoNoupFMlj0CxTh/BwTtGaccY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CPVOcgS5TmWGjZm9hDn9Rd6Lt7OhSae4YMGpPKpepfcxeraoxvyZIOHeVptJhd6Hl+9Ns3SmhIbUrHitkTFJw0tz1A58OLpTWkwcK759IgbSV8ARPwtb4Acq4x+2MfkX7SvRUOLYENa9Fmk+79dEZzM20fQ0XLSAIRY3X6mAxjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHh8oKcQ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2264aefc45dso38574535ad.0
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 16:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742513158; x=1743117958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kui4B9TaHJt0XTEqMqW6PZHu/E05QTdnvVauq7ZGjE0=;
        b=aHh8oKcQNRF+t7EZ+RzNPUMoEY1FcZ/o4X01dDCnvGo3yYlatSmV1WbBFetpQxuo25
         4pUUKxm7DEKBewaHvehzfS4leiYRrmG685skrDQXedyksq4VR9s9WJsOC6ii9HlXrfwx
         UUnPChTjZ9L7Z+vg+c9hScSNs06ySjF4DBcPbx4MQI/A7Kg+CGoQOa3Msze6lU7XqEHU
         Bwcojn/N5bgRrPEqDhb3OtmYxZS6eOgOemjLlDzkWbGOO2nuQNKnvwafL6cpNQLZCxO0
         f1BzG+N/5g2DaFH4x3LJxyMtmttfBQf9dPj4vmPkr0zPYw8+uMpcDVpSn+CrFz1/Uuj8
         8j3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742513158; x=1743117958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kui4B9TaHJt0XTEqMqW6PZHu/E05QTdnvVauq7ZGjE0=;
        b=jMYqIrOe2UcFJXZGpXga0RJ/0MmIOgHrZc9AOYwB+XoPWJ/xm62zyW02kE0B9i5X9c
         IlTLHDkRL7KMizzdsfjZTT5kz9kLsyc831/dQkRikC2wniMFsSNrU6MQIDGbMia5SXmX
         PqjcVVtie1tBJ/G7/5oAZ1yBCnLeflzcPm6CR9m5ItC2AjM/JSTQB/TcAXdGtCQgw8kx
         vy9u1iGw2rZU3LgIxP6RaV3wgrcVpoNx8TNwz9lkFXSYISOaJbnCzkR7RaFLV70+6/Ng
         vPdnRUwmDPOsL7NHSM40+kFjvj+LkynO395zSCHM0tfYo2oqefwhNcxvcbc5O+os8UyF
         3f3g==
X-Gm-Message-State: AOJu0Yx7T9Q1U2zI519IQTbl6rcYYy6czHMXG5v76FBt2m0vHHZrph1n
	CQD/EIrqpaZ0/qV7JbaH3AIoSoplydIXuVf6mQuG5NmG9/FaPmIiMOnejbMf
X-Gm-Gg: ASbGncuBbn0qOcr82xisv7QReeoHAjQCHYG2s4yv9X4rOrbwz7w8zyzGBOiUudNtjyL
	ASzgyQnVzYKfOx3k/3a3QqTMCdhKdcsFV0co8eatIMizGLCHXzTM3Y9mLeb4nwilnCIvc0I5wyF
	XSia+40k0QXdceq1gteKkBn2UnPCQ4p3+burQqP+8NU/yA0xqm7L9VPZ7oK6JGXPck9XuqnP2My
	oBbgFoQ+iIQu/FYrgX8tOwcbmq+EDij6FWPMY6LprW/IYB7R7V8ZA/5N4uvzJgSOcc+6rprKeUs
	RiEiglok9lua0EaS9H2hxp/g77pmFa3u/TmC8XYyjwn11jrfqNwcwVY=
X-Google-Smtp-Source: AGHT+IF+D7ABl/mZ6+SktP9HayZ6ulS44gk4hE342AeUnQV9TL+78RXgnPmeuUJRaiS8iBmTEvjBNg==
X-Received: by 2002:a05:6a21:6e47:b0:1f5:95a7:816e with SMTP id adf61e73a8af0-1fe42f9c4b3mr1988152637.23.1742513158060;
        Thu, 20 Mar 2025 16:25:58 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390611ccf8sm416306b3a.120.2025.03.20.16.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 16:25:57 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	edumazet@google.com,
	gerrard.tai@starlabs.sg,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [Patch net 08/12] selftests/tc-testing: Add a test case for CODEL with HTB parent
Date: Thu, 20 Mar 2025 16:25:35 -0700
Message-Id: <20250320232539.486091-8-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250320232539.486091-1-xiyou.wangcong@gmail.com>
References: <20250320232211.485785-1-xiyou.wangcong@gmail.com>
 <20250320232539.486091-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test case for CODEL with HTB parent to verify packet drop
behavior when the queue becomes empty. This helps ensure proper
notification mechanisms between qdiscs.

Note this is best-effort, it is hard to play with those parameters
perfectly to always trigger ->qlen_notify().

Cc: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index 06cb2c3c577e..3ee3197ec7d9 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -157,5 +157,36 @@
             "$TC qdisc del dev $DUMMY handle 1: root",
             "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
         ]
+    },
+    {
+        "id": "a4bd",
+        "name": "Test CODEL with HTB parent - force packet drop with empty queue",
+        "category": [
+            "qdisc",
+            "codel",
+            "htb"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY handle 1: root htb default 10",
+            "$TC class add dev $DUMMY parent 1: classid 1:10 htb rate 1kbit ceil 1kbit burst 1 prio 1",
+            "$TC qdisc add dev $DUMMY parent 1:10 handle 10: codel limit 1 target 0.01ms interval 1ms noecn",
+            "$TC filter add dev $DUMMY parent 1: protocol ip prio 1 u32 match ip protocol 1 0xff flowid 1:10",
+            "ping -c 2 -i 0 -s 1400 -I $DUMMY 10.10.10.1 > /dev/null || true",
+            "sleep 0.5"
+        ],
+        "cmdUnderTest": "$TC -s qdisc show dev $DUMMY",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s qdisc show dev $DUMMY | grep -A 5 'qdisc codel'",
+        "matchPattern": "dropped [1-9][0-9]*",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY handle 1: root",
+            "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
+        ]
     }
 ]
-- 
2.34.1


