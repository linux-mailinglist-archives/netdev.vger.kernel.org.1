Return-Path: <netdev+bounces-97143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 023478C95D6
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 20:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C46A1C20854
	for <lists+netdev@lfdr.de>; Sun, 19 May 2024 18:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DFE6D1A8;
	Sun, 19 May 2024 18:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="hiNoMrnd"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E8C6CDBA
	for <netdev@vger.kernel.org>; Sun, 19 May 2024 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716143879; cv=none; b=QrwMN30OiRraEZQPTRE75KrR33Rr0CY/goIDbBrbuuP7OCSRfg93cwx6TWs8Yy//yJpTKV+SVDMBYvo61y+bMZDTDLed8jSRji3gvJOgPXklLQV8RlhVMmkekMcvOVghPgef1SvQTaW0JgDJTaxOGv0K34E7Oxgjn1Qc9HEsaPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716143879; c=relaxed/simple;
	bh=vy5n2/KHWByF7ZvVsZ2P0erykSi0eDx3M2ogH5eGv5E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcI8vuW4VZsNdG74VKs5o2VPaP7ap2OeRr7rUIwnPO8b85sF2z8w3MS2oq9MXbxNXtLcBwq21/OE03msbZwifGtnWfPsKEqfCZqUtulUioKzN0SD3ZcnBZ50nH38BCfI4diUfCTYIwz/tvdH3qgAsY8fh7ZARg/yTc1I5kU5VWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=hiNoMrnd; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 48528201AE;
	Sun, 19 May 2024 20:37:55 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YXzwmJggZuda; Sun, 19 May 2024 20:37:54 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 58B3E20185;
	Sun, 19 May 2024 20:37:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 58B3E20185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1716143874;
	bh=9BeWKhxSygLWOvynC7N/pFXeBy2NuJlsHjZnYzNsx0M=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=hiNoMrndUh8Fq9lsmSVLTydZX1O1GQ3nPScQJfbjnZA/bjs+BEnZGxnx/7+XhT64p
	 u/aGVUoJJRq5ZxR4ic/yeTF072kylT3a3TB28n3xrEEmo2XzpiaEEA4i/VGYnscvV9
	 Ep8AkrBQtxrKXr6vo7Uf2Z+xzAXQz+JoEIXGoojkUmyIXz0LxY8p9cXRSEWRurtLzk
	 dyjadNQqn8PNa+DNBPjTsg8k7K9IT7L1u8++W3TNFpmH0PwjZER4iypUUEtjrhvyWL
	 2OEfhme4+QWo5hT2nVu57GHYddvlpPdIzCC5rr6Ty9yiS4akf4ujKeZuCWbZscolgN
	 IJVdfspc/ht2w==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id 4B85680004A;
	Sun, 19 May 2024 20:37:54 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 19 May 2024 20:37:54 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 19 May
 2024 20:37:53 +0200
Date: Sun, 19 May 2024 20:37:45 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Stephen Hemminger <stephen@networkplumber.org>, David Ahern
	<dsahern@gmail.com>
CC: <netdev@vger.kernel.org>, <devel@linux-ipsec.org>, Steffen Klassert
	<steffen.klassert@secunet.com>, Eyal Birger <eyal.birger@gmail.com>, "Antony
 Antony" <antony.antony@secunet.com>, Nicolas Dichtel
	<nicolas.dichtel@6wind.com>, Sabrina Dubroca <sd@queasysnail.net>, "Christian
 Hopps" <chopps@chopps.org>
Subject: [PATCH RFC iproute2-next 3/3] xfrm: update ip xfrm state output for
 SA with direction attribute
Message-ID: <4b4b45dfffeab66c64cf560f20b5317e0a3ad55f.1716143499.git.antony.antony@secunet.com>
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

With the introduction of the new SA direction attribute, I propose
removing redundant attributes in 'ip xfrm state' output.

When the SA has direction set, 'ip xfrm state' output can be simpler,
as several attributes for the opposite direction become redundant.

This commit is experimental. Review the output format. Examples of
the old and new styles are provided below.

This patch also re-formats the output to provide only direction-specific
information, reducing confusion.

