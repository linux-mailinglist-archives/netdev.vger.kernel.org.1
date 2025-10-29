Return-Path: <netdev+bounces-233881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2E1C19EC7
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 12:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29DCF3AAD13
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 11:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD40B2E62C3;
	Wed, 29 Oct 2025 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="1AKW0ske";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="geV90Pcl"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443C81E0DD8
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761735992; cv=none; b=LA9rH7iHVM+LLK0Pc7CSbbi43UYKa7XLlp2gE04zIY9uMEi1+YFVmqJewq7aZ02TsWwrMnRwrWIMbhygh2Z/J2TTJZnSLI6BaJ1DbJ7BY9HVXyq1k6vHl9VcJ7HCBEdo3c7iZg46WBr3ZSdh4H7K3j99UjcUEE4gaxzdbw23mKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761735992; c=relaxed/simple;
	bh=vSMvKELtHmWQpbOapuGZ+TnOJ9iKoKTYdsqzAsqoPno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rFc9I4CMM7vHsSZSrS43uxR1OslXByONxZTlp7g3zFba39cX6oqtSKBLG2J7G4vwjioIpSUfpn1meIHY0o85bT3RgjS7jTc7eHWNI6yTZy/UNG6BOiC8vnxVXWjoiBy5CsCbc9o4YlhLRbgqybv8bs/IRh1ScCCoPiYqxX30fdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=1AKW0ske; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=geV90Pcl; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 260E61D0009E;
	Wed, 29 Oct 2025 07:06:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 29 Oct 2025 07:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1761735988; x=1761822388; bh=Vokz5CrIB9
	0rADA0qcTRDxUT/QhS/fpR0h2WpLPPbtY=; b=1AKW0skeIutyo0+2KBL1/9z6FN
	tLcfwIHWGirXJxWyiUKJfbYmwD9t+RmAajYv6BN5eljr7uPZJgPHc1yBDzI8FFCo
	l7Q9yt9XzcASHzfEV1eoFsIxVzrpL3beaEDo6S12h21s3/1ygREx2cdWJl1zRATt
	XTWLvSzC38UvJu/1C/2fa/TfMGIvhVzqbb98b/uKKqwH8DsShE09Z004YB8iimCz
	gTEqAYpwlGmZ7LZTL7tkfof5IV1lbKsYxLuBzX3NR5v5aU6+QWyRp5th523WPGcp
	8nIUXIyNHsvNEhZoEaCYNZGPJUhATgZDwjQo0jomKaiOTArlHyJY6WfPkT0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761735988; x=1761822388; bh=Vokz5CrIB90rADA0qcTRDxUT/QhS/fpR0h2
	WpLPPbtY=; b=geV90PclKvvVtKwODX5NHVLSCefOwiRsKwpzck9yT9JQa1I3GM6
	y2c51EuaOdPcwBNCA5zztmu7n2ygBQZcer0u2PwwY4i7AaVUfd5+Hhy3sYHOQmHE
	dEcCx1WLnU7LRWCSjHVd6On+xxhGhSsvnSuWrqqhHuAGBbxhPyluV3l90GJ9VAEZ
	yaqjOxwy22bOQdy9UhtBdTtfyAgHU+kG1NUHWzIlQVt1zeaU9XadWezhEamiQ8E/
	mA9f6mysn/la6YGM3NU00eM2ojQdhaEfvK5dxr4WJuypmt1N+lOy5ovkn9IiOUP7
	Jq2El6ikjDxtIWbo5W+8GuNrgIvyPGuvl/g==
X-ME-Sender: <xms:M_UBaY8Np0dyKyNlCWkW7hlv0JghtSrGB0w5D-SixpilARSMzFevpw>
    <xme:M_UBaXsAUn1fJ5ggJpgHzVzbp-DmVzwNcsSacTbma95qpZxPZKPgZ5vdS5nmsxhm3
    mA7cBvKRQM8P9vbWQbe5HfjchbiMnukVO8_sZ7PnX4UEkAUOg6c-gY>
