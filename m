Return-Path: <netdev+bounces-129562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A782984813
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 16:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A99AAB213D2
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 14:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D221AAE2F;
	Tue, 24 Sep 2024 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3uj620j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634501AAE13;
	Tue, 24 Sep 2024 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727189702; cv=none; b=rjjhcJBGJLtwlRktOt9TYWvXOua2kUiXZW5kqS8ij9MkfkBchzg7WJdAvB/yRaBRItJURFZAlpIj3Fb/v/6pQBE/7nnNBLg2fmnoD68uzAp6z7XFAoBmH8+S23EmgwyVc5aAWdI9NetIEOYivfXnFsq1MlvWMj7ad0hEsW6hsag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727189702; c=relaxed/simple;
	bh=1sduO03urr59Qi4dBbushooe5wvxEuzK+cxIfuoq6o4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eRCgmGeJ0VgNkOOGWk/+eQbOf8StcKLlmBbXMqGK93042otNVfYpatVH/y3hDXK5L4wa9iilnu4q5NEhxjEx1kK1puDPOzGy1M777W4UNJFYmHXetTygQgla+CMcLSUWAeUdAAeHe7QnXGgckJ+j/b4TbB4uLLkbDJbHVbplCEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3uj620j; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-84e8028c47eso11828241.0;
        Tue, 24 Sep 2024 07:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727189699; x=1727794499; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PwWYYT9Q/cZvoSGqhJBMfjUwdvULWxIyVQqI4LWjq0s=;
        b=X3uj620j181Qf6KkoPjyCW3DZt8RFE2kUp6pbQBgJFLO8oIRRP2yo9/dJ69ufjjk7h
         ULu3jtKkKkLYSesUlrnvTRUSDa0vjv/Vhy0t6R1+fsaNwrt9EMFyY7/PnIPRQKpy8VQ5
         ji3UP9IQwYBG++Mm1zWLx6DleUWrRK5/bf8+pvcU0s7JDlMkv/2tncGHn4np70UlzSx6
         dgEav1HAlMwmChjm+K7OmTNb0aI/vUN8eC94wc6QtTPTPWF/wFntFMnwq/M5dNIzH/9v
         NU6C4uMl7bGDx0rkOHzucABY4KMSxX3kibX81cGvfEOOuY71nlHAuWeadX76n/Vns80s
         dnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727189699; x=1727794499;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PwWYYT9Q/cZvoSGqhJBMfjUwdvULWxIyVQqI4LWjq0s=;
        b=c0LEJr8NxrCql90gDNF7yDjI18chUpMmB/0s2CA4LD8g1em/Qo5fthcAXnh5YRWdxO
         fL6Vl44kr2vFUwW4dWJ0tCx5HshLTK6X6865+neq5mSJtrezHt8hb+dm2CCE6NtZCjXJ
         Oqk4Weqqu9z4kjhQABrgVTUF3bvBwm5BPRvIy9wB3AABOdHftJmyqgvhYdYFKaZ3Kezq
         JR3OUPAFbs7aSInySScp2I/Ud3a7SIbtobBGUToMWii1ndwR4IfzhdX3N2SHBThV83XM
         Zr08XFuEvwMQr3ZPg+zCmReFo24pBTch49X/DdVEPx2pMfOhqj0pToVWY3n6qLoPKduo
         OxYA==
X-Forwarded-Encrypted: i=1; AJvYcCUyhPaM1Qff7ZKMv/zDgY+VkeyHCl6IVzzRSa+OZzf0/y4HyDqtzOGqE+J0Ucx2OPUq0buQVNIE@vger.kernel.org, AJvYcCW7kKfSwlStQ38cq7UXOs1iY1kNbD/Jop4G6wLHukuN9yCeD2NxuXYV7s5/Cb3VEEeg4iPcGWF4ZAbgjbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTxjTmkinMIJnw26D4mJY0dOI/ZdTXQw2yhIGxE2IDJhlh/4hV
	mJH315W6YmL+tQ9hCTXuXJprP8M5lpWuPeOnZujfXFUxTacsI34VnPUx/V5Lqr2izg4STMtqH7P
	Mh5pAOgl1iYgfG8XbOLONwDF2ycI=
