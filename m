Return-Path: <netdev+bounces-112607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD6993A217
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 15:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDA50283C5B
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 13:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C13815358A;
	Tue, 23 Jul 2024 13:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSfuI8Gb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9401A13698E
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 13:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721743073; cv=none; b=ewoRxV/xscD50S/LaIb4haveSYGURiVM9MV50WZP9gWvb4Z+yvuZVWv+/WxTQfMSPdqi/EJRk7xURAxRRRzgyWK12JzrmwwnHz1VfWyM6j24JM0TbtMxK1vkw8QNXk/M5dFnEw22d+NGDOrmO0xTKKUzLt1z3MBna39Sx0J/WFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721743073; c=relaxed/simple;
	bh=Htm7bbcrcTmAnhecPl4n5nUHEvT19cnXeqLqaXmGBZk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DTXyfQpYcGsVTmiwXlaTOW6D08fXPxJpnt3uI745a0yQSWD4xAaEYXoCVpglNg8yhT9Nh9ufEbnGQ1oe/SpULMMwVVbP8Rj875qtCfZlDjciavARnSJ1AoNlNRLwL6UEmXX0HLGg1iCMCEpIK8WkFIGIoN73kxSklHeSU8KN/M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSfuI8Gb; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7a1c7857a49so1410480a12.1
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 06:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721743072; x=1722347872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tslxhN0AfZHkPjJg6kQWNl6AEidvpdaO4jAT2B2Dqog=;
        b=JSfuI8GbX8ZXYjcZnYTFZfknqsyw8Qgublx/M8l4SW6iZsUT0LkaS56E9YPKYUILB3
         0a3gsbxAoky+4teC4jRGAlK1ZOWoQzpESHbM5ru3hRBqAPOsndnUw4r9hiWh03GmoNEu
         c8KvblCHV2Yb293k6dR+SGMJ4GD/m+zMur5Wqz3QSGuO5eoId7eTmshONmX3AyBhS2AG
         eLZCHkTXRKU7WzpwSzPQmZECf1azQd+c1+UlM9xCTjWJXznPiZ0SpuykPduLTeWCL4NQ
         aSLTcpijgvmRkT5DUka+gquSfLU6mBuL5c5+ItWF2SZZy28uwPOABh5IEaYAD0lRIdVs
         49Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721743072; x=1722347872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tslxhN0AfZHkPjJg6kQWNl6AEidvpdaO4jAT2B2Dqog=;
        b=dzEF+B+5+TmqgHBktwk5nD4FA3zp15SMoSyEb6yiHJMPsRRgPp35Y4iv73wj/c33U3
         //3CNqFT50pOjcmsKnoZoDtL+BzXOuuccOTDKgvXgAzOBEZr2H5638rCJsGLLCshpfVF
         T2jVKq8NaKP1s8bTpdjkqFh5k8l3vXcHrcrldwnk6l2aqYyZoNm4a/mH8H8OFIuW8rii
         FQntu+rGsCeBK4Lnr0CUEI4xQzGIx7/CXN1CidX4mmVgTO8fUfUdJr2XIxbkLTBxekF7
         x+MC1vdvyNI1jVTvpwql+3F15sS2WtbcVXRVLrd1c8Zp8cul72a7q1KNBboDsmuYcrsI
         MD3A==
X-Gm-Message-State: AOJu0YynmDeZGUVha1rSscWT+JBj3RBOLNMq4ELYNLEF8KcaeriHNhU9
	TT7GdIcXYejju2Vv7xjhTpI/eLmIQMbj5GALhXbJxcltzSUiTZth
X-Google-Smtp-Source: AGHT+IED2cvJJslHT5yoZtSQxhHfTazelZE2VGAFhAreugHS6jAL6GtctMumEbzDbRvdOWpJHMh5kw==
X-Received: by 2002:a05:6a20:3949:b0:1c0:ef24:4125 with SMTP id adf61e73a8af0-1c4228cece5mr9060980637.26.1721743071693;
        Tue, 23 Jul 2024 06:57:51 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([114.253.36.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f295eaesm76760315ad.99.2024.07.23.06.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 06:57:51 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [RFC PATCH net-next] net: add an entry for CONFIG_NET_RX_BUSY_POLL
Date: Tue, 23 Jul 2024 21:57:42 +0800
Message-Id: <20240723135742.35102-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

When I was doing performance test on unix_poll(), I found out that
accessing sk->sk_ll_usec when calling sock_poll()->sk_can_busy_loop()
occupies too much time, which causes around 16% degradation. So I
decided to turn off this config, which cannot be done apparently
before this patch.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
More data not much related if you're interested:
  5.82 │      mov   0x18(%r13),%rdx
  0.03 │      mov   %rsi,%r12
  1.76 │      mov   %rdi,%rbx
       │    sk_can_busy_loop():
  0.50 │      mov   0x104(%rdx),%r14d
 41.30 │      test  %r14d,%r14d
Note: I run 'perf record -e  L1-dcache-load-misses' to diagnose
---
 net/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/Kconfig b/net/Kconfig
index d27d0deac0bf..1f1b793984fe 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -335,8 +335,10 @@ config CGROUP_NET_CLASSID
 	  being used in cls_cgroup and for netfilter matching.
 
 config NET_RX_BUSY_POLL
-	bool
+	bool "Low latency busy poll timeout"
 	default y if !PREEMPT_RT || (PREEMPT_RT && !NETCONSOLE)
+	help
+	  Approximate time in us to spin waiting for packets on the device queue.
 
 config BQL
 	bool
-- 
2.37.3


