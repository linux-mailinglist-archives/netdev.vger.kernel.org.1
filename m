Return-Path: <netdev+bounces-134581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CD999A43A
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 14:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5041B1F23094
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 12:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D81C2178E6;
	Fri, 11 Oct 2024 12:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dE3Idk3d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918C72178FF
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 12:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728651269; cv=none; b=N56GGHLL6tx0f3+xnFtY8oqS3V4AGYwvHYw+6yKaNHljNMKVmRMhISmrLgXLmV37mOvn0Rhje7A+fNgvCdhD2pZxCbMPyyD9AIEnymUhsB1bmPd+bpEx26oGHZ6dDXbX7ZTpPXzcpfO5oqc73m44Gbyb6tWQE44jhWyv+0+xfqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728651269; c=relaxed/simple;
	bh=VyUNwldRrrQYJDbp8UASTBoB6nfGOleGl++5aG0GTTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwRvzjEBEcEGvxi/9Y2xS+S61GVy7hDKd+0icy4paHiRu0ZR7vwzrtNXm/xHNnE4LG/emiHHgyr2a6Fa/lxSfjNGjclvxNdnEdNa5H8o2UFc6jBig5WeoEmdo29MCZ2qcBKjsymzFnEF/4TNheW/AUZRuphq90QU05Y7UuI0SBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dE3Idk3d; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c3df1a3cb6so345995a12.2
        for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 05:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728651266; x=1729256066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FdJxVcplaevM05fTidW7N27f+ew3Acvc2RAb92XPyxE=;
        b=dE3Idk3d/h5K49iug2gK1ia4A1N4AWuRK6XC6GlG2wh3KJQgiwEzO6AhtIAaOpNaJ2
         xnf1Opaobi68Bg6PTKgqADgmPb4QpXERoPWobX70LQASERgjT3kmAqoiR6T2fU5biI9P
         eTVUpjrPkOatYkmChhNHdwMTHFgW2N2PvkDcUrniYHU+9hvu27RJ1N4ZzWbE8F1AaBw2
         xbhSWNW/WY2f8wn5581JjT7eQErVihCOLOft3GDbbDk6dveSXoTn4jefYnsXu4v4HXt7
         HqqxUtjEPCuANnnWixTR3YOD1KxcVAdCm9takOrf27Vfk6YqnjhVkFeecb4NEr+iYXl/
         xXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728651266; x=1729256066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdJxVcplaevM05fTidW7N27f+ew3Acvc2RAb92XPyxE=;
        b=Hrm034HuhtAocUYrM6lr+wqVlBoQHJh4pbICIKxx51+5S9AouHqJwB/PNQldlBbH3v
         yRcZqwKKeANvBIkE4zxER2UDUqgqx9NQ3/zX46arg0ZalwCi38CCqOBqn1RYrnW1i03X
         GP31CREdaNbAzr4OmfdAFkuAk3t8cajNa9n3iWrD6QRy2IHBEEQ0aufzh+jZ/VWMwJb9
         iZfnyXxyshC2E5zcdM8QCj8ghC6AXzQ9tTFuRU9Nyi3Egy2x8jbnpmDL3+9gEVM1HS4G
         G8vVN6oP6+ZKauszVXwCUsavVGQqTy8U3b9YhHJGwRcowsbKbz76u64wvFf4+gq5iPH7
         /n+A==
X-Forwarded-Encrypted: i=1; AJvYcCUarMTqFqItpq6FD2rNQrb8sLCyQLVGHXKYoqD3qJaR+VcX0n+nKmFNF4x14OQFKKcDiZ4GINU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8OxUepdx/42ZY31LzktjzP11bL2mVYCFcvaCt5nrqMtl8r0DZ
	pt88LkfhCdPeHbV4neZPf2j48iyYOheYIwwNPSpGoB3cEZ8Bd/T3
X-Google-Smtp-Source: AGHT+IFj+5cVcEwcmTKG8nFQHA3Vlmz0vrd4X4eaM4oX3ZGJLI+Y4a1/QfiJmZEO34kf6ObJ6y1xLg==
X-Received: by 2002:a17:906:f5aa:b0:a99:53cf:26d5 with SMTP id a640c23a62f3a-a99b945539emr103189666b.11.1728651265581;
        Fri, 11 Oct 2024 05:54:25 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80f2737sm209363966b.217.2024.10.11.05.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 05:54:24 -0700 (PDT)
