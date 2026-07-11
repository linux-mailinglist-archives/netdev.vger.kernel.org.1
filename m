Return-Path: <netdev+bounces-306820-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y4jVC3UeUmq4MAMAu9opvQ
	(envelope-from <netdev+bounces-306820-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:44:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2449A74147E
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:44:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=MUgRBfag;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306820-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306820-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F247302186A
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 10:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CAD3B7B84;
	Sat, 11 Jul 2026 10:41:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B953BB11D
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 10:41:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783766486; cv=none; b=YFlkDgCtVvaqThwue7HxABzsM2GfNxcacL/HSOG53rc7FjbCB2IM59QXHTrQzq8XPvOMEh/S48OWbp8S+/KGn5PIi2gzR3GDe7ZI755mguB9NmYq4PEBkPs+Wcg4v5gCPTuQ+EYA4S8TyCNP6CUIi1wbQrKjzMjc62Cj7tIKj50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783766486; c=relaxed/simple;
	bh=fZdiAzGz7MDT4+l8yg8JqDcusAXgcqCF0bEYj/RAbu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bI0pcO+VeSvKRL9qm123s99HT9pkKiUk8oFuVudBAUCVCEBsUWimG27TURe9mwXJbry8eTT2stTndtY1D5OGb6Cd/6dOEpGUPFNdohk2v02Hhp1Ud6/08qNTfPmMwZuOuN/MY+W8EZXsYW7/LP8Sx/yIyAvXIYrtc9itObtPKFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUgRBfag; arc=none smtp.client-ip=209.85.218.47
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c15e0c3f395so203957866b.3
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 03:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783766483; x=1784371283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MsN2Bg58rEwq83AyY9vwpi88nOUpz5zJ1GusdkCgnH0=;
        b=MUgRBfagVEV3tdVmkz1L6Vuo4yWb3P9Tuwm0rD+oF0Nr0h+I/ze+pR9XviEks+bKik
         wv57Fi+dP6tsrTyrEI3AZb+raz74y3XpjFlZcajQ499xz04THk3SCRJA8LLH8g10Cs8v
         SaJ3G2DNK3p3wTDJ1y5osFDnwRWm90BK8GCEsDaoeuJaye5OPSP5Aeo9werdpkyJ5R2X
         RvS3lh0pj08pNmBq9HWGSYUQVTsBpvB7DVxD0ygSFE4mY0DXRXAOOVAAh7YsD32tpMmK
         gsSUrvh5H6OgbggupB+cAk3Zyh7tJblKpElBISOjSyLP3uwW69kL9BczT11PGaEdoPuE
         P39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783766483; x=1784371283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MsN2Bg58rEwq83AyY9vwpi88nOUpz5zJ1GusdkCgnH0=;
        b=ZgG5XUNsL9Ywbzsijcg5AXIwKDLo5uCNIPDkB83bsklPTyfLisovFciAwKhPtPwts0
         TM8qBhmusuDg3SnlAyofqHM9B4Jzi6BDTQW+CMM2t49S+E7FYNv2D0Lc2dR6NfRl9ls5
         Gd1GTr1LkXWJ3o+BNlRgdmZRm+4ytjbRBiZWjIC5dhfrIBY1EfB2uZ6uD/ZCgpSM1muA
         tCHVxTxzFPqTUzjezeyFSS1hx30efN+vQ3jRjHzFpeiRw8IsK47n0DiuL/XERd6IzgNS
         qhXpwjBywe+17H0Y/tjWtke8u5sYfSHwHkOflPywjU6f2hqWB+7BFL8uEJEjgljikzUZ
         xJnQ==
X-Forwarded-Encrypted: i=1; AHgh+RqjMP4OvThfmneAG8NT/FzPZEsitvU9lO57+LiTQiODz/H6N1qx3bge+n/yRGMbK0mZyebOp10=@vger.kernel.org
X-Gm-Message-State: AOJu0YxriJPwn2l8ziuRLusCK4EK9dJKIXjZULpR5RxMSlrZFTIYjKXA
	c0DOHokyV2JiR9mAAEE87kVtgjVQIZa/CCrMxB1+qBvoh3/+w1BilnMJ
X-Gm-Gg: AfdE7ck/JGvnk8AUi8DGW6NN+87a4XmQdlq/91EDCDGLlvcpcnJfG6e0x/OimA2XT/w
	/jNZKA+zaL8MDslE4T/piaA6gkYYgU/8CuLOGftFcq/FVQKOaqMfrMVuNjntyZS59LlG8aeU0Rw
	FqygiZNg7I4aFUPpW3b6l6EGh8u6OliOaByMjrcdIiaHUnujGKmdWxHyELvagSNM0nDR/yBGxSg
	LStrwHMQFg4mEdaRyHX+CpRbxEB6FwQtamLEx3ycvi5l9ainnNij9MBHzTkpgNf6xiZU471ese/
	6+sf3W6pC1AiIsXx2wZ/bLuS4+5utvFUn/e/4R1K5NJda/biIUhicB3pVgeXLewmfedMgPvDP1u
	Wqpd0Ix9+tCXkGwtStdMBOfb9kNYRPDeLbM7p1fMH7MeqZM6dzVgm+uHpWtVTbOLTN/2UXRHtL/
	Kh8wLqhSKEd42TFgLEwMO9Mmg93xukhMuPQ70BmjYup7nw+BDRFI6Y/CZsiuYkAhKJS7tWkJd3Y
	WEXvNgfSB7iTermlYYXe8e5xOIGQbYi2PRGESvFtmg5ycQqCg==
X-Received: by 2002:a17:907:cf87:b0:c12:80a9:d571 with SMTP id a640c23a62f3a-c161e9a4fc5mr102428666b.24.1783766482745;
        Sat, 11 Jul 2026 03:41:22 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-222-132.dab.02.net. [82.132.222.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15d5de95e6sm483041566b.39.2026.07.11.03.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 03:41:21 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH review-only 17/17] io_uring/zcrx: don't reload skb_shinfo
Date: Sat, 11 Jul 2026 11:40:10 +0100
Message-ID: <a190271e54e46afe752ee37411bc0ac46d87a11b.1783616211.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783616211.git.asml.silence@gmail.com>
References: <cover.1783616211.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306820-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:io-uring@vger.kernel.org,m:asml.silence@gmail.com,m:netdev@vger.kernel.org,m:asmlsilence@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2449A74147E

Keep skb_shinfo in a local variable so that it doesn't reload it on
every iteration of the loop.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 74046a09911a..0aa6455971d6 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -1836,6 +1836,7 @@ io_zcrx_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
 	struct io_kiocb *req = args->req;
 	struct sk_buff *frag_iter;
 	unsigned start, start_off = offset;
+	struct skb_shared_info *shi;
 	int i, ret = 0;
 
 	len = min_t(size_t, len, desc->count);
@@ -1871,17 +1872,15 @@ io_zcrx_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
 	}
 
 	start = skb_headlen(skb);
+	shi = skb_shinfo(skb);
 
-	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
-		const skb_frag_t *frag;
-		unsigned frag_end;
+	for (i = 0; i < shi->nr_frags; i++) {
+		const skb_frag_t *frag = &shi->frags[i];
+		unsigned frag_end = start + skb_frag_size(frag);
 
 		if (WARN_ON(start > offset + len))
 			return -EFAULT;
 
-		frag = &skb_shinfo(skb)->frags[i];
-		frag_end = start + skb_frag_size(frag);
-
 		if (offset < frag_end) {
 			unsigned copy = min(frag_end - offset, len);
 			unsigned frag_off = offset - start;
-- 
2.54.0


