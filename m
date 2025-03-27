Return-Path: <netdev+bounces-177976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB08AA73597
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 16:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B08717B0F3
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 15:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C9718C33B;
	Thu, 27 Mar 2025 15:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKWM14mb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645C318A92D;
	Thu, 27 Mar 2025 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743089311; cv=none; b=bSc3VeUNsvFSVayQvpkNmgn4Q0IiS7PwZeG3NJi1BtukFbEGqm+NKs04VT6C0bkvum8n9z38h6n0ThJe6sY9gtm2rRiLb/pvPYOwIh8HkQr/a9elpcm1iz264O9DHwKYJ3lzHUduKaHyVEw5f9Gv2c+IFGygsQ0RMXCG4W4cIpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743089311; c=relaxed/simple;
	bh=pwcalWL+tv3tIR/6p/tg0ukx76u/ZEj9jnPrIlgh3sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFoemA7pMpvw7b/C1s9HQr2rybGNSKv/+MrOc2fiJWFuJzpDLdaA1V+Hzjl4dvBD20I7vlrgyyY4pH0jaaSsP04qSdU3LlrwV/rVs1J2+6hm3lYuF0MR7oacz30y91AxWZcJP/Ge0HXH/tYq3dNvmQjhXgLCYvvAkxgeKSz+AWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKWM14mb; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-30384072398so1498519a91.0;
        Thu, 27 Mar 2025 08:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743089309; x=1743694109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RApsfE2Mk8xKmp10Ee1OdgidthdVR9yq6wKOoA6mDUI=;
        b=eKWM14mbX07ClP8n3Fx3qJZCUN5AcGNTK4qc4lXx0zt2mpFiU6Q7ErS1A4drJPFN9X
         IfhmmydqRDWjTSa6tWxU/sEXjutrACaxg0cfddnAxW3OzxFg1i+Iea+Wj+NDZnulUKVD
         eQVs6FmeyH3rNmghrOgVfTenTznamWlhzFg24Yk0On/Ok/wMUcV4wj0XWtyB46StkO3w
         FjPdFJW3Bq6lYo7C2idUNmDP/Ju8y9ksWbqIuQuGQ1e/syY9KmLlZi2VRGIVqwDyUNts
         ManPbdBoU0gYRMn0MKIehYqxtIpsogWHWC28NX4goDsoXFlGGRv+fTCjmqxBe+rcETNF
         5zig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743089309; x=1743694109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RApsfE2Mk8xKmp10Ee1OdgidthdVR9yq6wKOoA6mDUI=;
        b=miJomiRDZTMQWWSFDZ1+70KCOOZ1sWGYTjQUxUsyo64R9XYx5qxG87beBOFmO64OfZ
         lPKQgBLGUqE8VxGg7tD2Nf+qJsxSlSKoMGghfbtfzWGmXCPQRx0OIjKNH+RLRxyUWXKY
         7w0aprNHgW4snfBomWS14dPBOq6h1/5neroMdqJJthmo/fxUQ92piwl+oalM3lEtvLfX
         bqd6rZIXVIHB1u9nHkJQAacalfy6zVOn4koFWfhGKiPJ/YyG/NoifzBKvZ9HQ9D+KM0t
         n+cFZvqLaE4YEtb2bkO13vLDtXJ4Fw1LdqRmfBAdnMu1D9FfLY+TaCe2mgBQlECJ262n
         SBlA==
X-Forwarded-Encrypted: i=1; AJvYcCWuIYG4p61fKETRiPbP30CAXZUE9hhnWCrRXx63AJ+MxM5qNmW+gDAc74VX8onc1NvqH09npiFY@vger.kernel.org, AJvYcCXJNFJxyeqejW53GU1QGFPeAFDP75ULzsC7M+LU060i50ST3/UjaWVun+X+xkJlEDG/B2R7iKE0xKdR13o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGFjGfI7oDGSZS9wpektmXKCE9fDecewTCWBnUQmXrcl9ScqFM
	3dkz+NjuDUzn9wZKoJYpOzTyHm3CUZVvlfrPlPY31daJxGpJnn2m3K+Ukw==
