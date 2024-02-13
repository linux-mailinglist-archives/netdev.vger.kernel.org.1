Return-Path: <netdev+bounces-71225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BB7852BC1
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 09:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83A51F24323
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 08:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7321B7F3;
	Tue, 13 Feb 2024 08:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="X7PSFXde"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3E822612
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 08:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707814640; cv=none; b=GHIWD3vUoyKIBm3rQhV+8NhHzXepaGAv1CPkbNWQ/nAswPGp6J63moAf0tZN9hFGjhp+JoLAHyXBl/dA5T3pnd+NCeNKHK4tciDvYAdCs1EzSmYAF7RhJ1z3UuBvHllZXV54KQdQQadnXkWi3r1C+UPnljqyrRzjMJt5iyIr4no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707814640; c=relaxed/simple;
	bh=0DjQifCWf9zFX9B/wvhYzsWu5nTEgKshmCJoB/ZbQ0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2PrbtmoiMX08VDe8KAocRRC2xnCy8KRrW1O/uvVi+E2f4omSeHyr9fmnjwfcnHC8VIswFXe6Wdwq3mcDh/9fXjklDMlqFTFEt68bLVo2aw3ZnjqvThgLiuHBSkou7JgTXWryEVpMPqcTVbs3WptIcIhxaRhApG/pb/A+Q/L2RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=X7PSFXde; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d0f1ec376bso25874551fa.1
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 00:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1707814636; x=1708419436; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bW1dt+T6JQTnPokjKPW3rVlYQaH4mXXFpQ+tNRxiqS4=;
        b=X7PSFXdeZ+d/jJOE29UDreti+STb7ONsZOGTQgBlRLOxZ6BngmiIXjmOqGhVgTT3g/
         GbHseKdZjmDPFN8AFJg6CofjLimJhnxbTRwBVkoxlZDYnw0p5RVBPmz25E88jRDMupNr
         jzpmNZX62S36+CCzI9PZC4tPF+LYa+sSQqXczd6yzz8YCUr4zxYf109J3JWqZJelBOvC
         w+aOjKbubrdrO/92WdzASKBeY1BvZGkhF0+MDPUHUuZlaQxHGe1mhO3zU8uqhF5VKSZE
         J1ClH4WT2uvGvO16XHI0GochSQfcOUHu6sEovJ3wCTGPRFU9JERlf5GpU+Z/vSUE5dwx
         jgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707814636; x=1708419436;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bW1dt+T6JQTnPokjKPW3rVlYQaH4mXXFpQ+tNRxiqS4=;
        b=B4ZK3v39P74Wbihdb7/3+m9eI8zPUa7LNNFIIvvI6fSDxWi/PVM1tIA38kL1wtXKuY
         XDUse/XOeqf5/72RQ7wD+icRaNvNu3ldYzRv8pTiJao1sziosO28s4FYLXlR8QHkCO/w
         r7+hflbUiBSi4CQjz47yFrGcDFNUgL0gtZbRKST79k68WUsyXx7p+/2srPXUIrLmEAFu
         8JjflgMelXJg61wHCeeBy1HqKdHebE36G2EKyj0+2gkKUqJF2Dzh4/cP8HMrGAuP1etg
         xxl4mDdXYYQAIvmjcy9XGdpngFZ2DTGFezml9gHtn7+aS8SUWQNO+CCEOq4nuxU1ekz6
         ZfYw==
X-Forwarded-Encrypted: i=1; AJvYcCVCeFg5uwRB72wY+A0MOi5gtFgQV2y2BuTqb4df4Du3NqCDEDyZRTvws0d3ZsSPg87m8tzHwrcZWVjtmrEcMqom8RiecrKH
X-Gm-Message-State: AOJu0Yyc5FewrLHa+8qqMkJv/uJUPoeuY6lLmkFdUoHey0h67KjiKloE
	zjqn3Fo5PMDuDhoUSw2NS4U5atYvkP+qoRwYRTRy/4NUzTO88n+hRu7/ZQUSz42/ZEWYIHRuaZP
	ASsU=
X-Google-Smtp-Source: AGHT+IEiGj5S2ovVWIbdLdZuK3lyNH3PdMHYtryg6hdTo07KzO9v2DzkYE+0RaXrmJiAvjHf3lRfYw==
X-Received: by 2002:a2e:9b46:0:b0:2d0:aa06:f496 with SMTP id o6-20020a2e9b46000000b002d0aa06f496mr6030909ljj.40.1707814635693;
        Tue, 13 Feb 2024 00:57:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXPq31U22cxZyWkhgE2kah6HnXzwxy7CfyHR0BoDuaCix8pMg+8vGbDFVTIdMqawyD6eOUCM9aykP2rjJEaJwp9VIEAaw7XsKvNyEiMchk/ttuZmPxvAxPo1UVwcivDV71SrwYDsrsr6VcvdF0ZElSRlROoz2dVsetkdUzwzqO1p4JXjuPynHkNBXj43SZhwm0mY7KRFDDZmRtCR6JQ9VTdG88EQxQFLs+FwqkVPqXdMP4GhFpTAvhq/CN+jObYm+Ti5AGP3PLrA3ZRXcTwX1Doj/Hny7Dsg14OZ2YeyGLX5WhnWj4gRz9O1qTXHQx0l3+SyPHmkycTEiMDX/+MwBFEKZ4eYVDXNPJnZmEmHT4GGkmxtFbOE6O3KU06ftD7m8yttJG/QaZgQ+mxffKUnqZGjiCX
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id g8-20020a05600c310800b00410cfc34260sm5732576wmo.2.2024.02.13.00.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 00:57:15 -0800 (PST)
Date: Tue, 13 Feb 2024 09:57:12 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com,
	Piotr Raczynski <piotr.raczynski@intel.com>
Subject: Re: [iwl-next v1 06/15] ice: add subfunction aux driver support
Message-ID: <Zcsu6MCX-XkS8bki@nanopsycho>
References: <20240213072724.77275-1-michal.swiatkowski@linux.intel.com>
 <20240213072724.77275-7-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213072724.77275-7-michal.swiatkowski@linux.intel.com>

Tue, Feb 13, 2024 at 08:27:15AM CET, michal.swiatkowski@linux.intel.com wrote:
>From: Piotr Raczynski <piotr.raczynski@intel.com>
>
>Instead of only registering devlink port by the ice driver itself,
>let PF driver only register port representor for a given subfunction.
>Then, aux driver is supposed to register its own devlink instance and
>register virtual devlink port.
>
>Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
>Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>---
> .../intel/ice/devlink/ice_devlink_port.c      |  52 ++++-
> .../intel/ice/devlink/ice_devlink_port.h      |   6 +
> drivers/net/ethernet/intel/ice/ice_devlink.c  |  28 ++-
> drivers/net/ethernet/intel/ice/ice_devlink.h  |   3 +
> drivers/net/ethernet/intel/ice/ice_main.c     |   9 +
> drivers/net/ethernet/intel/ice/ice_sf_eth.c   | 214 ++++++++++++++++--
> drivers/net/ethernet/intel/ice/ice_sf_eth.h   |  21 ++
> 7 files changed, 302 insertions(+), 31 deletions(-)

Could you please split this. I see that you can push out 1-3 patches as
preparation.

