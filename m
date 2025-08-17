Return-Path: <netdev+bounces-214381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FC7B2938F
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 16:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEAC53B1BBA
	for <lists+netdev@lfdr.de>; Sun, 17 Aug 2025 14:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918BF2F9C34;
	Sun, 17 Aug 2025 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTr/44sk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A412F9C27;
	Sun, 17 Aug 2025 14:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755441730; cv=none; b=Hx1aid4lRoaQVwPzKehC8wayM/oM9GOYPTGJt+Rf5r1RGn6u5HDW4QSWwCyuHfaFd+Mfr6hOr8GqnfXK4KAkMu74Ka/fqktoHefcfClRO+9cfPP/JnXkdpppx/IwCBgH+UurItA1GiSe8I2RekF3NsD88N8g1kGFu/EPEmliyQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755441730; c=relaxed/simple;
	bh=VCAAoYXrZeEeZvYFDo8gpSf5FRlsHN77VicwqCg7lnk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fC4Ccl3MtMWp4HtMhnVMLk6YeWivlEV+jlc4XzpW5YJ6gBS/ADl7G3xp9e/06nkhtsXEQQSQ49VFk4mGqdHlyJ4MEBBBi0Z33BX/o8B+RZ2MgMyZhjjl+RJJPw3iy5HyHu63CDj/Wu3zYfZPtufPcAtj9dyLCHZlQ029fdgrC5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTr/44sk; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b9dc5c2f0eso2314486f8f.1;
        Sun, 17 Aug 2025 07:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755441727; x=1756046527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCK0McWcOTuTtwFlnRSx3Lqz/jXdIqFs+uzK4OV710Y=;
        b=BTr/44skjPhAdxbal7NahWzkVbEdpaUbOUWJ3nUwro/PceJUEoDatGH33kJZJ9najw
         1JwCcToQdjFPN2RMPrOBxkI3Fb8WhZDjCPhSIWOoCYfBdZXRtOzPpycHPJUyY7PLfIxF
         7Vz/ht7mMzHCmKQHC6ryqTLJWpqbjo3Kor3UR5iD0VRQYJTFxgHP0tp56WdyO1K7kAZi
         tBHeYUya2iSuUX7Qx+rsgK2fLfOcW+ZpD+owkMRX4RpttdGsOEO2TNGmZMJou7iRAzQB
         oNH9l0HAtUe7/7cYXnws003ymvJLK6gZwW0RRq0+vXSuIs4YPdLc/GPuuCKy74OCAJJt
         GMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755441727; x=1756046527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JCK0McWcOTuTtwFlnRSx3Lqz/jXdIqFs+uzK4OV710Y=;
        b=bfpNgkScJJ58I5k63HRSjj1rwpvhV2zVTbs3FwPsaeywSYRZR/A3EIPlQEqnnVKi+K
         ne/YFAMnnCb2LNvCXbUbhhhvqyIfHJFM8sli1/JAskrmexYWCff8QKoRpDYGcyUoA0c/
         pdzqYk8Q9VMEGg8MXwheWVmWkomR9OwCYxziPQ1Y8CiJqYlMRbcpVzKG6/jGxBk7d/cR
         Y2wEkAUac+qUcoQJXnS77OyW5bkTJ7b57An7uq7zouAJW95knxkEG3NyXk21AmzrgWsW
         2DXCmZWzJ0UT66E0tRHZptBXg7dAZMd+3F3umIdhH9ln1TZpBye9scmq8S+y/FJqNfXR
         z+Ag==
X-Forwarded-Encrypted: i=1; AJvYcCVeEEL0gZybcwWqSWiTlZFF9evqm8jnTSYblDwh4ybjTqxMwdClV/g/WZwdZXbb40D24teri02S@vger.kernel.org, AJvYcCXtd9yfTG80Z1FVQ4jOKMUhOXqbVCqcglub4+gYcoNO5HZ5swixVBktayJMgv6TULoqnFeSdH/C6XB6LHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE7SRJomPEFyRZQMK++AzuSaMMduaDpCtiWNuXIOsdEcCCeqDu
	isN0NkmYvknYC2LWy7vs3wLEf3KTVRwr8YQCZRsAeMrMq5a+46U7HPfV
X-Gm-Gg: ASbGncv4jXzbxoUiToO89aaIB/1iWU/HfsWOp4xdeYVog1aNVisOH24a43JQ2JViZOP
	Zdf5wIRUda054fhwzcSEzQrDMOfqk6CfVeypoedR8vhBHjYfpwcTU0KWbPKb7GApGFGMDKNuqS+
	uTQgypG7aZjX19xoQH5FWjRC6QfYAmnLUC9cBOslpdrsq3D0R+4WYfsRQaLh81t+pcpjrWLRfC7
	gA62QrAF3mLPY9zQvZgSK+4WcYuP823qxWAM7rbZ2k5hj0ExpFLn/zwQwqca9ss50yveKj49rA4
	F34RHZ497BVluH0jHtV3NrP9jL+ybgKxzqbUa1VRq2nTIaBIQtw+wSGv+3AAceV5dmr4HJRIhuB
	amPERpZFQzPZ8yke9xoYwhRdlC9Ip3YO0q5rvfx9U5airHSqNqWWG9BGAZ5Xg
