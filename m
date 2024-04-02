Return-Path: <netdev+bounces-83909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF7C894D58
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 10:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0517B2260F
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 08:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7303D96D;
	Tue,  2 Apr 2024 08:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fcoh1Iai"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB1F3D57A
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 08:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712046053; cv=none; b=uft7jVFlGkvnfbhu3u3nfj/5K2WaIs/VEx9NbMW0tlzEFUW0MvOx93VBHl8VjLO1AV4Q0UdZstwQiTYnkWpsrzfdqtUqmAn2+OrZZ72esukICdZ0cVrSm81V9QtLTLPSTQubKFq8l+LNQwDB6u9iraxjGHFrOggNT/i926Dsgo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712046053; c=relaxed/simple;
	bh=8nmFvPWj2VmRdRDKglF6WaM6wPFKqBMJEckD9LUyWD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHA+7k1HmL2gCePVp58gqYjqr/ov/IP25uW7jRgegwRvKIfWxevLIR0OwzOEP+FVnGwBPTOZTJTlXQCsfoXO4bODz/HgN7YYcPE2dGLNJUpMDNHZT5WVOK1dhFYhv2+Eqv0z30+o/ubJ+cnArerRjmhgfl/3d1TzgkQZehrFW8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fcoh1Iai; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-29f69710cbbso3278322a91.1
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 01:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712046051; x=1712650851; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MtgDNy5Ok/k3AgC4/N+aLWeQ5ZduvA0x4teM9jNjSvQ=;
        b=Fcoh1Iai4yP9O5O7/E0hiw4UXy6wu8lHav4kM9qzvi6Nr6boO4SL0aVaZOZj9+o+K9
         dX41JtfWkoep0G/oYPPEjrUROhEy9lxwv8NX2Wbk81ys26LxP+bqgGB4WbvvhrySUa0N
         6pm7q+We2dl/RI5B1ILcm1ZXj+WMAkO6ehU5GzI8VsFkUF9Pd5c/BMsOKJjDiZH+46+V
         8wQWm/cOhbRBTDxYy0UxMKbshr7EI+Nqi/rbwaBCYivrw04xlrYKyN3tBjGtMBJnXwML
         bdM5gOwMYjyeQHedfwlo3Q2xNXDx0GFefcDFpUsSvrNy/mkDliDA11EaSVUOWcZZePna
         eVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712046051; x=1712650851;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MtgDNy5Ok/k3AgC4/N+aLWeQ5ZduvA0x4teM9jNjSvQ=;
        b=E2h+yZHdePbV/E2TH7px1iOzdUlwB9cH1F4V5n1eHBapugqD4JH1DHpKuFWXwpUZwZ
         GmFXHH+YpKURsMR9ATL0ASI86Ks2xYZvxt2IBz40wP1xwDLjW3Y00H5tTrbda7Ahs2CA
         5q+rJGhqe8KESCc1ygJS8rRWgYtmpU+vXjTJroKxpoxtWJCgbzRVko7tuAEirRAHZxQS
         6VEWxOZJRebEuQeftUMQu0Cub3Nddb1N5Gd6/cADwt1P2VOSh4SVaf3RUI9WA/QYSEGg
         Hgf2FZFoZnHSBRhO5CVpqSk0LDYBwp3XZpTU+VckKcaDB/cteaPx9o4cXDXghoVx9rEL
         o2MA==
X-Gm-Message-State: AOJu0YxtuCCT6V0onqV81D1t4caMtchbj7KK+0iOBspnpQ7n9kZtyN4t
	EgwdlVKGIb4dgQNN8dv94wbuvNIjTH1Rjcc7sxYQZXQBNxdmfwTjxs0/3actVTp+88VdWRcO8gc
	KRo/rUgQjWLdU2Yd4fU/6QPmkj5Y=
