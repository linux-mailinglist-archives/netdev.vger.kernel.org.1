Return-Path: <netdev+bounces-66650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79988840148
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 10:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E0FB282ADA
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 09:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0EA55762;
	Mon, 29 Jan 2024 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ivw4DOmr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367A154FA9
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 09:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706520029; cv=none; b=Jtp089IXGCKgGaG9KVrx90BfZvLCeQWNU0/FkyXzwfsgrW6v7sF9Q5Mk29kILeJcjgWEvahxoUOTXTpIJ5fV0skO5CO2UOeSe8LUQvd0ULxHcttnYGVgOyHXJNI5MFb5cWnMEXV3ABjWTEiTx6Lbzt+x0cWUkWw4c98uKAMPhYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706520029; c=relaxed/simple;
	bh=XePu6ESbP1u4t/MnFXgEgs+74bLx1n7p+r7l+mLX2yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gg92MNx5KIwz1U+W7V7EFBVJ72ymJfoVs6smqSr3ENhVdsYApaXC78G8CHC3ahuYzCVUfAzcNv8M0FmrmRo1wn4cAmuMG0u7rdxYLPbZEAHlCOyBMvdvED/r6k5cMOiTu0JMhaVgF56H1hEBpoSYicDMKAfCVMtgYaC7jXrrhsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ivw4DOmr; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40ef3f351d2so4537975e9.1
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 01:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706520024; x=1707124824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SIipjDj72opyEFtxoDCTsvfMZXSlHdKPwPEDXfFHcYE=;
        b=ivw4DOmrzHVBhMZ5PWvdAI4O9Z3E5E7AeehvXy6CrME6XRRFssNrxRbSjUaiCxDgEz
         5ylOxvFAQOHfQZL0N9qx6V8PWBrJUgYoufaGA2Tp5DF3HPYF9JcGBl5FyHMAx6tJfwUy
         C4rIuj8PacUkwcKK7FfgbrQPOB2lC780nH2/DbOUSs/ZVkJvuIb73AYURMEocxz9QCAk
         R2tfYSojqAabQzX8j3tCk5DyUwlm+WOK7RT/gtOTK9lsbWre459FJLPQyn7OMtux0nYL
         /APCfJgBkvdGuYXtyK5LJKgIgTI9hEivGOGyz+H1+0iSNh9NcEauDX0MP06e4BnGOuKE
         bklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706520024; x=1707124824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIipjDj72opyEFtxoDCTsvfMZXSlHdKPwPEDXfFHcYE=;
        b=jc5elyPSCEUMirB/FrBAwZAgaLPO88SOMCavhLFDZs++rno7bW1CXqbF4VqkLCP6LN
         WBt+nBa+Q+YNdmAsfCIpml2Eqn02NUeplL1j28XWtXfGqU130nxlS2QrTvzImjAyG8lZ
         p8rjzSnx1DGFBrP6U94d4GCqOJ6PLQRJamjLj6fPI5zhQdt8izmZqohbdEC/D5/Ry5ll
         /6PctrCI72cqpC9LEZm3hB6DJ59wxEzvuq3H+J1gc3xcm7X9EMz88uS/0NAl2uhcxH2P
         CJ8VhnZsyPH1oK168VEKUL0jsBYkqcwbl+xDhA2DTjdezOPP7C+CcSLQIk/3qCiL+il+
         APOQ==
X-Gm-Message-State: AOJu0YxAaeN3+ulqdGo6H5ACuP+JcToFTkU+Dz/SrHASUoxY43H0fQS4
	phcSH6Aeh2QtbmkehfAdE3dHiHWptSSvqI/UEDegNyj29P1XdExpeOWx0/DplgQ=
X-Google-Smtp-Source: AGHT+IG2hr0oACHmCWtP4hJn4m+aVt8htuFB/yKzQfRP9dDjBRG0JJ3mpfw2aK7/JsjcWDNW1xfBZw==
X-Received: by 2002:a05:600c:1c12:b0:40e:fa51:3526 with SMTP id j18-20020a05600c1c1200b0040efa513526mr780424wms.10.1706520024197;
        Mon, 29 Jan 2024 01:20:24 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id k7-20020a05600c1c8700b0040ef3ae26cdsm4103365wms.37.2024.01.29.01.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 01:20:23 -0800 (PST)
