Return-Path: <netdev+bounces-242104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB8AC8C5DC
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 00:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CEE84E05B9
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 23:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75585287506;
	Wed, 26 Nov 2025 23:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dN0UWnrh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5050922D7A9
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 23:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764199969; cv=none; b=iHb4xolbI+XfsIJbtYUzqkqId5gIWHo/N/mjDk8/eAt+WLXud42Bu/ut7PnB/j8yFlWVyHMDp+wqoXzyQIVxWyb3E3fQYC5bk4TdLui9cOQyvZylrHGH7CKFlRiaEoo2veneblBTAVdNB5a59OYE6fS1s0rZSn28WuihkQK9jbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764199969; c=relaxed/simple;
	bh=aYsOlHltFCbqjIPvzq4taijGLX57uZ4seJEQrIj8ZxU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K5tGGGbTu7HxAZbU0dZe3ZGH1C6Y8KmVpHB2+3T5kV0cNs2dJHlq7Ze1+PPdM5K3iyYvazvUzFXZAKbPdaZuQUKcYncklEXiS//0xDVbJVl1Kn18wr7rcmWva7cPAp8XKQFLTmS8XcQf5VQPSEAU/y7yLyqpkM/pRpq2iv1WVEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dN0UWnrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703FCC4CEF7;
	Wed, 26 Nov 2025 23:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764199966;
	bh=aYsOlHltFCbqjIPvzq4taijGLX57uZ4seJEQrIj8ZxU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dN0UWnrhhujictgH55AiP3OwvRB1y4xeTrRveBE+nqlHJqeAbuD5CxISAjHnW/dUr
	 nYWovh55BOhIBHM47omiElgljUHCUrt3HduVxFfU25HkogXI+HtZXTdOaEACaBOItM
	 djYPc1DW8MbbRZYnQlSqf0fh6VgoJhbdq22PzZQkZwjWl50tNQePk+xZSRn+qNMpKA
	 wiWlvpRzIHosGTfjK8zklHizrnn+o9+yxPNeephV1/s7rR8JlNNhltAXHa55UuW52A
	 xQN5ww9R8EL5PHBTFAYVbXFTN1GDMm6zM2zOq5W+Q0S/yS/h4ta/sTcQdTPFemQADF
	 84zK1oUf/PR7w==
Date: Wed, 26 Nov 2025 15:32:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Birger Koblitz
 <mail@birger-koblitz.de>, Andrew Lunn <andrew@lunn.ch>, Paul Menzel
 <pmenzel@molgen.mpg.de>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Rinitha S <sx.rinitha@intel.com>
Subject: Re: [PATCH net-next 03/11] ixgbe: Add 10G-BX support
Message-ID: <20251126153245.66281590@kernel.org>
In-Reply-To: <20251125223632.1857532-4-anthony.l.nguyen@intel.com>
References: <20251125223632.1857532-1-anthony.l.nguyen@intel.com>
	<20251125223632.1857532-4-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



> @@ -1678,6 +1680,31 @@ int ixgbe_identify_sfp_module_generic(struct ixgbe_hw *hw)
>  			else
>  				hw->phy.sfp_type =
>  					ixgbe_sfp_type_1g_bx_core1;
> +		/* Support Ethernet 10G-BX, checking the Bit Rate
> +		 * Nominal Value as per SFF-8472 to be 12.5 Gb/s (67h) and
> +		 * Single Mode fibre with at least 1km link length
> +		 */
> +		} else if ((!comp_codes_10g) && (bitrate_nominal == 0x67) &&
> +			   (!(cable_tech & IXGBE_SFF_DA_PASSIVE_CABLE)) &&
> +			   (!(cable_tech & IXGBE_SFF_DA_ACTIVE_CABLE))) {
> +			status = hw->phy.ops.read_i2c_eeprom(hw,
> +					    IXGBE_SFF_SM_LENGTH_KM,
> +					    &sm_length_km);
> +			if (status != 0)
> +				goto err_read_i2c_eeprom;
> +			status = hw->phy.ops.read_i2c_eeprom(hw,
> +					    IXGBE_SFF_SM_LENGTH_100M,
> +					    &sm_length_100m);
> +			if (status != 0)
> +				goto err_read_i2c_eeprom;
> +			if (sm_length_km > 0 || sm_length_100m >= 10) {
> +				if (hw->bus.lan_id == 0)
> +					hw->phy.sfp_type =
> +						ixgbe_sfp_type_10g_bx_core0;
> +				else
> +					hw->phy.sfp_type =
> +						ixgbe_sfp_type_10g_bx_core1;
> +			}
                        ^^^^

Claude says:

In ixgbe_identify_sfp_module_generic(), what happens when a module has
the 10G-BX characteristics (empty comp_codes_10g, bitrate 0x67, fiber
mode) but the link length check fails (both sm_length values < 1km)?

The outer else-if condition matches, so we skip the final else clause
that sets sfp_type to unknown. But the inner if condition fails, so we
don't set the 10g_bx type either. This leaves hw->phy.sfp_type
unchanged from whatever value it had previously.

All other branches in this if-else chain explicitly set sfp_type, but
this path only conditionally sets it. Should there be an else clause
after the inner if to set sfp_type = ixgbe_sfp_type_unknown when the
link length requirement isn't met?

>  		} else {
>  			hw->phy.sfp_type = ixgbe_sfp_type_unknown;
>  		}

