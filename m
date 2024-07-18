Return-Path: <netdev+bounces-112091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE4E934E73
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 15:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9CC1C2133F
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 13:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B6213B7BE;
	Thu, 18 Jul 2024 13:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnNPY5A3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065341B86FB;
	Thu, 18 Jul 2024 13:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721310328; cv=none; b=bmYmpNRAooOC5235JsMBIHljDKSmQhiaqMsMhG5SRYK6X7DsmTOLiMbS73CFFyrvbViCTzatnWeNTaodM0rf9Xq8B1N6Uhj4DoSuj8vEWsG0C7L3HD/JNCxNZz+ZNhM/E99yyWtShvR2cZBTb5sjbFNTKBVfJHhM8TpwTC9WJmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721310328; c=relaxed/simple;
	bh=3rIIjfrMsL9HBG0ZUjtncQtFefTFzeSIFo/bC/TSwtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AF85Fe7JcN4I/pYfuIibOFLZG8BL8WjBi3IC0BmMi8AQWuMR3S9HAvTb60qku8LlKAC6KgystDZHxYpqPmJfYvYbwH50alZe2Og1J6l8d1qewhqiyVVVwR5g7ZwgE8l7CiXpl/ywI5iKUBeTiOHku8MQyZlhk3IsVm4TVj7XH9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnNPY5A3; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-70847d0cb1fso457773a34.3;
        Thu, 18 Jul 2024 06:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721310326; x=1721915126; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xGc8MKfbN3L/GKWoSL/Ioh6AMpLNqJHz7Tn8tmGdobw=;
        b=EnNPY5A3EEIispgdrimm/F6dR4r5NYuqnbFgBQH6lUVnGxuv7M2/smloFkcVSoTids
         nnMnYxYyYgW5r3YLTjwCKEDPcyAI25qKr9zjVdP4/ll7+BXvkC34dEkBdBP2uS3dmIqY
         OTWs4RRTirvfGR5v0SO3kFkM0owIMWX1PkPko9juCT1di6wb5Z2k34/iq44/4vq1UgSj
         6Jrx6Gp7AIulkjwyMRuljoP4abGykDk1FnsJNA2TAUcxLEPXzF8fScNhNW46LRUW5kHM
         u9Dbc8ipXoqXwBurIrLiFCBBWoCNMnrUzJFdLCnWtjddDsquu9M4iv6jCSw+kSFz9VfX
         QvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721310326; x=1721915126;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xGc8MKfbN3L/GKWoSL/Ioh6AMpLNqJHz7Tn8tmGdobw=;
        b=ncRr7kARvcnjhswtosK+jDtvO+D6ND0ax4czC+G2eASYLa4ANHBiW1cRhFUZSwGMXk
         oS7b/5Ea+MYLJkIm2NHRCMf+tjgXNmiQK0MbfW/A9IdLyctOoGs7ezPb/pVW4dUXxP5t
         ialCmm08F40wqG3LXZp6IzXVuk5sVK1z5Zv3sV4fCXaZLEjfWkRE4tMYBVyVyjcISLo+
         TaVoIWlA1Ks/IlV8+FQKaLdTGVbIycRi/hZjv0KzU9NEhvbH+kHm8kV4kkTIaxteR2R2
         HL4mNW4k0yIHHtFX3F+7upk1foOnRDuzEupPIWHzeL+DlTGRfpOoDUos/byY3wLT+of/
         p9KA==
X-Forwarded-Encrypted: i=1; AJvYcCWw8bMJ1sQbpg2BYwy0PdnuLYMkTWR2P/IyPt4lhLER72N8IiUdSW+w0INzG/XCMedLt9Jop9Kwv0qFjqHWD4qi4c3S1tis
X-Gm-Message-State: AOJu0YypwVaJOs6TYRBKZRxAFZ85geLJ9ahHSyDvsgxSW36jxiJevMhZ
	sQNRKH0WohiCMDqdwd8z121atwilcILm/hEFBZzSqvi/8uyvHi7XroVbFUPVqTk9MFzto1VnlvX
	a75x2G3+kvU4icn9sDaL3ea7NU+PKUsx5
