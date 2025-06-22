Return-Path: <netdev+bounces-200094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAFEAE31C0
	for <lists+netdev@lfdr.de>; Sun, 22 Jun 2025 21:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4363A3738
	for <lists+netdev@lfdr.de>; Sun, 22 Jun 2025 19:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C011EF38E;
	Sun, 22 Jun 2025 19:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="uV5TrVIc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8031A8F60
	for <netdev@vger.kernel.org>; Sun, 22 Jun 2025 19:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750620077; cv=none; b=nAHbvcTtAXw5hGjPzT/k8Qn+Vc05cepzMphWAydsuWbiruxT0Jk+jEYCMYMskkuaP8adsqE7qP3geqruM0XHK+lHf3FQEGtdh0Bvh+cUa4BeNCsfJa/eBFLtxIrrVqtpmBif6YB0KfTGFfniZPvHFTKfuv/dc/ugX4t1OU98pCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750620077; c=relaxed/simple;
	bh=k9NTIrnCrI7bUhw2SWLSzaSkr8zpxoFxFubHYi9mnFE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JRwW7Ts1OSCwx3p2b6aGip7tykXj5K/f1cn+fE74gIO9yp/ylBgocTpBTOJdxAPU/VrOm6hYW58FLIhE5ibt1NB1BMbGU7j8qIZs0Hx342zLtZGm6Nr++cHlIOeytFlDVxxFgnOVqUs+ugnP79zf7eHGxk/xqV0M7GOnp9mcEt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=uV5TrVIc; arc=none smtp.client-ip=185.70.43.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1750619138; x=1750878338;
	bh=cK6IOooSR3Svzsf6wGJzmcc920rm4hggH9O9N7CTcu4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=uV5TrVIcR5e6LUWXL1eivVBWZvsZwbEKMGvnsWSODp2WDQu5vNAFlYek2OUFxQiIW
	 pEvfzvRUqApFp4Ll84Vwl0wBhowNh0Q1Du36Db9LivlUTGgb9e6dxgX2vq0e5ulBPl
	 cpqOAk1F3UBViPwPWMzqzIAdevUm3qupQhrz7EZO4IP4pwfCSOjdGAR0y3eLlx5PIc
	 Kt0GIzZ/bAcRqrCMltgY1Nkj1qT4KbEQCEFoKFgK71slPWcM5Q1Lus4iNawwbNR+hj
	 uX5Wy8FfX1ruDm+wKFs3IK2+Do7msRmcP4RRJHyO1EGA/gdAWdgUSH2S4frOuBOExu
	 PABTvyC1Qxyzg==
Date: Sun, 22 Jun 2025 19:05:31 +0000
To: netdev@vger.kernel.org
From: William Liu <will@willsroot.io>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, victor@mojatatu.com, pctammela@mojatatu.com, pabeni@redhat.com, kuba@kernel.org, stephen@networkplumber.org, dcaratti@redhat.com, savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, William Liu <will@willsroot.io>
Subject: [PATCH net 2/2] selftests/tc-testing: Add tests for restrictions on netem duplication
Message-ID: <20250622190344.446090-2-will@willsroot.io>
In-Reply-To: <20250622190344.446090-1-will@willsroot.io>
References: <20250622190344.446090-1-will@willsroot.io>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: 009ca6bf8f000a2eec08315dce229911f6ff4396
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ensure that a duplicating netem cannot exist in a tree with other netems
in both qdisc addition and change. This is meant to prevent the soft
lockup and OOM loop scenario discussed in [1].

[1] https://lore.kernel.org/netdev/8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1ilxsE=
BNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=3D@will=
sroot.io/

Signed-off-by: William Liu <will@willsroot.io>
Reviewed-by: Savino Dicanosa <savy@syst3mfailure.io>
---
 .../tc-testing/tc-tests/qdiscs/netem.json     | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json =
b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
index 3c4444961488..e46a97e75f4b 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/netem.json
@@ -336,5 +336,46 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root"
         ]
+    },
+    {
+        "id": "d34d",
+        "name": "NETEM test qdisc duplication restriction in qdisc tree",
+        "category": ["qdisc", "netem"],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set lo up || true",
+            "$TC qdisc add dev lo root handle 1: netem limit 1 duplicate 1=
00%"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev lo parent 1: handle 2: netem ga=
p 1 limit 1 duplicate 100% delay 1us reorder 100%",
+        "expExitCode": "2",
+        "verifyCmd": "$TC -s qdisc show dev lo",
+        "matchPattern": "qdisc netem",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev lo handle 1:0 root"
+        ]
+    },
+    {
+        "id": "b33f",
+        "name": "NETEM test qdisc duplication restriction in qdisc tree in=
 netem_change",
+        "category": ["qdisc", "netem"],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set lo up || true",
+            "$TC qdisc add dev lo root handle 1: netem limit 1",
+            "$TC qdisc add dev lo parent 1: handle 2: netem limit 1"
+        ],
+        "cmdUnderTest": "$TC qdisc change dev lo handle 1: netem duplicate=
 50% || $TC qdisc change dev lo handle 2: netem duplicate 50%",
+        "expExitCode": "2",
+        "verifyCmd": "$TC -s qdisc show dev lo",
+        "matchPattern": "qdisc netem",
+        "matchCount": "2",
+        "teardown": [
+            "$TC qdisc del dev lo handle 1:0 root"
+        ]
     }
 ]
--=20
2.43.0



