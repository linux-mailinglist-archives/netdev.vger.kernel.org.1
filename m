Return-Path: <netdev+bounces-240884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4043C7BBD3
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 22:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C05E3A7711
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 21:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1226C2FFDE4;
	Fri, 21 Nov 2025 21:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="BdTpbf/3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ACDE23EAAB
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 21:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763760288; cv=none; b=Xz5xZbKGbWzyZvdhmi8AhKicvqe0b8aTqMNIgHwQcNUoDKhLZaqTcDdgQO0GJgsBgJuKDQ/jvHAmnH8y47Do2jeGh4qq/C3+dnfl6nCPfpbdpFv02SZUgUP4gKW9oUH2W3vBezPeSOrlNMOTZNrJt0dlLMmzl57SOYjZByc4o8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763760288; c=relaxed/simple;
	bh=VbLukKYtSA/4j16z9XgzXMTVmXuqCnWBViq94fgKNeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PFTS/j9J81cUVMGuNQsDVcybpweY0p/YWfMdGFG4Dtk+M2Qf0OoLOA2RrBPPilKbBGeNRbt/rjH775KgMVTdnXtLiosO35gqiDVa/5Wl68bdUJnxsGbjeu5dC220Ku1b6iNQcioTBGaP3diPxwB/9g/OZGEzOcwDk2Bpwr43ylQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=BdTpbf/3; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-37ba781a6c3so21056431fa.0
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 13:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1763760284; x=1764365084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPPV2M/XV3JZdiPTAOibkhCSD8tgfMgp4YdHlZ3Hgls=;
        b=BdTpbf/35fyl2Kaz4yGQ5/Id5qVwDJk/0KRqoscuO8Cwdi+rkl/FqhXoTaA4KsgU5L
         rXmkg7AKoOxzsWVfoDDq/qXf0vx3+bEeyMfI/ptJE8anDSki+zFgI0OjqwJSdqYVRaTn
         fnkWptUOKnLdQk/1MoseNzTAFgcshRMKxjQwFubc//hrtHIkKuNDqxJOZDhO+LwocMgr
         mcg82dXY1ZcWogaewpDIzusnG3gsrmBtWPa4ndMcvJVygcbezyTvxNc3CzX5TZRK9QdZ
         NqDK6kiBDDbcNK2bq7svWsRkRgeM5G0oRJqc49kdc7Ip8aJZs41QGFdHTwNbFFU0Ups2
         /eiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763760284; x=1764365084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wPPV2M/XV3JZdiPTAOibkhCSD8tgfMgp4YdHlZ3Hgls=;
        b=vdpmMxaJOUw+PcFrmiEPsimdTO6lG9XU49l4seAFUrfH1xhIEyIDzcG0FUet84NlLi
         WT3ae4Gf9ci3QyOBts+6wuD4GKV/a0DGJIAAPQzcvNh2cU9PIolhOEh4xIUYg4FaRVMe
         65FdphTOxrGFpOERCA5KnueXnXDw2wRh9AbLtbS6Ek1e/JguaYjYgW6JOkeSKvQbKFOK
         XoDLkqAE/gkiU4slM7x5xFSdM1Dr2pUwGiiga/g2xcCjitTknMXwGckEW+wwuN2JriuA
         aa9kvEjvpOVBC19XrAxmGwkJb17DNHyMkDrE2/3h1jl3NQC8NexovxF5zti1s53b5NYr
         kPdg==
X-Forwarded-Encrypted: i=1; AJvYcCVS1LG5ZbpGUeO4w3THvweQuw23D6nnZfuUB+yytc1D1J5k47ifBrLIfqecL65QE0rm/eQuAVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAPJvxVzQa0zKezFMJZ3PWXkLLys3BDJYjcSpvMCndSDPg0aJY
	qVRbdyVWWTktmyh9ejHBmU9S4th9lYrPMSeigPyYOg0sVuRvfZfBIW57S1OmkLAgZNggEE+CI1V
	jc1/9NuzFdbuOtuw/vVLD8kf7apEI9JJleH19h+Cq
