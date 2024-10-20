Return-Path: <netdev+bounces-137309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2149F9A554C
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 18:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F241B20CF8
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 16:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC82519408C;
	Sun, 20 Oct 2024 16:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHa8nDIs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AF16AA7
	for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729443046; cv=none; b=MRO8Nnx/PJf9gxY/ETumQZPoDrj1kZ3CBWujEKAztBN9VcZ9EZUscuMArF+v+lgrtggB0lMOhWMqrwvzwD5RU9EIHyYtph/F3zqOSZ+AQa8PdBXHFNA8zsPsnz4Sr3gJF349BqEDrjSgA1phsZRLG+C5Eq0Y2moWkFB/ujQekL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729443046; c=relaxed/simple;
	bh=8MgR8/qU67409kT85WfxdIfst354T1e6zkajpXIQxIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNplE+XCkpM1Xr2LGHH9wia7cIzfq+e9LSIwz4KuBTw2KpdcMgcHMQ4LuMt3wvwpkOIjixr8CZk2mm9zX6wsml9iLqPL9PwlMWOVfXNNMK5S/GNiWS041W5qDOJxTqmH09GOJ6QLBGWUsgO/mJWVpBRZ771MJQHuD4hxfpoueM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHa8nDIs; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-83a9be2c028so130565939f.1
        for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 09:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729443044; x=1730047844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2WiIfQWKFuRVeohXed6wrR/aQcy1H9nUKuB5CE/CkkQ=;
        b=mHa8nDIsLGMkpMcNH8oV/nc+/UQd50sOm863e5uqmCoLZ6ICJPhy1aFT9ElJWRPImh
         Gk+2QV5VG/OnvCYOs5G6stmauH0x0H5jSkmifza3h+T+O1a6EMNoYYt0mOYoJyI6A//h
         bnpQ7vNlaI+Ur6xpuMq6VHgyfjZl1nZNMK1k3bdiX67bLEHNmQ136+8SakPLqbisPrU6
         GFZlWW03Aw2y+IWFg6bmhEEYKWIacSpMh8VQsV780C56+da0iP1/hTsjuscmcsmTd103
         kVnn0KtXrNBNmIdeJkqjXzeEKfu3V/8P8FcMXM2788eRPnS5eGXgNK8oBiOxDXR2pvM9
         Wt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729443044; x=1730047844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WiIfQWKFuRVeohXed6wrR/aQcy1H9nUKuB5CE/CkkQ=;
        b=XgTsiL4a4AtuDiHn+ZaClhREzKYzP1y2zQM78eN/0gz0zj8lvg/vhUyYP64eptgc+t
         a4F20bSCIItABjFXH+fhmtvaXLB3ff2UgaNkOWQpKpwpUayXo8y3QaIGA6HIEhA79SKR
         eJFs1kLaFZ4O30h/tV1xroHkX9jQ229gHxKVHB2LN+H5vrkDSvrtR3IPK5BcOurb9SAt
         bPJY4pfXqLbi8K1qvq5Q8FNp7fxZ0HdsMD+CRf8E/ZLjb4dUtjOr376sfXFfeB8C5OTF
         GSOs7NPl2qyv2TCM8hl7TWlJjEzgecLHc+wB4xtbDl5byaEcth8C7C7sfXu9Vhqa9aox
         IUKw==
X-Forwarded-Encrypted: i=1; AJvYcCWDrGPaF0pFzTdu0pAjfxTds44wPrSt/JIuMyH1zktpdDqO5w8veKL5lUU1+NXg5RyATYZ+4/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe3w22eK6n1WVv5qGIixfHIUCl5Qwpyio4Z6L+5KHWxeEbgcCy
	GyXEZ6/tT/1cY6sMZWFNvkKcLmMZu7ut6K8xJhYLOU6bSp9YnSPEyndEPAc3JBSJFJ83tVsC0yM
	9GM2QLLPRWH+1+An9ptIFv/RBNj4=
X-Google-Smtp-Source: AGHT+IHKtdPwKAjwuYNEvxnN4AarGRAwGzmMwfl9P80u78ZeR3tl8zA12CbzQMSqxPARfyMwmGTk0Nwf87uDx/S1+E8=
X-Received: by 2002:a05:6e02:2141:b0:3a2:e9ff:255a with SMTP id
 e9e14a558f8ab-3a3f40b139fmr74629345ab.22.1729443043939; Sun, 20 Oct 2024
 09:50:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020145029.27725-1-kerneljasonxing@gmail.com>
 <20241020145029.27725-2-kerneljasonxing@gmail.com> <38811a75-ae98-48e7-96c0-bb1a39a0d722@kernel.org>
 <CAL+tcoByVRMTt5r1WPN8ovwQDW0fO-ksWya-MCMw2v_93DOCLQ@mail.gmail.com> <65575e53-c5b8-47a9-a0e8-034f42211844@kernel.org>
In-Reply-To: <65575e53-c5b8-47a9-a0e8-034f42211844@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 21 Oct 2024 00:50:07 +0800
Message-ID: <CAL+tcoDnQ-BEvQAJvw5LWLSR0gHzHZCjzzTztHo=kBetYgomDA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] tcp: add a common helper to debug the
 underlying issue
To: David Ahern <dsahern@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, ncardwell@google.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 12:41=E2=80=AFAM David Ahern <dsahern@kernel.org> w=
rote:
>
> On 10/20/24 10:34 AM, Jason Xing wrote:
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 739a9fb83d0c..8b8d94bb1746 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -2430,6 +2430,19 @@ void tcp_plb_update_state(const struct sock
> > *sk, struct tcp_plb_state *plb,
> >  void tcp_plb_check_rehash(struct sock *sk, struct tcp_plb_state *plb);
> >  void tcp_plb_update_state_upon_rto(struct sock *sk, struct tcp_plb_sta=
te *plb);
> >
> > +static inline void tcp_warn_once(const struct sock *sk, bool cond,
> > const char *str)
> > +{
> > +       WARN_ONCE(cond,
> > +                 "%sout:%u sacked:%u lost:%u retrans:%u
> > tlp_high_seq:%u sk_state:%u ca_state:%u advmss:%u mss_cache:%u
> > pmtu:%u\n",
> > +                 str,
> > +                 tcp_sk(sk)->packets_out, tcp_sk(sk)->sacked_out,
> > +                 tcp_sk(sk)->lost_out, tcp_sk(sk)->retrans_out,
> > +                 tcp_sk(sk)->tlp_high_seq, sk->sk_state,
> > +                 inet_csk(sk)->icsk_ca_state,
> > +                 tcp_sk(sk)->advmss, tcp_sk(sk)->mss_cache,
> > +                 inet_csk(sk)->icsk_pmtu_cookie);
> > +}
> > +
> > That quoted line seems a little long... Do you think this format is
> > fine with you? If so, I will adjust it in the next version.
> >
>
> Format strings are an exception to the 80-column rule. Strings should
> not be split to allow for grep to find a match, for example.

Thanks. I got it. I will use the above code snippet which can pass the
checkpatch script.

