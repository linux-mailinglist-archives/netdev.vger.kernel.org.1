Return-Path: <netdev+bounces-172781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A0DA55EC3
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 04:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600711889065
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 03:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C97194C9E;
	Fri,  7 Mar 2025 03:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSYzYKNi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB804192B81
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 03:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741318588; cv=none; b=LnauWIGSlcD57G7K3jwClWb3jhFAX7chxT/AWPlECC34e+PniKMdTaCkuFA/MgcbI1rZKjIq85V7vhdpdhJVatO+zEK8V6eUl8k3SXcCoGqBrY4T650gHC06WtFf8K7mRUtxSfJhr9FVyVD24wnn8QP2mD+KjNuJOWv1spO3AUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741318588; c=relaxed/simple;
	bh=4cr705Fz7tE6fPfVacy0geRhdmKGhlODOAipS07vVCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6x7Qeq+Cif3F7coVHgLofPHkJPkExOLsGz2xe4cGPCZNmNZB+N5LM+FCtsDgqucCbPlClQrptHb+iTxbBTz1xWO/CFQrrFrn9NrbS1z3WLV/E2e6eP92IhuWDcl6r1sktZHVApc83iGAoF92vZ8UF6u8wq77dF839scX/TQ6TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSYzYKNi; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4750bc8d102so13762281cf.1
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 19:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741318585; x=1741923385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SaP1lDZYkL3tJ7ndT8o1iYCUjUlsXXOPt5hOoDFAnnI=;
        b=gSYzYKNiSRZwfHhLK2b28GH08Kh3Aycu9VumKzTOa2dJdHYU/JGA1FE6UkuKAxZmGL
         unQM26J9id4lHUEk+IFJ7dzDvBgFsmL61hMpE8MFXYuDfNi3+bzFG3126VgHIqzJvCrc
         U62u8lfrbj2hLBKF74h0xuTtjONuDTWFt7IVdvRoWEmMKOGMCQugTnnnHLyR5rdy0ldo
         JfNjBtCocAZNkkLdq0+HPq2u4zo19IqZLUV9RRqC5UuG6avxZr1FKpgcgoabPAnWhCy6
         8dVAsQ1ZHzACrIggJbIZp7hbujnXWMF/QO9kZ8I5sApYfA+5eB1aPORZdK6L4DPfFkWP
         /Feg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741318585; x=1741923385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SaP1lDZYkL3tJ7ndT8o1iYCUjUlsXXOPt5hOoDFAnnI=;
        b=Q+VQM0Rpxyg0I2HC8Zrn9Kt5+zU89TxNB3bJn8rBV6ZMlSyX64ZEEZnMgclv7r8K1+
         4VntjtaYWmpQD3sJqKzArhr7A05B9I0+7Uhf4rL/D6CicaJP5y8it+5wILud4rdact5/
         MHrIWHYrN+AfyBRCa2gnfJ9gvPngSCWxa/RV136fukIN0qJMzbXaYxhCNJWxPx9NpIsA
         aJiq8O7QMBT6ADAhSBnJWG7xtefOfl4K9150zlcz4n/DC0d/kW9aoKrBtr7joqJia4Gj
         pnR9xPnSiUGotiAEQH9lAxM2JiE5mDiCUuDfjZaYS5hkRuc+y7Kl/E35LHUtNxCrr00F
         8lIA==
X-Gm-Message-State: AOJu0YxhstReOPu256yTngWQCHFdQ6pum+GDbv0wLBZs3KEN7Pctwiy4
	t5K5C0SRBLW0DXZGD7uzJ/FRXkC+cEgLiMIx9zoTGvKALEMr/GBtLrDqvQ==
X-Gm-Gg: ASbGncuxDU8sX0IG34kTT7SwxiH64IUJMpUu2GT8DvxVLyaIVLQERgbC3rO+QBQLj+f
	oaXnvpfxg/Ri+sT031tqx8SDLZ5u2W4aHHAd6pedby6xYKjzFra1Wp3CuagUunyNfbQQnWcXVRQ
	SWLY9zlpS3rAw6KGi7iapCv5nyNnn7xYa78HftXV8OX3A6zfcCZW4LvmZuI5vGTPFP5W5oLkHwO
	aLHMjDa84mJ02hmZ3/G8PSXbRicX2zpFKcUNzZtLBLk+D3VqS4H5BG36AGylT9EAqqWcB/abP+9
	XOkP4O/LO5L549rxo6DShnB5i5D4nWaw17p7kpGvT+3xvegqhtyHwPNp4l6nP9h9BiJdsIflf0+
	BiO1vePeXmlnvsqlN9Hiy5RhHKwcuyVU6xwSyrdMvTG6Y
