Return-Path: <netdev+bounces-263493-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CqlDBl6p2kshwAAu9opvQ
	(envelope-from <netdev+bounces-263493-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:17:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8842D1F8CE6
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1F863142A0E
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 00:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C749255F2C;
	Wed,  4 Mar 2026 00:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="bLcA41VL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFA523BF83
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 00:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772583294; cv=none; b=aggEOXFAT+A1UP284VEy4uDSFpBp5sa7x7/GRpJmpxJIYAOtEvWocA+PcU9at/ySGo5vIGjotBadLtbcK1kaqdIhEWbVExm63WiQn4Q5UKUrbFFGgopvjdB++xOLUouHLMt8wIkfvWnCg6D/sBY21a2b0XJPoeR9T/eP2Bchfmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772583294; c=relaxed/simple;
	bh=AgqmDWXkIYwGWN2LxaWIxVKTQffTAu6HkgSVDOvsopM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RArsNg3x/fD5YRfJHakbj1qbH52nvZ2drsw5uzD00T+6xjRe6tQW4EpQdBGXZJ2jih8I9QVWruffnan2aS9JJIIZRRFFssQ897NrDSYp/m3B5rJG3VqGqQZtvRUjQDfWDLvC2xB1xgGSlxF5tC2Tqh9JmvWfqktQ51gqr/W8sxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=bLcA41VL; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623K4YG12733646
	for <netdev@vger.kernel.org>; Tue, 3 Mar 2026 16:14:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=I+fD7bnL7kG5Knkml4x6n2FGZnBiq/bWMgUgHRmBpUE=; b=bLcA41VLSg84
	USxFf/zR0e1tbpvDqQH/rvnLsGxOBk5Go7d3jtBnutOn2PM6F8Hv3HVj3rZrG7Hs
	9Meyzx0qhr5RLBb+mdSrin6e2ybOl9Tcz1OS8USzluTBVoY7jvCRgaOTOE3UwvQl
	vrpwj1AzSdOPh4TL3t57VScihUq1OCXvRd32m0htkAxq41+Lmtp+NVg1NdosU9Ts
	jwISF0VNHWxlFVHejVIKjmtLul61ReyNyvs+vfOtQVDReY0m7D4DHVVgbHI5gFoI
	L73OGDkzJdqQadZtr2C7RzFeFfH+2WcK7E5HcYSLf9s4cIoCMEP/oFXqD7Ll8ulu
	SoM2cDQCpg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4cnmun6cwm-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 16:14:52 -0800 (PST)
Received: from twshared107802.16.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 4 Mar 2026 00:14:17 +0000
Received: by devbig1867.frc2.facebook.com (Postfix, from userid 708122)
	id 987F675991E9; Tue,  3 Mar 2026 16:14:06 -0800 (PST)
From: Wei Wang <weibunny@fb.com>
To: <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Daniel Zahka
	<daniel.zahka@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>
CC: Wei Wang <weibunny@fb.com>, Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH v2 net-next 4/9] selftests/net: Add netkit container ping test
Date: Tue, 3 Mar 2026 16:00:44 -0800
Message-ID: <20260304000050.3366381-5-weibunny@fb.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304000050.3366381-1-weibunny@fb.com>
References: <20260304000050.3366381-1-weibunny@fb.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDAwMCBTYWx0ZWRfX0W4Q3+zMI9Pj
 NxT4IJUgmTQUs7az3/jfGT9zR9PsFY6S/qBKFcqVqJ9e1SjYEqVJHHjcQoUAb3hi3OacLc7bhRZ
 bPIbppqfUTPlsrIagMRBcEEnghC2wBoR0/0B4DbgZnOE+FAb72GLNHoNMkTUcG9BMORNcFz70I/
 IBfTXbCRPcFWsXNzMASLOA4pQmO3ew/J1sK6RxR1P9pSS3TBD9cJHtxjfpT2vQ02CE8l9eAu3di
 T5BHpDD4/onYDLB5vSxeAdn3k1/mBCq90a5tMgHGTgRtT6ADRdHIr17f04+pYD1ghvLwnmsPbNm
 0XSV/n8b7e2aXslnGf1qnlrgkfX8T4F+HW7CFXl7FCvoAJ6IONnRoEQYOzvE+pkYlMDm4VxwCmU
 Klf6kcFb50NtgiO9YxDieb5VRpp2kyYzmU9C4nc50rUul93VXYDDBI4/A8VB/PaeHkeMW4bmov9
 mYPtKsdXptzJMcB9Bpg==