X-Google-Smtp-Source: AGHT+IFlIuH2NAhG3N61PeoqIDbW0IWOe4t4kn17RiKQqs35q6xh7BpQ/VMASePWLc6529FKkvONyg==
X-Received: by 2002:a5d:5d11:0:b0:3b8:fa8c:f1ac with SMTP id ffacd0b85a97d-3bc68b89fb3mr4773670f8f.24.1755441726833;
        Sun, 17 Aug 2025 07:42:06 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a22328b5fsm93743445e9.20.2025.08.17.07.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 07:42:06 -0700 (PDT)
Date: Sun, 17 Aug 2025 15:42:05 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: ecree.xilinx@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sfc: replace min/max nesting with clamp()
Message-ID: <20250817154205.6044124e@pumpkin>
In-Reply-To: <20250812065026.620115-1-zhao.xichao@vivo.com>
References: <20250812065026.620115-1-zhao.xichao@vivo.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 14:50:26 +0800
Xichao Zhao <zhao.xichao@vivo.com> wrote:

> The clamp() macro explicitly expresses the intent of constraining
> a value within bounds.Therefore, replacing min(max(a, b), c) with
> clamp(val, lo, hi) can improve code readability.

I think you can do a better job of the line wraps?
The first and third won't exceed 80 cols split onto two lines.
They might be 86 on one line - plausibly ok (but I like 80 and they are splittable).

	David

> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  drivers/net/ethernet/sfc/efx_channels.c       | 4 ++--
>  drivers/net/ethernet/sfc/falcon/efx.c         | 5 ++---
>  drivers/net/ethernet/sfc/siena/efx_channels.c | 4 ++--
>  3 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_channels.c b/drivers/net/ethernet/sfc/efx_channels.c
> index 06b4f52713ef..0f66324ed351 100644
> --- a/drivers/net/ethernet/sfc/efx_channels.c
> +++ b/drivers/net/ethernet/sfc/efx_channels.c
> @@ -216,8 +216,8 @@ static int efx_allocate_msix_channels(struct efx_nic *efx,
>  
>  	if (efx_separate_tx_channels) {
>  		efx->n_tx_channels =
> -			min(max(n_channels / 2, 1U),
> -			    efx->max_tx_channels);
> +			clamp(n_channels / 2, 1U,
> +			      efx->max_tx_channels);
>  		efx->tx_channel_offset =
>  			n_channels - efx->n_tx_channels;
>  		efx->n_rx_channels =
> diff --git a/drivers/net/ethernet/sfc/falcon/efx.c b/drivers/net/ethernet/sfc/falcon/efx.c
> index b07f7e4e2877..d19fbf8732ff 100644
> --- a/drivers/net/ethernet/sfc/falcon/efx.c
> +++ b/drivers/net/ethernet/sfc/falcon/efx.c
> @@ -1394,9 +1394,8 @@ static int ef4_probe_interrupts(struct ef4_nic *efx)
>  			if (n_channels > extra_channels)
>  				n_channels -= extra_channels;
>  			if (ef4_separate_tx_channels) {
> -				efx->n_tx_channels = min(max(n_channels / 2,
> -							     1U),
> -							 efx->max_tx_channels);
> +				efx->n_tx_channels = clamp(n_channels / 2, 1U,
> +							   efx->max_tx_channels);
>  				efx->n_rx_channels = max(n_channels -
>  							 efx->n_tx_channels,
>  							 1U);
> diff --git a/drivers/net/ethernet/sfc/siena/efx_channels.c b/drivers/net/ethernet/sfc/siena/efx_channels.c
> index d120b3c83ac0..703419866d18 100644
> --- a/drivers/net/ethernet/sfc/siena/efx_channels.c
> +++ b/drivers/net/ethernet/sfc/siena/efx_channels.c
> @@ -217,8 +217,8 @@ static int efx_allocate_msix_channels(struct efx_nic *efx,
>  
>  	if (efx_siena_separate_tx_channels) {
>  		efx->n_tx_channels =
> -			min(max(n_channels / 2, 1U),
> -			    efx->max_tx_channels);
> +			clamp(n_channels / 2, 1U,
> +			      efx->max_tx_channels);
>  		efx->tx_channel_offset =
>  			n_channels - efx->n_tx_channels;
>  		efx->n_rx_channels =


