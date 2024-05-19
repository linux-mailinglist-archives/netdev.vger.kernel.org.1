Return-Path: <netdev+bounces-97142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE228C95D5
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 20:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50249280E59
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 18:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFE36CDCA;
	Sun, 19 May 2024 18:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="J4rE3Q45"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEC56CDBA
	for <netdev@vger.kernel.org>; Sun, 19 May 2024 18:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716143857; cv=none; b=UdckYTZazqJ6KU7qejaoXPCxs69vuX+g+/niw8VWdW4QSlsEtr7SRl1445XrrojeBQ7ioL+sdLfb1qT15AD7Pz1sD6ENmmEhLZnM2x4ld3vbk+VC1nkTiafjpPuXrxCU8+nichDpzoCkdS0wJNxExWw6C3K5USSmTpZLQhK94As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716143857; c=relaxed/simple;
	bh=DCCGhccJ0aVT+829N3CMw3RL3dlaxXnyWFXk8kYgJJ0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjdcyQ6jWP88K8NEe2nZ5Mk8OlQ4JiTbiqWkvLFLvGqTlCJJVI3Ofsvwd1NEtKu2YyKhGGa1BLX1JXZy9uPaF4Tw3TwAqKM7YQcwYOgj756OwqqhDcHJepRz9ZPMRoPYo2GeKgPzFn8lFzcArVkMUW8hjqOLBjhsBWR94iBbZeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=J4rE3Q45; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 0F8AC201AE;
	Sun, 19 May 2024 20:37:32 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ldWeor4egJd4; Sun, 19 May 2024 20:37:31 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 545B420185;
	Sun, 19 May 2024 20:37:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 545B420185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1716143851;
	bh=crgMEc/Ys+JH4Kjo2ReKYOxq84A947rcEVPKuwDfxbU=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=J4rE3Q45CfpbWrWJhTKMBM2rgsUX0ZXp8OLsJqGD7+SItNvhPdc8fZUbflLAOc3QX
	 RJMtpQVb/6i24szAsDAke5zD4x6+B7i2+/Q3ovHxUjJZ2z+q40vlgHnO1Zi8XlHCh0
	 GEhmmk0eQt3Qwc1OZ6hEPxSFa13VSjkMmyLfC+tdnjtyn0FleckHzSipiuQuS+BLM/
	 AnCgFGyVaM0Bi+Jh8SdGUfpXid6g19fKoVM+4jkivAffAJQUB/UiJ9AI5ZYcSD+Y+r
	 wy8BkV+eW2TUpveChw8xYx/HbYVc9Q1HXv3AYAQrok96CifnmX7VU6tDQgOKiaQe0P
	 bJsxwZjNR+c7Q==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 44CA580004A;
	Sun, 19 May 2024 20:37:31 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 19 May 2024 20:37:31 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 19 May
 2024 20:37:30 +0200
Date: Sun, 19 May 2024 20:37:23 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Stephen Hemminger <stephen@networkplumber.org>, David Ahern
	<dsahern@gmail.com>
CC: <netdev@vger.kernel.org>, <devel@linux-ipsec.org>, Steffen Klassert
	<steffen.klassert@secunet.com>, Eyal Birger <eyal.birger@gmail.com>, "Antony
 Antony" <antony.antony@secunet.com>, Nicolas Dichtel
	<nicolas.dichtel@6wind.com>, Sabrina Dubroca <sd@queasysnail.net>, "Christian
 Hopps" <chopps@chopps.org>
Subject: [PATCH RFC iproute2-next 2/3] xfrm: support xfrm SA direction
 attribute
Message-ID: <3c5f04d21ebf5e6c0f6344aef9646a37926a7032.1716143499.git.antony.antony@secunet.com>
Reply-To: <antony.antony@secunet.com>
References: <cover.1716143499.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1716143499.git.antony.antony@secunet.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

- Add parsing "ip xfrm state add .. dir [ in|out ]
- Add printing XFRMA_SA_DIR.
- allow replay-window 0 on output state with esn

Previously:
ip xfrm state add src 192.1.3.33 dst 192.1.2.23 proto esp spi 1 \
  reqid 1 mode tunnel aead 'rfc4106(gcm(aes))'  \
  0x1111111111111111111111111111111111111111 96
  sel src 192.0.3.0/25 dst 192.0.2.0/25 dir out flag esn

Error: esn flag set without replay-window.

When the SA direction is set, kernel only allows oputput SA, with ESN
and replay-window zero. This change would not affect any existing use
cases; configuring SA.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 ip/ipxfrm.c     | 12 ++++++++++++
 ip/xfrm_state.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/ip/ipxfrm.c b/ip/ipxfrm.c
index b78c712d..3c0faf62 100644
--- a/ip/ipxfrm.c
+++ b/ip/ipxfrm.c
@@ -904,6 +904,18 @@ void xfrm_xfrma_print(struct rtattr *tb[], __u16 family, FILE *fp,
 		fprintf(fp, "tfcpad %u", tfcpad);
 		fprintf(fp, "%s", _SL_);
 	}
+	if (tb[XFRMA_SA_DIR]) {
+		__u8 dir = rta_getattr_u8(tb[XFRMA_SA_DIR]);
+
+		fprintf(fp, "\tdir ");
+		if (dir == XFRM_SA_DIR_IN)
+			fprintf(fp, "in");
+		else if (dir == XFRM_SA_DIR_OUT)
+			fprintf(fp, "out");
+		else
+			fprintf(fp, " %d", dir);
+		fprintf(fp, "%s", _SL_);
+	}
 }
 
 static int xfrm_selector_iszero(struct xfrm_selector *s)
