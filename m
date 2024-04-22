Return-Path: <netdev+bounces-90135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9C48ACDAD
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 15:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527BE1F20F54
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 13:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA47614A4C4;
	Mon, 22 Apr 2024 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="bfDaePoo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A78746E
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 13:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713790940; cv=none; b=c2TilLTHHyFmWmxU2tpZ+gwsCK3DevmqLldYATtc3oAVy3Q0tWH1uj3BzfbX3ViTNaBLE3CZ/fXOATo0V/OuK/bcuSlmXkghqgPvdpg5aI6IDwyZw2ICx5VH9PpbNQa0lfSXfaUWeJr+d8my4lIzEyxUF1STkMmHUvKaYOO3B6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713790940; c=relaxed/simple;
	bh=HiztFdgqaV8KD4r9t+kYvJXPXgbRU5w9CQbYk3ihQqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JREqXoho0hQIQNqFJfNxnkuM1KyG2VsZ1nPFnwG9iNlphxwZwbPdpKBwn08I2SWq01oL/Bm38aHXJsynYj/apM8nKS9zynbgJyb/SNI0hqPtiHlFXSHbGqCsnYWgbTJcAiFUJABtK5dv5j7FTGIX3eWHzmihm4uvNOcpuCjqZGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=bfDaePoo; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41a0979b9aeso10848645e9.3
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 06:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713790932; x=1714395732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qm99+1pJ8lbqw/SE/f1RwUN3qOZS7r1xsqomwM1clCE=;
        b=bfDaePoo7hOaamusFoD0TN/JyQq6eTgAvC04Bo6r/GqCvOAqj1LPjQa610Uvy5aLCh
         CF6bMCh0bxeRQYdgKZxOcDzUTELL2LK/1jHEvX87JxwGLsOREcnBaPPcV+rcMyu8gUcw
         e8m3S65rYkjDfI3mg9shKYIZaID+KCw+s3M4XH+a5tTrWk2KNSporOvmfNDrRMjO5lvw
         FmO51Wrc2UcEAJvaPshjOC6/pmRtzRAy0RynuSwxZi6UM+laBbu1iNWdQ4O6I7C2QPoo
         A7dH3mLqil7nclbC2xCKlvuFHobCCPwZx1xaM6nqtL1zLc8IwZEzkVwcOP4iXEkfBPVh
         DQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713790932; x=1714395732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qm99+1pJ8lbqw/SE/f1RwUN3qOZS7r1xsqomwM1clCE=;
        b=luY6TajELn/Q9lyjsGHIrleGNZUCA9w9+Rhl71LfLyd9dl1kPVjAmzmNuBGPUL2/w5
         8BoegRe+2lBBNnFgZbfVDnKosik7YXwbNir5I8rXPd0/dBAOLCTWY/eCWSCpIXPenqnN
         Lc2VWIImpyRNi0F87tq4Xe8KuDNjFXU9KFsb4r78BKKuayVKXSljI8Lnd3i70BICft44
         el+4xnmT8O2sIApt70PTRracKPwcwTjdEVDauaswGYhBawJGNmSPtM1DW/FQ4RkVzXuT
         0hy04J9mHccCCZGeLGzHj+tbXjliHRWjLU9qhp31vczGAhl8Dte5TP3h4WlO/xXEL8sZ
         Gnmw==
X-Forwarded-Encrypted: i=1; AJvYcCXTUzrCPmrIuhYJg2tRX59ADbMJP0ZgLSgNlWUToZ7EPlwKAOpa0V1HUqMFMq/gzvN1iV8l9Ue69LuM7Ixsuyitr/lDSgBa
X-Gm-Message-State: AOJu0YxAbUKvJeJJuQhvX4ouTfHlaFC2BPCIaJ8KzT+mH4ht8UUK2IV+
	37fDcuNNy9FptakECpx7ZXEV/EmSDHvwSiYf1yh6xJmQiB0bMNH/6BzArPsgkus=
X-Google-Smtp-Source: AGHT+IG3NklYHUNy3UDg5EkitlWCH3cW4NlqKxBNkiYa584fYnuPfopZscWVPOTdu1h6QogJnanWFA==
X-Received: by 2002:a05:600c:46c8:b0:414:d95:cc47 with SMTP id q8-20020a05600c46c800b004140d95cc47mr9577310wmo.30.1713790932386;
        Mon, 22 Apr 2024 06:02:12 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id bg5-20020a05600c3c8500b00419f419236fsm8281965wmb.41.2024.04.22.06.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 06:02:11 -0700 (PDT)
Date: Mon, 22 Apr 2024 15:02:10 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com
Subject: Re: [iwl-next v1 0/4] ice: prepare representor for SF support
Message-ID: <ZiZf0k-38srn486H@nanopsycho>
References: <20240419171336.11617-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419171336.11617-1-michal.swiatkowski@linux.intel.com>

Fri, Apr 19, 2024 at 07:13:32PM CEST, michal.swiatkowski@linux.intel.com wrote:
>Hi,
>
>This is a series to prepare port representor for supporting also
>subfunctions. We need correct devlink locking and the possibility to
>update parent VSI after port representor is created.
>
>Refactor how devlink lock is taken to suite the subfunction use case.
>
>VSI configuration needs to be done after port representor is created.
>Port representor needs only allocated VSI. It doesn't need to be
>configured before.
>
>VSI needs to be reconfigured when update function is called.
>
>The code for this patchset was split from (too big) patchset [1].
>
>[1] https://lore.kernel.org/netdev/20240213072724.77275-1-michal.swiatkowski@linux.intel.com/
>
>Michal Swiatkowski (4):
>  ice: store representor ID in bridge port
>  ice: move devlink locking outside the port creation
>  ice: move VSI configuration outside repr setup
>  ice: update representor when VSI is ready

FWIW, looks fine to me.


>
> .../net/ethernet/intel/ice/devlink/devlink.c  |  2 -
> .../ethernet/intel/ice/devlink/devlink_port.c |  4 +-
> drivers/net/ethernet/intel/ice/ice_eswitch.c  | 83 +++++++++++++------
> drivers/net/ethernet/intel/ice/ice_eswitch.h  | 14 +++-
> .../net/ethernet/intel/ice/ice_eswitch_br.c   |  4 +-
> .../net/ethernet/intel/ice/ice_eswitch_br.h   |  1 +
> drivers/net/ethernet/intel/ice/ice_repr.c     | 16 ++--
> drivers/net/ethernet/intel/ice/ice_repr.h     |  1 +
> drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  2 +-
> 9 files changed, 88 insertions(+), 39 deletions(-)
>
>-- 
>2.42.0
>
>

