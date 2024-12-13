Return-Path: <netdev+bounces-151889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9089F176A
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 21:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0B2188A3FC
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 20:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D551922DE;
	Fri, 13 Dec 2024 20:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DM4hj/q7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BB8286A1
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 20:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734122037; cv=none; b=PXY3Nlu+RwloEKB/ocpOgxu5dWCWoxa3gQ+LKsUDupzEQOxCoiEPJsghJMdNv2d3Rs6Tb7mtRR12m3s4F36BQQ/dDQMxLjzWHMeEM+UHa286dk+8ZD4KzByJywxg+qLeIyKnP4TyzTHVg9zzOLktvIQiXecOHi7B8VgoVF0Eweo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734122037; c=relaxed/simple;
	bh=dWXxzk04Qr028I4w8WI0G52XVF+DIelzgBpvHlba5FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M40lWs4SjqNkPoXXM6do/sVAA4yntJ16nSzgFJvOu8LF4Ze4NsuTV3Ma+bK8PHqJOJUnyTM6IOvNCeot8Gfw1JSV91RHjY6HUnrLT7bO5PM8e6NsW2Eti4wNe6Me2SI7pFmoTb9/RLSq0MyurLU4rWQ9cDp/pyysiVW5yzN4fLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DM4hj/q7; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3eb4ac63dc2so1096923b6e.3
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 12:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734122035; x=1734726835; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aVfFWgXZ313bdRwSnMNxCScq1x6naQV4FP9/cgENRn4=;
        b=DM4hj/q7dC6i/piWjyeAZIL6cTRtNgrpl1SXnbKQuEJt07KG/HNyCMW+GOgrhmVry6
         QLefEdaIdoRNDhd/Czym/LVui0rBuY2tTidXl5691wyW3baqHsUsBXdQYJQWHrpBs+Xe
         zNTFqg5L/MUPNTCMAsWpWKfxF6qXqBwAy8TWgeOUie0y3rOUQNIXYpWPU8gdLzCgprtE
         gL4WT8e+sGd8j+y9DMlVF2oP8KXGHrEeh1N6+m+8y1qfc/yb66dBXfDDCtIxLjR+GCtc
         C9A5SK3iXKe3FI2mjwJ9+zrGX4hG9l3BpleLe/ZeKrK0AScMhtL5rDUeB8N48Lvrch5D
         W5PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734122035; x=1734726835;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aVfFWgXZ313bdRwSnMNxCScq1x6naQV4FP9/cgENRn4=;
        b=Wy+b/w6avdBAqJFUjaYKRp+X3dRi/h7m5IK+I+TPcuPs/5uYxNDZA0ojbGkgFCn0dB
         NQIo+Ypaxw+LAwG2lG8ORbjFr347SxE9DgIc25bKljBKAbda1e8LhinBssSglWVg16vp
         4Ch1t2pgpUiqUxDEA1RsD6HB9Q4vxIUF/AJkjMHbyrIbU/qLXqi4qX/5neCoFeSbxB4y
         U5zGCS1s0LhlzMf03C8RL17qNJ9LGOHRtuxDJTq3/850IXzqh551GyOCQkR/+b1/wBGl
         sU1D9bH8nDCbhs4usObc3YYYQiRZO/qi7CDEcQryhLp4ak5VsSFcZDfVtdrlBx5bWaU6
         jwDA==
X-Forwarded-Encrypted: i=1; AJvYcCUXat9FOXFjtbSQx1yEWO4W+u+FI1NB5upgalac4HkggLJR0QdVtT4+s0iEEhbi/kEsFTYITFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyos5Wc2T9tKlwztFqvlN0a+5m+tTsGK8wvvn4qqlQCp9MJBhGp
	TBBPmR92sEoRLj3ZWTyWFsOVFkcILz6/OuWXlB9NVDvNHNI6hzz0L0WX
X-Gm-Gg: ASbGnctpKQjjPlKu+gbnlMM80JpADFwi6LGCthYVIkKpQwIjIdnfi2hIAF59r/XAaKh
	QAkk5IDPr6Ph64k0/X9IXtToZQHrKQGJMAlhAedAf2oQnY935dFjCOW4i3kcpxV3x+A8oZRsjmj
	Oh0c4TIEnD8TXZhnFvGA3U24New8bupBvkk7SwV0Tuar3ESelHtJgIXo2F+gDuhpoRfCl2Cm9gA
	idp7GOmAzEneltv69vFkP3Uu1DJZ+AYkKGWBv7pPD7ItbwoSaRDjATL
