Return-Path: <netdev+bounces-115188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D81945633
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 04:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E708B20DEF
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 02:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7798134BD;
	Fri,  2 Aug 2024 02:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GO3I31WF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3393D68;
	Fri,  2 Aug 2024 02:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722564073; cv=none; b=X3MO+1YtKVTWCGnkkQMs/feZOjeTDyiflAQYO4/8G9oqYU0Uk43yBSooSdJ7fsKTKyyZ3Y452ATI50GBS9h/S7UxWpEN4YYmCWq/Vi9l3hRB3k+Xspdqb2q61uxGbVZym7ojVgqtYkGZcQ1vF6tk3ET7Lt9wl2N31O3nrK5bVpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722564073; c=relaxed/simple;
	bh=DME/FcWpg1y22yW6VktfNpiVVplejRNksuU2BNddFm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SdU+S0/dIcEn/L+KLLA/4ODsd6PEqkaVlMIdluS41BDh4nJK+owbv/AKukARn1FTCX1pPfwV5qzXzbxLPOKuZZey/bG8+eGJtm8Rmd2xLN8lrx028UDwQxgI/VSowbL91EC7ipj9ZphtX2GoLtmSwij5daZVVf4THMjzA7xKiy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GO3I31WF; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2cb81c0ecb4so2059693a91.0;
        Thu, 01 Aug 2024 19:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722564072; x=1723168872; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6jPu7+Zk7lvnbGrSwKxSxehNV5Y9nXc9e9et1xGEkKw=;
        b=GO3I31WFZo0a+XBo1Ys8JeSgTFQFTSojS8JtBoL8pdSJWvmJkm7zcrum507sCyATSE
         iO0822c0WunPrbWhTKJTSivf7hQv6PEjba4LZWmCZ/UOPl/E8h4ZPuIRv3agujk9RyN1
         WXlXeH1PLm9I850YSS7ls4ERgvDWh4zTmNgZGq8fEMs9MwtQr6ay02MUGcNMV3DVnTzh
         nLXGzg2siNIZErO2fuAryVrC7wDEw24GhhHH2QF0KX1tW8CjRgZC498YrG+Kcgn9sW3L
         gbQ3kY4EFO0u4gnNaEAY+Pt/kmr1tIjP6NtFxOao4upKUklXnILv9wenJLK71XHCH4u1
         FLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722564072; x=1723168872;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6jPu7+Zk7lvnbGrSwKxSxehNV5Y9nXc9e9et1xGEkKw=;
        b=m0OX56uV3BFUvqSTh6RRrpFKiScK8saLB/xcR5PI9GEL4/6GrVO7qttT80PO3BiJ8i
         Ex+2H8C6zP61XiP1O1F8jdysfjMCoU0iBRwEt5xfV/245o0kIuWQkMjw3dvZqUojl2SX
         nOMGG8NPoxfzNTrsCzM3i2Sh5WhivL2At16127j0x3722+LJazbyc+ovUjwBw9vfgmOH
         Ewe0FKQrfafyQOluu3FeGa2AOgOVB0vzCHg8NRFwLj1KfHD89VrCsuPatwJdTELaHjGV
         nw4UIAoWfcDG5MxkVE1q2X2XbVqmBztV8OQ2S5FP2J4v8QxhL2lgdkrJHhJGB/qYuZA1
         owGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvZLYNFpxfd/gB16qFPN46Np6m0bCkNq5X0iudClOZIG/e69cR0km26mx9TNs94SI4iQwqO56nXbv9dbhtIveJsYLpaLY2Uz7RpTlWEjjCeHj97eXw9zwzB9WsRvgjVxNGazLE
X-Gm-Message-State: AOJu0YzpU6DDqVnrj5yvQpZVOPvh1ImJTak1tAwjItqIs4dt+5PhTpbE
	4xCliC3Kphsb0Arf2H71xa4ciSepueRwQa9gwvR/9kDlQRQ/kKNhGXBcYXWUmAG+ooYUUMRyNol
	kwCecimpDds+riFgUz98QVNFetMw=
X-Google-Smtp-Source: AGHT+IHjGpzpgrv1AUBVEgNxsB96VHmMg0F97xvxdjInlzIReOvhWJNU6m6LqZlULDRI7gbYV1gnMdNzinP0BSVC+bk=
X-Received: by 2002:a17:90a:ba97:b0:2c2:c3f5:33c3 with SMTP id
 98e67ed59e1d1-2cff093a154mr5472664a91.6.1722564071378; Thu, 01 Aug 2024
 19:01:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJwJo6Z-qsZ9ZLV7qHrc=ujYT0Q2Ayod_C6e9kM+2QH48z650w@mail.gmail.com>
 <20240802010250.82312-1-kuniyu@amazon.com>
In-Reply-To: <20240802010250.82312-1-kuniyu@amazon.com>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Fri, 2 Aug 2024 03:00:59 +0100
Message-ID: <CAJwJo6ajnzqS0mNwEJNEYo5HBryRNJOtZeK7aRVGWCdu5ovc0A@mail.gmail.com>
Subject: Re: [PATCH net v3] net/tcp: Disable TCP-AO static key after RCU grace period
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Aug 2024 at 02:03, Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
>
> From: Dmitry Safonov <0x7f454c46@gmail.com>
> Date: Fri, 2 Aug 2024 01:37:28 +0100
> > On Thu, 1 Aug 2024 at 01:13, Dmitry Safonov via B4 Relay
> > <devnull+0x7f454c46.gmail.com@kernel.org> wrote:
> > >
> > > From: Dmitry Safonov <0x7f454c46@gmail.com>
> > [..]
> > > Happened on netdev test-bot[1], so not a theoretical issue:
> >
> > Self-correction: I see a static_key fix in git.tip tree from a recent
> > regression, which could lead to the same kind of failure. So, I'm not
> > entirely sure the issue isn't theoretical.
> > https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=224fa3552029
>
> My syzkaller instances recently started to report similar splats over
> different places (TCP-AO/MD5, fl6, netfilter, perf, etc), and I was
> suspecting a bug in the jump label side.

I'm glad I dropped you a hint :-)

> report19:2:jump_label: Fatal kernel bug, unexpected op at fl6_sock_lookup include/net/ipv6.h:414 [inline] [000000001bd3e3db] (e9 ee 00 00 00 != 0f 1f 44 00 00)) size:5 type:1
> report23:1:jump_label: Fatal kernel bug, unexpected op at nf_skip_egress include/linux/netfilter_netdev.h:136 [inline] [00000000c1241913] (e9 e9 0a 00 00 != 0f 1f 44 00 00)) size:5 type:1
> report45:2:jump_label: Fatal kernel bug, unexpected op at tcp_ao_required include/net/tcp.h:2776 [inline] [000000009a4b37e9] (eb 5a e8 e1 57 != 66 90 0f 1f 00)) size:2 type:1
> report49:3:jump_label: Fatal kernel bug, unexpected op at perf_sw_event include/linux/perf_event.h:1432 [inline] [00000000c1f7a26c] (eb 24 e9 63 fe != 66 90 0f 1f 00)) size:2 type:1
> report58:2:jump_label: Fatal kernel bug, unexpected op at tcp_md5_do_lookup include/net/tcp.h:1852 [inline] [00000000fbd24b58] (e9 8d 01 00 00 != 0f 1f 44 00 00)) size:5 type:1
>
> I'll cherry-pick the patch and see if it fixes them altogether.
> It will take few days.

Thanks!

-- 
             Dmitry

