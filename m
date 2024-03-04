Return-Path: <netdev+bounces-77228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA94E870BFA
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 21:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 910312827BD
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 20:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D2010A19;
	Mon,  4 Mar 2024 20:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipanda-io.20230601.gappssmtp.com header.i=@sipanda-io.20230601.gappssmtp.com header.b="1m3/TwZq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C163010A01
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 20:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709585923; cv=none; b=MmaCLC3s2S1Gr5ZklKBb8di5RzSveTlApZrDakGV1otyzCUev3aJlW/bOsiQAituKqeGWuNZDdCP2xqsGyBDX/vZNqNHGU7/LXSH9PbeUIplcrHIAvmBICpzqcTRnwkPX5lrR2HoNFWpBnkzAUCDgTN8YJvOawgM0pFF8vkZuvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709585923; c=relaxed/simple;
	bh=oN3bxHpCLqjnWj1KvoILNErA03jUWIpTxqEWwGYmafg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EpnSPCH0+4YvnfVRZ8Qk2eHdW6FB/VisXlbntNRLVPMNda1Z347GS44TWrGH+mf29Ob1uq2fHU7Q7E/YvzBEmnBq483JVoLQD3fBJvfyvddkOAsdyZhCGMMhNAnhgqJxePmYXHayMIO5uM+gl7KEzndfU11HStZBG7BSP7l2Nhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sipanda.io; spf=pass smtp.mailfrom=sipanda.io; dkim=pass (2048-bit key) header.d=sipanda-io.20230601.gappssmtp.com header.i=@sipanda-io.20230601.gappssmtp.com header.b=1m3/TwZq; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sipanda.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipanda.io
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7cedcea89a0so2900036241.1
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 12:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sipanda-io.20230601.gappssmtp.com; s=20230601; t=1709585920; x=1710190720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oN3bxHpCLqjnWj1KvoILNErA03jUWIpTxqEWwGYmafg=;
        b=1m3/TwZqwFYWKWfY/zMkQeWrQpnRLRugdO8XL2OM3ssgA3HyMlZe0NRuaZAz0p8yU7
         uexz8BfXjDu51vDALncnsyYhtQUu+gzyijNE52rFGKTFHgYHw8CFcr3dmHEYgIvW+06b
         ycvBH1xkru3lbIgWR1WHxTWOUo9kGyymdbC6Ip+TE4Tircj1Wun1VryktjJGXUz1OMZm
         YfKIwByRVOsa1dUxE9GhVe2OqmPBIWotG8pJf7DjZ9tFX2MrwcZ9j/QboVzNQ+gF846T
         AhX2GbhMj0e3SUGd3chYXQuaxhMnv1rmothpIaV/aZfVR2fUan1JYZoQuKT6WhI5mu71
         7mjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709585920; x=1710190720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oN3bxHpCLqjnWj1KvoILNErA03jUWIpTxqEWwGYmafg=;
        b=PTMLJszojzE7yGYqQDTMe2MUmPXYeCH4xIRRqg3sGn/XcOrMd5AkyumFo6iQSXGgKt
         7r4C80GeJbRfFOPPMJLT/cIotesctk1IgOToUIiOQ9Wk6FJTIcHt2+ci6iMU9v5V+YSL
         dK5i7DBfaK0ay/oNDIIIyhPxJMwWehz+/XwF94THJpYOhu2tbyEaSJVf/4/4x9BWde0L
         Fwg9rDJ/qifAzZBMlBvTBIulfze8NUtHNWLsk/1k4VKHTBQT1kRsWrbBgnMJ/BEAqTEZ
         N27N7ACe6SDV2rydntFnyrlLEHLzKNwm2D4OMwRZTCMpS68yLYHtx9RMak4MHpY6sqQ1
         txJw==
X-Forwarded-Encrypted: i=1; AJvYcCW/Wp+LMLwNa+R8WaekdTNZF62g3TZzOhwDCoSoFbno2UzrlFfkx9wRhlnyXtp/YZCYRpPhQBak8AO24WoDyZ2SHVE8917z
X-Gm-Message-State: AOJu0YwXFUzwxEE2Q4HWGp/o5WJYbiQML/WybyndZFko606O79LTPrcr
	7CQk6mKyQxv8CpDCgyWAHZgPb2aL08vep5G5kciPfejeEaePX1OxcFIBzzsgVLqClNBWZ3uH4Zh
	WAY5TExvUNZvGSr8518uImZgXQsC2WW3XGTvdVg==
