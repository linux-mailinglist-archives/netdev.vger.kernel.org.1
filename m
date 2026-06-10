Return-Path: <netdev+bounces-297860-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W8BMAJHzKWoigAMAu9opvQ
	(envelope-from <netdev+bounces-297860-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 01:30:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4463166D618
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 01:30:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=L4xJmNka;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297860-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297860-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E33D03158C79
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 23:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD825299A82;
	Wed, 10 Jun 2026 23:29:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6938B37DAD6
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 23:29:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781134185; cv=none; b=DiSstbV2HieXG3spSdAnn0M2FjBUDk+9ERuaGUqQ1jJAtLTv0fiiQoAOHfiEOnVU0GuUPo+F4K2X9a2VFlGggFojBbbpZwlXGySwDmOUKeM2W/bGRLw/xqlgnbp6XvSYEpW+VVPCH+ySBHvILa345EbUinR1/l8kP+0EAffC6Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781134185; c=relaxed/simple;
	bh=VmL/XyDWEuE0QsbaGtnBZ4YmZiYfGkfte0l+rUVpi6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mniEQk5gcopp7zMAiSSJBy95wMgy0lPHg8JiQ1q6+owDyXLEM2iwFmXt747gwSuF1IrA8j+UIZPwib7d/g2rArQu9+EuakMwhVtaF2gMFmUtELquZWhBTba/BYY9oRo0aDkxuMy7JTBHRcNxYpP/Xm2owYrSzWXlsp3ud6V9k5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=L4xJmNka; arc=none smtp.client-ip=209.85.214.169
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c0c3315c5dso76246675ad.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 16:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1781134184; x=1781738984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tbtqprzo1bFuxnDYsSnM79zDHYhOXlVVzm5C0yyeVNM=;
        b=L4xJmNkajTQd1/8Q7apZ3vCN55xFiWC2y/gY3+cFpgAJAacoJ+hY2Ab9pasuy86G+j
         JE4KL4YEmdvdEyfeNbY4ZLUDzfeyDta74zS0nOP1uuXDs9QOR7SltgMfFA2zhc/aEqY6
         bwfoOKZbqTO+a0qjA+85EanBUR3Wt2W7ryJDB9FL6rgMifWz2lJyolq5Kez/DpdZ6YXN
         b1ep5TobOIm5eHQt01mSGSQ5rSJgBkKNzTdPif16fTI1ixM0e+F7hyOS+qPqsFYxTzPX
         a74iN+VpGLCnVgjmdUp3P7Q6Y6MSsOmpI++uVr36Q1sDy91FYnDAzLpeVy2w8PYtbmjp
         nGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781134184; x=1781738984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tbtqprzo1bFuxnDYsSnM79zDHYhOXlVVzm5C0yyeVNM=;
        b=C3gHZyxavQeuBFcdJS6ni0YNPahLauOyMcVmMT1kF5UL7aK3ZsMe+gfzmVO+4Krb52
         c0wq3ACfK7PEh/3op1vRXReh+OHZBuFKNYxTgi1rWJ/90j8AA5bblmmr3rBmVhZxQ+84
         yaqaHv3Ir6A8RpvtZJ6ruHuG8U2RqNsJmStjEnchiY4TMoYPnE2TllH1RO/AcIS0+XAd
         AXNjp0h4Inaprn9mCOYHAnA9D4unhHAVNWwb1NPXLYi1leFT5TwgfBLZZ41DESwyBsRB
         ASfYG4/v+4MIa4WDGlFmC2x9PDLuj6As/s/279yHxwvIjAHtAe+anCqLVp6J8kkyyslo
         fQSQ==
X-Forwarded-Encrypted: i=1; AFNElJ88NKO/g4k6NDM7zCDchlI21BdeZn/V1Usubm5Zuk6ufDNYfhCGRUd544YoKQeZDmk9CU6gBNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpg+ND6csSiBnaVB9hLr3Ajw0cIh603tXHIWy67J0d9/bzwNck
	oimMdwind6hoQ32PjrDYb2+0ES/XY0Ia5S4rU1ajXi+pzqZI3UJigVOmVOh8R+ZJeg==
X-Gm-Gg: Acq92OGIlQMJ6x3r8vzn40EPzetgPf0QjBlhRIBWw0GsQrhZ6im7CXYIu0u2C5xDBy1
	krg+xPkhfl7LakovfR6wKX3dtTyQwfxvDBvYf3dWV8ZdzVTyRtFwnpgE3t5haO0al7COAmcqvB2
	QQAKz1wvrRIPnVDvu5mfsoznVt7Oqd0sIaabaND6wvyaY9zH/nbU3dYffCWhkl/K5+El8ZK9Sve
	ioc81CTF/GCCrMkwySfoNJUpUBnOH9PTL7YMx+gbBvEfy1S8u2sPzt2GHchFYeyIWfMHeTOwsRU
	lcUCgPhGVdQgxkkTDByfZpLxjfY3fppQyfMbpurPiHIEgzwuOWyhGK3wUalL9D3L7c1g/uvNlTy
	IM9dRVWwwLROP44k2FbFpNkg2/elcZJeN4BfSrIk9VnSxwwNOJZqMt06lzDqfU8VIWHXtn0LSYt
	9fdO6yb6j6jnwiZbCkWFEd0a1MV5pb2Q==
X-Received: by 2002:a17:903:3b83:b0:2c0:ab82:6ba7 with SMTP id d9443c01a7336-2c2f3055e26mr1288055ad.33.1781134183883;
        Wed, 10 Jun 2026 16:29:43 -0700 (PDT)
Received: from p1.. ([2607:fb91:1582:d2f1:7bbf:a7c4:749b:120a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d090sm242781845ad.55.2026.06.10.16.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 16:29:43 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	minhquangbui99@gmail.com,
	bestswngs@gmail.com,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net v2 2/2] virtio-net: harden page_to_skb() big-packet frag loop
Date: Wed, 10 Jun 2026 16:29:36 -0700
Message-ID: <20260610232936.1176094-2-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610232936.1176094-1-xmei5@asu.edu>
References: <20260610232936.1176094-1-xmei5@asu.edu>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.linux.dev,gmail.com,asu.edu];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297860-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:jasowang@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:minhquangbui99@gmail.com,m:bestswngs@gmail.com,m:xmei5@asu.edu,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4463166D618

This is a robustness hardening patch. The slow-path frag loop in
page_to_skb() walks the page chain via page->private until the
device-reported len is consumed, implicitly trusting that len fits the
chain. It does not stop when the chain is exhausted (page becomes NULL
at the tail), nor when nr_frags reaches the end of the static
skb_shinfo()->frags[MAX_SKB_FRAGS] array.

Both bounds are needed: the chain length is big_packets_num_skbfrags + 1
pages, which for an MTU-driven configuration can be well below
MAX_SKB_FRAGS, so neither guard implies the other.

Make the loop self-defending so it no longer relies on the caller having
validated len: stop once the chain is exhausted, and never index past
MAX_SKB_FRAGS. No functional change for well-formed input.

Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
v2: robustness patch

 drivers/net/virtio_net.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index afe73eda1491..518c22fa1b68 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -906,8 +906,11 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
 	}
 
 	BUG_ON(offset >= PAGE_SIZE);
-	while (len) {
+	while (len && page) {
 		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
+
+		if (unlikely(skb_shinfo(skb)->nr_frags >= MAX_SKB_FRAGS))
+			break;
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
 				frag_size, truesize);
 		len -= frag_size;
-- 
2.43.0


