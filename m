Return-Path: <netdev+bounces-260275-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sN4RN9fvnGkaMQQAu9opvQ
	(envelope-from <netdev+bounces-260275-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:24:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC08180350
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E828301069B
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 00:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739F7217723;
	Tue, 24 Feb 2026 00:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="7ZG4lmNj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2F91DA62E
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 00:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771892690; cv=none; b=U/Xy7xSSloR7f2ikRouLQeuH8kUIr8GP5ZyBTUv2mfYZVhIu+CKH2ZeSwI0odGL6FaGXt0M4tXIBRZfqzmeD7HIeqVi2FH5oiNLPp1Yu+e62/BLZdM1MiArOXndhUB6f9T2XvqWMVQH9f+pTWWN70bKvceYltY5vJ5FseErYWsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771892690; c=relaxed/simple;
	bh=AgqmDWXkIYwGWN2LxaWIxVKTQffTAu6HkgSVDOvsopM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ElCOp2V8FNFUyXDU6QY/4TTlyPyqt57GZO4dDK7KaMt24RMGa9W8UomT4bsS9yWKBoQxM74DmsqH6sKO6wDCg25DKDFt/k4YwbyHtAXU3Pd9zS5lTvR2R/X3JMv9eaWom9wroqwHWrBRa2jF8yLZnyzwFZZvKV9nmR2CWQ4IQQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=7ZG4lmNj; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NM8bjT3493348
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 16:24:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=I+fD7bnL7kG5Knkml4x6n2FGZnBiq/bWMgUgHRmBpUE=; b=7ZG4lmNjPj3Z
	kf81UR0FjRWZZSPJaTbW+EkzYQhvO8Eel8ygS6CGoTsNeOchmLhzb1Oqp+py4BDn
	u/1rXzcSbM89/alH2fj1MBOr3+55GlSHWjqQdWT8DTzHAnY19Nk8Sa/KWXyHMTA1
	wC9aPKCVxs8TtEh8qypL1+VWBFZUoOI6EcDUms+hs4E339a/AdcboeauCX7MNECj
	X1sZ/Ff/CCu4pWWILvqeWJzI0WnMU6fNtHoR2tH6iJYRatnL2oV/AWTCZ1qfOGJl
	CbIaoAfNa5XvY1fB/xCGyMYeqaePx+C8hFR6KQI/pnejRy+RC4nLFKY51XYd5CBD
	gkJ9EyAmXw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4cgye7h54s-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 16:24:47 -0800 (PST)
Received: from twshared108366.16.frc2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 24 Feb 2026 00:24:45 +0000
Received: by devbig1867.frc2.facebook.com (Postfix, from userid 708122)
	id 0205865F7ED9; Mon, 23 Feb 2026 16:24:38 -0800 (PST)
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
Subject: [PATCH net-next 4/9] selftests/net: Add netkit container ping test
Date: Mon, 23 Feb 2026 16:24:04 -0800
Message-ID: <20260224002410.1553838-5-weibunny@fb.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224002410.1553838-1-weibunny@fb.com>
References: <20260224002410.1553838-1-weibunny@fb.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=GttPO01C c=1 sm=1 tr=0 ts=699cefcf cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=hWMQpYRtAAAA:8 a=_iP7kiItzET_0qtE3S4A:9
 a=KCsI-UfzjElwHeZNREa_:22
X-Proofpoint-GUID: xVOo7OT3M6XCsum6Xemn7fXVTr8z7Ekf
X-Proofpoint-ORIG-GUID: xVOo7OT3M6XCsum6Xemn7fXVTr8z7Ekf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDAwMSBTYWx0ZWRfX+G3u+lOBx8np
 agAMyPIMPFSSaMhcPPW9W+HgLuQV1U4oB/DZRNPbgneKh8alen+lPG2N2srjhppLvVw5D8hB26B
 HNGmTLcWkPFv4XmF0GxRJ/57DmjaTRjyomPxW8i/XY2HWz4UAF9j1zM7CskK6dEm7V8BZlM7Ols
 rUnrub+Dn/MWuKtGL7pzsfdYuk/zfFuYFu5Ps6yUrFDl5mIbaEc0lAX+QUimBebew0OejCmM+Gt
 +2ty+OOlpPENcBjpF4O/By+zhYwEQViFry9xWuNbH74qQgrkQ6EwbasEJ55oFOFq4JeLna0g+9B
 2/8hK6cohhZgvzKEVoRtZWtsbKyx4vAUCpSFEn5gfG6RxhrcP/cfyWg+1zxzRLIJ03W4RirZ9oW
 IKiuLPz6yqEBXqPLklN2E60Q+pBsPsMH/IEM/2AJOUTSoBUrPT549TZHp6rYyUPevcwjYZB5+cI
 jUFbaCIASLzZWSxM3rw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_06,2026-02-23_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fb.com,reject];
	R_DKIM_ALLOW(-0.20)[fb.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
	TAGGED_FROM(0.00)[bounces-260275-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[fb.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunny@fb.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lib.py:url];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0CC08180350
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


