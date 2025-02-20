Return-Path: <netdev+bounces-168232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0099FA3E301
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:48:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28F701885D3F
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 17:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471311DEFD2;
	Thu, 20 Feb 2025 17:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="H6ucX3+X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEAC1FF1AC
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 17:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740073701; cv=none; b=tH6yQQs+HFsDx0OqnV2VPPO1g77CEv7Nc75pIPbCFQzAkUwrghwjtogQvukrHAalLDOZJYaIBP1ZBrStDjJqL93RV5HA00KXJYVVULfembii+pLttYdvYVPp3stjTbzcufryGKsGuSFFkcJsEXpN6v09YYpWfKr6B8QO3dVCAK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740073701; c=relaxed/simple;
	bh=7Brb15ELOOx+aMxUHLd5T3uulU9wTsodzmhvTcS/394=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmw1wIFH3qc0XLmGJd2CaYzpHWlciLeSmTG5CJvP5B+ht+uQRL2gN4rFTMrSt/OSygoXVFT6/OPl47GcjaNzTiaRiM+6JvuXe780/8CElgOs0KtfgZUlHkH21yPtUecCfcPbgQ3SciPtB5k+RNe9xsYyyn/MkG6mY/bvGne7gsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=H6ucX3+X; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e69db792daso10407796d6.0
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 09:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740073698; x=1740678498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVSrbzlxSlQivFeEiDE76Ox1eAVkREhwKkJSsU6C8OQ=;
        b=H6ucX3+X3p4/b326fvzmar6pSvVL4Kj6T95enatlxESR9e+nNgmIylDDRS3z7uN4H6
         l45PfbWA6Su30aUN3TN4oDaklrWvvpLsklviwJa78x0opJECCT9U7gC1x0Oo1Fa4xMP1
         tXnfrv5zIkN4iNnH6jtuoq6NVOfw6U1uQQtpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740073698; x=1740678498;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DVSrbzlxSlQivFeEiDE76Ox1eAVkREhwKkJSsU6C8OQ=;
        b=PgE9L329k27KzsbGD0yvgv6tntfjs38Cc4WZZhsItBLRGIfLbv7Yv0LnXkYPIGfeex
         DritONIvMidx8iRj/5fXrbsmNtEkoYeT6qdn6MfdgVaKafKBdhS1mqI7xyB1Vp2RrBpU
         ejXu0+Hfm6BdYYT3Tue3wOxq2/RfBzrEdmPjsyQGnVuf6mMMjDFtrD0YrJddb6oDWUuQ
         /Nu2tIWiOucjpx2bQhoJwAAGbziDht+gKvymYUHLRn24sVPUBWzsAAfXnEcxKgbsC09/
         as9grvs2Jgw+T4DxJHGqaQyC23Pv7/3pohEqJ5ZaetiinxwQ8LAY8S1354Aw0WNGGHc8
         7gdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFtsgL1B+h4yZWLiqZuGFUmkK7MlbOUS5TwWKn6ljAeGKbdByhK5Rx6r7jKYTNmm1L16+bc5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY7Yu53LDsKXvL/LsbUMcaEo9O8NW+RVDBFJBjtRL3aJQNGX2B
	LpBiD5E4waiilpnCjFDN8KMzk4KDLNUyXAABx02TIqUS8FjmUQXiJ3j7/KFQCFg=
X-Gm-Gg: ASbGncurUpnAtNQYUWPcNs1nop5V8sbmmT3M75QnHBxssn3cmutmSDdfm4NId5DYs3O
	w9JtPeL6BhPa9ejeKlixduJyor6AFdeRQy8rgxosOzISuZvo5e0Z+mlloRL80QuxUJukR662EZ9
	R566SiWzxf+wV11SCQzOOyWP7FmCVdx7Y0uZQZHtuGromWLBvmIwHEUFss3yLkFCWlHmQMXRO+k
	LyIaaSd853Vhj14ViQgEttGnBNAt6MVCr8xDh2TgeXvWafO8kXJ8koZU1yO5RhHWhfbj+B+ClIQ
	YRUUlK+1SlzOhfFdhHZcf24MB975GNPtTIpCt/g0gzzl/MAdUQ+Wiw==
X-Google-Smtp-Source: AGHT+IH6zUubKfa4gvxFjI1DEmZ0im5n9AZjUsesKb2VPmWIAWIMFiYYwzhIUEyiv5xwbeSg0lzRWA==
X-Received: by 2002:a05:6214:27ca:b0:6d8:9cbf:d191 with SMTP id 6a1803df08f44-6e6ae802019mr272346d6.12.1740073698342;
        Thu, 20 Feb 2025 09:48:18 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7793f5sm88090756d6.5.2025.02.20.09.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 09:48:17 -0800 (PST)
Date: Thu, 20 Feb 2025 12:48:16 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	stfomichev@gmail.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v2 1/7] selftests: drv-net: add a warning for
 bkg + shell + terminate
Message-ID: <Z7dq4FUbEHe7QQg7@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, stfomichev@gmail.com,
	petrm@nvidia.com
References: <20250219234956.520599-1-kuba@kernel.org>
 <20250219234956.520599-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219234956.520599-2-kuba@kernel.org>

On Wed, Feb 19, 2025 at 03:49:50PM -0800, Jakub Kicinski wrote:
> Joe Damato reports that some shells will fork before running
> the command when python does "sh -c $cmd", while bash does
> an exec of $cmd directly.

I'm not sure what's going on, but as I mentioned in the other thread
and below, I am using bash as well.

> This will have implications for our
> ability to terminate the child process on bash vs other shells.
> Warn about using
> 
> 	bkg(... shell=True, termininate=True)
> 
> most background commands can hopefully exit cleanly (exit_wait).
> 
> Link: https://lore.kernel.org/Z7Yld21sv_Ip3gQx@LQ3V64L9R2
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2: new
> ---
>  tools/testing/selftests/net/lib/py/utils.py | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
> index 9e3bcddcf3e8..33b153767d89 100644
> --- a/tools/testing/selftests/net/lib/py/utils.py
> +++ b/tools/testing/selftests/net/lib/py/utils.py
> @@ -61,6 +61,10 @@ import time
>          self.terminate = not exit_wait
>          self.check_fail = fail
>  
> +        if shell and self.terminate:
> +            print("# Warning: combining shell and terminate is risky!")
> +            print("#          SIGTERM may not reach the child on zsh/ksh!")

I'm not opposed to putting a warning here, but just as a disclaimer
and for anyone else following along -- I am using bash:

$ echo $SHELL
/bin/bash

$ bash --version
GNU bash, version 5.2.21(1)-release (x86_64-pc-linux-gnu)

