Return-Path: <netdev+bounces-204418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 950ABAFA5B6
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 16:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38EA3189B963
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 14:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4203317BA5;
	Sun,  6 Jul 2025 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKe6JMll"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4CC2E3700
	for <netdev@vger.kernel.org>; Sun,  6 Jul 2025 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751811201; cv=none; b=Fj+d/Vt7+TyiscLcGD7dvLxa1g5V/4TUIgPyFeXtld8EzBscL6EkbD5LcEKsbHihcqA8YNgbAdG7z/gEcx/kHpCvsLbfzjelttlaZOlbYbU4p/xUSBMPeXw8hAtRLYkylTXsFtU0Kei30hkPImlhvTHXKNhZBNgol7JU/1rksOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751811201; c=relaxed/simple;
	bh=GFM9E9pEOKxnW9QKszfW4TmNp8FmGTTviVUP3FYw/LI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Sk2Oj5pER4BR191yqsv2boaMPp6qhlKNNCLpyb1BISTXjntvk81MHLcKquzZvTYji2ZCgINbZfOBzlz86y54XllwDwF3+vYe8WucnYE6jG40a5WeQRUv2TlaVL1tpiSnSFfxasJGc0z4QWKNKDCKT7UEZ3QYDZKUG0MwgXknMRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKe6JMll; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70f94fe1e40so35604287b3.1
        for <netdev@vger.kernel.org>; Sun, 06 Jul 2025 07:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751811198; x=1752415998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAp0zs/FUnwb/EfsSciQdcfxhasU/gQWdYmspN0NkkE=;
        b=mKe6JMllAOrJK3UStGkk4Cgjy5EoX1kDKyFMYuE82eJ7d9y5TNAeayq+lNNstG8DvY
         YSF2NIQa/il0iFz7ZmzQitjByH33GR39Cuotjm7jOXkHzkft9niMgZ981IRfIy0t2Z5X
         ZfG3ntPPTMZkGKJzY9FGoL4YxKcSdn4G8tu23si083A6mEBXUyVBvzE1wBagL0iln+mc
         CVViTGd1pTdYLEA2Hc0B9yMK27107NfVuQk31OPrKhxUa6iTi/a62E7H96DCawVUiR7T
         KLkNjwxXlaSWCIoxAwFIsuokXMYk1J1nU006xgOmmaMVXXyhpvdSRQVOcf8QlM/ylcwK
         natA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751811198; x=1752415998;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NAp0zs/FUnwb/EfsSciQdcfxhasU/gQWdYmspN0NkkE=;
        b=JXPjPAA7KXs5fi1NsfdVVO7Nlp+b3+Yo+FQXYEgraIMNG9W+lgor9EJGfglo65Vaxk
         prB9p/YuC3qX19Wpr7Hy8VpYZXNqRl7Hl6R3oznKQgjmCQ+Yml0I4DK5TkH55tJ8Suv8
         0aC+a+peWubc5BtCXiGfaljt0sL47ntmPDwYsRtrOQ6USoykC53zTvw4wPB+YrSW63hy
         /bVtFYaZGerEV/vM+fQ2cY++Tavo12PoJ7+GbuWxT1MvG3gXSKavDjBVDBc1fMAIboWe
         NEqWrVIiks0RJfofVyDcLmm8Qj05uta/Ac2g+UXk4MkpL4EKcJbYYRWXrYcSNy78iGeP
         sOqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeGU00rQe9YSTN6UBSAy9botaSm2d2Vxx/pO62OYHdm1esOcHMBQzG+e0GbHq193ettUiyZYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeLiJch0AXySVXemBBxev965EyvtcHlQAbGQq/+rfM5kh/QjV0
	bXOiuuJ8wRmR8MKhE7JpdbZFABjqBw7Vea3V6mlbJ3seXWXnAgBeHi+e
X-Gm-Gg: ASbGncugKHB/PH9ko076XHfLmhSU1OzSQ1XiVKSldoA6CSWFmkBufwUn7Abr/nmmDEG
	SCK4t6NXyz7FYE5qdAQ6HE/DGyImOtALH66/oWOovIf5m6osTFX8UPqMy9Z0qbjsYYDIzoQWif7
	/XmKeKcBNKR0uCO7LTs3Prt9gtihJM98FMiriWhJrMOzPsETlv1JYHKxqddYHmHAhkCsxbv4rTx
	sFN3vyXt9Au2ZRp5Jc/+o3U9WsK5QufcJwmdAujvgyRmJarvAB1GVH1qI9MCyfyE6XPf9Qj16x3
	tiZlYB3mUo0yHOdIczSdFqCIFh+h70Xn4VB6Hfz+6rDW/Zh/obpaIDhuecx+SwE7Xysm1rL9Y+Y
	tmu4s38Zn9UnzPAv7ORNNHnePwOt45Nsl6AFdiCo=
