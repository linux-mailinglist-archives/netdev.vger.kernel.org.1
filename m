Return-Path: <netdev+bounces-230152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C51D9BE47CF
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 18:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20DAF582671
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 16:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7334D32D0FE;
	Thu, 16 Oct 2025 16:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZJIgRCm5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A815532D0D1
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 16:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760631069; cv=none; b=M8I34rTN9j7ms2W5Kcy9Mez+emU3TbGxEsr4Vl72rxzMnaN+m9cgyojt4JSHqPVLhrprp0IALq4c11NBpzq2T18zgXVWANI/s8o/GeKEqaLxcYr/vtImgJ9zgDI6Dk5h4UxGt1LFCUdwWwPmv2I4pj5naSaohEJSla6oPuKijBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760631069; c=relaxed/simple;
	bh=3JFqZMAO2MkfmnZnU3bo2pTnlY7l08Q7V5DHqhuci4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJkZ2BymRs/vblpZ400uloprfJmv5sapqUlKpLOPjx2SXoDxWcJH81USLRwkPZ9kdD30B4Kx+ggN6X0/ED2CXj+JItMQyx2AyRb53nbwUlJExzi8vec7HCzptnz4We/f2cQyEpsxducV2x7xp0Tns7HLTTODj9sGKJyQvUTykgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZJIgRCm5; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-795773ac2a2so13216556d6.1
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 09:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760631066; x=1761235866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bNklfLGLMtp/NkwtTHx6KVyTSE+bkeDMZ6PrZ5Am9Y=;
        b=ZJIgRCm50sGrxrRPguAdnN7gGDJSzycs6cOzVnjecSkx/0CEv6k2sE/gV1ZC5bEKmA
         bTQYWyUMxg39EKf9vEggry4yoaMqMGU16JQMmZSk/LdzcWyhUsiD2d23uFbUuLJmvwLb
         swwHrf893GCi7LAf+IhkD2nbR6vZiVZblH4erS6OXqnv7Zlwqtc19O5t7pFFJgQE5QrM
         uDriGQ+g93aUHC1RV6lBgC9f/F2AYHu6JaSh4XRUACCnT1TAH/Somc3YmBTGUs8G9uK0
         jPGamZAD3MxYZW1wenlNNjxAiJ0EgYw8g9r6pZVfPrA47dKNpipKF5LbisbKnZsUbm2Z
         XdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760631066; x=1761235866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8bNklfLGLMtp/NkwtTHx6KVyTSE+bkeDMZ6PrZ5Am9Y=;
        b=fezekdiy6GH0tlaJu+Uml6HKzhQcME3bytjevEIwRDZZ3JuYeeJ0lLRFNVugojNG9B
         QiGfzZudq1CmFbkzNqVuiwFRNVBWVpVe6JlG27oM9uUPy/BFRnbZoULCqhAmnBSr17PO
         PRJ+o5GHbRYlLbubCb+yswmy06cCTDeDy6O7RdRphz1Dn9G6d1UW96tItslAlswq4Gsm
         A+62Oe/uAJom/6Gfeu8gcBoGq66hbgEB7Imx5lJFti7/kFggvyr2ks/BJUH8maJTrF2L
         nnuYlQgeyukmiFT/Kv1kPS3UC9RTxUHU37cHZ/Xm6cZmqiveNphSC1G4l+VVqffPayy/
         q7kg==
X-Forwarded-Encrypted: i=1; AJvYcCXCX4BFhTTXjKDhqTeY3AklFPTmXTmpBnfNdoYSx9qrzYcL9M4m+10VTgqKddz1VtzJjoSGfMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq6alr8Ea5OZOysCjPpVzo+Mlh7kfWn5PrKfiE9QdV51FG/W7O
	fnewPnqoD5eJLdOrE4FPVo5gTS1DgabNaMAtz4xa4CG/QHa5Momg6GBa+RV4u1zpx0diu56bRSj
	cl9KY/10XfpJCjBNuoV1rz0XILSRCX6Rqvkqbtm72
X-Gm-Gg: ASbGnctqXUdfXcnyUwHiA/6IkE+VTX2RcUhNa5NnrfjfAluGLLcBHGDOKUM1HHevMAM
	ox0fB9hJSS43TTR8xcAdAEa4IuDyvEShh1hdhulyuRNp0mh2OjPzK3LFMXUOojB98oNLxGmCrFZ
	iDYJFwqUMrgDXMc+WRCq9rUjAWwiRs7ds1vTiWzpZTCpq5H4VV/feJ1u6Chg7udC50ENpvH5rTd
	0S0hGYt4djZo+PAhw5B3bGY29GbcFjUAbHmwjkMhZFHe5f2KQOE+C15IpS0APg4HpB4ul5B
X-Google-Smtp-Source: AGHT+IGWm95dWbRTwFj3+Wkv0/Zxh46D1RRL89kGYA5Ameb77CX72UlkgNM+rMsTASbDNACfbnvUuATCXK4/qqsqDzs=
X-Received: by 2002:ac8:598b:0:b0:4b7:a8ce:a416 with SMTP id
 d75a77b69052e-4e89d28321cmr10111911cf.24.1760631065845; Thu, 16 Oct 2025
 09:11:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016040159.3534435-1-kuniyu@google.com> <20251016040159.3534435-2-kuniyu@google.com>
