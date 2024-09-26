Return-Path: <netdev+bounces-129883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4F5986C1A
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 07:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E56911C21CD8
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 05:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E781714B4;
	Thu, 26 Sep 2024 05:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWfYV9w3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC55A1171C;
	Thu, 26 Sep 2024 05:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727329341; cv=none; b=f3gQHv8pRW/rHcO2XoIcAGVosElkMgdT60Utpkymodp2Uw944CrXqLSFqV9kvAwJSI5MNv+EHceH5BCIuaigZRRuCsGQcTbDB4+8AX7JqH4g2WeSwGX1BTrf54nW015K04RQtYgFzkb1FTm2tHA5pUyM/W+Q9BHUeI4XaL1fRcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727329341; c=relaxed/simple;
	bh=OMbQrqbQj4X6e2bryijPlq9YJFUeZSyo/0sQ6oBZbiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=To40szaoT9KPDSEWKcE1mBXGSjpTYVrDBiQmr3f3xWOt4OlTmFh+m4lmL5zieBP0BWw8cRx/zWZWwdTUlOD0CBmnkN2l7rEESIbLSgaacZNk/dr0pC03t8oxfuvq4MnGLeKBClUa+PpErJzN/fbFLVuiZTtmmF2+++sIdF73om8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWfYV9w3; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-503f943f115so203348e0c.0;
        Wed, 25 Sep 2024 22:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727329337; x=1727934137; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iLLnvZ8Qnw5olhuTraYaLYgbkUKswojzU6UirKeGBGE=;
        b=TWfYV9w31tVJmlBcSNXwGOXpVB/YDamJvb2P3RqMhCrbDRF2gurvLOIViWiYa94vZe
         x6hIvtV3TAgTnC7xKgrZnAU2iGT/BVGq8rAV/Q0sMckyn3+mGWnMtbDppzUEUwmlI+46
         bfZc8FAj2jRbktiSuVV/5R9j/MhLXP2ukqFTbQxy7HNOWharPVR9JHY4YJ2jmgT7Qlep
         xu/5A7Zh4xlXp7A3fOww6d5IBV18dOt5Z1gn8FnGvyMStzDtLBlke35gaTFDxb43WdbR
         BoY9ebrgJTrTC1GlpSva5VWz04w8r8fDY9RoEVSL/qQ220mGcF/y4qeipyUoFbZnVj0Z
         zHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727329337; x=1727934137;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iLLnvZ8Qnw5olhuTraYaLYgbkUKswojzU6UirKeGBGE=;
        b=Y5fybGrVuVnzS2BsRLTzOKHQUh9ObU9Xd8KJP30c2EZnvnaUSKqXjzrDhi7OtEC+Sy
         qToNM0ClHpjXChmAkgjT/4IPkW8oE/98tb3bkXOmq1rVkGMF2GPQWn78avtxhXBASeea
         OLtYv2CAMo4xaXX8rXkn7H2mSW4tCsQKoee2vlFvax6/2LvGWR8Y16FlUqYJk0hS2gUz
         YWh7k5rwLthAIDJSgG69gI8z63AsUEemh4WBq8JPTNMimTWPgZOhJt5rhX/HV5X6bMQr
         8WoEZ6cJxOILB9av6cmXX31zLChSZq8OYxLfALRmUgKW4eQxXOsy6XdBlL8RwtkSwLVV
         0UTA==
X-Forwarded-Encrypted: i=1; AJvYcCWp+/Kf8CVKzlyCS5IgSaYQojCxaCeogoIZ4hrHnlUClg+vcLtEl93NGdgKJ2JHdR7i0I98r5Do@vger.kernel.org, AJvYcCXNrS2m80zKfQx5Lg/096dq2d8EMcS006ax4bxylS5CuOhlowWyf2aV+KNqnwQUY3Uo9sYj8uGCVsXjfhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YypPyLvyEm3nfapclKQEaK3NaNDAgpAvyKKTRC05E59jYrzHjYu
	keI4yqpdD3r7jxY6x6f6FGQDrtzyorWjOrIrRG+0pQSArOLHeIPDsAyJRvLomZIQ50i3FHoHdwF
	G0Eubdh2H3j+zp1FbcwDUZG514RRs6zV7GC8=
