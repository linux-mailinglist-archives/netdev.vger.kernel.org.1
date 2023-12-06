Return-Path: <netdev+bounces-54270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A538806628
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 05:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFA411F21683
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 04:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA900FBF1;
	Wed,  6 Dec 2023 04:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="Hemd8dwF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91292D3
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 20:25:25 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6d9a6f756c3so1753133a34.2
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 20:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1701836725; x=1702441525; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AzMpY3Q2dnUPW+re7xTCMq4vQkW0i8Xw3gC6e6cbmPw=;
        b=Hemd8dwFtDf4cQet5oIT/6UXvvzXeY7fS4/godFp4k2Y9eckyxMuwSmEaIGQe9LTrz
         RA35pH5IduhFqrOZCuNDEcC0zQFLJj5mg3LoN6OWosnrxTTjMVczY0yrI46hWVzpDYHu
         85CzmK3GTwwbng2g1yExtOPkGHYC9G1UHcF4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701836725; x=1702441525;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AzMpY3Q2dnUPW+re7xTCMq4vQkW0i8Xw3gC6e6cbmPw=;
        b=qolTnZlJc10Kn7ImhVIvFtwGWgYXgDOAbxAHUB6ojVTmibTj/VsfAnRcNK51Jt/EI9
         g4+XR1pKRBYzTkekXEtdJwkTNQ68yPTvdFNbfLG12+Kn2vjPU+db64yx85FUxfuGPQA0
         Fb994d4Bkz/uzyAJuJLZ9DsF7epnVkKYfdWXzXRupzmtIZFI3qBTUOMDzf1UimjCioyq
         +f9E3IAjmB8tiKVlylW0t6b/jzI3wXObYOORgmMZZHAfJtifuUVg6N8zwGn8pXSOcsn9
         Jdo+j3oZ6L8mNSVrw2TKW9E4zxQfnXw5CmPDkwy0BPm2mtrNW9VZcg1hqnj3dzNKgALn
         s89g==
X-Gm-Message-State: AOJu0YybXFUoKZIzB2iZXEiy3JpbsPlGuBjtZhxvxMjqOwUEVxrwli5x
	r+CHj2izhUuamQW1+2NBQowatA==
X-Google-Smtp-Source: AGHT+IHrWsS2/q5dwYRFBc4GD6P35Jgc+UxEFv+kNarIZiCIT0FRa1QGkLz1PoM1uhslATUHaNlwzw==
X-Received: by 2002:a9d:6e9a:0:b0:6d8:4c76:bac9 with SMTP id a26-20020a9d6e9a000000b006d84c76bac9mr468850otr.13.1701836724869;
        Tue, 05 Dec 2023 20:25:24 -0800 (PST)
Received: from ubuntu ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id c17-20020a637251000000b005c6676349f8sm6245452pgn.89.2023.12.05.20.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 20:25:24 -0800 (PST)
Date: Tue, 5 Dec 2023 20:25:19 -0800
From: Hyunwoo Kim <v4bel@theori.io>
To: =?iso-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
Cc: courmisch@gmail.com, imv4bel@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, v4bel@theori.io
Subject: Re: [PATCH] net: phonet: Fix Use-After-Free in pep_recvmsg
Message-ID: <20231206042519.GA5926@ubuntu>
References: <20231204065952.GA16224@ubuntu>
 <A2443BF8-D693-4182-9E07-3FFA33D97217@remlab.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A2443BF8-D693-4182-9E07-3FFA33D97217@remlab.net>

Hi,

On Mon, Dec 04, 2023 at 09:12:11AM +0200, Rémi Denis-Courmont wrote:
> Hi,
> 
> Le 4 décembre 2023 08:59:52 GMT+02:00, Hyunwoo Kim <v4bel@theori.io> a écrit :
> >Because pep_recvmsg() fetches the skb from pn->ctrlreq_queue
> >without holding the lock_sock and then frees it,
> >a race can occur with pep_ioctl().
> >A use-after-free for a skb occurs with the following flow.
> 
> Isn't this the same issue that was reported by Huawei rootlab and for which I already provided a pair of patches to the security list two months ago?

Is the issue reported to the security mailing list two months ago the same as this pn->ctrlreq_queue race?

> 
> TBH, I much prefer the approach in the other patch set, which takes the hit on the ioctl() side rather than the recvmsg()'s.

That's probably a patch to add sk->sk_receive_queue.lock to pep_ioctl(), is that correct?

> 
> Unfortunately, I have no visibility on what happened or didn't happen after that, since the security list is private.

Perhaps this issue hasn't gotten much attention.


Regards,
Hyunwoo Kim

> 
> >```
> >pep_recvmsg() -> skb_dequeue() -> skb_free_datagram()
> >pep_ioctl() -> skb_peek()
> >```
> >Fix this by adjusting the scope of lock_sock in pep_recvmsg().
> >
> >Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
> >---
> > net/phonet/pep.c | 17 +++++++++++++----
> > 1 file changed, 13 insertions(+), 4 deletions(-)
> >
> >diff --git a/net/phonet/pep.c b/net/phonet/pep.c
> >index faba31f2eff2..212d8a9ddaee 100644
> >--- a/net/phonet/pep.c
> >+++ b/net/phonet/pep.c
> >@@ -1250,12 +1250,17 @@ static int pep_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> > 	if (unlikely(1 << sk->sk_state & (TCPF_LISTEN | TCPF_CLOSE)))
> > 		return -ENOTCONN;
> > 
> >+	lock_sock(sk);
> >+
> > 	if ((flags & MSG_OOB) || sock_flag(sk, SOCK_URGINLINE)) {
> > 		/* Dequeue and acknowledge control request */
> > 		struct pep_sock *pn = pep_sk(sk);
> > 
> >-		if (flags & MSG_PEEK)
> >+		if (flags & MSG_PEEK) {
> >+			release_sock(sk);
> > 			return -EOPNOTSUPP;
> >+		}
> >+
> 
> Also this change is not really accounted for.
> 
> > 		skb = skb_dequeue(&pn->ctrlreq_queue);
> > 		if (skb) {
> > 			pep_ctrlreq_error(sk, skb, PN_PIPE_NO_ERROR,
> >@@ -1263,12 +1268,14 @@ static int pep_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> > 			msg->msg_flags |= MSG_OOB;
> > 			goto copy;
> > 		}
> >-		if (flags & MSG_OOB)
> >+
> >+		if (flags & MSG_OOB) {
> >+			release_sock(sk);
> > 			return -EINVAL;
> >+		}
> > 	}
> > 
> > 	skb = skb_recv_datagram(sk, flags, &err);
> >-	lock_sock(sk);
> > 	if (skb == NULL) {
> > 		if (err == -ENOTCONN && sk->sk_state == TCP_CLOSE_WAIT)
> > 			err = -ECONNRESET;
> >@@ -1278,7 +1285,7 @@ static int pep_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> > 
> > 	if (sk->sk_state == TCP_ESTABLISHED)
> > 		pipe_grant_credits(sk, GFP_KERNEL);
> >-	release_sock(sk);
> >+
> > copy:
> > 	msg->msg_flags |= MSG_EOR;
> > 	if (skb->len > len)
> >@@ -1291,6 +1298,8 @@ static int pep_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> > 		err = (flags & MSG_TRUNC) ? skb->len : len;
> > 
> > 	skb_free_datagram(sk, skb);
> >+
> >+	release_sock(sk);
> > 	return err;
> > }
> > 

