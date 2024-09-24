Return-Path: <netdev+bounces-129565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F2998482A
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 17:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3781F233B6
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 15:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1411AB6CA;
	Tue, 24 Sep 2024 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gc66sG23"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C751AB517
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727190186; cv=none; b=CdNjybf2d8dsuqqFVTBurJ496nkOE4mQAodbF4y2vBLIXJLwYStcJPmyhcg2+Z48Lw1K2wEbJKJQLb1vcTjNShje9hdrefOXdzkR8HdE3IGiKfVCFZHLwCi/YJ98E/WYCqDNC5rqBN/NFNLy7UDFXWLJAc2gx0Ie/bN/KZJsofI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727190186; c=relaxed/simple;
	bh=uH36kzWL1EBdTkFOXHjC/9nsGxPcfD5nMtqJg/GJiuY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=keTQCWrqijDgVfY60gwajHNgZJL+ozGzn6jWN/Rd08rc5SjdjCHfVa+HD+AzeuQT+M0Ps9ikORSvV8fIIgw1n78VhrvEwxvCVox5cFw0wytSFWMXFXNkCF/zklPXppgif+BgVqZVoaFkIPx5novwq3pGtpADqlLqSAL7GXNnYTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gc66sG23; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1ce191f74fso9617368276.2
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 08:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727190183; x=1727794983; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Un4IXmB0+ePAT/5m2bLmA+cooZOyhXf430sczYl0HI=;
        b=Gc66sG23CYRzWlvHHDX3tILXk9bv8LPqkQKvbSY/KVod+H24A8QhrvwwtcrlXQf0bt
         pwZ5GdeisCy4Mhv92ZVvZsBDzTMh+BYI79kO+MiUK1gBemHZBw5Z5JryALalRz7gQGkw
         HczCNzEzuBFps8G4NWXaQbDpC8PRhq0EYNp1m6VjlsF/qvd7VaLH9HnPm7DKzlRYTFRM
         2hCS69iAg3JRMIWmbC2nYEuvgqB2j96ICRGQwbYxyEbPuCAW6ptJp6gfCVARQUEWEyci
         AB1V8jPnzD1rtdiysyO9i2yEtbaIZd+M8hG2yn6l+ES2jkT2RI6TH0p/kzCROBhTiXpm
         glbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727190183; x=1727794983;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Un4IXmB0+ePAT/5m2bLmA+cooZOyhXf430sczYl0HI=;
        b=AfRq2XlLYrkOL8fYS8oErmpIhc44Wubu+fCsT52bfvj/U8pKsxSRDWIBZAavHfXlQh
         TBplZk2aTqmcm5kx4hajl/FaR083XFyS990Y2AudjPPfWw6+EZOdiGlAgAUFRk/eisaN
         x+30X00VldgZONyuheF8CvAjKFNqUViLqpTUF0YR76nl7TcT3WcyEAUwTWrlWlHzJgRE
         ZKR3323ASnNwLnNV8GXjEgAE95iZeCes/UlA04vsDtgHVHoIiZb6HMcSv/ZfXVxsXtK8
         DoEwSNA3VTaGAA+IFPYKhEmC2AmNNFk8u7n2kJq5iyT+bbXmebp1iXjjC6UcCdihbdnq
         4gog==
X-Forwarded-Encrypted: i=1; AJvYcCU1ZV4N6C5ACn/nD6SCah1CzVYbbf8GTVqKb/m8mrYz5B4mPxwyzpDUQrFGRYxOFKVLbOOyDFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ7OYITwZhuxxxXjzLS/WkaHhaw7QKXqCFmN/rDuqCYClXGRbF
	9mmgCxBBLVsJRwpiaHErCAJtnpatjZwR6+fBIIwuBlkyKzuTfnZPB8Xb1lVfMsuDvxum5gsheRU
	S817yITZuUA==
X-Google-Smtp-Source: AGHT+IFblErf3P728ZlcQ1ZStrOT/EGKi6CtIFcve5MnkjFOEHYuMx/u1azvXm4+r3ruRnzFiQqeCEtMJYPukA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:d855:0:b0:e1b:10df:78ea with SMTP id
 3f1490d57ef6-e2250c3b7demr11174276.4.1727190183474; Tue, 24 Sep 2024 08:03:03
 -0700 (PDT)
Date: Tue, 24 Sep 2024 15:02:57 +0000
In-Reply-To: <20240924150257.1059524-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240924150257.1059524-1-edumazet@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240924150257.1059524-3-edumazet@google.com>
Subject: [PATCH net 2/2] net: add more sanity checks to qdisc_pkt_len_init()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	Willem de Bruijn <willemb@google.com>, Jonathan Davies <jonathan.davies@nutanix.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

One path takes care of SKB_GSO_DODGY, assuming
skb->len is bigger than hdr_len.

virtio_net_hdr_to_skb() does not fully dissect TCP headers,
it only make sure it is at least 20 bytes.

It is possible for an user to provide a malicious 'GSO' packet,
total length of 80 bytes.

- 20 bytes of IPv4 header
- 60 bytes TCP header
- a small gso_size like 8

virtio_net_hdr_to_skb() would declare this packet as a normal
GSO packet, because it would see 40 bytes of payload,
bigger than gso_size.

We need to make detect this case to not underflow
qdisc_skb_cb(skb)->pkt_len.

Fixes: 1def9238d4aa ("net_sched: more precise pkt_len computation")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index f2c47da79f17d5ebe6b334b63d66c84c84c519fc..35b8bcfb209bd274c81380eaf6e445641306b018 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3766,10 +3766,14 @@ static void qdisc_pkt_len_init(struct sk_buff *skb)
 				hdr_len += sizeof(struct udphdr);
 		}
 
-		if (shinfo->gso_type & SKB_GSO_DODGY)
-			gso_segs = DIV_ROUND_UP(skb->len - hdr_len,
-						shinfo->gso_size);
+		if (unlikely(shinfo->gso_type & SKB_GSO_DODGY)) {
+			int payload = skb->len - hdr_len;
 
+			/* Malicious packet. */
+			if (payload <= 0)
+				return;
+			gso_segs = DIV_ROUND_UP(payload, shinfo->gso_size);
+		}
 		qdisc_skb_cb(skb)->pkt_len += (gso_segs - 1) * hdr_len;
 	}
 }
-- 
2.46.0.792.g87dc391469-goog


