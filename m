Return-Path: <netdev+bounces-269330-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMEIK8qmu2mUmQIAu9opvQ
	(envelope-from <netdev+bounces-269330-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 08:33:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB082C750D
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 08:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F866300D0E6
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 07:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F2F39E176;
	Thu, 19 Mar 2026 07:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4jy+rzN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E584390C8A
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 07:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773905604; cv=none; b=iktm5sR6jxwzdsJO2R0yngkxZcfZCtXDB2U3b+OpI+Afumeh8Uw1h8nN32EZetrX1d5jEoRd6i3tulCiQ47Vl4fIVgNb0qWhQJUWKvgTZXspXQWnYsjtGOCdPm5MvM458UQ1bVerqia1oKg7OBecc5/Dyx78dcZneyvKMR11FYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773905604; c=relaxed/simple;
	bh=GYSppdIMaX/06nQtFbo2tTryX8SKqeX06P5GhztxMfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R28Mx+86CQe6sl1OJFxh0pk1ScHP8ORt5sFqd/LTpeKfp4OizraE8RV1TVC/j0MFXg8N9ocx1WaW94zwRs+Q1CaZkqiaEzhXL5hehKTbgHlemArLt1uxugMdYStiNmp4ap5PSksQzs0pY7LKQJAWxsuHPGClGC86o2kEBEaCTZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4jy+rzN; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so311661a91.1
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 00:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773905602; x=1774510402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLQ1MC6fP9cORHP27xWUIjVQ8sSQEHBL6tE36vI4nLE=;
        b=I4jy+rzNBghX1ypUyWkKjJKoK+A8dGtAtS6sZ84wu/n+/oKSGo7OXZHhSGcetF7JLh
         XxRaScyj3NYZFxFoSxJq7iuGeRzdoV2j60/J8nWjbOWRntc2AHiuHG+CTH4cgd7/a8K1
         s+JWz2jGtSZ1HBI56SYkvqDem11cBccGl7Ui8K4DV02EhlKd/uNQ4ns6i3PXA9nzRwQS
         VM/lNZIB+0/aKiYwSE+UpKLR3CExZckob9IT/Cb4YkaaQkDyBbBM9HOlhv84WvonrptE
         cOiio+xiXBtgNJdpOvizbuUdF6/zNEDRcOuWuhiIOlMWyGbsDXemNLnUv7O5W6L/uKUs
         X3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773905602; x=1774510402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLQ1MC6fP9cORHP27xWUIjVQ8sSQEHBL6tE36vI4nLE=;
        b=iW8Ao0HTVSJFGltadca3fTs9xMXkBCqGgIAjNCPSdwFoImSOAy5UAS8quqMdk469SV
         FclQZHN2wbSG3UwgLP15VrX9jt379NCnkXw3tD4b29qnbQrXoaZ61kXSPfVBvCImyPV7
         woQxJ3y7BkVv1Aoo3sUlLnsKoD5zAIIpZDasb6pLtShePpwkyqhEfKZlBBkZdVEeu193
         chAmnDw8YsGgk9yAImpCjTXBoCbsDTDyx3fwIMEQtElRNvac/X9l/7t+ZmVhlp1iIq/A
         1k7rRgTnQhUF37u13D5260r++rOsyM54I5NbnuCcEifeReIkTwDFjwjRa7pcsUPh9BIV
         xP3A==
X-Forwarded-Encrypted: i=1; AJvYcCWg9q8WsMCp3E1Kb7RBxXjEe8VNEA5JzX4NWB/DQIf11OYbhDQMgSSuU6zROqvxpDjO7ic1UxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJc/q0F5UeGtKGNuvE5Tsa0qRVs2pFIQoJ06x7FycSnHhDclIz
	RzzsHUVm33s3abbQm7kiLoA5m6gkGct74XWklsrHGehW8eQtoy5gIr2I
X-Gm-Gg: ATEYQzzFNq5z++sPFahK4S6d0ybx4vz7Zug8T5mU5pZzeq6fABNjslc86DpQRdakiuA
	2+UsWcbnuSIK/wvToPNsu5yJQ7AqOalEM5SB3n9J3Y7z8SYICvpQzrD46U+cEGwG+giCqMCU7ze
	EVZ5HXr/+v9KhwhzoM9684Zbe9lgip1Qo2ZtTx/EKN1IBE5QdBFmR6hoszLCysT8DOIhDkUcqJh
	w7gB8mOwqQnxdVW62dbovwknTt3Lz72jBN4HL4An/2nY5AXHhD53z6p+o69HpA1YZVjpTP/dvHA
	I8Anis4dgPT/arB23AqK9/pg/eKO9WzvtkugsvgI6Ip1yNvq8F9RA/6YGL7tPSkKoujfEHOzqd2
	t7LT+kgqapi1xAWDq3ZrBhtvO4tPAAhG7EamCiNy31SBeA83WN307Q98McA/gKghLkNBlldPxZf
	TMwEabD137PxnGawRd+DX03ZnrDsmbRALMFQNSKFnP0g3asREx5LiOaH/NVr7QJe/IKpkZC85fL
	1msZ15673I=
X-Received: by 2002:a17:90a:e70d:b0:352:ba0f:fb28 with SMTP id 98e67ed59e1d1-35bb9e432f2mr5390169a91.1.1773905602343;
        Thu, 19 Mar 2026 00:33:22 -0700 (PDT)
Received: from SLSGDTSWING002.tail0ac356.ts.net ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc6026a5asm2166870a91.8.2026.03.19.00.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 00:33:21 -0700 (PDT)
From: bestswngs@gmail.com
To: security@kernel.org
Cc: edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xmei5@asu.edu,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net] nfnetlink_osf: validate individual option lengths in fingerprints
Date: Thu, 19 Mar 2026 15:32:44 +0800
Message-ID: <20260319073243.1176330-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,asu.edu,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269330-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.925];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AEB082C750D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Weiming Shi <bestswngs@gmail.com>