X-Google-Smtp-Source: AGHT+IHK+I1v3MgXmnb9d2IhwgJ2kjr9VPoI7BOk1peZbrqGdQkdA+GYW0TAD3QD2EMjZBEpOFzJ3mIRynz5704kUBU=
X-Received: by 2002:a05:6122:20a6:b0:4f5:22cc:71b9 with SMTP id
 71dfb90a1353d-505c1d96569mr4378359e0c.5.1727329337427; Wed, 25 Sep 2024
 22:42:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923113135.4366-1-kdipendra88@gmail.com> <20240924071026.GB4029621@kernel.org>
 <CAEKBCKPw=uwN+MCLenOe6ZkLBYiwSg35eQ_rk_YeNBMOuqvVOw@mail.gmail.com>
 <20240924155812.GR4029621@kernel.org> <CAEKBCKO45g4kLm-YPZHpbcS5AMUaqo6JHoDxo8QobaP_kxQn=w@mail.gmail.com>
 <20240924181458.GT4029621@kernel.org> <CAEKBCKPz=gsLbUWNDinVVHD8t760jW+wt1GtFgJW_5cHCj0XbQ@mail.gmail.com>
In-Reply-To: <CAEKBCKPz=gsLbUWNDinVVHD8t760jW+wt1GtFgJW_5cHCj0XbQ@mail.gmail.com>
From: Dipendra Khadka <kdipendra88@gmail.com>
Date: Thu, 26 Sep 2024 11:27:06 +0545
Message-ID: <CAEKBCKOykRKyBGzBA6vC0Z7eM8q5yiND64fa4Xxk5s5vCufXtA@mail.gmail.com>
Subject: Re: [PATCH net] net: ethernet: marvell: octeontx2: nic: Add error
 pointer check in otx2_ethtool.c
To: Simon Horman <horms@kernel.org>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com, 
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Simon,

On Wed, 25 Sept 2024 at 12:07, Dipendra Khadka <kdipendra88@gmail.com> wrote:
>
> On Wed, 25 Sept 2024 at 00:00, Simon Horman <horms@kernel.org> wrote:
> >
> > On Tue, Sep 24, 2024 at 11:42:58PM +0545, Dipendra Khadka wrote:
> > > Hi Simon,
> > >
> > > On Tue, 24 Sept 2024 at 21:43, Simon Horman <horms@kernel.org> wrote:
> > > >
> > > > On Tue, Sep 24, 2024 at 08:39:47PM +0545, Dipendra Khadka wrote:
> > > > > Hi Simon,
> > > > >
> > > > > On Tue, 24 Sept 2024 at 12:55, Simon Horman <horms@kernel.org> wrote:
> > > > > >
> > > > > > On Mon, Sep 23, 2024 at 11:31:34AM +0000, Dipendra Khadka wrote:
> > > > > > > Add error pointer check after calling otx2_mbox_get_rsp().
> > > > > > >
> > > > > >
> > > > > > Hi Dipendra,
> > > > > >
> > > > > > Please add a fixes tag here (no blank line between it and your
> > > > > > Signed-off-by line).
> > > > > > > Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> > > > > >
> > > > > > As you have posted more than one patch for this driver, with very similar,
> > > > > > not overly complex or verbose changes, it might make sense to combine them
> > > > > > into a single patch. Or, if not, to bundle them up into a patch-set with a
> > > > > > cover letter.
> > > > > >
> > > > > > Regarding the patch subject, looking at git history, I think
> > > > > > an appropriate prefix would be 'octeontx2-pf:'. I would go for
> > > > > > something like this:
> > > > > >
> > > > > >   Subject: [PATCH net v2] octeontx2-pf: handle otx2_mbox_get_rsp errors
> > > > > >
> > > > >
> > > > > If I bundle all the patches for the
> > > > > drivers/net/ethernet/marvell/octeontx2/ , will this subject without v2
> > > > > work? Or do I need to change anything? I don't know how to send the
> > > > > patch-set with the cover letter.
> > > >
> > > > Given that one of the patches is already at v2, probably v3 is best.
> > > >
> > > > If you use b4, it should send a cover letter if the series has more than 1
> > > > patch.  You can use various options to b4 prep to set the prefix
> > > > (net-next), version, and edit the cover (letter).  And you can use various
> > > > options to b4 send, such as -d, to test your submission before sending it
> > > > to the netdev ML.
> > > >
> > >
> > > I did not get this -d and testing? testing in net-next and sending to net?
> >
> > I meant that b4 prep -d allows you to see the emails that would be sent
> > without actually sending them. I find this quite useful myself.
> >
> > >
> > > > Alternatively the following command will output 3 files: a cover letter and
> > > > a file for each of two patches, with v3 and net-next in the subject of each
> > > > file. You can edit these files and send them using git send-email.
> > > >
> > > > git format-patch --cover-letter -2 -v3 --subject-prefix="PATCH net-next"
> > > >

Do I need to maintain patch history below  Signed-off-by for each
patch when I send them in the patch set? If so, what to do with those
which have v1 but no v2 but the patch-set in v3?

> > >
> > > Should I send it to net-next or net?
> >
> > Sorry for the confusion. I wrote net-next in my example,
> > but I think this patch-set would be for net.
> >
> > ...
>
> Thank you Simon for everything.
>
> Best regards,
> Dipendra

Best regards,
Dipendra

