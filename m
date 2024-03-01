Return-Path: <netdev+bounces-76722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DAC86E9B7
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 20:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33BEA1C23CA7
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 19:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913D43C47C;
	Fri,  1 Mar 2024 19:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sar4jvV0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0989E3BBCD
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 19:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321873; cv=none; b=nBmy/kCp8UtM5Axv2dpwd7HY1ThIVjtC69bK95zbPZlMsG4YfnbRzyacDiI+Ufj30v2/NZpH9Dj1ykuY559mYRWLawEdzgc4k7jnoRLnHRk8+MJEPfpmhdRYCSoXq6a9S28vHEUCteoJgNljxC9EIMRGeW4a+yrbPnJeuS//YDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321873; c=relaxed/simple;
	bh=rAn+kOgjPT01Ybieuz+bGgltV40x2pm2cf51Jv6KDK8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QMwi64nBHjmmRMbUy0WhbBklrVqTftZ0CV0Im29yof6QRHsTq/m/b+aBbBoQqdgXLxPTlGkJ7ghPr4995s3GyCfrsROFA4wseTPdDYs9mTSFbULqBj7NIxQeEgri40QUJxR6VlQwP17SEAn5t1NRnNaI9+a9sXzcUzm5ZpvOIQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sar4jvV0; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso3861075276.3
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 11:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709321871; x=1709926671; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jNMTH5/4z0N5NVuRkLpaJrGHTXoTS/bT5IMcs+2HcWo=;
        b=Sar4jvV0PHJUsEKQSDjCIQVLY9maTKzgwZzZmhkvU9KnGQdQBSHH7pM6/ndL9BT1fZ
         yURPd6X4B5bOFatrA1r2vG8mTRZbVLLKU3igkBfvzihuBMIPUW2iEWEi7VUh9pWAGOoB
         E3pGWJcMSAZP4Lv8NF27okcqouGkO4WmVhVew8ZX+C22gyqxcC+Miuv9oc1dLLUfyFfQ
         5zXrQRmZIeGPd+oDhIKu6rh7XrB7kEihcbPvraJ95EQsFD0jJTefWWPU97Ba67EL8JbU
         2Erbl39Eyopv1sGXS5SsDI+1Jze96UMXo6luC2s3bW4iclG4nXscS1p4asO7dMgJkqp4
         TE9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709321871; x=1709926671;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jNMTH5/4z0N5NVuRkLpaJrGHTXoTS/bT5IMcs+2HcWo=;
        b=smsul0V7h9ZafImHJCHihPHHYQJ0ZiywtckxsO38I6BhZKYNOKUKOqqbUjzt7f+BJU
         2Q5ZiIuQR5K7A4H/vaKr6btXxolsXgljbIwrb7EGexD/v4CgnPzp5PqiIRhiZTbNZiG/
         DQLhx4g95kc1jsnKhOv4SDwBT7aayScLpGphlbgpAMijklpihY9Lb7w0b55GIY4BkR6n
         8LvhFq3UHYgwn9WyPUzpsEngxp5/F0rOWec3eIARNSPp2PXe7P2JZhlH3cRBrEf9g8mR
         TMvijrxzN/vrMUiOT/poDte2D2LALq8GLmiOHrHJahg8j0sx2juh7CecSVvf3iN7YO8Y
         K5yw==
X-Forwarded-Encrypted: i=1; AJvYcCVJEa5Hb2JKtePHI25Bd/o5OxkXzK8s/I7Zv6KVTaM+7DWnrniKulGIFt+dy8bI/fUnAb+a/aOnqX3Ta0/CA23n6jlinsNo
X-Gm-Message-State: AOJu0YxIoUgFzcXRiV40BZ64zJr3rQMe+rATpoah2pNhesaOiL3Vd/+R
	cLCRiLL1H9YkpSCrUS1eY//u8OqXB4AOv+KPfQQEvVL4jGFcBwcAQzDBZChUeWygirk6NxXf1Wh
	p/vQBWOW68g==
X-Google-Smtp-Source: AGHT+IHyY0rOFwHjQMcT1kP1pRrkx5HISyqQdlcwMeSw7OMs17GhYN4gLMPSBTgR4eZ4zrvvau8FBdvVSWRQ/Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:b20b:0:b0:dcb:bc80:8333 with SMTP id
 i11-20020a25b20b000000b00dcbbc808333mr556607ybj.13.1709321871149; Fri, 01 Mar
 2024 11:37:51 -0800 (PST)
Date: Fri,  1 Mar 2024 19:37:40 +0000
In-Reply-To: <20240301193740.3436871-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301193740.3436871-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240301193740.3436871-5-edumazet@google.com>
Subject: [PATCH net-next 4/4] tcp: gro: micro optimizations in tcp[4]_gro_complete()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Richard Gobert <richardbgobert@gmail.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

In tcp_gro_complete() :

Moving the skb->inner_transport_header setting
allows the compiler to reuse the previously loaded value
of skb->transport_header.

Caching skb_shinfo() avoids duplications as well.

In tcp4_gro_complete(), doing a single change on
skb_shinfo(skb)->gso_type also generates better code.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_offload.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 875456efc92ddd546e13232dd775aaaf1093ce4f..b955ab3b236d965a38054efa004fe12f03074c70 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -299,18 +299,20 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
 void tcp_gro_complete(struct sk_buff *skb)
 {
 	struct tcphdr *th = tcp_hdr(skb);
+	struct skb_shared_info *shinfo;
+
+	if (skb->encapsulation)
+		skb->inner_transport_header = skb->transport_header;
 
 	skb->csum_start = (unsigned char *)th - skb->head;
 	skb->csum_offset = offsetof(struct tcphdr, check);
 	skb->ip_summed = CHECKSUM_PARTIAL;
 
-	skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
+	shinfo = skb_shinfo(skb);
+	shinfo->gso_segs = NAPI_GRO_CB(skb)->count;
 
 	if (th->cwr)
-		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
-
-	if (skb->encapsulation)
-		skb->inner_transport_header = skb->transport_header;
+		shinfo->gso_type |= SKB_GSO_TCP_ECN;
 }
 EXPORT_SYMBOL(tcp_gro_complete);
 
@@ -335,10 +337,9 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct sk_buff *skb, int thoff)
 
 	th->check = ~tcp_v4_check(skb->len - thoff, iph->saddr,
 				  iph->daddr, 0);
-	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4;
 
-	if (NAPI_GRO_CB(skb)->is_atomic)
-		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID;
+	skb_shinfo(skb)->gso_type |= SKB_GSO_TCPV4 |
+			(NAPI_GRO_CB(skb)->is_atomic * SKB_GSO_TCP_FIXEDID);
 
 	tcp_gro_complete(skb);
 	return 0;
-- 
2.44.0.278.ge034bb2e1d-goog


