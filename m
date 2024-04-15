Return-Path: <netdev+bounces-88080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5787E8A5989
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 20:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83303B22C63
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 18:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE301369B8;
	Mon, 15 Apr 2024 18:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdWoH1mV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BFC13A89C
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 18:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713204233; cv=none; b=u8HytUVjchGpeeM9cPLx3IlePcp4uej+MJYdb64YomnBjSZ61hVBU5/GbXGjEHeC//Kn6X0YJu60fXUyxoiHWjI7y7fNREbdAQ8J12DSOKh8WGeagUW6JZgp2CtiZuWilI2gysTznGU3IKAmTXlDGjfTxyKzaNAXXjSDipMOGXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713204233; c=relaxed/simple;
	bh=50KdwdlsXOKLxRC02rUYrfY/fC65mK2hSlXH5/kjv1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gxMOMi5vZ3RrUyDFf2b8UFLh8xs+TGbrBNiezsvo1TiLVOOTeueXiq9v8I1Kdy+JTzZ8tZAxsrXJT/SqHE5/SmkOflElTnWnurUmn5X7A0hvNVcAOkUx7AU1o4/1VMEY+YkmhSOl7mUObsJOpctvmFG9nlbkjuDjoosFb/d+8oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdWoH1mV; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-347c197a464so1002289f8f.2
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 11:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713204230; x=1713809030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHaGcfEU4qqfdLpJ95BDm9t1l3OhMJRGoOjqkWpeIwc=;
        b=EdWoH1mVwpojKqB29FFcexz3G5GnhbmaOwEhG49tteSJL6G1XFuxANsnopK57wWPPH
         4/HLkR9v3alGHuDWA1erK5o3pbcl06bbLX0Fikf5ciM1iHtliPwjrypnfKrEB4sOAZdh
         J0wlLJJyCSrhUc4OVeE6v2AZWNOWgVhayOw9m9lIdc6X5uDemGSjyXqGd8HrJ33TMVD3
         Slxla+vslWfk5CL9Ei2OvjPH32tRynMTxYj3EkON3amoPCLCjts+gcaOwpFRqYiH/GRy
         CMoOzXbgZNxrBPZNuCVAg8M8uFe3sS/KZ8KWxowgTrYXCfDAHctgl2RJr59wUplh9R3G
         bRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713204230; x=1713809030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHaGcfEU4qqfdLpJ95BDm9t1l3OhMJRGoOjqkWpeIwc=;
        b=gWX7Rl749dq5U1wz/U4Ppkqv2OViDf5gfxBn0yghcXAu+1sh4l1kzhWQwUiRFJikiE
         18USlo9QxXmBy/+zvrHVgKd3qgpG3njaq3cbU4aUn79zVAbOFJhSXnIDO4ossQNHe8ni
         cq3YfXAZavA/GfXKJBX4jJLYEcsdgcMeRjZDx2k9zoDJLkCG0RAdHbcgeOodjUjRnhXy
         XBUKLwxmZxI/4BdoMq0K/cPcojntvEC6IhZo+nwaalHirIdyBGPtCTKrte/o6FsmBsUU
         WTC5B8gN8bLtynWZQ8YgCMl/UvD2hYApZ6ylVfPf6DrVUdH+3kvMuKdnM3GIBsJSCm7d
         +sWw==
X-Forwarded-Encrypted: i=1; AJvYcCVyYbDSrdS7cccWsmLTqj3ipM736OxE2sAyQ0pKbyI9u3tZNEZM2fOGxKnMDx4dl+1LDTwlnK55V8Beu0KDSCnjGfhps/Y/
X-Gm-Message-State: AOJu0YxDONpefV6okhxWBAG367dORp7FDlqu1B2xaoyvXg/LFad8i/cr
	Wi5CbRAt6qASccBsJmytCHtFVcOvYb5xPCk8Ex/cMmp82KLNI9G+5oK1ms7647BGAkhg89SjSP3
	Yx+GG47fDnF8uXc1l2NeRzIBjjO95Lw==
