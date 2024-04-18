Return-Path: <netdev+bounces-89291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2B88A9EBE
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 17:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FFC11C2211C
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABE516C852;
	Thu, 18 Apr 2024 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="BvPnHgBu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C858B16C69C
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713455015; cv=none; b=B/uvkBggoyH7yyoVwgu1ho1sjZVk/ICVOoxMqjlehy8tyVuve1p+NGzx6m5l8JhRtu5f8IgHzwJIsiTCmPQiEgdAveo5Dkltpq+xZJfPo3MJrmKVvpdflsZXpSy6eaky6kxnLDKJDxNpukepbn/2A0rxKjzbfTodbrAXBy6vGAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713455015; c=relaxed/simple;
	bh=yZCORKnbVIP5ti4V5j3IoiNsgVb6JVqnt6H1A4cmzBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhGmgz6sBmu7TQWim9Gu1GiytMSWotu7Tb8L1arK1jwKZjjo6PKSCPvg03UBOCHChMrhEm7XVajzyQCDZK8p0RJqcnpq+Hw6Y6APiQZdEns0RzO9gUmkxIUM+vYnEbl6UrU9brz/sJqB0m8xPBxTl9FFvUlSqGde1NJN7/rsiYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=BvPnHgBu; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d895e2c6efso13620811fa.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 08:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713455011; x=1714059811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wv84R62W+nFZK9Qn4TJM8MSeWSQNQQ/88HdTwn4ZbCo=;
        b=BvPnHgBuSUcKc4qq5GkWTfyZHTsxdoDy0e7kOqzxcSYYUCntGr+2MnRMe9jdFU/WCo
         lXVyknAmdvSqEvrfIDvrxZ9nU2RDN4hWhZAI6V8VU5R9A1AG1YPJ/WdPo0nyLK4zpIpc
         9C9gwF96x8+6Sjv1o7fUSSghwlmejsD76cqybmYAYvuhjtF9vOrDEaPK89seuoeujH32
         KczNOwcbE0YrJTikssYIslyCvz9+sl0Pq9T/pB+e6b/j+osQwymHeg9Qw10Bz0FGXZ1n
         bIgKxjG/UyVivmtBVVOs3Ae+0AGDrZqG5ybQXeJH7raovxST7zF6zE3n9RE1/IQ2DCfq
         NoZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713455011; x=1714059811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wv84R62W+nFZK9Qn4TJM8MSeWSQNQQ/88HdTwn4ZbCo=;
        b=UCqfT9lAwCysFTGHRKrMAXKld0PmHcgx7DlrlTSyBg1w4C9lQ/k10IRbpvFnAkk29F
         +wwOjcSzQstz2oVrOjz3hrduMOK09ggnY3im0CODUuORy9u5mGqu7pnS2omMdtf6VCJt
         CG2gQljLB7c3es7rki07X4lQSbhD0FCbxVCIIPO5nS8LF4n7wC0+lGigeiMT2veZaG4s
         vUu2EZm6eobrCDiUBFjZvHQSf+ounCYzF4nULu1+dpNMYxKbg8y5/yZP7ZHU4iyOSPfM
         1ofVV/heT8nifWilVG+xWdW29+SKnGk9yS3sy1rbvWUNTZtMka0/J5Zy81hYMvXxkZIN
         iWqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBC5rtIpDwVgHNJ7yAle03jpbDsErVORkXUaxRmMCEpcCXCQIDHOqxNe+Gc3ePhWeIFllFAIYGZJCdp11noP9+g/cHdsTb
X-Gm-Message-State: AOJu0Yy5GQ4vS525xgipFwqY7zuAyEP7BCvwPsbSBMI2Mv/ARPY7ZBvd
	6EK5n0oL6jkWsp4lb/TrinsFS3NjSEjmvz6q6/o5DRtvvePrTC2iLVHpkroWWA0=
X-Google-Smtp-Source: AGHT+IH/KyPVd/2LhG5m5ZqHdXTFDZ0mdyAPGoty0zRQjHntyWkm4XehwnesZcdxZcnx+px/dhRbCg==
X-Received: by 2002:a2e:3015:0:b0:2d4:6f14:53d5 with SMTP id w21-20020a2e3015000000b002d46f1453d5mr1794363ljw.26.1713455010518;
        Thu, 18 Apr 2024 08:43:30 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id o12-20020a5d62cc000000b00349c42f2559sm2112203wrv.11.2024.04.18.08.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 08:43:29 -0700 (PDT)
Date: Thu, 18 Apr 2024 17:43:25 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com
Subject: Re: [iwl-next v4 5/8] ice: allocate devlink for subfunction
Message-ID: <ZiE_nUEsGT8Cd3BK@nanopsycho>
References: <20240417142028.2171-1-michal.swiatkowski@linux.intel.com>
 <20240417142028.2171-6-michal.swiatkowski@linux.intel.com>
 <ZiEMRcP7QN5zVd8Z@nanopsycho>
 <ZiEWtQ2bnfSO6Da7@mev-dev>
 <ZiEZ-UKL0kYtEtOp@nanopsycho>
 <ZiEyP+t9uarUrLGO@mev-dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiEyP+t9uarUrLGO@mev-dev>

Thu, Apr 18, 2024 at 04:46:23PM CEST, michal.swiatkowski@linux.intel.com wrote:
>On Thu, Apr 18, 2024 at 03:02:49PM +0200, Jiri Pirko wrote:
>> Thu, Apr 18, 2024 at 02:48:53PM CEST, michal.swiatkowski@linux.intel.com wrote:
>> >On Thu, Apr 18, 2024 at 02:04:21PM +0200, Jiri Pirko wrote:
>> >> Wed, Apr 17, 2024 at 04:20:25PM CEST, michal.swiatkowski@linux.intel.com wrote:
>> >> >From: Piotr Raczynski <piotr.raczynski@intel.com>
>> >> 
>> >> [...]
>> >> 
>> >> >+/**
>> >> >+ * ice_allocate_sf - Allocate devlink and return SF structure pointer
>> >> >+ * @dev: the device to allocate for
>> >> >+ *
>> >> >+ * Allocate a devlink instance for SF.
>> >> >+ *
>> >> >+ * Return: void pointer to allocated memory
>> >> >+ */
>> >> >+struct ice_sf_priv *ice_allocate_sf(struct device *dev)
>> >> 
>> >> This is devlink instance for SF auxdev. Please make sure it is properly
>> >> linked with the devlink port instance using devl_port_fn_devlink_set()
>> >> See mlx5 implementation for inspiration.
>> >> 
>> >> 
>> >
>> >I am going to do it in the last patchset. I know that it isn't the best
>> 
>> Where? Either I'm blind or you don't do it.
>> 
>> 
>
>You told me to split few patches from first patchset [1]. We agree that
>there will be too many patches for one submission, so I split it into
>3:
>- 1/3 devlink prework (already accepted)
>- 2/3 base subfunction (this patchset)
>- 3/3 port representor refactor to support subfunction (I am going to
>  include it there)

Sorry, but how is this relevant to my suggestion to use
devl_port_fn_devlink_set() which you apparently don't?


>
>[1] https://lore.kernel.org/netdev/20240301115414.502097-1-michal.swiatkowski@linux.intel.com/
>
>Thanks,
>Michal
>
>> >option to split patchesets like that, but it was hard to do it differently.
>> >
>> >Thanks,
>> >Michal
>> >
>> >> >+{
>> >> >+	return ice_devlink_alloc(dev, sizeof(struct ice_sf_priv),
>> >> >+				 &ice_sf_devlink_ops);
>> >> >+}
>> >> >+
>> >> 
>> >> [...]

