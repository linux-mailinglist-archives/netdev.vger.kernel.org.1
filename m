Return-Path: <netdev+bounces-190648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA48AB8101
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 10:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 679E61698D7
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 08:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDC22797BB;
	Thu, 15 May 2025 08:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+JRWrYM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8132D2206AC;
	Thu, 15 May 2025 08:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747298404; cv=none; b=LYzcRtsc72UkHzVRrgBo7X4rCGw89/gM1J0dl28P2CqxehNd0awk74roZPVXPzV2nMvnH1Hpw4J604s76Q4Ld3NEMGn0PxgjiNA3VByynPw7K78QuP7GmebBbXFnil2dL/Df3IaKh4uaQKvS5VB9B+d6D4VvScsSwXpKYaOKM50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747298404; c=relaxed/simple;
	bh=ibUfkBTfbAysGeFjCuVMLvM8lRBrkrGMr5Q8KjUYpFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iNC1px2xlKjrsuewHyv6OqbuNF7SJPneyDjfZa8mjxxIuftuLvP9HRSuDq2nWmteUyGCLidxp1gRLp3bM7KikNZw0vORogIdJ5wKTNvkaPlFtNKU5+A/WrltRlRhrHbvlZMf01rK/KD9h0ZOTIW33r4Wjw9T4c9ovY4yCBybTi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+JRWrYM; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6f0ad74483fso7528806d6.1;
        Thu, 15 May 2025 01:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747298401; x=1747903201; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ibUfkBTfbAysGeFjCuVMLvM8lRBrkrGMr5Q8KjUYpFQ=;
        b=V+JRWrYM62/3Esane/bI7hc3xN4gsahFCa+Y4eKimLATahAjPdLf2UIUJ0F8kZ8UQk
         rnXCnBmxCbfIWYD4ojOr60bpqLv8jla8Lrnu3qEWo2k0I3STc7d1eQQrnKOWSEDDv8NN
         BNefsRZB2rinc0GX2W0sqq8C/SVDiucoQhCmC66abPJQVhHsB1QxYb/CiyRY/k+T69Dz
         aQgwJ2KfQVgEnS0pi6FTs3eRnWPn5oVVOildoJB81cbTzrSoUX+D+eAMSV/UuRs+dDu5
         xcabkg4NKJo/A1zV8/ahDwAGSf9B1M0Cz6OVuEb9bHpgocK7zEjJhxPHJxEsnZyL+UIO
         5PTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747298401; x=1747903201;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ibUfkBTfbAysGeFjCuVMLvM8lRBrkrGMr5Q8KjUYpFQ=;
        b=BYzqE+hfzrND2Q0ksUvzMWf0RFpbdrpYaE06B7/iAZB3M2pLhLfn1tJzZYcl32FY7B
         kcbPT6m1QRjnGLZWPUpx/w/6KgNlumBTNv3r87pRuFVP6uhPKgo3a9yJrjonBMWOodJc
         rY0DCm4Hd70keKlFdF0CwuqdRCauIzdPoLyflnLrJrkMCkHIP3bK0W9eI5FBaMXZaKE+
         dOFbQeCZn0jWzba16wsmH1GCtDIvBjzdAjeci1oQ4F/MgplBF0JzLztP5c5ploaAVzi/
         0FqGwyzzc+gPxvulxhHtt1GZJNMY0CREnWaCHMjiIc0++Mpy/I7tV+USQ7xeaqiFZSYe
         wxMA==
X-Forwarded-Encrypted: i=1; AJvYcCVZBe+1aC3rx5gLhcVbqYG8ZiNdXe25DI0AB1tt/1irit+j57OsMzJx01339kckcx1zW6beq5Djv6ODLJs=@vger.kernel.org, AJvYcCXa51c9YgmQ9cPhtpButUPdoJIAT2ga/x/iYf5SvhtJNJsXlAH8B9ip/W7IsbqwRfwa1LteByBB@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh2VRXOlVad5DRxQ0PccD5Y96AlnRk2Tfb8LkrT/UyB91DRU8l
	qH6AzTw+fbYReEmfrNzTgCV+1jEKK1Fj7uH3E3w8HLHvdJhgE/zBnETUYL+ADUj/vGvgwGIQo6r
	DDbrvtel8jzjgUZFY4Zc8MCRqUCw=
