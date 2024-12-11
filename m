Return-Path: <netdev+bounces-151148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D00D59ED042
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 16:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873C2288DF5
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 15:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E8E1D63F8;
	Wed, 11 Dec 2024 15:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TuAWOjKb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D211D5CC6
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 15:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931983; cv=none; b=LH7vaYzjWvAbXG+k0isJCJsXc8H0Z5qb+2/G8iAphJ8iEqjXXPtiCbhC8wqhxV9AIQk7nJ0UMIvt/KgfZ56v/llvf3q111cDl+L36l6YVwpHf/Yof5CmpwcpiO+iEZoMkgUiM8uGXaMd/6Dba7eZw0HUwyW706Sb5s/sQVLkV+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931983; c=relaxed/simple;
	bh=IC53HRb8V9iRnpBWfxbNXmj/88s49PLXKEG+dC8i5fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kn4E4rrGrM3bs0c99C24IlLNPi5Z3xm7xKyGf/RuKhvTJu6G705z7QVJbTooC+heL9sALAyqK4pj3V0COewoHhXxc6hSFgFMYak07kWBQmP7CI+Bagq0Z+iloNUVSMhlNkux2rj/TGTjgLh5yYurC1HpcqK8Z8jvLr7pBA3Unxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TuAWOjKb; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-435004228c0so30526295e9.0
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 07:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733931979; x=1734536779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B2rrjtFYCNa+l0opUFsEhFJAlzA2QKbBJlwN52j4330=;
        b=TuAWOjKbpPy1WmYPC4QZoR6IIcNGO5jcCDJUEUioo4LO88WGvAZZ9yiuZNd153rJUc
         nfdgz7608NiY2ucd26uUcJtFpmY7wFAFyRuD/vZIhWyrvtn0xaPyZPEkNmwWzYaF4XOP
         UypRU+V2sygDqHleFs5uZOnB2xOIlMkWTieulWJ6M820yELaobg4nFpLtsKvv5MjYuSp
         FfnCm1lMUJsoDNvugqo4cXn/J16HAKUT4sPgjOtvO6KarJ4oMAJigVSpVqIJgzI6pTPE
         7SYum6XlkdLh05jU0RVfSYMrQJd8zgcTRkgoB+frcB1ZGVYbCPG7ucfAqtc8mh/WWgPt
         OPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733931979; x=1734536779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2rrjtFYCNa+l0opUFsEhFJAlzA2QKbBJlwN52j4330=;
        b=B1b0Rej008ipJMWj2bv4v1Q9OGNx1VrnMB3G0XNA65lCPNK3e/HvacWV8+oDMsMpXX
         9cYoFPzetKRQIPmRaqleh5qTGd0OVgu7SZzka77tneCG+YvofBCb2qpnTR7TCm9zfBHV
         ovLZ6SbxUGRIJ6TY4YkjiDiw8aQq6VqDF2EY2nLoejKn+GqV1w6XVdaPJNYuoQNnTXYx
         gfQ43nXZyW16we8RrjlqOBogLCWZ7Lm66pWTsfjpY7hA5jAew8XwF9bq0xb1d+uhF/KP
         ZjdEADGegs1ydRgpqb2IkathhRTbwA91OMq433Itf2N6LL+Xe8TcD+igub3cCzi/RFFs
         v3yg==
X-Forwarded-Encrypted: i=1; AJvYcCXe0OiY6a0hr5YNwBuAlZpRg9+/O7E1VBBce5w9vdmZBjBaNPh3705TA/0FuT0jCan1d9W8p5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCHcV2fPAOgJ5OY7gEOw3kMuQprvyooZufpEBZ7He9YD2VxCOd
	5cvgF8OJis3Hz6VH0BEXdSXQNdFtrd3ZZ+LRz2rbUdqCjzKN7+3BoetAY/X0nI8=
X-Gm-Gg: ASbGncv28Wtoiku8R1F3xbblCIOjJf5WOkkzejoTIt76hioJ/31kniIZRAmjjRfbl25
	X7bgo3hkYU1qy4buO7eURcsUIIJxrwbqUUn0304TLD8R308Sggm19m//BDbjCdUC73F+qc3Xy2+
	ZCWTF40ugPHxJLYBpCwQGEUcsADlOxH4FLCn288mOsFwRahfbBQsPbZsPLvc4UG8D++wnZI24G4
	UwYBXFELuGZ0Ln2H8jolSo+epJ0u87E1NayKiEOH7zxwkHc1vAmzbu5lRQ=
X-Google-Smtp-Source: AGHT+IElAjFrQA1BOKFF5sD8uSomr+adDjCh2fxba5+aLmeIQZ30HWVdJYlj+iWlHcRAJRttZ0NMfA==
X-Received: by 2002:a05:6000:1ac8:b0:386:3213:5ba1 with SMTP id ffacd0b85a97d-3864ce97262mr3126317f8f.24.1733931979554;
        Wed, 11 Dec 2024 07:46:19 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878251dba9sm1532151f8f.98.2024.12.11.07.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 07:46:18 -0800 (PST)
