Return-Path: <netdev+bounces-178014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 355EEA73FE7
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 22:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2ADE189B606
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 21:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE4C1D90B9;
	Thu, 27 Mar 2025 21:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMi73lJs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D541D515B
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743109510; cv=none; b=tSXJUMcBPCbHFtj8TgkRGGoSEuGllzCylFdlmOoQP9dnj4J//ttY1+ubsec0SQ+LVx0bq3VA33mgHpTceDuhxN4aykYPuPgwh83rfjZqnZ4cBvKCive842UFtp/dBF0+mdnjsGfluvRPFElt94r+4NvMKSHR+UxeStj2TPlLpAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743109510; c=relaxed/simple;
	bh=Yt3BwsatZyNYaz2up+qbU7T5itRkatw2D+ZbGMF/REQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnEZCgqwrDBj9sE17cRVwgieICrSKpOBcc7qqF0wcCaTDSv4Gq/Bh0tdb7gGYSBs6p8PZPYJjLYqckH+lzeo/AEW0YXhQe+1UPGx77CIJaEdF2UhrQfXg6qOVj4cdxuNIRo0T+ESNGPE2+ftxosY00wwBBGc1Rn/w4vPOLT2sSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMi73lJs; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2255003f4c6so31191245ad.0
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 14:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743109508; x=1743714308; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6TD4upKUsUkOyeQ3/iOW5P+JAVYEKJPZTLc6dlrhOSU=;
        b=mMi73lJsvUDO2RxWKYnArS7VaQAoFkEvWNo2kUeMAtm5J6dQI1+9d6Kn/AO6z+iDnZ
         +ryKUVJWHZiKV0JdoKHH2tap5UFQxc4MopjOqDfwR3NgVsqq4SRcme0NTWXixajfgW+b
         NGc+5+jj8dQ1VdIB+4cIYYIwgY+eO2IpvEODgJYaPzzpw3ovGkeBcaJwwhVq6eWSdi48
         nTxohqhoEmdtTD6JP01nppeu+VZWjQTlriW8vrQRgTdYwxZBTmwXxRQj82mA0wOOw16k
         XToYKRtsJOAZsA0KZxFOhGYM3Yz1dlMPfpQB7B66ngirFVymarWFG8uRniKs0735sd+h
         4/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743109508; x=1743714308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TD4upKUsUkOyeQ3/iOW5P+JAVYEKJPZTLc6dlrhOSU=;
        b=OLiyW+/BSsYALAjC3LT3CdF4Nz6BlFEKqaPJBBUfWRRKi/LVbi2I2rPzpz532pBobJ
         lw04g4Bxa9AZgWorMRvGrLTsIvdUlAVBKhG1TJHja6VG9GDSp20sFC6rN04xQy8RV8hW
         5oDv5I3+ziFvCTkRS78K86ouloVhT6xsCDPVMGG3Cb1a+pN/7FS6kaT5JZ9BdMWJMJhy
         AuajlUuyNWjodEd2JhjgGILMSZxa3vHJm2G9dEuUIAuzPEqtn8z2er/lCws8BDp+vg6v
         XDjGVQCZSCIT8Qc6GWyhLBXrqN1jSSbrZHG6J9loZ+tv3zTKH2RtVEPuxxNXQWno2PiG
         nUfw==
X-Forwarded-Encrypted: i=1; AJvYcCVdAgwbSqQ4gZ8QMLISH93bb8KDFVkusrHaeUT0aU06CqR1Yo8KDkP/ZEj+vzVYZf/xAaSY7yk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyndo4P1ee5a8dbbivnJR31YRDs/mf3pnJji+yGdPMyFlfstpoj
	uz1qgMV24bBbRodmDo5aJfNK1zeeowtb3ZkzoOrBQFkICdrWefM=
X-Gm-Gg: ASbGncuc8n8ppFigc/m4xZi88fUmPt2VQ/xLttRGeRjMxJggSB6l5MFrPgrrlN0vMlv
	OkXmpjHGScLtWLwHl9MMLI5s3uhWX3cbU76JlF0oy8rWZ8wm+kDkL2YTmHBqHEAKU3ewNiy6X24
	aYsGL5hiNnXi20vaO6XMo4n0XNAl7wxUQVwigCJPKmZW9/MBB2JQEb2A5KKXlgjPEIbCi558ggC
	Frg40PEWm/X6QgrMLWM6TNnZ9IGEQo9cI5b0l04q+o/IT8qUZBaYIs/qJG3sVb560Me+E6tBr/k
	IX9AhoJMHEDA+AADoVe53MpiyKPotxCQY2dSzP/o0vC5
X-Google-Smtp-Source: AGHT+IFS0x5Om06+R9h5h6unGVz2KWSwaMGhVMDRl+epbSYtthkU1CkJRehpNOXq2+HuSXBM4ab98A==
X-Received: by 2002:a17:903:1d1:b0:224:2201:84da with SMTP id d9443c01a7336-2280481cc33mr48563395ad.6.1743109507655;
        Thu, 27 Mar 2025 14:05:07 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291f1cf632sm4249775ad.125.2025.03.27.14.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 14:05:07 -0700 (PDT)
Date: Thu, 27 Mar 2025 14:05:06 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net v2 05/11] net/mlx5e: use netdev_lockdep_set_classes
Message-ID: <Z-W9ghVoqyuHsVOH@mini-arch>
References: <20250327135659.2057487-1-sdf@fomichev.me>
 <20250327135659.2057487-6-sdf@fomichev.me>
 <20250327120821.1706c0e3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250327120821.1706c0e3@kernel.org>

On 03/27, Jakub Kicinski wrote:
> On Thu, 27 Mar 2025 06:56:53 -0700 Stanislav Fomichev wrote:
> > Cosmin reports a potential recursive lock warning in [0]. mlx5 is
> > using register_netdevice_notifier_dev_net which might result in
> > iteration over entire netns which triggers lock ordering issues.
> > We know that lower devices are independent, so it's save to
> > suppress the lockdep.
> 
> But mlx5 does not use instance locking, yet, so lets defer this one?

SG! Maybe the mlx folks can have it as part of their queue mgmt work?
Cosmin are you ok with adding this to your patch series?

