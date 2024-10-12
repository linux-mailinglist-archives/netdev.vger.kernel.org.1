Return-Path: <netdev+bounces-134790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A95D99B2F5
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 12:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8577284323
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 10:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A221514F6;
	Sat, 12 Oct 2024 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NARd8hQY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186FC153BD7
	for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 10:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728728885; cv=none; b=N3cz1QeAkV8Kc7QKcl7bXWWRGDmBRBANwjpqhlHrVULjVi2tFlT88KzRCBsjU6Ee+3+y3LwdhC1u8PLLYR/63dlG4EM0LHI9bZzEY6OoBdjM088G5Jt0r8t58F/czjTMZfl1vlWSlDhmRKOSQEV6P/n6Aoi0Uss6I0NazhvPaF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728728885; c=relaxed/simple;
	bh=9+Z/srz1j+1BjeOnvB7pXntXTgxbfWJF7XXfH30NxJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htBVVPoGMO6ofW5yu3Cb+9l6FdmGPW0cdj94iz+WJWqIHGB9Gz2FKqhIAogL9/YnLlI0mfEgpRJJMwD0rh2MawojY5UAXxa4yC3SHzmdDjSXYiVZIHwo4xtpo19U2WJKO+zRiFQUsIwoc2e8vBJc1K042csHJUkVbSnHgpPFG2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NARd8hQY; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c936e8ea13so546648a12.3
        for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 03:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728728882; x=1729333682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EEnYNr2rbdYoFGhU5pVqwT9UwY6fVdCcRdTnkJuOwv0=;
        b=NARd8hQYRJCDxH+EmQTu90JhGJzVSRMgx1Sl9xn72t2kjMI+bMy5HpzJlgQ1NzjRZP
         iVWDxbweQv5aqklN6r3RAnDuBA8CNf4JMe4EKCNgvo5/QAVlqwguAyI8lLCma2UMUIce
         T+Dx2o/JsL5OcLads57VaqkaHQUuM5EiVbeMMbC/EI2NQ2RbG7/KSQy/Y+hdccK+4wGM
         WE5awhPlO3UjnD66gCCu3Rtgo7YYOINxN6EbfBgbV+uq866nqLKUW1tPQhA7VT4yOJ6d
         DiikAA65b1XyyZ4GXN5TEJsTwW6Zv4fzXcyIXZr425dTDDnPX46MzX1tFf/QzfCQWEYw
         vz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728728882; x=1729333682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEnYNr2rbdYoFGhU5pVqwT9UwY6fVdCcRdTnkJuOwv0=;
        b=d8uyBWnN7qd60s2h6borT6J2yABF15BVFyJoY3F0kvG6Iz1/p0NyvciiNCFLPVtOBN
         gtc5rNjMLKoHhgsm9GTnt5TT2hJGb4lL38AlKnZDakXFEo82b503+EF8W58rAX0SKuX9
         fyX9f1UFR1bYFQYWyHnniQKhjJiw6LQbAdNfjbo9FesMVQocPiUh/QlslNjH+jYJtJxT
         AU93eubTaXnWhOeMd4zOopIRoUvcrfhdWaaOajQ2wbeTpOzOZ5fQOMcXB71YWAG1qM48
         CqG9uJRYBDUV4oNFrerbc+4PIPA3x/aQFZSaECzDk83Tm+P+8GC723f9FiJHw0LMMfgk
         Fa4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWjmdRHPh0hhay3JX+IYr7cZJjvpOnJdfaV1kYDbTVuSjTzuswtyiWrA3WHIP7JyIyr1FWUvZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDShOUOYEP9eHVQZJzh6ACAv2FRi4GmBmDbLWtxGTL3FWxqO4h
	7tvXWrNuu9A0B6wKj6AtNR/C7DabtmSgRiqSSGMmAzMq5HnMBbvJ
X-Google-Smtp-Source: AGHT+IGQBlxn0fRqfTv8gJ0pj73fr5+MzL80m9CYPKEP8cLMKQGel/rG04bn58gFLK7yIyRZhToXyw==
X-Received: by 2002:a17:907:7ea1:b0:a99:63d8:a1a8 with SMTP id a640c23a62f3a-a99b939cb60mr212223666b.1.1728728882020;
        Sat, 12 Oct 2024 03:28:02 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80efe57sm310897066b.188.2024.10.12.03.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 03:27:50 -0700 (PDT)
