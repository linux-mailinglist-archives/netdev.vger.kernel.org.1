Return-Path: <netdev+bounces-230975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B52EEBF2925
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 18:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F4F34F857B
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 16:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA640330301;
	Mon, 20 Oct 2025 16:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="S9Y2vtOo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D3532AAD6
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979550; cv=none; b=VWlT29j5/odj6HgWjkhjVQXpJmkO6jpfdiIiaNI+fnQoR4jDFRH41Bqte0WWqBJDfb55yLvHj8pbQ0BCHYlPdbWQonDTLPUyZN6O67jCJQ4XljuPJrIh/cpY2leiaYLB/+Hl6aq3vXRPgWRr3IonGo27aw5Jlszw8e6bjEdSr8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979550; c=relaxed/simple;
	bh=G4IIEQsXq1zdqfeiQ67q5+Y4YDGcO2IWhXqVol5xqew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPQrUHQzQasrymUOQXajtNjdWdGpnCDAnkn7M5dMLkYQuKHHTYI5kgyostcpczH2U4KtpvuvewJxsGIiXbz9QnqmhpXIiZh2/00Xxs/PEELMwXYrV5mOLGJszACiUoDtc+JFjYWHRtkvdTr2ab2r5loHE8sfTAvW1I6iROLA0dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=S9Y2vtOo; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-893c373500cso181001685a.0
        for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 09:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1760979548; x=1761584348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uB/VZmCKvL9ltY4A0qr8Fdw6HiGHMx/f84IHKJJrOdE=;
        b=S9Y2vtOoTjRNJJJPwbY7Mrx20Ldi9AUcLWA13B6tx3lP7GP00VIdr3EXeC/0S4DZDQ
         MR0/SQ+JfitvcY+ok9h8tJIhRW9LTqWGTtsU6d58deYAPenkfMh+cUv2of+os3V+U3E6
         flGdnSK10ln/nWkIufNPVzqdq/wGqg79AzF11lCVBxBhaaCgPGP4xVnsTVIwCHGF5ugv
         THeGWLl4D7fPrUtkjPBH6fdVkojkgoTXqGW33MtjtfyAuemmHB7COmvSnCoAiZOGTJ+B
         73FhLXQMlMO0zfEmWxO5MwkD+IMFdKbTkFM9+dR72CuLk3uYuqgTsZcyGmjSL8Vuixa+
         88Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760979548; x=1761584348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uB/VZmCKvL9ltY4A0qr8Fdw6HiGHMx/f84IHKJJrOdE=;
        b=tgpu4RgGOkDnGNIr5fj64z79lAxonvcfuD0VnGJARfXvDdxDVzXG+yhhiEVRy34X6j
         81NMhNFi9xlsfsofGsMpHcQd+y4QhCWjVDIaevH9lyT0h35fvkGxHcC0POfp0eSgUNic
         yws2+8saoMLMh5fVjam1VoM2q5sn1tRqkCKZ4nm7Oa/x2lEwXJ4lYdGn6JKm/EAd5CEA
         D4Kxl3FLvWXPO6C3e7EEngbh1siAjW1gr3f0jDZ9Dan5BNsGARyivJ0kJ2Uav/F0Sa1o
         2xlL1UxffgDTQ74WwDCbfRR2pxWID4iojFOHU+JWEIOetVyIO4dfUfzFVkY3AFlI/VLM
         voaA==
X-Forwarded-Encrypted: i=1; AJvYcCWbQWjzu7/K+aVBsXptcMmDjmaZfUk2XqzX5b7Qfh3guuOag8YLnMlqeCOKhoNnlqabpUF0pzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL5i5tKdzLYRDbSA5nFYcKdOvPWIEBNdEjfouqtGeWuOhccpq4
	RdS4Clr5ViteTmrlm12qs7COj4NydlL/GHJ1HcbvBP0omD+zLONwvyEy0KtDoanS4g==