X-Gm-Gg: ASbGncsnhOtLjqRr/swZKRw2O0qh3QewC7yQbJzPHgkG+gUsVAW69zMewuqSVGEJF7L
	/yabNJzLsOeN7V2rvoWPcbDii2rZDdUCOG51HrLphE0pJbtdMxxyUtGSPZH+cQpSpIllaVnRado
	BRdZU/GXsRpJg/mX8hIn3OEkacvsWB3jH0bp3LwoMfZ8BSVUYihyT4ha4XJUObtDM2YW4cQhm++
	LE6xlUVc6FOm/VvYhKIJhepg2VS2XluHDRnohLVdQiFg46+/Tj+TdklWrJaGAqaF9721ORp2/kL
	OM8oSbXnVbYnGNFmcTB+otNlOeTmoCRDV7JBNOphKlUnEB8=
X-Google-Smtp-Source: AGHT+IFKe4SnRU7PQNPjFKnvpnqknx+ZVQ8R+bntltjtUdj5i2np/fCn6XDl4F6x1Uj5AEPpg3bUQA==
X-Received: by 2002:a17:90b:3d0a:b0:2ff:53ad:a0f4 with SMTP id 98e67ed59e1d1-303a7d6a99cmr7351484a91.12.1743089309356;
        Thu, 27 Mar 2025 08:28:29 -0700 (PDT)
Received: from eleanor-wkdl ([140.116.96.205])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3039dff0c76sm2360160a91.20.2025.03.27.08.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 08:28:28 -0700 (PDT)
Date: Thu, 27 Mar 2025 23:28:25 +0800
From: Yu-Chun Lin <eleanor15x@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: isdn@linux-pingi.de, kuba@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jserv@ccns.ncku.edu.tw,
	visitorckw@gmail.com
Subject: Re: [PATCH] mISDN: hfcsusb: Optimize performance by replacing
 rw_lock with spinlock
Message-ID: <Z-VumXiqJJkZKNZZ@eleanor-wkdl>
References: <20250321172024.3372381-1-eleanor15x@gmail.com>
 <20250324142115.GF892515@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324142115.GF892515@horms.kernel.org>

On Mon, Mar 24, 2025 at 02:21:15PM +0000, Simon Horman wrote:
> On Sat, Mar 22, 2025 at 01:20:24AM +0800, Yu-Chun Lin wrote:
> > The 'HFClock', an rwlock, is only used by writers, making it functionally
> > equivalent to a spinlock.
> > 
> > According to Documentation/locking/spinlocks.rst:
> > 
> > "Reader-writer locks require more atomic memory operations than simple
> > spinlocks. Unless the reader critical section is long, you are better
> > off just using spinlocks."
> > 
> > Since read_lock() is never called, switching to a spinlock reduces
> > overhead and improves efficiency.
> > 
> > Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> > ---
> > Build tested only, as I don't have the hardware. 
> > Ensured all rw_lock -> spinlock conversions are complete, and replacing
> > rw_lock with spinlock should always be safe.
> > 
> >  drivers/isdn/hardware/mISDN/hfcsusb.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Hi Yu-Chun Lin,
> 
> Thanks for your patch.
> 
> Unfortunately I think it would be best to leave this rather old
> and probably little used driver as-is in this regard unless there
> is a demonstrable improvement on real hardware.
> 
> Otherwise the small risk of regression and overhead of driver
> changes seems to outweigh the theoretical benefit.

Thank you for your feedback.

I noticed that the MAINTAINERS file lists a maintainer for ISDN, so I
was wondering if he might have access to the necessary hardware for
quick testing.

Since I am new to the kernel, I would like to ask if there have been
any past cases or experiences where similar changes were considered
unsafe. Additionally, I have seen instances where the crypto maintainer
accepted similar patches even without hardware testing. [1]

[1]: https://lore.kernel.org/lkml/20240823183856.561166-1-visitorckw@gmail.com/

Regards,
Yu-Chun

