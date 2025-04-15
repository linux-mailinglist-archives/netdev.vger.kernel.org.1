Return-Path: <netdev+bounces-182741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B884A89CB6
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F0F9162780
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E741127511B;
	Tue, 15 Apr 2025 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jevSCgSJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240F34315C;
	Tue, 15 Apr 2025 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744717334; cv=none; b=qLL/3pSvoC7eOeCXj4ADi7YCZk+IbHLLym1r+8jEnVvCJFV4bRiofXexudKKelsEu7iEYwFpO3iUImhIbS7BpkVW4zs09bLHKn8TLTZDLxWMGtP95HG7wHRSXm0rrmN+o6YF39VFL5RKAywQljre+bst6A51DhlsCKL3CV15hLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744717334; c=relaxed/simple;
	bh=QhfVigsm7SBObuoA8R+qdVnqcMzh35Er9Pjuzdof8Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQkI2Qjly5K6vuNzDK1oY2Rw1M/q59orml2MCe8OSCf0lnCGbKMB+Vu75WSTphO5imWzR4E9+BEb/pVVjOo5+dNbhS4aYKWKQWOhU359flBJGcM6obzLcp7vhMTAzex4DILuSa2s+wXZgY1Olel22CAGPyW+NFKKy01PMhr7UcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jevSCgSJ; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30db2c2c609so58235921fa.3;
        Tue, 15 Apr 2025 04:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744717331; x=1745322131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i5Dh+LpffC+aAAcZFSD9TChVY9RnBWDvztPr08kGTZ0=;
        b=jevSCgSJVOBs3KAN76UNweeoMDu8wTEnIztBLhQ4RlXTm36GBX8SB7PBILDMMZDh5j
         WnsYy2LE8uCF6EBIt+XKcy8mDXYDEPuh69iO4I7q8eJd+cDscnxtO0EYvU0DeelmPm+n
         Wzqei8bCvT+XZJtV/+EEpcL+Mp1x2w1ZKYxxXcudbHrIikP1lga7NU75fulIN6f/Zkcn
         IlSEFoctT03M/BDdpvJLs/CbB8FCe3+TuJHZ1Z2SDcbMlCTOR1el4KDht4en5YMz6zxT
         EfIu9rFBsJjpDZncnOd9IY+02EZFQabnz26lnwtuBg2Ekvdrse4rhHTNcO3SNgKmTHVm
         JHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744717331; x=1745322131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5Dh+LpffC+aAAcZFSD9TChVY9RnBWDvztPr08kGTZ0=;
        b=sB3prvYAupi1zYYP36wvThYhkeGDrz7bOFm2IG7Li6R+jxLa4mQgc8W05Yhd7al8OL
         rlVxwA79mLmteSwyST4N4cOc8DxMlhU7YBMRpRXqSDG0H4LcR4k4m3C7i20bXChW+qFs
         HrPhqy08QM1TOiXn2+AfULrrDFlayraQECVPOmjnkbde/i2h1b69TW1EGNJiYStscTBS
         xuX8I+OCCWnCSdK+erun+cmG+MqK07mVG5T8LLiJPsVbVMDd5+L0Ufv8SQNNgNlqAoyW
         uA+5o7h/iuCq2gB8pUdqVI3V9yy1L1eo/XTsMne4EqFBX3vnwQl9klhFy4+7ePOYDIUG
         mdvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWlihzKb0UXni5y9KBgGbk8F2W3ILSyxu04oxXFcbAZtIeU4MWc0EYpWqR/N2c04HXzc/C+lDIdJdU6v8=@vger.kernel.org, AJvYcCX/1rPlJW+7Lk1Y9wBRbibHS70JZo+5rXxHroZKAjAQRnXVtVZHUxpwV/snCKPVwCABZ+QRw+Tp@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/8aRJbtSyu40lTdXc97U84LKelvEVRrNSW4MzMKGvsiRu8zgv
	RCN9bGFtWhhu6KU2EA0w2vVhLQoOInug6u9cPDhLFlBEJRyMqYLC
