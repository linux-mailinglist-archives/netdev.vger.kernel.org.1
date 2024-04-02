Return-Path: <netdev+bounces-84165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BCA895D85
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 22:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60C0A1F22CBD
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 20:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0508115D5D5;
	Tue,  2 Apr 2024 20:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcDPxNI4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7821E15D5B3
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 20:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712089532; cv=none; b=KwLv5PYeeGHuJ45eDTS2obmkCz4SIfSf8YDilwOJRY0QGDVeUvNEYHVaya80vc8zhhBFoYdwP512M0in/o3MXOBwoK6M0nyx6LnW1cW6dXhsqRIS5EADT1M2QISbCIYrbsRvkI4sc7haHcs5SyEQhkRCDUSw34C9xErjZuqr9Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712089532; c=relaxed/simple;
	bh=Ju9jET8eBe9jgdDFaMRbN2AKk4OovlxEj3nYzgHIOBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brluotoveqlQCg9DrpC+SXJSU1lvmghQ2ePm+RBSZgnvBEp07R++wpfrUAv5h0U7/8vw1Sn4vJJtNqXkuBrINDXffRejSxOvz4h30HIkOEez5fZj9l50tKNUDMN4jsdzMybCRMH/EzWFPRBAU6tT7q7TC83RcJUutNAxh+N0zsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcDPxNI4; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-53fa455cd94so4176177a12.2
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 13:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712089530; x=1712694330; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qzQQHoJQ11iL4ZRq1RRJUHfxyNKqnhQT5F/85QjSLyE=;
        b=LcDPxNI4/Rn4NpiNj8nFBowNpkVQJYLG0RYnfC2599V5KBwD6/VgsAlAdtJDklKuRN
         Gvc6Eg5eO8qbhL7bRh+aJgY7h0Z9F/khFqtGH7/JW7INxd8BEpZnZmFWOdb2L2qNMkMe
         R8qwcSTAS4p8luq5F+5sMVNHL7hpvgQ+3llBnMkNWnrKsHoLSL9g44lm2NZTXkr782ny
         9qZNDOPs8qiqkarO3yk3/U6HKwqJB0oh00DTjEPc0xoc+Q6WeC2bSqbQziatJJh0Q42Z
         lCtDi02n4xLNwyi8XEiMQqKfocZov4+O1qZSRGh487XC4eEuz7yCcRKdY+GWU4Y8s9XY
         7Aiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712089530; x=1712694330;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qzQQHoJQ11iL4ZRq1RRJUHfxyNKqnhQT5F/85QjSLyE=;
        b=MStYGJomcHx2ZKgbnJ3LB56Z7Pff6aB2V0mQOImCwNKqBOCSyz8DhSm5rdu/jGh3XI
         C3v08vMjzQ/sDoOwKrXs8Cl08l1/bBUYijrP4A2aRrfzI1HDJ164M9hjWAxzFgdr39bn
         3llNGtE7CByR5WJAKlao+ywKKCuPp5Ikbk0QfkxSPMLN/Q1uFH3vdVK655Zlgawljof7
         CyWUnkrcTDcGd2FssFoQWm1IAOrbhJxP3eJ7rDZZQ6aQTNtYwtAvCYeFYR7K6rcCVGsk
         7Y1vxOCEmVyM3tjwvAgVx6s8v0Jzy6/zXgh2m0FaH8WC1YM4cBHc+uqFoX9xfkUqfb93
         gX5g==
X-Gm-Message-State: AOJu0YzdfLQkWd94qi6wmw3v0SAjtq3zy0LhyarCV3mlxBa6MsnBcAQ+
	GESr1OEQQMQmtPLcBg/xqpTnuW9VOr8k7iEGsPkJK60UIFbhEb35iZf8JfrDgP6GMlVghy+GoLR
	llj7aXJW6rxtQIKcJFdF26km94fQ=