X-Google-Smtp-Source: AGHT+IG3qG2lwzV5uNQ0+ZaU3XTQhCrVjrWoA3bwdKdb0vFBnbOKxuGw5ac5xCHNtCqd2sGOF76LL80sd0CINN7QW90=
X-Received: by 2002:a5d:4011:0:b0:347:9b80:2071 with SMTP id
 n17-20020a5d4011000000b003479b802071mr3054220wrp.26.1713204230191; Mon, 15
 Apr 2024 11:03:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <171217496013.1598374.10126180029382922588.stgit@ahduyck-xeon-server.home.arpa>
 <41a39896-480b-f08d-ba67-17e129e39c0f@huawei.com> <CAKgT0Uf6MdYX_1OuAFAXadh86zDX_w1a_cwpoPGMxpmC4hGyEA@mail.gmail.com>
 <53b80db6-f2bc-d824-ea42-4b2ac64625f2@huawei.com> <CAKgT0UeQS5q=Y2j3mmu9AhWyUMbey-iFL+sKES1UrBtoAXMdzw@mail.gmail.com>
 <0e5e3196-ca2f-b905-a6ba-7721e8586ed7@huawei.com> <CAKgT0UeRWsJ+NiniSKa7Z3Law=QrYZp3giLAigJf7EvuAbjkRA@mail.gmail.com>
 <bf070035-ba9c-d028-1b11-72af8651f979@huawei.com> <CAKgT0UccovDVS8-TPXxgGbrTAqpeVHRQuCwf7f2qkfcPaPOA-A@mail.gmail.com>
 <20240415101101.3dd207c4@kernel.org>
In-Reply-To: <20240415101101.3dd207c4@kernel.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 15 Apr 2024 11:03:13 -0700
Message-ID: <CAKgT0UcGN3-6R4pt8BQv2hD04oYk48GfFs1O_UGChvrrFT5eCw@mail.gmail.com>
Subject: Re: [net-next PATCH 13/15] eth: fbnic: add basic Rx handling
To: Jakub Kicinski <kuba@kernel.org>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, netdev@vger.kernel.org, 
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 10:11=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 15 Apr 2024 08:03:38 -0700 Alexander Duyck wrote:
> > > > The advantage of being a purpose built driver is that we aren't
> > > > running on any architectures where the PAGE_SIZE > 4K. If it came t=
o
> > >
> > > I am not sure if 'being a purpose built driver' argument is strong en=
ough
> > > here, at least the Kconfig does not seems to be suggesting it is a pu=
rpose
> > > built driver, perhaps add a 'depend on' to suggest that?
> >
> > I'm not sure if you have been following the other threads. One of the
> > general thoughts of pushback against this driver was that Meta is
> > currently the only company that will have possession of this NIC. As
> > such Meta will be deciding what systems it goes into and as a result
> > of that we aren't likely to be running it on systems with 64K pages.
>
> Didn't take long for this argument to float to the surface..

This wasn't my full argument. You truncated the part where I
specifically called out that it is hard to justify us pushing a
proprietary API that is only used by our driver.

> We tried to write some rules with Paolo but haven't published them, yet.
> Here is one that may be relevant:
>
>   3. External contributions
>   -------------------------
>
>   Owners of drivers for private devices must not exhibit a stronger
>   sense of ownership or push back on accepting code changes from
>   members of the community. 3rd party contributions should be evaluated
>   and eventually accepted, or challenged only on technical arguments
>   based on the code itself. In particular, the argument that the owner
>   is the only user and therefore knows best should not be used.
>
> Not exactly a contribution, but we predicted the "we know best"
> tone of the argument :(

The "we know best" is more of an "I know best" as someone who has
worked with page pool and the page fragment API since well before it
existed. My push back is based on the fact that we don't want to
allocate fragments, we want to allocate pages and fragment them
ourselves after the fact. As such it doesn't make much sense to add an
API that will have us trying to use the page fragment API which holds
onto the page when the expectation is that we will take the whole
thing and just fragment it ourselves.

If we are going to use the page fragment API we need the ability to
convert a page pool page to a fragment in place, not have it get
pulled into the page fragment API and then immediately yanked right
back out. On top of that we don't need to be making significant
changes to the API that will slow down all the other users to
accomodate a driver that will not be used by most users.

This is a case where I agree with Jiri. It doesn't make sense to slow
down all the other users of the page fragment API by making it so that
we can pull variable sliced batches from the page pool fragment
interface. It makes much more sense for us to just fragment in place
and add as little overhead to the other users of page pool APIs as
possible.