X-Google-Smtp-Source: AGHT+IFWlqMVFBoKcV6hseAJUnZ6M3BBB/Kala7LFFLA8XcpKQEImuTrHalGIK62Lr2CNcY1VdHtmKAyvR0PSWNN5kQ=
X-Received: by 2002:a17:90a:974b:b0:2a2:20d8:2110 with SMTP id
 i11-20020a17090a974b00b002a220d82110mr14057235pjw.8.1712046051136; Tue, 02
 Apr 2024 01:20:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171154167446.2671062.9127105384591237363.stgit@firesoul> <CALUcmU=xOR1j9Asdv0Ny7x=o4Ckz80mDjbuEnJC0Z_Aepu0Zzw@mail.gmail.com>
In-Reply-To: <CALUcmU=xOR1j9Asdv0Ny7x=o4Ckz80mDjbuEnJC0Z_Aepu0Zzw@mail.gmail.com>
From: Arthur Borsboom <arthurborsboom@gmail.com>
Date: Tue, 2 Apr 2024 10:20:35 +0200
Message-ID: <CALUcmUkvpnq+CKSCn=cuAfxXOGU22fkBx4QD4u2nZYGM16DD6A@mail.gmail.com>
Subject: Re: [PATCH net] xen-netfront: Add missing skb_mark_for_recycle
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, wei.liu@kernel.org, 
	paul@xen.org, Jakub Kicinski <kuba@kernel.org>, kirjanov@gmail.com, dkirjanov@suse.de, 
	kernel-team@cloudflare.com, security@xenproject.org, 
	andrew.cooper3@citrix.com, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Mar 2024 at 10:47, Arthur Borsboom <arthurborsboom@gmail.com> wrote:
>
> On Wed, 27 Mar 2024 at 13:15, Jesper Dangaard Brouer <hawk@kernel.org> wrote:
> >
> > Notice that skb_mark_for_recycle() is introduced later than fixes tag in
> > 6a5bcd84e886 ("page_pool: Allow drivers to hint on SKB recycling").
> >
> > It is believed that fixes tag were missing a call to page_pool_release_page()
> > between v5.9 to v5.14, after which is should have used skb_mark_for_recycle().
> > Since v6.6 the call page_pool_release_page() were removed (in 535b9c61bdef
> > ("net: page_pool: hide page_pool_release_page()") and remaining callers
> > converted (in commit 6bfef2ec0172 ("Merge branch
> > 'net-page_pool-remove-page_pool_release_page'")).
> >
> > This leak became visible in v6.8 via commit dba1b8a7ab68 ("mm/page_pool: catch
> > page_pool memory leaks").
> >
> > Fixes: 6c5aa6fc4def ("xen networking: add basic XDP support for xen-netfront")
> > Reported-by: Arthur Borsboom <arthurborsboom@gmail.com>
> > Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> > ---
> > Compile tested only, can someone please test this
>
> I have tested this patch on Xen 4.18.1 with VM (Arch Linux) kernel 6.9.0-rc1.
>
> Without the patch there are many trace traces and cloning the Linux
> mainline git repository resulted in failures (same with kernel 6.8.1).
> The patched kernel 6.9.0-rc1 performs as expected; cloning the git
> repository was successful and no kernel traces observed.
> Hereby my tested by:
>
> Tested-by: Arthur Borsboom <arthurborsboom@gmail.com>
>
>
>
> >  drivers/net/xen-netfront.c |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
> > index ad29f370034e..8d2aee88526c 100644
> > --- a/drivers/net/xen-netfront.c
> > +++ b/drivers/net/xen-netfront.c
> > @@ -285,6 +285,7 @@ static struct sk_buff *xennet_alloc_one_rx_buffer(struct netfront_queue *queue)
> >                 return NULL;
> >         }
> >         skb_add_rx_frag(skb, 0, page, 0, 0, PAGE_SIZE);
> > +       skb_mark_for_recycle(skb);
> >
> >         /* Align ip header to a 16 bytes boundary */
> >         skb_reserve(skb, NET_IP_ALIGN);
> >
> >

I don't see this patch yet in linux-next.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log

Any idea in which kernel release this patch will be included?

