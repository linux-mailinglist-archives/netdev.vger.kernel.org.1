Return-Path: <netdev+bounces-81000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E3D885780
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 11:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412851C21260
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 10:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551FE54F89;
	Thu, 21 Mar 2024 10:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F+bdIDkG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB7814284
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 10:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711017297; cv=none; b=R3OVrSGOMOHHInN/qKy2IVwsrtGMtsiw+Fo2JF9GxkDYMOeUEhhqcAMq1oadeDeX7apxqAH5s6tJvL92cqUu3JNHNPzxEU7/PnYTvQElADTB3HTlzt+hTzQlOHYRY6cyz1rg/h88hq7aPTsrxwrohOfpvM7sR3BbSrNCkKAg8UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711017297; c=relaxed/simple;
	bh=y4emFXGGAZffpUX9wn8XGyawcIby/7BxyXLMzGwuUlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvece5Gf+Or1C+6iMkJfqJBpD9v+z0B5XQNJz6CxaaGBgMUmCm8HleEsRHSETzW3bC2phlldrqa+WHey3gStrZmx1YYo2L5VCS6TqZyeAhpQLPnJYytM/8JAs3JRffB3WnGSugQzb/OAT7+9I8RlDZ7IkFQtJ67fmDE36tNJd/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F+bdIDkG; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512f3e75391so608259e87.2
        for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 03:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711017294; x=1711622094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3XNkgAQnQ6LBfF2NFDRpA/pvI0NsrzPvIEpAHL8Ayt0=;
        b=F+bdIDkGzDaBLrdVKjtUiTAA/Dz/rG/yZGAAhu9b6bZyDlDxnqHH/dnruulUpT+v9U
         R3k8FXVXkP5Vq0vtxbabSaL+XA0fAnef5O1D9JX08rrjYnvo84uNaVDZBdQYIMM5jokC
         YznDdInJHUrbrEbKHBeOXvKRF9lEfTLkRcGHaQaxi5egEiWqt7h89143Lvlujrqlh+dE
         X+T/LB0p+6GND7LVAf3d1BkYxUAegyQs65YCKSP4815PMQefPb3OW/Rujv3nY4KGuNWy
         OzTCtUB0OCifQdV4X5hnlscNLyoGHMwOluJ9eJzeI+AmbiQ3GHtiqogejqO2TjiZwhCB
         0RzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711017294; x=1711622094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XNkgAQnQ6LBfF2NFDRpA/pvI0NsrzPvIEpAHL8Ayt0=;
        b=EiVXiBW7MfaLFliCwiIcnI3fyIdhhnkpt5nIi9PDf3hdyb+E8mSdNJte4oMdy1Hq1e
         MflQXRzYmJxU1zF+yCzIkCnw8mbcSRHOmNPNhllnVdHdknNu8SHyqd0ST8NWi8UBSXye
         JSQpOxeXQF0CzDYxaiNg3+L+4Wg477H2aTyx4XUohgkeXz8xl2PYdbPxon9s1wlrYwTF
         +2lMQ5KEbnTFORV8L8rQXGBPyH+HwQxPXxWVJG3ESo5ak8Ahtawgo1NbImZML4wa7Bgj
         7RR6u5sETwL2CPpLSxEFd/2xqLi8g9hnoL1YITtBsmOUPXRFiOcBWlI0Z2KIXOMYhfPx
         hZvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcjhzCwywe4tR4RdtIQmbIxLESnZOYwhVvzFAxes0pXoey67yurmJUms0QTJTXCjyDyydwCu1u8a1U4gBbOagxaecf03sQ
X-Gm-Message-State: AOJu0YwYyu24fEuTi0v67H5s1oJHo6WfdydrOCulHmjEiRPwvosWsLj0
	TD7I/NHPJRgfW9nLWC4KgIeRKR6jFdgY3ZPbBFDSvAVm4z/NJ8IoaCWTjYuxT7s=
X-Google-Smtp-Source: AGHT+IHcrMw9qmrRmKJ+2QA1uL5wiYGSUSyvOjThedDZOBU+nrthRuPB8s9XAlNO95sJ+RIlSU9Jkw==
X-Received: by 2002:ac2:5b8f:0:b0:513:ec32:aa8a with SMTP id o15-20020ac25b8f000000b00513ec32aa8amr5682658lfn.11.1711017293674;
        Thu, 21 Mar 2024 03:34:53 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id iv20-20020a05600c549400b004146bce65f4sm5064318wmb.13.2024.03.21.03.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 03:34:53 -0700 (PDT)
Date: Thu, 21 Mar 2024 13:34:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kees Cook <keescook@chromium.org>,
	David Laight <David.Laight@aculab.com>,
	"Czapnik, Lukasz" <lukasz.czapnik@intel.com>
Subject: Re: [PATCH net] ice: Fix freeing uninitialized pointers
Message-ID: <22ba28d7-e8ed-4b5a-9b6f-42d944d2f67d@moroto.mountain>
References: <77145930-e3df-4e77-a22d-04851cf3a426@moroto.mountain>
 <20240319124317.3c3f16cd@kernel.org>
 <facf5615-d7ac-4167-b23c-6bab7c123138@moroto.mountain>
 <20240320202916.2f2bda73@kernel.org>
 <6266c75a-c02a-431f-a4f2-43b51586ffb4@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6266c75a-c02a-431f-a4f2-43b51586ffb4@intel.com>

On Thu, Mar 21, 2024 at 10:59:42AM +0100, Przemek Kitszel wrote:
> Simplest solution would be to add a macro wrapper, especially that there
> are only a few deallocation methods.
> 
> in cleanup.h:
> +#define auto_kfree __free(kfree) = NULL
> 
> and similar macros for auto vfree(), etc.
> 
> then in the drivers:
> -struct ice_aqc_get_phy_caps_data *pcaps __free(kfree) = NULL,
> 				  *othercaps __free(kfree) = NULL;
> +struct ice_aqc_get_phy_caps_data *pcaps auto_kfree,
> 				  *othercaps auto_kfree;

The auto_kfree looks like a variable to my eyes.  I'd prefer something
like:

#define __FREE(p) p __free(kfree) = NULL

	struct ice_aqc_get_phy_caps_data *__FREE(pcaps);

regards,
dan carpenter


