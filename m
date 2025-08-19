Return-Path: <netdev+bounces-214937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F4EB2C2C8
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 14:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F013BFFB3
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 12:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED43221294;
	Tue, 19 Aug 2025 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfqpuK/M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E876334707;
	Tue, 19 Aug 2025 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755605496; cv=none; b=G9pASLloxck53vPFZXNIMxziIcllcnwnD7uWjM2C82cdTSeoYYtGt23oY6Isq5nu6AsC/b+0xdcgOUimPFIg7+PeJd/jkz8hyQJq7Yp422CPJnBjem4x8ZbPfGUrB7lw9NmDrUDDkQmM9xe7Et3lHHbAOqXIf0EeNDMBBNZL9y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755605496; c=relaxed/simple;
	bh=ghTe/hJO8m8TU6lItqGvP/g3/v2V2hM+Y5Q774nzWew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHzPWjl2TH3r5ykTHQegfcnefsUhllm4sfZkhLlIF+HfHJbLCHf+/8BJr/h4cEgfI3lRNWp3UbcYxxYSAIwj/9GQGpWtPB7rm3JfVP7IrFf+V5Bxlhmwk9POYoKOXqYBUkBGNEgfpOmrIE8y22gEz3SnGDVtPFGRyh2as8cptBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfqpuK/M; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b46158e11so227795e9.0;
        Tue, 19 Aug 2025 05:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755605493; x=1756210293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KRI96Tnd5IBAwt0UVHPzAxc8vO83yPZkaLZ/vLMLJLc=;
        b=mfqpuK/M9OtTaHgJzhzOBnnMds7sb3vFcHrdUbR1ddB/APtJBBim6uizUIANj162OT
         EWTpDcc6Otic9zHbM7lTcZR+iwRLgZPBvxSlMwusCykLhsE6WVcav/olfXt14h0GXsl7
         FmBnjD6Mra0UsY78s+udfSILaQKkOMcsPPw/lgQh10Uvwb5MQGBVEfb975WLdvAI4gwk
         RaPKfZbsFSENY7xv+9XdjdzDszynkELKcgeKvhhg0cQ97LBfMyR9PXLwnoFG9mHSn3Li
         W5dFsJVeORh1vGKYNLuG7wRIBFFM3sxEEftstP8YNCdbhwTuV7DmC62gfdvVHdo4W0Xq
         NsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755605493; x=1756210293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRI96Tnd5IBAwt0UVHPzAxc8vO83yPZkaLZ/vLMLJLc=;
        b=uLlbNaZH116D4K95mgwcMws0g1mY/df2+awM52y0q5cXwADdUZacIVT1xsMH8YiU/d
         ZFCwZCJA90ZkFpwDD9rUti/ycsIRqt6PHErG2a+bDi6A2Dnuwq0x+cr5Fx85cPdqeU6L
         rCgKU0hRPr7pAUqkbVzJZHcBdYr+/iJ4/AH+tubRxw2BCge2cipT62GnoMxWeR5if7Lq
         LqYlG9awVbTQmHObzd1Jy+tpU+nqUh8GPktpV+ALVia3chgtMYJM5NqQxKzO/zZ8lSN9
         LW4+ME334ohpkcsF5XR1wiZPDCzDsSlBDQtO22Ld558JPHjxA5libsIs/cm7MGpfaHve
         AnYA==
X-Forwarded-Encrypted: i=1; AJvYcCWCD94z4VAEHkNXtzUWASjJGjUEG1beVF4KVkfov64mQx7o0xW+azjwbXQhQjIU7UnhodHeJTEo@vger.kernel.org, AJvYcCWY3VezC5jS4qNjPqQyQ83JgutHsQ4bFoDq09k+AFFYmZT/su3HWyFdxlQowtICfCXDHV3RA8JSMWwPosY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfo+GDsAipFzvk0rqkh9XZXLpc0/2L74lbR+G7gUKGcrmGy3pi
	5aD6Sf26S8ApuKA0Wf2vefng/rOjWvMH/y/uLoLEk06Yli2Lxo0tVFMb
X-Gm-Gg: ASbGncvLU15sIDloCvmYIHwmOo0SRAZ+XIv1CsRTWMBFMTl+gEZbUM4AJ4wjl8b4f7N
	cFD0NTuj0dsFeTW5UdbxdM87jTh4FdirKASCHHktX08IuFA2BeA4Q4Xa7Q3mTYdppVbkBLgczU9
	qjyYL5MMwcl6BfQu4l67rYfCB2I+CYNk+TG6j9SJ7JSM3/3AcqxBQyPp/m9Z8s4edgBPMeP9Vkw
	0mHy/NzbfAZ66sEaegdrxnK2xMZIJ4ulSxx7RyH8hrLqMR5raRXf8gqEDdP5iiSTbYEyfRDjnhE
	qdzYom9Rr3fGha4OxiJr3iQcpktk4Le4y0hj5cC0Fxg5jtKxR0bCSMxnwWLqRWcEPx/J8p/lJDt
	gKIdCdYi04RIiykE=
