Return-Path: <netdev+bounces-89203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 249738A9AD1
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55D531C21472
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 13:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8998613C3FF;
	Thu, 18 Apr 2024 13:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="r6C12IyW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F10D1442E3
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713445382; cv=none; b=PS1CJZGWTO8j6usE4Lpt8rAjsSn8J4eK3+OutD2tj1MBs0yqV2P55RTFhrqnvEGtX+lrG61H9XW4n4PKrfm04nCkDR0jst1lam+mRxR9PETlPbhmv2Ep5UkzRwPFxuX7gh1VJcvXbG8J16uHHuIe5CKdfpZwzCiOWBtVoj6Qr/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713445382; c=relaxed/simple;
	bh=IIo/O0ksaEcToCeBEhuz28y/cPSHvOHeMuu1BA1ATUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVe1o0IkY3YSKh9D7r4/GgT55TgRVewZj2+DOsKISVw3HaZKJB6b8EL9Mmm7zPyzv9gXSUWcmyx+ztYxJ3Szay/ApTLAQWlbeTC5QJECvP343r2vgqLXCa0KzpzPMwo3mqFqx/JH22PMiECo7S1nQglaJlJW1LT394TSb/d6bmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=r6C12IyW; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-418c979ddf3so6675315e9.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 06:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713445375; x=1714050175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1EtvARd3LNiKuseaLsK3AxuTAIqX4rdxJ4FBJML0okc=;
        b=r6C12IyWxOhRw5cCJiWlc0zXjIfG4+u1R3NOaeRWgl8JhS2ndoUGNCU/H7VheSflWt
         Csae22aFLsYrve3IIinDsSdkqlqimATZNR76dQ3xWyJvhhPVu9GjRg93nhpr08WhIVNm
         DWJgypyum0QGK4oGzf880lXlrwNf47GaVRvHvgtF1oIAeAe4BS7oWhwkfJrJ6UDGBqyo
         brkJpm4rbr5Iub+KxHDBxDc2LtW2p8aBtwytaSNasAxBgAM1HlZw/8a4Gawn8mofMzej
         8nmzstbCTQCoHmDwDnfvptedqqZuiJCCMx32/+f97I0d/Binmh1vpKcS36nP/71TYo5F
         F5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713445375; x=1714050175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EtvARd3LNiKuseaLsK3AxuTAIqX4rdxJ4FBJML0okc=;
        b=JMfnaMm7p3CgbxrKQLgIaRxA80s7BBVbOJuE/v7hUdBKpmW4JEAeERx1ApU8gjc8HU
         Gz4PR4Y3WzuN6llnIblCVfLjK4IZSpvwCapTVBiZJbOJwbx+MPXljGAKIQTCy/dP+r0y
         x/hoxFNxhWuMbgNvKS0K7pnTlGh05yzs2Sis6xq6slX9eDkjnfsAiNtfUMPV9CEFPoBv
         c8QPzvkjhz1KwCoA2nWUzwHik0YJ7+n6GRyBGuo+5QviVmxvZKVL7y+x8ykjIUA7VfpD
         F1avEUukzhPnB6MnxH7R52ZSuaMDNeDbl0vFpTA+7ZhZhRz23/BqLpRKiT8smgcKpNgS
         2UJg==
X-Forwarded-Encrypted: i=1; AJvYcCU4dLPMg4n/K7cj5M7ZtQ4fUoq9xixTOnjXp6iukGUtb+ZrC9lw3zoGdf4gNoNH++BADmreVpO5g7YIx+QKL/Q7gK1Zfpen
X-Gm-Message-State: AOJu0Yxs8MbSmhSa/z10SY+ksb3E8JT1XlBbk58YxPI59OQLA9VLuZ8g
	N3yUVd3Rtyr7OqaP8PbESOQw94qrYVXjLs7yWkhTwUscZZizA5beh8ld6T6ogUA=
X-Google-Smtp-Source: AGHT+IEhPAVXWXhk09rCMXcAkKygM5NW7vUYRMs+Xdl9WLBb+h1dXhG56C/WpvIJLOujdDLTkptYvA==
X-Received: by 2002:a05:6000:400e:b0:34a:3148:47f2 with SMTP id cp14-20020a056000400e00b0034a314847f2mr446938wrb.18.1713445375376;
        Thu, 18 Apr 2024 06:02:55 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id b16-20020a5d40d0000000b00346406a5c80sm1791455wrq.32.2024.04.18.06.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:02:53 -0700 (PDT)
Date: Thu, 18 Apr 2024 15:02:49 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com
Subject: Re: [iwl-next v4 5/8] ice: allocate devlink for subfunction
Message-ID: <ZiEZ-UKL0kYtEtOp@nanopsycho>
References: <20240417142028.2171-1-michal.swiatkowski@linux.intel.com>
 <20240417142028.2171-6-michal.swiatkowski@linux.intel.com>
 <ZiEMRcP7QN5zVd8Z@nanopsycho>
 <ZiEWtQ2bnfSO6Da7@mev-dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiEWtQ2bnfSO6Da7@mev-dev>

Thu, Apr 18, 2024 at 02:48:53PM CEST, michal.swiatkowski@linux.intel.com wrote:
>On Thu, Apr 18, 2024 at 02:04:21PM +0200, Jiri Pirko wrote:
>> Wed, Apr 17, 2024 at 04:20:25PM CEST, michal.swiatkowski@linux.intel.com wrote:
>> >From: Piotr Raczynski <piotr.raczynski@intel.com>
>> 
>> [...]
>> 
>> >+/**
>> >+ * ice_allocate_sf - Allocate devlink and return SF structure pointer
>> >+ * @dev: the device to allocate for
>> >+ *
>> >+ * Allocate a devlink instance for SF.
>> >+ *
>> >+ * Return: void pointer to allocated memory
>> >+ */
>> >+struct ice_sf_priv *ice_allocate_sf(struct device *dev)
>> 
>> This is devlink instance for SF auxdev. Please make sure it is properly
>> linked with the devlink port instance using devl_port_fn_devlink_set()
>> See mlx5 implementation for inspiration.
>> 
>> 
>
>I am going to do it in the last patchset. I know that it isn't the best

Where? Either I'm blind or you don't do it.


>option to split patchesets like that, but it was hard to do it differently.
>
>Thanks,
>Michal
>
>> >+{
>> >+	return ice_devlink_alloc(dev, sizeof(struct ice_sf_priv),
>> >+				 &ice_sf_devlink_ops);
>> >+}
>> >+
>> 
>> [...]

