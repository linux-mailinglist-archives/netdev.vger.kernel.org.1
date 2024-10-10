Return-Path: <netdev+bounces-133995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BB4997A59
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 04:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0800B284920
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 02:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBF3224CF;
	Thu, 10 Oct 2024 02:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqWtSqJK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8766A14293;
	Thu, 10 Oct 2024 02:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728525934; cv=none; b=dABL507twSSYrDjrRcGuvTzKhFVt+hlc6JHbmwD3VFmrFVKQlU/tGLRpE5n7ieEITnjLwhhbCdFrYfJPAXvDHukQ9CF41E9eYtrQMFAU5jGYLODG8mtQHo3IYbDvoOzoOYb/9nm2GzwRM5usZ2yaSRvnj255uqIa1ycx6ZLYd9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728525934; c=relaxed/simple;
	bh=oP5QYm/70vfqOtPdsGr2+LBh3R8qeM5xVe8DOd5ZiD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OF2Tcmjlb4r8Z9/2e1I2R31Ay/hHHim5OBtrVGVwPoQy0vdkA/p2bcpCNRsDd8Fe31DTJeyWkAYREV0zhaQwSl5nSAu16mu/mShJeCH6g0XLdBaaxAtUFCB/SRZX0l97mmYjtHYFUUcfqtoOU/Lc10qj2ZUXB66/vk547tjIv1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eqWtSqJK; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-e2904ce7e14so432455276.0;
        Wed, 09 Oct 2024 19:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728525931; x=1729130731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMrS54MxodS3n9OqxrG5rU5JYoDqHS/hBg9ei6ZcNfA=;
        b=eqWtSqJKJKhYnrhr8TRMf6nMyW2YH8KE7rRFICtta40hpiNwk74YoahGaWBTPxU/L1
         GPQgaTsWqad12UAWnJDafzdBI53ySaTVfPMOhalCkyHXjzzShsId/GLtDzZDQDkhocES
         TeDC8QLZ/mUba91eV8Ip3nBatF9MOQvBXDUm49e2YzvTVvmkf1qwZvHek/kZijBGN3vS
         hlaOdtbIonjC20QQwGtI85lQSv5yGQFvPVCt0durzKyfbwZzygwYjQZI7Q7kwxqCzv/9
         O3lKD/PE5rMnAiTNbmJiaV74Jfqtzy9FaBW9OB0fzK9ljEUDmG9F0StKHv7clL05JKt6
         HWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728525931; x=1729130731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMrS54MxodS3n9OqxrG5rU5JYoDqHS/hBg9ei6ZcNfA=;
        b=Xd+yeeeanvQ2pQhD4UokANsDMH46f7ScI3zzzRMHwSaBCkMLL365OvNBGE7iJg7kZ3
         LcWICTVAIoNKSJbCpiouv3ABGy1vZI5BavxNDPP47p3RuZ5REYPo7ByDgoYECk82Prkg
         363B2Lm7rGAmOfi1fnKHcxDNnyYVKxHVhiuqoKtSPlnMiDQW0tThgJFcO6wEKFUYQInK
         sb/eVAICjpVANNXAEPT/VNVACnd0d8vgRHtjV/15PwmcU/BX8yHC7jCdlU8gWvL0R4H1
         bs7svn/IPbP5w1V7spUbtkE6bVEBJRI20/pIr17RnD204PfnNSGn4SjHgyaeKPjTA57d
         kmgA==
X-Forwarded-Encrypted: i=1; AJvYcCWQYvQa14NSo24w1GX3/hkRxca5ia1ts18HsAd3mms6WGFUi2HV8CSZgje8XIdprb8vWf4XY7xk@vger.kernel.org, AJvYcCXwWKG2guyR16gJ7FzZAyPbVqg8I7YGP72y6dtvZrrMmMUN93oWMthwmq2Ell72CC57Ol8nHTAmnBOQrzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGOrVqtvhW5LENIklMUApqZg8+jQwsmQ82Yg1cqhg7Ero4EaRG
	mluMZB+ItBKk1F1bztx7IzeQ+C/jgxadrbGl+rw1C9m1dOLeBtSrFytjWDlpCs7dF/1MJWOM51N
	eG8v8YIFNCg9ncxGRguR/lXY1C/Y=
X-Google-Smtp-Source: AGHT+IGx8Yz9D2oYZMxrivrhT/RrPksLeeIeW6BZDSTBHLzlqNKOeKwrgDz6WnDPsSv84d+PwSDXh+jx6w3kYpV0+lc=
X-Received: by 2002:a05:6902:2310:b0:e29:c8f:14ba with SMTP id
 3f1490d57ef6-e290c8f16e2mr1156535276.5.1728525931383; Wed, 09 Oct 2024
 19:05:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008142300.236781-1-dongml2@chinatelecom.cn>
 <20241008142300.236781-9-dongml2@chinatelecom.cn> <ZwV0cjdg2x67URMx@debian>
 <CADxym3ZDkjuu9TJQ_vmbky75T+bn32XMrMhQRi=rVtxgRXC_Zw@mail.gmail.com> <CAL+tcoAwJCsACt=Cc6HtzCFgBq_TUhmJq7dSuYnbFF5XGETQ_Q@mail.gmail.com>
In-Reply-To: <CAL+tcoAwJCsACt=Cc6HtzCFgBq_TUhmJq7dSuYnbFF5XGETQ_Q@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Thu, 10 Oct 2024 10:06:13 +0800
Message-ID: <CADxym3Y4p6kH=UGA7=bq6LKxBzLTpEPhUuJrd9FUqgL7_7HVJg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 08/12] net: vxlan: use kfree_skb_reason() in vxlan_xmit()
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Guillaume Nault <gnault@redhat.com>, idosch@nvidia.com, kuba@kernel.org, 
	aleksander.lobakin@intel.com, horms@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org, 
	dongml2@chinatelecom.cn, amcohen@nvidia.com, bpoirier@nvidia.com, 
	b.galvani@gmail.com, razor@blackwall.org, petrm@nvidia.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 10:29=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Wed, Oct 9, 2024 at 9:37=E2=80=AFAM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
> >
> > On Wed, Oct 9, 2024 at 2:05=E2=80=AFAM Guillaume Nault <gnault@redhat.c=
om> wrote:
> > >
> > > On Tue, Oct 08, 2024 at 10:22:56PM +0800, Menglong Dong wrote:
> > > > Replace kfree_skb() with kfree_skb_reason() in vxlan_xmit(). Follow=
ing
> > > > new skb drop reasons are introduced for vxlan:
> > > >
> > > > /* no remote found for xmit */
> > > > SKB_DROP_REASON_VXLAN_NO_REMOTE
> > > > /* packet without necessary metadata reached a device which is in
> > > >  * "eternal" mode
> > >
> > > That should be "external" mode (with an "x").
> > >
> > > > +     /**
> > > > +      * @SKB_DROP_REASON_TUNNEL_TXINFO: packet without necessary m=
etadata
> > > > +      * reached a device which is in "eternal" mode.
> > >
> > > Here too.
> > >
> >
> > Oh, my eyes!
> >
> > I checked this document one by one, and I'm sure there
> > are no more typos besides this one.
> >
>
> You can try "codespell xxx.patch" to avoid typos easily before
> submitting patches.

That's a good idea! Thank you, xing~

