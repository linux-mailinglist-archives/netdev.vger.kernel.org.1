Return-Path: <netdev+bounces-142176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 350BF9BDB42
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80FEAB22406
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B3C185B6E;
	Wed,  6 Nov 2024 01:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Plp0wuOE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3683617B50E
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 01:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730857177; cv=none; b=PQPS/u4JwgKIhN4dkBQ0cWHNS/I1EwNQKRi0uMvuos37ZWJyeChNFn2UMM73TVarCtju380WDFGq/f1OpCYoWl/OUy9KdZIb7sb7BZxGAiIFQdn4LLRTZWT3X9P756cdEmZbILQx12Q8/TxZBveEeSUNw4Znp8w1ZXEVAxjW/QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730857177; c=relaxed/simple;
	bh=u8diYdJp2GDKmDyAUIfxrQxJVZaO4Y8KvT4R3Cc097U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldFoGk8pqc6KOb7J+vfCxfXtMTeQH2ZrOQFu70QF/cLPVdiWD+30QOF4+RUQlSo8c4L9+4o88omozHxjSuJvhgZBdRfUAx6AVmPpdP9oYJYeATM9J21beaKK+2tnvnc9y7cjq3tx7YJ8mktzBiRUfPmBNtLQsA/QhdqrkSM7OYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Plp0wuOE; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7205b6f51f3so5171727b3a.1
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 17:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730857175; x=1731461975; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bFiLqahKhfjkZ7pIPaChABOyOeEVctIFiElTS0MyyBQ=;
        b=Plp0wuOEtazBULFJDO9h0do8DfTu/kgnOZfXFvDelfr7XpenJnhIukvhgrACK8zXxE
         SdnMF6ZetxmmgPvvvxGHY5ujK3RCQ0mqpiva0ttCLNV3UzfPaVgztiWmp/wOU0oF67KE
         aZVrmdYIT50bcn9gIQQKMppBfuJKRBXusbXumx8vwb1h97fW9BjipTghnfBGsF/mNnG0
         hP+Lwm8lK5a3J911XPE2lER+2Lnet2UpG/6fbQvYVkZmOI13o3b/nlgoxHlIoFMyrB6a
         2FxTVau/o4GgllEMD39NcsVlQaDB7E9sP4b96EFaegPi8qHDE7A+5VP/0Lg8DLNsShK+
         IY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730857175; x=1731461975;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFiLqahKhfjkZ7pIPaChABOyOeEVctIFiElTS0MyyBQ=;
        b=mGGvU5hZvZdGvBjMzUtTKTMeZ/rtW2/KmSk0umRdsEQ4YrQZK1CP8rrvZucF/ghomm
         Kgu/sr9z6D7rD4rWbBiKf48uT2A9kXNvNdJQ24+TaI2+DmuNwoiJADNKDluJS8LsVBoD
         g6b0518jUdhxtWvF1cCs7QQ1ASkJ8wOUeyf0TJL6fdx6w7GmIDjZPvqVQeoELYpuDY35
         qT/rIwCt+8si3hpmpejbs7CLgOeNZ2wr+nnaJQih/8oHWywYyd6HVD4cFRpt3f10rSHb
         fbtPb31q1E07TBMSkRizrgp/H/xhYVh8htVmL0bDXGkGjdmLbR6fCgUjYej+J7x7cSH/
         Dcfw==
X-Gm-Message-State: AOJu0YzXgcIVx4HHT+URDM+z57AllRC9iWoUBV4dJEhTHBwmunURbMe1
	wYXBzrlyV/ja6/rK3jNBliJK84bO5FXx3DiJlam6ZHeMevS7MpbU