X-Google-Smtp-Source: AGHT+IGp2WnKifFn498aaSlEvNDjRDXiBaKVYshHt0U4VHY/6ABsUsx864I5sdsS5B5MWGauWZDHrj/ARvcN9RZhMDU=
X-Received: by 2002:a05:6122:3c89:b0:4fc:eb15:b0f6 with SMTP id
 71dfb90a1353d-503e04b6397mr9904680e0c.8.1727189699122; Tue, 24 Sep 2024
 07:54:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923113135.4366-1-kdipendra88@gmail.com> <20240924071026.GB4029621@kernel.org>
In-Reply-To: <20240924071026.GB4029621@kernel.org>
From: Dipendra Khadka <kdipendra88@gmail.com>
Date: Tue, 24 Sep 2024 20:39:47 +0545
Message-ID: <CAEKBCKPw=uwN+MCLenOe6ZkLBYiwSg35eQ_rk_YeNBMOuqvVOw@mail.gmail.com>
Subject: Re: [PATCH net] net: ethernet: marvell: octeontx2: nic: Add error
 pointer check in otx2_ethtool.c
To: Simon Horman <horms@kernel.org>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com, 
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Simon,

On Tue, 24 Sept 2024 at 12:55, Simon Horman <horms@kernel.org> wrote:
>
> On Mon, Sep 23, 2024 at 11:31:34AM +0000, Dipendra Khadka wrote:
> > Add error pointer check after calling otx2_mbox_get_rsp().
> >
>
> Hi Dipendra,
>
> Please add a fixes tag here (no blank line between it and your
> Signed-off-by line).
> > Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
>
> As you have posted more than one patch for this driver, with very similar,
> not overly complex or verbose changes, it might make sense to combine them
> into a single patch. Or, if not, to bundle them up into a patch-set with a
> cover letter.
>
> Regarding the patch subject, looking at git history, I think
> an appropriate prefix would be 'octeontx2-pf:'. I would go for
> something like this:
>
>   Subject: [PATCH net v2] octeontx2-pf: handle otx2_mbox_get_rsp errors
>

If I bundle all the patches for the
drivers/net/ethernet/marvell/octeontx2/ , will this subject without v2
work? Or do I need to change anything? I don't know how to send the
patch-set with the cover letter.

> As for the code changes themselves, module the nits below, I agree the
> error handling is consistent with that elsewhere in the same functions, and
> is correct.
>
> > ---
> >  .../ethernet/marvell/octeontx2/nic/otx2_ethtool.c    | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> > index 0db62eb0dab3..36a08303752f 100644
> > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c
> > @@ -343,6 +343,12 @@ static void otx2_get_pauseparam(struct net_device *netdev,
> >       if (!otx2_sync_mbox_msg(&pfvf->mbox)) {
> >               rsp = (struct cgx_pause_frm_cfg *)
> >                      otx2_mbox_get_rsp(&pfvf->mbox.mbox, 0, &req->hdr);
> > +
>
> nit: No blank line here.
>
> > +             if (IS_ERR(rsp)) {
> > +                     mutex_unlock(&pfvf->mbox.lock);
> > +                     return;
> > +             }
> > +

If the above blank line after the check is ok or do I have to remove
this as well?

> >               pause->rx_pause = rsp->rx_pause;
> >               pause->tx_pause = rsp->tx_pause;
> >       }
> > @@ -1074,6 +1080,12 @@ static int otx2_set_fecparam(struct net_device *netdev,
> >
> >       rsp = (struct fec_mode *)otx2_mbox_get_rsp(&pfvf->mbox.mbox,
> >                                                  0, &req->hdr);
> > +
>
> Ditto.
>
> > +     if (IS_ERR(rsp)) {
> > +             err = PTR_ERR(rsp);
> > +             goto end;
> > +     }
> > +
> >       if (rsp->fec >= 0)
> >               pfvf->linfo.fec = rsp->fec;
> >       else
>
> --
> pw-bot: changes-requested

Best regards,
Dipendra Khadka

