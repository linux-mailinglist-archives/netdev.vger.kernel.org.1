Return-Path: <netdev+bounces-137801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2BF9A9E13
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 11:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8C1CB21D8C
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 09:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC8A1494AB;
	Tue, 22 Oct 2024 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpfY2fNN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEBA126BEF
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 09:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588460; cv=none; b=eDuiqS4nvvdLN0nFqwwctUVFigc+kZPuTLY7W8GYFgRnVgnxi054MXXBeXHIlz8VyEVc6MgPfU7GAPBTRUuHKZ8Az3qiEOTJZHshR0AgEHEyou5/Wi+0njYCXLsncouQeR3pxnI4Co+H3P8DXFQYN/58E6nJATOqIGWIQVGtmPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588460; c=relaxed/simple;
	bh=2c+UCb4zLD+/Hnc7ocTcLx7elaG+FUU4zSO2q1VOxIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OdanEAe8tF8Eb37Inet2xToTK9usOpk/vfpcyvW312ExheP0lV9KQYdmmD78jn0Vi3GEB+FloPvUPzbBADwSF+p6Z7vPOZGjUwmgZ7S3Nvh/6aAiHEdnXROZdhT5I+FJ86xwHNnx0bbsQz3Zxe0JE42Cb4v2D+PZXkA1K/YyvOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpfY2fNN; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a3a7b80447so19080435ab.1
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 02:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729588457; x=1730193257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgEs9UZU+lAFXrdoUzrRizB6AnJpdtL0uSKUGCirQck=;
        b=gpfY2fNNeNDl74cPJ+LurFTfPh6C1IjLbEH2TQocYy5RgHXsnlvmGFp9Luorx7Caaq
         XtgmrpZ3A52AbtvBHBEPA9LOB10/HhsK/zDGn9yt8cV84nKjYjI9pNxSWfte87AvsuBD
         13IgKT0vPtvgpk6qpc+b5BKSByDgxMTyjzrs8GrEMCeqjpt6EesOis2Okb0c4NHzb+IP
         mfhhe0Mv0IotG2IMTUl6iI5YkCNscfLMUdLyHfAG3SBZegA+M31f+/CTl3SGTlfN+1D9
         rfgtzwz6+Vab8+j5LaLtzt7qmemU2ApPIElJXWclxv5OaiJQZAHulILZVhBgDIRdm7Zz
         +RLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729588457; x=1730193257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xgEs9UZU+lAFXrdoUzrRizB6AnJpdtL0uSKUGCirQck=;
        b=sYV0K2p62oBDyZBVACXcIjQAo8GmoAZsp1HObFjnC0Rk09seBaRnfqsxCZfkDbrzCC
         D6z7iHwKDgoP0tz7N4MJ6s3QUKuzqv4vohzQWLJb8n5RLXTd7k2OZtPd9sDlmGUwBC+C
         M/LK9MJI3esN5EFx8S4+weUdIxCuUMnAKcNiILfjKsVWWnKUsV1+NsANwLnITx+5WXE4
         B2bYyCObndnlAeHqkMzb1Nj1BbOd7DyDOju0koKYTBgmijtflZKFS+RRyddAXihUBiuG
         L2XbRaIs5YgKzo3EKi1DbtabdXLBVxLUFZCH5rkHy2DUjpLlPH2ceLKxZWI39Qkl9QgE
         iSbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhN0ciVFn9YJHY1btD6AvKk9IfrlwvQKH39tjFqu+WxN8AgqvLj1ZC9KeBZaBx1XAjnilW3/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs/Qk1j6VTxrZ+iF8WO+emRFb2S4hgrEZTMLzJeF4RIMYFYYh6
	KdMEGfj3jnFHc0qtGfZfJVhseAlKprYrcD5V8OdSSoDNRJdCsekms5Ncef74kVzOY1V19gAkBQY
	xwTbTS0GtifETygCA3nATRba1gLEUX/dN3vU=
X-Google-Smtp-Source: AGHT+IGMvoirik0O45T0ATwocixbTEAgxcuqa42aB/YzxFM2U/L0MBdsKRbIYJtYFjxYKsKHhIKD0VFxWL0uEo19Bqs=
X-Received: by 2002:a05:6e02:198b:b0:3a3:4221:b0d3 with SMTP id
 e9e14a558f8ab-3a4cd2f8be0mr21057025ab.0.1729588457551; Tue, 22 Oct 2024
 02:14:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021155245.83122-1-kerneljasonxing@gmail.com>
 <20241021155245.83122-3-kerneljasonxing@gmail.com> <CANn89iLmyNnRn27mSy_fYacvacUoNh=fy2qzCP-1tcL5g_r3vg@mail.gmail.com>
In-Reply-To: <CANn89iLmyNnRn27mSy_fYacvacUoNh=fy2qzCP-1tcL5g_r3vg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 22 Oct 2024 17:13:41 +0800
Message-ID: <CAL+tcoDuogZy76ZtBQmdC5nD=Dbk9Om31s8-jekfUeNum04o1g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/2] tcp: add more warn of socket in tcp_send_loss_probe()
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, ncardwell@google.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 4:00=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Oct 21, 2024 at 5:53=E2=80=AFPM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Add two fields to print in the helper which here covers tcp_send_loss_p=
robe().
> >
> > Link: https://lore.kernel.org/all/5632e043-bdba-4d75-bc7e-bf58014492fd@=
redhat.com/
> > Suggested-by: Paolo Abeni <pabeni@redhat.com>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > Cc: Neal Cardwell <ncardwell@google.com>
> > --
> > v2
> > Link:https://lore.kernel.org/all/CAL+tcoAr7RHhaZGV12wYDcPPPaubAqdxMCmy7=
Jujtr8b3+bY=3Dw@mail.gmail.com/
> > 1. use "" instead of NULL in tcp_send_loss_probe()
> > ---
> >  include/net/tcp.h     | 4 +++-
> >  net/ipv4/tcp_output.c | 4 +---
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 8b8d94bb1746..78158169e944 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -2433,12 +2433,14 @@ void tcp_plb_update_state_upon_rto(struct sock =
*sk, struct tcp_plb_state *plb);
> >  static inline void tcp_warn_once(const struct sock *sk, bool cond, con=
st char *str)
> >  {
> >         WARN_ONCE(cond,
> > -                 "%sout:%u sacked:%u lost:%u retrans:%u tlp_high_seq:%=
u sk_state:%u ca_state:%u advmss:%u mss_cache:%u pmtu:%u\n",
> > +                 "%scwn:%u out:%u sacked:%u lost:%u retrans:%u tlp_hig=
h_seq:%u sk_state:%u ca_state:%u mss:%u advmss:%u mss_cache:%u pmtu:%u\n",
> >                   str,
> > +                 tcp_snd_cwnd(tcp_sk(sk)),
> >                   tcp_sk(sk)->packets_out, tcp_sk(sk)->sacked_out,
> >                   tcp_sk(sk)->lost_out, tcp_sk(sk)->retrans_out,
> >                   tcp_sk(sk)->tlp_high_seq, sk->sk_state,
> >                   inet_csk(sk)->icsk_ca_state,
> > +                 tcp_current_mss((struct sock *)sk),
>
> You can not promote to non const, because tcp_current_mss() might
> change socket state.
>
> If a debug helper changes the socket state, then it is no longer a debug =
helper.

It does make sense. Thanks.

>
> >                   tcp_sk(sk)->advmss, tcp_sk(sk)->mss_cache,
>
> This was already reported btw.

So I'm going to remove this tcp_current_mss() line.

Thanks,
Jason

