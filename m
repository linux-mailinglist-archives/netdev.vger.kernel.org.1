Return-Path: <netdev+bounces-247899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C72D0057B
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 23:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A519D3008FA0
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 22:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71653296BB6;
	Wed,  7 Jan 2026 22:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjPI3GVO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B827B29D293
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 22:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767825475; cv=none; b=c6OzmaTuWbAMzQlS7xNJlXK8+FsYQknaoowJTLNPE00NpAk77EP1navA56mb1tYxK+NN/AouViv+QOGrJOl4lkYER1UHV5L4d8ppenZwyKhW9CUchuSURYDaAwpVC2TmCiqXnoRWWwJgLMYuRAyoLX9KROJL3CK+/H8hIWg0IFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767825475; c=relaxed/simple;
	bh=3sYY1Qc99ANJJ3YHG4zUW4xeZ/NUoAuHhB0LQiDLB+o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hvWH3vBw7XaY9FimtwWnq8+99xx1diqNmrdi9cqPSam3mMz+rFf2c95vhZrehhetIh7YheFFjNZAImYMoMef1uX/wDi6CFSPAO+ROSs9s/b8AF6hEomBOGM7knji6ZK5IoxuBfCYpG4zlpfH1rieSTQ9908xaTJ/sJVh+nliaQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjPI3GVO; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64661975669so2758874d50.3
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 14:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767825473; x=1768430273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRBooldm41LgTFya8OY2OmgrhoB+H6pwWMX8YIfPpgc=;
        b=LjPI3GVORmk8ypUUIx1xghnyZ6IJ2/7mUaCAYX9Af/FRijV8SUeHjAPNDCdii7hO7e
         jZEVr6THrNb0xvwfqqUzEtcsD+9jjmJdAv51JSUq3SreGb9py66hCQEUmdSbnGk6a5gF
         z/dxvkicbOHecx4MkYWFtpmeUfH4wDQJwPKCihDBMOtNLJsGG2bV56etNXQ5Wp9xNL+M
         kzulICo+BhrRxnS60KjSivHOSspCEvC6beYehJN5jFbhKSQtquy2rEuETF5OzfFNl4N3
         1DDs/SsWZwpSt647u5/2cBfua+vPYvT//kk3xeOJDeGrkzc0RLe66zRWN26DFVuzsG0e
         eC2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767825473; x=1768430273;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rRBooldm41LgTFya8OY2OmgrhoB+H6pwWMX8YIfPpgc=;
        b=WYcywufbnxLEA4YPwTfxilQM4hb1NAcUCjg9+IJMDYE8HaZKgodlS3Y4E7HQTeJjfV
         3czjC5ve9nP+woNdc30QyYjojSKjxbU+dAXtjWVnpca4QnTSFNKgyUYDz9+O7Wqzz9ea
         eVcAs/BRmLIQKFNK4eFAaQ4xWRbsjIR3JNz1hoPZQOTz4Qa7cMsL1AR94rc3BpdpvhfV
         28WZ7Y9/lEXeh6kU+taTtTx81ORG/M7OdUiVtD4nMNEGjzTLpbTYgg4GefjTkS7r1cAs
         k/NA5sCF09D5k+fcJslXAV3TkiLePUh0Vcuvo3wzbilxZy2GJ4bTlNCFDfoRFwfBMZi7
         Ht0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHrKCVDCPcMb8ynWykLevUEuw88UGhAWSYpZ2QsKsvooN7Aaxq6dz/RfzMS/glLvyPk824NV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7zsiEqb3z6tnbRMu+dBCrEWWBX7D1SXcE95zuWDGpcpb3xwpi
	UDUgWij8CrYZ+5HGdZQx7DpLbJooF70nXmV5LR76ST5Ksm44RgbpGkM9
X-Gm-Gg: AY/fxX4ZcfJVfY8HuWEJyP+fM/N8WM72ayh2Su840objyQY7DMjouvdvWwAGI0e3Ghr
	miV6FqmlnM2TvDGwhZuHjX0WI2UNymudCMvsg7bbCWswJhnPTiPjXp4vP0oD68SZh/WORl4Qxat
	G05F78ofMTw7FPVTS9X3xV809sSTUYY32R2enRM8w+VnQH0ejxlqlyEcm+gSYQNHzbWQjcDZ+c2
	42lr6VMiKrN490qOUhqRDUUAizYs2z8WiMOgF7Bybms7bTW1qtOo6u6E1qwpD0zOEzPr2snuNz/
	uVypJN1zIY3Ao8vavJaZ4ykfmCV5P758d7Z3LgA+WhzISdM4/fuo2IHJShr2JGF0vWrJjUBZ/jX
	gV8R4erEu6u2DUMQvedtDkL/tgh+SCszr/iS1c3GsY+jd2sq7BtFPWlwHDW+OpLdKq5z+KXhomY
	Vg9S33TtD7sbIVwlQXxcFg8w4tJ3kLWgx5GF4hmw+VARK+xj/Qafd9bbbEvV6O7scCBuyKJw==
