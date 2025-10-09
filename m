Return-Path: <netdev+bounces-228322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F40BC79C5
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 09:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82D2D3E6F7B
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 07:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BF52BE65B;
	Thu,  9 Oct 2025 07:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TnvQmqxZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB7F1C1F02
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 07:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759993679; cv=none; b=J7xl6ONLTbxZ6px3Q1mtNrEsXhZlu6hXFZAAGbWP4al7X8y7Vq80T3F/yPcWtqKhNg3s+Bvy3HkIfdcd5CYeKyHRX6ssbhKDI6/SH0H53BUG9YWYq8mc57GpOMm8pzK9kN8TgJYguiXddKrFZdKydpAnaxY+usXEkMMPR76jlgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759993679; c=relaxed/simple;
	bh=lbbVyk5jCBer66b9CPFbrfSyMRiBlKAI8daIXk3lt70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dr1zcHYP15Bztl4Rhj7Z0hs6qrWjwrBvP0u6Zf0r2ER2VRVprlexzqwRtYYLrogrhMwGOrOPT2KHG89GLRpxKVptHwjKM7noMoGblM2IEyZfUED+NL6Q+m+8ajuglRJM5UU5ST5lGBPnjiKPOR2gjrRV5xUEYtycbaagVw4xfoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TnvQmqxZ; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4df0467b510so6037561cf.3
        for <netdev@vger.kernel.org>; Thu, 09 Oct 2025 00:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759993676; x=1760598476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3M52dh1h+FfVjykyrFeFn3fcuq9jJ8NMh6+SJVp+QDw=;
        b=TnvQmqxZFG/sxOwPBPwnYGgMkEc4zqUpG4EHS4nuKORDYTrncQOkNboEATQGD+jc8k
         Fx9Dgl5Xlv8+PULY5zYHD/7tehLiEpgt+dupflPvF2x69WkLuDREPnjj4m8iJK9cxSss
         0yBCfCBmnxR1Qi/RKE547TJnRZcrRUll3hwlTBnfTGm8lb/qaJM76Wv/SSjeUeavR5Ts
         9TUL++xlKd+7mS732GqXIDn3pEY7Tmximo7hstttDYJs1naJiGgmWmCJo+edOLiYM3aZ
         TAkTm2d3OYXFOxoHexAf62Qpvutax+IxHbsKTJaSN2YACZd7u++x0sjlgcNjXBU9V7cx
         dLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759993676; x=1760598476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3M52dh1h+FfVjykyrFeFn3fcuq9jJ8NMh6+SJVp+QDw=;
        b=FekPHAJotVFOx/Ahs8Vvq08Fq/sWYRt/OzgAhT+1reihx4kZ07L79hxFlVsSzL1RXI
         8rpO543lkw1+1r4FfHmVkYAIT2wSlmKQR50Z9T5yFCGvE9Cew1ybAVCgFV2wV5yHs+kz
         in0mARY0/ANGG0SXpAFdxWRKQDsJTwPGkWC4AuMEVL9D3TAl6Oomld0Fh/kdBP8NCZD/
         Npj8vb6J7N2nzOEzTyTcaR+Bu7rkI6HVQpAkPpDmrF8Cxu2iab7X1D9kISZGo5CvFWAh
         FSB5XAg+c9FG+NGkqqWyeeB6OCiOYWOsMzozQsTvba7hhhTQAE3baAyU96Ksvqd/8onZ
         ulQw==
X-Forwarded-Encrypted: i=1; AJvYcCV0JIv3xmC1KUVkkHxXoaKEj/1MOwtV8xi1nE2ySyDNolLSLOzjtHaIgDVG2maJEMumdGwSFQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwt+HgTbz0pJOY6LZ5TRyT+7FoOF6v5DXLd/45K07lvD1Y1Xo4
	+0tQl26AxHTBrXRPB66eWDiRk9PDsY9V80N5IRi4WN97SvApkYFLn7GLmtds7zuGPYl1NXZtGmU
	siy+yCAg/e7uGtziG3UmECc2HNxZmhQDjuALjT30M