X-Google-Smtp-Source: AGHT+IGOE6IjCkb2PnqjpY+v6HalfSbtgL6A0IkbUYekfMFiezI/3MuoIir4oidIQwhEMoARVpXyhA==
X-Received: by 2002:a17:90b:3c4e:b0:2ee:d63f:d71 with SMTP id 98e67ed59e1d1-2f28fb67304mr6039699a91.14.1734116014087;
        Fri, 13 Dec 2024 10:53:34 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f12b379225sm2421343a91.0.2024.12.13.10.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 10:53:33 -0800 (PST)
Date: Fri, 13 Dec 2024 10:53:32 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>,
	Taehee Yoo <ap420073@gmail.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next 00/13] selftests: ncdevmem: Add ncdevmem to ksft
Message-ID: <Z1yCrGD-UOlw5VbY@mini-arch>
References: <20240912171251.937743-1-sdf@fomichev.me>
 <ZuNFcP6UM4e5EdUX@mini-arch>
 <CAHS8izM8e4OhOFjRm9cF2LuN=ePWPgd-EY09fZHSybgcOaH4MA@mail.gmail.com>
 <ZuNgklyeerU5BjqG@mini-arch>
 <Z1uLgXIA8HApli8v@mini-arch>
 <CAHS8izPAB2Vr0LoVfvz4SBpSdvmXv_CYSj7Z0ZX2Cngx1ooC9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izPAB2Vr0LoVfvz4SBpSdvmXv_CYSj7Z0ZX2Cngx1ooC9Q@mail.gmail.com>

On 12/13, Mina Almasry wrote:
> On Thu, Dec 12, 2024 at 5:19 PM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 09/12, Stanislav Fomichev wrote:
> > > On 09/12, Mina Almasry wrote:
> > > > On Thu, Sep 12, 2024 at 12:48 PM Stanislav Fomichev
> > > > <stfomichev@gmail.com> wrote:
> > > > >
> > > > > On 09/12, Stanislav Fomichev wrote:
> > > > > > The goal of the series is to simplify and make it possible to use
> > > > > > ncdevmem in an automated way from the ksft python wrapper.
> > > > > >
> > > > > > ncdevmem is slowly mutated into a state where it uses stdout
> > > > > > to print the payload and the python wrapper is added to
> > > > > > make sure the arrived payload matches the expected one.
> > > > >
> > > > > Mina, what's your plan/progress on the upstreamable TX side? I hope
> > > > > you're still gonna finish it up?
> > > > >
> > > >
> > > > I'm very open to someone pushing the TX side, but there is a bit of a
> > > > need here to get the TX side done sooner than later. In reality I
> > > > don't think anyone cares as much as me to push this ASAP so I
> > > > plan/hope to look into it. I have made some progress but a bit to be
> > > > worked through at the moment. I hope to have something ready as the
> > > > merge window reopens; very likely doable.
> > >
> > > Perfect!
> >
> > Hey Mina,
> >
> > Any updates on this? Any chance getting something out this merge window?
> >
> > I was hoping you'd post something in the previous merge window (late Sep),
> > but if you're still busy with other things, should I post a v2 RFC? I have
> > moved to the mode which you suggested where tx dmabuf is associated
> > with the socket; this lets me drop all tx ref counts (socket holds
> > dmabuf, skb holds socket until tx completion). I also moved to a
> > more performant offset->dma_addr resolution logic in tcp_sendmsg and
> > fixed a bunch of things on the test side...
> 
> My apologies for the delay. I have the TX path ready, but having
> trouble running the performance tests unrelated to the patch itself.
> I'm going to send the TX path after a round of internal reviews,
> likely by the end of next week.

Awesome, looking forward to it! I put whatever I have on my side on gh
as well: https://github.com/fomichev/linux/commits/upstream/net-next/tx/2/

Take a look in case something makes sense to update on your side. I
reworked the test to a more conventional 'cfg.remote.deploy' model
and I also simplified lookup of dma_addr on tx (my previous tx code
was super slow and buggy).