X-ME-Received: <xmr:M_UBaTDEppG31qNx44M05ipQysyiu1ZKyXYYO9XUQ_zwvXSeuH_yTKFXgBEy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieefheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrsghrihhnrgcu
    ffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrfgrth
    htvghrnhepgeefkeevieejfffhfffhjeekvdehvdekleekheehtdeggfevkefflefgteeg
    lefgnecuffhomhgrihhnpeigshhinhhfohdrfhgrmhhilhihnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhl
    rdhnvghtpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuges
    qhhuvggrshihshhnrghilhdrnhgvthdprhgtphhtthhopehsthgvfhhfvghnrdhklhgrsh
    hsvghrthesshgvtghunhgvthdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:M_UBaXW2pC2sd1rntSPwCCfm-PaFrAxAEufni66DZUBj8-zMO8jU-g>
    <xmx:M_UBaZADLMLeYaAANv9b47Wosr_JitWgbWN8_mZR1Gha_l8r3FAQAg>
    <xmx:M_UBaS8yR6_-qEGYh1JfwwpUevTrQITrKY96vPPUyYYq0cjuuAS7rQ>
    <xmx:M_UBaYGrpSVQ9pI4F4aTxVJ5Ok6YhV49t_kFyYG2iroFlHiIm-9ibg>
    <xmx:M_UBaYx4qOL6JZeFavbYPQv55cxbxVGhsp2wkgDY3qvfdwKz3L6Pnicz>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 07:06:26 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH iproute2-next] ip-xfrm: add pcpu-num support
Date: Wed, 29 Oct 2025 12:06:16 +0100
Message-ID: <2623d62913de4f0e5e1d6a8b8cbcab4a9508c324.1761735750.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel supports passing the XFRMA_SA_PCPU attribute when creating
a state (via NEWSA or ALLOCSPI). Add a "pcpu-num" argument, and print
XFRMA_SA_PCPU when the kernel provides it.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 ip/ipxfrm.c        |  6 ++++++
 ip/xfrm_state.c    | 20 ++++++++++++++++++--
 man/man8/ip-xfrm.8 |  4 ++++
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/ip/ipxfrm.c b/ip/ipxfrm.c
index b15cc0002e5b..586d24fb8594 100644
--- a/ip/ipxfrm.c
+++ b/ip/ipxfrm.c
@@ -919,6 +919,12 @@ void xfrm_xfrma_print(struct rtattr *tb[], __u16 family, FILE *fp,
 			fprintf(fp, "other (%d)", dir);
 		fprintf(fp, "%s", _SL_);
 	}
+	if (tb[XFRMA_SA_PCPU]) {
+		__u32 pcpu_num = rta_getattr_u32(tb[XFRMA_SA_PCPU]);
+
+		fprintf(fp, "\tpcpu-num %u", pcpu_num);
+		fprintf(fp, "%s", _SL_);
+	}
 }
 
 static int xfrm_selector_iszero(struct xfrm_selector *s)
diff --git a/ip/xfrm_state.c b/ip/xfrm_state.c
index fbb1f9137183..cf8e7f3ca0ce 100644
--- a/ip/xfrm_state.c
+++ b/ip/xfrm_state.c
@@ -47,9 +47,9 @@ static void usage(void)
 		"        [ coa ADDR[/PLEN] ] [ ctx CTX ] [ extra-flag EXTRA-FLAG-LIST ]\n"
 		"        [ offload [ crypto | packet ] dev DEV dir DIR ]\n"
 		"        [ output-mark OUTPUT-MARK [ mask MASK ] ]\n"
-		"        [ if_id IF_ID ] [ tfcpad LENGTH ]\n"
+		"        [ if_id IF_ID ] [ tfcpad LENGTH ] [ pcpu-num CPUNUM ]\n"
 		"Usage: ip xfrm state allocspi ID [ mode MODE ] [ mark MARK [ mask MASK ] ]\n"
