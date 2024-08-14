Return-Path: <netdev+bounces-118335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 216429514C5
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 08:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B76981F24AC6
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 06:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C853C74424;
	Wed, 14 Aug 2024 06:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="modYS0Wt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029088488
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 06:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723617781; cv=none; b=a0REHLNQ+S4EKrHeUQgBonDhMilwjcbQGftvjvl0o7dNCCCLfdjLbFK8yNDd4B9Fugr568iYtEvvxL7/51keL7kIKmMMeeB3QnTDzoefbaaCv3aNKFn9vCTfXaomtrnBlnavXAaaWVlPxXumR54ffL48FURNStXSY6GzAVDsDnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723617781; c=relaxed/simple;
	bh=jZ2PmbZ8xodunhbCZWMEKC3g1etMNx66h/wxu/zzeEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6cgfGdoA6gG9i9nUCHj6KuG6pp7Nco4tzUthmd+Aq9u0Yq9JN6VEmjM4VwQWFs6LROfeKpQPVi5ZDCCjmem5qeXO8NA38MnC9k6cP+aQl+2gZxIMxNQ+qUi9Kfl7HyB3yfZCV1UC2J4zmrrzwSzJhnroXMNzSnAihk9eqbNEIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=modYS0Wt; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5b391c8abd7so7482665a12.2
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 23:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723617777; x=1724222577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZ2PmbZ8xodunhbCZWMEKC3g1etMNx66h/wxu/zzeEk=;
        b=modYS0WtAiCtmFJEBptVa9H+efkd8vSZ5c6u5XsDq3s28WNz6O4JIYNjIKOuPul4ie
         eRsHL+T+qUXrYUcFdjJBheovwYgPzxzGPGik9Q2yiBPYgxyD3Fmobc8lKaTgaXsQEvIP
         xmwNp/CNYB+KLQVKSsLkGEj7VcJEI8bYQzUP4cDq++Z1U7eUiWvjuSxJAYPX8eGFhdwz
         K6rFun1BFBwX4ZRaB3ONuPvmd7PdQTuxn6wDlVj2nykunsvRaqdvbkSJVeZ75habw/Lp
         fMnaKK4gAbF1g1NnAXCe6EJBwBFwmVsG7jZlixBZ9OrW6ZC259lG+PzWzna2BEbiYeBa
         /dFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723617777; x=1724222577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZ2PmbZ8xodunhbCZWMEKC3g1etMNx66h/wxu/zzeEk=;
        b=rifnM8Ba/+HkTq8+24m58+4flWUrBYryS2itvQv0CW6O32RdHMKBGWUM9jEnyb5JQJ
         f7nndl/1F0vydfUXVJmYlJH78zwOE9gAQuLH4cd+q0ssXcR45IdMlbDMBtyojKLrq7GU
         DTSyr1RXuNNZfrAApjGDXEV2BXzICpzT7RbJ9eQvrtt7KmIt72RluZNTz427r6q4oRQD
         gVF2EOULrFBzvNRpotUVrfxb6rtXULouv/mxIv71INKYzHNYHEsMPSI9vG5iMkcvz2k6
         cDOebuUfRJlZTRCO8CpzoWbgj0eqeM7xz04puBr+fyweyqJyrN4jmHOrlQxPiPilQ+qZ
         9zLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVap1wplSenkHWvRkdnEEb2jscckl3zuQ+TZy4ZQftFfPXTtsIxG2CVVSJyf+HzuU8k/SaJLAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0gcX3vegBXY31cIcybFUDXO0WXiqBnV8xsKL4Bju33GFuSMf7
	4yMXKA4AnQUSt2zcLuLt0QQRzwRtlhjBiX+t5SOLSOZQQtIClUWcE8wtIAF6wchil554stHuBZj
	p9J77/LzpdlYP0Hl9hZ32snIPwGA=