X-Gm-Gg: ASbGnctDadaLkxW75pYw9TRMx1eLQ1jP7tzNW9P6cdFrETVOIgoh2ZJvH1k719/66Ka
	xgO46+DDA9e0f32yNDnbQi1v0JCZ3EHEcknfIJ+VgHlTq2ekMY3HTt06QBoWgbJwZasnlc2KBrr
	sTBUUcV8gkZJwe+xgZRP/d4sFlucuU+/1QUkXqAfoUYMgR2cNz5UeFHIqu7Vsfugl/FLcZEFbAd
	K2al1vDH+nGXUknSs+1VJiknjOHfxilqBbGOmqeU/YwtBx2b9FyjsMzwGnBZgojC8RrLv1WdO14
	Nx1bViS31CW3qQlzMgSaJcDBjfnnRydPKB8GUH+TlePK58Fszq5SHMFrt+vucAGtS+DS/NWflel
	fVW1Mi2HCLaiAtoUnNtFfAaGt+bAtpIZSU2DdR4vks2ep27aMs3tmb97UkFeXC05+y0E4av5gdt
	cIiMJJOnW3864CytQU+etl5wDoJG3Zz+wPATydSUvpK9r6hgdE2dFp2yH/662tS8tOo4HoMA==
X-Google-Smtp-Source: AGHT+IGHLtr5/zlm5Vk8aYNdt9qjYP5rvB9gZkc2DEsoKbe86O4g6iczemLL9y9CqHYMB7xXk9uMsg==
X-Received: by 2002:a05:620a:4410:b0:848:af6f:cb94 with SMTP id af79cd13be357-890569d449cmr2055375485a.43.1760979547552;
        Mon, 20 Oct 2025 09:59:07 -0700 (PDT)
Received: from rowland.harvard.edu (nat-65-112-8-19.harvard-secure.wrls.harvard.edu. [65.112.8.19])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cf58e7bfsm588289785a.50.2025.10.20.09.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:59:06 -0700 (PDT)
Date: Mon, 20 Oct 2025 12:59:04 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: yicongsrfy@163.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, oliver@neukum.org, pabeni@redhat.com
Subject: Re: [PATCH net v5 2/3] net: usb: ax88179_178a: add USB device driver
 for config selection
Message-ID: <3c2a20ef-5388-49bd-ab09-27921ef1a729@rowland.harvard.edu>
References: <20251013110753.0f640774.michal.pecio@gmail.com>
 <20251017024229.1959295-1-yicongsrfy@163.com>
 <db3db4c6-d019-49d0-92ad-96427341589c@rowland.harvard.edu>
 <20251017191511.6dd841e9.michal.pecio@gmail.com>
 <bda50568-a05d-4241-adbe-18efb2251d6e@rowland.harvard.edu>
 <20251018172156.69e93897.michal.pecio@gmail.com>
 <6640b191-d25b-4c4e-ac67-144357eb5cc3@rowland.harvard.edu>
 <20251018175618.148d4e59.michal.pecio@gmail.com>
 <e4ce396c-0047-4bd1-a5d2-aee3b86315b1@rowland.harvard.edu>
 <20251020182327.0dd8958a.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020182327.0dd8958a.michal.pecio@gmail.com>

On Mon, Oct 20, 2025 at 06:23:27PM +0200, Michal Pecio wrote:
> On Mon, 20 Oct 2025 11:56:50 -0400, Alan Stern wrote:
> > Instead of all this preferred() stuff, why not have the ax88179 driver's 
> > probe routine check for a different configuration with a vendor-specific 
> > interface?  If that other config is present and the chip is the right 
> > type then you can call usb_driver_set_configuration() -- this is exactly 
> > what it's meant for.
> 
> That could be doable and some code could be shared I guess, but how to
> get the probe() routine to run in the first place?
> 
> The chip may be in other configuration, without this vendor interface.
> If we remove _AND_INTERFACE_INFO, it's still a problem that cdc_ether
> may already be bound to the CDC interface in CDC config.
> 
> Registering a *device* driver plows through such obstacles, because
> core allows device drivers to immediately displace existing drivers.
> 
> 
> It seems that this could work, if cdc_ether blacklisting and revert
> of _AND_INTERFACE_INFO are applied as suggested in this series.
> (But as part of the main commit, to avoid transient regressions).
> 
> I wonder if blacklisting is considered necessary evil? Without it, it's
> possible that cdc_ether binds for a moment before it's kicked out by
> the vendor driver. Looks weird in dmesg, at the very least.
> 
> FWIW, my RTL8153 is blacklisted in cdc_ether too. So much for the
> promise that cfgselectors will allow users to choose drivers ;)

Another possibility is simply to give up on handling all of this 
automatically in the kernel.  The usb_modeswitch program certainly 
should be capable of determining when a USB network device ought to 
switch to a different configuration; that's very similar to the things 
it does already.  Maybe userspace is the best place to implement this 
stuff.

Furthermore, with usb_modeswitch it's not at all uncommon to have some 
drivers bind momentarily before being kicked off.  People don't care 
about it very much, as long it all happens reliably and automatically.

Alan Stern