X-Google-Smtp-Source: AGHT+IG43XRvEtmsPeZelskZDIfIMoRRQgdn1U1actr6OiHG91TGrucCNci73DSnIEBAd6uovMYHMA==
X-Received: by 2002:a05:690c:6210:b0:70e:7f7f:cfda with SMTP id 00721157ae682-71667eabf4dmr130493887b3.10.1751811198477;
        Sun, 06 Jul 2025 07:13:18 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7166598d68csm12381487b3.24.2025.07.06.07.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 07:13:18 -0700 (PDT)
Date: Sun, 06 Jul 2025 10:13:17 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <686a847db2f31_3aa6542949f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250702223606.1054680-5-kuniyu@google.com>
References: <20250702223606.1054680-1-kuniyu@google.com>
 <20250702223606.1054680-5-kuniyu@google.com>
Subject: Re: [PATCH v1 net-next 4/7] af_unix: Use cached value for SOCK_STREAM
 in unix_inq_len().
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kuniyuki Iwashima wrote:
> Compared to TCP, ioctl(SIOCINQ) for AF_UNIX SOCK_STREAM socket is more
> expensive, as unix_inq_len() requires iterating through the receive queue
> and accumulating skb->len.
> 
> Let's cache the value for SOCK_STREAM to a new field during sendmsg()
> and recvmsg().
> 
> The field is protected by the receive queue lock.
> 
> Note that ioctl(SIOCINQ) for SOCK_DGRAM returns the length of the first
> skb in the queue.
> 
> SOCK_SEQPACKET still requires iterating through the queue because we do
> not touch functions shared with unix_dgram_ops.  But, if really needed,
> we can support it by switching __skb_try_recv_datagram() to a custom
> version.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  include/net/af_unix.h |  1 +
>  net/unix/af_unix.c    | 38 ++++++++++++++++++++++++++++----------
>  2 files changed, 29 insertions(+), 10 deletions(-)
> 
> diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> index 1af1841b7601..603f8cd026e5 100644
> --- a/include/net/af_unix.h
> +++ b/include/net/af_unix.h
> @@ -47,6 +47,7 @@ struct unix_sock {
>  #define peer_wait		peer_wq.wait
>  	wait_queue_entry_t	peer_wake;
>  	struct scm_stat		scm_stat;
> +	int			inq_len;
>  #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
>  	struct sk_buff		*oob_skb;
>  #endif
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index fa2081713dad..aade29d65570 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -2297,6 +2297,7 @@ static int queue_oob(struct sock *sk, struct msghdr *msg, struct sock *other,
>  
>  	spin_lock(&other->sk_receive_queue.lock);
>  	WRITE_ONCE(ousk->oob_skb, skb);
> +	WRITE_ONCE(ousk->inq_len, ousk->inq_len + 1);
>  	__skb_queue_tail(&other->sk_receive_queue, skb);
>  	spin_unlock(&other->sk_receive_queue.lock);
>  
> @@ -2319,6 +2320,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
>  	struct sock *sk = sock->sk;
>  	struct sk_buff *skb = NULL;
>  	struct sock *other = NULL;
> +	struct unix_sock *otheru;
>  	struct scm_cookie scm;
>  	bool fds_sent = false;
>  	int err, sent = 0;
> @@ -2342,14 +2344,16 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
>  	if (msg->msg_namelen) {
>  		err = READ_ONCE(sk->sk_state) == TCP_ESTABLISHED ? -EISCONN : -EOPNOTSUPP;
>  		goto out_err;
> -	} else {
> -		other = unix_peer(sk);
> -		if (!other) {
> -			err = -ENOTCONN;
> -			goto out_err;
> -		}
>  	}
>  
> +	other = unix_peer(sk);
> +	if (!other) {
> +		err = -ENOTCONN;
> +		goto out_err;
> +	}
> +
> +	otheru = unix_sk(other);
> +
>  	if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN)
>  		goto out_pipe;
>  
> @@ -2418,7 +2422,12 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
>  
>  		unix_maybe_add_creds(skb, sk, other);
>  		scm_stat_add(other, skb);
> -		skb_queue_tail(&other->sk_receive_queue, skb);
> +
> +		spin_lock(&other->sk_receive_queue.lock);
> +		WRITE_ONCE(otheru->inq_len, otheru->inq_len + skb->len);
> +		__skb_queue_tail(&other->sk_receive_queue, skb);
> +		spin_unlock(&other->sk_receive_queue.lock);
> +

The change from spin_lock_irqsave here and below is intentional, I
assume. If respinning, worth stating explicitly.

