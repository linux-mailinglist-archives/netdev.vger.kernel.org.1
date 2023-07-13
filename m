Return-Path: <netdev+bounces-17591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF52C752367
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 15:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA4311C2132A
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 13:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A6E111B3;
	Thu, 13 Jul 2023 13:20:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAED1094A
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 13:20:59 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCE930C5
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 06:20:49 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-3wzTFMkIM1C2YrMdrEhgpg-1; Thu, 13 Jul 2023 09:20:32 -0400
X-MC-Unique: 3wzTFMkIM1C2YrMdrEhgpg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BBFF588D06C;
	Thu, 13 Jul 2023 13:20:31 +0000 (UTC)
Received: from hog.localdomain (unknown [10.45.224.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C3ADD2166B26;
	Thu, 13 Jul 2023 13:20:30 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	kuba@kernel.org,
	simon.horman@corigine.com,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v3 2/2] selftests: rtnetlink: add MACsec offload tests
Date: Thu, 13 Jul 2023 15:20:24 +0200
Message-Id: <c31ec07ad34e8ed5249e0667e44091332d1d48d4.1689173906.git.sd@queasysnail.net>
In-Reply-To: <cover.1689173906.git.sd@queasysnail.net>
References: <cover.1689173906.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_VALIDITY_RPBL,RDNS_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Like the IPsec offload test, this requires netdevsim.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 tools/testing/selftests/net/rtnetlink.sh | 83 ++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selft=
ests/net/rtnetlink.sh
index ba286d680fd9..488f4964365e 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -21,6 +21,7 @@ ALL_TESTS=3D"
 =09kci_test_vrf
 =09kci_test_encap
 =09kci_test_macsec
+=09kci_test_macsec_offload
 =09kci_test_ipsec
 =09kci_test_ipsec_offload
 =09kci_test_fdb_get
@@ -643,6 +644,88 @@ kci_test_macsec()
 =09echo "PASS: macsec"
 }
=20
+kci_test_macsec_offload()
+{
+=09sysfsd=3D/sys/kernel/debug/netdevsim/netdevsim0/ports/0/
+=09sysfsnet=3D/sys/bus/netdevsim/devices/netdevsim0/net/
+=09probed=3Dfalse
+=09local ret=3D0
+
+=09ip macsec help 2>&1 | grep -q "^Usage: ip macsec"
+=09if [ $? -ne 0 ]; then
+=09=09echo "SKIP: macsec: iproute2 too old"
+=09=09return $ksft_skip
+=09fi
+
+=09# setup netdevsim since dummydev doesn't have offload support
+=09if [ ! -w /sys/bus/netdevsim/new_device ] ; then
+=09=09modprobe -q netdevsim
+=09=09check_err $?
+=09=09if [ $ret -ne 0 ]; then
+=09=09=09echo "SKIP: macsec_offload can't load netdevsim"
+=09=09=09return $ksft_skip
+=09=09fi
+=09=09probed=3Dtrue
+=09fi
+
+=09echo "0" > /sys/bus/netdevsim/new_device
+=09while [ ! -d $sysfsnet ] ; do :; done
+=09udevadm settle
+=09dev=3D`ls $sysfsnet`
+
+=09ip link set $dev up
+=09if [ ! -d $sysfsd ] ; then
+=09=09echo "FAIL: macsec_offload can't create device $dev"
+=09=09return 1
+=09fi
+
+=09ethtool -k $dev | grep -q 'macsec-hw-offload: on'
+=09if [ $? -eq 1 ] ; then
+=09=09echo "FAIL: macsec_offload netdevsim doesn't support MACsec offload"
+=09=09return 1
+=09fi
+
+=09ip link add link $dev kci_macsec1 type macsec port 4 offload mac
+=09check_err $?
+
+=09ip link add link $dev kci_macsec2 type macsec address "aa:bb:cc:dd:ee:f=
f" port 5 offload mac
+=09check_err $?
+
+=09ip link add link $dev kci_macsec3 type macsec sci abbacdde01020304 offl=
oad mac
+=09check_err $?
+
+=09ip link add link $dev kci_macsec4 type macsec port 8 offload mac 2> /de=
v/null
+=09check_fail $?
+
+=09msname=3Dkci_macsec1
+
+=09ip macsec add "$msname" tx sa 0 pn 1024 on key 01 123456789012345678901=
23456789012
+=09check_err $?
+
+=09ip macsec add "$msname" rx port 1234 address "1c:ed:de:ad:be:ef"
+=09check_err $?
+
+=09ip macsec add "$msname" rx port 1234 address "1c:ed:de:ad:be:ef" sa 0 p=
n 1 on \
+=09=09key 00 0123456789abcdef0123456789abcdef
+=09check_err $?
+
+=09ip macsec add "$msname" rx port 1235 address "1c:ed:de:ad:be:ef" 2> /de=
v/null
+=09check_fail $?
+
+=09# clean up any leftovers
+=09for msdev in kci_macsec{1,2,3,4} ; do
+=09    ip link del $msdev 2> /dev/null
+=09done
+=09echo 0 > /sys/bus/netdevsim/del_device
+=09$probed && rmmod netdevsim
+
+=09if [ $ret -ne 0 ]; then
+=09=09echo "FAIL: macsec_offload"
+=09=09return 1
+=09fi
+=09echo "PASS: macsec_offload"
+}
+
 #-------------------------------------------------------------------
 # Example commands
 #   ip x s add proto esp src 14.0.0.52 dst 14.0.0.70 \
--=20
2.40.1