Date: Fri, 11 Oct 2024 15:54:21 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/3] net: phylink: remove "using_mac_select_pcs"
Message-ID: <20241011125421.eflqwvpnkrt4pdxh@skbuf>
References: <ZwfP8G+2BwNwlW75@shell.armlinux.org.uk>
 <20241011103912.wmzozfnj6psgqtax@skbuf>
 <ZwVEjCFsrxYuaJGz@shell.armlinux.org.uk>
 <E1syBPE-006Unh-TL@rmk-PC.armlinux.org.uk>
 <20241009122938.qmrq6csapdghwry3@skbuf>
 <Zwe4x0yzPUj6bLV1@shell.armlinux.org.uk>
 <ZwfP8G+2BwNwlW75@shell.armlinux.org.uk>
 <20241011103912.wmzozfnj6psgqtax@skbuf>
 <ZwkEv7rOlHqIqMIL@shell.armlinux.org.uk>
 <ZwkEv7rOlHqIqMIL@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwkEv7rOlHqIqMIL@shell.armlinux.org.uk>
 <ZwkEv7rOlHqIqMIL@shell.armlinux.org.uk>

On Fri, Oct 11, 2024 at 11:58:07AM +0100, Russell King (Oracle) wrote:
> On Fri, Oct 11, 2024 at 01:39:12PM +0300, Vladimir Oltean wrote:
> > On Thu, Oct 10, 2024 at 02:00:32PM +0100, Russell King (Oracle) wrote:
> > > On Thu, Oct 10, 2024 at 12:21:43PM +0100, Russell King (Oracle) wrote:
> > > > Hmm. Looking at this again, we're getting into quite a mess because of
> > > > one of your previous review comments from a number of years back.
> > > > 
> > > > You stated that you didn't see the need to support a transition from
> > > > having-a-PCS to having-no-PCS. I don't have a link to that discussion.
> > > > However, it is why we've ended up with phylink_major_config() having
> > > > the extra complexity here, effectively preventing mac_select_pcs()
> > > > from being able to remove a PCS that was previously added:
> > > > 
> > > > 		pcs_changed = pcs && pl->pcs != pcs;
> > > > 
> > > > because if mac_select_pcs() returns NULL, it was decided that any
> > > > in-use PCS would not be removed. It seems (at least to me) to be a
> > > > silly decision now.
> > > > 
> > > > However, if mac_select_pcs() in phylink_major_config() returns NULL,
> > > > we don't do any validation of the PCS.
> > > > 
> > > > So this, today, before these patches, is already an inconsistent mess.
> > > > 
> > > > To fix this, I think:
> > > > 
> > > > 	struct phylink_pcs *pcs = NULL;
> > > > ...
> > > >         if (pl->mac_ops->mac_select_pcs) {
> > > >                 pcs = pl->mac_ops->mac_select_pcs(pl->config, state->interface);
> > > >                 if (IS_ERR(pcs))
> > > >                         return PTR_ERR(pcs);
> > > > 	}
> > > > 
> > > > 	if (!pcs)
> > > > 		pcs = pl->pcs;
> > > > 
> > > > is needed to give consistent behaviour.
> > > > 
> > > > Alternatively, we could allow mac_select_pcs() to return NULL, which
> > > > would then allow the PCS to be removed.
> > > > 
> > > > Let me know if you've changed your mind on what behaviour we should
> > > > have, because this affects what I do to sort this out.
> > > 
> > > Here's a link to the original discussion from November 2021:
> > > 
> > > https://lore.kernel.org/all/E1mpSba-00BXp6-9e@rmk-PC.armlinux.org.uk/
> > > 
> > > Google uselessly refused to find it, so I searched my own mailboxes
> > > to find the message ID.
> > 
> > Important note: I cannot find any discussion on any mailing list which
> > fills the gap between me asking what is the real world applicability of
> > mac_select_pcs() returning NULL after it has returned non-NULL, and the
> > current phylink behavior, as described above by you. That behavior was
> > first posted here:
> > https://lore.kernel.org/netdev/Ybiue1TPCwsdHmV4@shell.armlinux.org.uk/
> > in patches 1/7 and 2/7. I did not state that phylink should keep the old
> > PCS around, and I do not take responsibility for that.
> 
> I wanted to add support for phylink_set_pcs() to remove the current
> PCS and submitted a patch for it. You didn't see a use case and objected
> to the patch, which wasn't merged.

