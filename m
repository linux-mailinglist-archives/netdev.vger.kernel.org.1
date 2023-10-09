Return-Path: <netdev+bounces-39250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5537BE7AD
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 19:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF47D1C208E9
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BD33714F;
	Mon,  9 Oct 2023 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NhP0W0dX"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF17134BE
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 17:21:32 +0000 (UTC)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFF49E
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 10:21:31 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-578d0d94986so3490027a12.2
        for <netdev@vger.kernel.org>; Mon, 09 Oct 2023 10:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696872091; x=1697476891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UvG29kjnBvm/h/aaY9yR0PuKwn+9CpzwBm6a6KnjkEw=;
        b=NhP0W0dXPmCW0Domrv10tcvy6IpSVBSW1c6WzDNeqF23RFGt+HgrL4c95Zzt0jRkio
         GGMRy4HYyYtfmt42djDr7pAewhg1Ebp51q42lJqdfAJ9FTN80Q+T4o8tWOxUcfweALTc
         0CJfoGVXe2kTn3CfZAcze5QGfXfBAaGT3VJuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696872091; x=1697476891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvG29kjnBvm/h/aaY9yR0PuKwn+9CpzwBm6a6KnjkEw=;
        b=GBBPWBiiuhSyjMF4jUtRt2u38cnR83tCG7hwKPS7ia0HQY0gIoRYEzkWWOCTPOnqnV
         0GYzWf2U2R9Yo3zDkw37PBjf2WklfdzRn5F0W/hhVykN3E8s9py2CvQFqhRZNGaDcZho
         e5iS036F1vd2XeM3vV87OibkH658P2d0+Qs0+TkCjkF+oHiC3bKBnQrgpaT0A7Zu4YJ/
         4z2I4rKnlwf9u5RoOYeWg8aZEt5ZRxzCKh7HQw00mSRAhrfNzWpyUdjdyTTwp2yMpX8S
         499XUqkpJoJUw73zdx5EFJO93pt5p/wqk8Hj6uKjs4M1b2S1AgvQD6EQKax7s6x1Ds/W
         3CVQ==
X-Gm-Message-State: AOJu0YwgePs14lI3lVi8z20Q32nC+ZS7ZB8yrkY3nz0Sgh6wrU1KfWRr
	WUCcGt5u49dWV6DVmIkcm89sPA==
X-Google-Smtp-Source: AGHT+IF8y/KaV1MDDakfXoOojQZsUswxZWMMxS2/NoWslI0dIEux6WDeviCFEv5jJLovoO+YRBrUAw==
X-Received: by 2002:a17:90b:2015:b0:27b:2459:6ae4 with SMTP id hs21-20020a17090b201500b0027b24596ae4mr9874569pjb.40.1696872090897;
        Mon, 09 Oct 2023 10:21:30 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a195e00b002635db431a0sm9324058pjh.45.2023.10.09.10.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 10:21:30 -0700 (PDT)
Date: Mon, 9 Oct 2023 10:21:29 -0700
From: Kees Cook <keescook@chromium.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	kuba@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
	pabeni@redhat.com, slyich@gmail.com,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH v1 net] af_packet: Fix fortified memcpy() without flex
 array.
Message-ID: <202310091020.18B4F8D27@keescook>
References: <202310090852.E9A6558@keescook>
 <20231009171228.89827-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009171228.89827-1-kuniyu@amazon.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 10:12:28AM -0700, Kuniyuki Iwashima wrote:
