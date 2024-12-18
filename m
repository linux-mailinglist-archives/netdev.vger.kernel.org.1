Return-Path: <netdev+bounces-152857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 179D69F6054
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 09:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C901884CA6
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 08:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6941791F4;
	Wed, 18 Dec 2024 08:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WLzhjs/z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EB214F9E2
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 08:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734511440; cv=none; b=E0+uVH59usV8LDSY05hA/FTixMyZ0+LrelJDj3F7/+4cRiUkXwIwpWJ4z3K6zToZxpiunr7wvJIxQOCIb81j8dPFbipxAnr3ZXy/xUPkCrhYACwjEiZyzK2I/UlK1xuGO2wifi3BNNAgHWlkZLpWK+7wBQ0r/qwpoeOsi7c7Rpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734511440; c=relaxed/simple;
	bh=YzcJl1FbFDEHDQf72+B90WAbhYMxAhvg5sqVxs6Ue/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mr8CebfJ3mVeVcA97VKbviEFVCXwoChBOsdNAGsMReSBPN2uMHIYBYFTH5tqW2xk9ddRt2ffSw2xIULmO2Gel8Fn2yKQYgTipEUr8W0aTPIi37b2fPwf438nTwSPIdLBWuzJXwDbEg3IOOm+t2RAT4n6Fb/nr8LIkfE1z7TmkQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WLzhjs/z; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so1022548466b.2
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 00:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734511437; x=1735116237; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MU+DAJGYy3oCu/TF/zialaJ4v/JIvCr+RgufidPD9TI=;
        b=WLzhjs/zWMkTOOVgLnrh3dZmxQx1tCYKy10unK63e3+67H3J/34GfyCCLpCM10m0lz
         ugoI5hoe+XNHkJHpu9Ha2+m6acp3ArTdugQ4d6FZjLS85KN6ze0iNlguRdH7zw3Ce4nw
         Rq0QUAY4kMXdRscIt21ABlWMPhX6U2XIaTyy3xiA7EVUKI00K9gkXpiU4m59tgWqcYeh
         cqIXKvpzUjgb1KNwA3YppqjYTO6wiCdEbNZPLkUUs9Nz9CZm2NVgFr5jO+jvlrLnQ+KM
         8+nLqIMZRn2H+NSWV5QQD6sm8C2IxAO4fme3vmv6Ff+/OKiHIv0ZYV1YoQ+5pArLoSCC
         A3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734511437; x=1735116237;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MU+DAJGYy3oCu/TF/zialaJ4v/JIvCr+RgufidPD9TI=;
        b=Kl6+QZ4DvJ9nRDXkzsib5Qy3/CQ5ylGkd6T9tR2Er4QZVd1MGJQ1hGqAhDZOZGdOon
         BLOq1QO8fc+Lsa0NFJHNGeqK6mZRD9HdEVfArYf0+XpAlCGpyecs6z69LkRsQ5EfYS4V
         I0IfByAcpuMNqe4UriiHS7hwx4fBAqcahNc5+f0J4LrDXvbT2ofoTUWGpQu6zEP2fTHI
         uRV2c8J3+27IGxSwKl03PLkBhbVgcYQzSi0x3zQzTxdsyE3tDPsqfZImHvPwGQCAtf7o
         oYDFPOLFjP3vNaioG5FM/KKFWpTqfe9ZnG4Wy0lzGCvTi7bhs2waptx0ibRwpSC/IEHf
         AzmA==
X-Forwarded-Encrypted: i=1; AJvYcCX+qa152i2kp+vY8n7W5kB8RfiezuTYp6VOASL3ZZYnbqfxpdSX2rlAga8A8d6npEIhKxeIVSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXp0rUZ+UDmLT3WaX0ykHFZkm3b+J+JXspkxdwRg8Hzi5ekTY2
	xtyLxCyPD2k99MpKO8oBGByrya2fJM2LDQPthEOT7+eIjEsKrOShy7czOatBshE=
X-Gm-Gg: ASbGncsdZmzazm0or+if908of8iOAvzz8dQi4lSTQtluPUNlo6Er1lLoFCuyU81m1YN
	4RPCdBOJ9MGmLbNPevc8iYhC4+Sg6lebjrEIYlKJmk0KNMUbW3Yobb91Wlx/S7iAyv4NJknM7Ug
	H5Qm881EUL/td0sTG0lMZ/L+fiZ3tFuR7I+1VYC1MCinEdPPl0yD16GT3keiAt1nzbCzuK4S9Zl
	+qTf58Bpmo5q44e11xCspIHxEOvVBWdeNwxEv+0DjIqseiIrvK8Y9ZaPrh3UQ==
X-Google-Smtp-Source: AGHT+IGB2sToVn4vti1D2vhTFdBJYdg2TfbR8CbMlMyUVjPXfQrZG/iM44121J6wvyAgWLXs/DwIvQ==
X-Received: by 2002:a17:906:309b:b0:aab:740f:e467 with SMTP id a640c23a62f3a-aabf471f759mr147708466b.8.1734511436884;
        Wed, 18 Dec 2024 00:43:56 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9c3eb5e0sm510398866b.44.2024.12.18.00.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 00:43:56 -0800 (PST)
Date: Wed, 18 Dec 2024 11:43:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	krzk@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/2] net: stmmac: call of_node_put() and
 stmmac_remove_config_dt() in error paths in stmmac_probe_config_dt()
Message-ID: <50d126f4-e87a-4502-8a9b-7291d0143ed6@stanley.mountain>
References: <20241218032230.117453-1-joe@pf.is.s.u-tokyo.ac.jp>
 <20241218032230.117453-2-joe@pf.is.s.u-tokyo.ac.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241218032230.117453-2-joe@pf.is.s.u-tokyo.ac.jp>

The subject is too long.

On Wed, Dec 18, 2024 at 12:22:29PM +0900, Joe Hattori wrote:
>  	plat->stmmac_ahb_rst = devm_reset_control_get_optional_shared(
>  							&pdev->dev, "ahb");
>  	if (IS_ERR(plat->stmmac_ahb_rst)) {
> -		ret = plat->stmmac_ahb_rst;
> -		goto error_hw_init;
> +		stmmac_remove_config_dt(pdev, plat);
> +		return ERR_CAST(plat->stmmac_ahb_rst);
>  	}
>  
>  	return plat;
> -
> -error_hw_init:
> -	clk_disable_unprepare(plat->pclk);
> -error_pclk_get:
> -	clk_disable_unprepare(plat->stmmac_clk);
> -
> -	return ret;

Ah...  This is a bug fix, but it's not fixed in the right way.

These labels at the end of the function are called an unwind ladder.
This is where people mostly expect the error handling to be done.  Don't
get rid of the unwind ladder, but instead add the calls to:

error_put_phy:
	of_node_put(plat->phy_node);
error_put_mdio:
	of_node_put(plat->mdio_node);

The original code had some code paths which called
stmmac_remove_config_dt().  Get rid of that.  Everything should use the
unwind ladder.  This business of mixing error handling styles is what led
to this bug.

Calling a function to cleanup "everything" doesn't work because we keep
adding more stuff so it starts out as "everything" today but tomorrow
it's a leak.

This can all be sent as one patch if you describe it in the right way.

    The error handling in stmmac_probe_config_dt() has some
    error paths which don't call of_node_put().  The problem is
    that some error paths call stmmac_remove_config_dt() to
    clean up but others use and unwind ladder.  These two types
    of error handling have not kept in sync and have been a
    recurring source of bugs.  Re-write the error handling in
    stmmac_probe_config_dt() to use an unwind ladder.

regards,
dan carpenter