Main changes:
- Only show oseq_hi/oseq for output SA.
- Only show seq_hi/seq for input SA.
- Show replay-window attributes only for input SA.
- Show replay-window or ESN replay-window, not both.
- Use replay-window consistently with ESN and non-ESN.
  * previously there was replay_window and replay-window.

Here is an exmple of input SA and output SA with ESN set.
-- input state ip xfrm state
-- new output wtih dir in --
ip xfrm state add src 10.1.3.4 dst 10.1.2.3 proto esp spi 3 reqid 2 \
  mode tunnel aead 'rfc4106(gcm(aes))' \
  0x2222222222222222222222222222222222222222 96 dir in flag esn \
  replay-window 36

-- new outpu "ip xfrm state"
src 10.1.3.4 dst 10.1.2.3
        proto esp spi 0x00000003 reqid 2 mode tunnel dir in
        flag esn
        aead rfc4106(gcm(aes)) 0x2222222222222222222222222222222222222222 96
        seq-hi 0x0, seq 0x0
        replay-window 36, bitmap-length 2
         00000000 00000000
        sel src 0.0.0.0/0 dst 0.0.0.0/0

-- old output ip xfrm state
src 10.1.3.4 dst 10.1.2.3
        proto esp spi 0x00000003 reqid 2 mode tunnel
        replay-window 0 flag esn
        aead rfc4106(gcm(aes)) 0x2222222222222222222222222222222222222222 96
        anti-replay esn context:
         seq-hi 0x0, seq 0x0, oseq-hi 0x0, oseq 0x0
         replay_window 36, bitmap-length 2
         00000000 00000000
        sel src 0.0.0.0/0 dst 0.0.0.0/0

--- example of output state :
ip xfrm state add src 10.1.3.4 dst 10.1.2.3 proto esp spi 3 reqid 2 \
  mode tunnel aead 'rfc4106(gcm(aes))' \
  0x2222222222222222222222222222222222222222 96 dir out flag esn

-- new output; ip xfrm state
src 10.1.3.4 dst 10.1.2.3
        proto esp spi 0x00000003 reqid 2 mode tunnel dir out
        flag esn
        aead rfc4106(gcm(aes))
0x2222222222222222222222222222222222222222 96
        oseq-hi 0x0, oseq 0x0
        sel src 0.0.0.0/0 dst 0.0.0.0/0

-- old output;  ip xfrm state
src 10.1.3.4 dst 10.1.2.3
        proto esp spi 0x00000003 reqid 2 mode tunnel
        replay-window 0 flag esn
        aead rfc4106(gcm(aes)) 0x2222222222222222222222222222222222222222 96
        anti-replay esn context:
         seq-hi 0x0, seq 0x0, oseq-hi 0x0, oseq 0x0
         replay_window 0, bitmap-length 0
        sel src 0.0.0.0/0 dst 0.0.0.0/0

Noitce minor fixes to output of the following commands when the direction is set.
Old API and output works the same when the SA direction is not set.

"ip xfrm state"
"ip -s xfrm state"
"ip -d xfrm state"
"ip xfrm monitor"
"ip -s xfrm monitor"
"ip -d xfrm monitor"

Please test it and give feedback, did I  miss a white space, tab..

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 ip/ipxfrm.c | 138 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 90 insertions(+), 48 deletions(-)

diff --git a/ip/ipxfrm.c b/ip/ipxfrm.c
index 3c0faf62..d631c28d 100644
--- a/ip/ipxfrm.c
+++ b/ip/ipxfrm.c
@@ -257,7 +257,8 @@ const char *strxf_ptype(__u8 ptype)
 
 static void xfrm_id_info_print(xfrm_address_t *saddr, struct xfrm_id *id,
 			__u8 mode, __u32 reqid, __u16 family, int force_spi,
-			FILE *fp, const char *prefix, const char *title)
+			__u8 sa_dir, FILE *fp, const char *prefix,
+			const char *title)
 {
 	if (title)
 		fputs(title, fp);
@@ -307,6 +308,15 @@ static void xfrm_id_info_print(xfrm_address_t *saddr, struct xfrm_id *id,
 		fprintf(fp, "%u", mode);
 		break;
 	}
+
+	if (sa_dir) {
+		fprintf(fp, " dir ");
+		if (sa_dir == XFRM_SA_DIR_IN)
+			fprintf(fp, "in");
+		else
+			fprintf(fp, "out");
+	}
+
 	fprintf(fp, "%s", _SL_);
 }
 
