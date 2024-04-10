Return-Path: <netdev+bounces-86645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3D489FB46
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 17:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 908081C20BBA
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 15:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B22316EBF0;
	Wed, 10 Apr 2024 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="RFNq99eP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A3116D9D6
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712761944; cv=none; b=VivNxIiUyylOycKiTrUigoAYqe/KIiD302yqTo7BSxzQoHP6q7cHPjMSJq4RcR2wdLtd55kdeUJVuY2X6I9WZD+/Jgj9MtXI1iNiT+jLxjYSXCkh45PklW2d6D6AyNyW9FOutXfpRTcsa7NNt9OPJuT5xyy19xo+h7fJDSvp/gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712761944; c=relaxed/simple;
	bh=dro+vPCe2U+w0dBuIw0QsOIWpPz2nwt7smR+9wMhLjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMrgmY78UokFE7zjhuC7K2Q7iED5Amvl/cyw1rQl0Ea5FEPTeQkdEuzr79I2qL7JZARuURcWIrFPWSJmwMxBIARYoKArmeHYoHQSqKIZ9lDsWLBs6lWVGWvYfwisDfEtINSDsRRN6C7xz6kc15i3+2R5cg3DV2gU5OIgNkJxZpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=RFNq99eP; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4166d6dab3dso24381405e9.0
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 08:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712761941; x=1713366741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F7rN1y8Su7AEcLYNY+nm6JUkKcjJmsiVN5hdUvdf8WI=;
        b=RFNq99ePoSZPB6XtKM96olsmSrDEGQPviojaumUunioloMe36R6ree8AkVuBoCIUG+
         39h3aJQHFc0DuCjSkzGbxtnc1zKctAJ90ZZQ8m+EoMwuGEL7u1jg1gPYIhHwr4I5yTLU
         jOJY5n+C+1eX/Ff9Ob03AKXaoZlC/YzhOw2nJ2XIb2jJ6UTJMZ5ZeNU+75Dp+4nNPRqn
         ReMa3rIv0azQXD1idmAkeV7b+0WdQxnUjHJYWKkux9PzbgrKFulJd1tZmmYpNc4VO/1Z
         0E3ERvs3vSV7huRfqkwNAd0u4i5BoeMO4626jgDEK6oiz7L6PAnRym1qUNEWpgbiDzXT
         yybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712761941; x=1713366741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7rN1y8Su7AEcLYNY+nm6JUkKcjJmsiVN5hdUvdf8WI=;
        b=qNl1k4Z5bocrGAjy4TNA/Rslp0X0bbvZcDZnuGQ2s4tVZPOA/DEwQZ90aQ/Kmqin1L
         O4yBc/LOUYSTNfW6Aci6Qf6Qyv0sPXznK6XApP4fon2K4h4DqqTZspSId97qt3c+n0xu
         FfDyWH0hlIt11r8doBrt40tcIMdkawWgSpOzPJCv0c2WCZ6WBLHierNeLv5JqL24Gl9W
         kLc6FKyMX2X2MKR3UuoVla7ss87ofw8zMEE4wzAE+anfKyqSGMrClV1AY3OSmB6ysWUe
         I79ua3hAXATFCMRO3mxhkzJhEWWWoJFfihnOYoDNbO1gOVjxDuH/3YGj5UB6UFeJSP+Y
         GzuA==
X-Forwarded-Encrypted: i=1; AJvYcCUTE+YztvNZ9hB8/Uv2HjRX09+fXxQR46YlLredDqP6ddv8BGUm8qgRivC+SO1Uc5xEvEykMbgUFjJzCio2mMXPhocaNzyh
X-Gm-Message-State: AOJu0YyaR5jZDc5JG6JLqPMTccfhMkKSjPhNp9du3meQyYCdSPpCYVtk
	V7Fvl85YSsB23qtm/YfVsGOoBMTSSCDUDIhy98T0v8NA+c5qlK7aUHB7mWRSbSc=
X-Google-Smtp-Source: AGHT+IGfRdwp7YdHDmADXZUQcfeOK3231gjb7h18oltQrh9IKQ008j1dLXBNnVtlYrgVFmzwI3CjSQ==
X-Received: by 2002:a05:600c:3ba5:b0:415:613b:6dc4 with SMTP id n37-20020a05600c3ba500b00415613b6dc4mr1898009wms.28.1712761940707;
        Wed, 10 Apr 2024 08:12:20 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c468500b004149536479esm2557042wmo.12.2024.04.10.08.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 08:12:20 -0700 (PDT)
Date: Wed, 10 Apr 2024 17:12:18 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: pabeni@redhat.com, John Fastabend <john.fastabend@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <ZhasUvIMdewdM3KI@nanopsycho>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <20240409135142.692ed5d9@kernel.org>
 <ZhZC1kKMCKRvgIhd@nanopsycho>
 <20240410064611.553c22e9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410064611.553c22e9@kernel.org>

Wed, Apr 10, 2024 at 03:46:11PM CEST, kuba@kernel.org wrote:
>On Wed, 10 Apr 2024 09:42:14 +0200 Jiri Pirko wrote:
>> > - not get upset when we delete those drivers if they stop participating  
>> 
>> Sorry for being pain, but I would still like to see some sumarization of
>> what is actually the gain for the community to merge this unused driver.
>> So far, I don't recall to read anything solid.
>
>From the discussion I think some folks made the point that it's
>educational to see what big companies do, and seeing the work
>may lead to reuse and other people adopting features / ideas.

Okay, if that's all, does it justify the cons? Will someone put this on
weights?


>
>> btw:
>> Kconfig description should contain:
>>  Say N here, you can't ever see this device in real world.
>
>We do use standard distro kernels in some corners of the DC, AFAIU.

I find it amusing to think about a distro vendor, for example RedHat,
to support driver for a proprietary private device.


>
>> >If you think that the drivers should be merged *without* setting these
>> >expectations, please speak up.
>> >
>> >Nobody picked me up on the suggestion to use the CI as a proactive
>> >check whether the maintainer / owner is still paying attention, 
>> >but okay :(
>> >
>> >
>> >What is less clear to me is what do we do about uAPI / core changes.
>> >Of those who touched on the subject - few people seem to be curious /
>> >welcoming to any reasonable features coming out for private devices
>> >(John, Olek, Florian)? Others are more cautious focusing on blast
>> >radius and referring to the "two driver rule" (Daniel, Paolo)?
>> >Whether that means outright ban on touching common code or uAPI
>> >in ways which aren't exercised by commercial NICs, is unclear.   
>> 
>> For these kind of unused drivers, I think it would be legit to
>> disallow any internal/external api changes. Just do that for some
>> normal driver, then benefit from the changes in the unused driver.
>
>Unused is a bit strong, and we didn't put netdevsim in a special
>directory. Let's see if more such drivers appear and if there
>are practical uses for the separation for scripts etc?

The practical use I see that the reviewer would spot right away is
someone pushes a feature implemented in this unused driver only.
Say it would be a clear mark for a driver of lower category.
For the person doing API change it would be an indication that he
does not have that cautious to not to break anything in this driver.
The driver maintainer should be the one to deal with potential issues.

With this clear marking and Documentation to describe it, I think I
would be ok to let this in, FWIW.