X-Google-Smtp-Source: AGHT+IEWJoy42BTscloNA4+3qorLdbglh3CoQMmFHiF4id97ekDFXeo2KRYYWZ4kqV/aqlksHXsKVQ==
X-Received: by 2002:ad4:5f46:0:b0:6e8:fb7e:d33b with SMTP id 6a1803df08f44-6e900677496mr22037746d6.33.1741318585492;
        Thu, 06 Mar 2025 19:36:25 -0800 (PST)
Received: from willemb.c.googlers.com.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f71727d1sm14528946d6.117.2025.03.06.19.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 19:36:24 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 2/3] ipv6: save dontfrag in cork
Date: Thu,  6 Mar 2025 22:34:09 -0500
Message-ID: <20250307033620.411611-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250307033620.411611-1-willemdebruijn.kernel@gmail.com>
References: <20250307033620.411611-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

When spanning datagram construction over multiple send calls using
MSG_MORE, per datagram settings are configured on the first send.

That is when ip(6)_setup_cork stores these settings for subsequent use
in __ip(6)_append_data and others.

The only flag that escaped this was dontfrag. As a result, a datagram
could be constructed with df=0 on the first sendmsg, but df=1 on a
next. Which is what cmsg_ip.sh does in an upcoming MSG_MORE test in
the "diff" scenario.

Changing datagram conditions in the middle of constructing an skb
makes this already complex code path even more convoluted. It is here
unintentional. Bring this flag in line with expected sockopt/cmsg
behavior.

And stop passing ipc6 to __ip6_append_data, to avoid such issues
in the future. This is already the case for __ip_append_data.

inet6_cork had a 6 byte hole, so the 1B flag has no impact.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 include/linux/ipv6.h  | 1 +
 net/ipv6/ip6_output.c | 9 +++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index a6e2aadbb91b..5aeeed22f35b 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -207,6 +207,7 @@ struct inet6_cork {
 	struct ipv6_txoptions *opt;
 	u8 hop_limit;
 	u8 tclass;
+	u8 dontfrag:1;
 };
 
 /* struct ipv6_pinfo - ipv6 private area */
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index d91da522c34e..581bc6289081 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1386,6 +1386,7 @@ static int ip6_setup_cork(struct sock *sk, struct inet_cork_full *cork,
 	}
 	v6_cork->hop_limit = ipc6->hlimit;
 	v6_cork->tclass = ipc6->tclass;
+	v6_cork->dontfrag = ipc6->dontfrag;
 	if (rt->dst.flags & DST_XFRM_TUNNEL)
 		mtu = READ_ONCE(np->pmtudisc) >= IPV6_PMTUDISC_PROBE ?
 		      READ_ONCE(rt->dst.dev->mtu) : dst_mtu(&rt->dst);
@@ -1421,7 +1422,7 @@ static int __ip6_append_data(struct sock *sk,
 			     int getfrag(void *from, char *to, int offset,
 					 int len, int odd, struct sk_buff *skb),
 			     void *from, size_t length, int transhdrlen,
-			     unsigned int flags, struct ipcm6_cookie *ipc6)
+			     unsigned int flags)
 {
 	struct sk_buff *skb, *skb_prev = NULL;
 	struct inet_cork *cork = &cork_full->base;
@@ -1475,7 +1476,7 @@ static int __ip6_append_data(struct sock *sk,
 	if (headersize + transhdrlen > mtu)
 		goto emsgsize;
 
-	if (cork->length + length > mtu - headersize && ipc6->dontfrag &&
+	if (cork->length + length > mtu - headersize && v6_cork->dontfrag &&
 	    (sk->sk_protocol == IPPROTO_UDP ||
 	     sk->sk_protocol == IPPROTO_ICMPV6 ||
 	     sk->sk_protocol == IPPROTO_RAW)) {
@@ -1855,7 +1856,7 @@ int ip6_append_data(struct sock *sk,
 
 	return __ip6_append_data(sk, &sk->sk_write_queue, &inet->cork,
 				 &np->cork, sk_page_frag(sk), getfrag,
-				 from, length, transhdrlen, flags, ipc6);
+				 from, length, transhdrlen, flags);
 }
 EXPORT_SYMBOL_GPL(ip6_append_data);
 
@@ -2058,7 +2059,7 @@ struct sk_buff *ip6_make_skb(struct sock *sk,
 	err = __ip6_append_data(sk, &queue, cork, &v6_cork,
 				&current->task_frag, getfrag, from,
 				length + exthdrlen, transhdrlen + exthdrlen,
-				flags, ipc6);
+				flags);
 	if (err) {
 		__ip6_flush_pending_frames(sk, &queue, cork, &v6_cork);
 		return ERR_PTR(err);
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