X-Proofpoint-ORIG-GUID: BFZPMe3_C6h4wFstlMl0w9aUJ4oDlVQG
X-Proofpoint-GUID: BFZPMe3_C6h4wFstlMl0w9aUJ4oDlVQG
X-Authority-Analysis: v=2.4 cv=BrGQAIX5 c=1 sm=1 tr=0 ts=69a7797c cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=crHB47gyY4rKiduisYu9:22 a=hWMQpYRtAAAA:8 a=_iP7kiItzET_0qtE3S4A:9
 a=KCsI-UfzjElwHeZNREa_:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Rspamd-Queue-Id: 8842D1F8CE6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fb.com,reject];
	R_DKIM_ALLOW(-0.20)[fb.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
	TAGGED_FROM(0.00)[bounces-263493-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunny@fb.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fb.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: David Wei <dw@davidwei.uk>

Add a basic ping test using NetDrvContEnv that sets up a netkit pair,
with one end in a netns. Use LOCAL_PREFIX_V6 and nk_forward BPF program
to ping from a remote host to the netkit in netns.

Signed-off-by: David Wei <dw@davidwei.uk>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../testing/selftests/drivers/net/hw/Makefile |  1 +
 tools/testing/selftests/drivers/net/hw/config |  3 +++
 .../selftests/drivers/net/hw/nk_netns.py      | 23 +++++++++++++++++++
 3 files changed, 27 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/nk_netns.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/test=
ing/selftests/drivers/net/hw/Makefile
index a64140333a46..91df028abfc0 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -32,6 +32,7 @@ TEST_PROGS =3D \
 	irq.py \
 	loopback.sh \
 	nic_timestamp.py \
+	nk_netns.py \
 	pp_alloc_fail.py \
 	rss_api.py \
 	rss_ctx.py \
diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testin=
g/selftests/drivers/net/hw/config
index 2307aa001be1..b6524040418e 100644
--- a/tools/testing/selftests/drivers/net/hw/config
+++ b/tools/testing/selftests/drivers/net/hw/config
@@ -1,3 +1,4 @@
+CONFIG_BPF_SYSCALL=3Dy
 CONFIG_FAIL_FUNCTION=3Dy
 CONFIG_FAULT_INJECTION=3Dy
 CONFIG_FAULT_INJECTION_DEBUG_FS=3Dy
@@ -5,6 +6,8 @@ CONFIG_FUNCTION_ERROR_INJECTION=3Dy
 CONFIG_IO_URING=3Dy
 CONFIG_IPV6=3Dy
 CONFIG_IPV6_GRE=3Dy
+CONFIG_NETKIT=3Dy
+CONFIG_NET_CLS_BPF=3Dy
 CONFIG_NET_IPGRE=3Dy
 CONFIG_NET_IPGRE_DEMUX=3Dy
 CONFIG_UDMABUF=3Dy
diff --git a/tools/testing/selftests/drivers/net/hw/nk_netns.py b/tools/t=
esting/selftests/drivers/net/hw/nk_netns.py
new file mode 100755
index 000000000000..afa8638195d8
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nk_netns.py
@@ -0,0 +1,23 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+from lib.py import ksft_run, ksft_exit
+from lib.py import NetDrvContEnv
+from lib.py import cmd
+
+
+def test_ping(cfg) -> None:
+    cfg.require_ipver("6")
+
+    cmd(f"ping -c 1 -W5 {cfg.nk_guest_ipv6}", host=3Dcfg.remote)
+    cmd(f"ping -c 1 -W5 {cfg.remote_addr_v['6']}", ns=3Dcfg.netns)
+
+
+def main() -> None:
+    with NetDrvContEnv(__file__) as cfg:
+        ksft_run([test_ping], args=3D(cfg,))
+    ksft_exit()
+
+
+if __name__ =3D=3D "__main__":
+    main()
--=20
2.47.3


