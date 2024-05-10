Return-Path: <netdev+bounces-95356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 867758C1F4F
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 09:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2F9BB20B82
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 07:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D939015EFCF;
	Fri, 10 May 2024 07:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YxUfBhIg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B4312AAE5
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715327612; cv=none; b=TrxqpWsgKbiWiZ3Vc3qRbsDaLpcibJobzOZhONJ2AjArWoieCliwzOBpPfxP0GimmF+bbwYCQHnfFvjizonPyPG4PXzkO3ultGAVJCR7lkcQRNB4Mmoot950bSdQHL41Fl/2oISg9xKtmvxqdNd9xrtQARuV7Yx3qFiuR2iuzE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715327612; c=relaxed/simple;
	bh=GxyAF9MoJNLsnqPAnppWaAlGb/bgW3XtzFkDeBhsW0A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oo4Xh2Y1R+7KQIur4U4gUjd9vVLyuvxnpVxdqUHs8QKLD00L3232ZiCoDXCVBtQDr3f9tYIol/J90tz6X8b9YF+81Tnhr1RyEGKeJC5PAmUgFO070z9JzSMALySLi7pgfWmz+ADLgICqNNE7RZKc/ZuNzhiTzf8bW1/5OTAueeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YxUfBhIg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715327609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=g4GGxDEFSHl6lyi7MRw43ABVeuKuMPwbDZXHmI7q75A=;
	b=YxUfBhIgaA/jEo+Izt5JyvERkT1oa1D5mpBZ8bOGdF9biMYADkG3vnHbgB21YQf8bc/77N
	BENKIIZ18sD36Nn3YE6rMx2oZM3Obxz323Op/jxsL8xmoBVhHgNPaD76YWkXZ8R7wGpxiV
	KzKsgmR6wX4FJl9CU+9f2IbQ+fWZX00=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-F5Im2YSfMBajggBBBtgbHg-1; Fri, 10 May 2024 03:53:28 -0400
X-MC-Unique: F5Im2YSfMBajggBBBtgbHg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-34eaba0b1ddso194325f8f.3
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 00:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715327607; x=1715932407;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g4GGxDEFSHl6lyi7MRw43ABVeuKuMPwbDZXHmI7q75A=;
        b=BhOcIzX/kJPcWH/scsLqSJA2DITkkcUy7oMIHhm99zGZriooLX7lDB9y8RA0sjRy2I
         uxEdq1mXliXxbRij+p+dcOkcFTa3KnGI5xiOxZo0veQhEsZOpxB3so4HB22xCGwoJUlc
         tdUJIVeFas0kuteZrJHcuiF2pFraTOcGcjEbo8gW80vACGKwJpr1VGQYerQek10KqHyk
         synsP1Er/Op09rG5U+h/Bz8Jmrm10xPxLfPFQymHGsSgYVpRjmp/zOV0oKozK9JTNo53
         qFdDRQDKiilhOF1v4k9dWiD31lT9wD5S2UyBUGqkkXOXJFMnxxfMzSfk2pbUjOf8mF53
         ct2w==
X-Forwarded-Encrypted: i=1; AJvYcCWZwd1GN7Uvt+G1kASuODJfstM4nK+pJ7Gp66rlTN4Ogu8juteYC1co5f7ZovySsowj2Tk1HZuMIzT2tjIC6CKPNNzUSX/a
X-Gm-Message-State: AOJu0Yz9+qt0mF5eUazbEpc7Yi2HaAL42K+3GLQO+wr8XpVCfPRzIl22
	ZWJ3voUSvNWHe/QxIquo3SnqQH/EvWbQ20m41fDGHi6bjIVd3XgoIZR8HdEqYqnMJGpdcVAW/9A
	SolwUFC6HFuRjmPb+GsPMkkfBSKYU180iJV4aM2ykR0+kHpF9DBRSLw==
X-Received: by 2002:adf:c049:0:b0:350:4c83:d654 with SMTP id ffacd0b85a97d-3504c83d800mr1100910f8f.1.1715327607351;
        Fri, 10 May 2024 00:53:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1UCbqaNK//8VrxUgCszOlFXgeaAEsEoE/I9gSjyyy2h2wSVth/J/hrk/i4XeBpgWOCR5aHA==
X-Received: by 2002:adf:c049:0:b0:350:4c83:d654 with SMTP id ffacd0b85a97d-3504c83d800mr1100898f8f.1.1715327606852;
        Fri, 10 May 2024 00:53:26 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1b68:1b10::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baacfb9sm3787831f8f.68.2024.05.10.00.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 00:53:26 -0700 (PDT)
