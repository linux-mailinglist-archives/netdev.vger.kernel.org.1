Return-Path: <netdev+bounces-248851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E3ED0FD12
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 21:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D825301584F
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 20:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2C7248F73;
	Sun, 11 Jan 2026 20:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vlfe6jaf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EC622A813
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 20:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768163974; cv=none; b=bEVKl3dPHS3MauFRnL9CEahvk0Sguzz108K5d9g+U/zdpmaYU2ZjX4fYPB6zg1IYp2Y2xZ5K033N1O+DaXVe3GgjzgIhdFPIEev/sO/IMoyBmxpFx+4swcFzO7ue2CToun6D5RiPZAtFGIukWa1I9s3kd6PojVPlDN9G0HPMbps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768163974; c=relaxed/simple;
	bh=BW13uDTRClwd+ENxHZXrwcj7SqhkHZAYp+zJ9mxdIss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NgQyxp6NNS1GCludnqz0zJpiSJijfvpzdHNzEyQyDFBGOKB2su0uvBj2i8e01z5pNS78ARkFv+5DhipvpFU3zk2HxuOvCBgHuGAIgIpnSoMxxXtv1mJLmsYMUg8CDKwV09SO7whyEK14QjZktyessJFTaK6Q3xuDAnPEqlh/+js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vlfe6jaf; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-93f5910b06cso2860709241.0
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 12:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768163972; x=1768768772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/B6ir2X1iP6OIYfvHzrgy+6QEnGmGpOcZQdGo4rUmk=;
        b=Vlfe6jafqpcv1447YgakVCS78OBd4NtiKJeKi9AmjA4LehYOexwfOhBTqE5PB1saYL
         5BdpepXDRGLdCg9REInDLz0uHw90oUXpQ/MnGigt1JuuMnjTEbvTZlZ0tZqREJ4cLUi4
         rirYJFFPdBhH0jQj9AVHBTuX13ak+pA2qdsLRkQ5SZXcamIEyzVLRO5tSuZucdTDDWNe
         XofE7u7qQMOa+9ijIGmDvXLNLVsoxl5oqKFcLSgdQSl/s13L0o/Md2lL5vSvtz4ovU8c
         15QlGRGnzZAy6tcLWxM/PFpTQojIAMN7oM0wKs1gNiEFiVawylPdCSdIqw4yO6x/OFgp
         iYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768163972; x=1768768772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P/B6ir2X1iP6OIYfvHzrgy+6QEnGmGpOcZQdGo4rUmk=;
        b=k2RXNoqWnCJH4i+24ckYZ+oxStfe74vzOT9T5VuncG8EMEVHW0RnzSvlkJk92UFhyA
         pJ0VYTUBiagxiTHS+dkJHlwaXm/qz4x1yz5ipADh3cXVQuxiWiVSo/rhNPTCNTd13zZm
         eyy/1g8Zf/E4/IQveWM5AHtGUq5hOQGmOYtD+gal26HPex45TswdL8QNY7J6Bm82KXwe
         vyN+qhLMw9k80+Lw+1bQFkmi6AG/cgf1p69YNkvh5hPOWzdo8P7ZYwvSvMxSIr4lZrXn
         yfrvcMODN6aILyUIlCBsn1L9GzsZi569FdI9ccddkUbbZADCTs1bSxoAB3zEJ/PCCOEC
         OtNw==
X-Forwarded-Encrypted: i=1; AJvYcCWlRR9mpE5+x6zNZ7/UqSPATfjKOtzDGVMk2VVGDPtvn0k78k2VWVHAKp/GRuYpfijctwVZFn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAbEQrkj006B0L+wxvrIw+xRItJdxqHBGF2Z0LX4a+Q/2LXOBb
	DHlZsihM+AEumAVP0R//nEc+zFm8JyXrloFaJOuZ2KoRGxeCcOBWdIf8uLNFY3h5n8RHlz1ZD4r
	MNx5tLYiJMHkYnElR2JMtzTp7+kks2h0=
X-Gm-Gg: AY/fxX5Veb5uv309mkGd5XPzVmSGvF1m0XQXOqUUmnOY+Vm1/P+wPvCWjRr46P50dfw
	ZQTZhG30qKeUXhP+UqTEmmPqzZ985J5d1GQaICfETfP6N8HLY/XDnx+z8y8/SMO80wutuKOnz5I
	x3zh9z1tZio3cr+2C+xUDuEZrLxVifZ/Rz5cSlthVysvSlirITzf36wTZJvE5OLYVYYoGgpcmRh
	iB43qqeoJ2bRv8GxtbfxoaHXjOYF+VcUV+3A0A3bBTizte/Qa5V+acZTqqt+RSLDTB4y8MwjAkP
	2eZaxSqKIQi+hSags1a9RNUyvug8
X-Google-Smtp-Source: AGHT+IHgiVt0XZYHJifogGXKM5jKONG9TLKcspZkda6yt0LOWf6kO999+bQ8W8E6x1OgBeJWn9LEF0UE4NTlDMeG5Us=
X-Received: by 2002:a05:6102:c8d:b0:5db:293c:c294 with SMTP id
 ada2fe7eead31-5ec8b94edbfmr6899220137.5.1768163972469; Sun, 11 Jan 2026
 12:39:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111163947.811248-1-jhs@mojatatu.com> <20260111163947.811248-6-jhs@mojatatu.com>
In-Reply-To: <20260111163947.811248-6-jhs@mojatatu.com>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Sun, 11 Jan 2026 12:39:21 -0800
X-Gm-Features: AZwV_QiHay8kyrsuwvPurpt476Csb0RIB49hzdeCN69NIk-5IDi1jZbzUDbC3ug
Message-ID: <CAM_iQpVVJ=8dSj7pGo+68wG5zfMop_weUh_N9EX0kO5P11NQJw@mail.gmail.com>
Subject: Re: [PATCH net 5/6] net/sched: fix packet loop on netem when
 duplicate is on
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	netdev@vger.kernel.org, jiri@resnulli.us, victor@mojatatu.com, 
	dcaratti@redhat.com, lariel@nvidia.com, daniel@iogearbox.net, 
	pablo@netfilter.org, kadlec@netfilter.org, fw@strlen.de, phil@nwl.cc, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	zyc199902@zohomail.cn, lrGerlinde@mailfence.com, jschung2@proton.me, 
	William Liu <will@willsroot.io>, Savino Dicanosa <savy@syst3mfailure.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2026 at 8:40=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
> -               q->duplicate =3D 0;
> +               skb2->ttl++; /* prevent duplicating a dup... */
>                 rootq->enqueue(skb2, rootq, to_free);
> -               q->duplicate =3D dupsave;

As I already explained many times, the ROOT cause is enqueuing
to the root qdisc, not anything else.

We need to completely forget all the kernel knowledge and ask
a very simple question here: is enqueuing to root qdisc a reasonable
use? More importantly, could we really define it?

I already provided my answer in my patch description, sorry for not
keeping repeating it for at least the 3rd time.

Therefore, I still don't think you fix the root cause here. The
problematic behavior of enqueuing to root qdisc should be corrected,
regardless of any kernel detail.

Thanks.
Cong