diff --git a/ip/xfrm_state.c b/ip/xfrm_state.c
index 9be65b2f..214d0d07 100644
--- a/ip/xfrm_state.c
+++ b/ip/xfrm_state.c
@@ -47,9 +47,9 @@ static void usage(void)
 		"        [ coa ADDR[/PLEN] ] [ ctx CTX ] [ extra-flag EXTRA-FLAG-LIST ]\n"
 		"        [ offload [ crypto | packet ] dev DEV dir DIR ]\n"
 		"        [ output-mark OUTPUT-MARK [ mask MASK ] ]\n"
-		"        [ if_id IF_ID ] [ tfcpad LENGTH ]\n"
+		"        [ if_id IF_ID ] [ tfcpad LENGTH ] [dir DIR]\n"
 		"Usage: ip xfrm state allocspi ID [ mode MODE ] [ mark MARK [ mask MASK ] ]\n"
-		"        [ reqid REQID ] [ seq SEQ ] [ min SPI max SPI ]\n"
+		"        [ reqid REQID ] [ seq SEQ ] [ min SPI max SPI ] [dir DIR]\n"
 		"Usage: ip xfrm state { delete | get } ID [ mark MARK [ mask MASK ] ]\n"
 		"Usage: ip xfrm state deleteall [ ID ] [ mode MODE ] [ reqid REQID ]\n"
 		"        [ flag FLAG-LIST ]\n"
@@ -290,7 +290,9 @@ static int xfrm_state_modify(int cmd, unsigned int flags, int argc, char **argv)
 	struct xfrm_replay_state_esn replay_esn = {};
 	struct xfrm_user_offload xuo = {};
 	unsigned int ifindex = 0;
-	__u8 dir = 0;
+	__u8 dir = 0; /* only used with xuo XFRMA_OFFLOAD */
+	__u8 sa_dir = 0; /* state direction. Should match the above when offload */
+
 	bool is_offload = false, is_packet_offload = false;
 	__u32 replay_window = 0;
 	__u32 seq = 0, oseq = 0, seq_hi = 0, oseq_hi = 0;
@@ -462,6 +464,14 @@ static int xfrm_state_modify(int cmd, unsigned int flags, int argc, char **argv)
 			NEXT_ARG();
 			if (get_u32(&tfcpad, *argv, 0))
 				invarg("value after \"tfcpad\" is invalid", *argv);
+		} else if (strcmp(*argv, "dir") == 0) {
+			NEXT_ARG();
+			if (strcmp(*argv, "in") == 0)
+				sa_dir = XFRM_SA_DIR_IN;
+			else if (strcmp(*argv, "out") == 0)
+				sa_dir = XFRM_SA_DIR_OUT;
+			else
+				invarg("value after \"dir\" is invalid", *argv);
 		} else {
 			/* try to assume ALGO */
 			int type = xfrm_algotype_getbyname(*argv);
@@ -587,7 +597,7 @@ static int xfrm_state_modify(int cmd, unsigned int flags, int argc, char **argv)
 	}
 
 	if (req.xsinfo.flags & XFRM_STATE_ESN &&
-	    replay_window == 0) {
+	    replay_window == 0 && sa_dir != XFRM_SA_DIR_OUT ) {
 		fprintf(stderr, "Error: esn flag set without replay-window.\n");
 		exit(-1);
 	}
@@ -760,6 +770,14 @@ static int xfrm_state_modify(int cmd, unsigned int flags, int argc, char **argv)
 	if (output_mark.m)
 		addattr32(&req.n, sizeof(req.buf), XFRMA_SET_MARK_MASK, output_mark.m);
 
+	if (sa_dir) {
+		int r = addattr8(&req.n, sizeof(req.buf), XFRMA_SA_DIR, sa_dir);
+		if (r < 0) {
+			fprintf(stderr, "XFRMA_SA_DIR failed\n");
+			exit(1);
+		}
+	}
+
 	if (rtnl_open_byproto(&rth, 0, NETLINK_XFRM) < 0)
 		exit(1);
 
@@ -792,6 +810,7 @@ static int xfrm_state_allocspi(int argc, char **argv)
 	char *maxp = NULL;
 	struct xfrm_mark mark = {0, 0};
 	struct nlmsghdr *answer;
+	__u8 sa_dir = 0;
 
 	while (argc > 0) {
 		if (strcmp(*argv, "mode") == 0) {
@@ -823,6 +842,14 @@ static int xfrm_state_allocspi(int argc, char **argv)
 
 			if (get_u32(&req.xspi.max, *argv, 0))
 				invarg("value after \"max\" is invalid", *argv);
+		} else if (strcmp(*argv, "dir") == 0) {
+			NEXT_ARG();
+			if (strcmp(*argv, "in") == 0)
+				sa_dir = XFRM_SA_DIR_IN;
+			else if (strcmp(*argv, "out") == 0)
+				sa_dir = XFRM_SA_DIR_OUT;
+			else
+				invarg("value after \"dir\" is invalid", *argv);
 		} else {
 			/* try to assume ID */
 			if (idp)
@@ -875,6 +902,15 @@ static int xfrm_state_allocspi(int argc, char **argv)
 			req.xspi.max = 0xffff;
 	}
 
+	if (sa_dir) {
+		int r = addattr8(&req.n, sizeof(req.buf), XFRMA_SA_DIR, sa_dir);
+
+		if (r < 0) {
+			fprintf(stderr, "XFRMA_SA_DIR failed\n");
+			exit(1);
+		}
+	}
+
 	if (mark.m & mark.v) {
 		int r = addattr_l(&req.n, sizeof(req.buf), XFRMA_MARK,
 				  (void *)&mark, sizeof(mark));
-- 
2.30.2


