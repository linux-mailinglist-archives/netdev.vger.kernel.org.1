Return-Path: <netdev+bounces-126575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E86971E21
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 17:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3591F22DAB
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 15:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B4E3611B;
	Mon,  9 Sep 2024 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWKcz+sx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DB97494
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725896162; cv=none; b=pTgBevVCtmjaBC3GVANXmfb7lzw3LYMm4jDAk+75pI+PZyfdp1WD9VVrPW+Il0fYfIKZorRzedXuFn8Vdoj07t5EN4ke7FyyRnCB9iKVJgreT45K2iwCPAFGKDPccdwyq5bEmEc9+nYD5AldJJT6porNa4okf1w5V2xQdys5TIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725896162; c=relaxed/simple;
	bh=JueY7xelKqd9HXhFB7GE5uB+8y18imaatbpN9wf0xUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4Y8yS+n3lVeFNShm6/CAoOJiAbDi2gtTRQL0lf1qgRu1I3NmZEtzsAtlPaUQ40IxFs7rszQCgLZaiHSB5s8+Tu6ID0s1Mlkfcrj487kYkpkY3kA8pAVRfMtgoFfXnFT0StIUTIc6rs9uaxnH8qDERT50psb3ReMcJOxmp4lOE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWKcz+sx; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5e1b50feb9bso1901902eaf.1
        for <netdev@vger.kernel.org>; Mon, 09 Sep 2024 08:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725896160; x=1726500960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DwIVBvuYjZVkQjK2YIF1hoHv46569P09obBzlSF31mg=;
        b=XWKcz+sx/d0c9vTK4rWWPMrW7uah7j6nMKkCxDcPHzQL4eMLDpL9JDCfC0N6SXcJkz
         IDuIz9bu0i/5Oq9QY9nTEt3QS5s2ymvHNpN1B3oBEf9Am34QS+pgSwiHsWqhM1P9EW89
         nhu6PGNq6XTGWbBsX2CMbmZDC1K0Vj1bNr/QErLnPTX8TKFd4b7FBuxhlFMLp3jxCfpD
         itKqKQ5HmLaHyVHuASFePG/8jrX0kPaSA4xQELMKLxOeg+Fq8QJFefMblS3ooPZK6q/0
         6dLZ+qkcZSColYdERB6RStQ/1KmTop0uJM7XTz1J97LX/KCqcdusTlz79a4BZuheECbA
         HPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725896160; x=1726500960;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwIVBvuYjZVkQjK2YIF1hoHv46569P09obBzlSF31mg=;
        b=E5NvRww2z1wXjUqDYm8CiFWDA8QmrzqYKUxibugRLEj/u/JMDvZ7OLdfzI4HOMEzM/
         hvKpxxBJk5ZBiQuN/45fY5P3emJbo8FvpGdphD70tYaWWhF1FO8HyYFTn0My1GFrkhKo
         Y5619euKPQLZ+sAbzdF1fRhnjm6s53H/UubFOkRoPCBckn78t9QliCJ7T3Xxvlm6/ekn
         AJbu4jW5TsZZJ6gUrTNkIEPyVWjc4q6j8exD+KgCPgcuOy2MaOz83vpZEd8y4eiTm4Fz
         RaeXc8ufD8ZIgivAoVT9rOAzIdB03P8eg9b6Wog871i0Alj2iG3OZsuOON4JQ7K3sFC1
         8j9A==
X-Forwarded-Encrypted: i=1; AJvYcCVU9XJ58DtOTBPfgBWr/cxkQW/KP/0nV4AX9XY8WBtbOkozrxKqgWVqNnRqmJtsdLJwTx2Uzvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8WdGAvVIf9u2utboPxEN6CAKwIKHGxDvFpJdQRZ8vhnELoiJV
	btIiegiGx0iYpUIlonKFiEsMeHMIyue61XeyYyXwCWK84gi+h3CwisbJLA==
X-Google-Smtp-Source: AGHT+IGLwQvGK6klf2Z1l+rQH/Ey9O29wZ+t/WxnPRD3uppr7k+n3T6a+JMYjjcS27hOyTqB9s0ZbA==
X-Received: by 2002:a05:6870:a989:b0:260:e713:ae8b with SMTP id 586e51a60fabf-27b9d80b584mr4086425fac.20.1725896160464;
        Mon, 09 Sep 2024 08:36:00 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e5991558sm3650614b3a.219.2024.09.09.08.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 08:35:59 -0700 (PDT)
Date: Mon, 9 Sep 2024 08:35:57 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Christophe ROULLIER <christophe.roullier@foss.st.com>
Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Maciek Machnikowski <maciek@machnikowski.net>
Subject: Re: [BUG] Regression with commit: ptp: Add .getmaxphase callback to
 ptp_clock_info
Message-ID: <Zt8V3dmVGSsj2nKy@hoboy.vegasvil.org>
References: <8aac51e0-ce2d-4236-b16e-901f18619103@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aac51e0-ce2d-4236-b16e-901f18619103@foss.st.com>

On Mon, Sep 09, 2024 at 05:13:02PM +0200, Christophe ROULLIER wrote:
> Hi Rahul, All,
> 
> I'm facing regression using ptp in STM32 platform with kernel v6.6.
> 
> When I use ptp4l I have now an error message :
> 
> ptp4l[116.627]: config item (null).step_window is 0
> PTP_CLOCK_GETCAPS: Inappropriate ioctl for device

Strange.  The ptp4l code does simply:

	err = ioctl(fd, PTP_CLOCK_GETCAPS, caps);
	if (err)
		perror("PTP_CLOCK_GETCAPS");

But this kernel change...

> This regression was introduced in kernel v6.3 by commit "ptp: Add
> .getmaxphase callback to ptp_clock_info" SHA1:
> c3b60ab7a4dff6e6e608e685b70ddc3d6b2aca81:

...should not have changed the ioctl magic number:

diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_clock.h
index 1d108d597f66d..05cc35fc94acf 100644
--- a/include/uapi/linux/ptp_clock.h
+++ b/include/uapi/linux/ptp_clock.h
@@ -95,7 +95,8 @@ struct ptp_clock_caps {
 	int cross_timestamping;
 	/* Whether the clock supports adjust phase */
 	int adjust_phase;
-	int rsv[12];   /* Reserved for future use. */
+	int max_phase_adj; /* Maximum phase adjustment in nanoseconds. */
+	int rsv[11];       /* Reserved for future use. */
 };

Maybe the compiler added or removed padding?  What compilers did you
use?

Thanks,
Richard





