Return-Path: <netdev+bounces-199984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2869AE29D1
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 17:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 525CF16295D
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 15:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AA81EB5F8;
	Sat, 21 Jun 2025 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hROErPTb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8AF101EE
	for <netdev@vger.kernel.org>; Sat, 21 Jun 2025 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750519403; cv=none; b=E/oCqsGwC2sFZ8eHkRyLSU7JFKkpVNwGlKBfxSHXyJK0U1O+xpa0O98047oLGqzIC5Bf94w3NDpxYzA5e/HK2XLV9ihrRNhXuyLWQ1eNS8GLB0SmwlkmwNYm78Gzvd3qLtdoGtnRqZ+qvlg4aPyZxa2T4nCOCAMQy6DJiSwHFXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750519403; c=relaxed/simple;
	bh=7z33BgNTi9gD/vslnmhVmaA5ZPhggneAW5LztDANT7o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FIaq4UjHGhVIeSvEg82Gj2nag0kc9Pc9iJs953SAgfqYUMMj2YKGg8XiZX2lWDsNxblH2SZSjaPRS5MqXdgfjwVPaIN5U5ighYtMHudxe6DdAJjXbzkh0MpQPC07bdRqeJbKwgSnF2f13AtevPRtFcHmpcMY8uO4S3U1PgP3pec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hROErPTb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315C1C4CEE7;
	Sat, 21 Jun 2025 15:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750519402;
	bh=7z33BgNTi9gD/vslnmhVmaA5ZPhggneAW5LztDANT7o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hROErPTbLFaJLtkhdGBauY/6riBtxuo6H8WP962/mJsnAtmWTnRuPh38l6I+8sVfd
	 HB2RYRYTRvMEFJpIImqEjeNwzmheMHp/GH10/cFneCKV7OuruFUEUT0DTGDeZ39RyK
	 W7cGNWeV2KduPp4KJI9wdI0Dt0O3DW9jpztanInnbOqdHgx/RqzI8OfwWbiM4u5atc
	 uvjEbkBlDmXQS90IlKNTXOJLKqjYcTm1n6d2r6WgGfweW8f+kRt3PXZ9ceeErPUUAU
	 dJ1PHi55U9k0tp2vBqubCTGhrvWxEVOJ0AmcPpaskGQgeET7mknQYphqTfbR5AUH4x
	 35lKHy8UtzXow==
Date: Sat, 21 Jun 2025 08:23:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Karol Kolacinski
 <karol.kolacinski@intel.com>, jacob.e.keller@intel.com,
 przemyslaw.kitszel@intel.com, richardcochran@gmail.com, Michal Kubiak
 <michal.kubiak@intel.com>, Milena Olech <milena.olech@intel.com>, Rinitha S
 <sx.rinitha@intel.com>
Subject: Re: [PATCH net-next 07/15] ice: add ICE_READ/WRITE_CGU_REG_OR_DIE
 helpers
Message-ID: <20250621082321.724b65dd@kernel.org>
In-Reply-To: <20250618174231.3100231-8-anthony.l.nguyen@intel.com>
References: <20250618174231.3100231-1-anthony.l.nguyen@intel.com>
	<20250618174231.3100231-8-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Jun 2025 10:42:19 -0700 Tony Nguyen wrote:
> +#define ICE_READ_CGU_REG_OR_DIE(hw, addr, val)                     \
> +	do {                                                       \
> +		int __err = ice_read_cgu_reg((hw), (addr), (val)); \
> +								   \
> +		if (__err)                                         \
> +			return __err;                              \
> +	} while (0)
>  int ice_write_cgu_reg(struct ice_hw *hw, u32 addr, u32 val);
> +#define ICE_WRITE_CGU_REG_OR_DIE(hw, addr, val)                     \
> +	do {                                                        \
> +		int __err = ice_write_cgu_reg((hw), (addr), (val)); \
> +								    \
> +		if (__err)                                          \
> +			return __err;                               \
> +	} while (0)

Quoting documentation:

  12) Macros, Enums and RTL
  -------------------------
  
[...]

  Things to avoid when using macros:
  
  1) macros that affect control flow:
  
  .. code-block:: c
  
  	#define FOO(x)					\
  		do {					\
  			if (blah(x) < 0)		\
  				return -EBUGGERED;	\
  		} while (0)
  
  is a **very** bad idea.  It looks like a function call but exits the ``calling``
  function; don't break the internal parsers of those who will read the code.
  
See: https://www.kernel.org/doc/html/next/process/coding-style.html#macros-enums-and-rtl

