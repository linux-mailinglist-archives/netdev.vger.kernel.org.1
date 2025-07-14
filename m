Return-Path: <netdev+bounces-206504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AA8B034DC
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 05:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97C047A4734
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 03:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6661B1D7E5C;
	Mon, 14 Jul 2025 03:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b="eoddhjHW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-24420.protonmail.ch (mail-24420.protonmail.ch [109.224.244.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8AF35942
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 03:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752462882; cv=none; b=I0IhYjyou7nXEyxjvRpSag0qJVih0o6XlE49FdvzJgI8YNlhpMeO+IhVXbMjXUtTEqZmRE1ECCfn7GLJaXexlHErXFij5dh6weKt6odt1CVO1W0QNKPUPLlrSbKwKbaQTPUpLB5QuOnK3mF1qzCeob/1D+Ll+kkzbxluCa8150g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752462882; c=relaxed/simple;
	bh=7wMC7ZoJjRNhPLALAbMzT6ORkse0Ucwz10mYA33Lp1s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pN5i0pORkZfxJt0GKSCE/AfObDx0kTuBXF1okoKm3ehUhsdIFr+E0nRMG2XlPNSzwY1aP8qW+2RfKJFlLNM8LJlfMWxD2fh0VHsfe+bR0YoVjiEM1oldbWYasxsf0YvLDBognreg+8qv8k2xz1kN6X3GxgYY81uQZ1UykKIzqgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io; spf=pass smtp.mailfrom=willsroot.io; dkim=pass (2048-bit key) header.d=willsroot.io header.i=@willsroot.io header.b=eoddhjHW; arc=none smtp.client-ip=109.224.244.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=willsroot.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=willsroot.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=willsroot.io;
	s=protonmail; t=1752462871; x=1752722071;
	bh=MWGGflju3eJtko5ad2yQmpw/fJ7RjW31tQiOiWayMro=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=eoddhjHWsEw4sEFI4KLDC+f+FiPWAs+TR42Db+JrU5DNnYAmue3HVyf/IvZ4c8KQl
	 fQgTB9pd749elku6HvixreN84qVSznBxa891yImnGJieseZpZyqHHF7214ezaADWi9
	 CTQz1AFl/F8hCYfOMO25CMt8rhI1d1v0vSU8K9lCDNrPPPdTbnBmN2HMTpUV6dg1fD
	 aoO7m52F03uhzr7eGRvAyifVDo1KaMWJHb7AAnUALLyVik1fHix2EDdpE0zbakEdRR
	 MZxcsxTiqc1BN8WtAdDBJYtnTAE846QnbItVyYdOl4070nGx4tlf5i+RF1NNEXH2oi
	 W4g3yGQHRGTlA==
Date: Mon, 14 Jul 2025 03:14:25 +0000
To: netdev@vger.kernel.org
From: William Liu <will@willsroot.io>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, pabeni@redhat.com, kuba@kernel.org, savy@syst3mfailure.io, jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, horms@kernel.org, William Liu <will@willsroot.io>
Subject: [PATCH net 2/2] selftests/tc-testing: Test htb_dequeue_tree with deactivation and row emptying
Message-ID: <20250714031413.76259-1-will@willsroot.io>
In-Reply-To: <20250714031238.76077-1-will@willsroot.io>
References: <20250714031238.76077-1-will@willsroot.io>
Feedback-ID: 42723359:user:proton
X-Pm-Message-ID: a26a658e40de69736693aa1898c5cd3ebc62f977
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ensure that any deactivation and row emptying that occurs
during htb_dequeue_tree does not cause a kernel panic.
This scenario originally triggered a kernel BUG_ON, and
we are checking for a graceful fail now.

Signed-off-by: William Liu <will@willsroot.io>
Signed-off-by: Savino Dicanosa <savy@syst3mfailure.io>
---
 .../tc-testing/tc-tests/infra/qdiscs.json     | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json =
b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index 5c6851e8d311..a8b58ffd8404 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -672,5 +672,31 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY root handle 1: drr"
         ]
+    },
+    {
+        "id": "5456",
+        "name": "Test htb_dequeue_tree with deactivation and row emptying"=
,
+        "category": [
+            "qdisc",
+            "htb"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.11.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY root handle 1: htb default 1",
+            "$TC class add dev $DUMMY parent 1: classid 1:1 htb rate 64bit=
 ",
+            "$TC qdisc add dev $DUMMY parent 1:1 handle 2: netem",
+            "$TC qdisc add dev $DUMMY parent 2:1 handle 3: blackhole"
+        ],
+        "cmdUnderTest": "ping -c1 -W0.01 -I $DUMMY 10.10.11.11",
+        "expExitCode": "1",
+        "verifyCmd": "$TC -j qdisc show dev $DUMMY",
+        "matchJSON": [],
+        "teardown": [
+            "$TC qdisc del dev $DUMMY root"
+        ]
     }
 ]
--=20
2.43.0