X-Gm-Gg: ASbGncsXQBwVHizo6ihZ/1RRbJURVXxblKKpBtG6am1/yVQSnbHRDODxlgVG14qQEOv
	jVWgU+oDM7UVYm8XqY4jCpccXeHmWdFp2X6wbiZQD0VbHXfyc1QEhfs8lYIDfCicIPxayxb7l9U
	IXI+CyPKw1nZA8l2coYGF/uad08iVDvjlFF8Xf0mPPZgDMBrDUwzrKqNHpmzbQMEkZfUgozUR1E
	yPRtNHFnxfX3/i1gscr1aiQpn7oBJEJZkknrw==
X-Google-Smtp-Source: AGHT+IGX8qBecZyb+pIbR5G0iTKPZsClm1K9y+5nFkeZs4NBukkbXnHL7r7xRdYK4Yr36ptDZgKGjM2jiXSeZKLPycE=
X-Received: by 2002:ac8:5847:0:b0:4d2:95ab:ecb0 with SMTP id
 d75a77b69052e-4e6ead5afb8mr84565721cf.64.1759993675359; Thu, 09 Oct 2025
 00:07:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3b78ca04-f4b9-4d12-998d-4e21a3a8397f@chinatelecom.cn>
In-Reply-To: <3b78ca04-f4b9-4d12-998d-4e21a3a8397f@chinatelecom.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 9 Oct 2025 00:07:44 -0700
X-Gm-Features: AS18NWASjTPvsTSPBC6XRuDuoZqgCPV0bsX2fSbCWNUjwlh1HcRwARWtjH3Fxjw
Message-ID: <CANn89i+rHTU2eVtkc0H=v+8PczfonOxTqc=fCw+6QRwj_3MURg@mail.gmail.com>
Subject: Re: [PATCH] bpf, sockmap: Update tp->rcv_nxt in sk_psock_skb_ingress
To: zhengguoyong <zhenggy@chinatelecom.cn>
Cc: john.fastabend@gmail.com, jakub@cloudflare.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 8:07=E2=80=AFPM zhengguoyong <zhenggy@chinatelecom.c=
n> wrote:
>
> When using sockmap to forward TCP traffic to the application
> layer of the peer socket, the peer socket's tcp_bpf_recvmsg_parser
> processing flow will synchronously update the tp->copied_seq field.
> This causes tp->rcv_nxt to become less than tp->copied_seq.
>
> Later, when this socket receives SKB packets from the protocol stack,
> in the call chain tcp_data_ready =E2=86=92 tcp_epollin_ready, the functio=
n
> tcp_epollin_ready will return false, preventing the socket from being
> woken up to receive new packets.
>
> Therefore, it is necessary to synchronously update the tp->rcv_nxt
> information in sk_psock_skb_ingress.
>
> Signed-off-by: GuoYong Zheng <zhenggy@chinatelecom.cn>

Hi GuoYong Zheng

We request a Fixes: tag for patches claiming to fix a bug.

How would stable teams decide to backport a patch or not, and to which vers=
ions,
without having to fully understand this code ?


> ---
>  net/core/skmsg.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 9becadd..e9d841c 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -576,6 +576,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psoc=
k, struct sk_buff *skb,
>         struct sock *sk =3D psock->sk;
>         struct sk_msg *msg;
>         int err;
> +       u32 seq;
>
>         /* If we are receiving on the same sock skb->sk is already assign=
ed,
>          * skip memory accounting and owner transition seeing it already =
set
> @@ -595,8 +596,15 @@ static int sk_psock_skb_ingress(struct sk_psock *pso=
ck, struct sk_buff *skb,
>          */
>         skb_set_owner_r(skb, sk);
>         err =3D sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, ms=
g, true);
> -       if (err < 0)
> +       if (err < 0) {
>                 kfree(msg);
> +       } else {
> +               bh_lock_sock_nested(sk);
> +               seq =3D READ_ONCE(tcp_sk(sk)->rcv_nxt) + len;
> +               WRITE_ONCE(tcp_sk(sk)->rcv_nxt, seq);

This does not look to be the right place.

Re-locking a socket _after_ the fundamental change took place is
fundamentally racy.

Also do we have a guarantee sk is always a TCP socket at this point ?

If yes, why do we have sk_is_tcp() check in sk_psock_init_strp() ?

> +               bh_unlock_sock(sk);
> +       }
> +
>         return err;
>  }
>
> --
> 1.8.3.1