@@ -322,7 +332,7 @@ static const char *strxf_limit(__u64 limit)
 	return str;
 }
 
-static void xfrm_stats_print(struct xfrm_stats *s, FILE *fp,
+static void xfrm_stats_print(struct xfrm_stats *s, __u8 sa_dir, FILE *fp,
 			     const char *prefix)
 {
 	if (prefix)
@@ -331,8 +341,14 @@ static void xfrm_stats_print(struct xfrm_stats *s, FILE *fp,
 
 	if (prefix)
 		fputs(prefix, fp);
-	fprintf(fp, "  replay-window %u replay %u failed %u%s",
-		s->replay_window, s->replay, s->integrity_failed, _SL_);
+
+	if (sa_dir == XFRM_SA_DIR_OUT) {
+		/* would the fail occur on OUT??? */
+		fprintf(fp, " failed %u%s", s->integrity_failed, _SL_);
+	} else {
+		fprintf(fp, "  replay-window %u replay %u failed %u%s",
+			s->replay_window, s->replay, s->integrity_failed, _SL_);
+	}
 }
 
 static const char *strxf_time(__u64 time)
@@ -584,7 +600,7 @@ static void xfrm_tmpl_print(struct xfrm_user_tmpl *tmpls, int len,
 			fputs(prefix, fp);
 
 		xfrm_id_info_print(&tmpl->saddr, &tmpl->id, tmpl->mode,
-				   tmpl->reqid, tmpl->family, 0, fp, prefix, "tmpl ");
+				   tmpl->reqid, tmpl->family, 0, 0, fp, prefix, "tmpl ");
 
 		if (show_stats > 0 || tmpl->optional) {
 			if (prefix)
@@ -675,6 +691,8 @@ done:
 void xfrm_xfrma_print(struct rtattr *tb[], __u16 family, FILE *fp,
 		      const char *prefix, bool nokeys, bool dir)
 {
+	__u8 sa_dir =  tb[XFRMA_SA_DIR] ? rta_getattr_u8(tb[XFRMA_SA_DIR]) : 0;
+
 	if (tb[XFRMA_MARK]) {
 		struct rtattr *rta = tb[XFRMA_MARK];
 		struct xfrm_mark *m = RTA_DATA(rta);
@@ -813,7 +831,6 @@ void xfrm_xfrma_print(struct rtattr *tb[], __u16 family, FILE *fp,
 
 		if (prefix)
 			fputs(prefix, fp);
-		fprintf(fp, "anti-replay context: ");
 
 		if (RTA_PAYLOAD(tb[XFRMA_REPLAY_VAL]) < sizeof(*replay)) {
 			fprintf(fp, "(ERROR truncated)");
@@ -822,8 +839,11 @@ void xfrm_xfrma_print(struct rtattr *tb[], __u16 family, FILE *fp,
 		}
 
 		replay = RTA_DATA(tb[XFRMA_REPLAY_VAL]);
-		fprintf(fp, "seq 0x%x, oseq 0x%x, bitmap 0x%08x",
-			replay->seq, replay->oseq, replay->bitmap);
+		if (sa_dir == XFRM_SA_DIR_OUT)
+			fprintf(fp, "oseq 0x%x", replay->oseq);
+		else
+			fprintf(fp, "seq 0x%x, oseq 0x%x, bitmap 0x%08x",
+				replay->seq, replay->oseq, replay->bitmap);
 		fprintf(fp, "%s", _SL_);
 	}
 
@@ -833,36 +853,55 @@ void xfrm_xfrma_print(struct rtattr *tb[], __u16 family, FILE *fp,
 
 		if (prefix)
 			fputs(prefix, fp);
-		fprintf(fp, "anti-replay esn context:");
+		if (!sa_dir) {
+			fprintf(fp, "anti-replay esn context:");
+			fprintf(fp, "%s", _SL_);
+		}
 
 		if (RTA_PAYLOAD(tb[XFRMA_REPLAY_ESN_VAL]) < sizeof(*replay)) {
-			fprintf(fp, "(ERROR truncated)");
+			fprintf(fp, "(ERROR esn truncated)");
 			fprintf(fp, "%s", _SL_);
 			return;
 		}
-		fprintf(fp, "%s", _SL_);
 
 		replay = RTA_DATA(tb[XFRMA_REPLAY_ESN_VAL]);
-		if (prefix)
+
+		if (!sa_dir && prefix)
 			fputs(prefix, fp);
-		fprintf(fp, " seq-hi 0x%x, seq 0x%x, oseq-hi 0x%0x, oseq 0x%0x",
-			replay->seq_hi, replay->seq, replay->oseq_hi,
-			replay->oseq);
+		if (!sa_dir)
+			fprintf(fp, " ");
+		if (!sa_dir || sa_dir == XFRM_SA_DIR_IN)
+			fprintf(fp, "seq-hi 0x%x, seq 0x%x",
+				replay->seq_hi, replay->seq);
+		if (!sa_dir)
+			fprintf(fp, " ");
+		if (!sa_dir || sa_dir == XFRM_SA_DIR_OUT)
+			fprintf(fp, "oseq-hi 0x%0x, oseq 0x%0x",
+				replay->oseq_hi, replay->oseq);
 		fprintf(fp, "%s", _SL_);
-		if (prefix)
-			fputs(prefix, fp);
-		fprintf(fp, " replay_window %u, bitmap-length %u",
-			replay->replay_window, replay->bmp_len);
-		for (i = replay->bmp_len, j = 0; i; i--) {
-			if (j++ % 8 == 0) {
-				fprintf(fp, "%s", _SL_);
-				if (prefix)
-					fputs(prefix, fp);
+
+		if (sa_dir != XFRM_SA_DIR_OUT) {
+			if (prefix)
+				fputs(prefix, fp);
+			if (!sa_dir)
 				fprintf(fp, " ");
+			if (sa_dir)
+				fprintf(fp, "replay-window");
+			else
+				fprintf(fp, "replay_window"); /* for historic reasons */
+			fprintf(fp, " %u, bitmap-length %u", replay->replay_window,
+				replay->bmp_len);
+			for (i = replay->bmp_len, j = 0; i; i--) {
+				if (j++ % 8 == 0) {
+					fprintf(fp, "%s", _SL_);
+					if (prefix)
+						fputs(prefix, fp);
+					fprintf(fp, " ");
+				}
+				fprintf(fp, "%08x ", replay->bmp[i - 1]);
 			}
-			fprintf(fp, "%08x ", replay->bmp[i - 1]);
+			fprintf(fp, "%s", _SL_);
 		}
-		fprintf(fp, "%s", _SL_);
 	}
 	if (tb[XFRMA_OFFLOAD_DEV]) {
 		struct xfrm_user_offload *xuo;
@@ -904,18 +943,6 @@ void xfrm_xfrma_print(struct rtattr *tb[], __u16 family, FILE *fp,
 		fprintf(fp, "tfcpad %u", tfcpad);
 		fprintf(fp, "%s", _SL_);
 	}
-	if (tb[XFRMA_SA_DIR]) {
-		__u8 dir = rta_getattr_u8(tb[XFRMA_SA_DIR]);
-
-		fprintf(fp, "\tdir ");
-		if (dir == XFRM_SA_DIR_IN)
-			fprintf(fp, "in");
-		else if (dir == XFRM_SA_DIR_OUT)
-			fprintf(fp, "out");
-		else
-			fprintf(fp, " %d", dir);
-		fprintf(fp, "%s", _SL_);
-	}
 }
 
 static int xfrm_selector_iszero(struct xfrm_selector *s)
@@ -944,22 +971,30 @@ void xfrm_state_info_print(struct xfrm_usersa_info *xsinfo,
 {
 	char buf[STRBUF_SIZE] = {};
 	int force_spi = xfrm_xfrmproto_is_ipsec(xsinfo->id.proto);
+	__u8 sa_dir =  tb[XFRMA_SA_DIR] ? rta_getattr_u8(tb[XFRMA_SA_DIR]) : 0;
+	bool sl = false;
 
 	xfrm_id_info_print(&xsinfo->saddr, &xsinfo->id, xsinfo->mode,
-			   xsinfo->reqid, xsinfo->family, force_spi, fp,
+			   xsinfo->reqid, xsinfo->family, force_spi, sa_dir, fp,
 			   prefix, title);
 
 	if (prefix)
 		strlcat(buf, prefix, sizeof(buf));
+
 	strlcat(buf, "\t", sizeof(buf));
 
-	fputs(buf, fp);
-	fprintf(fp, "replay-window %u ", xsinfo->replay_window);
-	if (show_stats > 0)
-		fprintf(fp, "seq 0x%08u ", xsinfo->seq);
+	if (sa_dir == 0 || (sa_dir == XFRM_SA_DIR_IN && tb[XFRMA_REPLAY_VAL])) {
+		fputs(buf, fp);
+		fprintf(fp, "replay-window %u ", xsinfo->replay_window);
+		if (show_stats > 0)
+			fprintf(fp, "seq 0x%08u ", xsinfo->seq);
+		sl = true;
+	}
+
 	if (show_stats > 0 || xsinfo->flags) {
 		__u8 flags = xsinfo->flags;
 
+		fputs(buf, fp);
 		fprintf(fp, "flag ");
 		XFRM_FLAG_PRINT(fp, flags, XFRM_STATE_NOECN, "noecn");
 		XFRM_FLAG_PRINT(fp, flags, XFRM_STATE_DECAP_DSCP, "decap-dscp");
@@ -969,8 +1004,10 @@ void xfrm_state_info_print(struct xfrm_usersa_info *xsinfo,
 		XFRM_FLAG_PRINT(fp, flags, XFRM_STATE_AF_UNSPEC, "af-unspec");
 		XFRM_FLAG_PRINT(fp, flags, XFRM_STATE_ALIGN4, "align4");
 		XFRM_FLAG_PRINT(fp, flags, XFRM_STATE_ESN, "esn");
-		if (flags)
+		if (flags) {
 			fprintf(fp, "%x", flags);
+		}
+		sl = true;
 	}
 	if (show_stats > 0 && tb[XFRMA_SA_EXTRA_FLAGS]) {
 		__u32 extra_flags = rta_getattr_u32(tb[XFRMA_SA_EXTRA_FLAGS]);
@@ -982,12 +1019,17 @@ void xfrm_state_info_print(struct xfrm_usersa_info *xsinfo,
 		XFRM_FLAG_PRINT(fp, extra_flags,
 				XFRM_SA_XFLAG_OSEQ_MAY_WRAP,
 				"oseq-may-wrap");
-		if (extra_flags)
+		if (extra_flags) {
 			fprintf(fp, "%x", extra_flags);
+			sl = true;
+		}
 	}
-	if (show_stats > 0)
+	if (show_stats > 0) {
 		fprintf(fp, " (0x%s)", strxf_mask8(xsinfo->flags));
-	fprintf(fp, "%s", _SL_);
+		sl = true;
+	}
+	if (sl)
+		fprintf(fp, "%s", _SL_);
 
 	xfrm_xfrma_print(tb, xsinfo->family, fp, buf, nokeys, true);
 
@@ -1002,7 +1044,7 @@ void xfrm_state_info_print(struct xfrm_usersa_info *xsinfo,
 
 	if (show_stats > 0) {
 		xfrm_lifetime_print(&xsinfo->lft, &xsinfo->curlft, fp, buf);
-		xfrm_stats_print(&xsinfo->stats, fp, buf);
+		xfrm_stats_print(&xsinfo->stats, sa_dir, fp, buf);
 	}
 
 	if (tb[XFRMA_SEC_CTX])
-- 
2.30.2


