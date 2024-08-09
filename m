Return-Path: <netdev+bounces-117168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6012E94CF4C
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 13:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF277B21B14
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 11:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63BD19308F;
	Fri,  9 Aug 2024 11:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="vVfb414l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3846419307B
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 11:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723202232; cv=none; b=ejuIn+SSrQUr8bQWTc5+C7WrxGGb/gq3aPqydSrKmPeBE5I30du/3P1KHhmbs/+ptVccOcLRjJth8iFRE+K69w30Fh8TTlSktznrNsfl1FfFOtCev1VsNU4Ym9p1DlH4f/GPFEv3HYlwPadcNPdu4NaQKhEYIz9nDx+yfUll55w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723202232; c=relaxed/simple;
	bh=dkfVkZTpiXR7HGxBN5rrtw6Dj8zX6DHqoVAmW84HTJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkqLyWQ4B7Y+tshT8U6cj2ai7Nkn1e1WslADrYE7bsGyNB8epSbCo7yyr4nd34rgvSLP9KTDgtQ+97zhDwZsJbttUdqGaC91OTus1/2fln+WH6a+tbnFYhbS9VZtCH4wIYzvc+M5J6UXOCihcOpTdjsxY9OI/GDjTutUayHaZfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=vVfb414l; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7a94478a4eso490921166b.1
        for <netdev@vger.kernel.org>; Fri, 09 Aug 2024 04:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1723202229; x=1723807029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dkfVkZTpiXR7HGxBN5rrtw6Dj8zX6DHqoVAmW84HTJA=;
        b=vVfb414lb+Mk2Dr2ApcvrKWU8mR9cHstHWUNuJPQirBfTuqC95nDpooVi3HPAd6vSv
         FMp3s9tyElP8FBHP7Dx1kog6VJ3/JF+jPcfRqUBxDxM7L8+ZIQwbb2IlVVoT648E0pfE
         xWdVj0FyhHuDvl7Z7uBDm8NQTiXwO/A5UdRidbh/2Y7pc72qeczzmGf8Z3GbmJ50CKTx
         DERFOheuEBMs/pfqB2/Iv045YHxm8DE/7olWOlb29mhi0Pv8pfHsOilX2Ebc0RR4lDNv
         QLz+QWntHWcAIM2oGXC20q5TUqC5DwR+FZZGW/z4D5QwZdhWIt4yZ+g3dgoau7d+0cS2
         Ez+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723202229; x=1723807029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkfVkZTpiXR7HGxBN5rrtw6Dj8zX6DHqoVAmW84HTJA=;
        b=Oc468xkCo3S0ZyCIWWxo4CCa6aQ2xZjhaRymNBM90HKCVGsv9MwedSsixveHStxC3O
         QBUNqdEd6JZkj0C6Xkn8kJXcjoyjiZcrkGM4qaztrv3N3A17Qgb036Y3h/DKzEIQwkjG
         Qu7CAFLfzZNkKuLoQnnNp+sqSYHkgm8TlOTRIKloptcPKv9k2yPRBS/7wfTz+psiMx9u
         GA+Y4TZDnoRRyp5Tho9vv+e0OPumQ/B/HUibRLfXraElwzU6JzGeoGkDVZN5X0KnNPGY
         A1Ni3vbNk33xirEPC49q2H0xlL2Hw7g3/vHb1cqnnuwUMNOFK+qpSstS9059TC649eq4
         9dlw==
X-Forwarded-Encrypted: i=1; AJvYcCUDRjFQvp23cOWwn1hGEwIXSdR+/o1f20ldbaFprBRwICxMMLRPGX4aI02VPr08UwlEwjhPeY0lzbYZICNf+OU3bIZ4jZSg
X-Gm-Message-State: AOJu0YzUOmXBJlm8dNxOxpNtKdH0Fk3MmQsy4MbFwUCJF4Ae4vtXkfvu
	w+qC0NF81WD68Qer6Qhe4c/i+Ci9gsq1o3z0pUCUW8C04ndBwhEVzGy50Xo7eDw=
X-Google-Smtp-Source: AGHT+IFCUKEPMzr1b/T3DorhyXLKz2scFQ+3Y6x0IqRD8SYeqpN8nKByUheNpYrnCAZl8cZBbpkEYA==
X-Received: by 2002:a17:907:c888:b0:a7d:89ac:9539 with SMTP id a640c23a62f3a-a8091ec7f4bmr381602266b.7.1723202229375;
        Fri, 09 Aug 2024 04:17:09 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ecabb2sm828212566b.214.2024.08.09.04.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 04:17:08 -0700 (PDT)
Date: Fri, 9 Aug 2024 13:17:07 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, netdev@vger.kernel.org,
	Piotr Raczynski <piotr.raczynski@intel.com>,
	michal.swiatkowski@linux.intel.com, jiri@nvidia.com,
	shayd@nvidia.com, wojciech.drewek@intel.com, horms@kernel.org,
	sridhar.samudrala@intel.com, mateusz.polchlopek@intel.com,
	kalesh-anakkur.purayil@broadcom.com, michal.kubiak@intel.com,
	pio.raczynski@gmail.com, przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com, maciej.fijalkowski@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH net-next v3 05/15] ice: allocate devlink for subfunction
Message-ID: <ZrX6swCQAiQt6XCS@nanopsycho.orion>
References: <20240808173104.385094-1-anthony.l.nguyen@intel.com>
 <20240808173104.385094-6-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808173104.385094-6-anthony.l.nguyen@intel.com>

Thu, Aug 08, 2024 at 07:30:51PM CEST, anthony.l.nguyen@intel.com wrote:
>From: Piotr Raczynski <piotr.raczynski@intel.com>
>
>Allocate devlink for subfunction instance.
>
>Create header file for subfunction device. Define subfunction device
>structure there as it is needed for devlink allocation.
>
>Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
>Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