Date: Sat, 12 Oct 2024 13:27:31 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/3] net: phylink: remove "using_mac_select_pcs"
Message-ID: <20241012102731.yylcm54ajdy35dud@skbuf>
References: <ZwVEjCFsrxYuaJGz@shell.armlinux.org.uk>
 <E1syBPE-006Unh-TL@rmk-PC.armlinux.org.uk>
 <20241009122938.qmrq6csapdghwry3@skbuf>
 <Zwe4x0yzPUj6bLV1@shell.armlinux.org.uk>
 <ZwfP8G+2BwNwlW75@shell.armlinux.org.uk>
 <20241011103912.wmzozfnj6psgqtax@skbuf>
 <ZwkEv7rOlHqIqMIL@shell.armlinux.org.uk>
 <ZwkEv7rOlHqIqMIL@shell.armlinux.org.uk>
 <20241011125421.eflqwvpnkrt4pdxh@skbuf>
 <Zwllt43iS5EDvjHN@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zwllt43iS5EDvjHN@shell.armlinux.org.uk>

On Fri, Oct 11, 2024 at 06:51:51PM +0100, Russell King (Oracle) wrote:
> On Fri, Oct 11, 2024 at 03:54:21PM +0300, Vladimir Oltean wrote:
> > On Fri, Oct 11, 2024 at 11:58:07AM +0100, Russell King (Oracle) wrote:
> > > I wanted to add support for phylink_set_pcs() to remove the current
> > > PCS and submitted a patch for it. You didn't see a use case and objected
> > > to the patch, which wasn't merged.
> > 
> > It was an RFC, it wasn't a candidate for merging anyway.
> 
> What does that have to do with it????????????
> 
> An idea is put forward (the idea of allowing PCS to be removed.) It's
> put forward as a RFC. It gets shot down. Author then goes away believing
> that there is no desire to allow PCS to be removed. That idea gets
> carried forward into future patches.
> 
> _That_ is what exactly happened. I'm not attributing blame for it,
> merely explaining how we got to where we are with this, and how we've
> ended up in the mess we have with PCS able to be used outside of its
> validated set.
> 
> You want me to provide more explanation on the patch, but I've
> identified a fundamental error here caused as an effect of a previous
> review comment.
> 
> I'm now wondering what to do about it and how to solve this in a way
> that won't cause us to go around another long confrontational discussion
> but it seems that's not possible.
> 
> So, do I ignore your review comments and just do what I think is the
> right thing, or do I attempt to discuss it with you? I think, given
> _this_ debacle, I ignore you. I would much rather involve you but it
> seems that's a mistake.

My technical answer was already provided 2 replies ago:

| Keeping in mind that I don't know whether anything has changed since
| 2021 which would make this condition any less theoretical than it was
| back then, I guess if I were maintaining the code involved, I'd choose
| between 2 options (whichever is easiest):
| 
| - Imagine a purely theoretical scenario where phylink transitions
|   between a state->interface requiring a phylink_pcs, and one not
|   requiring a phylink_pcs. I'm not even saying a serial PCS hardware
|   block isn't present, just that it isn't modeled as a phylink_pcs
|   (for reasons which may be valid or not). Probably the most logical
|   thing to do in this scenario is allow the old phylink_pcs to be
|   removed, and its ops never to be used for the new state->interface.
| 
| - Validate, possibly at phylink_validate_phy() time, that for all
|   phy->possible_interfaces, mac_select_pcs() either returns NULL for
|   all of them, or non-NULL for all of them. The idea would be to leave
|   room for the use case to define itself (and the restriction to be
|   lifted whenever necessary), instead of giving a predefined behavior
|   for the transition when in reality we have no idea of the use case
|   behind it. I don't know whether checking phy->possible_interfaces
|   would be sufficient in ensuring that such a transition cannot occur.

I have nothing more to add to this discussion.

