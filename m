Return-Path: <netdev+bounces-82900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A38789021A
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 15:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E073A1C2D904
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 14:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1813112A154;
	Thu, 28 Mar 2024 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xImDMEGr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9287912D76A
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636840; cv=none; b=MtksoqEYayb/JJ5Q9Bvv18EMqpKWCTm47iFS5qZMxdDZZ2Vm3oZ1bdmlCouTCnLcSSIptNihdpIyloft7vL8yFAoRaPV2wZ/uEj6oIOJKzNWbvC9h49wWeEyxn+JMrXK0wGlW/KVoTq5eAkNW03xT7AxcIsg9WaS7pqlBW01k7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636840; c=relaxed/simple;
	bh=wIncWrswncQh1bRWLkOE4ukf9R7mdV4WgyoV/cDr3i4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ARyq9fJ+XDjhCoUnVTvg3c/WHpt5YZ874Ut3WOGNmx72J2ofOuQx4Efu3sns4PWyRN3QnN4hwvW34GsbizgSE3UBx6XpTDCWbI1sXRotL4wUXwKmwG86SCZji499uF4zWeYGjbUsmikLUYBcp6clvOJJt8XioOWnJ/69TGhIyJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xImDMEGr; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf618042daso1433963276.0
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 07:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711636837; x=1712241637; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=74e/xj321Yg8Kp/ugt0Wz2SNI5GKWEc3hdNqdlM7Rp4=;
        b=xImDMEGrPfTCl3hsG0TCswa0wZ9aBH5pHceC9TkDaGgcwmBllxK7xbtgbeESrH7a3O
         DNAdtmD9Xv+PstEaYt+vE1TQeJwtb5/ajxrbSR7/1OpwoKEbVTAm+qmcHvGir++uGyRJ
         sdr20fTE37LcX5MXyI19nCnN3XlepFdKWnts+jAVjB3IjH7rvIr4TkAdAvLTI5NMYlUe
         N5gt2ttq7L1nbtBTBoBt9Eh0Y6CPn1skNOxSbGmu/YRbbXiAc9s1ijJeAP+zbkEI/lcU
         AWsMVcmqxrdZPt0r9ORxkmfFsUwYshNDINtkLsK/g1YaVeGl/zcmb0fwRtFTm7DXk9gf
         dBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711636837; x=1712241637;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=74e/xj321Yg8Kp/ugt0Wz2SNI5GKWEc3hdNqdlM7Rp4=;
        b=WG6yi0a5O/JxXvt9QZyivy4cqjYfDNcpKrfp+dObBsgjfsxzBppFlpv+WE2uN23DAA
         vWcN87xr6mKQyp1DSgI9LPMFazlhyh+vi8jlB3n6QOUTPoYR0e5T+UqGzXju2+PLpZXi
         jTTP0xabd92BPOCe2SIgjXWgcay3biZ9qtCdP6yYo6b37AikAeZ9spcrCIUL3lmBMkYV
         ASDcZt4B0Ff6dGbB/V3Xo8c9CnDygRaujC2HV0K7peRU/3WWLRESY36mBJwPxXJ0EFcV
         XPIqHOvXng5K58XKdsvornn39GciYixFdA4gWSLCdk/Z0euym6p8CsDhL/f7vzc9ic4U
         sOPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiZalqxutM5TaCG4tZqio8HRq14tAC3LW/gRiikY0eCVlscbSIV0s2RD8+bqEW+6ZnbeGWZOFtg0Hg/eU06wnxAYwp7mzF
X-Gm-Message-State: AOJu0Yz5WjYNF0ku8xYir7UDibqtmYOzS7H0fVenx4JZyDSvqN3BLKub
	pI7xo4P9GNm9jD1ci6NoKLu9JlYkhnCtU/tWciNvhZy/Tgwoye77YMU+pC12CqnO0zEnIMk3a5P
	VEL1OC2W2PQ==
X-Google-Smtp-Source: AGHT+IF/Y0ofKB2DyDqUZAQTS65is5HxA4flQEVOy942Zd2HFD9Dil8dPIykb/bxzvZEKenSzQzfnI9ZBKeNIw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1b06:b0:dcc:94b7:a7a3 with SMTP
 id eh6-20020a0569021b0600b00dcc94b7a7a3mr206671ybb.12.1711636837606; Thu, 28
 Mar 2024 07:40:37 -0700 (PDT)
Date: Thu, 28 Mar 2024 14:40:30 +0000
In-Reply-To: <20240328144032.1864988-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240328144032.1864988-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240328144032.1864988-3-edumazet@google.com>
Subject: [PATCH net-next 2/4] udp: relax atomic operation on sk->sk_rmem_alloc
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

atomic_add_return() is more expensive than atomic_add()
and seems overkill in UDP rx fast path.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/udp.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index f2736e8958187e132ef45d8e25ab2b4ea7bcbc3d..d2fa9755727ce034c2b4bca82bd9e72130d588e6 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1516,12 +1516,7 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 	size = skb->truesize;
 	udp_set_dev_scratch(skb);
 
-	/* we drop only if the receive buf is full and the receive
-	 * queue contains some other skb
-	 */
-	rmem = atomic_add_return(size, &sk->sk_rmem_alloc);
-	if (rmem > (size + (unsigned int)sk->sk_rcvbuf))
-		goto uncharge_drop;
+	atomic_add(size, &sk->sk_rmem_alloc);
 
 	spin_lock(&list->lock);
 	err = udp_rmem_schedule(sk, size);
-- 
2.44.0.396.g6e790dbe36-goog


