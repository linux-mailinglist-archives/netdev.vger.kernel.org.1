Return-Path: <netdev+bounces-201245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97545AE895B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27D53A4CCC
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F7126A1CF;
	Wed, 25 Jun 2025 16:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGeVXeKQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045FF263F27;
	Wed, 25 Jun 2025 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867904; cv=none; b=tJ3UeTTtSTzvunQ/+DtEI02ng2c0cMKdrZOhY8UOUGKhXnk5rEDFXsH5afjmxgBL0qCnPM3AUslUJAGrZotyFWnQdB5WH7vy87lphM8Ye9x0v4+RNbj22nbzF0t7zAsj4tmnleoEggxa2sARQqUVeHKXUaszdkoevjUKv8+Psvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867904; c=relaxed/simple;
	bh=fiDY7UQhwHZHJ59VnbCeNiiR00xsBG2CfKUCsGGKFro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEMiIHLZBBHqFUjkq4zEUsaFyHjREcr4e6gs8KbjBfxbmUdAersUOIiDITN6enkyGuSrlEmyVBU1YHiIM31EX/dl5VlqOTG64HD9hTRrLmRhtCyyQFUu475VkeDlrOm82t2VCkcwjDnayy9mzIwRJ90h6Uc9lJyfCii8bIKypW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGeVXeKQ; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-70e5d953c0bso602797b3.1;
        Wed, 25 Jun 2025 09:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750867902; x=1751472702; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fiDY7UQhwHZHJ59VnbCeNiiR00xsBG2CfKUCsGGKFro=;
        b=FGeVXeKQWM9xLVTXU1IHjHQWK3v72FtcG+ffugRsi2uwsXxdRRHjhbzv6LfK1OIfpO
         fFDFUmmWw72Zio1+mcyDYN8EHKIdDP8/eMft1G4hoeOEYOIOQcTdqA5Qwr8SaAlJKr7e
         QNKRYWJZyHi8gooKuS8GWgap5/TKRcqIkniXDxEd9mydhLzG2W7bWgegYTPZphFYqXaS
         hbqrslOez5sKx1bq2fu9jaIQLmcDsCIzI3LlWUh40ZRd5AlMFxo0apyDoXq+cjrDT/cB
         wRdkhI75cBYR83/81i7MnyBrd/bpzc2ND4QTSzQ2P0IOCFAd7amUWwnKqP4GDdzc14nI
         T2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750867902; x=1751472702;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiDY7UQhwHZHJ59VnbCeNiiR00xsBG2CfKUCsGGKFro=;
        b=ti7iExNYi8Y16TikQyeKJa1n29mCdfqahfW/wjLEJu3c1fi6HX7oyVT8SmR8MAtALV
         yNuUwiN3aLiKXnCdGc7Fd9UDUsUWz3XuFXJztrQIC73dpLySmgYSuxaQDf6d+f0ZsodM
         4uBRi7+AUNGbXA7TizIPC8lS7ty5nxd1TirgTvztVTIZYE0Pi9B96zB6NhSpFTlErcRl
         Nr2CnCTukDbvabM1kJbcgMtwuC8e5NLFrhNH1zeKhyhr0PYPpjSHCQLj6b+wG+h/LCBR
         trzZQv1FSF3LwiDRPAHYjcgjyySfgvz7FJ75xeiDU3QkcDrko1yuv90D8x6+IjKfJHmP
         8TvA==
X-Forwarded-Encrypted: i=1; AJvYcCWtMkxaR5ZwnaGtaDoaD52IuW0A/JFtGQLVw4rFXXOySnuz5N0ocfLWYVN4+C5sACEuW4ZbuAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSaEh6/Sn82iXrQFN/OudV6JL+sd870iBjXzSj3mHxmP5Bl1n1
	bTI3Jji9cOnryZoLkSu5eadit0vf5Z1VPf/cCm75Wz7FA6RzMfAO2sjYlRjdtw==
X-Gm-Gg: ASbGncvEdzKI/1R+oZcCx7dUv68EgD/EVsHGvv54b5a3npf7CqtUmK1Cm4ZwAo6+8NP
	Q9dhLKdzfU9SzmADFvmscfB1En9mc2LtcD7byMOUdprDP5MmuEXX8DY2TvERD+aEnjUKaU2XSas
	+kJn4lAYgjO86lh8P93J86TmBXKN+UA7gkQ5rXLdi3++Xv8bOStk57htiJaAZljwWOTz3RRRftg
	BcWlGeMUjly4b2PrZ15fbYbO2CfxW9fazF4wNXKm5FHKVPcbp80S6/MhQItYnuOAiBX+HGEjX+K
	TOMDjijfl2NYybcH4vbDX2CeWegOXsvlcfhJxtFAbafX+qveMsTIH6r+yKH/wA4Mp+qMusCTqNm
	qA9VbnERDX+avKExN
X-Google-Smtp-Source: AGHT+IEcju23gCZ/YfeD27VrtKWESCsPd4NKeo1UzcTwNfpNS5tPqX3GMc3h4E+X6tR26USS5tyE1g==
X-Received: by 2002:a05:690c:9418:10b0:70e:2355:3fe0 with SMTP id 00721157ae682-71406d192e1mr39357047b3.16.1750867901945;
        Wed, 25 Jun 2025 09:11:41 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-712c4a219b3sm24940667b3.44.2025.06.25.09.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 09:11:41 -0700 (PDT)
Date: Wed, 25 Jun 2025 09:11:39 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [patch V2 00/13] ptp: Belated spring cleaning of the chardev
 driver
Message-ID: <aFwfu5oWk1d7NjE2@hoboy.vegasvil.org>
References: <20250625114404.102196103@linutronix.de>
 <aFwKc5R3uZVc_aoH@hoboy.vegasvil.org>
 <87a55vrelj.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a55vrelj.ffs@tglx>

On Wed, Jun 25, 2025 at 06:05:44PM +0200, Thomas Gleixner wrote:
> You sure there were no forbidden plants involved?

Not in Calyfornia :^)

Cheers,
Richard

