Return-Path: <netdev+bounces-296556-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VLIKN4S/JmoScQIAu9opvQ
	(envelope-from <netdev+bounces-296556-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:11:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F14656790
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:11:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BfE4NlYP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296556-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-296556-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8DD00300D769
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 13:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F90321F5F;
	Mon,  8 Jun 2026 13:10:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3571736C5B4
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 13:10:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924211; cv=none; b=e3TY3gDFbwL0J9s1naQ8Q2G0OmOi5TUHf4/j0mtOimZNY/4HN+hmbwt1LWC6lRN6ORrC9xRaCCC3S6q5XlOgTtzaSvi1aWnRedR2ABgxHtVRziJ7M04kPFFKR3rZCZ7pOrEDQwwO4GD2lcjTB5oLR3LP0Rn+tf3Ih6GzHUUBjmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924211; c=relaxed/simple;
	bh=2RVbTDHmQ4a63/sntDmq4HEqh3gOowX5Dl0RPU3VcbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rP7eCEe8OyXQWaMXXHTyKnoXLLM+1fjkGlRRt+VcfNbJ1tyDh4LOTKhIgg2Qevzp7EEYi/4an1EYduAbJEBNUPJkaOQw5JQSjizHd5m7JsHRsAnLB0+vOhJJT7QGqNwR4h3zoKuuv6BzhxTI8ijMCwPUkxehqxrsbRv/sG2dUz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfE4NlYP; arc=none smtp.client-ip=209.85.128.67
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-490ae34298aso3528775e9.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 06:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780924208; x=1781529008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwq/NpE2muVAo9/GSq/xz3GnH0zO2xzCrY2NhDwYVf8=;
        b=BfE4NlYPVwWpmGXYOIoWvAtDM/USMoo0ip39BEyEl6WBPSnj1tyw2I6TTl7zpYmz9y
         6mFKZ/y/W/NfgH8xB5O3nphKnlzq/LJpR7IFZjITWmjxbNekfM4NWDJ+TbRjG4zSjRDE
         aAgE01RQkpZ1ekL7JBy0QytiLe2VgZ1B2dHSOQWiec8/th8NrmxgrkK41zzfTvZYlREc
         cZJ4A1O1ishODFOzAv84AKpbd77cDk6cVzZc+P9ANULR5Vpo3VGNG4KyJUlj2PYr386j
         EBJ4BHbLFen0vjh/XLsY79y/hH3JkhXb7n1oFZCWsNYIg9nSKl+L+dH3xjnhAC5Dm11F
         ypPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780924208; x=1781529008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nwq/NpE2muVAo9/GSq/xz3GnH0zO2xzCrY2NhDwYVf8=;
        b=DHinOw1OFtfiAonOJg8A+e1U2detLvVz2wrfX6p3Vv4LiUkFOlhbtJOMZZ0yTBefWy
         JnOLxtqAotNLFCIwFeYabvH7ITd3l1EbPHoLi1jPaS31+UNAqkNHzRIPzNwIJPRL0paC
         eMBodRY4qz/876qzPS9whfca0z2AS2fTlORF3GkuU3a2RB1xvsLmTdfVlYPhlOQ1+tIY
         Mt/pfU2/hheUeohPQT5ubS3sWNAxEAb+etWD3kULNsqIr+LfY+cu43X1ShYazhglH8xM
         dYZBlTRExpADSSUGTT+8Pu0zQ8knesHaIJmUMAbpOVgLhGKrInABEt3hfejitEtGnKuF
         pwoA==
X-Gm-Message-State: AOJu0Ywyv1avJj4ANZfyUUsM+NPMHady1893kKu3ZG/H1oYar9Qhh0Xb
	gTmKBJQDdFbNdLJKDKv7ZlIeW/srM5ZL07d/h8JbIcDR+DmbyeN10zGecLx6F7Gp
X-Gm-Gg: Acq92OEVIum1xsUOMo12FfZthRgdlfgV3Vb4vYkqfxlnV91Uaq/pCKen4uv/6i2zmLw
	IH1jntEPnvS74+9zqqraUTuWPEOgYYbv+Gho24v2Ja0MquNMcI+qkHuzxgv28+D5Vie2kXTD9nO
	+TSCgpyZWyyfzGNQWAmuoqxa+OOZfCG/ATb0O52DlJDqhfa9RvdEz9stK3hY1YY0VmYrg7YGF8H
	32lltzRHbe5u1XolwMbDgl6+rZRs/QaD4GGtaqIzt/dIe5aSKspCF8C6fQV1HeaH6G2iD/QsLw5
	q0SQjgiYSiGXJdPOH67pwDQuYmFpbgF3Uo4NtQOkmEaVD/5OyvsoTKeVO+P2jxoXnAKhuAfrfyQ
	E/gSod11I/siJOs3N7Tt/YJGLxa1GRLsskdpPCmxYkKGcf0PCmPVP/f7E83ShAQy6zTcc4jAg0K
	y4k6Y1v6UNnczWcO6wsQAvl4xzLZTTQJo0byureT13Rg==
X-Received: by 2002:a05:600c:4688:b0:490:b2f9:d9a4 with SMTP id 5b1f17b1804b1-490c25985c5mr118493105e9.1.1780924208432;
        Mon, 08 Jun 2026 06:10:08 -0700 (PDT)
Received: from localhost ([104.28.193.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d37edbsm300135675e9.2.2026.06.08.06.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:10:07 -0700 (PDT)
From: Mariusz Klimek <maklimek97@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	idosch@nvidia.com,
	ncardwell@google.com,
	shuah@kernel.org,
	kuniyu@google.com,
	alice@isovalent.com,
	Mariusz Klimek <maklimek97@gmail.com>
Subject: [PATCH net-next 06/10] tcp: set MSS correctly for PMTU above 65535
Date: Mon,  8 Jun 2026 15:07:51 +0200
Message-ID: <20260608130755.5626-7-maklimek97@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260608130755.5626-1-maklimek97@gmail.com>
References: <20260608130755.5626-1-maklimek97@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296556-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:ncardwell@google.com,m:shuah@kernel.org,m:kuniyu@google.com,m:alice@isovalent.com,m:maklimek97@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[maklimek97@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,isovalent.com,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maklimek97@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D3F14656790

This patch fixes __tcp_mtu_to_mss to support MTUs above 65535. According to
RFC2675 and RFC6691, an advertised MSS of 65535 means "any MSS, rely only
on PMTU discovery". ip6_default_advmss already adheres to this behavior,
but __tcp_mtu_to_mss doesn't. __tcp_mtu_to_mss instead clamps the MSS to
65535.

Note that MTU probing also doesn't currently support PMTU > 65535 because
icsk_mtup.search_high is set to 65535. This commit doesn't add support for
PMTU > 65535 when MTU probing is enabled because it is not obvious what
icsk_mtup.search_high should be. A possible solution is to only set
icsk_mtup.search_low and to exponentially raise it until a probe becomes
too big (and then set icsk_mtup.search_high) but since this is a
non-trivial change, delegate it to a separate patch series.

Signed-off-by: Mariusz Klimek <maklimek97@gmail.com>
---
 net/ipv4/tcp_output.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index a66a3622006d..2d87b9cacd12 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1990,19 +1990,30 @@ static inline int __tcp_mtu_to_mss(struct sock *sk, int pmtu)
 {
 	const struct tcp_sock *tp = tcp_sk(sk);
 	const struct inet_connection_sock *icsk = inet_csk(sk);
+	unsigned int ext_hdr_len;
 	int mss_now;
 
+	ext_hdr_len = icsk->icsk_ext_hdr_len;
+
+	/* Take into account added jumbogram HBH header. */
+	if (unlikely(pmtu - sizeof(struct ipv6hdr) > IPV6_MAXPLEN))
+		ext_hdr_len += sizeof(struct hop_jumbo_hdr);
+
 	/* Calculate base mss without TCP options:
 	   It is MMS_S - sizeof(tcphdr) of rfc1122
 	 */
 	mss_now = pmtu - icsk->icsk_af_ops->net_header_len - sizeof(struct tcphdr);
 
-	/* Clamp it (mss_clamp does not include tcp options) */
-	if (mss_now > tp->rx_opt.mss_clamp)
+	/* Clamp it (mss_clamp does not include tcp options).
+	 * An mss of 65535 means we should rely entirely on PMTU discovery
+	 * (RFC2675, RFC6691).
+	 */
+	if (mss_now > tp->rx_opt.mss_clamp &&
+	    likely(tp->rx_opt.mss_clamp < IPV6_MAXPLEN))
 		mss_now = tp->rx_opt.mss_clamp;
 
 	/* Now subtract optional transport overhead */
-	mss_now -= icsk->icsk_ext_hdr_len;
+	mss_now -= ext_hdr_len;
 
 	/* Then reserve room for full set of TCP options and 8 bytes of data */
 	mss_now = max(mss_now,
-- 
2.47.3