X-Google-Smtp-Source: AGHT+IGngoKDuzCxvM9UepNkHp+ktQwyY9hfan6KLWWtdcJSgo7qrvIRP29btItHDsGC+UTo303GrDgOttbuu2r8lCQ=
X-Received: by 2002:a17:90a:db49:b0:29f:c827:bc8c with SMTP id
 u9-20020a17090adb4900b0029fc827bc8cmr11617961pjx.18.1712089529894; Tue, 02
 Apr 2024 13:25:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171154167446.2671062.9127105384591237363.stgit@firesoul>
 <CALUcmU=xOR1j9Asdv0Ny7x=o4Ckz80mDjbuEnJC0Z_Aepu0Zzw@mail.gmail.com> <CALUcmUkvpnq+CKSCn=cuAfxXOGU22fkBx4QD4u2nZYGM16DD6A@mail.gmail.com>
In-Reply-To: <CALUcmUkvpnq+CKSCn=cuAfxXOGU22fkBx4QD4u2nZYGM16DD6A@mail.gmail.com>
From: Arthur Borsboom <arthurborsboom@gmail.com>
Date: Tue, 2 Apr 2024 22:25:13 +0200
Message-ID: <CALUcmUn0__izGAS-8gDL2h2Ceg9mdkFnLmdOgvAfO7sqxXK1-Q@mail.gmail.com>
Subject: Re: [PATCH net] xen-netfront: Add missing skb_mark_for_recycle
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, wei.liu@kernel.org, 
	paul@xen.org, Jakub Kicinski <kuba@kernel.org>, kirjanov@gmail.com, dkirjanov@suse.de, 
	kernel-team@cloudflare.com, security@xenproject.org, 
	andrew.cooper3@citrix.com, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"

After having a better look, I have found the patch in linux-next

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=0cd74ffcf4fb0536718241d59d2c124578624d83

On Tue, 2 Apr 2024 at 10:20, Arthur Borsboom <arthurborsboom@gmail.com> wrote:
>
> On Fri, 29 Mar 2024 at 10:47, Arthur Borsboom <arthurborsboom@gmail.com> wrote:
> >
> > On Wed, 27 Mar 2024 at 13:15, Jesper Dangaard Brouer <hawk@kernel.org> wrote:
> > >
> > > Notice that skb_mark_for_recycle() is introduced later than fixes tag in
> > > 6a5bcd84e886 ("page_pool: Allow drivers to hint on SKB recycling").
> > >
> > > It is believed that fixes tag were missing a call to page_pool_release_page()
> > > between v5.9 to v5.14, after which is should have used skb_mark_for_recycle().
> > > Since v6.6 the call page_pool_release_page() were removed (in 535b9c61bdef
> > > ("net: page_pool: hide page_pool_release_page()") and remaining callers
> > > converted (in commit 6bfef2ec0172 ("Merge branch
> > > 'net-page_pool-remove-page_pool_release_page'")).
> > >
> > > This leak became visible in v6.8 via commit dba1b8a7ab68 ("mm/page_pool: catch
> > > page_pool memory leaks").
> > >
> > > Fixes: 6c5aa6fc4def ("xen networking: add basic XDP support for xen-netfront")
> > > Reported-by: Arthur Borsboom <arthurborsboom@gmail.com>
> > > Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> > > ---
> > > Compile tested only, can someone please test this
> >
> > I have tested this patch on Xen 4.18.1 with VM (Arch Linux) kernel 6.9.0-rc1.
> >
> > Without the patch there are many trace traces and cloning the Linux
> > mainline git repository resulted in failures (same with kernel 6.8.1).
> > The patched kernel 6.9.0-rc1 performs as expected; cloning the git
> > repository was successful and no kernel traces observed.
> > Hereby my tested by:
> >
> > Tested-by: Arthur Borsboom <arthurborsboom@gmail.com>
> >
> >
> >
> > >  drivers/net/xen-netfront.c |    1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
> > > index ad29f370034e..8d2aee88526c 100644
> > > --- a/drivers/net/xen-netfront.c
> > > +++ b/drivers/net/xen-netfront.c
> > > @@ -285,6 +285,7 @@ static struct sk_buff *xennet_alloc_one_rx_buffer(struct netfront_queue *queue)
> > >                 return NULL;
> > >         }
> > >         skb_add_rx_frag(skb, 0, page, 0, 0, PAGE_SIZE);
> > > +       skb_mark_for_recycle(skb);
> > >
> > >         /* Align ip header to a 16 bytes boundary */
> > >         skb_reserve(skb, NET_IP_ALIGN);
> > >
> > >
>
> I don't see this patch yet in linux-next.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log
>
> Any idea in which kernel release this patch will be included?

