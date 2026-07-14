Return-Path: <netdev+bounces-307389-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eceqLtfzVWomwwAAu9opvQ
	(envelope-from <netdev+bounces-307389-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 10:31:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AF27526B4
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 10:31:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="giy/cU2f";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307389-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307389-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86C5C302DFB3
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 08:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF473EDE40;
	Tue, 14 Jul 2026 08:25:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0D83F8EB7
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 08:25:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784017524; cv=none; b=NctBPDPuPbnHZE5lSDKXIGLm38jcistACeSeeQqcpe6PgxMO2inIvQLMgxtChqXckcR+0BlDXAY4JXjjKSE3CwEcpzg1RTAgWz0qOhQ2ZtxYExiISuMynnP/WRFKh0S6QW/pMB33/jy2qDNcw2oN5UZO1LvtRnN7tCUokG/oFYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784017524; c=relaxed/simple;
	bh=Mwbnhj9N+bChxzWMPQVb/tX7I1RBQGFrsOYlWCn2Wos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mBPEbPPj/FHuWISZuGmqSixQSgD/xUOB1C/oyrHcmYvYGsjTeve5Axk1JgWEiYOvxZNCpFt46uQBcAiYu5vkGI3qE87s5WNjR6OgwbUoHHdxqgvlckkWsCTOs2APYrKtn71rtWEr/G0DjMyXHAST7t3u5OrjVVDe8mJqJqqXJ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=giy/cU2f; arc=none smtp.client-ip=209.85.167.47
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aec139da7eso694545e87.1
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 01:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784017517; x=1784622317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2aq9ASsSVVcCb27XWhYTSc8/QMqg/E/6IObcZcIPIKs=;
        b=giy/cU2foZ00BP+AAsqLLwrFBOuhJN3Tv9QMNapN7LSoDv4f7cNGsqrWIYZ9TgYo2f
         hVj2CYkHsRK7OQAzmWe5f3EH4GOTLD8MERZyQnxRU5bbARPIvfjmftgz5s1mvAPQzFH7
         HF1rcXAMjYTJKHY5aM7WSCPLHfLPeuuVSIQHBGx3AlTHrn/c+mjJxA1NQvBNijEpY/4x
         d4EmTgABNsrVN2gqUKKwEeeMm6YcQOe00T338Gc6kAghkmBBqJEoaRkaPCWSo18NVmcx
         50MsOvFdvadzBdTTmmGX2khT4Wflq08ro3TrczpX0AsnDfIUHmkwYxciCKMwDAIG4gzA
         m7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784017517; x=1784622317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2aq9ASsSVVcCb27XWhYTSc8/QMqg/E/6IObcZcIPIKs=;
        b=GUqaNvTsPbdySb8uDXjsHHqkriUoyRS4koy/L86c1cAOyQzK3IYaA4IsVatuixO86R
         kyeOMBN50kH7QBcwIwXfpksPEqsPOcvn5lKDtD+A1hnytih0jy7Bu+7OtFtSf7lpUEeD
         GmETGjLO/kCVhbr03RMtZkzyaz7w59VD4O4JIxSwjhqLADRzdWI8syTGM9AtIKHRM/qq
         O5iQ+yZ1DwaPNSJ8ecOMk9osbZHyWdO72QUBenDB6pTMTNkJslI3U2eJ8yT28JDjN6VN
         lB5eXGuYVSNXrMD0e7UWslptGZ11qAfTLNj/GUhUCfZKWZ0bGiRwOKUhS+yxg3jPLsww
         zpEg==
X-Gm-Message-State: AOJu0YxMoq5d7IzNBoutdNLvCSB8Eo2K0Y5XCXbFsS5X78dScmSLaMpC
	AD4E1y99ycgABCpwaGGsUq+odORa9nqArDtoJX3wn4O9pnkMXM+7b3o13bJwlnTyV6o=
X-Gm-Gg: AfdE7cl2aAnrMVsZz4K4NjjbBJw+ibD7szj1NQKFwlhigSS467FgGyXfu/wybLKr+Dg
	obl9BBgRqHQxr1r/aP27uqqDttiYopAKTLRO86CKcaJhX/TKDUEX1YfDML/02h2Z+lE46rkJMEE
	DPsWhyPPhb+fLfFgVOgaHbX4FHwMF17kkJmKguFPTbeL2CJtIHidmYl0Yv9KAbUM1vR3GWdCymz
	AMxUi8MKcpA2QxNyK1qVStXZLlCWdq0Osi5fnSQV2AEdudpkeImNuBXbw9b2JbHjSz0s6KkAe2J
	7p73E4hs98FKranBVRUvGTRanN1IwP8vqyN35RcZB8g7megBnZT3KR5an7I/aq0dN5PU42jmLml
	nnNOlFt8kvU1vR1MSYUJo192XccZJPy3Qg1h6tCkSFSdaClHYwHNpgN0LdlFa5DqbVolRSXgb6d
	Sq6DygtKskKBOrYmKbJJwgmxQKatGNGC8RZoAJRByHpiIoXOWKEMEzKqpdDv/wh9z/LE3DofV8c
	iExD9Y7VdiDUKPXdw==
X-Received: by 2002:a05:6512:22d0:b0:5ae:ba93:abe with SMTP id 2adb3069b0e04-5b01c55a3bdmr2888577e87.30.1784017516359;
        Tue, 14 Jul 2026 01:25:16 -0700 (PDT)
Received: from debian.localdomain (95-25-161-220.broadband.corbina.ru. [95.25.161.220])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39c84b9382esm30676591fa.29.2026.07.14.01.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 01:25:15 -0700 (PDT)
From: Igor Putko <igorpetindev@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Igor Putko <igorpetindev@gmail.com>
Subject: [PATCH] net: core: use WARN_ON_ONCE in datagram iterators
Date: Tue, 14 Jul 2026 11:25:11 +0300
Message-ID: <20260714082511.2817-1-igorpetindev@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307389-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[igorpetindev@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:igorpetindev@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[igorpetindev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 29AF27526B4

Datagram fragment iteration helpers check for invalid buffer offsets
using WARN_ON(). In fast-path packet processing routines, a malformed
skb or lower-level driver bug triggering this check can result in
unbounded dmesg logging.

Excessive console logging in data-path contexts introduces severe I/O
latency overhead and risks triggering a DoS or system instability
via log flooding.

Replace WARN_ON() with WARN_ON_ONCE() in __skb_datagram_iter() and
skb_copy_datagram_from_iter(). This ensures anomalous conditions remain
reportable for debugging without spamming the kernel log on repeated
occurrences.

Signed-off-by: Igor Putko <igorpetindev@gmail.com>
---
 net/core/datagram.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index c285c6465..125b52870 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -416,7 +416,7 @@ static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
 		int end;
 		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 
-		WARN_ON(start > offset + len);
+		WARN_ON_ONCE(start > offset + len);
 
 		end = start + skb_frag_size(frag);
 		if ((copy = end - offset) > 0) {
@@ -449,7 +449,7 @@ static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
 	skb_walk_frags(skb, frag_iter) {
 		int end;
 
-		WARN_ON(start > offset + len);
+		WARN_ON_ONCE(start > offset + len);
 
 		end = start + frag_iter->len;
 		if ((copy = end - offset) > 0) {
@@ -570,7 +570,7 @@ int skb_copy_datagram_from_iter(struct sk_buff *skb, int offset,
 		int end;
 		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 
-		WARN_ON(start > offset + len);
+		WARN_ON_ONCE(start > offset + len);
 
 		end = start + skb_frag_size(frag);
 		if ((copy = end - offset) > 0) {
@@ -594,7 +594,7 @@ int skb_copy_datagram_from_iter(struct sk_buff *skb, int offset,
 	skb_walk_frags(skb, frag_iter) {
 		int end;
 
-		WARN_ON(start > offset + len);
+		WARN_ON_ONCE(start > offset + len);
 
 		end = start + frag_iter->len;
 		if ((copy = end - offset) > 0) {
-- 
2.47.3


