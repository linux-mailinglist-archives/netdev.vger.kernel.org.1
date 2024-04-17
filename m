Return-Path: <netdev+bounces-88826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D4F8A8A0D
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 19:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A06AB279BF
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 17:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D205171669;
	Wed, 17 Apr 2024 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yqxgxcpZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3B114199C
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 17:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713374067; cv=none; b=RDyERA5OU5Q4FNhFWp7dZY459SpX1xb3IPs5HwlhFA0cHWPv3IQOcMvxAgSU7FqxPdJ2Midf0QqXOOIUTzeclwiiDf9NWA90jCuxKRHOxq4WLJDxl7dWRDQhS8xByd9A/GzI35oxOXtEqUb9oWQKurwfyVT8KS/05r0/ejHHNgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713374067; c=relaxed/simple;
	bh=8h6dTvorT4Ylqavu4znsyltkdj7Es9QLPGkNLy6/HTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENfTWmomgi8uRD1NAoFBuiU2YdhJ/EnR0F4PMLPxv5yNJpLoSn12ecA/e4USgmceb1BfQs3vknXwK8gxq09RISJxzR1JrKRsq4ncpnX6x846jEqmcBfJDeESynhkBF25nQ6g+i2ikYCtnVl45SjuQDZ/364Wk64tm01gtYnGbRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yqxgxcpZ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41881bd2ea7so2515e9.1
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 10:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713374065; x=1713978865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5SygzrnJsWN0niGriL9dVC73N52bISysk2tXhiV2hPk=;
        b=yqxgxcpZGI84tkw4yJ61iVr4LXYKQHlDb6ZYwOPv/dgeG0uJK3wbRfd4qQYCJKE9mK
         ybDGJPiqGTjATqYJdmdkGLvJeXhdpeDmYQdyDRpJ6L4wyWF1/YZ/sQwAuYoYgyxn6Xrv
         RUvVwdnp0Hx2qSIk3k78RNdx4WUhJqLswa1y3SO43gp9UH6/e/rEOyzXdC4UNrGSIPch
         ogpX/yGjYX3InXAjs8FgpiMfr0OaJgRZY6hPqVb4fnFel+nfvaD6AlofkqV+66gvd+mU
         9jDtUoXefa51PZnLt+16jVpiVsEr+vpYYOrH/hV7SG9kvtnQ5abMhPXkecV04BG20zfg
         Y48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713374065; x=1713978865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SygzrnJsWN0niGriL9dVC73N52bISysk2tXhiV2hPk=;
        b=kCNjK3X9gah9VYSmIE1zoHXsDd5vOtN+coy6Dx/Ri/JFiE4VtRNKjMhOtNBLOElWeH
         aFZZ1CuD3eeBjjx+ckpVLDNjPNgnPH6mMZKgOqRnsOUvxialoQnVVtz0Yf/hOyju80qR
         RvkAP57WQRBrhoaBOaOvFJf4d5oYKg0KFK82tCoPPxrYmiRMCO32rwvaI+01viukoDCa
         pu25KytKYGRdw2N6xXD8CZ7QZUNYqY3A9yDu3E2jidLpsKzihp8d4REYHCvAmN/Mdhzu
         wLpj3L8obWwlghG8X9ixnnnL5sMtMiFUfBmnVlJ+zN529mIsfk9XRrsehLxYq8vOQRw9
         ZboA==
X-Forwarded-Encrypted: i=1; AJvYcCWnXnxqs8CzG1Q0dqrm9oIUweV/v673i2HQo4tLiZ0zlU4EUKPPYEIAo/KJ4JzLEK3AUlbW3LEA4vl0jWjiOn3nOk0sDiRC
X-Gm-Message-State: AOJu0YzX4q9egS+9ZNs1yVOl7LYTwJHDlRBsaNpxg+5PvUhZcIq5bB+v
	j9TpMxvjW1IV0iEiv7LPvWAN4+YGWEM8APIkeuamS5fD7iK/9xImdLMx/vExOvq/fGNclD9qf5x
	szQckiVGVKoybwKmbmpqpDX3G/1L32oCaJCHL
