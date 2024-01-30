Return-Path: <netdev+bounces-67145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6297784233C
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 12:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E56C28A8A4
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 11:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B9966B5C;
	Tue, 30 Jan 2024 11:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="mQXbhnBK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF546679F1
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706614582; cv=none; b=QitSK9DfTJTZGk09KROZZN5wJQmKyunKAq5ZbKq/DCjvgQYSDkAD6BKlaOXEHqfa2V9yGOrwSFG8fo4DZ2Unc0healErK8SoJ4fztiPn0qNLSqyRjNjuhGjxS3QuI22AWeAW0imcAMMFQoZY71WHcLEPs2kj7ABhKdSmN/oMsVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706614582; c=relaxed/simple;
	bh=9+tpw6eqVoUx8DaCJOPQlB7e2IqZMzgG6zdL0c9ayVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZLINwoecBhY3pzgtx9UCYJ6lRPCR82G9bGqKhKZr8uN6paApfXS5M8QlU2kF31jtdCbcd7KoqlhU3ES0OilRtTNYKPNEZKKzJv109dCbPm/yhUgJexZLlYyBnRJMn1namStvSX8IUBp1Wh9CuscfNb7m4LdsNweYp4Bqep0QsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=mQXbhnBK; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5100cb238bcso6887142e87.3
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 03:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706614577; x=1707219377; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z589ah/E+arRK+98FIzjabP+mwM/CT6Cv5/SEuddldo=;
        b=mQXbhnBKxm4oQCURC62qAEF8jke1NsWKVD9pHO9c1SJcxDoHnkF2BvpNFgLBiWDK6f
         SAqaG8K8xCT+Tk+CEWz7OcSB4pNjWI1a2cHU875MCCxOZQcnxs66bH9vZ/oCz6Uc882g
         D0p9lyXd8Be5Od9mbpx6zq36RKaAaz2KS1xBUl7G2Gbc8X5cjndcAQm8AzaUO2sN0TBB
         1Q8rkDgP9hEnjx8tqXjTylcJZJLg3BJXJmt2edpQZWB7CmHrFT0IrUZtVaaL+4tdrbHG
         KQI81Du+e2MobGUErGTxPBe5pNexzlYkwKwg74QQ3ihkVqJ56R+4DVHISmvGl3S0CBCu
         E2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706614577; x=1707219377;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z589ah/E+arRK+98FIzjabP+mwM/CT6Cv5/SEuddldo=;
        b=dRohP7knrUOlBTZMYQj4fT4urUlI1KZsOwns2SbLo+NKLay5UqeydGQqZrnnsZ+04I
         l/fZ76MYlsmVsDR7N4GgLdcn1EYo9pGri2rarIG1PSi/sfpapjLwzk0fjfuWV02nsI1d
         hFPXFzTVGu0OuNSddXn+yxR+kOWuPpmovPaW9LJ83WwYQ4L7htO3AR02x3ijQm07UhRD
         EK4eXkkM2n8INM17v0eIL3tPQ3zs03v2gPeSiN2ePUBrFJanqX5dhL4XtRm3rOsAyBBg
         wiAfNNHZ8kh1OuOiTmXkw7nueG7AvqkY1YukIwVAqRkPA7bde43dCfpz6eX4iGq6XMoE
         l9sg==
X-Gm-Message-State: AOJu0YwEdjwZE1xxwnIYq/jNwAlUusY4zdj4gvqjidS7O3iGdd4YwoI8
	VHy0YvQJTvNlSfnP2RY++dHocbMJ61DL/Y56jTmJ+rVAAfVrV90sXAUeTw+Ccm8=
X-Google-Smtp-Source: AGHT+IGPy0uAw1buNJJZrWt9XnskuJ7XWCPeSlguGsvrKZhuhRZxrERWaw+BR+NwHlRl4eEuwszBng==
X-Received: by 2002:a19:4316:0:b0:510:1624:d78a with SMTP id q22-20020a194316000000b005101624d78amr5164645lfa.48.1706614576641;
        Tue, 30 Jan 2024 03:36:16 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVe/u7U2u9Ln/gA3oj6ap3ovswULcaPor+4WIElnNSdl+h+6A880MWIFKr9qsIHLFnjEiU21Dzd2p7Yv37/fXKTvF4Fxm6Je3rSg+qcyMHLCnrho5ZxB3pMElQs3jzG5V7gxzMFNTn0Qi0VTS+M6qusiHzPm1UvYbYs+/O0pZHE2lo6HI0z30GETvvhtV5++qPJQcK784hHRzoWVUz10QoOGkA2er0hnJxK+x6B0lo0CHcuZltn/nP6Qp0Njr+JsqCYGw==
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a13-20020a05600c348d00b0040f032787casm1518334wmq.38.2024.01.30.03.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 03:36:16 -0800 (PST)
Date: Tue, 30 Jan 2024 12:36:13 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com, vadim.fedorenko@linux.dev,
	paul.m.stillwell.jr@intel.com, bcreeley@amd.com
Subject: Re: [PATCH iwl-next v4] ice: Remove and readd netdev during devlink
 reload
Message-ID: <ZbjfLTeXRA3-UzDW@nanopsycho>
References: <20240130103101.88175-1-wojciech.drewek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130103101.88175-1-wojciech.drewek@intel.com>

Tue, Jan 30, 2024 at 11:31:01AM CET, wojciech.drewek@intel.com wrote:
>Recent changes to the devlink reload (commit 9b2348e2d6c9
>("devlink: warn about existing entities during reload-reinit"))
>force the drivers to destroy devlink ports during reinit.
>Adjust ice driver to this requirement, unregister netdvice, destroy

s/netdvice/netdevice/

>devlink port. ice_init_eth() was removed and all the common code
>between probe and reload was moved to ice_load().
>
>During devlink reload we can't take devl_lock (it's already taken)
>and in ice_probe() we have to lock it. Use devl_* variant of the API
>which does not acquire and release devl_lock. Guard ice_load()
>with devl_lock only in case of probe.
>
>Introduce ice_debugfs_pf_deinit() in order to release PF's
>debugfs entries. Move ice_debugfs_exit() call to ice_module_exit().

Sounds something like 3 patches to me :)


>
>Suggested-by: Jiri Pirko <jiri@nvidia.com>
>Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>Reviewed-by: Simon Horman <horms@kernel.org>
>Reviewed-by: Brett Creeley <brett.creeley@amd.com>
>Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
>---
>v2: empty init removed in ice_devlink_reinit_up
>v3: refactor locking pattern as Brett suggested
>v4: fix wrong function name in commit message
>---
> drivers/net/ethernet/intel/ice/ice.h         |   3 +
> drivers/net/ethernet/intel/ice/ice_debugfs.c |  10 +
> drivers/net/ethernet/intel/ice/ice_devlink.c |  68 ++++++-
> drivers/net/ethernet/intel/ice/ice_fwlog.c   |   2 +
> drivers/net/ethernet/intel/ice/ice_main.c    | 189 ++++++-------------

Yeah. Would be better to split. But up to you.

