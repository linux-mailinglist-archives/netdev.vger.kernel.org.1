Return-Path: <netdev+bounces-129337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A7597EED0
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 18:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12561F21E01
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 16:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B64E197A8A;
	Mon, 23 Sep 2024 16:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwcLY7GS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E362414A8B;
	Mon, 23 Sep 2024 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107430; cv=none; b=e3mvHCSn3Sgj3w3TU7OyjIETu6nYHp7RdY6fpZ/dZR2RPTyBsQeigsjrH8aKQxV7QZU4Xm8i9AApdsl/mPYq0nTYCI/RQpvVLU86onwwfKmHg6YCR1n6E06NDmXMgQoc9mQFeMae6zi4v3aSWzHWWdguYrpGZYO4aGS44/qyBwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107430; c=relaxed/simple;
	bh=0kHEyi2ZGEOA/tHEaHIEHpV8oGG14Toudm8/ViSl+o0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VxcLXO70GvyKLZ9vwGLGT0y3Zqr1eh0TE3mAT1dDJyPi5XDZdEPW5/ooLQd7TC7iJHw6JX43TLEy7mn9j7m5HJ+pI2rB4PKeaMLwD2K1rlt/RQISq9LrA/Y3xqOiQ8xTDevw2fRar+CG6RWUuE3TBQ8qLHgkAHdYOecyGjWVv+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwcLY7GS; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e0438e81aaso2900646b6e.3;
        Mon, 23 Sep 2024 09:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727107428; x=1727712228; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qwM6eC4sLjhYhEAwIQsQENiXdX+y3qdjIMbxEplszAM=;
        b=QwcLY7GSlG1n9e6UPhCoAVG1KCNTVtfDh2jj1ZTgFbaADD2z1PpWDFzv/+XOZ3M2cA
         06vnS/qpHwHynOcEbaGRrZjZx0hAHGZdJA0CPSIOJ3sHoit2Q1bCM4U8P4AyVApqCl9R
         WSvkY/tJrdgnjkfXAw+GGzFXjGSC912AP46QEc8jlbtxGB7VFc3emX26yv5CSQty5QrM
         0L7NehdbhQCvEgNUdfZPwXKNtayjYEkhrC5r3QyPDYIBDZOGBOYYoRp2YWoeTLt2q2dE
         atJUMwW6jPG/hnlfIHbyZwJ6dNqj8wa4V/yND2WxPEvrcTnl4WLKRkBTaR5/Ekk12Bph
         PX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727107428; x=1727712228;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qwM6eC4sLjhYhEAwIQsQENiXdX+y3qdjIMbxEplszAM=;
        b=Oh/Qq8KPUww1FOfPvvmGTTkXIl08GrTZ2RwzCqPQG5177WXfJ6BZnm2g/5zF9Ra4tJ
         huwt8xZyv7kG6+TGOg3VabMRXz4CyCtxUxANQ5LehyyJG+u1vJ0DKhgX7wCNNywncGy8
         1SWXKIcbLIOEM8++Ql6P0Wu6fQlR0EEDKpqNY1LImA5zwuKwREk86yiy0l5NuqWhg9Co
         ZR82sMY3RHSrKLzt2YmmQSrqrmzCfLK97L3zphyooYMavDrQ25VqfT090Lt3jdZfKfCb
         lGvQqCmeGhb7mKUqq2w4CnlCzhk39GaFwATS2XxcgNL5MDErYJPleB/J5Z56Ufm9ohno
         me/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV0o9w8U/9ihBUkU+1J7cRFIaeynrqSbpTP3fOdQUsytjrkInhlG8AmbvZHYWhYxPWY7RIgR9nE@vger.kernel.org, AJvYcCVKxQV7V+fYY864g7IXWK9XoVnHABXW2HmswqRQ/yK7f68+19hpRtU9rsSbPeRH4lPYsXGNTsl+lS1KbEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5VX65FkB4K9zu6gnygeJ3AmGYEySW0f33/KHnYR4D2QjXf8j9
	FV9JsvZtnZmlYyuQ0+F0+mUxpA8BUywY17S7QSTpTDIbqvlJtjKWXvmP6wKtacNDxd/3xxZfEYX
	486+7ebSaZYKs/7HicwkVQbwCdZc=