It was an RFC, it wasn't a candidate for merging anyway.

> I've kept that behaviour ever since on the grounds of your objection -
> as per the link that I posted. This has been carried forward into the
> mac_select_pcs() implementation where it explicitly does not allow a
> PCS to be removed. Pointing to the introduction of mac_select_pcs() is
> later than your objection.

This does not invalidate my previous point in any way. The phylink_set_pcs()
API at that time implied a voluntary call from the driver. "pcs" was not
allowed to be NULL, and your patch was the one introducing phylink_set_pcs(NULL)
as a valid call. That's what I objected to as not seeing the purpose of.

Whereas the new mac_select_pcs() has "return NULL" already baked into it
from day one (the one-to-one equivalent of it being: don't call
phylink_set_pcs()). It becomes inevitable, in this new model, to handle
somehow the "what if" scenario of returning NULL after non-NULL, whereas
that was not necessary before. It's a different API, which automatically
implies a new set of rules.

My point is that it was impossible for me to consciously contribute to
the definition of the mac_select_pcs() API rules. Saying that the
introduction of mac_select_pcs() came later than my comment proves
exactly that. I couldn't have possibly known that my review comment will
be used for a different API than phylink_set_pcs(), because the new API
hadn't been posted.

Whereas what you are saying is that the mac_select_pcs() posting took
place after my comment => of course you took my comment into consideration.
You seem to be omitting that I did not have all information.

> Let me restate it. As a *direct* result of your comments on patch 8/8
> which starts here:
> https://lore.kernel.org/netdev/E1mpSba-00BXp6-9e@rmk-PC.armlinux.org.uk/
> I took your comments as meaning that you saw no reason why we should
> allow a PCS to ever be removed.

I still stand by that statement, in that context. You took it out of
context.

> phylink_set_pcs() needed to be modified to allow that to happen. Given
> your objection, that behaviour has been carried forward by having
> explicit additional code to ensure that a PCS can't be removed from
> phylink without replacing it with a different PCS. In other words,
> mac_select_pcs() returning NULL when it has previously returned a PCS
> does *nothing* to remove the previous PCS.

The carrying over of old behavior from one API to another API is merely
one of the design choices that can be made, and far from the only
option. In general, you introduce new API exactly _because_ you want to
change the behavior in some conditions.

> Maybe this was not your intention when reviewing patch 8/8, but that's
> how your comments came over, and lead me to the conclusion that we
> need to enforce that - and that is enforced by:
> 
>                 pcs_changed = pcs && pl->pcs != pcs;
> 
> so pcs_change will always be false if pcs == NULL, thus preventing the
> replacement of the pcs:
> 
>         if (pcs_changed) {
>                 phylink_pcs_disable(pl->pcs);
> 
>                 if (pl->pcs)
>                         pl->pcs->phylink = NULL;
> 
>                 pcs->phylink = pl;
> 
>                 pl->pcs = pcs;
>         }
> 
> I wouldn't have coded it this way had you not objected to patch 8/8
> which lead me to believe we should not allow a PCS to be removed.
> 
> Review comments do have implications for future patches... maybe it
> wasn't want you intended, but this is a great example of cause and
> (possibly unintended) effect.

This restatement was not necessary, as I believe I got the point from
your previous message.

I still fundamentally reject any responsibility you wish to attribute to
me here. For one, my review feedback was in a different context. But
let's even assume it was directly related, and I knew mac_select_pcs()
would come. If I were maintaining a piece of code and received some
review feedback, I would not translate it into code that carries
exclusively _my_ sign-off, unless _I_ agree with it and can justify it.
I would not seek to transfer responsibility to somebody else. In fact,
if I were to be held accountable for patches signed off by others, I
wouldn't even be reviewing anything. So I think it's a very fair
collaboration rule, and I'm only asking you to apply it to me as well.

