Return-Path: <netdev+bounces-34147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB2C7A2566
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 20:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09A9A1C209F8
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 18:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE39C18E36;
	Fri, 15 Sep 2023 18:12:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105FB182CA
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 18:12:52 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F702105
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 11:12:50 -0700 (PDT)
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1694801568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vHAL++FKqwE7PML7eHRqrAxmA7uJje01hAJCXrjPQjA=;
	b=QU1U3O2Ve/nZnfoAT1voPkJQAbf/iPUGr7jj0lSxDoS9Pd6oVd9iiSO+FOBWZS3BpByF0I
	D8QRDxbYTs5VlAtWEAh6qrrOHGwDv8e8P9HCGCNtdFQi8pHUsQrmeWRdHDbETjmojSe/Fn
	67oHX5rulCKC4p241UAtVvWjerMqkkZfZkxwTFHgiNWHV1OH2xiZhiljipJNGYSlKGR08K
	T7kn48Qzx77/DiRa24RvPHPEGD/RUAoSeRVuKswyo4txw2fFPeuOyHzChIMOlOWeudAE7X
	LjiBA0ZvIXdSoz59B98k9XsWabaQaLq+4Cmh7rArSYZxvndlIcssP/TWzoFoCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1694801568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vHAL++FKqwE7PML7eHRqrAxmA7uJje01hAJCXrjPQjA=;
	b=xJvUw3BfPgMQ55JG/YhC0kP1+RA0cg/w04slLoUXuWEjMdYEBsSInDIxaQCAvybwi2vUHJ
	NR91EsuibY3/JzAA==
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Oetken <ennoerlangen@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Lukasz Majewski <lukma@denx.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next 5/5] selftests: hsr: Extend the testsuite to also cover HSRv1.
Date: Fri, 15 Sep 2023 20:10:06 +0200
Message-Id: <20230915181006.2086061-6-bigeasy@linutronix.de>
In-Reply-To: <20230915181006.2086061-1-bigeasy@linutronix.de>
References: <20230915181006.2086061-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The testsuite already has simply tests for HSRv0. The testuite would
have been able to notice the v1 breakage if it was there at the time.

Extend the testsuite to also cover HSRv1.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 tools/testing/selftests/net/hsr/hsr_ping.sh | 23 +++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/hsr/hsr_ping.sh b/tools/testing/se=
lftests/net/hsr/hsr_ping.sh
index d4613b7b71883..1c6457e546257 100755
--- a/tools/testing/selftests/net/hsr/hsr_ping.sh
+++ b/tools/testing/selftests/net/hsr/hsr_ping.sh
@@ -203,7 +203,9 @@ do_complete_ping_test()
=20
 setup_hsr_interfaces()
 {
-	echo "INFO: preparing interfaces."
+	local HSRv=3D"$1"
+
+	echo "INFO: preparing interfaces for HSRv${HSRv}."
 # Three HSR nodes. Each node has one link to each of its neighbour, two li=
nks in total.
 #
 #    ns1eth1 ----- ns2eth1
@@ -219,10 +221,10 @@ setup_hsr_interfaces()
 	ip link add ns1eth2 netns "$ns1" type veth peer name ns3eth1 netns "$ns3"
 	ip link add ns3eth2 netns "$ns3" type veth peer name ns2eth2 netns "$ns2"
=20
-	# HSRv0.
-	ip -net "$ns1" link add name hsr1 type hsr slave1 ns1eth1 slave2 ns1eth2 =
supervision 45 version 0 proto 0
-	ip -net "$ns2" link add name hsr2 type hsr slave1 ns2eth1 slave2 ns2eth2 =
supervision 45 version 0 proto 0
-	ip -net "$ns3" link add name hsr3 type hsr slave1 ns3eth1 slave2 ns3eth2 =
supervision 45 version 0 proto 0
+	# HSRv0/1
+	ip -net "$ns1" link add name hsr1 type hsr slave1 ns1eth1 slave2 ns1eth2 =
supervision 45 version $HSRv proto 0
+	ip -net "$ns2" link add name hsr2 type hsr slave1 ns2eth1 slave2 ns2eth2 =
supervision 45 version $HSRv proto 0
+	ip -net "$ns3" link add name hsr3 type hsr slave1 ns3eth1 slave2 ns3eth2 =
supervision 45 version $HSRv proto 0
=20
 	# IP for HSR
 	ip -net "$ns1" addr add 100.64.0.1/24 dev hsr1
@@ -259,7 +261,16 @@ for i in "$ns1" "$ns2" "$ns3" ;do
 	ip -net $i link set lo up
 done
=20
-setup_hsr_interfaces
+setup_hsr_interfaces 0
+do_complete_ping_test
+cleanup
+
+for i in "$ns1" "$ns2" "$ns3" ;do
+	ip netns add $i || exit $ksft_skip
+	ip -net $i link set lo up
+done
+
+setup_hsr_interfaces 1
 do_complete_ping_test
=20
 exit $ret
--=20
2.40.1


