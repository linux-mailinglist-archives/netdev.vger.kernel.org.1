Return-Path: <netdev+bounces-89170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7BB8A9975
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 14:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 186032817EC
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 12:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF0B15F323;
	Thu, 18 Apr 2024 12:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ThsJEsHB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B988A15AAAD
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 12:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441868; cv=none; b=KfVHwshF5luyaevyLgbeeP9VF5MFYC0uiWVg5Ms9mlf6e+uLNvQZEKhZh4K7lXjS5SsjDwNZp/lgSnNTDAUe0R6bXXFdqwKU4wHtAjDhPl+8PCIsb0rDiCWv7ACWThO6/CxhJtJUrdFCK805k2w7XAXn9sSvppfsOq12ZAMqhy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441868; c=relaxed/simple;
	bh=NSPObthoUmWtROw3vEjSYKn7j4ROgyyvv74mVjGyD/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmDUuYUeBtor3OMkADH7bM8UIdffLjNQ+xuiEDtdBHjWqizRQbC+G0OKUpMZULTnL4UpREyheOf3hP6Z/Xo5DFqAv3xZgyJbDYzTBsQwYWB7dG1Ut4GQa4F8BfS/xIYhMj3ZkKllMM2oqakNQLd82NTSwxZ/fnC/jlHFXaac+8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ThsJEsHB; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e4a148aeeso330997a12.2
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 05:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713441863; x=1714046663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=37f3ccn//ByTUoAR5JHG4cni1pFUTiZHTlyJI9lNZHw=;
        b=ThsJEsHByxVy/qHY75hWmjqUvyKtpOI73bsVC3aGtxJiL5H6itVNCtCqNHml6jdCBz
         N/3O7dvAr832t2wXJGw9HQQ7v1cCKfNxvT9VrWHBlUKRv8bwFsSgiX4LurUnGH/4WWrY
         1GIsO2dNkLDHyxw2tBJ0qozV7LQCFDXmxXds+TD3BYMQ37T5Yr+S6aD41k8o/4KCGR12
         1TgdjhF1aV/RcGOKmLTRvZ7vKK14XBfp5njavRiZ5q8ix3mp7Rk/sycCj2wRRgUgLrTX
         iz6XY/j0Dx5HoxBzcuFx8pkkRj7MFKoXpxxRrjOT2d/dbcV9eVL/+nlLYTpkGkfVuBXq
         UHZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713441863; x=1714046663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37f3ccn//ByTUoAR5JHG4cni1pFUTiZHTlyJI9lNZHw=;
        b=ENxaDg9E/NO8z/zTN2INxJE6XP/SvxTaBClEw6dgKLx/OP2XzWI5IawDByDw7/r+y7
         RXaFEzUwnfq2Jvj7d7YeTlOQu+d5YNKmEif8WDRxitFxDlgnN0PJREtqmtj9psLx7lnH
         pQzeVdcWFctSN85uO9nmCj7EhjtAzBoh/+QXBVfZ6s8/kWA3SoC4ucYGijf4twX18nal
         XhyPJ5Ejo7OEqx48GUdTTI31h3Yo4V0EV1XjuRWjutRv9xLqt6TQ/W7rGK/UIxtzmXVD
         ourmksJEc87mkx/GeFNTaUv8jru7rBTDbH3X/gfsYjfnVISBwSc4m92RLcA7Kyx3/zxK
         VL5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVAGDrrSvIKgrX6/dFLp3FccRIv+5AsuUZAnjh6XmVvAbPRMe1VPyXWA4O6v3csBzrRx363yIvhBCmWh+yLSjnjmi4laNof
X-Gm-Message-State: AOJu0Ywrl+PqHEQxz1gfcWJJJwdCotGOPtURgfHpv2Ci4eRm/HhSadii
	2/lLjFRfq+nVj6ChIcMxkfHHWnclzE8k90JdvnoMPo57d/y3cdTk1I2cVwJbbzA=
X-Google-Smtp-Source: AGHT+IH7SHBw7rC7zllH17bUzX7FhKAwi9y3jf1g1iOqWa0GZ7feR7s5nEWChL+Fwranei5nHBwbRg==
X-Received: by 2002:a50:cdc1:0:b0:56b:986b:b4e7 with SMTP id h1-20020a50cdc1000000b0056b986bb4e7mr2035401edj.27.1713441862964;
        Thu, 18 Apr 2024 05:04:22 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id s12-20020aa7c54c000000b0057025ea16f2sm790411edr.39.2024.04.18.05.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 05:04:22 -0700 (PDT)
Date: Thu, 18 Apr 2024 14:04:21 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com
Subject: Re: [iwl-next v4 5/8] ice: allocate devlink for subfunction
Message-ID: <ZiEMRcP7QN5zVd8Z@nanopsycho>
References: <20240417142028.2171-1-michal.swiatkowski@linux.intel.com>
 <20240417142028.2171-6-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417142028.2171-6-michal.swiatkowski@linux.intel.com>

Wed, Apr 17, 2024 at 04:20:25PM CEST, michal.swiatkowski@linux.intel.com wrote:
>From: Piotr Raczynski <piotr.raczynski@intel.com>

[...]

>+/**
>+ * ice_allocate_sf - Allocate devlink and return SF structure pointer
>+ * @dev: the device to allocate for
>+ *
>+ * Allocate a devlink instance for SF.
>+ *
>+ * Return: void pointer to allocated memory
>+ */
>+struct ice_sf_priv *ice_allocate_sf(struct device *dev)

This is devlink instance for SF auxdev. Please make sure it is properly
linked with the devlink port instance using devl_port_fn_devlink_set()
See mlx5 implementation for inspiration.


>+{
>+	return ice_devlink_alloc(dev, sizeof(struct ice_sf_priv),
>+				 &ice_sf_devlink_ops);
>+}
>+

[...]

