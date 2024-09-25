Return-Path: <netdev+bounces-129656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8139852DF
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 08:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B9F71C21084
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 06:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B9B155C9A;
	Wed, 25 Sep 2024 06:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxCzIibe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F901553BB;
	Wed, 25 Sep 2024 06:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727245366; cv=none; b=d8tAFS7pEq5i/STzUcmB6xfFE7ZytKCjSw+8NS9jHvNbHBWqrj7/1pfpBB1c83AkvAzr0Te4V0JoHAMc4aRLtOaycEd03nVj9S71uNsuZhObXobW667DVmxyk2TTGJi34Awd0CV8U8jRXRf+wsUT4cMq+snNSspZb5Zz5lzyS6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727245366; c=relaxed/simple;
	bh=DI93RTVhxJCMcF7fWRY0x9wSn19y2TQtXcBi/Dp2FVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+piaS9HQQzK9mwe4H18bwBAo9Wbgxn5rhC379uEY0kXn9x+C+FohU66luByihHq3mZVOQyhijq/yJPJ6ADlU4gOhUxXVNd+sKR0lrZnR13pRUZA5gPjuB+LJPKpk9mrzKptI7QPT6Ah3J0Mik40ItV9+Qe5zDrNzN/sF4QKPlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxCzIibe; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-846d741dfdbso1513701241.0;
        Tue, 24 Sep 2024 23:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727245363; x=1727850163; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k7veGukCa0lref55ONxo5SP6cYT+orCQe+FfCxTaJJo=;
        b=CxCzIibeRql247HrbYaaFr3uCRAWSi5pzDcYYT2LrEBMQIuMlev+xyfkp6263Cou47
         CAknpzm5BuH8lvFAOGRGD4h0BfMmQjWb6qoS07vqufVgd1R4LYC65ZmZbuvJoZqEfOoY
         GLbFizblQ9J6X+RJfRAjDhzwSiZGcjNoFLxjg+QsCFt3vARqqbY7BwE6N1dTZWEMaYnL
         4FChhJ99jwcq5Qr2EHq6tTAvr/tpx6w/gls+bNk/Z7qVE59nbXyOv/9pUkmQFoYXnS94
         C3s0ZZlb5bt1lVb8bZ6F8pAe++BBiDc725h7tnWATsKHbxjFvomuO7HdP4WJkqBKNMCY
         imfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727245363; x=1727850163;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k7veGukCa0lref55ONxo5SP6cYT+orCQe+FfCxTaJJo=;
        b=jQ7itpAqEW/EsOyrqWSpUKDLm+y21rtXbPeSgJW0QyPf3CUmgR0KdXiD+le1SD2lzU
         ++q9N/EDNZjQo1Mo9v23oqWor8G7unoaefxNNy8QHKKCcGNw9IfuHFN6OVps5tesE1/s
         pBNmAGSAz+WbOSqmN3uWSo/9aaj2TJzI80dOswupEXV/ugTqNQkGjafwY2LCwSGfWqzJ
         6X5Y6nqIsP9CMwiOMt/iIsrkZSKj+gBd7jEmctMLOzO9105rUHDMg/h6DcbalCbWeb3d
         sDY1SDdXB7fB+UJ0njljWZt5iHv8Ltalmx3oMgS7SEamLQLTBFx78GHLC6ytBjlw0hdB
         /Tfw==
X-Forwarded-Encrypted: i=1; AJvYcCUn3Tea1TdL89h8t8s2pwMpmcRshLot8Yd50jD+q16YMr3y2TbNaxnU8bZZKe5dZTJFnca4n5Yb1Jthzt4=@vger.kernel.org, AJvYcCXFSsoYxXpl2WV5/DvjLSrJFFOIQcV1DdrZVkDv1Qd5/98qP68QcBfpRjZRG/CBFvwoWxsqc+QN@vger.kernel.org
X-Gm-Message-State: AOJu0YzyE+V/EanQw6uVSPXsJGPyT1A50Sdx1/aCMd4sjnsfayc/HaPg
	3tgHfi5NdksxIKeJDjcPZC29GSwN4LPsVueeMo6ownVOItdvt1ERhPztuH1YlECTM1wOf3CT/MJ
	1bJxfnIOw66EORtu+J0Yd86r8Olk=
