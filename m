Return-Path: <netdev+bounces-159127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CFFA14787
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 02:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A24893A9C38
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 01:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F360288DA;
	Fri, 17 Jan 2025 01:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="FOnE1AAo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1F2D530
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 01:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737077163; cv=none; b=OGFf7wnm/CrF/UYEA3oBlsutiF3J5/0hpMtohhdpJQ9YVjkc7l53buLFndBoM29malYKk/7QvCBFwyQQewc8eY9o7YmWYdLmvaRPFIJr5DIIrW3dJvfkUDIkqubrzen0x5+/XwLMrQXApoQFbLDk1321IPfm/a0kQvqa2nB40uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737077163; c=relaxed/simple;
	bh=0nP1NjrdeZnIxgIslci2OCDz0Ku2kJ6JfJsBzYpPjh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHwm56Txf2/ntrUqYqkwn9OFIF/48teSJ3lWeM+Do7Lw6ZKayIm/n5Sl9kV/k9dObSUHh5/HvaktgRW7ffYnPq5I2Gfo7j1M591VfajrYTG9bINI/bfzjxUi2oaXH3Itcmjdjq2462KrsLkcg1T23jjEZyBVZITIIn2GjgRaQCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=FOnE1AAo; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e39779a268bso2654948276.1
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 17:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1737077160; x=1737681960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nP1NjrdeZnIxgIslci2OCDz0Ku2kJ6JfJsBzYpPjh8=;
        b=FOnE1AAo5PGA2CY73J8RhemE6G3uUaCuHFmDnxMPW+7nVZQaqvD8IdNpSNz4yLpb1O
         aY/o1fyWvt0t3XUkRRilrhHfzWvsItTzGC3I4mue9WZFq/PLbeIiKTaBrAH1DxtSyvG5
         l3Wr+jMqnwqjD6Li4QnRCBRtoJomq6i+GkxA7C1gSwQmSLTLYwsoXPUvSRQWthf05BP4
         itRRmoCnjxlMSroJ2ddwJWySdxFQXrSMH2I2ThpwRPkgTBNreFXFWnVK/OHEpYa2qwlS
         y8LIdOBukT0SxOIBL2pBDzQSRLEDJNEp6hqEA3X7lNkyt2WEYFSTpXktmudXl6vvA80X
         ZUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737077160; x=1737681960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nP1NjrdeZnIxgIslci2OCDz0Ku2kJ6JfJsBzYpPjh8=;
        b=lKWHUfzBQsL/R/KhCRu9vo1yCSRPzc+4Nqs370dpBgnA52P603Ya+EpD0Dm40Fdr70
         6Q4nmbzT3UfN8OqxU0Q3qXo3Y37KrOeotY8BTvXfDXGhdsJ48XLTiHNa9Wik+NjqnUDI
         euIS3hHXBJoQZ6TPSqlQI1LG+CqB6Tp0vElkvvGZ+G+ScIzZrZOdVDSGMNsrUsE34z7s
         +OkGQnNG5v0ivrSZBRrrCpeoGmOGJdxeHg4spyBBjxZii8fkOmZYwpt3uN6B4rnvnj7N
         ngULQkD9xHHBwyRa1rhOSp8Sf6/TMOSLihXDHh8cntmmn4gbyWjXXS5V5gBwKA7LUwfr
         P7jw==
X-Forwarded-Encrypted: i=1; AJvYcCVsVh/KhhIZc30Guo5O3nW1S6I9G7DgAK8T/ihQbUHY7ZPes0cSJ12q97RhMsKyavvUORUc2E8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0AXVwibeejgdsGxlJXnPocmVR/Z5MaKbS0qmpjSxXkEjGJmjW
	tipCfvjaiNui80G0nLawSb/p2iX0A1DNwnIbHr6lxMjqaVObdT+oEkog69M2dFaI7esHwPKd9r9
	/yUmNSrfZK2nYv/K4AcTEq4wNjya3gZuBFqqqNw==
X-Gm-Gg: ASbGncvQ24FcXTZnBxnx9n7dA62MV/+t7Co+1cfnzQurJW1WKOKTSsKU8yAQ1OSdR0c
	nJu3119dYR/ebdudnhg75x+mEKw8TvPDYBA/sGQ==