In-Reply-To: <20251016040159.3534435-2-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 16 Oct 2025 09:10:54 -0700
X-Gm-Features: AS18NWCUG4sMh6UJ5akhyAEZP8SgKxvu5-RNJ3VZHCH539_JPr8fiTDIVAr3kuE
Message-ID: <CANn89iJnQErC8OLoTgnNxU8MURKANbiqXBYaUHsNaTO3m+P54Q@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/4] tcp: Make TFO client fallback behaviour consistent.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Yuchung Cheng <ycheng@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 9:02=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> In tcp_send_syn_data(), the TCP Fast Open client could give up
> embedding payload into SYN, but the behaviour is inconsistent.
>
>   1. Send a bare SYN with TFO request (option w/o cookie)
>   2. Send a bare SYN with TFO cookie
>
> When the client does not have a valid cookie, a bare SYN is
> sent with the TFO option without a cookie.
>
> When sendmsg(MSG_FASTOPEN) is called with zero payload and the
> client has a valid cookie, a bare SYN is sent with the TFO
> cookie, which is confusing.
>
> This also happens when tcp_wmem_schedule() fails to charge
> non-zero payload.
>
> OTOH, other fallback paths align with 1.  In this case, a TFO
> request is not strictly needed as tcp_fastopen_cookie_check()
> has succeeded, but we can use this round to refresh the TFO
> cookie.
>
> Let's avoid sending TFO cookie w/o payload to make fallback
> behaviour consistent.
>

I am unsure. Some applications could break ?

They might prime the cookie cache initiating a TCP flow with no payload,
so that later at critical times then can save one RTT at their
connection establishment.

> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/ipv4/tcp_output.c | 39 +++++++++++++++++++++------------------
>  1 file changed, 21 insertions(+), 18 deletions(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index bb3576ac0ad7d..2847c1ffa1615 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -4151,6 +4151,9 @@ static int tcp_send_syn_data(struct sock *sk, struc=
t sk_buff *syn)
>         if (!tcp_fastopen_cookie_check(sk, &tp->rx_opt.mss_clamp, &fo->co=
okie))
>                 goto fallback;
>
> +       if (!fo->size)
> +               goto fallback;
> +
>         /* MSS for SYN-data is based on cached MSS and bounded by PMTU an=
d
>          * user-MSS. Reserve maximum option space for middleboxes that ad=
d
>          * private TCP options. The cost is reduced data space in SYN :(
> @@ -4164,33 +4167,33 @@ static int tcp_send_syn_data(struct sock *sk, str=
uct sk_buff *syn)
>
>         space =3D min_t(size_t, space, fo->size);
>
> -       if (space &&
> -           !skb_page_frag_refill(min_t(size_t, space, PAGE_SIZE),
> +       if (!skb_page_frag_refill(min_t(size_t, space, PAGE_SIZE),
>                                   pfrag, sk->sk_allocation))
>                 goto fallback;
> +
>         syn_data =3D tcp_stream_alloc_skb(sk, sk->sk_allocation, false);
>         if (!syn_data)
>                 goto fallback;
> +
>         memcpy(syn_data->cb, syn->cb, sizeof(syn->cb));
> -       if (space) {
> -               space =3D min_t(size_t, space, pfrag->size - pfrag->offse=
t);
> -               space =3D tcp_wmem_schedule(sk, space);
> -       }
> -       if (space) {
> +
> +       space =3D min_t(size_t, space, pfrag->size - pfrag->offset);
> +       space =3D tcp_wmem_schedule(sk, space);
> +       if (space)
>                 space =3D copy_page_from_iter(pfrag->page, pfrag->offset,
>                                             space, &fo->data->msg_iter);
> -               if (unlikely(!space)) {
> -                       tcp_skb_tsorted_anchor_cleanup(syn_data);
> -                       kfree_skb(syn_data);
> -                       goto fallback;
> -               }
> -               skb_fill_page_desc(syn_data, 0, pfrag->page,
> -                                  pfrag->offset, space);
> -               page_ref_inc(pfrag->page);
> -               pfrag->offset +=3D space;
> -               skb_len_add(syn_data, space);
> -               skb_zcopy_set(syn_data, fo->uarg, NULL);
> +       if (unlikely(!space)) {
> +               tcp_skb_tsorted_anchor_cleanup(syn_data);
> +               kfree_skb(syn_data);
> +               goto fallback;
>         }
> +
> +       skb_fill_page_desc(syn_data, 0, pfrag->page, pfrag->offset, space=
);
> +       page_ref_inc(pfrag->page);
> +       pfrag->offset +=3D space;
> +       skb_len_add(syn_data, space);
> +       skb_zcopy_set(syn_data, fo->uarg, NULL);
> +
>         /* No more data pending in inet_wait_for_connect() */
>         if (space =3D=3D fo->size)
>                 fo->data =3D NULL;
> --
> 2.51.0.788.g6d19910ace-goog
>

