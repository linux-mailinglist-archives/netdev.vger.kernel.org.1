Return-Path: <netdev+bounces-128114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F6B9780E7
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23D37B2323A
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 13:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7001DA0F7;
	Fri, 13 Sep 2024 13:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nDbpXSYv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEF21B984E
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 13:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726233536; cv=none; b=BWwC0ISykmlBtsVkitS0KqP4HPrNl1QY+mWfC50C6PIpQP1zbM6KWxMkIr34F+YijiT6aHe8slBUNUoOaHucCfQu7KqbhFixQWlDRJNgeVfeusYjCCYX+gNhnmn+WeqQUAmNK5ZJp5pFYd2isEEZ3RDbT403/d+Ic5XMB40ASE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726233536; c=relaxed/simple;
	bh=+N1+Kkz30FJSzCh5yf0PQ5GaqCCytb3sbR4xxjPB4ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1RxwznDHIVh8GNI93BbdDn83rteX9ZwiERzpGyPgJSAJd6Z5gxH6X8sS/UQZYihkvAelQ2/2VzwGeSzSi3F0Ltnu0ldBcJg/XDs6nlh+qEbZ/bWCFyrEFmovcl72K1gdjAXhBMKBf8jSHyl+N2iFrmz6DhsoR+FbD6JHZTJshs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nDbpXSYv; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6da395fb97aso17469457b3.0
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 06:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726233533; x=1726838333; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+N1+Kkz30FJSzCh5yf0PQ5GaqCCytb3sbR4xxjPB4ug=;
        b=nDbpXSYvWAsn1zF9cI7lpmwTALrd/6GThve+7x2sC5QVnwNTei5ceKI9tKjdoxDc0y
         j0kYOrLynOOJh122tRbrLeR7IJwCgeDJgcygJA24dMobXqQardfeNAq8O6+Y2JrkIjal
         sDeUnulMNdRwZFue+RReCjkhksYMPgNWd9r4yqgfYjbIgNF66ZwiDIEO6KmSa+Jtsq+w
         hHN2ldWyVOUGyX+2GTYvITSmKkXzOtb53NSCmLPYVSj02bflbwxSZOGbnsQavxfmJ193
         bqMi6K78/5tjV+rMGlnQFU10ecAqgt1NFKCiHTF7l4FaWDl5aQ0b9gavao4dcoinMoT7
         jPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726233533; x=1726838333;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+N1+Kkz30FJSzCh5yf0PQ5GaqCCytb3sbR4xxjPB4ug=;
        b=Bo0Euf7yaMiXhyQwW9SnCe2h5/sLPwObYdFTniw0VrofAL+/Ed0EDJoohxjZznQt2Y
         XC0FwX1CMS+pLCGsIdBQiJcwB2rqWEXb/dVbxBJTb/VaB7yHFPHtvlsAXywWUFey2qJz
         aDMKe8luOm1lKJ6dphY4ylZ1SvVOvR1ZgKjagrIEL3ZrgWhqSK1rUtNrF7aHSuUQ7/MC
         nkM7EYSTtnO2pC16pffpWrM+0exxDE+65l3myGPg00Vsuf1jPUnJ6hhAO/y5HPJ6NLfi
         9+N6mjSEwfncOU2zHOGi0VgHbUrXNyXvQklRNIKcpbc/MAxey4ea+4vEQh7GvBBoHHOA
         J38A==
X-Gm-Message-State: AOJu0YxSQe1bWGGAq9+1otuoYDbz6lPheKTyeZsklC0qgx/xk/5Kezd7
	fYm1lpUV33XBdsBePis8+iXjf4xwAQtmlEP40qcW1XwC7dzsr50wAnyD+GMutnLD2Ko+8IVnh0F
	Sr55i2eSPIh8bFqE/TCng+1aeUbOv4NZwFhNPHA==
X-Google-Smtp-Source: AGHT+IFoleA2nXBR1tBw5VI8sGSYxlFSteRXaCUnsHm7Z6rLEn3XK5DRiKcEblir8xvInxJE0/Y45Q2xvBiuyUuMqOE=
X-Received: by 2002:a05:690c:3142:b0:6db:d7c9:c97b with SMTP id
 00721157ae682-6dbd7c9e3a2mr5947367b3.40.1726233533379; Fri, 13 Sep 2024
 06:18:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913121230.2620122-1-vladimir.oltean@nxp.com>
In-Reply-To: <20240913121230.2620122-1-vladimir.oltean@nxp.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Fri, 13 Sep 2024 15:18:42 +0200
Message-ID: <CACMJSesEsWXvb6_-VvdD9T+6TP8rYt+D0pU76KEGwRhU5j0RVw@mail.gmail.com>
Subject: Re: [PATCH net] net: phy: aquantia: fix -ETIMEDOUT PHY probe failure
 when firmware not present
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Christian Marangi <ansuelsmth@gmail.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, Jon Hunter <jonathanh@nvidia.com>, 
	Hans-Frieder Vogt <hfdevel@gmx.net>
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Sept 2024 at 14:12, Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
>
> The author of the blamed commit apparently did not notice something
> about aqr_wait_reset_complete(): it polls the exact same register -
> MDIO_MMD_VEND1:VEND1_GLOBAL_FW_ID - as aqr_firmware_load().
>
> Thus, the entire logic after the introduction of aqr_wait_reset_complete() is
> now completely side-stepped, because if aqr_wait_reset_complete()
> succeeds, MDIO_MMD_VEND1:VEND1_GLOBAL_FW_ID could have only been a
> non-zero value. The handling of the case where the register reads as 0
> is dead code, due to the previous -ETIMEDOUT having stopped execution
> and returning a fatal error to the caller. We never attempt to load
> new firmware if no firmware is present.
>
> Based on static code analysis, I guess we should simply introduce a
> switch/case statement based on the return code from aqr_wait_reset_complete(),
> to determine whether to load firmware or not. I am not intending to
> change the procedure through which the driver determines whether to load
> firmware or not, as I am unaware of alternative possibilities.
>
> At the same time, Russell King suggests that if aqr_wait_reset_complete()
> is expected to return -ETIMEDOUT as part of normal operation and not
> just catastrophic failure, the use of phy_read_mmd_poll_timeout() is
> improper, since that has an embedded print inside. Just open-code a
> call to read_poll_timeout() to avoid printing -ETIMEDOUT, but continue
> printing actual read errors from the MDIO bus.
>
> Fixes: ad649a1fac37 ("net: phy: aquantia: wait for FW reset before checking the vendor ID")
> Reported-by: Clark Wang <xiaoning.wang@nxp.com>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Closes: https://lore.kernel.org/netdev/8ac00a45-ac61-41b4-9f74-d18157b8b6bf@nvidia.com/
> Reported-by: Hans-Frieder Vogt <hfdevel@gmx.net>
> Closes: https://lore.kernel.org/netdev/c7c1a3ae-be97-4929-8d89-04c8aa870209@gmx.net/
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> Only compile-tested. However, my timeout timer expired waiting for
> reactions on the thread with Bartosz' original patch, and Hans-Frieder
> Vogt wrote a message in his cover letter implying that the patch fixes
> the issue for him. Any Tested-by: tags are welcome.
>

Still works on sa8775p-ride v3

Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