> From: Kees Cook <keescook@chromium.org>
> Date: Mon, 9 Oct 2023 09:01:34 -0700
> > On Mon, Oct 09, 2023 at 08:31:52AM -0700, Kuniyuki Iwashima wrote:
> > > Sergei Trofimovich reported a regression [0] caused by commit a0ade8404c3b
> > > ("af_packet: Fix warning of fortified memcpy() in packet_getname().").
> > > 
> > > It introduced a flex array sll_addr_flex in struct sockaddr_ll as a
> > > union-ed member with sll_addr to work around the fortified memcpy() check.
> > > 
> > > However, a userspace program uses a struct that has struct sockaddr_ll in
> > > the middle, where a flex array is illegal to exist.
> > > 
> > >   include/linux/if_packet.h:24:17: error: flexible array member 'sockaddr_ll::<unnamed union>::<unnamed struct>::sll_addr_flex' not at end of 'struct packet_info_t'
> > >      24 |                 __DECLARE_FLEX_ARRAY(unsigned char, sll_addr_flex);
> > >         |                 ^~~~~~~~~~~~~~~~~~~~
> > > To fix the regression, let's go back to the first attempt [1] telling
> > > memcpy() the actual size of the array.
> > > 
> > > Reported-by: Sergei Trofimovich <slyich@gmail.com>
> > > Closes: https://github.com/NixOS/nixpkgs/pull/252587#issuecomment-1741733002 [0]
> > 
> > Eww. That's a buggy definition -- it could get overflowed.
> 
> Only if they pass sizeof(struct sockaddr_storage) to getsockname().
> 
> 
> > 
> > But okay, we don't break userspace.
> > 
> > > Link: https://lore.kernel.org/netdev/20230720004410.87588-3-kuniyu@amazon.com/ [1]
> > > Fixes: a0ade8404c3b ("af_packet: Fix warning of fortified memcpy() in packet_getname().")
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > ---
> > >  include/uapi/linux/if_packet.h | 6 +-----
> > >  net/packet/af_packet.c         | 7 ++++++-
> > >  2 files changed, 7 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/include/uapi/linux/if_packet.h b/include/uapi/linux/if_packet.h
> > > index 4d0ad22f83b5..9efc42382fdb 100644
> > > --- a/include/uapi/linux/if_packet.h
> > > +++ b/include/uapi/linux/if_packet.h
> > > @@ -18,11 +18,7 @@ struct sockaddr_ll {
> > >  	unsigned short	sll_hatype;
> > >  	unsigned char	sll_pkttype;
> > >  	unsigned char	sll_halen;
> > > -	union {
> > > -		unsigned char	sll_addr[8];
> > > -		/* Actual length is in sll_halen. */
> > > -		__DECLARE_FLEX_ARRAY(unsigned char, sll_addr_flex);
> > > -	};
> > > +	unsigned char	sll_addr[8];
> > >  };
> > 
> > Yup, we need to do at least this.
> > 
> > >  
> > >  /* Packet types */
> > > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > > index 8f97648d652f..a84e00b5904b 100644
> > > --- a/net/packet/af_packet.c
> > > +++ b/net/packet/af_packet.c
> > > @@ -3607,7 +3607,12 @@ static int packet_getname(struct socket *sock, struct sockaddr *uaddr,
> > >  	if (dev) {
> > >  		sll->sll_hatype = dev->type;
> > >  		sll->sll_halen = dev->addr_len;
> > > -		memcpy(sll->sll_addr_flex, dev->dev_addr, dev->addr_len);
> > > +
> > > +		/* Let __fortify_memcpy_chk() know the actual buffer size. */
> > > +		memcpy(((struct sockaddr_storage *)sll)->__data +
> > > +		       offsetof(struct sockaddr_ll, sll_addr) -
> > > +		       offsetofend(struct sockaddr_ll, sll_family),
> > > +		       dev->dev_addr, dev->addr_len);
> > >  	} else {
> > >  		sll->sll_hatype = 0;	/* Bad: we have no ARPHRD_UNSPEC */
> > >  		sll->sll_halen = 0;
> > 
> > I still think this is a mistake. We're papering over so many lies to the
> > compiler. :P If "uaddr" is actually "struct sockaddr_storage", then we
> > should update the callers...
> 
> We could update all callers to pass sockaddr_storage but it seems too much
> for net.git.. :/  I think the conversion should be done later for net-next.
> 
>   $ grep -rn -E "\.getname.*?=" | cut -f 2 -d"=" | sort | uniq | wc -l
>   40

Agreed -- it's something to do going forward. Your fix is likely the
right approach to take to undo the UAPI change.

-Kees

-- 
Kees Cook