X-Gm-Gg: ASbGncsavKpv9W2aA9zYCqkIq3vMPWwOLDpES+QwDxxHZu+HjpaVdP+Tcc0VVgJh6AF
	T+CHe5dC1ituaRG90EFZfDujmmZ1CmoeGUBQWRZX3XZysp/xsyPXgjLMSjNiqJRzPSSDKGP1jHG
	oHtFgpKl2MK8L5+kiEiekrNLr6BtwRjz4=
X-Google-Smtp-Source: AGHT+IHHzxX8+BZ4lQpATkb8RqHjMNSfGL7/8msW6UDhFfY2Jf1ydS+PimvGJzc5dIh7+BHVW4DnjBZ8xBwczKLsFDw=
X-Received: by 2002:a05:6214:dcf:b0:6f5:107c:7db2 with SMTP id
 6a1803df08f44-6f896dfbe03mr106122926d6.9.1747298401287; Thu, 15 May 2025
 01:40:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512161013.731955-1-sean.anderson@linux.dev>
 <20250512161013.731955-7-sean.anderson@linux.dev> <20250514195716.5ec9d927@kernel.org>
 <aCWh48ckDDCttbe-@shell.armlinux.org.uk>
In-Reply-To: <aCWh48ckDDCttbe-@shell.armlinux.org.uk>
From: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Date: Thu, 15 May 2025 10:39:50 +0200
X-Gm-Features: AX0GCFsXDjgEM_KdqprfolO5k4dNrtD6K7RPooqI8L7lL5WpY0vhlYiHPfL-F30
Message-ID: <CA+_ehUxH1ZLgARNM7XRHd+j2Nuqu7P6oQh335VdzBGG-OeNCrQ@mail.gmail.com>
Subject: Re: [net-next PATCH v4 06/11] net: phy: Export some functions
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jakub Kicinski <kuba@kernel.org>, Sean Anderson <sean.anderson@linux.dev>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, upstream@airoha.com, 
	Kory Maincent <kory.maincent@bootlin.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Il giorno gio 15 mag 2025 alle ore 10:12 Russell King (Oracle)
<linux@armlinux.org.uk> ha scritto:
>
> On Wed, May 14, 2025 at 07:57:16PM -0700, Jakub Kicinski wrote:
> > On Mon, 12 May 2025 12:10:08 -0400 Sean Anderson wrote:
> > > Export a few functions so they can be used outside the phy subsystem:
> > >
> > > get_phy_c22_id is useful when probing MDIO devices which present a
> > > phy-like interface despite not using the Linux ethernet phy subsystem.
> > >
> > > mdio_device_bus_match is useful when creating MDIO devices manually
> > > (e.g. on non-devicetree platforms).
> > >
> > > At the moment the only (future) user of these functions selects PHYLIB,
> > > so we do not need fallbacks for when CONFIG_PHYLIB=n.
> >
> > This one does not apply cleanly.
>
> In any case, we *still* have two competing implementations for PCS
> support, and the authors have been asked to work together, but there's
> been no sign of that with both authors posting their patch sets within
> the last week.
>
> Plus, I had asked for the patches to be posted as RFC because I'm not
> going to have time to review them for a while (you may have noticed a
> lack of patches from myself - because I don't have time to post them
> as I'm working on stuff directed by my employer.)
>
> Sadly, being employed means there will be times that I don't have the
> bandwidth to look at mainline stuff.
>

Hi Russell,
my 2 cent on the topic, I'm more than happy to collaborate with Sean but
the implementation idea between the 2 is so different that we really need
some guidance on what is possible and what is not.

As said by Daniel, in my series we can totally introduce a compat layer
based on this and the all the PCS documentation for this is golden and
lovely.

For RFC, in my series I moved out of it to trigger some additional build test
and also because it seems to me sometimes RFC patch when net-next is
open gets ignored. (And also to stress that the thing works and is not only
an idea)

I know you are full busy with life and work, this is just to explain some
decisions from my side.