X-Google-Smtp-Source: AGHT+IEHYfpt7bb/NzJhZU0a9zAo3i4cdOiotzYZOUVxXI0QoGGkv9f9t2C7M8wdQZ/tifsphO29at4UW6OEMQizph4=
X-Received: by 2002:a05:6102:320b:b0:472:b533:3046 with SMTP id
 r11-20020a056102320b00b00472b5333046mr3384241vsf.15.1709585920629; Mon, 04
 Mar 2024 12:58:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225165447.156954-1-jhs@mojatatu.com> <b28f2f7900dc7bad129ad67621b2f7746c3b2e18.camel@redhat.com>
 <CO1PR11MB49931E501B20F32681F917CD935F2@CO1PR11MB4993.namprd11.prod.outlook.com>
 <65e106305ad8b_43ad820892@john.notmuch> <CAM0EoM=r1UDnkp-csPdrz6nBt7o3fHUncXKnO7tB_rcZAcbrDg@mail.gmail.com>
 <CAOuuhY8qbsYCjdUYUZv8J3jz8HGXmtxLmTDP6LKgN5uRVZwMnQ@mail.gmail.com>
 <20240301090020.7c9ebc1d@kernel.org> <CAM0EoM=-hzSNxOegHqhAQD7qoAR2CS3Dyh-chRB+H7C7TQzmow@mail.gmail.com>
 <20240301173214.3d95e22b@kernel.org> <CAOuuhY8fnpEEBb8z-1mQmvHtfZQwgQnXk3=op-Xk108Pts8ohA@mail.gmail.com>
 <20240302191530.22353670@kernel.org> <CAOuuhY_senZbdC2cVU9kfDww_bT+a_VkNaDJYRk4_fMbJW17sQ@mail.gmail.com>
 <20240304120747.6f34ab6e@kernel.org>
In-Reply-To: <20240304120747.6f34ab6e@kernel.org>
From: Tom Herbert <tom@sipanda.io>
Date: Mon, 4 Mar 2024 12:58:29 -0800
Message-ID: <CAOuuhY99WQbtFQhaU8HhW4_XaX6nPs2F0XVHqeDLUVqCMfsg8w@mail.gmail.com>
Subject: eBPF to implement core functionility WAS Re: [PATCH net-next v12
 00/15] Introducing P4TC (series 1)
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, John Fastabend <john.fastabend@gmail.com>, 
	"Singhai, Anjali" <anjali.singhai@intel.com>, Paolo Abeni <pabeni@redhat.com>, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>, "Chatterjee, Deb" <deb.chatterjee@intel.com>, 
	"Limaye, Namrata" <namrata.limaye@intel.com>, Marcelo Ricardo Leitner <mleitner@redhat.com>, 
	"Shirshyad, Mahesh" <Mahesh.Shirshyad@amd.com>, "Jain, Vipin" <Vipin.Jain@amd.com>, 
	"Osinski, Tomasz" <tomasz.osinski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Cong Wang <xiyou.wangcong@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Vlad Buslov <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Khalid Manaa <khalidm@nvidia.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Victor Nogueira <victor@mojatatu.com>, 
	"Tammela, Pedro" <pctammela@mojatatu.com>, "Daly, Dan" <dan.daly@intel.com>, 
	Andy Fingerhut <andy.fingerhut@gmail.com>, "Sommers, Chris" <chris.sommers@keysight.com>, 
	Matty Kadosh <mattyk@nvidia.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 12:07=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun, 3 Mar 2024 08:31:11 -0800 Tom Herbert wrote:
> > Even before considering hardware offload, I think this approach
> > addresses a more fundamental problem to make the kernel programmable.
>
> I like some aspects of what you're describing, but my understanding
> is that it'd be a noticeable shift in direction.
> I'm not sure if merging P4TC is the most effective way of taking
> a first step in that direction. (I mean that in the literal sense
> of lack of confidence, not polite way to indicate holding a conviction
> to the contrary.)

Jakub,

My comments were with regards to making the kernel offloadable by
first making it programmable. The P4TC patches are very good for
describing processing that is table driven like filtering or IPtables,
but I was thinking more of kernel datapath processing that isn't table
driven like GSO, GRO, flow dissector, and even up to revisiting TCP
offload.

Basically, I'm proposing that instead of eBPF always being side
functionality, there are cases where it could natively be used to
implement the main functionality of the kernel datapath! It is a
noticeable shift in direction, but I also think it's the logical
outcome of eBPF :-).

Tom