X-Google-Smtp-Source: AGHT+IHjNxlsPZrJOpYV0zoZZVlo/TU2gzGl/iFrrVr90fyjXQGg1Yjofg0PEYE5uW+wUYKNpnM+eA==
X-Received: by 2002:a05:6a00:92a1:b0:71e:98a:b6b4 with SMTP id d2e1a72fcca58-720c98a80b0mr24918856b3a.11.1730857175304;
        Tue, 05 Nov 2024 17:39:35 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1e780fsm10462582b3a.46.2024.11.05.17.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 17:39:34 -0800 (PST)
Date: Wed, 6 Nov 2024 01:39:31 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [IPv6 Question] Should we remove or keep the temporary address
 if global address removed?
Message-ID: <ZyrI07Dq_YRWFk6A@fedora>
References: <Zyn-lUmMbLYO64E_@fedora>
 <CAH5Ym4hAz6xRnf-o32usHj8S5ESj0cpFBb7JypDVMkq2_v0x1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5Ym4hAz6xRnf-o32usHj8S5ESj0cpFBb7JypDVMkq2_v0x1w@mail.gmail.com>

Hi Sam,
On Tue, Nov 05, 2024 at 04:50:46PM -0800, Sam Edwards wrote:
> > After checking the code, it looks commit 778964f2fdf0 ("ipv6/addrconf: fix
> > timing bug in tempaddr regen") changes the behavior. I can't find what we should
> > do when delete the related global address from RFC8981. So I'm not sure
> > which way we should do. Keep or delete the temporary address.
> >
> > Do you have any idea?
> 
> Hi Hangbin,
> 
> RFC8981 section 3.4 does say that existing temporary addresses must
> have their lifetimes adjusted so that no temporary addresses should
> ever remain "valid" or "preferred" longer than the incoming SLAAC
> Prefix Information. This would strongly imply in Linux's case that if
> the "mngtmpaddr" address is deleted or un-flagged as such, its
> corresponding temporary addresses must be cleared out right away. That
> also makes intuitive sense to me, because if an administrator is
> deleting (or un-flagging) "mngtmpaddr" they very likely want no more
> temporary addresses within that prefix.

Thanks for the confirmation.

> 
> So, I would say what you've found is a bug. Doubly so because the
> temporaries contain a pointer to the managing address, which is
> possibly now dangling.
> 
> By the way, I don't think my patch from 2 years ago is still working
> correctly: I'm seeing that my (high-uptime) workstation has two
> mngtmpaddr addresses, one public address and one internal to my LAN,
> but currently only the "internal to my LAN" one has any
> still-preferred temporary addresses currently.
> 
> Last time around, Paolo strongly suggested that I include a regression
> test with my patch. I now realize it's a good idea to write such a
> test:
> 1. Create a dummy Ethernet interface, with temp_*_lft configured to be
> pretty short (10 and 35 seconds for prefer/valid respectively?)
> 2. Create several (3-4) mngtmpaddr addresses on that interface.
> 3. Confirm that temporary addresses are created immediately.
> 4. Confirm that a preferred temporary address exists for each
> mngtmpaddr address at all times, polling once per second for at least
> 10 minutes.
> 5. Delete each mngtmpaddr address, one at a time (alternating between
> deleting and merely un-mngtmpaddr-ing), and confirm that the other
> mngtmpaddr addresses still have preferred temporaries.
> 6. Within steps 3-5, also confirm that any temporaries that exist have
> a corresponding mngtmpaddr. (Basically the test should, at all steps,
> confirm that every existing mngtmpaddr has at least one preferred
> temporary, and that every existing temporary has a matching
> mngtmpaddr.)
> 
> This test should fail, demonstrating both of these bugs, when run
> against the latest kernel. Then we can get to work on making the test
> pass.
> 
> Are you interested in writing that test or should I? I have never
> contributed test cases to the kernel before, so there'd be a bit of a
> learning curve for me, but I'm happy to do it.

I can write the test and maybe also the fixes. But it could take at least 2
weeks as I also have some other works in hand. If you can do it more quick,
please feel free to do it first.

Thanks
Hangbin

