Return-Path: <netdev+bounces-94875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 050098C0EC2
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8942C2816CF
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 11:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F48130E34;
	Thu,  9 May 2024 11:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ttJmFKd7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6B5130488
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 11:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715253373; cv=none; b=Qk5YAksOeFUEMZLaXEaK5qJBKdaA/LDQ4E3OxApd743G5kHphgycshNW5PwAJ7YHRVNpeaDTOY4Mxr5hjHzCpuzCi5zp/dnFudeTZI376gEGFeV9HaYfIxupwgVoPpjii4ZE5O2OtoaMcq1ReqJEKvMeGx02Qd5XbtNDM7B7rXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715253373; c=relaxed/simple;
	bh=4u30kZoxQBjWFH8koykfIxVdu/Yx8T8HI0t+rNi0REg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KfGUHz8wkCRjnP9N6F+bnf7MFmcuKa7TDaG8FIo1KEMRI4KalS8mar7FiGyNzeyS/zE9LSx73n7xoBZzRERuoj3lZF6y0Hf5cFdIph7DIba2UMphFEzKZTfa7OvQZCjuy7mOpc9uAMyhzXDWeYJmNR26ZUy2utejjLNMB8RzUzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ttJmFKd7; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2df83058d48so9089651fa.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 04:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715253370; x=1715858170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AFuUqAbs5MXoJpctNR4nsrfOq1ZqzqbPUpmX6ZjWvEY=;
        b=ttJmFKd7LVb6dJWmc3l6umiZXr03Fa4jbbE5FnErafGuR1ts6Tscyp7DE7VCLQJZTD
         CN5jEPihG7jYzvi448Hkw7XkHb/+Rtok4qu7PpyDRf7wWv3TQ++kfCniuQVZwGJNjyMl
         J7KKs/nKQl+izAe8/M240OO6yMRfAEkf7e7BN7KbJbaNAifWYqjj8LQJfDzwKqWdpkp1
         8eYK/UTIe9ZLGQ9sl+dQiTLYM74Oe9zvk9NbNqgIEs0ral0mfL+TIr5/g55pj6v0x8ZV
         8VYBon8YBcgyMz3YlfdlWUBmsyYk4n3h+H26Ff47BNKHhmzazPNh+cXulNuzUDlQLh4o
         PxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715253370; x=1715858170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFuUqAbs5MXoJpctNR4nsrfOq1ZqzqbPUpmX6ZjWvEY=;
        b=MWkBKP99pj18WDnOTxJG0UKiChDs1y99C5DS74tmauf/ZIK9eMEwSDObObaJT7D/5q
         4F/S8Jv/EvFg8j4BjATW4805rQxdGu/J8iArSJchnaG230QyQGrXjjGMKQwHPm3t8k3A
         3QxAwOFfoWNbDJotDQwc/NycG0UlZDYOy3Q8aS7R0gzmSxurEyffYARrJQEQQjkOYLGG
         dV90rik09Rxr934kfoysWW9qaUUdR8iHWq6pZpoQ18yVqj+BPDE6FK7PH/BJ3yOPJ+7w
         BUzckb5t+odhWSuIITG/YsWDfTSFYn5zmfv84aHQEwvFQIFv+wSdfQuI7X97ilOwSqKo
         +thA==
X-Forwarded-Encrypted: i=1; AJvYcCWCgaS73xC6U9ExqBHWDW12HxJ1TWirW2O3BHgv5UIuDS8R6DRBaDar91NdAc8B/qGiAOmZTsPzGhB/WcgBXrlBzMJMT9u/
X-Gm-Message-State: AOJu0YwbMPdn0X0tAwAdO8idggw9aIGkc3Xi0yj0RYdLVRA5VTaEoAxb
	o/mFrooGWLRePMmjolS4bRzY98X7iTtdvB7PNwZGb6WS46DJw+qc08Mj3mJjH3I=
X-Google-Smtp-Source: AGHT+IGm6muKgNQz+Sq946eF9NxhstzvJKt8rFmW5lH/znHG9AqgwH6mHrZMxiX36JRtGjK5Ttz65A==
X-Received: by 2002:a2e:a54c:0:b0:2e2:a0f0:4e74 with SMTP id 38308e7fff4ca-2e4477b4e16mr41683101fa.52.1715253369473;
        Thu, 09 May 2024 04:16:09 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a7826sm1425094f8f.52.2024.05.09.04.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 04:16:08 -0700 (PDT)
Date: Thu, 9 May 2024 13:16:05 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com
Subject: Re: [iwl-next v1 08/14] ice: create port representor for SF
Message-ID: <ZjywddcaIae0W_w3@nanopsycho.orion>
References: <20240507114516.9765-1-michal.swiatkowski@linux.intel.com>
 <20240507114516.9765-9-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507114516.9765-9-michal.swiatkowski@linux.intel.com>

Tue, May 07, 2024 at 01:45:09PM CEST, michal.swiatkowski@linux.intel.com wrote:
>Store subfunction and VF pointer in port representor structure as an
>union. Add port representor type to distinguish between each of them.
>
>Keep the same flow of port representor creation, but instead of general
>attach function create helpers for VF and subfunction attach function.
>
>Type of port representor can be also known based on VSI type, but it
>is more clean to have it directly saved in port representor structure.
>
>Create port representor when subfunction port is created.
>
>Add devlink lock for whole VF port representor creation and destruction.
>It is done to be symmetric with what happens in case of SF port
>representor. SF port representor is always added or removed with devlink
>lock taken. Doing the same with VF port representor simplify logic.
>
>Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>---
> .../ethernet/intel/ice/devlink/devlink_port.c |   6 +-
> .../ethernet/intel/ice/devlink/devlink_port.h |   1 +
> drivers/net/ethernet/intel/ice/ice_eswitch.c  |  85 +++++++++---
> drivers/net/ethernet/intel/ice/ice_eswitch.h  |  22 +++-
> drivers/net/ethernet/intel/ice/ice_repr.c     | 124 +++++++++++-------
> drivers/net/ethernet/intel/ice/ice_repr.h     |  21 ++-
> drivers/net/ethernet/intel/ice/ice_sriov.c    |   4 +-
> drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   4 +-
> 8 files changed, 187 insertions(+), 80 deletions(-)

This calls for a split to at least 2 patches. One patch to prepare and
one to add the SF support?

