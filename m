Return-Path: <netdev+bounces-288987-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIPsIPrmCmoE9QQAu9opvQ
	(envelope-from <netdev+bounces-288987-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:16:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D7D56A88A
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 869263001479
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4CC340A6B;
	Mon, 18 May 2026 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ciqe4kIU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BbFgEQpL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A146A331A78
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 10:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779099380; cv=none; b=GqjIjBVgtMw+WBj5q40zIXrJZCakB5lR8zWOGkdlgC57wYOWUzrwEkAD+CfiD7+VJKKTCd8nzf0vFUp5mV57PtHEwf0Cr6n2kv9rwPvCZurw2iWVqeysHMkAlb4nL26jxhRBRtfzfzGZEZ5HTMhw1YF1AjMi9pRdc+DpQ1IcGrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779099380; c=relaxed/simple;
	bh=p2oIC8NYFEoKssE9YGgapSCQbvrsyIhbBtAn1ZjbU6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ts09l81kzqIQQgzXynvRB9z0KrtlER2LKJmarYRJNxRb6CXAbD42dpRkmDrXt3tMyrDEEFwR3QXoUyos1kwBqcsOrsZdm+P0UwcVu1KgAslhXrWot/i9SrswAr9hoFIHOKV9DP1PvzmvSp/KY6eBpTsyAR6kOC29A9TxBack5PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ciqe4kIU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BbFgEQpL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779099376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U+bPT0OwjK2/sBWY1H6birk4kBm4U11B33CKAu6EoPE=;
	b=Ciqe4kIUiI+1FvMgKZ7C0fn0L86Y/TLQPeSV8JneBc/oRBtvWNzJSDymY6Pgm45UUc/n1k
	Rwa4yCUKyOH4RvqU3jJ9AMPnYpMZsu2J8fkN8WCxrFpZZeL8cQfflRQxPXveh7pb9R+ZAC
	aAQ02Dox3BhEYZbxAdBg9/osLqfKG00=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-SKMNRZNLOVO4WK_1dkwrTQ-1; Mon, 18 May 2026 06:16:14 -0400
X-MC-Unique: SKMNRZNLOVO4WK_1dkwrTQ-1
X-Mimecast-MFC-AGG-ID: SKMNRZNLOVO4WK_1dkwrTQ_1779099373
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48fd8162ed7so16955235e9.2
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 03:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779099373; x=1779704173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U+bPT0OwjK2/sBWY1H6birk4kBm4U11B33CKAu6EoPE=;
        b=BbFgEQpL7qbTrfvHVpe75nbFOTJihiwUcyogK/G8kJtinkoeUqImBmj5HzSCL+Woge
         3pRwEc95MlagTfZ9RrmhNUUGBIiH8X4My5xHrlcPnS4nPRXbbRbIUCVcR7EgOGVWl+x9
         lswHpkZweDop+/vy3Yw50wJqQXQbln2M1iZd4cKNuCIlOaijZWj48L1fQbnUYn6hAfsa
         wQu+RIkNgysruoJGrmx+acAcVt5zzg817WuTNhIBm+rdaT0sHKUM5X3LL/lZis1EvKsC
         MTmXPQxJiGSRaAt9zaq3wc8wG7lOrKreTgluWOJEnNXWHllSDntsoFK9SPzwwGpVzFCs
         vUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779099373; x=1779704173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+bPT0OwjK2/sBWY1H6birk4kBm4U11B33CKAu6EoPE=;
        b=lkGyegtuI5ENiJ8hKtaSahjEjpQ4FN3nDke3VXPwIT1K51dyLgi+xwV9DmR6FSg709
         ZEdXPVG2i+kDX4/lOAGU2u2pH72KE19a0iMz7s+28s3jivkDaw/CNmBiw3YP8UMOG14a
         NZ2sa/vMYAZRpQGJ1quEAZQul4lK5cE4AewFTfBqNNCrcF9qzW1ocd9WmfIZ1TJF2k38
         J/fB2AubgfSw0UBoSpTbycng+5PLvCsRyeIchyb9S+tbfTRrANCJKqh7KaSYb5BCTjQy
         c/MpQa1NHHiadtMzFgBi7otBcMphIQHh56sRxKC4wK+TnJOMghtzoLX1gz7vO26z93vf
         Ijkw==
X-Forwarded-Encrypted: i=1; AFNElJ8yIIt1g0UxsHAGZi/MeL+3Cer6nNFO8XwElJSZ5thiydfdR1b52Yp0r8ylxTHTpowK3BsVvbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvqwhnstqIyMZ0aU0clhsptSoLH9L4jyXG6C0UQ8IKck5Ad08h
	4KtZjwnYbT9UooqunCyhJlJPKGPaHtTZ7pb0WW9lGrfpBImEq2E98ml3exEfEw8AQiOmxq2nC2+
	IGQiFPmuLSFRPzwDIZ395SB8MEZmsxPpMkJK2p7sOG30SuKrQfPuZzW8lRw==
X-Gm-Gg: Acq92OGgZDxcr3TgpuwbxldZqWMJ1It0hv+P4UOi1it1yCPsZFQ5LAENodyiMjUam0+
	WWccFMuFyhp9TxYplpey+ZBEQuccmuXm0Gpy8NbYsaomgtf88Nb9UGOlyvjKuD+psDeHU6qA6xu
	ubrg32G8NqMLyathyu9e5M1yfHMDh9ch/DGjwb9Dd+O+59ti8LXeLzwZ/4YKH2fBUE+tEivqu1a
	8vjhLXCdeOQa03BOztPX2aU/d42Uh3DI6sze51dFb/qpbgO14cFnR61TM/R96GdelnhwLXKJ2B5
	jRy6ad6uLHg2lnr4u/lSZa9ZMyCCJLXYfFN4oYTbg2vsnw7aH4/YtHuRrM2p5/Ln3USvdZ0shFr
	I4D3A6yXkpnktsXfUynpG4rIWqlboAmX9LLTyxJ0tB4bVmO52ZxRmrDQapgo8+d7naKNYtrFGOA
	==
X-Received: by 2002:a05:600c:c494:b0:485:4388:3492 with SMTP id 5b1f17b1804b1-48fe60ed839mr211918905e9.11.1779099372897;
        Mon, 18 May 2026 03:16:12 -0700 (PDT)
X-Received: by 2002:a05:600c:c494:b0:485:4388:3492 with SMTP id 5b1f17b1804b1-48fe60ed839mr211918235e9.11.1779099372199;
        Mon, 18 May 2026 03:16:12 -0700 (PDT)
Received: from sgarzare-redhat (host-87-16-204-231.retail.telecomitalia.it. [87.16.204.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe53ab6aasm261827455e9.2.2026.05.18.03.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 03:16:11 -0700 (PDT)
Date: Mon, 18 May 2026 12:16:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Ziyu Zhang <ziyuzhang201@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andy King <acking@vmware.com>, 
	George Zhang <georgezhang@vmware.com>, Dmitry Torokhov <dtor@vmware.com>, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, r33s3n6@gmail.com, gality369@gmail.com, zhenghaoran154@gmail.com, 
	hanguidong02@gmail.com, zzzccc427@gmail.com
Subject: Re: [PATCH net] vsock: keep poll shutdown state consistent
Message-ID: <agrldIdftDXvATYx@sgarzare-redhat>
References: <20260516034745.260442-1-ziyuzhang201@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260516034745.260442-1-ziyuzhang201@gmail.com>
X-Rspamd-Queue-Id: 25D7D56A88A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288987-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vmware.com,lists.linux.dev,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sat, May 16, 2026 at 11:47:45AM +0800, Ziyu Zhang wrote:
>vsock_poll() reads vsk->peer_shutdown before taking the socket
>lock to set EPOLLHUP and EPOLLRDHUP, then reads it again under the
>lock to report EOF readability. A shutdown packet can update
>peer_shutdown while poll is waiting for the lock, so one poll invocation
>can report EPOLLIN without the corresponding HUP/RDHUP bits.
>
>Keep non-connectible sockets on a single lockless READ_ONCE()

Should this be paired with WRITE_ONCE() on writers?

>snapshot. For connectible sockets, defer shutdown-derived poll bits
>until after lock_sock() and use one READ_ONCE() snapshot for both EOF
>readability and HUP/RDHUP. This preserves shutdowns that arrive before
>the lock is acquired and keeps all peer-shutdown-derived bits consistent
>for a poll pass.
>
>Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>Signed-off-by: Ziyu Zhang <ziyuzhang201@gmail.com>
>---
> net/vmw_vsock/af_vsock.c | 40 ++++++++++++++++++++++++++--------------
> 1 file changed, 26 insertions(+), 14 deletions(-)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index adcba1b7b..bed42347b 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1122,6 +1122,25 @@ static int vsock_shutdown(struct socket *sock, int mode)
> 	return err;
> }
>
>+static __poll_t vsock_poll_shutdown(struct sock *sk, u32 peer_shutdown)
>+{
>+	__poll_t mask = 0;
>+
>+	/* INET sockets treat local write shutdown and peer write shutdown as a
>+	 * case of EPOLLHUP set.
>+	 */
>+	if (sk->sk_shutdown == SHUTDOWN_MASK ||
>+	    ((sk->sk_shutdown & SEND_SHUTDOWN) &&
>+	     (peer_shutdown & SEND_SHUTDOWN)))
>+		mask |= EPOLLHUP;
>+
>+	if (sk->sk_shutdown & RCV_SHUTDOWN ||
>+	    peer_shutdown & SEND_SHUTDOWN)
>+		mask |= EPOLLRDHUP;
>+
>+	return mask;
>+}
>+
> static __poll_t vsock_poll(struct file *file, struct socket *sock,
> 			       poll_table *wait)
> {
>@@ -1139,19 +1158,9 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
> 		/* Signify that there has been an error on this socket. */
> 		mask |= EPOLLERR;
>
>-	/* INET sockets treat local write shutdown and peer write shutdown as a
>-	 * case of EPOLLHUP set.
>-	 */
>-	if ((sk->sk_shutdown == SHUTDOWN_MASK) ||
>-	    ((sk->sk_shutdown & SEND_SHUTDOWN) &&
>-	     (vsk->peer_shutdown & SEND_SHUTDOWN))) {
>-		mask |= EPOLLHUP;
>-	}
>-
>-	if (sk->sk_shutdown & RCV_SHUTDOWN ||
>-	    vsk->peer_shutdown & SEND_SHUTDOWN) {
>-		mask |= EPOLLRDHUP;
>-	}
>+	if (!sock_type_connectible(sk->sk_type))
>+		mask |= vsock_poll_shutdown(sk,
>+					    READ_ONCE(vsk->peer_shutdown));

Can we move this in the `if (sock->type == SOCK_DGRAM)` branch ?

Not a strong opinion about that, but in any case IMO we should add a 
comment here to explain why we are doing only for not connectible 
sockets.

That said, if we use WRITE_ONCE in the writers, do we really need to 
move this after the lock_sock for the connectable ones?

>
> 	if (sk_is_readable(sk))
> 		mask |= EPOLLIN | EPOLLRDNORM;
>@@ -1171,6 +1180,7 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
>
> 	} else if (sock_type_connectible(sk->sk_type)) {
> 		const struct vsock_transport *transport;
>+		u32 peer_shutdown;
>
> 		lock_sock(sk);
>
>@@ -1203,10 +1213,12 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
> 		 * terminated should also be considered read, and we check the
> 		 * shutdown flag for that.
> 		 */
>+		peer_shutdown = READ_ONCE(vsk->peer_shutdown);
> 		if (sk->sk_shutdown & RCV_SHUTDOWN ||
>-		    vsk->peer_shutdown & SEND_SHUTDOWN) {
>+		    peer_shutdown & SEND_SHUTDOWN) {
> 			mask |= EPOLLIN | EPOLLRDNORM;
> 		}
>+		mask |= vsock_poll_shutdown(sk, peer_shutdown);

nit: to keep the order the same as before, I would move this call just 
before this `if` block, but I don't think it makes any difference in the 
end.

>
> 		/* Connected sockets that can produce data can be written. */
> 		if (transport && sk->sk_state == TCP_ESTABLISHED) {
>-- 
>2.43.0
>