X-Google-Smtp-Source: AGHT+IGgnX83WsAuYeTRJZ6jCVqxvuk9XgYhgjEbvF8lZL1NdcZyJw/KnZhBD/PkpSqYRFxshr6Gy0N9ChoVpa+GPto=
X-Received: by 2002:a05:6870:d8d0:b0:250:171d:5c74 with SMTP id
 586e51a60fabf-260ee841d15mr2085163fac.26.1721310326096; Thu, 18 Jul 2024
 06:45:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717193725.469192-1-vtpieter@gmail.com> <20240717193725.469192-2-vtpieter@gmail.com>
 <20240717193725.469192-3-vtpieter@gmail.com> <20240717193725.469192-4-vtpieter@gmail.com>
 <e6285fd7-91fd-411c-bea9-ddcb62b90550@lunn.ch>
In-Reply-To: <e6285fd7-91fd-411c-bea9-ddcb62b90550@lunn.ch>
From: Pieter <vtpieter@gmail.com>
Date: Thu, 18 Jul 2024 15:45:13 +0200
Message-ID: <CAHvy4ArmWx78aP=2O1a2F=GXqro2N6GxjdYO+AGs32petpL4+Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] net: dsa: microchip: check erratum workaround through
 indirect register read
To: Andrew Lunn <andrew@lunn.ch>
Cc: devicetree@vger.kernel.org, woojung.huh@microchip.com, 
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, o.rempel@pengutronix.de, 
	Pieter Van Trappen <pieter.van.trappen@cern.ch>
Content-Type: text/plain; charset="UTF-8"

On Thu, Jul 18, 2024 at 04:24, Andrew Lunn <andrew@lunn.ch> wrote :
> On Wed, Jul 17, 2024 at 09:37:24PM +0200, vtpieter@gmail.com wrote:
> > From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> >
> > Check the erratum workaround application which ensures in addition
> > that indirect register write and read work as expected.
> >
> > Commit b7fb7729c94f ("net: dsa: microchip: fix register write order in
> > ksz8_ind_write8()") would have been found faster like this.
> >
> > Also fix the register naming as in the datasheet.
>
> We are in the merge window at the moment, so net-next is closed at the
> moment. Please repost in two weeks.

Right sorry I only realize this now. I did some reading up on netdev
patches; will make sure to rebase on net-next tree as well when I
submit the v2 in 2 weeks.

> >
> >       /* KSZ87xx Errata DS80000687C.
> >        * Module 2: Link drops with some EEE link partners.
> > @@ -1981,8 +1982,13 @@ static int ksz8_handle_global_errata(struct dsa_switch *ds)
> >        *   KSZ879x/KSZ877x/KSZ876x and some EEE link partners may result in
> >        *   the link dropping.
> >        */
> > -     if (dev->info->ksz87xx_eee_link_erratum)
> > -             ret = ksz8_ind_write8(dev, TABLE_EEE, REG_IND_EEE_GLOB2_HI, 0);
> > +     if (dev->info->ksz87xx_eee_link_erratum) {
> > +             ret = ksz8_ind_write8(dev, TABLE_EEE, REG_IND_EEE_GLOB2_LO, 0);
> > +             if (!ret)
> > +                     ret = ksz8_ind_read8(dev, TABLE_EEE, REG_IND_EEE_GLOB2_LO, &data);
> > +             if (!ret && data)
> > +                     dev_err(dev->dev, "failed to disable EEE next page exchange (erratum)\n");
>
> If data is not 0, should it be considered fatal? Maybe return -EIO ?

Indeed that would make more sense; will return -EIO for v2.

Thanks, Pieter