X-Gm-Gg: ASbGncveWNrxhMxjXV3gIHzJ2JJti0A4GyDnzdgX8qZxRApo5XbHwiC2fVCDSnz0OWP
	j6fEAc8eBtvpP8/GYoeJVbfBDnlK+IneBrs/CHtqczgon8FbwkPvSj981s0hdovKxjguyCfxByi
	fpAJmOJ9gKHj7jb9lTzgWfHc3HtMZCENXI36zOheNM3b1oUH8NI+RJXQjxrNnX45RgUyNWJt+f8
	AbzcMbPchRkZgQ9azIvRMFHr9poALh4HtDnb3Ca4trPd552qk5YmdEo1o0mIcx3z8rOclMUpqk+
	vBQ90iaEXgiidjTZDPAWJig3iaoc3hPgXGbR0b1T3N+jIDSgzkstxwTDVyQ=
X-Google-Smtp-Source: AGHT+IEpl8qDvbU6ciFPMPGZ8NR8BxZqgyssnweGfXuri+OOiAd9ktvQBvkioPuPxudKbXuKmiARXVIwT17DilmQcNU=
X-Received: by 2002:a2e:83c7:0:b0:378:e437:9085 with SMTP id
 38308e7fff4ca-37cd9284a9fmr9059511fa.37.1763760284072; Fri, 21 Nov 2025
 13:24:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112001744.24479-1-tom@herbertland.com> <20251112001744.24479-2-tom@herbertland.com>
 <553d867e-b95a-40fc-8f82-03449e3781e3@uliege.be>
In-Reply-To: <553d867e-b95a-40fc-8f82-03449e3781e3@uliege.be>
From: Tom Herbert <tom@herbertland.com>
Date: Fri, 21 Nov 2025 13:24:33 -0800
X-Gm-Features: AWmQ_bkYMScOcZG0OOFZAj3Ie-HKGaRZvWronKotscFSXQjgFRQMfnLuLRz_omA
Message-ID: <CALx6S347Pj82aFnV9=ghMQab+sQV=tM5eMSMjWaRC3rnJ0bc8Q@mail.gmail.com>
Subject: Re: [RFC net-next 1/3] ipv6: Check of max HBH or DestOp sysctl is
 zero and drop if it is
To: Justin Iurman <justin.iurman@uliege.be>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 5:17=E2=80=AFAM Justin Iurman <justin.iurman@uliege=
.be> wrote:
>
> On 11/12/25 01:15, Tom Herbert wrote:
> > In IPv6 destitaion options processing function check if
>
> s/destitaion/destination
>
> > net->ipv6.sysctl.max_dst_opts_cnt is zero up front. If is zero then
> > drop the packet since Destination Options processing is disabled.
> >
> > Similarly, in IPv6 hop-by-hop options processing function check if
> > net->ipv6.sysctl.max_hbh_opts_cnt is zero up front. If is zero then
> > drop the packet since Hop-by-Hop Options processing is disabled.
> > ---
> >   net/ipv6/exthdrs.c | 6 ++++--
> >   1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> > index a23eb8734e15..11ff3d4df129 100644
> > --- a/net/ipv6/exthdrs.c
> > +++ b/net/ipv6/exthdrs.c
> > @@ -303,7 +303,8 @@ static int ipv6_destopt_rcv(struct sk_buff *skb)
> >       struct net *net =3D dev_net(skb->dev);
> >       int extlen;
> >
> > -     if (!pskb_may_pull(skb, skb_transport_offset(skb) + 8) ||
> > +     if (!net->ipv6.sysctl.max_dst_opts_cnt ||
> > +         !pskb_may_pull(skb, skb_transport_offset(skb) + 8) ||
> >           !pskb_may_pull(skb, (skb_transport_offset(skb) +
> >                                ((skb_transport_header(skb)[1] + 1) << 3=
)))) {
> >               __IP6_INC_STATS(dev_net(dst_dev(dst)), idev,
> > @@ -1040,7 +1041,8 @@ int ipv6_parse_hopopts(struct sk_buff *skb)
> >        * sizeof(struct ipv6hdr) by definition of
> >        * hop-by-hop options.
> >        */
> > -     if (!pskb_may_pull(skb, sizeof(struct ipv6hdr) + 8) ||
> > +     if (!net->ipv6.sysctl.max_hbh_opts_cnt ||
> > +         !pskb_may_pull(skb, sizeof(struct ipv6hdr) + 8) ||
> >           !pskb_may_pull(skb, (sizeof(struct ipv6hdr) +
> >                                ((skb_transport_header(skb)[1] + 1) << 3=
)))) {
> >   fail_and_free:
>
> IMO, this patch is necessary, whether or not this series is applied at
> some point.

Agreed. Thanks!

Tom

>
> Despite being an RFC:
>
> Reviewed-by: Justin Iurman <justin.iurman@uliege.be>

