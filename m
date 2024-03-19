Return-Path: <netdev+bounces-80542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A580187FBBD
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 11:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E541C21EB0
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 10:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017F47E564;
	Tue, 19 Mar 2024 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="PhUxpv+D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BB87D419
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 10:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710843942; cv=none; b=jFeK6i0KZ+8gH89fkIyPg9bba+G7Mj+udaJim3cLYWwj3GRIjhJOEbrL94po/JF+cxZMKqhijopeyNZ1jQ/Lp4DpSTe+JHWB4SCX7G1l9T4CM1IvpibFnMRp82lD+1JhC9dK1vhT+GY1MqDIXykd5PL6mWTGlgS51E2TEN6SVvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710843942; c=relaxed/simple;
	bh=oTXC/wbQ51UIDL07kJviApZLJbAMWY5TN/5g53crcYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rku1G1T8qyGOucArtFKS0t978POK48wOJo67WF1YIt74BbFYJLPoZYGOIsj8yVcJSr7khqEzKEKH82RhfRMpc9ApdJ/1GukPmJC/R5z8trikbbiadtvROorx06ILWRGSD0I/uu2peIK8JSDLzzAt5Ykdd9RvCUtOUGXNRoOgYnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=PhUxpv+D; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-512e4f4e463so5990897e87.1
        for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 03:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710843938; x=1711448738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oTXC/wbQ51UIDL07kJviApZLJbAMWY5TN/5g53crcYY=;
        b=PhUxpv+DfxOUavzRV9uGR2QVWSDH0t006SW7rw43zZ8+XT1IDyMCzGka82XmQZbSud
         qn80thICNt/bke1kN6HBNHGhLGKObwq9dD96Hy173230XrCazWzf/yDY16gWw2PJPFVm
         ifExinfEojniSyynkKMwHp8Ny/fzOgQ8GuPQuXCnF5K/TE6+l1DMQwFPJ3X3NIQWsFRR
         GMdfpN5my98Flqih2TGvwynGQpPl1yLpYZf1IT3TCKRhmcsGAYy18ZWvWbalIUK0bnqC
         qmfrlrpdRhhUbOh7Hp53HBOl6ZrhzhNbNGarhojoPaDz94/jREdunpQJdJy3l2D9B4cP
         7uEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710843938; x=1711448738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTXC/wbQ51UIDL07kJviApZLJbAMWY5TN/5g53crcYY=;
        b=BvIfycqG55zqE2npzYmlflYf3MqEwd5FIyM8Dh/0j9pFBUxA+fUCJoVn0tfJjJY9oQ
         7k+WDIspGIT3oBPN9OVSn/XFBiF4BeQPrwmm/91QHFAUs9rKvD2KVXbLRrxTPi0PvlHt
         fZQGmKlEDG8Va7B2mT0sNEH8USZHwVDXEnb0SgRLJIpH7pmtacHGIZLwp7WSbxt4wR5r
         kTUcpbvG7euZIhTgRaiHUr4KtRtqpfffwyOXc704/SDDg5oVuVBzaNFDxjqM2zo2gBEh
         iuaLHOrcgPMWBlaDtZB7639TRU42rI5icUc+lzVBSKp2EFyajfXeJo6c0QaFQJQQKxMS
         DBeQ==
X-Gm-Message-State: AOJu0YxhwUQ0R7aJa8uaHOqqjBaqayRm8FOKGd4X+O+9k7Ka+M1RoAIb
	j8uTdnp68IbLTPH8e3yvWgBcyePpk5Bre1yduiUbdUubZP8yKUPWEltZ54FuxDg/UIdjfcW8jD3
	78TQ=
X-Google-Smtp-Source: AGHT+IHBEYxMdf7EUFfVdd5ojgJCIa7Qd9jXAFR1mKkUtfqgXCkr1oqH/Znz+xela24vnnbkZ7D6Pg==
X-Received: by 2002:a19:8c4d:0:b0:513:cc24:c464 with SMTP id i13-20020a198c4d000000b00513cc24c464mr10289181lfj.15.1710843937924;
        Tue, 19 Mar 2024 03:25:37 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id n22-20020a05600c3b9600b0041408451874sm10558176wms.17.2024.03.19.03.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 03:25:37 -0700 (PDT)
Date: Tue, 19 Mar 2024 11:25:34 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH net-next v1 1/1] nfc: st95hf: Switch to using gpiod API
Message-ID: <ZfloHvWaTOQErWfU@nanopsycho>
References: <20240318203923.183943-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318203923.183943-1-andriy.shevchenko@linux.intel.com>

Mon, Mar 18, 2024 at 09:39:23PM CET, andriy.shevchenko@linux.intel.com wrote:
>This updates the driver to gpiod API, and removes yet another use of
>of_get_named_gpio().
>
>Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

net-next is closed, send again next week.

