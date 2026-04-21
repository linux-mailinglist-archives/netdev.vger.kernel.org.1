Return-Path: <netdev+bounces-280030-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8O1nNxsq52mo4wEAu9opvQ
	(envelope-from <netdev+bounces-280030-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 09:41:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BDF437C12
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 09:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2FBD030234EC
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 07:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA478384251;
	Tue, 21 Apr 2026 07:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWXGP0GI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DD9384249
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 07:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776757069; cv=none; b=oqUd2wB6zILhIz35d64huxG+xtPZrCoAldDplOiiidnPogGAW3xvNmYnStgrNc3lP1FI7qu4G7+0Qe3sOlTefzAAXvj7zJxMIh8/Zq1qh3JQONxdbt8FxlY3Z+StvT2bHBSGKO8kNbzvlQGYDFYMlA872DyKZry2rZ5bl6InwPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776757069; c=relaxed/simple;
	bh=rt4wqxwDz7bsDxeraQEO0K5hU8JIJcUXKnSVXRUwNTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UT91ceNAWCftKky5BnKFTeqYrufIyiGjDKr3lSiGaqC8HUQhD5tD3gEoOk2m/RKm1AY/b35q/YcmEncZpSHLIWX+r8xjbkTYUwE+mPUXeqej3eCTOsI1a2SF+rgqtKqnALnZqGPL3AKSlHIixrgg7/GX5arJAM26B2HkVYp8tI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWXGP0GI; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so2338735e9.0
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 00:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776757067; x=1777361867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9MSpkDs/YA1OHYfaSUQ5bT/WJy5enL5wzyN0Hj8Q2s=;
        b=WWXGP0GIQ24RyQosqY0cq0/RzQfNrVMcW0JIwJL9Tf36FLaTiZnEj17M0m+OgK40y5
         4d5RIMDijF5gssP5ElMMokTF1Ev1cu3Ig4oUG5MLIo4pDXkep0iBo5H3iag3sM7vYApl
         upNH72xlWI30KWnblYn+zu3ikW+K77A0pJg3mIrhsxH+/gSgNgcWs/xBvEJtacJzsOA5
         rDbZG4ltoZ7umlVKCYysTC5veGltc+2UxlIMwja5ic+EWrrvYmBEIRwNuG2SF/sW8H6O
         +Oi1/luEoCO3z+O0nZoJAeUNTaFQQuC9cNdT4slKRUI/xcBC9hFpaohVzA7kbHdZCV8e
         II0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776757067; x=1777361867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9MSpkDs/YA1OHYfaSUQ5bT/WJy5enL5wzyN0Hj8Q2s=;
        b=A01chSRZC1G+Vdvff0iJZMWyrw3HZbg+EoDFWGgObMbDxbvrOZVw3KdHZnvICPRIlv
         H0PRzPNYsCNLpUgjtOx5JO93BSc5IwVwp4E52r/fRziPKUqzNLQeNWIY3c/ny/ZRYT1R
         GXnrJ1nEYp6ZMo/0Aak9X7unqe8l3X0eJ+5Nf+/PUtOt6hPYlrm+L91FarlpPvq7nfFx
         Qj72AdxyFOxZGTJRnAz2TYQEvImhs4r0dPEQi5Xp6g12kDxREwogBzqXHpQskKHG+ixO
         KDMPRIz4OmjT/7ti8zFKHLTEkiAeaY+3+h+pp3f9HJ1zFFuFYmUIF7k6Ou0sEouYRac3
         v/ig==
X-Gm-Message-State: AOJu0YzQ3aoD33njCgYf1HD4nnne9i1oE/3DoRD7UcdRZLxU6jjd9+pP
	HQXbu0wHzdifi1BZLhALA0agVv9aDE+hRiN3JX5wVQ37504EaGEWik9yj8Odxw==
X-Gm-Gg: AeBDieuPs+NcQVynu39toDvFkUthtvpQujbSJsXznoZTZOHmERFTLv3yqEslgFFj5pz
	XwMeivVZ0VPhVwkSGzPuyi5zRj808/+/gcbIurSQlddUDHAd61m2w+kJf6M/S1soRAbnwa99GsN
	Qz0XzjEo/PpdhJnOrDyXaGBmgoE2gr4EvnWMn+Fm0klVgnQa2jXfLC5rpgFkiPYIxkxGZhc4WEe
	FAmIt+gGwiHSkq9isbGtooXDIYTJG+fdBEN8FLJ0hH01zgyXRvdug6xH2zjGtBUTx3Jgfw22eba
	nC0UNVh12WpN/mTkrUC/sXtW2YHZ7WOT8vG2tgmdcXuyKBLaD96CMqp0odvw9KM7YyDXMJ9/iGC
	ojLUoBXj8MStsb0zyfJuWQWXMImtVbnIXzJKrRVNrz+K2UkRLz35JQjkXvcEdGQzDNPQ/BX+hp7
	kIQ8CVsP7NSqoELxwCr5Yegs3/vcSEBw==
X-Received: by 2002:a05:600c:314b:b0:485:3a86:6392 with SMTP id 5b1f17b1804b1-488fb778b66mr217390275e9.20.1776757066300;
        Tue, 21 Apr 2026 00:37:46 -0700 (PDT)
Received: from fedora-dev ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc100162sm373883825e9.5.2026.04.21.00.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 00:37:45 -0700 (PDT)
From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
To: kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Nikola Z. Ivanov" <zlatistiv@gmail.com>
Subject: [PATCH net] netdevsim: Initialize all fields of ip header when building dummy sk_buff
Date: Tue, 21 Apr 2026 10:37:38 +0300
Message-ID: <20260421073738.22110-1-zlatistiv@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280030-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zlatistiv@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 59BDF437C12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Syzbot reports a KMSAN uninit-value originating from
nsim_dev_trap_skb_build, with the allocation also
being performed in the same function.

The cause of the KMSAN warning is a missing assignment of
the tos and id fields of the ip header.

Fix this by calling skb_put_zero instead of skb_put to
guarantee null initialization.
Additionally remove the now redundant zero assignments
and reorder the remaining ones so that they more closely
match the order of the fields as they appear in the ip header.

Closes: https://syzkaller.appspot.com/bug?extid=23d7fcd204e3837866ff
Fixes: da58f90f11f5 ("netdevsim: Add devlink-trap support")
Signed-off-by: Nikola Z. Ivanov <zlatistiv@gmail.com>
---
There is a very similar function in psample.c called nsim_dev_psample_skb_build
which is almost identical to nsim_dev_trap_skb_build except for the
allocation flag reflecting its non-interrupt context and the fact
it does proper initialization of all fields.
Since these 2 are almost identical would it make sense to combine them
into 1, possbly by passing the allocation flags as parameters?

Thank you in advance for reviewing and answering!

 drivers/net/netdevsim/dev.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index 1e06e781c835..64b7cc3a6575 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -829,16 +829,14 @@ static struct sk_buff *nsim_dev_trap_skb_build(void)
 	skb->protocol = htons(ETH_P_IP);
 
 	skb_set_network_header(skb, skb->len);
-	iph = skb_put(skb, sizeof(struct iphdr));
-	iph->protocol = IPPROTO_UDP;
-	iph->saddr = in_aton("192.0.2.1");
-	iph->daddr = in_aton("198.51.100.1");
-	iph->version = 0x4;
-	iph->frag_off = 0;
+	iph = skb_put_zero(skb, sizeof(struct iphdr));
 	iph->ihl = 0x5;
+	iph->version = 0x4;
 	iph->tot_len = htons(tot_len);
 	iph->ttl = 100;
-	iph->check = 0;
+	iph->protocol = IPPROTO_UDP;
+	iph->saddr = in_aton("192.0.2.1");
+	iph->daddr = in_aton("198.51.100.1");
 	iph->check = ip_fast_csum((unsigned char *)iph, iph->ihl);
 
 	skb_set_transport_header(skb, skb->len);
-- 
2.53.0


