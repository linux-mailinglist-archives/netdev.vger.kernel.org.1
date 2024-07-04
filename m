Return-Path: <netdev+bounces-109304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0567A927CD0
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 20:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4C51F24221
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 18:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496464E1CA;
	Thu,  4 Jul 2024 18:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="h2rfwH6f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA6F6E614
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 18:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720116361; cv=none; b=RHXcuCPjAfKPLvNL0bNT+gFsx4YRHzrq2uoIAMtd/tCUH4vTrR78lVNEnPbu8G9OyTo12YwRjbfjtmD9f6MKy8X4B+WSx21Yf4UY4LFTaYQL1UKsBdCIU59SrXnO6+jWClP8ERQ4ytpSTAurNpSdLsH133mSKtarY5Qb1HNuisg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720116361; c=relaxed/simple;
	bh=C/0eJVnXdGf79qADOmZUc3+u9o+Erj1w+nzv1WN+10M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YJl/F2DMv5avXh2669o4qKN9ViZZ2iOYqoXEBMhPJ+Z0mWenXXvWzAijFcKJwgu+QQv2zIyryuxU+dgfRE+1kWGbZypVIfB6Ih40g2VlYKwu4I6Muv8E98X3Nju6k/57krtXESw9E60SFTVTPNB0gwte+7tVUWlXcidaAte46dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=h2rfwH6f; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-701b0b0be38so668806b3a.0
        for <netdev@vger.kernel.org>; Thu, 04 Jul 2024 11:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1720116358; x=1720721158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JV2Fv3AdF3sxOQWJ86d69rbSqwaw3+GpmIGTVOLioIo=;
        b=h2rfwH6f0cG7MY6xLIhm4APNZZ9L7+y4fNZEPfzYprFHqa9PIEFgsqrhAdOHJauG2S
         6VkyjHUFDqge8D+lnBmTmt3hnJIjFDqCQTOY1ruguMIAqFiJfOj5XJili9VHhQZjjwLo
         xkiT9yidSw4jupDlnWI1Cz1mbnwEbWb5UHdGCYTa9zqLLae4M0ErWc0MM2G+x99S8tRi
         /oJZmjkU7nCwItZA3adfaOgD4OHnOVUJq1gn8ue7iU7T+Dfhulw8KrRCrtnQ45v3o8KR
         dju628cARd4F7qeq8wzV9knmedc5OEgiLgHvyFqZJU4mfb2d+Tf3BXw4W0Yxv7whK73R
         xArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720116358; x=1720721158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JV2Fv3AdF3sxOQWJ86d69rbSqwaw3+GpmIGTVOLioIo=;
        b=eUou8wVQ8UYHvdNE9uCNGRnS5ss0n8udv+yAUBSjNU8gcNZZynzypo9dQ97KDMu6Wx
         uqogvIb9xj8boc2dJAUq9R9992b1qJ3lMjAW+inkiz8GcVCktl7fgF4y2ZCqKCjiG4q1
         o8Rpbzxj+oMyxU5FB8/aqFP8wufxJTEtplNhrLs6W+WTZcuS/EioM1LXql3KvDYUkss0
         QrSiGpxhATcj3m0+yk/DcU2cCoqFMYQEJJYZhUJCEV7zYqFfn6WhUyWOlrePm6RTI9hD
         NFdf+U0h4upBJpycNqSvPZhyqK/N1apbxOwAEmL0ltLcyaXEVbOFcYZRrlPzu4+O6ZTH
         E0HA==
X-Forwarded-Encrypted: i=1; AJvYcCXfqTTCcPlH/Z0Ja7gVT/avtE9Ey823LQZHR4pIlLMhKDy76EfPfLSTE1LC6QB7iigg5FzO5I0Bw1kvsQ0PE8M8sXbEqH4g
X-Gm-Message-State: AOJu0Yy1N5qldV6YC+SMpmSnM7gsNmTQ3GFYHpPuLBRSUx4z93pkXbSx
	+YjNLPofIzzD/ulMweC61Qt66eiNWpC1tZ5CXZPN8r6E59JVGqHSFPlzQIWgAq0=
X-Google-Smtp-Source: AGHT+IHgNeDxM0l826IZeX0BnOQDkbN7I3k4GcAs0EuIrL/KMt5zKkoH52JC51JhXZGQsNI9f+JE1w==
X-Received: by 2002:a05:6a00:170d:b0:704:24fb:11c6 with SMTP id d2e1a72fcca58-70b0094a6c0mr2272501b3a.12.1720116358373;
        Thu, 04 Jul 2024 11:05:58 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6c8ec943sm9928346a12.69.2024.07.04.11.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 11:05:58 -0700 (PDT)
Date: Thu, 4 Jul 2024 11:05:56 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bastian Krause <bst@pengutronix.de>
Cc: Fabian Pfitzner <f.pfitzner@pengutronix.de>, mkubecek@suse.cz,
 netdev@vger.kernel.org
Subject: Re: [PATCH ethtool 1/2]: add json support for base command
Message-ID: <20240704110556.1ebea204@hermes.local>
In-Reply-To: <f30c683d-303f-40ff-967a-7c33ecc07202@pengutronix.de>
References: <20240603114442.4099003-1-f.pfitzner@pengutronix.de>
	<f30c683d-303f-40ff-967a-7c33ecc07202@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jul 2024 17:21:16 +0200
Bastian Krause <bst@pengutronix.de> wrote:

> >   	if (pause)
> > -		printf("%s\n", asym ?  "Symmetric Receive-only" : "Symmetric");
> > +		print_string(PRINT_ANY, label_json, "%s\n",
> > +			     asym ?  "Symmetric Receive-only" : "Symmetric");
> >   	else
> > -		printf("%s\n", asym ? "Transmit-only" : "No");
> > +		print_string(PRINT_ANY, label_json, "%s\n", asym ? "Transmit-only" : "No");  


JSON has boolean type, why is this not ysed here?

