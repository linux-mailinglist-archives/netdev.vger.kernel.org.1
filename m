Return-Path: <netdev+bounces-296897-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mNfBAQGTJ2o7zAIAu9opvQ
	(envelope-from <netdev+bounces-296897-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 06:13:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9123565C2CE
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 06:13:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=iGoZypR9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296897-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296897-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0479C30383BA
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 04:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDA536606B;
	Tue,  9 Jun 2026 04:13:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C4A31E82A
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 04:13:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780978430; cv=none; b=MnMmZAEGo4fz6APdJtR0fI2Pfuh94DCjP/aD+N7bUO5EZXv0yG+iLthiJJT6ufeQSe/nNggY/wcdCiDL1Fw5MQvlse3QPknj6uNCilti+UKRQX7GLB/nRg+6zxQgY7Habz4bZT5tHYCM0gqbcyjHwPlldWcgFvxaPDWueFCsMbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780978430; c=relaxed/simple;
	bh=9MBVBMHX3XBMglgYtRKCNWwhMLN3vIETVwjBNcKSKqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nn/L9r+KwU2HRVooDxEfe9QBR8gVmJP7FrKkW2LuVPLFFFvvmeRacb871+0hhzhxiGni2+7ddCNLLHspcfuoGw74wlcXo5RmDc8HDdB9NU5JssMM7Kr6htiEuj17iuFmRJeq3qUd5gnzBuwvUYtgCNZe8a3o9z/HzAr51kZxyH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=iGoZypR9; arc=none smtp.client-ip=209.85.214.169
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c0c3546924so33038115ad.3
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 21:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1780978429; x=1781583229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jzoVF3GrkcAg4eBg7xLx+ZS0r0tXMtVkGacnCT+mMGY=;
        b=iGoZypR9wAowVcBG0E1wh1ZSyZmvqXSaon2g8ag/WevngCNTQPmtY6DO52mBzHmlW0
         mrNm01q18WLVFTXLVIgvlFiwnztnymm/B7THrwJW3brCswNUIbkcMUE6Z5L9o45JPCvb
         dAyM9zhfDZayVvqufjpM+BMpXKhZ3cTSv0N3wPNIld6DYqrnxHjopqFjYi8nSWWkLu/B
         rovgtXlPY82pxI80NVzvTXnBm2xpax1K0B15u2xd3i/myzH5DIT+glxhbIZyCUK21c21
         1ANRlIQ0aMwxdluve+r/zvNE1FwSJxdNKqNcHzlibDrJK5/vrHRlx92IGd1J3SDW2V8y
         c08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780978429; x=1781583229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzoVF3GrkcAg4eBg7xLx+ZS0r0tXMtVkGacnCT+mMGY=;
        b=I/m/d5G3Pc9BbWPxdlrR6DI1CCH9fYIz2e6s4MlMLRTathdyapbZ1LeE3Cs6cwKl3z
         rh97Vmv4cPBPmXeCHEEvgJzlmYc6EioCENJov9n8H7L8bS1qnh3Ri0obu9M7qf0619IS
         jxmPY/8UIiJWE4oB7gwkPYX5pPGF0e1ur95zKcNE4mg3GZ995auhAEEHiT8OygzjP0aU
         czuMcZ12PvM3AnA735ArQMlngEbHAOEoGcOtzhq/d3Vwmv4VU1ohlg6SF/IXJTcWiD/g
         d1zdtd3BxCesJ94HV5t/ubIwgW+Q5zWOTZzthrVDqUfFW7Mnyeus5hffWwNHYUPnL2gc
         Co9g==
X-Gm-Message-State: AOJu0YyWQEAs9cCt79yLBa3YqRbT9jhOw0WmBG4xOq1m1NC6GAuBCLRz
	w6hMIRuz0T75KiaZ27seYESblG9K5ShhD/LdkDdDzshDOJZwkLq3XRlsFUH7G6HXUdip+df0I9L
	7Ft7AIjAR
X-Gm-Gg: Acq92OE3yRho+0jRO8ms3YTAIRIj/kAg/B03S3VRMnCizjKxfZj/d7VVuOSgEoZoz/K
	yLYEBgavlm2Jh8ziZOZavwrJgb3o1cAvrSmcgSiavFFVbWtz8dEJbSN7lyGzsJ+TztihN9jQ9dY
	4DE4qb+TNH57wAn65d//93it4CQDgU/g82b8Nsveh9bdtAKtGtR95q1x3mgCXNbd5tKd8mjIV+L
	13NJnprM4jbHemgpejKM+uZIWj2lmN5Bakj58XznVYZEuPYy+RW6Ashk3XC9IA436PzNX50P2PS
	t9ud7bSnhhWeFt7IGfRyc2hhrIgEHp4knIPH4QmWxgjnFbr2npqlGvVXu9hJSbSGghvFrMkW3B3
	0J+UJhRQPdGaWddIyR/OqlecEpGoXYHYomw+LSYlZfjfnbe1ttkSApOUVdTlsbykU+lHYS67y8d
	O+Synczz6RJMr14cGODIfzsfXUUg==
X-Received: by 2002:a17:903:4b50:b0:2bc:b80f:6782 with SMTP id d9443c01a7336-2c1e821dd0bmr188851525ad.11.1780978428979;
        Mon, 08 Jun 2026 21:13:48 -0700 (PDT)
Received: from p1.. ([73.140.210.38])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f85de1sm197126035ad.20.2026.06.08.21.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 21:13:48 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: netdev@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Weiming Shi <bestswngs@gmail.com>,
	Kyle Zeng <kylebot@openai.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v2 1/2] geneve: gate GRO hint in geneve_gro_complete() on gs->gro_hint
