Return-Path: <netdev+bounces-57534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0709B8134D1
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 16:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EAF4B20CBA
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 15:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39455C8FD;
	Thu, 14 Dec 2023 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="sAu6lj2/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F638E
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 07:31:37 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6da3a585c29so1232833a34.1
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 07:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702567896; x=1703172696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yO4kIoFu7m42w9yDigXpykpNwdT7OWkJmrUXnTRqkgQ=;
        b=sAu6lj2/UnObxhiSZ2ZfhwKd0Kl4S4NN8MW12NEM9Rvgu3telVzkZPRD+VpRVp9TcM
         /VG7B32K4xODG/RAJa/5jjsAvbYi5gVzH9FMEeCq/jLsK3+oU1lZehdmn02yMoIfWtnx
         1QwGwWmsSKEWNQgouauEhP1LievM8E0fN0uTIJUocZTGVJK4rXefNreA7B1g+liMoVCD
         B1wISBDaFIz0+m/1yPRPdm/uWIqsZwDbmyMShW7fYyRu27MdEl+6F7au41cYOnUjnR6l
         2msgtNE83RUJY7FxmkHXN+c1HKhts4CYe3DogL6RQhLyvwewjUA6yyHLDOTXoK70O9HW
         CnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702567896; x=1703172696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yO4kIoFu7m42w9yDigXpykpNwdT7OWkJmrUXnTRqkgQ=;
        b=uCKqdyDQ+/incWVCZnR4UL5ZlzFQ3GJTaAH/YKBC6sRy1Fp98tpO8rJRuoFMeIHt3A
         TXKgERIS4KS1cYDnIxt6zPGXma3FPn62WgbfCLDgKda4QLGj7UvkRWMToIrmFh96HVT2
         pSNgs2/uOW7BJIFCT0SazG1yg1gkFXAcJIuQcEqv6MXk6cDLNA74cOfCb+SaFq59ROzB
         3GLYoEut9Hl2DtMf1Izk36XTChxSGYYNpyFXmG9sYYD4IvR8JZlLDxxOG5/AWBSK/j6/
         QpQNinFEhrVZchCJJypB+WlSkEDcly/PXthRuW84tT+QU/Td9kMixFYYm0bDx1YkO6Fm
         SIPw==
X-Gm-Message-State: AOJu0YzfPAB2IG9R40ZS1lta2DtGa7dWco5wgC0vi9FEpd2l+eFAZyEs
	/26S3R+5Iu6rqga57HYi4U+P/bWG8AyupkcFXZ62nA==
X-Google-Smtp-Source: AGHT+IHa7CFhkPQf7/HLv4UBRu46RyqZ5iCU6cnnVvuqgcqf+8Era4Wre4XVrWXvPIenlblA9thcMLA89jU38lK1PCE=
X-Received: by 2002:a05:6830:1084:b0:6d9:e192:56a4 with SMTP id
 y4-20020a056830108400b006d9e19256a4mr9214346oto.17.1702567896301; Thu, 14 Dec
 2023 07:31:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205205030.3119672-1-victor@mojatatu.com> <20231205205030.3119672-3-victor@mojatatu.com>
 <20231211182534.09392034@kernel.org> <CAM0EoMkYq+qqO6pwMy_G58_+PCT6A6EGtpPJXPkvQ1=aVvY=Sw@mail.gmail.com>
 <CANn89i+-G0gTF=Vmr5NprYizdqXqpoQC5OvnXbc-7dA47tcdyQ@mail.gmail.com>
 <CAAFAkD8X-EXt4K+9Jp4P_f607zd=HxB6WCEF_4BGcCm_hSbv_A@mail.gmail.com>
 <CAM0EoMk9cA0qCGNa181QkGjRHr=4oZhvfMGEWoTRS-kHXFWt7g@mail.gmail.com> <20231213130807.503e1332@kernel.org>
In-Reply-To: <20231213130807.503e1332@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 14 Dec 2023 10:31:24 -0500
Message-ID: <CAM0EoM=+zoLNc2JihS4Xyz77YciKCywXdtr8N3cDuwYRxc8TcQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] net: sched: Make tc-related drop reason
 more flexible for remaining qdiscs
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jamal Hadi Salim <hadi@mojatatu.com>, Eric Dumazet <edumazet@google.com>, 
	Victor Nogueira <victor@mojatatu.com>, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, pabeni@redhat.com, daniel@iogearbox.net, 
	dcaratti@redhat.com, netdev@vger.kernel.org, kernel@mojatatu.com, 
	Taehee Yoo <ap420073@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 4:08=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 13 Dec 2023 13:36:31 -0500 Jamal Hadi Salim wrote:
> > Putting this to rest:
> > Other than fq codel, the others that deal with multiple skbs due to
> > gso segments. So the conclusion is:  if we have a bunch in the list
> > then they all suffer the same fate. So a single reason for the list is
> > sufficient.
>
> Alright.
>
> I'm still a bit confused about the cb, tho.
>
> struct qdisc_skb_cb is the state struct.

Per packet state within tc though, no? Once it leaves tc whatever sits
in that space cant be trusted to be valid.
To answer your earlier question tcf_result is not available at the
qdisc level (when we call free_skb_list() but cb is and thats why we
used it)

> But we put the drop reason in struct tc_skb_cb.
> How does that work. Qdiscs will assume they own all of
> qdisc_skb_cb::data ?
>

Short answer, yes. Anyone can scribble over that. And multiple
consumers have a food fight going on - but it is expected behavior:
ebpf's skb->cb, cake, fq_codel etc - all use qdisc_skb_cb::data.
Out of the 48B in skb->cb qdisc_skb_cb redefined the first 28B and
left in qdisc_skb_cb::data as free-for-all space. I think,
unfortunately, that is now cast in stone.
Which still leaves us 20 bytes which is now being squatered by
tc_skb_cb where the drop reason was placed. Shit, i just noticed this
is not exclusive - seems like
drivers/net/amt.c is using this space - not sure why it is even using
tc space. I am wondering if we can make it use the 20B scratch pad.
+Cc author Taehee Yoo - it doesnt seem to conflict but strange that it
is considering qdisc_skb_cb

> Maybe some documentation about the lifetimes of these things
> would clarify things?

What text do you think makes sense and where should it go?

cheers,
jamal

