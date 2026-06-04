Return-Path: <netdev+bounces-295291-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zxOFDf2TIWoBJQEAu9opvQ
	(envelope-from <netdev+bounces-295291-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 17:04:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8114264132A
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 17:04:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Vz75So96;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295291-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295291-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B1CA319C708
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 14:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1F92FFF8D;
	Thu,  4 Jun 2026 14:48:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCAD2F1FD7
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 14:48:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780584491; cv=none; b=ISCyL5z120KjE3gF+gPnoEoGCFykWqZWTgiYzY9ZCCNXifD8cpc2p1hVa7Y6yrlQxaVMzMjDmWNrVdg4oeSTVV63dMXvdNNlt/IDF8KlxlJHGT5wYwi/5Wg02UCSgZE7DqkeFuSYu0S/yz0dOpjCzx+9uUKE19/XPCrTluw+dQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780584491; c=relaxed/simple;
	bh=FU9HER91Ej/OZ0yUd7/32NVYa2fHomlz5PZtXaVPMVA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Px11hihDqp4lZHK/Uss4ipQwoaAwJKAOtTejWoc+uxY3h4Gx7G8xLZgbooqcrEleN6xvJf+blWLcJtAyBMq6gRJjUcFQEhcCtsY5ZcePuIujMkR5UUUnJXHLKOwA5Ic1hJktbaQ4LaZ7Bpg8HfU8rc9eFnoNZAPcOa2oX5V43kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vz75So96; arc=none smtp.client-ip=209.85.219.44
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8ccd847c282so413506d6.3
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 07:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780584489; x=1781189289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pzA+SFKwg+C2pc4VzZHUq5/yfmOXYjLGy/ckfsc4Rdg=;
        b=Vz75So96EVdMiOYd2oaZEPIXR7tLtDH4nmeKjUzJ1lFwxKOzy5uoVVjmP0Z1mDrCz1
         Z222huVOeratnkUFnCyqHUz2G8kYutov5cKdTwxn97j+XZV+X0yaBZSKrsp1c2RwoTBR
         dazShhnxUBbvzWeFoDwEEoGGOkjknx37ElfeQBnIryh+Fly99SpNCgrgoQEiJs8ITGC/
         1aAwHKWyFHwq0SgX3iKqO1qz1uHRX9wCKNnWaeWnDe9LxXjbknvETmfWwM3X9f9Z521s
         NVAKQTZ6XLWS1ZgpFAi4UkG3eivMCI/aT9+Rsh+6RqDMKUMpToAeGtfKFqkQ4BftqBK6
         ObQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780584489; x=1781189289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzA+SFKwg+C2pc4VzZHUq5/yfmOXYjLGy/ckfsc4Rdg=;
        b=ZRJW5ncpmiNu3X98Dw2wcDFERlrE/lBS25pF3nBEkErokCYjyusPrKpbDAxk4AhgPT
         ar3uUl/i2gY2WKbOR74vGE8oSApoq7kCd6HKWxnPMLGQ1Ya7UMpd09a3rcggvNPLX6xx
         nOUDl9TJ3Z2EA9aCxoxUxZhIVAsSm/MmiF/lwShdmlHKSHYOEN2KWQZJmB8ONqYGN/up
         hg9O7rCtlRuJx/j3bWpDjU82mPY+HBx8ikYc0lZOHcD/YbtgWkkl2HVbw3ykcrnFMlNq
         qeq6daKIqHujUpQ5IstE3jOcqlWKUVdRViGokXMW8Ek7csT3oOGTbHjtToubYv1pSzrN
         2zgg==
X-Gm-Message-State: AOJu0YwwJclDwW4+ytw22zKJyWt9JTNxq3n3Y2clWmxVVvlMhZIJbpua
	Lp/kD+sHTvR6FjdZnoSMbsLFBE8qoDu3yPFi0JuPkE0kcw6Ouf+TPMzDPLDtcys6oV4=
X-Gm-Gg: Acq92OFxwc/86I7yNnnXJ02eOym+gyZlA8AjGiWk8WA5/G/rAK0q3uNw6rGHzE/5II5
	q86t3gd+bx++flz+umD1+BaKWNmuSiusODXhJb/5Lqm7r0byCm6Ns1t+I3ipZ9P9sbydAMrzYk8
	tEuRSmfh7SlFCDykgOsEDgwYQQEQWrMMfQek2ITAMbDk9C7Bg4WWZRwOHyKK9hygn/l6Fay29z3
	AJUk5uXYVbx34DFQTs8B0sK+c1mtjVu1uNqOeTohtA96uQfOuzFKD+Xixeprztacs0UbVATaqwZ
	JE9JW8/wVgT2QKn2fXztIYydcg8jgUSLxhOaPoiYnBGhofLpY/Ym5spo5kqAdakZ37zCS53KnPz
	ons7yHPxgekEjKWbrD+bxjz5qNSc5Seo33g8mnGe1HEA3hrH8xLzgIdiiqS2ertObWp6BeQzniK
	E08gKGbabpVoQ5jt8JKvEORE5P9R/S6CgTDh8SRnSVMzDRKRq+KrNySRgkVZyUY7pj5+8QR71wU
	CIB3TDAQZy3+F3ORhBslYJX7WBsw4jixs58piCQ/+o=
X-Received: by 2002:ad4:5ba8:0:b0:8cc:ef84:d144 with SMTP id 6a1803df08f44-8cedb291390mr31492766d6.1.1780584489274;
        Thu, 04 Jun 2026 07:48:09 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.82])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd26b3b9sm54736026d6.45.2026.06.04.07.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 07:48:08 -0700 (PDT)
