Return-Path: <netdev+bounces-169412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 573C6A43C18
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 11:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2B6A3A9CB6
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A66C266B43;
	Tue, 25 Feb 2025 10:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="inVk5mhH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D47265637
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 10:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740480188; cv=none; b=Z2ckLC6/YvJ2FHuM66kV4J6mxm2LBySFCRU7WKrPCMAstbWY5E7bvVvPAko25i0rLMxZeH5nHj3SZBvtheRKL0CGT+L7gzvQPCVweKG9DJwpf7XQRwlNT2LoXnvVYcDuxDecgb7Pu0p9hcWFYekCSO7O+gXdOEwQKlr3GuAEv8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740480188; c=relaxed/simple;
	bh=WmX/HKbPg2yhjHd2ztqu4hvAwiWSwjJEY8ElVwafig4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rfn4kC32LhE5/Ke08giZRZ1cvg9Je2wm/c4Fq3Ho+gnqiuUx6reWmhcPa8pz8GAIKJbZkRRY0wyawOPcNDyEwJ94B/yVlYJ+HgtkTwU4YqXH2uPhQZSamv1fmKpUn6Gs5qZo7NKXbhx+1QoOScH3hSbwOgrP63z7Yaxto8jm98U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=inVk5mhH; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5ded51d31f1so9652303a12.3
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 02:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740480185; x=1741084985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/9NSaPWarJT8m9YpOKT1i1+rtd0gBduX7v6m0zq7l8=;
        b=inVk5mhHcVvfBa/OvZghALCJSC8IGaIHJj2HRmXC8qA7ac6jPXlM+OkeFwKz77YeiC
         9Jpjw6e8R9GaBqI1i+txEO9Kzr5ybFd4S/v3YGedIlFM3MmiO+qa0kEUtmcjgjTrJwGp
         wFARFOUzKaQDvnCArannwbX2aixc9mp5Uii0vjDGaRGm4U23IJamhnLY0kYhAHeMC0Hc
         svpHGMLfxl6akeMiC+bAIfJ9DAD2lShpUzOokinNAH0HuL0uCJjOrdT0IwYM6M0nRTei
         f3cmL+yPgC2WJ63WWnPimm3OlJfvICD5ht1Ct84CNfu/in+FyI8rz9iZ6w8kLyoj2Ckp
         qn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740480185; x=1741084985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/9NSaPWarJT8m9YpOKT1i1+rtd0gBduX7v6m0zq7l8=;
        b=A7u5B9J6dAzXaEp/gtS/pN/4zir24k/i8nxmVEYPaqxvDSV2JVs5Qn8Sya3lu/7SQk
         LtUz/dtKFVde6xAO/OWg50IB3dYT3Onhx7QPpy6RToTx/k9r3i9Bb//kiqWlNk53i6Py
         o4fHCIgj0uEPajgU/lBRkNGeEPM5tQDLapeH6P1zDc3RH/APozPs5ZSLDd+ZbHFa+kMx
         IKbJuoG5yMJcM8JYk3oL9THoCMQEDxm4TMYEVZAuAN2StlFQZsCH4NX0/HYSxejgOG+J
         llQLqNBgKOdr1IVdMboStqSlps/D3rL6jhY3tTsUW11Rs5pulqKLqfDSc+fzhXLsUhj6
         UwhA==
X-Forwarded-Encrypted: i=1; AJvYcCXgGRVraDRjbVOVPZ4pMfGjiVnbEZlkwDdnraFe2j1YWUlseO0ti3C5gIEHcxug074gy6LXwPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA7WvshAdjLVuiGH3vaHqc8s9tQN5NxhrBNQMz1VdpsI80elm1
	64OiZHY8fbMyGOu4CyjZQTPZppy5YTfGZHQlDD6rhOYhkoL0NXphEChsK+xXXaVL1z/UjI5SbB+
	C1VWoHo1WuPnMiaXed3TiwYd60Pe3z9rRwnMikWthzzJ58urI1PT7
X-Gm-Gg: ASbGncvHbkOJMJOVdazdjUM0hnOlxoIHEXkrN73SShnxDS3ZJAIxGM1v9juxjJUhnTq
	qY/V1IFuxX43qKiCOE1uhzT7I8zuiNCpgJKgiOmshYHlKNZn4c02jx3dlZ7WYpSYAXl5Yb1Wfpq
	2w3ib6I3Y7
X-Google-Smtp-Source: AGHT+IFmvOYpL5a8G0B4ujBz7Hpsgq2tRXpKOvHe+Lsgvln4A1XoNRhCi1/G6JDb6Xa5vkpf1HeIgatPhogDTU0FDrk=
X-Received: by 2002:a05:6402:51ce:b0:5e0:750a:5c30 with SMTP id
 4fb4d7f45d1cf-5e0b721dfbcmr15731622a12.20.1740480184613; Tue, 25 Feb 2025
 02:43:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224110654.707639-1-edumazet@google.com> <4f37d18c-6152-42cf-9d25-98abb5cd9584@redhat.com>
 <af310ccd-3b5f-4046-b8d7-ab38b76d4bde@kernel.org> <CANn89iJfXJi7CL2ekBo9Zn9KtVTRxwMCZiSxdC21uNfkdNU1Jg@mail.gmail.com>
 <927c8b04-5944-4577-b6bd-3fc50ef55e7e@kernel.org> <CANn89iJu5dPMF3BFN7bbNZR-zZF_xjxGqstHucmBc3EvcKZXJw@mail.gmail.com>
 <40fcf43d-b9c2-439a-9375-d2ff78be203f@kernel.org> <CANn89iLH_SgpWgAXvDjRbpFtVjWS-yLSiX0FbCweWjAJgzaASg@mail.gmail.com>
 <CANn89i+Zs2bLC7h2N5v15Xh=aTWdoa3v2d_A-EvRirsnFEPgwQ@mail.gmail.com>
In-Reply-To: <CANn89i+Zs2bLC7h2N5v15Xh=aTWdoa3v2d_A-EvRirsnFEPgwQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Feb 2025 11:42:53 +0100
X-Gm-Features: AQ5f1JokaK0Wn2iXZTSfx7TAl06FEfUvmeqi1PbFvQDBlpMNXB96A8mb0s8x5Xk
Message-ID: <CANn89iLf5hOnT=T+a9+msJ7=atWMMZQ+3syG75-8Nih8_MwHmw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: be less liberal in tsecr received while in
 SYN_RECV state
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Jakub Kicinski <kuba@kernel.org>, 
	Yong-Hao Zou <yonghaoz1994@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 11:39=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>

>
> Yes, this would be it :
>
> diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> index 728bce01ccd3ddb1f374fa96b86434a415dbe2cb..3555567ba4fb1ccd5c5921e39=
d11ff08f1d0cafd
> 100644
> --- a/net/ipv4/tcp_timer.c
> +++ b/net/ipv4/tcp_timer.c
> @@ -477,8 +477,8 @@ static void tcp_fastopen_synack_timer(struct sock
> *sk, struct request_sock *req)
>          * regular retransmit because if the child socket has been accept=
ed
>          * it's not good to give up too easily.
>          */
> -       inet_rtx_syn_ack(sk, req);
>         req->num_timeout++;
> +       inet_rtx_syn_ack(sk, req);
>         tcp_update_rto_stats(sk);
>         if (!tp->retrans_stamp)
>                 tp->retrans_stamp =3D tcp_time_stamp_ts(tp);

Obviously, I need to refine the patch and send a V2 later.

