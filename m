Return-Path: <netdev+bounces-118713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 713B395287C
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 06:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D651C21231
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 04:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94F42C182;
	Thu, 15 Aug 2024 04:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N291daD4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEF2AD5A
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 04:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723695806; cv=none; b=V2bUPcOtCR1cdppQyoCii0AKS4s71T9V+tNzT1JajE4TSo29Uw9KRUog1VcSoIa2toZoynpV/QzVsNGbC2y866qLovGD18qe3Ulx/VzWoe9vlRC7C/nblV7NPTnOqOXwoLtyMy94BxmBmGgKc5meR4kEMOFg8G13IYL7tPfSaKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723695806; c=relaxed/simple;
	bh=EPP4294I3zMcUnZnzSyKGjSnacaLRnrphw9BFh8eBZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnY4s8gR6063tI/JfTwiaqfkjrYTLtoeyD0r3YTvM/918h+ayn0S7ka65n9JZM99wnh0By+4AZs5WPYjfDOIvju77yV6XtsR1twMbVHmD7Ech/rEzW4BXf08ci82zC3oLblxroDyzy5oXhXB66yW8i7fcagTKPR1M6elVEZcV0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N291daD4; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2cdba9c71ebso95022a91.2
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 21:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723695805; x=1724300605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/TDAc6ZiAtnYD1AofAz83sJPi0+fKx57hTg02ey83Oc=;
        b=N291daD4N9qFxr8/T7xS1RAl/WSqrq34mDnzh6XFjA8BNYtOufyBaSfH72kyhUkF7t
         F8KD73EBOG0MdwpXW/PT7XvqEUM0LQ1SPyATxaxdh++dbfZxXAwn7BaZllNXZGIn95Mf
         4kTb7J86RIOuCDfkBEFTXSQ/4SosrounHfwDwR/RW1q19ZjT0/diD65usf0yTH5DQY8w
         hskT5FxPI5X0LEygxX5ya9OiXPt8gCfKbfebznJfyldJElp8/YUobsdB/SVuRUkZIG3H
         fSgTkho5fQ4GqjjBNmBp26o1gO2LsVa3wsDPr3DI1jkFFQlylNssMV6msWvMI9/Isl3U
         qR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723695805; x=1724300605;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TDAc6ZiAtnYD1AofAz83sJPi0+fKx57hTg02ey83Oc=;
        b=kLpBiOABucHx09oGZAx9pytq6WecZiXnrbERESaK5eWVZTmWI6e/Eosk63GEsUTeeC
         BQgfTjkKp9nazaWMDpwdq/Th+ADKY87PTeN+USt6b4RBj9L8e0gBy4m0SJc1SY0GBQtK
         OsviS7c1n54aGjD9PGqjjPNw5TsGxe0V9lS8a/pFcHH6ZyZxuFotM9OV1te8RJerGUY1
         n3eR3UBysMr/GPEvIHpH3VOZCCLihNcY8iVNS2hXprLCjOK/z0Fl6n+GoIbun13vMtui
         1A32iEYbNS6HWLxgj9cNOdBFIooka+vrIs5n/DwrQJKAsrZl/FPx4b6PAKUQHCqzAcK/
         RgXA==
X-Gm-Message-State: AOJu0Yw6sUtkcZE1J8WlC9CgCK/9wYqBSrjx0S9OCI93JPKGGuoiIncb
	eC7kDyENxyF0/j92EiTnxTr2t5iF7nqQ2Nq/K91MnMF29yNlOw/G
X-Google-Smtp-Source: AGHT+IFtXRK0Alo1giD2k+Jx1cpvRiKedHH1LIFhhNl94oqCsW3PaezDFw/+b+1XBFaGzeS62yPaBg==
X-Received: by 2002:a17:902:e546:b0:1fc:5b41:bac9 with SMTP id d9443c01a7336-201ef974affmr10022695ad.7.1723695804573;
        Wed, 14 Aug 2024 21:23:24 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f031c68bsm3766215ad.109.2024.08.14.21.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 21:23:24 -0700 (PDT)
Date: Wed, 14 Aug 2024 21:23:22 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: netdev@vger.kernel.org, jacob.e.keller@intel.com, vadfed@meta.com,
	darinzon@amazon.com, kuba@kernel.org
Subject: Re: [RFC 1/3] ptp: Implement timex esterror support
Message-ID: <Zr2Cun2AhVLRAm1t@hoboy.vegasvil.org>
References: <20240813125602.155827-1-maciek@machnikowski.net>
 <20240813125602.155827-2-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813125602.155827-2-maciek@machnikowski.net>

On Tue, Aug 13, 2024 at 12:56:00PM +0000, Maciek Machnikowski wrote:
> The Timex structure returned by the clock_adjtime() POSIX API allows
> the clock to return the estimated error. Implement getesterror
> and setesterror functions in the ptp_clock_info to enable drivers
> to interact with the hardware to get the error information.

So this can be implemented in the PTP class layer directly.  No need
for driver callbacks.
 
> getesterror additionally implements returning hw_ts and sys_ts
> to enable upper layers to estimate the maximum error of the clock
> based on the last time of correction.

But where are the upper layers?

> This functionality is not
> directly implemented in the clock_adjtime and will require
> a separate interface in the future.

We don't add interfaces that have no users.

Thanks,
Richard

