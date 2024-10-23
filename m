Return-Path: <netdev+bounces-138080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A4A9ABCE7
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 06:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0271F23A62
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 04:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A91E13CABC;
	Wed, 23 Oct 2024 04:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vqs7U3ZD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E437613C9A4
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 04:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729657223; cv=none; b=ec0DQutumLB6uyRLUAPHqtjGT/yXSkwmu6YobqfXx/GDE2rsrwdXIGjXM9YWrV5+cVNx+guSXPae+gQdAgu4SjFiyO3SZaRaOkPSnFFSVBFPf4x+XQWCGr4FPlzSd2J4KUu8kMbU3PPXz6GUesk/oJs44DgWehlyvyTm6X0cm5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729657223; c=relaxed/simple;
	bh=5AzT1taj0pA4sZfEiuj7XpnlaBsaPYjj+0LPDWH1faw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XqzbxhvhfTH/LMCbGfqzlHWl5jq0mPBDGJ3GjhFIhBeaDjM6uVzU2zAffuljn8Y0II28SMAQpsAtDYbLhge7xXkUOA2nRIvmMs+tlZH3jBp+dmvUdHsfAB7rJKcPDnwMn7heoM70n6UoKeMPP6s4/dgSgven9NOVBjnMdlj9IuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vqs7U3ZD; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so67031185e9.2
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 21:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729657220; x=1730262020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szWPc/FSyoKSqkBK5CzwbagFAjqRg4Nwm6Wd7urBYVg=;
        b=Vqs7U3ZDQFmgzXyLWco/XCZMAsFAzedC1GSc5CuIJ95pkiswywVDIf9aOK57Jg3+ey
         JbbgEHZN3vsCC2IxU9OWS9vV3qMPz7ucwalsXkK/JU1bsdLEoD17bsDn/CV4MhxO3kkI
         uYOZbYs5lHQzzdRMXdyRNk6/eGoWwd0ehqYq+KYaLBVagZbHaRMSbRTpTDgfLh8jPfHE
         gAhr5lLphwmotJX5kNVXRHwfHnJ0PXK3xs905o4GMX+kaiH2puCYiG4jmRIxvD/wneR4
         b2ySvPODRvLTLoJCIbd3U24RsmOYIHxa/m4Bu3ujjzd7leDTX7iX/aywxG4V3Lkj/e66
         58Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729657220; x=1730262020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szWPc/FSyoKSqkBK5CzwbagFAjqRg4Nwm6Wd7urBYVg=;
        b=tGOKLYB6AiftgcEoeHqOMOHSRbG4+iTuIo1IXOKZT5eMbE9wfolDD6OKUwnrBcU48D
         aTvDSBj26e/ooy+G/EpdMHvJU5yRfVRjo/MXYdcPFBCw9kFmETuqWUHaSGMyN0aGNvPn
         qTU1fgt/cpwPTBL1IdWOopXn08ovPcccqf79RcARJKGlbq+T18i9ViQPgrO5zzo12sAM
         HnBi9UH5xxMY+v4uzKsnZwG91EKh8eJHiT8QcqLwGmhEPwvfoal+0Luw1OboWRsVe4fG
         kajgx62QBae1EFlPRE5qhzm98nRn2qAPz8rvYq3xlBwef2ytj+5feLYW3rtlNxjlU7Jt
         aqaw==
X-Forwarded-Encrypted: i=1; AJvYcCWYK9RDe+K0A87PaFEVAScCyUumDBk6c9MavK6mEo1YEYpMO8HADUmPLPtmnXTeKiAuBueAcjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8sGIbcqRGgcyWJgR/lbN92NyCVZK4bhhLo17yXmqfi8NaZf6z
	A1cL8iLqLMjNtdYlNsQKOgfd8fgYV6wrZRbL+sVrugi4KVe+q5GLjMlhlRNLKS/291LoT4yZEpT
	5+x47TcwbT06aKs4J1WMoLNWMsdo=
X-Google-Smtp-Source: AGHT+IEaG/Dug1JIei2NJbyE8nW0LDHTj1b0yH3BdKIBw+1H4tGtCuHGLK1vYINjFHWXdd+e6FxmqdvyvKqCbIG9svg=
X-Received: by 2002:a05:600c:3555:b0:42f:4f6:f8bc with SMTP id
 5b1f17b1804b1-431841441b9mr9745435e9.9.1729657219783; Tue, 22 Oct 2024
 21:20:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023023146.372653-2-shaw.leon@gmail.com> <20241023034916.26795-1-kuniyu@amazon.com>
In-Reply-To: <20241023034916.26795-1-kuniyu@amazon.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Wed, 23 Oct 2024 12:19:43 +0800
Message-ID: <CABAhCOR2v4HQecFvYuocNy3FDLoy9rKc3a0f1gVhg79dy+Ra9Q@mail.gmail.com>
Subject: Re: [PATCH net-next 1/5] rtnetlink: Lookup device in target netns
 when creating link
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	idosch@nvidia.com, kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 11:49=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> > --- a/net/core/rtnetlink.c
> > +++ b/net/core/rtnetlink.c
> > @@ -3733,20 +3733,24 @@ static int __rtnl_newlink(struct sk_buff *skb, =
struct nlmsghdr *nlh,
> >  {
> >       struct nlattr ** const tb =3D tbs->tb;
> >       struct net *net =3D sock_net(skb->sk);
> > +     struct net *device_net;
> >       struct net_device *dev;
> >       struct ifinfomsg *ifm;
> >       bool link_specified;
> >
> > +     /* When creating, lookup for existing device in target net namesp=
ace */
> > +     device_net =3D nlh->nlmsg_flags & NLM_F_CREATE ? tgt_net : net;
>
> Technically, this changes uAPI behaviour.
>
> Let's say a user wants to
>
>   1) move the device X in the current netns to another if exists, otherwi=
se
>   2) create a new device X in the target netns
>
> This can be achieved by setting NLM_F_CREATE and IFLA_NET_NS_PID,
> IFLA_NET_NS_FD, or IFLA_TARGET_NETNSID.
>
> But with this change, the device X in the current netns will not be moved=
,
> and a new device X is created in the target netns.

You're right, what about testing for NLM_F_EXCL aslo?

