Return-Path: <netdev+bounces-120609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A872959F25
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50CE0284F51
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 13:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2F11AF4DB;
	Wed, 21 Aug 2024 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbYdbZts"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398B11AF4EB
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 13:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724248745; cv=none; b=JNQvhIRaL+1VVBzGX2lnn6r4pPKIuVxlRA2i+euU0gcMCBSasTJ9Yntj1zsLOhv7LMp30JZ4FbaOejDguCc0i8wbUc5/a3oOhnlY29kUxmkRUwShpxiPBRSrsAcsF3oun1OXRPCxJTlPVzj0BUuvlIp12RcUw/KHT4uizrTHnLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724248745; c=relaxed/simple;
	bh=9SOEX+EJf4kKCLAr1loMA9CbUP6lPUTyrgzSyq2U5Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esA9p/WHG2CdpJwyOW82Lb7RoZVoYOZwxDDmmFqMfL1zBhu/xjZONxoneeGOmTSsBpfGOnCGSy80Ch+tjtKjofBIoLmkbTtzy2w+8ytn31qpcYoOQ87NnMFQF8YXjwbFgsYwsR0qYQZNDaR5y+4UdHPlpn48GHzzrt6DWKPbtG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbYdbZts; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5334832fb94so197483e87.0
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 06:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724248742; x=1724853542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3UAdG0AdRcRChlhzFKRWZNgqeN0o/Y4fG9SaGkycZLY=;
        b=AbYdbZtsy9+xUROQIdjDubJHCUbc6qOut+4aU6sPfaVxTHyFS4fOuznWg1hMT4YQla
         AYHU5JikNHKZC0x4L5AATe1XA9kkDSUUpUznhgceHnmvvPdGvFB7db7lEDA20ntnk/x1
         rlwSLEwkyJKrxJhkzmSr8GDu970pjX5jWSoJeU/fsd/F1peodVS3JH0aRY0XTI47zwO+
         QTYNg5a/nbAMTaUMcbZT5i9Lf76OqafDrRyWNZsRLJCsCXF4+qOLAjSi3Xd3TZEX6eSf
         k5B5m9Ry1UMITpCcEVgW9L2J1oVV70qbISHeiD206xIoqW82MQkJxPjrQjfWasdSFYB7
         o4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724248742; x=1724853542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3UAdG0AdRcRChlhzFKRWZNgqeN0o/Y4fG9SaGkycZLY=;
        b=oVcLeBGy8eYZBMPH7Cyi+fwgoeqAhkLFCV+7ZU3s9oAGRW285wMNMyl6lz+d5r3emB
         b/ar2r07QEDobnB1xtcmFdX662GrPMcrQZ/FXz0o0KSoH7SmaHyHniypv5VudSWlXdlE
         bPBtwjecmdxfz/Nr8sjmd/etPUulup6GjXR2fj1rrrWWjHserCQiEByhlfmOmD3Sv2Zv
         +pmM2IS5V0XfNk6LbzKYRZUjSlZmECZUhgBLO+zG0yd9YimsFEkYkk7pkCDL3IY50YDW
         W6QhlqwTFGk6qz6P4NKgk9S2YnENFKyhfm8eu7rwIhptgqRMpXOnvbwXKdjuzMHEhCwB
         M44w==
X-Gm-Message-State: AOJu0Ywgj72t7E0SUhb/68ZVDLCq0+uB9GKo4DS8x3ZBSUvBW9HOpseT
	YToCdtzQH9BdxzFBBpkDueuFc3rwrXfV7lOQEI3infltO/AIBsjCcSMs7P04
X-Google-Smtp-Source: AGHT+IHBNjoQQ0/mpJVR5U2F5fHD/KN3qfMaSum4ixNhhQG94hHjPkFgcnml1jidivDjNr9nvzS5og==
X-Received: by 2002:a05:6512:3baa:b0:52c:def2:d8af with SMTP id 2adb3069b0e04-5334858bee5mr952785e87.4.1724248741686;
        Wed, 21 Aug 2024 06:59:01 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83839472basm911512166b.170.2024.08.21.06.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 06:59:01 -0700 (PDT)
Date: Wed, 21 Aug 2024 16:58:59 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: lib/packing.c behaving weird if buffer length is not multiple of
 4 with QUIRK_LSW32_IS_FIRST
Message-ID: <20240821135859.6ge4ruqyxrzcub67@skbuf>
References: <a0338310-e66c-497c-bc1f-a597e50aa3ff@intel.com>
 <0e523795-a4b2-4276-b665-969c745b20f6@intel.com>
 <20240818132910.jmsvqg363vkzbaxw@skbuf>
 <fcd9eaf4-3eb7-42e1-9b46-4c03e666db69@intel.com>
 <7d0e11a8-04c3-445b-89d3-fb347563dcd3@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d0e11a8-04c3-445b-89d3-fb347563dcd3@intel.com>

On Mon, Aug 19, 2024 at 02:53:34PM -0700, Jacob Keller wrote:
> The patches work for my use-case! I also think it might be helpful to
> add some Kunit tests to cover the packing and unpacking, which I
> wouldn't mind trying to do.
> 
> If/when you send the patches, feel free to add:
> 
> Tested-by: Jacob Keller <jacob.e.keller@intel.com>
> 
> Alternatively, I could send them as part of the series where I implement
> the changes to use lib/packing in the ice driver.

This is good to hear!

I did have some boot-time selftests written, albeit in a very bare-bones
format. I'm afraid I do not have as much energy as I'd wish to push this
patch set forward. Especially not to learn to use KUnit and to adapt the
tests to that format.

If you wish, here is a Github branch with what I have. You can pick from
it for your submissions and adapt as you see fit.
https://github.com/vladimiroltean/linux/tree/packing-selftests