X-Gm-Gg: ASbGncsnEjXWWj2hIa3Mr2YL5ua/EEsYKmstKdBEaVBnsW7Xt0V0/KFVDZ0zw49kBin
	D23jk8qrslh5dmFiW906jjeRBHGzswCbTd8GQ+eNx4rJn94S1ZVGRj8oL5331EdKXhbBiGvwD4P
	CDMB4//+y6PvjGAGuR5xxKiFEniqgWFgpOcN4gpTYOVrscIoKxvbRQbgafvGjdLZw+4GxREsoDZ
	/iAf/FqH48vjOuOlTmgY/3ZOt4/5ZQGFe2JYrsqP0uj5gfPRaD+1ru7XeGWYnQbwvEwnp5c1WOr
	2AG3Brv9xiATWMA/krwthPaZIRcDp3HFKNq47QF7BQ2FMfhPrAynrXo=
X-Google-Smtp-Source: AGHT+IGgU0UJEysNIrkt3zaL7ZSEf7rDssLzS832i8/1eRHg+agGZPnDGAQi/zb5lfvKaIr0Llx4uA==
X-Received: by 2002:a05:651c:1591:b0:2ff:d0c4:5ffe with SMTP id 38308e7fff4ca-310499fafadmr50535201fa.16.1744717330869;
        Tue, 15 Apr 2025 04:42:10 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30f465d509bsm19870341fa.84.2025.04.15.04.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 04:42:10 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
	by home.paul.comp (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 53FBg7Tv029170;
	Tue, 15 Apr 2025 14:42:08 +0300
Received: (from paul@localhost)
	by home.paul.comp (8.15.2/8.15.2/Submit) id 53FBg7U4029169;
	Tue, 15 Apr 2025 14:42:07 +0300
Date: Tue, 15 Apr 2025 14:42:07 +0300
From: Paul Fertser <fercerpav@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: kalavakunta.hari.prasad@gmail.com, sam@mendozajonas.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        npeacock@meta.com, akozlov@meta.com, hkalavakunta@meta.com
Subject: Re: [PATCH net-next v3] net: ncsi: Fix GCPS 64-bit member variables
Message-ID: <Z/5GD1FYMLt1fHCB@home.paul.comp>
References: <20250410172247.1932-1-kalavakunta.hari.prasad@gmail.com>
 <Z/j7kdhvMTIt2jgt@home.paul.comp>
 <ed49eed8-3e0f-4bda-aa30-f581005c4865@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed49eed8-3e0f-4bda-aa30-f581005c4865@redhat.com>

Hello Paolo,

On Tue, Apr 15, 2025 at 01:09:42PM +0200, Paolo Abeni wrote:
> On 4/11/25 1:22 PM, Paul Fertser wrote:
> > On Thu, Apr 10, 2025 at 10:22:47AM -0700, kalavakunta.hari.prasad@gmail.com wrote:
> >> From: Hari Kalavakunta <kalavakunta.hari.prasad@gmail.com>
> >>
> >> Correct Get Controller Packet Statistics (GCPS) 64-bit wide member
> >> variables, as per DSP0222 v1.0.0 and forward specs. The Driver currently
> >> collects these stats, but they are yet to be exposed to the user.
> >> Therefore, no user impact.
> >>
> >> Statistics fixes:
> >> Total Bytes Received (byte range 28..35)
> >> Total Bytes Transmitted (byte range 36..43)
> >> Total Unicast Packets Received (byte range 44..51)
> >> Total Multicast Packets Received (byte range 52..59)
> >> Total Broadcast Packets Received (byte range 60..67)
> >> Total Unicast Packets Transmitted (byte range 68..75)
> >> Total Multicast Packets Transmitted (byte range 76..83)
> >> Total Broadcast Packets Transmitted (byte range 84..91)
> >> Valid Bytes Received (byte range 204..11)
> >>
> >> v2:
> >> - __be64 for all 64 bit GCPS counters
> >>
> >> v3:
> >> - be64_to_cpup() instead of be64_to_cpu()
> > 
> > Usually the changelog should go after --- so it's not included in the
> > final commit message when merged. I hope in this case the maintainers
> > will take care of this manually so no need to resend unless they ask
> > to.
> > 
> > Other than that,
> > 
> > Reviewed-by: Paul Fertser <fercerpav@gmail.com>
> 
> @Paul: it's not clear to me if as a consequence of the discussion
> running on v2 of this patch you prefer reverting back to be64_to_cpu().
> 
> The packet alignement should yield to the correct code in both cases.

But it might produce warnings for the v3 variant so my understanding
is that v2 is perfect and can be picked up (other than the changelog
included in the commit message).

Thank you!