-		"        [ reqid REQID ] [ dir DIR ] [ seq SEQ ] [ min SPI max SPI ]\n"
+		"        [ reqid REQID ] [ dir DIR ] [ seq SEQ ] [ min SPI max SPI ] [ pcpu-num CPUNUM ]\n"
 		"Usage: ip xfrm state { delete | get } ID [ mark MARK [ mask MASK ] ]\n"
 		"Usage: ip xfrm state deleteall [ ID ] [ mode MODE ] [ reqid REQID ]\n"
 		"        [ flag FLAG-LIST ]\n"
@@ -309,6 +309,7 @@ static int xfrm_state_modify(int cmd, unsigned int flags, int argc, char **argv)
 	bool is_if_id_set = false;
 	__u32 if_id = 0;
 	__u32 tfcpad = 0;
+	__u32 pcpu_num = -1;
 
 	while (argc > 0) {
 		if (strcmp(*argv, "mode") == 0) {
@@ -458,6 +459,10 @@ static int xfrm_state_modify(int cmd, unsigned int flags, int argc, char **argv)
 		} else if (strcmp(*argv, "dir") == 0) {
 			NEXT_ARG();
 			xfrm_dir_parse(&dir, &argc, &argv);
+		} else if (strcmp(*argv, "pcpu-num") == 0) {
+			NEXT_ARG();
+			if (get_u32(&pcpu_num, *argv, 0))
+				invarg("value after \"pcpu-num\" is invalid", *argv);
 		} else {
 			/* try to assume ALGO */
 			int type = xfrm_algotype_getbyname(*argv);
@@ -767,6 +772,9 @@ static int xfrm_state_modify(int cmd, unsigned int flags, int argc, char **argv)
 		}
 	}
 
+	if (pcpu_num != -1)
+		addattr32(&req.n, sizeof(req.buf), XFRMA_SA_PCPU, pcpu_num);
+
 	if (req.xsinfo.family == AF_UNSPEC)
 		req.xsinfo.family = AF_INET;
 
@@ -797,6 +805,7 @@ static int xfrm_state_allocspi(int argc, char **argv)
 	struct xfrm_mark mark = {0, 0};
 	struct nlmsghdr *answer;
 	__u8 dir = 0;
+	__u32 pcpu_num = -1;
 
 	while (argc > 0) {
 		if (strcmp(*argv, "mode") == 0) {
@@ -831,6 +840,10 @@ static int xfrm_state_allocspi(int argc, char **argv)
 		} else if (strcmp(*argv, "dir") == 0) {
 			NEXT_ARG();
 			xfrm_dir_parse(&dir, &argc, &argv);
+		} else if (strcmp(*argv, "pcpu-num") == 0) {
+			NEXT_ARG();
+			if (get_u32(&pcpu_num, *argv, 0))
+				invarg("value after \"pcpu-num\" is invalid", *argv);
 		} else {
 			/* try to assume ID */
 			if (idp)
@@ -901,6 +914,9 @@ static int xfrm_state_allocspi(int argc, char **argv)
 		}
 	}
 
+	if (pcpu_num != -1)
+		addattr32(&req.n, sizeof(req.buf), XFRMA_SA_PCPU, pcpu_num);
+
 	if (rtnl_open_byproto(&rth, 0, NETLINK_XFRM) < 0)
 		exit(1);
 
diff --git a/man/man8/ip-xfrm.8 b/man/man8/ip-xfrm.8
index 3efd617247d7..4c278ccba38c 100644
--- a/man/man8/ip-xfrm.8
+++ b/man/man8/ip-xfrm.8
@@ -76,6 +76,8 @@ ip-xfrm \- transform configuration
 .IR DIR " ]"
 .RB "[ " tfcpad
 .IR LENGTH " ]"
+.RB "[ " pcpu-num
+.IR CPUNUM " ]"
 
 .ti -8
 .B "ip xfrm state allocspi"
@@ -94,6 +96,8 @@ ip-xfrm \- transform configuration
 .I SPI
 .B max
 .IR SPI " ]"
+.RB "[ " pcpu-num
+.IR CPUNUM " ]"
 
 .ti -8
 .BR "ip xfrm state" " { " delete " | " get " } "
-- 
2.51.1