Date: Mon,  8 Jun 2026 21:13:32 -0700
Message-ID: <20260609041334.2506153-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,google.com,lunn.ch,davemloft.net,gmail.com,openai.com,asu.edu];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296897-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:bestswngs@gmail.com,m:kylebot@openai.com,m:xmei5@asu.edu,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,openai.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9123565C2CE

geneve_gro_receive() reads the GRO hint through geneve_sk_gro_hint_off(),
which honours it only when the socket enabled IFLA_GENEVE_GRO_HINT
(gs->gro_hint). geneve_gro_complete() instead calls the low-level
geneve_opt_gro_hint_off() and acts on the hint unconditionally.

On a tunnel without the hint, receive aggregates the frames as plain
ETH_P_TEB while complete still honours an attacker-supplied hint option: it
inflates gh_len by gro_hint->nested_hdr_len (u8) and redirects the dispatch
type, so the inner gro_complete handler runs at nhoff + gh_len, an offset
receive never pulled nor validated, reading out of bounds of the skb head:

  BUG: KASAN: slab-out-of-bounds in ipv6_gro_complete (net/ipv6/ip6_offload.c:196)
  Read of size 1 at addr ffff88800fe91980 by task exploit/153
   ipv6_gro_complete (net/ipv6/ip6_offload.c:196)
   geneve_gro_complete (drivers/net/geneve.c:965)
   udp_gro_complete (net/ipv4/udp_offload.c:940)
   inet_gro_complete (net/ipv4/af_inet.c:1621)
   __gro_flush (net/core/gro.c:306)

Gate the complete path on gs->gro_hint too via geneve_sk_gro_hint_off(), so
both paths agree. Tunnels that enable the hint are unaffected.

Fixes: fd0dd796576e ("geneve: use GRO hint option in the RX path")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Reported-by: Kyle Zeng <kylebot@openai.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v2: Add Kyle as "Reported-by"

 drivers/net/geneve.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 715180c3a1b3..d0dc5d6c46df 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -948,13 +948,13 @@ static int geneve_gro_complete(struct sock *sk, struct sk_buff *skb,
 	struct genevehdr *gh;
 	struct packet_offload *ptype;
 	__be16 type;
-	int gh_len;
+	unsigned int gh_len;
 	int err = -ENOSYS;
 
 	gh = (struct genevehdr *)(skb->data + nhoff);
 	gh_len = geneve_hlen(gh);
 	type = gh->proto_type;
-	geneve_opt_gro_hint_off(gh, &type, &gh_len);
+	geneve_sk_gro_hint_off(sk, gh, &type, &gh_len);
 
 	/* since skb->encapsulation is set, eth_gro_complete() sets the inner mac header */
 	if (likely(type == htons(ETH_P_TEB)))
-- 
2.43.0


