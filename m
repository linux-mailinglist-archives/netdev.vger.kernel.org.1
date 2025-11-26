Return-Path: <netdev+bounces-242102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5E2C8C5CD
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 00:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 605284E1B60
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 23:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC35328314C;
	Wed, 26 Nov 2025 23:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpd7+V+g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DD54207A;
	Wed, 26 Nov 2025 23:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764199860; cv=none; b=Gf0WXTxjv6MfZ5MZXz4Bb+tCOak3UxkztYaPj7GvrWS0QSSDYbepUSb6HxILVvZTDik06FKtzGiHkZ4LUFqXCLPewe2xG6mP+KqzDiQAYWcTKmEww2q7/53yx5bdHQhNDklN91g+Sqr/qyO7F1vTH4jvBr+QlfzY+ORzx8f3Ikk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764199860; c=relaxed/simple;
	bh=pbazvms3qhUN67tFcmFD1XFjqbasp/h6qwpzpJT0Cu8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PqA/UxbojELyjLtLgfsx7ViljLkQF2eeD7x+qmL/5ZGYVqEZDvLHSopoVvZDlcAN/gZIzV5dyRcGzPAnudQ43bnjtNOEyKyGQaNHDf9yNi28ZrXPzWW0XmyYyiQmcBx35Qi+l4tL8lNDY7gEJuaAe8Yb4fwogOYKSD2eP3nbWV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpd7+V+g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFBF6C4CEF7;
	Wed, 26 Nov 2025 23:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764199860;
	bh=pbazvms3qhUN67tFcmFD1XFjqbasp/h6qwpzpJT0Cu8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tpd7+V+gnVAet6iTsCALSC56T2Ma7ZeEMrM9PsB+7MyTK1fMuRk7ROaDnJ/8Vs9N+
	 rIvN62H+fMDXQxY3y0l7cGlYIEBFgqgnOCeF1+9EqNlja1pty4h2r84FqR0r3I5PE3
	 dE3Wea2nGmu9S86TdHi2QpXQcs53HL2Ld4LfOsxyFTT9vh+7eQT+Gfy2LOMEBvvj2S
	 jwHfUuo25Ws6EZ9s1Tl3+L0s4tD7dBnsjhyYWKulUWEf6vyVot+J7rrO1bnPHJH/Mh
	 YjDLnHrks9WSkB1VrJB3ErmoJIZagJFOBuOk3PUTNRuEncTLlKKi/Z2XHl/krt5t0t
	 a67+K/5Uoclwg==
Date: Wed, 26 Nov 2025 15:30:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, richardcochran@gmail.com, corbet@lwn.net,
 linux-doc@vger.kernel.org, horms@kernel.org, aleksandr.loktionov@intel.com,
 przemyslaw.kitszel@intel.com, Paul Menzel <pmenzel@molgen.mpg.de>, Grzegorz
 Nitka <grzegorz.nitka@intel.com>
Subject: Re: [PATCH net-next 01/11] ice: add support for unmanaged DPLL on
 E830 NIC
Message-ID: <20251126153057.2bbc21d0@kernel.org>
In-Reply-To: <20251125223632.1857532-2-anthony.l.nguyen@intel.com>
References: <20251125223632.1857532-1-anthony.l.nguyen@intel.com>
	<20251125223632.1857532-2-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Nov 2025 14:36:20 -0800 Tony Nguyen wrote:
> +int ice_is_health_status_code_supported(struct ice_hw *hw, u16 code,
> +					bool *supported)
> +{
> +	const int BUFF_SIZE = ICE_AQC_HEALTH_STATUS_CODE_NUM;
> +	struct ice_aqc_health_status_supp_elem *buff;
> +	int ret;
> +
> +	buff = kcalloc(BUFF_SIZE, sizeof(*buff), GFP_KERNEL);
> +	if (!buff)
> +		return -ENOMEM;
> +	ret = ice_aq_get_health_status_supported(hw, buff, BUFF_SIZE);
> +	if (ret)
> +		goto free_buff;
> +	for (int i = 0; i < BUFF_SIZE && buff[i].health_status_code; i++)
> +		if (le16_to_cpu(buff[i].health_status_code) == code) {
> +			*supported = true;
> +			break;
> +		}

Claude Code review says you may not find the @code ...

> +free_buff:
> +	kfree(buff);
> +	return ret;

.. but still report 0 ..

> +	/* Initialize unmanaged DPLL detection */
> +	{
> +		u16 code = ICE_AQC_HEALTH_STATUS_INFO_LOSS_OF_LOCK;
> +		int err;
> +
> +		err = ice_is_health_status_code_supported(&pf->hw, code,
> +							  &pf->dplls.unmanaged);
> +		if (err || !ice_is_unmanaged_cgu_in_netlist(&pf->hw))
> +			pf->dplls.unmanaged = false;

.. which is not handled here

> +	}

BTW floating code block like:

	{
		int i;

		bla(i);
	}

Is not an acceptable coding style upstream.

