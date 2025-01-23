Return-Path: <netdev+bounces-160588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3818EA1A6C6
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 16:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427583ABA12
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 15:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB953212B13;
	Thu, 23 Jan 2025 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="sf3lvnqI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108E4211A3A
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 15:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737645114; cv=none; b=rDX7TlHQKxBqWImTvSKRkydQ9123lhaCWpjN+UEM7ypAIFrKEp4uR1GGebhcL+BaOdf2NtiMZQNkT5E8V8rgLoa0fcB9ToRE9j5YmJr+1oVAzoO4xkLebmqGEm1VH4c3W3y7HeL7YlUdanLMcwv0v1/zAJc0lIwaVdVnP5Da87Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737645114; c=relaxed/simple;
	bh=9F/OaSn8fuweFCH3ladTWTaTydc93sP5hBxUQpgO0Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9pkKLsWRSxC6YtsChXtj4CchJCAoos5qcATL8Ai+HSRR7uc5O6gixwUH4CcjO+OdUBdPwBJ5qwDKoroiykqQX/au58c7x1z8z/k7DYlF7weXmtV8MsqXwazpmA3TKNhEc5ey438/PQJDyWzG5lipF7Ac+4dwqmAU4we0Su+b38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=sf3lvnqI; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d8ece4937fso8673716d6.2
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 07:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1737645112; x=1738249912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=631aiENuZfGBJPCs1cywEgmvIT9kJQOpty8zcOly6Oo=;
        b=sf3lvnqIGGs1t/3jOZ0Z3bpfQclWIlKEhG43WZVATd29yl2KmcvUhPx9nA9JXMUwkX
         de6aGhYOqwcu0NhUpVHce0ujhhycYjExtsIZ5ZDz37M3B27GzFn7VnF0YxaMRCqg6hRF
         6mWclZKX9AN8XGBLwmmaCI4T6lpINTgxNlu0ZIF28Wf2MtDsjLbZsK08dpzgpKM1P2tC
         OghueD/w1FG+BR5TlvE53US6NqEEowug+L2jtBmhe510kZg39pBcd9DYDO22MMRXKv5s
         G8FlXlypu0l1qlvaWR96BCNV2NGHYRf3PPRoWVGuMC673zVJMo0L/avKsFf0y+VvLaU7
         XwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737645112; x=1738249912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=631aiENuZfGBJPCs1cywEgmvIT9kJQOpty8zcOly6Oo=;
        b=Za68+XcqW3gFmurl+AbNdujPxqB0Bz595M2HwfFyPsNJGFBn7tTjkBv7V5A5FSvf4g
         BIJelpnQbqufb1wbQ7ADLCiumMIMS4tH+pNd3at/HcEtk86dbMqqWHB5rCHvaymP7Xn+
         Bm4LBMRSXWqTi5G9NauQITn9t6hcbPamDAUaiOLshhgeM2xVRL03/CYGEcNVMH91GdoV
         CrZN+V4utDvx2HIX+J+viQfPEweTKq44PMEfamhjMlgWhlYnNuTeNu835keXm/ijg7T5
         9ECcG7EpQTedUKMNK1LdKEL8O5FrR52CKMmTbcGJh8XmYd/wiZmAXi6HxOJ3sQQFq+vT
         qlHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZmyknN3sO7eDh7XyHkWFC50SjoKG5YrjsX3whehj4BZzJfRUp+sFtazpXaZQf1TSPC0oFAHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKUiqqB4ac3PmDpwkakuU7R50BY/vuPc/YBP6V+LFilN7JzxUk
	5avLhG2sZUuR2lmusjRkAttXkrql8qjBiyz4ElfumddMZOSfaGjErSizTBULfg==
X-Gm-Gg: ASbGncunvZLZbDZFssgmtfNVTVOWG58XRtkxqR3RrN7XLePcjZmThoJlO4MFCzuZ87p
	7Qolde9vVzq7HxXSRkZRRwaVIsKCUGK8Fxy2YMIOx7+LG1as5pCD6EGcuOshNZ+mmua+1N31SPr
	d5nGFYPcCoLl84W3U6rrgb/VOcxNADnueCwVzlg2z2HcWPwZz9aA6RE6bHRJpdnh9HqAL/+PgYC
	4oBlYyhl5ybyldwjQ7eE4n+5QUr3uc3SvgJFVfxbLK0rxhKmdkd04IsAolN6i2HhQzWf3Q5wrrh
	B9yFZzvM2ucxiGlPNUcUcSk=
X-Google-Smtp-Source: AGHT+IFUzFZYic8b37Oq8op4miNTXO7cwki07AlbPa1AyzBG78+xrz5qJpCoIBrPSuDV9oVi5Ns4PA==
X-Received: by 2002:a05:6214:570b:b0:6d4:25c4:e772 with SMTP id 6a1803df08f44-6e1b2251083mr497962286d6.36.1737645111911;
        Thu, 23 Jan 2025 07:11:51 -0800 (PST)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afcd3859sm71567576d6.74.2025.01.23.07.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 07:11:51 -0800 (PST)
Date: Thu, 23 Jan 2025 10:11:49 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Petko Manolov <petkan@nucleusys.com>
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	syzbot+d7e968426f644b567e31@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH net] net: usb: rtl8150: enable basic endpoint checking
Message-ID: <0a063f6a-cce7-4a78-99e4-7069e37ab3d9@rowland.harvard.edu>
References: <20250122104246.29172-1-n.zhandarovich@fintech.ru>
 <20250122124359.GA9183@bender.k.g>
 <f199387d-393b-4cb4-a215-7fd073ac32b8@fintech.ru>
 <f099be8f-0ae0-49c7-b0bc-02770d9c1210@rowland.harvard.edu>
 <20250123094930.GG4145@bender.k.g>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123094930.GG4145@bender.k.g>

On Thu, Jan 23, 2025 at 11:49:30AM +0200, Petko Manolov wrote:
> On 25-01-22 10:59:33, Alan Stern wrote:
> > On Wed, Jan 22, 2025 at 05:20:12AM -0800, Nikita Zhandarovich wrote:
> > > Hi,
> > > 
> > > On 1/22/25 04:43, Petko Manolov wrote:
> > > > On 25-01-22 02:42:46, Nikita Zhandarovich wrote:
> > > >> Syzkaller reports [1] encountering a common issue of utilizing a wrong usb
> > > >> endpoint type during URB submitting stage. This, in turn, triggers a warning
> > > >> shown below.
> > > > 
> > > > If these endpoints were of the wrong type the driver simply wouldn't work.
> > 
> > Better not to bind at all than to bind in a non-working way.  Especially when
> > we can tell by a simple check that the device isn't what the driver expects.
> > 
> > > > The proposed change in the patch doesn't do much in terms of fixing the
> > > > issue (pipe 3 != type 1) and if usb_check_bulk_endpoints() fails, the
> > > > driver will just not probe successfully.  I don't see how this is an
> > > > improvement to the current situation.
> > 
> > It fixes the issue by preventing the driver from submitting an interrupt URB
> > to a bulk endpoint or vice versa.
> 
> I always thought that once DID/VID is verified, there's no much room for that to
> happen.

Unfortunately that's not so, for two reasons.  First, the vendor may 
change the device's design without updating the Product or Device ID, 
and second, a malicious device may spoof the VID, PID, and DID values.  
(Or, as in this case, a fuzzer may try to fool the driver.)

> Alright then.  I'd recommend following Fedor Pchelkin's advise about moving
> those declarations to the beginning of probe(), though.

Agreed.

Alan Stern

