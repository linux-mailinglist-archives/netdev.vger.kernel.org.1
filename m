Return-Path: <netdev+bounces-87043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF31A8A16AD
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 16:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6967028ABC0
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 14:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D97814EC45;
	Thu, 11 Apr 2024 14:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3rbUQDF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2286214E2C4
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 14:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844334; cv=none; b=VZYs6vALmqLb4usKNrKy+MLNxcKs8oIoaQEr9N45/XpmB8YJTrJzi+yfzdj4ld9NXP+WAPC9Cv8RwVQqT5RqmvlC1kpIb3qfQ2u150qmBLfPtjPYgMW146xQMZqUp7sqejjxykC9RwVmXpt4kkNdyYN1GDeyeUMp1BZ5pR9SVpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844334; c=relaxed/simple;
	bh=sO/k1VyPKOnENEgajkskPj9+oQuq1K/3Wv/9ylX49AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOQdQsgxKxaGn+VduwuBsCZwK5OxEUp3HBPt3E5w9QN2pxGpWH6JXeKbxWoSfw0adRNwXS3MBiQ9YsFHeGY1tSVmFnL0o4ye/1Wl3JdRrTbtLF3KEW7SRbftBKS7oNAq/ys+O7u4Lv7CQjnsL2iJAa4s/jx1xH5jzrp8Y/zpluY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3rbUQDF; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-61871eaf3c1so682007b3.1
        for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 07:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712844332; x=1713449132; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ISI+xkivGoH4G8u7U1qLHZI0IRvd5fA/fqQTszejiu4=;
        b=c3rbUQDFY6SCxBj70NwdMBD9r1eKZS4EMDMBSGhwIGwep5o2DwwZJ6WGdL7ciT6tnd
         +eLfYPsgrauWWg7Qg5fuJ2Sqy6MFpN2dZB2jrZi+VYp62O2HaQDGgJHHBbaMFwVg8bv9
         CUilXXAcTU5XeGId63ayxW5Sagv/L55A3XN3xoUBfHtYIVuRIbQye9aobMtl1TGwQtKL
         0VuedUMxeKd6bQRSgOQZWRNO68le2rf1I/ZtCS6k9I6bFsaEHm+HVSfpbmwkF0h1Ma6j
         zQn3DOUoEIm2vuBLoE2COiZXdItcAsAboLYnZQuKVp+pFGHXvDfB0q/+BaT5nRnRiM8s
         DI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712844332; x=1713449132;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ISI+xkivGoH4G8u7U1qLHZI0IRvd5fA/fqQTszejiu4=;
        b=AQDxzESD5iVVUWZXedE1P3JeJuMdTwYLAtDLe2MzS5qU93jum28hWF7eO/9FpeK53l
         BMWP+8c+5x047JcCzx+LAKmvnbatHg0epotQdyHHRN7mWi2YVeZVfH0YifHwJ9L+YOfz
         9inftenUzk2HQ3tcMoA6bO9qGMRA/cA3FlPRTbkOFYKE3nf5MR4hMCOcJ8/SGEVZec2q
         zsgoETEIm4pb8h+/qeKH/rHo7/y9QWSnyOdV15Na22oQsmZBxpURWwSnOztxSYKzk1J7
         0mV4hqqA9jNi+YNAcrtZKqR6pfFEjkELXy+sGIXrS8jPfrDwO04LEa7qN3Gp0RG35Y9u
         99rQ==
X-Gm-Message-State: AOJu0YypUMqNITWp96JTqmyToyIsjDSprmIPL3U5H9NEATqA6wW3MFxf
	aA7UHOXEFMFzd2ZoXnIcWo7s0dH/QI9kh9g/6gMXqCj+N/tju5fi
X-Google-Smtp-Source: AGHT+IE4/g5B9+n0jLctyKrzyUcTGABg2j8m0u27PyyKaMJIGc6ptNlcyk1bQUj7sHjCgnpE88qAkQ==
X-Received: by 2002:a81:d40d:0:b0:60a:55b7:8e6b with SMTP id z13-20020a81d40d000000b0060a55b78e6bmr4584886ywi.1.1712844332026;
        Thu, 11 Apr 2024 07:05:32 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id y138-20020a0dd690000000b0061248f16528sm321262ywd.66.2024.04.11.07.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 07:05:31 -0700 (PDT)
Date: Thu, 11 Apr 2024 07:05:28 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: netdev@vger.kernel.org, kernel@pengutronix.de,
	Yangbo Lu <yangbo.lu@nxp.com>
Subject: Re: [PATCH net-next 0/5] ptp: Convert to platform remove callback
 returning void
Message-ID: <ZhfuKDc0Oiiwgpjm@hoboy.vegasvil.org>
References: <cover.1712734365.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1712734365.git.u.kleine-koenig@pengutronix.de>

On Wed, Apr 10, 2024 at 09:34:49AM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> this series converts all platform drivers below drivers/ptp/ to not use
> struct platform_device::remove() any more. See commit 5c5a7680e67b
> ("platform: Provide a remove callback that returns no value") for an
> extended explanation and the eventual goal.
> 
> All conversations are trivial, because the driver's .remove() callbacks
> returned zero unconditionally.
> 
> There are no interdependencies between these patches, so they can be
> applied independently if needed. This is merge window material.
> 
> Best regards
> Uwe

For the series:

Acked-by: Richard Cochran <richardcochran@gmail.com>

