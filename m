Return-Path: <netdev+bounces-228670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D2EBD1ADF
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 08:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 507964E7273
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 06:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE3F21CFF7;
	Mon, 13 Oct 2025 06:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpS5vRk4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3AC1DE4CD
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 06:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760336845; cv=none; b=fTgr80tOzvaLvlm94VbvlDGZCtQXerbNL7LJZH4y66diT/b9/afWAESp6qdEJhA+SSMdt9uzv1R2Xq0Fhx9sJDDO0ogsjpdYGeuT3th2oeUwujQrXLMht9+/BTd15A3cYW+9twVkdzM7gAOrRPmn5pdsCe+VO4FduOnhz8WAOP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760336845; c=relaxed/simple;
	bh=C8vNNHZvAtyBt20ycUXr/JZp4K3nXiHY4UV19MDvuHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rObIST0CgxK0BUbA1f7ZbIfcpBop1qUP9D9v6t9FhLM4Cj6mDTW3uau4w+3lG9/rBh95zEvBnttoyufuUi+lRrJ8/t+oEUB0B4EN0S/fbPxknoHwctf9dptnujXjm+bzI3g+qmORTH5XNB3CGiLibhVUeRYMlASaamsBmgpCm0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpS5vRk4; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-42f9f5a9992so22203365ab.2
        for <netdev@vger.kernel.org>; Sun, 12 Oct 2025 23:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760336843; x=1760941643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8vNNHZvAtyBt20ycUXr/JZp4K3nXiHY4UV19MDvuHg=;
        b=mpS5vRk47wz6HkiByl2FfuKJKgaYrs6RZDtxBq7BcllU93wBeDaKiPHHbyv1JNfgyA
         Vo4Up9bC3gqO/d5R7/Xv50df0X7gRgXI7SMoWNs1ph8PEOQqARABBtMAjJ/xPOx7PTyM
         MIDPvqOF8WNLjrpM2wJhtxrXx/mTagIGOCckiGNZ+pNp+tS1SqS/7gGYaoxAmG2Ie6QQ
         RsWR6TDG7pFWtt1YEIG5bpEeeLR4zYSpM7n6P0Supn49E1bHq+Pu+phqkqr5X4ncDgyE
         CAaVPD0SVDvZ6B83+SBP3EIpVVd45G0Ajzj2OYQPg513VuuiunzK6KlofOukf8saQg3H
         Oupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760336843; x=1760941643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8vNNHZvAtyBt20ycUXr/JZp4K3nXiHY4UV19MDvuHg=;
        b=uO7hi2+HqVL1Hg1r+lDJKOPnCiMkmroW18l1NTmKp2sppe34HWEdHbKMzBI5ZCxtRW
         /L2bRuwIThuk67mpXxKvYXaGoxh0Ozec6mD2VyVTSgZS5I9oeTjfXRgqxj9MDhZELMHa
         U8u/lMO/B8SNB237Ib98b6OH2hQBu5XEN/xiXnUT3gp4yAfaopi5MATl6Ju3lIrkmltF
         U/cr8slNU78mIXS1nAYYYWvil9fGhFOCMvZEJQtFwz69C1YNPs/MoZpvlIENiqosyb3F
         oGQJF43pTNJhYdSpGNLc2d0UvHAmv8ZPoMnlel+dJeW4XvA2chyhqaySB8teNYBGFjai
         8zlw==
X-Forwarded-Encrypted: i=1; AJvYcCVvWQX2stA0AkJP2ktjMBZhVpEVCziOlyA/HLXXUaoKqICzsQoCcTN7/GzxyQ1hrhtoGRPUsak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy66EcC159NddOIy39csTtS9DKu3Q3yFyXqX6yn7UP58GY23DpX
	LRMPq4AhMe8AICwSeXmUkQzu1+N6qpev3pBRzoMpyjogOuPBgBoMM+J23kxbSEEHcLCCMtpUT3I
	pvCYgF/XC/bgMdd+MJ3IwgKHpzERVhzs=
X-Gm-Gg: ASbGnctmNLP61Z8ThZjnEpp0QtDvowKSiu4vzd5TxPJeCVoYJQXXuejWHk2iWsBZMF0
	jScMtwiv/1vGlpZXiMydcnpn++8aWMKb+D98D830q1mkVU2ShBCnGAqnwH6xb3dHZyUkXSKlCuQ
	z8vikZbVX+joF5yn8n68pGHeIfrKOy/TAxV/p7XefvkUTHumQ0Wiqt8InkEOL/Cc4s8+YJAJ47r
	v2sxgZGrXGb78/qeOUq9P3oEib1LEBlTXTZXLqL1KL9m+w=
X-Google-Smtp-Source: AGHT+IGgqHYD4VflONP0jVPXUlkjVXxJTP76TmwWfIxXjKC1WZ/+/7GjlfWRE4kW6YotyzP3yXTySDvv/hzKRy5esck=
X-Received: by 2002:a05:6e02:1c2a:b0:42d:8a3f:ec8f with SMTP id
 e9e14a558f8ab-42f873d1bbemr227352135ab.15.1760336842774; Sun, 12 Oct 2025
 23:27:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926074033.1548675-1-xuanqiang.luo@linux.dev>
 <20250926074033.1548675-2-xuanqiang.luo@linux.dev> <f64b89b1-d01c-41d6-9158-e7c14d236d2d@redhat.com>
 <zus4r4dgghmcyyj2bcjiprad4w666u4paqo3c5jgamr5apceje@zzdlbm75h5m5>
In-Reply-To: <zus4r4dgghmcyyj2bcjiprad4w666u4paqo3c5jgamr5apceje@zzdlbm75h5m5>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 13 Oct 2025 14:26:46 +0800
X-Gm-Features: AS18NWCqkc9Ka0YUDI18cPQBvhXm9QgW6suHmb1R73bEJDpKv6-WkV-6kSpej5Q
Message-ID: <CAL+tcoBy+8RvKXDB2V0mcJ3pOFsrXEsaNYM_o21bk2Q1cLiNSA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/3] rculist: Add hlist_nulls_replace_rcu()
 and hlist_nulls_replace_init_rcu()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Paolo Abeni <pabeni@redhat.com>, kuba@kernel.org, edumazet@google.com, 
	davem@davemloft.net, horms@kernel.org, kuniyu@google.com, 
	xuanqiang.luo@linux.dev, "Paul E. McKenney" <paulmck@kernel.org>, netdev@vger.kernel.org, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 1:36=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> On Tue, Sep 30, 2025 at 11:16:00AM +0800, Paolo Abeni wrote:
> > On 9/26/25 9:40 AM, xuanqiang.luo@linux.dev wrote:
> > > From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> > >
> > > Add two functions to atomically replace RCU-protected hlist_nulls ent=
ries.
> [...]
> > >
> > > Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> >
> > This deserves explicit ack from RCU maintainers.
> >
> > Since we are finalizing the net-next PR, I suggest to defer this series
> > to the next cycle, to avoid rushing such request.
> >
> > Thanks,
> >
> > Paolo
>
> Hi maintainers,
>
> This patch was previously held off due to the merge window.
>
> Now that the merge net-next has open and no further changes are required,
> could we please consider merging it directly?
>
> Apologies for the slight push, but I'm hoping we can get a formal
> commit backported to our production branch.

I suppose a new version that needs to be rebased is necessary.

Thanks,
Jason

