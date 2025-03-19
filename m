Return-Path: <netdev+bounces-176037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADA3A686C5
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 09:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439C719C3035
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 08:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526CB24E4C6;
	Wed, 19 Mar 2025 08:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qZ1otxzq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13F415A85A
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 08:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742372889; cv=none; b=mZFDTqdpWZoM3Z4whRMHP3/DYdz50+UUKRZWEvObT+tKhGmTwFAJZSPR/eiePSKRJ//XQt5SPK63CkP//9qotNVRaXHQsaDxVp02LZp8NrwoW6H7Z/uHhhAX1lAtO/a2zM8nzeb9nG4hWEer5KI9khhIAX5fZK14S1YIIsCkLts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742372889; c=relaxed/simple;
	bh=Y1oIK+mTm7ahiNzsC/RLo3OJnI6i1CgDpiEcphg7cW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NmH2xEI+Gw/zjVCt3ZD6Hy5AI3NYsuRiDpNcW7X9/oBKfPjbe35LbrlTe+SOyApHifrj1GwlElpxSNcyjwv/uzsCaVz8tgIQdkmP9doy8ivipywIgSUbzrEAMeitSG3lpqlQH8Xvd79EN0rZdpWgDCAtuaXUp0d95FfDTz6r93Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qZ1otxzq; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4769b16d4fbso35475871cf.2
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 01:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742372886; x=1742977686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkmpOiSrp77sQ2Qv2r1nnrrLIt5t0t8YWBnoFSxp6eU=;
        b=qZ1otxzqAhH96Tfe2s9MAU0TWm9RqHxAOEPsWsjH8P1Ry9uXPP3AjbUEg7yGchg4fi
         jQHCIxVhuZFl+BfFqliSvKXZ0+UsMbYGY+fq/qPictQzIwUbQ71tvSIRt66FE35yFr9t
         l0c8BvjjYm2BQDQWPDkPi8uLFRXcAfVY5/vl/50sYTcp6HWZPNe8+ZKYcd6gMHJdshnW
         3FDJWe8ngs5Kk3dG/Ef+FIZ2JV7LkQNyC9VNIFyCogeburE0i5rPkvh39ARpx6gwsWus
         Ko9o8RXSbZWEhRmVwhmWCplZYl3eHoZldeIJQQy9yYbbTex1fzxORQ7Ssk9IR1e8Anvg
         dM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742372886; x=1742977686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkmpOiSrp77sQ2Qv2r1nnrrLIt5t0t8YWBnoFSxp6eU=;
        b=wH04IfI4edn3gK4N7cW/xYL3jbsUBSWRYtb/wobaj2zqlKe19cHJ763exdWHK8PNpR
         yAmC9joC6QS7S8Jq+CcT86hmmcXyscncc6mAsOtdbrjO4fNzlsUv71F7mo4rnB+YjAUE
         ndXzQyyfxORMlbwvms4oIHHOh3yao49tTqAzwoVoYm5wpF02mpd59rL84UXQQhaUBUpu
         a2kw1MiAMqtixLOAXNlMZuUbWrJb7j8OUlruYc1c2qy3Gu8EIZ3QkVqUMXhNUXN+/z9Y
         c5HzKDpz5VgkylshENm8mJ/pjz1j5Df6GmpE+hrvT5RohvmdQwBlRv4dUPuT4No/jQ0M
         /r0Q==
X-Gm-Message-State: AOJu0YzSs0z26mbPEdvBpjFapU1MXGDgEihIC8aogmQ26Hvr9haQQcWO
	UsOODjo1gEV95Cx7P1NHH2UxZWCzBLTlx9/3Lr5Hh+midkJR7m/UZMzivV1H4M2umabVnXP+q1w
	x8L54IxOwa1C5ASRFuvq3KAIETKvMwn45Vj6o
X-Gm-Gg: ASbGnctYUETYstzKCRUT6192osCrM8os8GJVWHoggwWC5fJdOQxwrYTWdaiL3srIDQA
	26dvwdlvGXjnMkr60O2LdudY9auAhL97r34w3WXgL1Lpuy2+Cge6CG62RuAS1e5fJy9u6ezEdUn
	zle7Ur/AebKQqySuytLvr+SDy9LSw=
X-Google-Smtp-Source: AGHT+IGTims1UZXB5aldTS4W9H8cCYtlaaFLKKZw0vVSLTftjeIUbYWwN2kQYDmappcrVdLBncZly08ciU4ScP72vrc=
X-Received: by 2002:a05:622a:248e:b0:476:ac73:c3f3 with SMTP id
 d75a77b69052e-477082c1083mr39156341cf.1.1742372886320; Wed, 19 Mar 2025
 01:28:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2a1893e924bd34f4f5b6124b568d1cdfc15573d5.1742320185.git.pabeni@redhat.com>
 <CANn89iLst-RHUmidAqHxxQAPrH8bJYT+WiFxPU0THJyWWH0ngQ@mail.gmail.com> <6bf46527-e4d9-41d0-9213-94af1394add9@redhat.com>
In-Reply-To: <6bf46527-e4d9-41d0-9213-94af1394add9@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 19 Mar 2025 09:27:55 +0100
X-Gm-Features: AQ5f1JoGl-Ul8qABeoFvBsLI6THQB6gLTaKrCIfc-l5Dj6yFcpmv-ff0ugv2uSQ
Message-ID: <CANn89iJfnuVx-sJdb70KwFgArz5mdC4jnkA6e7PADDbh2KxvGQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: introduce per netns packet chains
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Sabrina Dubroca <sd@queasysnail.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 9:39=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> on 3/18/25 7:55 PM, Eric Dumazet wrote:
> > On Tue, Mar 18, 2025 at 7:03=E2=80=AFPM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >> @@ -2529,7 +2546,7 @@ void dev_queue_xmit_nit(struct sk_buff *skb, str=
uct net_device *dev)
> >>                 pt_prev =3D ptype;
> >>         }
> >>
> >> -       if (ptype_list =3D=3D &net_hotdata.ptype_all) {
> >> +       if (ptype_list =3D=3D &dev_net_rcu(dev)->ptype_all) {
> >
> > Using the following should be faster, generated code will be shorter.
>
> Right. I can do that in the next revision.
>
> >> @@ -5830,6 +5848,14 @@ static int __netif_receive_skb_core(struct sk_b=
uff **pskb, bool pfmemalloc,
> >>                 deliver_ptype_list_skb(skb, &pt_prev, orig_dev, type,
> >>                                        &ptype_base[ntohs(type) &
> >>                                                    PTYPE_HASH_MASK]);
> >> +
> >> +               /* The only per net ptype user - packet socket - match=
es
> >> +                * the target netns vs dev_net(skb->dev); we need to
> >> +                * process only such netns even when orig_dev lays in =
a
> >> +                * different one.
> >> +                */
> >> +               deliver_ptype_list_skb(skb, &pt_prev, orig_dev, type,
> >> +                                      &dev_net_rcu(skb->dev)->ptype_s=
pecific);
> >
> > I am banging my head here.  I probably need some sleep :)
>
> Let me rephrase. I think `skb->dev` and `orig_dev` potentially can be
> located in different netns; prior to this patch all the netns
> ptype_specific ptype for a given type were placed in the same ptype_base
> slot, and traversed by the first deliver_ptype_list_skb() call.
>
> Now we don't need to traverse the lists on both netns, as the ptype rcv
> function (packet_rcv) will ignore packets with dev_net(skb->dev) !=3D
> ptype->pf_packet_net.
>
> Does the above help?

Ah, I get it now, thanks.