X-Google-Smtp-Source: AGHT+IE2HKr1o48yBV21IQITTjGUYObVZuQ1UyR39Rr1PAt8YKV8CzLsbZat/g3pofd3ddSi8HytQBYigqxF1uYKAdQ=
X-Received: by 2002:a05:6902:2749:b0:e3c:a021:4898 with SMTP id
 3f1490d57ef6-e57b0bc7ba7mr698473276.13.1737077160222; Thu, 16 Jan 2025
 17:26:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212215132.3111392-1-tharvey@gateworks.com>
 <20241213000023.jkrxbogcws4azh4w@skbuf> <CAJ+vNU2WQ2n588vOcofJ5Ga76hsyff51EW-e6T8PbYFY_4xu0A@mail.gmail.com>
 <20241213011405.ogogu5rvbjimuqji@skbuf> <CAJ+vNU3pWA9jV=qAGxFbE4JY+TLMSzUS4R0vJcoAJjwUA7Z+LA@mail.gmail.com>
 <PH7PR11MB8033DF1E5C218BB1888EDE18EF152@PH7PR11MB8033.namprd11.prod.outlook.com>
 <CAJ+vNU3sAhtSkTjuj2ZMfa02Qk1rh1-z=1unEabrB8UOdx8nFA@mail.gmail.com>
 <55858a5677f187e5847e7941d62f6f186f5d121c.camel@microchip.com> <DM3PR11MB8736EAC16094D3BFF6CE1B30EC1B2@DM3PR11MB8736.namprd11.prod.outlook.com>
In-Reply-To: <DM3PR11MB8736EAC16094D3BFF6CE1B30EC1B2@DM3PR11MB8736.namprd11.prod.outlook.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 16 Jan 2025 17:25:49 -0800
X-Gm-Features: AbW1kvYoy2gQnb3USOHgE2lcctiIWlie_F0koJTjgxdz9xMYweV0bnuGq5ftv1A
Message-ID: <CAJ+vNU2BZ2oMy2Gj7xwwsO8EQJcCq9GP-BkaMjEpLUkkmBQVeg@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: microchip: ksz9477: fix multicast filtering
To: Tristram.Ha@microchip.com
Cc: Arun.Ramadoss@microchip.com, andrew@lunn.ch, davem@davemloft.net, 
	olteanv@gmail.com, Woojung.Huh@microchip.com, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, edumazet@google.com, 
	UNGLinuxDriver@microchip.com, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 5:09=E2=80=AFPM <Tristram.Ha@microchip.com> wrote:
>
> > Hi Tim,
> >
> > > Hi Arun,
> > >
> > > Ok, that makes sense to me and falls in line with what my patch here
> > > was trying to do. When you enable the reserved multicast table it
> > > makes sense to update the entire table right? You are only updating
> > > one address/group. Can you please review and comment on my patch
> > > here?
> >
> >
> > During my testing of STP protocol, I found that Group 0 of reserved
> > multicast table needs to be updated. Since I have not worked on other
> > groups in the multicast table, I didn't update it.
> >
> > I could not find the original patch to review, it shows "not found" in
> > lore.kernel.org.
> >
> > Below are my comments,
> >
> > - Why override bit is not set in REG_SW_ALU_VAL_B register.
> > - ksz9477_enable_stp_addr() can be renamed since it updates all the
> > table entries.
>
> The reserved multicast table has only 8 entries that apply to 48
> multicast addresses, so some addresses share one entry.
>
> Some entries that are supposed to forward only to the host port or skip
> should be updated when that host port is not the default one.
>
> The override bit should be set for the STP address as that is required
> for receiving when the port is closed.
>
> Some entries for MVRP/MSRP should forward to the host port when the host
> can process those messages and broadcast to all ports when the host does
> not process those messages, but that is not controllable by the switch
> driver so I do not know how to handle in this situation.
>

Hi Tristram,

Thanks for your feedback.

What is the behavior when the reserved multicast table is not enabled
(does it forward to all ports, drop all mcast, something else?)

> The default reserved multicast table forwards to host port on entries 0,
> 2, and 6; skips host port on entries 4, 5, and 7; forwards to all ports
> on entry 3; and drops on entry 1.
>

Is this behavior the desired behavior as far as the Linux DSA folks would w=
ant?

commit 331d64f752bb ("net: dsa: microchip: add the enable_stp_addr
pointer in ksz_dev_ops") enables the reserved multicast table and
adjusts the cpu port for entry 0 leaving the rest the same (and wrong
if the cpu port is not the highest port in the switch).

My patch adjusts the entries but keeps the rules the same and the
question that is posed is that the right thing to do with respect to
Linux DSA?

Best Regard,

Tim

> enable_stp_addr() is used to enable STP support in all KSZ switches, so
> ksz9477_enable_stp_addr() cannot be simply renamed.
>
> It is probably best to have a specific setup_reserved_multicast_table
> In KSZ9477 and LAN937X drivers to update those entries.
>