X-Google-Smtp-Source: AGHT+IHtcJ83ClreK41Jty65h5eL9wFd7SBneiV1e84OYQqEbdmuy6WR2s5jBNjPdT1ChQhwWR+0B7Rr9JWmdl2CxXc=
X-Received: by 2002:a05:6122:1d4d:b0:503:e775:ad50 with SMTP id
 71dfb90a1353d-505c2070295mr1418042e0c.8.1727245363245; Tue, 24 Sep 2024
 23:22:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923113135.4366-1-kdipendra88@gmail.com> <20240924071026.GB4029621@kernel.org>
 <CAEKBCKPw=uwN+MCLenOe6ZkLBYiwSg35eQ_rk_YeNBMOuqvVOw@mail.gmail.com>
 <20240924155812.GR4029621@kernel.org> <CAEKBCKO45g4kLm-YPZHpbcS5AMUaqo6JHoDxo8QobaP_kxQn=w@mail.gmail.com>
 <20240924181458.GT4029621@kernel.org>
In-Reply-To: <20240924181458.GT4029621@kernel.org>
From: Dipendra Khadka <kdipendra88@gmail.com>
Date: Wed, 25 Sep 2024 12:07:32 +0545
Message-ID: <CAEKBCKPz=gsLbUWNDinVVHD8t760jW+wt1GtFgJW_5cHCj0XbQ@mail.gmail.com>
Subject: Re: [PATCH net] net: ethernet: marvell: octeontx2: nic: Add error
 pointer check in otx2_ethtool.c
To: Simon Horman <horms@kernel.org>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com, 
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Sept 2024 at 00:00, Simon Horman <horms@kernel.org> wrote:
>
> On Tue, Sep 24, 2024 at 11:42:58PM +0545, Dipendra Khadka wrote:
> > Hi Simon,
> >
> > On Tue, 24 Sept 2024 at 21:43, Simon Horman <horms@kernel.org> wrote:
> > >
> > > On Tue, Sep 24, 2024 at 08:39:47PM +0545, Dipendra Khadka wrote:
> > > > Hi Simon,
> > > >
> > > > On Tue, 24 Sept 2024 at 12:55, Simon Horman <horms@kernel.org> wrote:
> > > > >
> > > > > On Mon, Sep 23, 2024 at 11:31:34AM +0000, Dipendra Khadka wrote:
> > > > > > Add error pointer check after calling otx2_mbox_get_rsp().
> > > > > >
> > > > >
> > > > > Hi Dipendra,
> > > > >
> > > > > Please add a fixes tag here (no blank line between it and your
> > > > > Signed-off-by line).
> > > > > > Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
> > > > >
> > > > > As you have posted more than one patch for this driver, with very similar,
> > > > > not overly complex or verbose changes, it might make sense to combine them
> > > > > into a single patch. Or, if not, to bundle them up into a patch-set with a
> > > > > cover letter.
> > > > >
> > > > > Regarding the patch subject, looking at git history, I think
> > > > > an appropriate prefix would be 'octeontx2-pf:'. I would go for
> > > > > something like this:
> > > > >
> > > > >   Subject: [PATCH net v2] octeontx2-pf: handle otx2_mbox_get_rsp errors
> > > > >
> > > >
> > > > If I bundle all the patches for the
> > > > drivers/net/ethernet/marvell/octeontx2/ , will this subject without v2
> > > > work? Or do I need to change anything? I don't know how to send the
> > > > patch-set with the cover letter.
> > >
> > > Given that one of the patches is already at v2, probably v3 is best.
> > >
> > > If you use b4, it should send a cover letter if the series has more than 1
> > > patch.  You can use various options to b4 prep to set the prefix
> > > (net-next), version, and edit the cover (letter).  And you can use various
> > > options to b4 send, such as -d, to test your submission before sending it
> > > to the netdev ML.
> > >
> >
> > I did not get this -d and testing? testing in net-next and sending to net?
>
> I meant that b4 prep -d allows you to see the emails that would be sent
> without actually sending them. I find this quite useful myself.
>
> >
> > > Alternatively the following command will output 3 files: a cover letter and
> > > a file for each of two patches, with v3 and net-next in the subject of each
> > > file. You can edit these files and send them using git send-email.
> > >
> > > git format-patch --cover-letter -2 -v3 --subject-prefix="PATCH net-next"
> > >
> >
> > Should I send it to net-next or net?
>
> Sorry for the confusion. I wrote net-next in my example,
> but I think this patch-set would be for net.
>
> ...

Thank you Simon for everything.

Best regards,
Dipendra

