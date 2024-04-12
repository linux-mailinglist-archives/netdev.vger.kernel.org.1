Return-Path: <netdev+bounces-87307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E80D38A27D2
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 09:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25ADC1C22559
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 07:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB704655D;
	Fri, 12 Apr 2024 07:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="JWPHKFZF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D4E8F5C
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 07:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712906425; cv=none; b=DgS2paRtyiEwtwsrG2HbbGVTLf326E4bzu1Rm3/Yy5pj3J6vTUL4N6pQ7h0UqWR7lzGtXVNd2eT2jmAGxRjB+v9t3CLrDlGY66KJIs08rFSmPWR7UnTUUuh0HqWAC4DNLO30+DkNmWdFGs9Gd6tzOsLupbJQCz07ztkFMBkLsTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712906425; c=relaxed/simple;
	bh=/hETkjv1iN/Uez3VNUgyub6IOOBYWx+XdQ6KBbWFX/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8EZ73sGqDKTC2WRaaHh+fFofan94GeQOnJBm9bWpte75sNOqidpvKRVhoYsmt3PmPdc6pfvGH8XIqDTdUzoS5adef2khRwKXCmH/xFuoTT4srMzPaO8FbcA5HoBW8vMKqXhHa4MHZ9+FtMEKGH0by1Ck3UyGr7N5MvwH5nQi1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=JWPHKFZF; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516cbf3fe68so753265e87.0
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 00:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1712906421; x=1713511221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/hETkjv1iN/Uez3VNUgyub6IOOBYWx+XdQ6KBbWFX/o=;
        b=JWPHKFZFS4nYVNKX0mSQ9+UCvXy+7uLYggfHp20Cr8xJKIdSWsFX8yPHJVeck/O9Wg
         sQuB1gQptABEwPW6oQs6hostJLZsSvwuPWriQ+PBAYWIXOW54dY7aly6Y8xtaQHxI/G5
         mVWgIBugCYb6FEqLBnc4qAM4InY9T/UHJdPAUTZq5FRVslzPlfucGQezrOzJ+2FsmSPv
         0Vict3WtJaxC58wr/QOnPfHC3AFSYIKGMxv5ht3VPgypViPfolAaXAefXPoFjX7qVrPI
         bE8OdQ1lkL8lcjhxgALKSx/VJmxv3mVgFrltr5RA+7uiCWNiXzc4d4Zr6Qs6kj/T0xBN
         K9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712906421; x=1713511221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hETkjv1iN/Uez3VNUgyub6IOOBYWx+XdQ6KBbWFX/o=;
        b=EugkyW7T1vcgpR7PlskvURvEl55Q4FndVVZzPv/LUYX8VLjt9OY+0H4HcR2xFaffLO
         K7S42+HJcK00VwUM6p+JlqTc/HvknepeFcjRIv7XIhPsl3YY4wuY6u5zkCeL2QnbBtwo
         rmGwBin/CDLeC/YCVq9eXodgInUXPVVWG4DPrg5fNm5Px5Vd2Eedq3QfiP4ZAvmhJVsx
         ixwGPArbXlKnMSlAWDirjJPjZkepTPWsb6XA7XNgb8yE4gSIke5EJHOct+612I5s5eXE
         lyby4o094IS2+J7t/ZRe5OdlkBLgAbbi9iWsACPnd7Vcco+ZQcSu+bEjJJZ9ZmDgN0Oe
         ycmA==
X-Forwarded-Encrypted: i=1; AJvYcCVqnVL/v0AQubOGqQ8GmBiY2/NFFSdwS3Ikdzx4589SYaCgMOjTmMjV3QaG182d6HtubBXH8KZ/oJJU31ftVe9u1SPKEoqd
X-Gm-Message-State: AOJu0Yyllb+cUAOBFToRmRJuhuFdfWnh8toYG8RCq2XmHR3uapGjFXDV
	+cj3jNxFTBEnnMs4qyrzUXttu/9D069cnQ32JdDTl1W6VQ8gcyAa3rH9dBOKMSw=
X-Google-Smtp-Source: AGHT+IFLe7RifxtQxqtjmK6B5O9eNd0MR5sjGR86QN3vKg/4TzdpDfDeqTv+9mwREQpJLKPCPEBa4w==
X-Received: by 2002:a05:6512:29b:b0:515:9abe:6c46 with SMTP id j27-20020a056512029b00b005159abe6c46mr1007371lfp.34.1712906420875;
        Fri, 12 Apr 2024 00:20:20 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id w10-20020ac2598a000000b005187d5cc274sm177157lfn.227.2024.04.12.00.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 00:20:20 -0700 (PDT)
Date: Fri, 12 Apr 2024 09:20:17 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	mateusz.polchlopek@intel.com,
	Piotr Raczynski <piotr.raczynski@intel.com>
Subject: Re: [iwl-next v3 5/7] ice: base subfunction aux driver
Message-ID: <ZhjgsaK7hppdrFwM@nanopsycho>
References: <20240412063053.339795-1-michal.swiatkowski@linux.intel.com>
 <20240412063053.339795-6-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412063053.339795-6-michal.swiatkowski@linux.intel.com>

Fri, Apr 12, 2024 at 08:30:51AM CEST, michal.swiatkowski@linux.intel.com wrote:
>From: Piotr Raczynski <piotr.raczynski@intel.com>
>
>Implement subfunction driver. It is probe when subfunction port is
>activated.
>
>VSI is already created. During the probe VSI is being configured.
>MAC unicast and broadcast filter is added to allow traffic to pass.
>
>Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