X-Google-Smtp-Source: AGHT+IF/8f9U9sqa7mM9SBQb1x2OJFmJf1sey+yIn+cZklw5qMjQJkjZ/u8ty8LccSyX86FFECR19A==
X-Received: by 2002:a05:690e:1481:b0:645:556b:62a4 with SMTP id 956f58d0204a3-64716b5fd1cmr3379646d50.7.1767825472692;
        Wed, 07 Jan 2026 14:37:52 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6470d8b241csm2582233d50.19.2026.01.07.14.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 14:37:51 -0800 (PST)
Date: Wed, 07 Jan 2026 17:37:51 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Mahdi Faramarzpour <mahdifrmx@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 dsahern@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org
Message-ID: <willemdebruijn.kernel.22b9558f6c8d6@gmail.com>
In-Reply-To: <CA+KdSGOW0+V9KTA6CebvJ5dSqBxCV5XFAJshJByQ36=GWX6yiQ@mail.gmail.com>
References: <20260105114732.140719-1-mahdifrmx@gmail.com>
 <20260105175406.3bd4f862@kernel.org>
 <CA+KdSGN4uLo3kp1kN0TPCUt-Ak59k_Hr0w3tNtE106ybUFi2-Q@mail.gmail.com>
 <willemdebruijn.kernel.36ecbd32a1f0d@gmail.com>
 <CA+KdSGOzzb=vMWh6UG-OFSQgEapS4Ckwf5K8hwYy8hz4N9RVMg@mail.gmail.com>
 <willemdebruijn.kernel.21c4d3b7b8f9d@gmail.com>
 <CA+KdSGOW0+V9KTA6CebvJ5dSqBxCV5XFAJshJByQ36=GWX6yiQ@mail.gmail.com>
Subject: Re: [PATCH net-next] udp: add drop count for packets in
 udp_prod_queue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mahdi Faramarzpour wrote:
> On Wed, Jan 7, 2026 at 6:39=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Mahdi Faramarzpour wrote:
> > > On Tue, Jan 6, 2026 at 10:52=E2=80=AFPM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Mahdi Faramarzpour wrote:
> > > > > On Tue, Jan 6, 2026 at 5:24=E2=80=AFAM Jakub Kicinski <kuba@ker=
nel.org> wrote:
> > > > > >
> > > > > > On Mon,  5 Jan 2026 15:17:32 +0330 Mahdi Faramarzpour wrote:
> > > > > > > This commit adds SNMP drop count increment for the packets =
in
> > > > > > > per NUMA queues which were introduced in commit b650bf0977d=
3
> > > > > > > ("udp: remove busylock and add per NUMA queues").
> > > >
> > > > Can you give some rationale why the existing counters are insuffi=
cient
> > > > and why you chose to change then number of counters you suggest
> > > > between revisions of your patch?
> > > >
> > > The difference between revisions is due to me realizing that the on=
ly error the
> > > udp_rmem_schedule returns is ENOBUFS, which is mapped to UDP_MIB_ME=
MERRORS
> > > (refer to function __udp_queue_rcv_skb), and thus UDP_MIB_RCVBUFERR=
ORS
> > > need not increase.
> >
> > I see. Please make such a note in the revision changelog. See also
> >
> > https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html=
#changes-requested
> >
> Ok.
> =

> > > > This code adds some cost to the hot path. The blamed commit added=

> > > > drop counters, most likely weighing the value of counters against=

> > > > their cost. I don't immediately see reason to revisit that.
> > > >
> > > AFAIU the drop_counter is per socket, while the counters added in t=
his
> > > patch correspond
> > > to /proc/net/{snmp,snmp6} pseudofiles. This patch implements the to=
do
> > > comment added in
> > > the blamed commit.
> >
> > Ah indeed.
> >
> > The entire logic can be inside the unlikely(to_drop) branch right?
> > No need to initialize the counters in the hot path, or do the
> > skb->protocol earlier?
> >
> Right.
> =

> > The previous busylock approach could also drop packets at this stage
> > (goto uncharge_drop), and the skb is also dropped if exceeding rcvbuf=
.
> > Neither of those conditions update SNMP stats. I'd like to understand=

> > what makes this case different.
> >
> The difference comes from the intermediate udp_prod_queue which contain=
s
> packets from calls to __udp_enqueue_schedule_skb that reached this bran=
ch:
> =

>     if (!llist_add(&skb->ll_node, &udp_prod_queue->ll_root))
>         return 0;
> =

> these packets might be dropped in batch later by the call that reaches =
the
> unlikely(to_drop) branch, and thus SNMP stats must increase. Note that =
such
> packets are only dropped due to the ENOBUFS returned from udp_rmem_sche=
dule.

Understood.

The difference with the other drops is that those are on the skb that
is being passed to __udp_enqueue_schedule_skb, and are accounted to
the SNMP stats in the caller when __udp_enqueue_schedule_skb returns
with an error.

The skbs queued here cannot be accounted that way, so require
additional separate SNMP adds.

> > > > > >
> > > > > > You must not submit more than one version of a patch within a=
 24h
> > > > > > period.
> > > > > Hi Jakub and sorry for the noise, didn't know that. Is there an=
y way to check
> > > > > my patch against all patchwork checks ,specially the AI-reviewe=
r
> > > > > before submitting it?
> > > >
> > > > See https://www.kernel.org/doc/html/latest/process/maintainer-net=
dev.html
> > > >
> > > thanks.
> >
> >