Date: Mon, 29 Jan 2024 10:20:22 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Saeed Mahameed <saeed@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [net-next 07/15] net/mlx5: SD, Add informative prints in kernel
 log
Message-ID: <Zbdt1vy9WLRqMqGK@nanopsycho>
References: <20231221005721.186607-1-saeed@kernel.org>
 <20231221005721.186607-8-saeed@kernel.org>
 <ZZfySfG4VClzDKTr@nanopsycho>
 <6e17498c-2499-4c91-bc50-33bab8201965@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e17498c-2499-4c91-bc50-33bab8201965@gmail.com>

Thu, Jan 25, 2024 at 08:42:41AM CET, ttoukan.linux@gmail.com wrote:
>
>
>On 05/01/2024 14:12, Jiri Pirko wrote:
>> Thu, Dec 21, 2023 at 01:57:13AM CET, saeed@kernel.org wrote:
>> > From: Tariq Toukan <tariqt@nvidia.com>
>> > 
>> > Print to kernel log when an SD group moves from/to ready state.
>> > 
>> > Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
>> > Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
>> > ---
>> > .../net/ethernet/mellanox/mlx5/core/lib/sd.c  | 21 +++++++++++++++++++
>> > 1 file changed, 21 insertions(+)
>> > 
>> > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
>> > index 3309f21d892e..f68942277c62 100644
>> > --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
>> > +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
>> > @@ -373,6 +373,21 @@ static void sd_cmd_unset_secondary(struct mlx5_core_dev *secondary)
>> > 	mlx5_fs_cmd_set_l2table_entry_silent(secondary, 0);
>> > }
>> > 
>> > +static void sd_print_group(struct mlx5_core_dev *primary)
>> > +{
>> > +	struct mlx5_sd *sd = mlx5_get_sd(primary);
>> > +	struct mlx5_core_dev *pos;
>> > +	int i;
>> > +
>> > +	sd_info(primary, "group id %#x, primary %s, vhca %u\n",
>> > +		sd->group_id, pci_name(primary->pdev),
>> > +		MLX5_CAP_GEN(primary, vhca_id));
>> > +	mlx5_sd_for_each_secondary(i, primary, pos)
>> > +		sd_info(primary, "group id %#x, secondary#%d %s, vhca %u\n",
>> > +			sd->group_id, i - 1, pci_name(pos->pdev),
>> > +			MLX5_CAP_GEN(pos, vhca_id));
>> > +}
>> > +
>> > int mlx5_sd_init(struct mlx5_core_dev *dev)
>> > {
>> > 	struct mlx5_core_dev *primary, *pos, *to;
>> > @@ -410,6 +425,10 @@ int mlx5_sd_init(struct mlx5_core_dev *dev)
>> > 			goto err_unset_secondaries;
>> > 	}
>> > 
>> > +	sd_info(primary, "group id %#x, size %d, combined\n",
>> > +		sd->group_id, mlx5_devcom_comp_get_size(sd->devcom));
>> 
>> Can't you rather expose this over sysfs or debugfs? I mean, dmesg print
>> does not seem like a good idea.
>> 
>> 
>
>I think that the events of netdev combine/uncombine are important enough to
>be logged in the kernel dmesg.

Why? I believe that the best amount od dmesg log is exactly 0. You
should find proper interfaces. Definitelly for new features. Why do you
keep asking user to look for random messages in dmesg? Does not make any
sense :/



>I can implement a debugfs as an addition, not replacing the print.
>
>> > +	sd_print_group(primary);
>> > +
>> > 	return 0;
>> > 
>> > err_unset_secondaries:
>> > @@ -440,6 +459,8 @@ void mlx5_sd_cleanup(struct mlx5_core_dev *dev)
>> > 	mlx5_sd_for_each_secondary(i, primary, pos)
>> > 		sd_cmd_unset_secondary(pos);
>> > 	sd_cmd_unset_primary(primary);
>> > +
>> > +	sd_info(primary, "group id %#x, uncombined\n", sd->group_id);
>> > out:
>> > 	sd_unregister(dev);
>> > 	sd_cleanup(dev);
>> > -- 
>> > 2.43.0
>> > 
>> > 