From: HanQuan <eilaimemedsnaimel@gmail.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	security@kernel.org,
	nbd@openwrt.org,
	HanQuan <eilaimemedsnaimel@gmail.com>,
	MingXuan <bwnie0730@outlook.com>
Subject: [PATCH net] net: add pskb_may_pull() to skb_gro_receive_list()
Date: Thu,  4 Jun 2026 14:46:25 +0000
Message-ID: <20260604144625.3860228-1-eilaimemedsnaimel@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,openwrt.org,gmail.com,outlook.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-295291-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:security@kernel.org,m:nbd@openwrt.org,m:eilaimemedsnaimel@gmail.com,m:bwnie0730@outlook.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[eilaimemedsnaimel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eilaimemedsnaimel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8114264132A

skb_gro_receive_list() calls skb_pull(skb, skb_gro_offset(skb)) without
first ensuring the data is in the linear area via pskb_may_pull(). When
the skb arrives via napi_gro_frags(), skb_headlen can be 0 (all data in
page fragments) while skb_gro_offset is non-zero (after IP+TCP header
parsing). The skb_pull() then decrements skb->len by skb_gro_offset
but skb->data_len stays unchanged, hitting BUG_ON(skb->len < skb->data_len)
in __skb_pull().

The UDP fraglist GRO path already contains this guard at
udp_offload.c:749. Adding it to skb_gro_receive_list() itself provides
centralized protection for all callers (TCP, UDP, and any future
protocols), and ensures the precondition of skb_pull() is satisfied
before it is called.

On pskb_may_pull() failure, set NAPI_GRO_CB(skb)->flush = 1 so the
skb is not held as a new GRO head and is instead delivered through the
normal receive path, matching the UDP handling.

Fixes: 8d95dc474f85 ("net: add code for TCP fraglist GRO")
Reported-by: HanQuan <eilaimemedsnaimel@gmail.com>
Reported-by: MingXuan <bwnie0730@outlook.com>
Signed-off-by: HanQuan <eilaimemedsnaimel@gmail.com>
---
 net/core/gro.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/gro.c b/net/core/gro.c
index a84753983467..35f2f708f010 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -232,6 +232,11 @@ int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
 	if (unlikely(p->len + skb->len >= 65536))
 		return -E2BIG;
 
+	if (!pskb_may_pull(skb, skb_gro_offset(skb))) {
+		NAPI_GRO_CB(skb)->flush = 1;
+		return -ENOMEM;
+	}
+
 	if (NAPI_GRO_CB(p)->last == p)
 		skb_shinfo(p)->frag_list = skb;
 	else
-- 
2.43.0