Date: Wed, 11 Dec 2024 18:46:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: vigneshr@ti.com, matthias.schiffer@ew.tq-group.com, robh@kernel.org,
	u.kleine-koenig@baylibre.com, javier.carrasco.cruz@gmail.com,
	diogo.ivo@siemens.com, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com, Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com
Subject: Re: [PATCH net v4 1/2] net: ti: icssg-prueth: Fix firmware load
 sequence.
Message-ID: <304870d9-10c7-43b3-8255-8f2b0422d759@stanley.mountain>
References: <20241211135941.1800240-1-m-malladi@ti.com>
 <20241211135941.1800240-2-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211135941.1800240-2-m-malladi@ti.com>

On Wed, Dec 11, 2024 at 07:29:40PM +0530, Meghana Malladi wrote:
> -static int prueth_emac_start(struct prueth *prueth, struct prueth_emac *emac)
> +static int prueth_emac_start(struct prueth *prueth, int slice)
>  {
>  	struct icssg_firmwares *firmwares;
>  	struct device *dev = prueth->dev;
> -	int slice, ret;
> +	int ret;
>  
>  	if (prueth->is_switch_mode)
>  		firmwares = icssg_switch_firmwares;
> @@ -177,16 +177,6 @@ static int prueth_emac_start(struct prueth *prueth, struct prueth_emac *emac)
>  	else
>  		firmwares = icssg_emac_firmwares;
>  
> -	slice = prueth_emac_slice(emac);
> -	if (slice < 0) {
> -		netdev_err(emac->ndev, "invalid port\n");
> -		return -EINVAL;
> -	}
> -
> -	ret = icssg_config(prueth, emac, slice);
> -	if (ret)
> -		return ret;
> -
>  	ret = rproc_set_firmware(prueth->pru[slice], firmwares[slice].pru);
>  	ret = rproc_boot(prueth->pru[slice]);

This isn't introduced by this patch but eventually Colin King is going to
get annoyed with you for setting ret twice in a row.

>  	if (ret) {
> @@ -208,7 +198,6 @@ static int prueth_emac_start(struct prueth *prueth, struct prueth_emac *emac)
>  		goto halt_rtu;
>  	}
>  
> -	emac->fw_running = 1;
>  	return 0;
>  
>  halt_rtu:
> @@ -220,6 +209,78 @@ static int prueth_emac_start(struct prueth *prueth, struct prueth_emac *emac)
>  	return ret;
>  }
>  
> +static int prueth_emac_common_start(struct prueth *prueth)
> +{
> +	struct prueth_emac *emac;
> +	int ret = 0;
> +	int slice;
> +
> +	if (!prueth->emac[ICSS_SLICE0] && !prueth->emac[ICSS_SLICE1])
> +		return -EINVAL;
> +
> +	/* clear SMEM and MSMC settings for all slices */
> +	memset_io(prueth->msmcram.va, 0, prueth->msmcram.size);
> +	memset_io(prueth->shram.va, 0, ICSSG_CONFIG_OFFSET_SLICE1 * PRUETH_NUM_MACS);
> +
> +	icssg_class_default(prueth->miig_rt, ICSS_SLICE0, 0, false);
> +	icssg_class_default(prueth->miig_rt, ICSS_SLICE1, 0, false);
> +
> +	if (prueth->is_switch_mode || prueth->is_hsr_offload_mode)
> +		icssg_init_fw_offload_mode(prueth);
> +	else
> +		icssg_init_emac_mode(prueth);
> +
> +	for (slice = 0; slice < PRUETH_NUM_MACS; slice++) {
> +		emac = prueth->emac[slice];
> +		if (emac) {
> +			ret |= icssg_config(prueth, emac, slice);
> +			if (ret)
> +				return ret;

Here we return directly.

> +		}
> +		ret |= prueth_emac_start(prueth, slice);

Here we continue.  Generally, I would expect there to be some clean up
on this error path like this:

		ret = prueth_emac_start(prueth, slice);
		if (ret)
			goto unwind_slices;

	...

	return 0;

unwind_slices:
	while (--slice >= 0)
		prueth_emac_stop(prueth, slice);

	return ret;

I dread to see how the cleanup is handled on this path...

Ok.  I've looked at it and, nope, it doesn't work.  This is freed in
prueth_emac_common_stop() but partial allocations are not freed.
Also the prueth_emac_stop() is open coded as three calls to
rproc_shutdown() which is ugly.

I've written a blog which describes a system for writing error
handling code.  If each function cleans up after itself by freeing
its own partial allocations then you don't need to have a variable
like "prueth->prus_running = 1;" to track how far the allocation
process went before failing.
https://staticthinking.wordpress.com/2022/04/28/free-the-last-thing-style/

regards,
dan carpenter


