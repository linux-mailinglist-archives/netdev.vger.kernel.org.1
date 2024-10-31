Return-Path: <netdev+bounces-140641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0D19B7592
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 08:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 610CD1F25402
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 07:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FE914F9F8;
	Thu, 31 Oct 2024 07:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wx8/ZtVi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CAE1494D9
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 07:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730360770; cv=none; b=Hnde1dGtKpYchCMl2hu2cWcDsFOj0qrs2VrFXCF/zlqfhJ9enYkXQXuIHelKRhvZ+1Qzvl3DzxmZ5Vnba3pnE6a0tIvqOoqbUvve6KvCxibM/kzHv40lKqLTGj2A43c/rXrn2UeK527YTHGGuq5UMfD6RS3l6nRxQ5vlUX3NetI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730360770; c=relaxed/simple;
	bh=LdbOM/BwIk/pN2XjwYTzGXq4hdCfnupmnuaDAJjI/qE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEB2XcQYmCIIOFu32dohLfaiXOmfBc4OIQH4qV8LXA5s84kFk8LYLGkQWzziBrys+BzV0IhxV/QgRu60TQM1GV99YhKQvNfUj7RmLsJDoD+Nr5h4K9u8Sxrq36jTS5y5DLlIoSUPWhjLMucpuyvq6U6Tt0C57Yekl58m0coiC2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wx8/ZtVi; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539d9fffea1so593494e87.2
        for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 00:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730360767; x=1730965567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z34kmNIYPZBu2E2byTLklxAtzQXRWwOn/Bq4zHtatFA=;
        b=Wx8/ZtViouNtFAdIYOVccXH66eCghCEXxnlsg1saQH+mOhwk48d6OIFrgbRfD9gUIE
         HvLw3GLyjhXN/H5uElTQ8eVtZc8OJ7k0QRVrfNsLMog797TAoorm+i138t/vun37h3dx
         5Hgm78/p/iBaxnI36eDzKoegOKlWjoPIHJgK9lkTN8i1FbWARvdfCUsPYfT3zOBJ31jp
         paKwhSwg49gkYueo3PKY2Qss43IXD8uSUyzjLJ9Du48M6IJY0J6cImhhfqCp93FnqOCs
         RMVauZ/EafaV3xBOEUnM8jJZ5QSuGdz+IdUuhvgwCWMTdz8ANswOoetpqAgHJCDUHUmQ
         7qYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730360767; x=1730965567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z34kmNIYPZBu2E2byTLklxAtzQXRWwOn/Bq4zHtatFA=;
        b=GUJ4L4+9lTOrxekwJWiV86Xjo00CeahCe6NWDPoOQbrOMFLmnFS5+68gqZHbb7f/kb
         LR0zasCS/vFQ20Jigd4tDPLSBGv7cm6OGJJUfV7zrADD3HkRfUJUQNux7motlDqTvty/
         tLIzI8WGz6OJDc8CRbA0oIeADoKPq3+3ZRgv+c5jegmvAC0jfyagkaWOTSvmhud9YKG3
         1A11ugNC8VXezwC6mivM3iFU6blda2dr+Zgn3Qxp80cbCkCoUu1X7jXlEPmjQ4zB3vSu
         ZgpSmT2GZHZDJ2mcBGK78+zmY0RIQx9dgNhdT72vdmEWBIGpTT9oU8wx3Ymd6IcBLxdk
         PadA==
X-Forwarded-Encrypted: i=1; AJvYcCWYyimz3bDBe4JyDCWUvJM7d0IGaYytxtGmz5B5Cbq5VRL4Hj0+iv/0b8XDKsMiXFHc3BvgcbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd41/5ufn1n7BYmaJb23Ruuoh/PI8ijl83y+VhsQ+/BOdJaBEZ
	S/erIOL5mi39fWaF4bYaEMVFsr61k674sVhh4tgkfGvpZEd7oK9kIryDKXBJXiY=
X-Google-Smtp-Source: AGHT+IEyV5MIRRCLQdmK7UjBg34Gzl/bEwH7BHu5682+naCccZ2ArZURIDYl2Ep7HMv9K2PTTsfJNg==
X-Received: by 2002:a05:6512:b84:b0:539:f886:31d6 with SMTP id 2adb3069b0e04-53b348ec0bbmr8246954e87.2.1730360766487;
        Thu, 31 Oct 2024 00:46:06 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9aa09fsm45693025e9.37.2024.10.31.00.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 00:46:06 -0700 (PDT)
Date: Thu, 31 Oct 2024 10:46:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Daniel Machon <daniel.machon@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 6/9] ice: use <linux/packing.h> for Tx and Rx
 queue context data
Message-ID: <cdbf7a65-024b-40e0-b096-29537476c82a@stanley.mountain>
References: <20241025-packing-pack-fields-and-ice-implementation-v2-0-734776c88e40@intel.com>
 <20241025-packing-pack-fields-and-ice-implementation-v2-6-734776c88e40@intel.com>
 <20241029145011.4obrgprcaksworlq@DEN-DL-M70577>
 <8e1a742c-380c-4faf-a6c2-3fa67689c57e@intel.com>
 <62387bab-f42a-4981-9664-76c439e2aadb@intel.com>
 <bda38b6e-73df-4ca5-8606-b4701a4db482@stanley.mountain>
 <5ff708b8-1c6e-4d53-ad64-d370c081121a@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ff708b8-1c6e-4d53-ad64-d370c081121a@intel.com>

On Wed, Oct 30, 2024 at 01:34:47PM -0700, Jacob Keller wrote:
> 
> 
> On 10/30/2024 4:19 AM, Dan Carpenter wrote:
> > Always just ignore the tool when it if it's not useful.
> > 
> > CHECK_PACKED_FIELDS_ macros are just build time asserts, right?  I can easily
> > just hard code Smatch to ignore CHECK_PACKED_FIELDS_* macros.  I'm just going to
> > go ahead an do that in the ugliest way possible.  If we have a lot of these then
> > I'll do it properly.
> > 
> 
> We have 2 for ice, and likely a handful for some of the drivers Vladimir
> is working on. More may happen in the future, but the number is likely
> to unlikely to grow quickly.
> 
> I was thinking of making them empty definitions if __CHECKER__, but
> ignoring them in smatch would be easier on my end :D
> 

Adding them to __CHECKER__ works too.

> > regards,
> > dan carpenter
> > 
> Looking at how smatch works, it actually seems like we could implement
> the desired sanity checks in smatch, though I wasn't quite able to
> figure out how to hook into struct/array assignments to do that yet.

I'd do it the way you have.  It's better to be close to the code.  It's way
harder in Smatch and it's not like you need flow analysis.

regards,
dan carpenter