X-Google-Smtp-Source: AGHT+IHC9w1dRcTSJd4LR1vqBhDitDvE4OLQZsFelNu8F7q7biluu3WAq39F3GvCsom5Ep83YPEYuU9BFAcKTDsOoeA=
X-Received: by 2002:a05:600c:1c03:b0:416:7385:b675 with SMTP id
 j3-20020a05600c1c0300b004167385b675mr212311wms.7.1713374064436; Wed, 17 Apr
 2024 10:14:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415132054.3822230-1-edumazet@google.com> <20240415132054.3822230-10-edumazet@google.com>
 <20240417170739.GE2320920@kernel.org>
In-Reply-To: <20240417170739.GE2320920@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Apr 2024 19:14:10 +0200
Message-ID: <CANn89i+jt2dk4yF-k2U3iDcDgwBp-hOs9EGpdHU9F4cEcQteSw@mail.gmail.com>
Subject: Re: [PATCH net-next 09/14] net_sched: sch_fq_codel: implement
 lockless fq_codel_dump()
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 7:07=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Mon, Apr 15, 2024 at 01:20:49PM +0000, Eric Dumazet wrote:
> > Instead of relying on RTNL, fq_codel_dump() can use READ_ONCE()
> > annotations, paired with WRITE_ONCE() ones in fq_codel_change().
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >  net/sched/sch_fq_codel.c | 57 ++++++++++++++++++++++++----------------
> >  1 file changed, 35 insertions(+), 22 deletions(-)
> >
> > diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
>
> ...
>
> > @@ -529,30 +539,33 @@ static int fq_codel_dump(struct Qdisc *sch, struc=
t sk_buff *skb)
> >               goto nla_put_failure;
> >
> >       if (nla_put_u32(skb, TCA_FQ_CODEL_TARGET,
> > -                     codel_time_to_us(q->cparams.target)) ||
> > +                     codel_time_to_us(READ_ONCE(q->cparams.target))) |=
|
> >           nla_put_u32(skb, TCA_FQ_CODEL_LIMIT,
> > -                     sch->limit) ||
> > +                     READ_ONCE(sch->limit)) ||
> >           nla_put_u32(skb, TCA_FQ_CODEL_INTERVAL,
> > -                     codel_time_to_us(q->cparams.interval)) ||
> > +                     codel_time_to_us(READ_ONCE(q->cparams.interval)))=
 ||
> >           nla_put_u32(skb, TCA_FQ_CODEL_ECN,
> > -                     q->cparams.ecn) ||
> > +                     READ_ONCE(q->cparams.ecn)) ||
> >           nla_put_u32(skb, TCA_FQ_CODEL_QUANTUM,
> > -                     q->quantum) ||
> > +                     READ_ONCE(q->quantum)) ||
> >           nla_put_u32(skb, TCA_FQ_CODEL_DROP_BATCH_SIZE,
> > -                     q->drop_batch_size) ||
> > +                     READ_ONCE(q->drop_batch_size)) ||
> >           nla_put_u32(skb, TCA_FQ_CODEL_MEMORY_LIMIT,
> > -                     q->memory_limit) ||
> > +                     READ_ONCE(q->memory_limit)) ||
> >           nla_put_u32(skb, TCA_FQ_CODEL_FLOWS,
> > -                     q->flows_cnt))
> > +                     READ_ONCE(q->flows_cnt)))
>
> Hi Eric,
>
> I think you missed the corresponding update for q->flows_cnt
> in fq_codel_change().

q->flows_cnt is set at init time only, it can not change yet.

Blindly using READ_ONCE() in a dump seems good hygiene,
it is not needed yet, but does no harm.