X-Google-Smtp-Source: AGHT+IH0eia4TG5YFkTqiUJZM/G12PDMt7N8RHsl7xl79Qev4iLIhhMPHr35Bf3JR8VtfSwI35qwwNjsUqCBHXYXA5k=
X-Received: by 2002:a05:6358:2926:b0:1ad:282:ab1f with SMTP id
 e5c5f4694b2df-1bc975dc5bdmr312659855d.7.1727107427978; Mon, 23 Sep 2024
 09:03:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922185235.50413-1-kdipendra88@gmail.com> <20240923155606.GJ3426578@kernel.org>
In-Reply-To: <20240923155606.GJ3426578@kernel.org>
From: Dipendra Khadka <kdipendra88@gmail.com>
Date: Mon, 23 Sep 2024 21:48:36 +0545
Message-ID: <CAEKBCKOYi6TuDdDf0GV+aKtiKSgjckEFhdpsywk175MqMgz7ww@mail.gmail.com>
Subject: Re: [PATCH] Staging: net: nic: Add error pointer check in otx2_flows.c
To: Simon Horman <horms@kernel.org>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com, 
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Thank you for the response.I had already sent the v2 patch. I will
send v3 addressing all the issues.

On Mon, 23 Sept 2024 at 21:41, Simon Horman <horms@kernel.org> wrote:
>
> On Sun, Sep 22, 2024 at 06:52:35PM +0000, Dipendra Khadka wrote:
> > Smatch reported following:
> > '''
> > drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c:123 otx2_alloc_mcam_entries() error: 'rsp' dereferencing possible ERR_PTR()
> > drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c:201 otx2_mcam_entry_init() error: 'rsp' dereferencing possible ERR_PTR()
> > drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c:236 otx2_mcam_entry_init() error: 'frsp' dereferencing possible ERR_PTR()
> > '''
> >
> > Adding error pointer check after calling otx2_mbox_get_rsp.
> >
> > Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
>
> Hi Dipendra,
>
> As noted by Andrew Lunn in relation to another patch [1],
> this driver isn't in Staging so the subject is not correct.
> And moreover, as Andrew suggested, please take a look at [2].
>
> [1] https://lore.kernel.org/all/13fbb6c3-661f-477a-b33b-99303cd11622@lunn.ch/
> [2] https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>

> > ---
> >  .../ethernet/marvell/octeontx2/nic/otx2_flows.c   | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> > index 98c31a16c70b..4b61236c7c41 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_flows.c
> > @@ -120,6 +120,11 @@ int otx2_alloc_mcam_entries(struct otx2_nic *pfvf, u16 count)
> >               rsp = (struct npc_mcam_alloc_entry_rsp *)otx2_mbox_get_rsp
> >                       (&pfvf->mbox.mbox, 0, &req->hdr);
>
> nit: No blank line here please.
>      Similarly in the other hunks of this patch.
>
> >
> > +             if (IS_ERR(rsp)) {
> > +                     mutex_unlock(&bfvf->mbox.lock);
>
> This doesn't compile as bfvf doesn't exit in this context.
>
> > +                     return PTR_ERR(rsp);
>
> Looking at error handling elsewhere in the same loop, perhaps this
> is appropriate instead of returning.
>
>                         goto exit;
>
> > +             }
> > +
> >               for (ent = 0; ent < rsp->count; ent++)
> >                       flow_cfg->flow_ent[ent + allocated] = rsp->entry_list[ent];
> >
>
> ...

Best Regards,
Dipendra