X-Google-Smtp-Source: AGHT+IGekfdZ7lJr187IMt6EVQ3l+DylqbSOCZ5tS4Yp+XdwoUPNLzKAaUwiMFVQ9WeNtHy5uYiKmG0OzFCLSAaESNs=
X-Received: by 2002:a17:907:dab:b0:a7a:b9dd:775a with SMTP id
 a640c23a62f3a-a8367058fbdmr102141466b.67.1723617777095; Tue, 13 Aug 2024
 23:42:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808070428.13643-1-djduanjiong@gmail.com> <87v80bpdv9.fsf@toke.dk>
 <CALttK1RsDvuhdroqo_eaJevARhekYLKnuk9t8TkM5Tg+iWfvDQ@mail.gmail.com>
 <87mslnpb5r.fsf@toke.dk> <00f872ac-4f59-4857-9c50-2d87ed860d4f@Spark>
 <87h6bvp5ha.fsf@toke.dk> <66b51e9aebd07_39ab9f294e6@willemb.c.googlers.com.notmuch>
 <87seveownu.fsf@toke.dk> <CALttK1Qe-25JNwOmrhuVv3bbEZ=7-SNJgq_X+gB9e4BfzLLnXA@mail.gmail.com>
 <87frr8wt03.fsf@toke.dk>
In-Reply-To: <87frr8wt03.fsf@toke.dk>
From: Duan Jiong <djduanjiong@gmail.com>
Date: Wed, 14 Aug 2024 14:42:45 +0800
Message-ID: <CALttK1TWBeZWDwHoW9q6qkT6=XT4EmZM1ZbK3KtKSXR-ZcAFeA@mail.gmail.com>
Subject: Re: [PATCH v3] veth: Drop MTU check when forwarding packets
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 7:40=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@kernel.org> wrote:
>
> Duan Jiong <djduanjiong@gmail.com> writes:
>
> >> >
> >
> > vm1(mtu 1600)---ovs---ipsec vpn1(mtu 1500)---ipsec vpn2(mtu
> > 1500)---ovs---vm2(mtu 1600)
>
> Where's the veth device in this setup?
>

The veth device is used for ipsec vpn containers to connect to ovs, and
traffic before and after esp encapsulation goes to this NIC.


> > My scenario is that two vms are communicating via ipsec vpn gateway,
> > the two vpn gateways are interconnected via public network, the vpn
> > gateway has only one NIC, single arm mode. vpn gateway mtu will be
> > 1500 in general, but the packets sent by the vm's to the vpn gateway
> > may be more than 1500, and at this time, if implemented according to
> > the existing veth driver, the packets sent by the vm's will be
> > discarded. If allowed to receive large packets, the vpn gateway can
> > actually accept large packets then esp encapsulate them and then
> > fragment so that in the end it doesn't affect the connectivity of the
> > network.
>
> I'm not sure I quite get the setup; it sounds like you want a subset of
> the traffic to adhere to one MTU, and another subset to adhere to a
> different MTU, on the same interface? Could you not divide the traffic
> over two different interfaces (with different MTUs) instead?
>

This is indeed a viable option, but it's not easy to change our own
implementation right now, so we're just seeing if it's feasible to skip
the veth mtu check.


> >> > Agreed that it has a risk, so some justification is in order. Simila=
r
> >> > to how commit 5f7d57280c19 (" bpf: Drop MTU check when doing TC-BPF
> >> > redirect to ingress") addressed a specific need.
> >>
> >> Exactly :)
> >>
> >> And cf the above, using netkit may be an alternative that doesn't carr=
y
> >> this risk (assuming that's compatible with the use case).
> >>
> >> -Toke
> >
> >
> > I can see how there could be a potential risk here, can we consider
> > adding a switchable option to control this behavior?
>
> Hmm, a toggle has its own cost in terms of complexity and overhead. Plus
> it's adding new UAPI. It may be that this is the least bad option in the
> end, but before going that route we should be very sure that there's not
> another way to solve your problem (cf the above).
>
> This has been discussed before, BTW, most recently five-and-some
> years ago:
>
> https://patchwork.ozlabs.org/project/netdev/patch/CAMJ5cBHZ4DqjE6Md-0apA8=
aaLLk9Hpiypfooo7ud-p9XyFyeng@mail.gmail.com/
>
> -Toke