nfnl_osf_add_callback() validates opt_num bounds and string
NUL-termination but does not check individual option length fields.
A zero-length option causes nf_osf_match_one() to enter the option
matching loop even when foptsize sums to zero, which matches packets
with no TCP options where ctx->optp is NULL:

 Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
 KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
 RIP: 0010:nf_osf_match_one (net/netfilter/nfnetlink_osf.c:98)
 Call Trace:
  <IRQ>
  nf_osf_match (net/netfilter/nfnetlink_osf.c:227)
  xt_osf_match_packet (net/netfilter/xt_osf.c:32)
  ipt_do_table (net/ipv4/netfilter/ip_tables.c:293)
  nf_hook_slow (net/netfilter/core.c:623)
  ip_local_deliver (net/ipv4/ip_input.c:262)
  ip_rcv (net/ipv4/ip_input.c:573)
  </IRQ>
 Kernel panic - not syncing: Fatal exception in interrupt

Additionally, an MSS option (kind=2) with length < 4 causes
out-of-bounds reads when nf_osf_match_one() unconditionally accesses
optp[2] and optp[3] for MSS value extraction.  While RFC 9293
section 3.2 specifies that the MSS option is always exactly 4
bytes (Kind=2, Length=4), the check uses "< 4" rather than
"!= 4" because lengths greater than 4 do not cause memory
safety issues -- the buffer is guaranteed to be at least
foptsize bytes by the ctx->optsize == foptsize check.

Reject fingerprints where any option has zero length, or where an MSS
option has length less than 4, at add time rather than trusting these
values in the packet matching hot path.

Fixes: 11eeef41d5f6 ("netfilter: passive OS fingerprint xtables match")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/netfilter/nfnetlink_osf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/netfilter/nfnetlink_osf.c b/net/netfilter/nfnetlink_osf.c
index 94e3eac5743a..c35b831dac5a 100644
--- a/net/netfilter/nfnetlink_osf.c
+++ b/net/netfilter/nfnetlink_osf.c
@@ -303,6 +303,7 @@ static int nfnl_osf_add_callback(struct sk_buff *skb,
 	struct nf_osf_user_finger *f;
 	struct nf_osf_finger *kf = NULL, *sf;
 	int err = 0;
+	int i;

 	if (!capable(CAP_NET_ADMIN))
 		return -EPERM;
@@ -318,6 +319,13 @@ static int nfnl_osf_add_callback(struct sk_buff *skb,
 	if (f->opt_num > ARRAY_SIZE(f->opt))
 		return -EINVAL;

+	for (i = 0; i < f->opt_num; i++) {
+		if (!f->opt[i].length)
+			return -EINVAL;
+		if (f->opt[i].kind == OSFOPT_MSS && f->opt[i].length < 4)
+			return -EINVAL;
+	}
+
 	if (!memchr(f->genre, 0, MAXGENRELEN) ||
 	    !memchr(f->subtype, 0, MAXGENRELEN) ||
 	    !memchr(f->version, 0, MAXGENRELEN))
--
2.43.0

