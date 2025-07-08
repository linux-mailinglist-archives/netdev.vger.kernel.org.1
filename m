Return-Path: <netdev+bounces-204979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B65AFCBC0
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBD887AE4DB
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 13:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E882C15A6;
	Tue,  8 Jul 2025 13:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n5F7Pceu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D50C2DCBF7
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980846; cv=none; b=RfD1OuIsMTeR0eZrZJYvchWt2ZK+2k3DG/cxUdrt2uqsCQFvoJ4UWDR291dyqeCNWu8PMsZfM8Y4XwEvc1GvhhUKoaBrkV0fmrZC8RBYjwAfN9O04aRuBonF1P4IHYAQhSQoPbGffcHEdGaFhwWY4eeIbouzlaNBFUclJMqtr9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980846; c=relaxed/simple;
	bh=VkclARAf7T2zimJiYG2Icq1pOjn1RSfMeWduJRBfvfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K8134Gk3hfLfLCiBQVEy/Z4hoBbKevjPeDX3qG6a9myEbjEhnM/ITuBflMYo+jl47do8j75Q1DvRaWnlf6cv0ddn83XnDPOCsOl5lBRa73GUA74uL3RjB3Y1+xa3LtXcOir/N/c39Kqx1Or5AE9/1dpSC9VwAGYRePKB9BvPSFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n5F7Pceu; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a752944794so47204811cf.3
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 06:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751980844; x=1752585644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjrqhHztRTTGo7VijNsPBimusRotp9VgBK5Mw23Me10=;
        b=n5F7PceuLFwNlt1qwvBTmDRtRnd+T+Kebld8oTKozzaUeO5qYobRfI9pXRNDGSTuHz
         rs1dx00R8bSz/vYNgkWiYWzKryDtvlE4Szbeq6X41U3nz0M4WmplF8AOHyOo37b5Z0Zj
         99JdyeHCfRNQUeiM5F+mIZGc9eKjydIYfw4K9DTcYWSPzMO/+nEb6nhEZZsjm/cFef/x
         WO4x2DQDj1NqeYg7ZjWE60jiE6DEcH3eRPoEgeI/KdXX4QZmj2Es3N3ftq8K9D6o3nWv
         dikX1HwWObaY0NLREqU4rQadhhzDoRQq7CfXEXrrfYeDja6aEJe6gt3EVl34IXzyHSXB
         3qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751980844; x=1752585644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjrqhHztRTTGo7VijNsPBimusRotp9VgBK5Mw23Me10=;
        b=Tt3Kk3x49g6cwhnqusO+1X/xDwAL/6IY5KIGYmL0FLeyelvgulBk0Foa+OBWgRE05m
         rvISWTga9uYu0kkiQuXjILMJgFOBdZtkedtExKvsO475XJD2iukyiUd2wvj4QhSKapB+
         2WkLmtqvnaIqddKPYgIVmwkNlR3MlVVJiuBkN8dCyUK5c2sTMfe2eH9A1jCbAFKtfjlo
         JAGdt+BYT61FI9XMB1UA3g4i1ynadlPx+Nnc1lVGx6D++hYVvzhd/pSYj9guC5NiVkNj
         qOAaSQcpcchVE9ZRJrMO43aAbtsl8QAxdIW8Sm0t2rYR57e6f3zkHyVgVHStM66qURuT
         of3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWsKEATi2sZhGJW0cQ5pcQuJdQKwJxp5fkxAuMeBd7TrOp5iqI/Z1A+pQAhHWf6MhCVOumRvUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ76AgGmNYH8WeoKV0eXZ7bEZHOOVW6rmT+jAFCmlN3zlbkUpO
	F9x9gshFjL5a+K2jvsL0gWqgQr8nnwm9OkuyOgNeNjHxZHs8F4hMXB+JFmHIDE9LS1xyfBaFG3Y
	6m0fFsnCppVczN2YVeI14YwU0cxE4a184qtGa8cfC
X-Gm-Gg: ASbGncuF0FY8fzYwOBxM2oW9y8/tnM6KceLBxkU7O0rX/JbsojJmR0W55oypHZNZ6Rb
	2GgGckI7TxsXyIqNrWsgODJc0h18xQqWGYmVc+sUIc3QflgsP9COSnLFq5as00tiGXJz+2fIL9q
	Eu87m12DCay0XW7YeHkUc6yZHTTH3tW3+cP1L6dy1gEEo=
X-Google-Smtp-Source: AGHT+IFPpsSYDMgE9HHJQc+OGIPJKjBjPRaVoFB20jVpI1UcDAvatRZ4EMCt0d8WqfG21TsAP03Zelcbr8ISmMSDKpc=
X-Received: by 2002:a05:622a:112:b0:4a7:71d5:c975 with SMTP id
 d75a77b69052e-4a9cca8ac6amr34245811cf.10.1751980843545; Tue, 08 Jul 2025
 06:20:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707130110.619822-1-edumazet@google.com> <20250707130110.619822-9-edumazet@google.com>
 <20250708125411.GG452973@horms.kernel.org>
In-Reply-To: <20250708125411.GG452973@horms.kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 8 Jul 2025 06:20:32 -0700
X-Gm-Features: Ac12FXwa3ouxALK3CxoiRyNWWp18-VlrBRSNzcFOnwV8uKr6N5Oc0ZrqXIppgQg
Message-ID: <CANn89iKFibV=AXC+z8f1xvvJBJA9ydkxczw-0Ged2RTQ+O=cqA@mail.gmail.com>
Subject: Re: [PATCH net-next 08/11] net_sched: act_nat: use RCU in tcf_nat_dump()
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 5:54=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Mon, Jul 07, 2025 at 01:01:07PM +0000, Eric Dumazet wrote:
> > Also storing tcf_action into struct tcf_nat_params
> > makes sure there is no discrepancy in tcf_nat_act().
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> ...

> > @@ -294,12 +293,12 @@ static int tcf_nat_dump(struct sk_buff *skb, stru=
ct tc_action *a,
> >       tcf_tm_dump(&t, &p->tcf_tm);
> >       if (nla_put_64bit(skb, TCA_NAT_TM, sizeof(t), &t, TCA_NAT_PAD))
> >               goto nla_put_failure;
> > -     spin_unlock_bh(&p->tcf_lock);
> > +     rcu_read_lock();
>

Absolutely, thank you for catching this.

