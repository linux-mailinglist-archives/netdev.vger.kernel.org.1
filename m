Return-Path: <netdev+bounces-263489-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNoXEaF5p2kshwAAu9opvQ
	(envelope-from <netdev+bounces-263489-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:15:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB9B1F8C7C
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 01:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EAB0305B45F
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 00:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC3E150997;
	Wed,  4 Mar 2026 00:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="t2LgQyYg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F7C192B75
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 00:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772583234; cv=none; b=JM7p/s8AGD0ZXLeYUFXmlWNqqSTjNSnr7mULiX9ozUVqPqECOMjQb9iQ1zRrlPMEUUwOmpLD0epP88hjAhU6BI2Ee//g0nHJdzRJH1P3VwbTuRsoDjE6Kt67hwwKXgWu2j5Kc2ueX/XEMm3jK2F8L6eINIkcIvGClE+gWuzTDE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772583234; c=relaxed/simple;
	bh=HOHhwBmh2uPy53v9vYBf1CyFA6dYuwZH6rPeBLyJxoA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9hPpZitMyYhdjrtiBCASllP5rPJ4HTBqah5r+YCIkFKTk+Fpcuhxh0qxFaYsz9dA9Ms5omN0/QkWKmJ4Ij5zXEcifEpqpF7JCbQHlq9xWTgZAO2cDfSlYT7OA1HDRmxgObl5Olpa2b5BFhiuRoxOtlL33jsoiBmYp0s5xSywVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=t2LgQyYg; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 623M93xQ2641847
	for <netdev@vger.kernel.org>; Tue, 3 Mar 2026 16:13:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=ilAgVYUcbnyvHN8xc1CxT0q/wlakEkocuZZRC4oY+Bs=; b=t2LgQyYg94oW
	BlbOUhRSVMw9CM1YWl1s9zQ97F1Myca+PwQnaWYlgzNACgtwJfvE6fnAmfw72P4v
	p7vU9GcrSi37woNpGz0FK3o2D6R2rBVK8E0q6jqDIwXURciP/Po48Zv12qAKyq8s
	/baIepFyXv69Md016CC7F/G9nwV317/6QP/u/VP5Ys3SUfZYPGpkYdJeOUaUBaC+
	3wVhMCGsmqGg/Rouh9PnzhIA8AdhO7kRwV8oubcJ60+wkEkA+dtzsyRJqjsT7U8i
	YtmYP8aqIFqowcfTeLrEzpqFAPdZVJV3B86QmsEVY6jxTeS/o9MGZWwdHF5Dif3S
	OwCH9pGT+w==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4cp4knnhx0-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 16:13:52 -0800 (PST)
Received: from twshared108366.16.frc2.facebook.com (2620:10d:c085:108::150d)
 by mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 4 Mar 2026 00:13:45 +0000
Received: by devbig1867.frc2.facebook.com (Postfix, from userid 708122)
	id BE6FD7598FCC; Tue,  3 Mar 2026 16:13:43 -0800 (PST)
From: Wei Wang <weibunny@fb.com>
To: <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Daniel Zahka
	<daniel.zahka@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>
CC: Wei Wang <weibunny@fb.com>
Subject: [PATCH v2 net-next 2/9] selftests/net: Export Netlink class via lib.py
Date: Tue, 3 Mar 2026 16:00:42 -0800
Message-ID: <20260304000050.3366381-3-weibunny@fb.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDAwMCBTYWx0ZWRfX88YLtj7VGMmR
 ZUx55scXpTQaVAWWAhmKk3oYoJF1+Z6q99bcJ8lX2ng0whTN34n1JMIaz41Q5vjyap4bA5p/JI7
 E3gI1Ni1S1youMRjIV12zWLm0uIA2kKhsk/UqJnhumenErEEZrqfATo7wFgyg7I4FQhqQhU13H8
 w8jwQ9K/r+s0PfTte1a/o728TUt6smHEhW7PyRj4eOs5Ghh27zD6m/m3xUc/sys2bTZAKAHnJgs
 /Mluz+gwqj8MDNDPVY+6SyB15XvXtqoQ1sKvX+Sve2XxP5guPkckMmH6Fxvz3uebieMLaZh+VoL
 9UyscfCQMLRldKsD9WhZKsjgrBha8XpIEhY2TrvUkjTrkskTORg0lc7HwUCKTHOtk7QRDWfwcyY
 3oAV9oA9ItZpzrKDsvb1T7bNl0JQXXUl1MO+zh56EMlZdXqI9nI/HLpW4mPnrlm7OAXTJk8sfUE
 +7/xn0M90ND0H1RSgog==
X-Authority-Analysis: v=2.4 cv=WKtyn3sR c=1 sm=1 tr=0 ts=69a77940 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_78whYxrdx1mplLwxq1U:22 a=xKRG0ZNjTxjQNNSMgjIA:9
X-Proofpoint-ORIG-GUID: 1b6vtR5crboprz7jPQhLEteR4MffWBQy
X-Proofpoint-GUID: 1b6vtR5crboprz7jPQhLEteR4MffWBQy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Rspamd-Queue-Id: 9DB9B1F8C7C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fb.com,reject];
	R_DKIM_ALLOW(-0.20)[fb.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
	TAGGED_FROM(0.00)[bounces-263489-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunny@fb.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fb.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: David Wei <dw@davidwei.uk>

Making rtnl newlink calls requires constants defined in Netlink class in
pyynl. Export it.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 tools/testing/selftests/drivers/net/lib/py/__init__.py | 4 ++--
 tools/testing/selftests/net/lib/py/__init__.py         | 4 ++--
 tools/testing/selftests/net/lib/py/ynl.py              | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/too=
ls/testing/selftests/drivers/net/lib/py/__init__.py
index 5872d114f142..e5ef5e949c12 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -19,7 +19,7 @@ try:
     # Import one by one to avoid pylint false positives
     from net.lib.py import NetNS, NetNSEnter, NetdevSimDev
     from net.lib.py import EthtoolFamily, NetdevFamily, NetshaperFamily,=
 \
-        NlError, RtnlFamily, DevlinkFamily, PSPFamily
+        NlError, RtnlFamily, DevlinkFamily, PSPFamily, Netlink
     from net.lib.py import CmdExitFailure
     from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, =
\
         fd_read_timeout, ip, rand_port, rand_ports, wait_port_listen, wa=
it_file
@@ -31,7 +31,7 @@ try:
=20
     __all__ =3D ["NetNS", "NetNSEnter", "NetdevSimDev",
                "EthtoolFamily", "NetdevFamily", "NetshaperFamily",
-               "NlError", "RtnlFamily", "DevlinkFamily", "PSPFamily",
+               "NlError", "RtnlFamily", "DevlinkFamily", "PSPFamily", "N=
etlink",
                "CmdExitFailure",
                "bkg", "cmd", "bpftool", "bpftrace", "defer", "ethtool",
                "fd_read_timeout", "ip", "rand_port", "rand_ports",
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testi=
ng/selftests/net/lib/py/__init__.py
index a584e7f806a4..54e84282781c 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -16,7 +16,7 @@ from .utils import CmdExitFailure, fd_read_timeout, cmd=
, bkg, defer, \
     bpftool, ip, ethtool, bpftrace, rand_port, rand_ports, wait_port_lis=
ten, \
     wait_file, tool
 from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFa=
mily, RtnlAddrFamily
-from .ynl import NetshaperFamily, DevlinkFamily, PSPFamily
+from .ynl import NetshaperFamily, DevlinkFamily, PSPFamily, Netlink
=20
 __all__ =3D ["KSRC",
            "KsftFailEx", "KsftSkipEx", "KsftXfailEx", "ksft_pr", "ksft_e=
q",
@@ -31,4 +31,4 @@ __all__ =3D ["KSRC",
            "NetdevSim", "NetdevSimDev",
            "NetshaperFamily", "DevlinkFamily", "PSPFamily", "NlError",
            "YnlFamily", "EthtoolFamily", "NetdevFamily", "RtnlFamily",
-           "RtnlAddrFamily"]
+           "RtnlAddrFamily", "Netlink"]
diff --git a/tools/testing/selftests/net/lib/py/ynl.py b/tools/testing/se=
lftests/net/lib/py/ynl.py
index 32c223e93b2c..a52b067f7589 100644
--- a/tools/testing/selftests/net/lib/py/ynl.py
+++ b/tools/testing/selftests/net/lib/py/ynl.py
@@ -13,14 +13,14 @@ try:
         SPEC_PATH =3D KSFT_DIR / "net/lib/specs"
=20
         sys.path.append(tools_full_path.as_posix())
-        from net.lib.ynl.pyynl.lib import YnlFamily, NlError
+        from net.lib.ynl.pyynl.lib import YnlFamily, NlError, Netlink
     else:
         # Running in tree
         tools_full_path =3D KSRC / "tools"
         SPEC_PATH =3D KSRC / "Documentation/netlink/specs"
=20
         sys.path.append(tools_full_path.as_posix())
-        from net.ynl.pyynl.lib import YnlFamily, NlError
+        from net.ynl.pyynl.lib import YnlFamily, NlError, Netlink
 except ModuleNotFoundError as e:
     ksft_pr("Failed importing `ynl` library from kernel sources")
     ksft_pr(str(e))
--=20
2.47.3