X-Google-Smtp-Source: AGHT+IHb3g0KqyXlO1gF7yGcFxPS1MfSocspJ6urB4KB840Hl2rTj3z6kqq4Ksvh20FMSCtf6nPWLw==
X-Received: by 2002:a05:6000:24c9:b0:3a5:7875:576 with SMTP id ffacd0b85a97d-3c0dffac5camr889442f8f.1.1755605492696;
        Tue, 19 Aug 2025 05:11:32 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d005:3b00:5508:97d1:7a8e:6531])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c074d43b9asm3467612f8f.24.2025.08.19.05.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 05:11:30 -0700 (PDT)
Date: Tue, 19 Aug 2025 15:11:26 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v2 3/8] net: dsa: lantiq_gswip: move definitions
 to header
Message-ID: <20250819121126.y7jyc4xtvadnjemv@skbuf>
References: <cover.1755564606.git.daniel@makrotopia.org>
 <cover.1755564606.git.daniel@makrotopia.org>
 <a6dd825d9e3eefa175a578a43e302b6eaae2b9dd.1755564606.git.daniel@makrotopia.org>
 <a6dd825d9e3eefa175a578a43e302b6eaae2b9dd.1755564606.git.daniel@makrotopia.org>
 <20250819105055.tuig57u66sit2mlu@skbuf>
 <aKRb3R1l9XLr3DHw@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKRb3R1l9XLr3DHw@pidgin.makrotopia.org>

On Tue, Aug 19, 2025 at 12:11:25PM +0100, Daniel Golle wrote:
> On Tue, Aug 19, 2025 at 01:50:55PM +0300, Vladimir Oltean wrote:
> > On Tue, Aug 19, 2025 at 02:33:02AM +0100, Daniel Golle wrote:
> > > +#define GSWIP_TABLE_ACTIVE_VLAN		0x01
> > > +#define GSWIP_TABLE_VLAN_MAPPING	0x02
> > > +#define GSWIP_TABLE_MAC_BRIDGE		0x0b
> > > +#define  GSWIP_TABLE_MAC_BRIDGE_KEY3_FID	GENMASK(5, 0)	/* Filtering identifier */
> > > +#define  GSWIP_TABLE_MAC_BRIDGE_VAL0_PORT	GENMASK(7, 4)	/* Port on learned entries */
> > > +#define  GSWIP_TABLE_MAC_BRIDGE_VAL1_STATIC	BIT(0)		/* Static, non-aging entry */
> > > +#define  GSWIP_TABLE_MAC_BRIDGE_VAL1_VALID	BIT(1)		/* Valid bit */
> > 
> > The VAL1_VALID bit definition sneaked in, there was no such thing in the
> > code being moved.
> > 
> > I'm willing to let this pass (I don't think I have other review comments
> > that would justify a resend), but it's not a good practice to introduce
> > changes in large quantities of code as you're moving them around.
> 
> I agree that this is bad and shouldn't have happened when moving the code.
> Already this makes git blame more difficult, so it should be as clean as
> possible, source and destination should match byte-by-byte.
> It happened because I had the fix for the gswip_port_fdb() (for which Vladimir
> is working on a better solution) sitting below the series and that added this
> bit.
> 
> I can resend just this single patch another time without the rest of the
> series, or send it all again. Let me know your preference.

I think in this case it's tolerable, because it's just a new macro, it
doesn't change the existing ones and doesn't result in changes to the
generated code. Not to mention it will probably have to be used - if you
saw it is used in Maxlinear's SDK drivers for newer switch IPs, then I
expect you will also need to set this bit, irrespective of my other
gswip_port_fdb() fix which just has to do with DSA API compliance.

At least I wouldn't push for the resend of an 8-patch set just because
of this. But it's a practice I would pay more attention to, in the
future, to avoid more serious things being modified.

If current-generation switches need the VAL1_VALID bit set, and are
broken without it, then the current arrangement would indeed be
problematic and I would advise to first fix that in 'net', wait for the
net -> net-next merge on Thursday to avoid conflicts, and then rebase
this patch on top. But I wasn't under the impression that VAL1_VALID is
needed for the IPs currently supported by the driver.