Message-ID: <dc8e67fac99c7a1d2cb36bff2217515116bf58cf.camel@redhat.com>
Subject: Re: [PATCH v1 net] af_unix: Update unix_sk(sk)->oob_skb under
 sk_receive_queue lock.
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: billy@starlabs.sg, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org,  kuni1840@gmail.com, netdev@vger.kernel.org
Date: Fri, 10 May 2024 09:53:25 +0200
In-Reply-To: <20240510050341.27782-1-kuniyu@amazon.com>
References: <8015f2f2fec7d5a5a7164e1480d0e0c18b925f61.camel@redhat.com>
	 <20240510050341.27782-1-kuniyu@amazon.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-10 at 14:03 +0900, Kuniyuki Iwashima wrote:
> From: Paolo Abeni <pabeni@redhat.com>
> Date: Thu, 09 May 2024 11:12:38 +0200
> > On Tue, 2024-05-07 at 10:00 -0700, Kuniyuki Iwashima wrote:
> > > Billy Jheng Bing-Jhong reported a race between __unix_gc() and
> > > queue_oob().
> > >=20
> > > __unix_gc() tries to garbage-collect close()d inflight sockets,
> > > and then if the socket has MSG_OOB in unix_sk(sk)->oob_skb, GC
> > > will drop the reference and set NULL to it locklessly.
> > >=20
> > > However, the peer socket still can send MSG_OOB message to the
> > > GC candidate and queue_oob() can update unix_sk(sk)->oob_skb
> > > concurrently, resulting in NULL pointer dereference. [0]
> > >=20
> > > To avoid the race, let's update unix_sk(sk)->oob_skb under the
> > > sk_receive_queue's lock.
> >=20
> > I'm sorry to delay this fix but...
> >=20
> > AFAICS every time AF_UNIX touches the ooo_skb, it's under the receiver
> > unix_state_lock. The only exception is __unix_gc. What about just
> > acquiring such lock there?
>=20
> In the new GC, there is unix_state_lock -> gc_lock ordering, and
> we need another fix then.
>=20
> That's why I chose locking recvq for old GC too.
> https://lore.kernel.org/netdev/20240507172606.85532-1-kuniyu@amazon.com/
>=20
> Also, Linus says:
>=20
>     I really get the feeling that 'sb->oob_skb' should actually be forced
>     to always be in sync with the receive queue by always doing the
>     accesses under the receive_queue lock.
>=20
> ( That's in the security@ thread I added you, but I just noticed
>   Linus replied to the previous mail.  I'll forward the mails to you. )
>=20
>=20
> > Otherwise there are other chunk touching the ooo_skb is touched where
> > this patch does not add the receive queue spin lock protection e.g. in
> > unix_stream_recv_urg(), making the code a bit inconsistent.
>=20
> Yes, now the receive path is protected by unix_state_lock() and the
> send path is by unix_state_lock() and recvq lock.
>=20
> Ideally, as Linus suggested, we should acquire recvq lock everywhere
> touching oob_skb and remove the additional refcount by skb_get(), but
> I thought it's too much as a fix and I would do that refactoring in
> the next cycle.
>=20
> What do you think ?

I missed/forgot the unix_state_lock -> gc_lock ordering on net-next.

What about using the receive queue lock, and acquiring that everywhere
oob_skb is touched, without the additional refcount refactor?

Would be more consistent and reasonably small. It should work on the
new CG, too.

The refcount refactor could later come on net-next, and will be less
complex with the lock already in place.

Incremental patch on top of yours, completely untested:
---
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 9a6ad5974dff..a489f2aef29d 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2614,8 +2614,10 @@ static int unix_stream_recv_urg(struct unix_stream_r=
ead_state *state)
=20
 	mutex_lock(&u->iolock);
 	unix_state_lock(sk);
+	spin_lock(&sk->sk_receive_queue.lock);
=20
 	if (sock_flag(sk, SOCK_URGINLINE) || !u->oob_skb) {
+		spin_unlock(&sk->sk_receive_queue.lock);
 		unix_state_unlock(sk);
 		mutex_unlock(&u->iolock);
 		return -EINVAL;
@@ -2627,6 +2629,7 @@ static int unix_stream_recv_urg(struct unix_stream_re=
ad_state *state)
 		WRITE_ONCE(u->oob_skb, NULL);
 	else
 		skb_get(oob_skb);
+	spin_unlock(&sk->sk_receive_queue.lock);
 	unix_state_unlock(sk);
=20
 	chunk =3D state->recv_actor(oob_skb, 0, chunk, state);
@@ -2655,6 +2658,7 @@ static struct sk_buff *manage_oob(struct sk_buff *skb=
, struct sock *sk,
 		consume_skb(skb);
 		skb =3D NULL;
 	} else {
+		spin_lock(&sk->sk_receive_queue.lock);
 		if (skb =3D=3D u->oob_skb) {
 			if (copied) {
 				skb =3D NULL;
@@ -2673,6 +2677,7 @@ static struct sk_buff *manage_oob(struct sk_buff *skb=
, struct sock *sk,
 				skb =3D skb_peek(&sk->sk_receive_queue);
 			}
 		}
+		spin_unlock(&sk->sk_receive_queue.lock);
 	}
 	return skb;
 }


