Return-Path: <netdev+bounces-64020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BAA830B0D
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 17:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A21912887CE
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 16:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B902232D;
	Wed, 17 Jan 2024 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V0onXuhv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CDC224C2
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 16:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508949; cv=none; b=nM2Nb2hsr6LnZypFzPOF7Xw0nIUEakZm9qI39UeSkogB7rgIfbEbIVaktTUKG6r7CxTuXTvSAKNmeICsGgkIzKOsXyqWJCOp8Ll5KSBo26BxnC0LWblutUkno8UL2QApg11fbmaGkKyQ4szN8hvSKzztP30/PltrNX8OwljfweY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508949; c=relaxed/simple;
	bh=b07Jp3UHXSYA14cQsXEAajOG7C6xS0I5AL/BU1uuAHw=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=kjMAVU5PdWSfAC31lrFBUA66fi1a0pcXoOC7rKedQ8BfvWjc8nAHcqqlDQV5UFPXiiMpM3wULFKxLZM+aJrpjdZuYnCnR5BVNUKKilNbac6wNxiygTDLfZpakyoPxaZbD4l6zCROKYu5/lzxm/Uba8bidq3ZWxAPzbd3CSF12ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V0onXuhv; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50eaf2f00d1so2958e87.1
        for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 08:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705508946; x=1706113746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayzMxEKWODrb0jPlytcX75yGqSqm7F855h2iNMiZuno=;
        b=V0onXuhvGa6bI53OoV05p7pSgqDOyd122jNIxdeg8kxS4yQ6kkLURZxAc+AaFfOalV
         oPL4FMqiwED5nA433SHNG/sn78FJThwZy35D1yJyd0zCMbX8g9P3X3JgHV47xNlk5glc
         tQBH3uZNxiN7c/JLA4n5Eyy4BO1iHBhf8HnkrhFyevLiitoxwsRtUpZk47b+8tH/YEl/
         ppo1PJJNDfcWwE5jeuTemZ/IZtF2n9ti3mnsdj2p8l3tk1ZPLmt43KkNNbOIwkuVBgiQ
         EUnMKPUGKW7en9pHFy3zEZ2KfjpL6L8U3Kvi+goEoz7rWfjpUIh7CPFr5GlJGL6myI24
         Trog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705508946; x=1706113746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayzMxEKWODrb0jPlytcX75yGqSqm7F855h2iNMiZuno=;
        b=DnZdSWjxTKIST20WW6VlNNNJT4F3lETGIAX809O1SEghGcRxRrYOhnskrRIIE3WNvK
         sVxAfILLNN02ltojpRim0H3oNjNfAA+qeNbXOTmxyMp9j2uc04zsNPsSR5Ob7mvIkuv/
         Trm4Zd6fHdGqOYA2rb1REv+YyliHMurAy5i0H7tgSmPa9IxHuEyWTzZkjma1w4cGth8E
         m7rykNtNBe56tk+aMMzKZgljD9IsxpjIpfVNT88ZymBLLKGeaHR5XiarzPoFHI6qjab9
         QUactcQDwnOcScSZVlG6X8epNcEQXmh+fGYH0UYmuJjzlbX2IqUblRnITrPkBMzZBxgL
         /XRg==
X-Gm-Message-State: AOJu0YzH++KGuAeaGf+5M423QXbq6NoMk5xWke921nIZoCpaJhzMOd+Y
	AbYeWwYaPSANpiQEJdO8HCcilrYLLxO4L1yMM/VALGYXA1DboiHsj0rG7z+6PREDwNryDDI5q7K
	WI3LwbvVnioKjVkQqGkH3pSlxf5kWbQnSHNmL
X-Google-Smtp-Source: AGHT+IH2SdaT3Qdcf+JM5rk8Wvy8xai7iQYR0tcoznElpDeAFxn63i0fLT69MgXZA3envFVHYw0M7Sw4RT0JZM/GLQ0=
X-Received: by 2002:a05:6512:281f:b0:50e:6186:3c23 with SMTP id
 cf31-20020a056512281f00b0050e61863c23mr91658lfb.7.1705508945668; Wed, 17 Jan
 2024 08:29:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117160030.140264-1-pablo@netfilter.org> <20240117160030.140264-15-pablo@netfilter.org>
 <CANn89i+jS11sC6cXXFA+_ZVr9Oy6Hn1e3_5P_d4kSR2fWtisBA@mail.gmail.com> <54f00e7c-8628-1705-8600-e9ad3a0dc677@netfilter.org>
In-Reply-To: <54f00e7c-8628-1705-8600-e9ad3a0dc677@netfilter.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Jan 2024 17:28:54 +0100
Message-ID: <CANn89iK_oa5CzeJVbiNSmPYZ6K+4_2m9nLqtSdwNAc9BtcZNew@mail.gmail.com>
Subject: Re: [PATCH net 14/14] netfilter: ipset: fix performance regression in
 swap operation
To: Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, netfilter-devel@vger.kernel.org, 
	davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, fw@strlen.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 5:23=E2=80=AFPM Jozsef Kadlecsik <kadlec@netfilter.=
org> wrote:
>
> Hi,
>
> On Wed, 17 Jan 2024, Eric Dumazet wrote:
>
> > On Wed, Jan 17, 2024 at 5:00=E2=80=AFPM Pablo Neira Ayuso <pablo@netfil=
ter.org> wrote:
> > >
> > > From: Jozsef Kadlecsik <kadlec@netfilter.org>
> > >
> > > The patch "netfilter: ipset: fix race condition between swap/destroy
> > > and kernel side add/del/test", commit 28628fa9 fixes a race condition=
.
> > > But the synchronize_rcu() added to the swap function unnecessarily sl=
ows
> > > it down: it can safely be moved to destroy and use call_rcu() instead=
.
> > > Thus we can get back the same performance and preventing the race con=
dition
> > > at the same time.
> >
> > ...
> >
> > >
> > > @@ -2357,6 +2369,9 @@ ip_set_net_exit(struct net *net)
> > >
> > >         inst->is_deleted =3D true; /* flag for ip_set_nfnl_put */
> > >
> > > +       /* Wait for call_rcu() in destroy */
> > > +       rcu_barrier();
> > > +
> > >         nfnl_lock(NFNL_SUBSYS_IPSET);
> > >         for (i =3D 0; i < inst->ip_set_max; i++) {
> > >                 set =3D ip_set(inst, i);
> > > --
> > > 2.30.2
> > >
> >
> > If I am reading this right, time for netns dismantles will increase,
> > even for netns not using ipset
> >
> > If there is no other option, please convert "struct pernet_operations
> > ip_set_net_ops".exit to an exit_batch() handler,
> > to at least have a factorized  rcu_barrier();
>
> You are right, the call to rcu_barrier() can safely be moved to
> ip_set_fini(). I'm going to prepare a new version of the patch.
>
> Thanks for catching it.

I do not want to hold the series, your fix can be built as another
patch on top of this one.

Thanks.

