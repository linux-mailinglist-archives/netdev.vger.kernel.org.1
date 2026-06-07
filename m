Return-Path: <netdev+bounces-296171-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FGC9EpvKJGo+/QEAu9opvQ
	(envelope-from <netdev+bounces-296171-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 03:34:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 928A464EA72
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 03:34:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=openai.com header.s=google header.b=UkpcYPNF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296171-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296171-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=openai.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B4D83015E0E
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 01:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26D613D8B1;
	Sun,  7 Jun 2026 01:34:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD6422301
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 01:34:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780796056; cv=none; b=WMdwaKyBxgIhoU1k2Zg2mUZKJ/dDPOzbzNBVVa6WSEZaqckF/497UUv8apQloOvEKxzJj7aNhZoDej9G0JDdJeiJvZxeDoHv1yDhla27wM9PO/qteXUeoIBcmqMOfl3B1T6ICGkz6P6a1g1BanH59OPwtUFMFyefzJch4SOMvHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780796056; c=relaxed/simple;
	bh=xAwvr7E/y0R4MOOVbWmvvQOBuFzJLguFe1RSToaTUTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EJcoPVok6CWE+gVOIoeEeZI7PMtsO6wyX4xgqcG7L5+Sz5JuCheJjzmh+B95En1YvN8i9OeAimw0EezCMrcbz8re4ifv+20MxEO/PLxuoQn/FkCmhwdWuRgmTxZK0cXvBxj25apbY61g4/EGHW0Rvd8VHWFrBfBYGfhI0nPsm0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=UkpcYPNF; arc=none smtp.client-ip=74.125.82.180
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-304c520fe9aso4950931eec.0
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 18:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1780796054; x=1781400854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4MftsAp1BE4fUTsT0ZUfPG/Nvx6lbnO4sgomcwSsZjs=;
        b=UkpcYPNF/P+gW+ZSZkEQqamhVx7IROPFffGc2BkIorpLErGrMYAC5P3NuTXUvTsbla
         9+ZE49ed6yzsJ7EX19Qpiq8Ci/NqXmt9DLjJbBRjUtCT9tkbN13gMXuOHGKOtUfqcW+J
         4XgqFNpobbpiwub9S9UljqameDvxH5CkORE1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780796054; x=1781400854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MftsAp1BE4fUTsT0ZUfPG/Nvx6lbnO4sgomcwSsZjs=;
        b=YjjWXTs+V8Lw3WpVk0fDeffZGd/qQJTBKOs5PYlmqvD2v414IPzc4druM4XQwq4n0X
         6lKQ4fHdlc75c3hysn8/pzf3Mykt6YzV9W+JZhzSXfS7XAUhhgnhoMhGrZhjBJXpCVIo
         UlC7G4gO4dlu2B2ZiNH6b5D5WV4soGdfZxMeHMmbyU0NIqymKOkZ1cIGeDRIRHqjo4G2
         MbtjMZ4cT/IOiR/2JJMpUJnWonyHeFK07guvxK3/f0Ft+VVNcjZtoXh80GpxdRAMVnf8
         YlbrDi+kMTt1EiCyPeEyt9rb3QkJG0rOF5vAyDQXIWLEa3gMEc85u85gIzShlFDArmoz
         yt/g==
X-Gm-Message-State: AOJu0Yyo37NE76zXXmIcma05I01y6BRziBLbQjPNmWhW+23Dxvu1Z/ej
	YKfUUtIo2YRnLbaQWLCqH4osWEwRSwc3XOmtEh9p91+4K987UxR+UXNKFe+0+ghCq91LcKJf8Mv
	qq+6Ef/c=
X-Gm-Gg: Acq92OFP7eDNxVsRjwL0D8Lc7AD3HCv8+NRZCbJF+xt5aa8Nf6XNUTKVqymI9oJLOzC
	PUjP4l1KJSjI/uMWEwagve1TBZJb/hngpw/7XfWgiu065d7vsI4u8B3yo+5JqJL0KqmuOB43AcK
	Rz6bFlpoHmvX4lkMeZSiEKhObCIGPsyqTQdcjLOqFkV89e1Nd54C9Tbc31jbBnMOKwjdcuYKpU6
	a7yXoTUdOFoPBjQv602GUqT0cT1DAarN8Hm6MYoHBeo451ohv0RpY3ElAXkrFH0goIuX7Z90Hq4
	3C+9aUrh1BgPh8FmgdN45WlchX++ClzTcu8qxSSWHPocJ+Gzo3ewG+6Mw4s30Xn2+44qm1ANB31
	na1suh/lAj2jgAx7Jw+HajIqU4zauyidk5zbVrnlvZEjrgjqAMH5bUjnfTgFgrykWe97ObQUYKP
	O7b4u6SDRtQ5do1Ko3929juxXVJe06vjj95qv/LUsZYu/T+vNYWN0UlBUFYZTSDt3zKF6ctIDCK
	4LncV7UFZQceQQ3rLUqDkBplv+emPZgvfRqxqtwzFK0
X-Received: by 2002:a05:7300:534f:b0:304:b15:17d6 with SMTP id 5a478bee46e88-3077b357e93mr5922329eec.6.1780796054549;
        Sat, 06 Jun 2026 18:34:14 -0700 (PDT)
Received: from com-75606.node.ndb.openai.org ([104.241.0.233])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db85f60sm15576645eec.8.2026.06.06.18.34.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 06 Jun 2026 18:34:14 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kyle Zeng <kylebot@openai.com>
Subject: [PATCH] net: geneve: gate GRO completion hints on socket config
Date: Sat,  6 Jun 2026 18:34:06 -0700
Message-ID: <20260607013406.7294-1-kylebot@openai.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[openai.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[openai.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296171-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:edumazet@google.com,m:kylebot@openai.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kylebot@openai.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[openai.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kylebot@openai.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,openai.com:mid,openai.com:dkim,openai.com:from_mime,openai.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 928A464EA72

Geneve GRO receive only consumes the netdev GRO hint option when the
receiving Geneve socket has gro_hint enabled.  geneve_gro_complete(),
however, parses the hint option directly with geneve_opt_gro_hint_off()
and therefore extends the completion offset even for sockets that did not
enable hint processing.

That lets a packet for a normal Geneve socket carry a syntactically valid
hint with an attacker-controlled nested_hdr_len.  GRO receive validates
and pulls only the ordinary Geneve header/options, but completion can then
run the inner protocol completion callback at nhoff + gh_len where gh_len
includes the untrusted hint length.  This can make completion access beyond
the header area validated by receive.

Use geneve_sk_gro_hint_off() in the completion path, matching receive and
post-decap processing, so the hint is honored only for sockets that enabled
the feature.

Fixes: fd0dd796576e ("geneve: use GRO hint option in the RX path")
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 drivers/net/geneve.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index c6563367d382..d62cbee6c0fe 100644
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

