Return-Path: <netdev+bounces-109098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A22926DAC
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 04:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E319B22B88
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 02:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D5A17557;
	Thu,  4 Jul 2024 02:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfzrfcZk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FB0FC02
	for <netdev@vger.kernel.org>; Thu,  4 Jul 2024 02:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720061759; cv=none; b=TzPOtIdXWS24e9r4W82YENgeYkFPNICZP/Y+4W3iD3zEhJJMyWhb850PyVD9AE0vdAGl5pziH3LLvlMukutaioh7ERYVJ7SF9rmPDfIdC3K6xKb6hZGlSkogVphxaVIbnrVksF4drRFK9rtrgf9H9aLZa5c9cE+h00G/Ue+RKNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720061759; c=relaxed/simple;
	bh=9fXtVVKjRUcsO0cFEvge/ottyvWiD9LC/p97wP1XV6g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tBjlYumFgO3oXz4I448JVEqNpOvsQEs4Bz8hXyY9wilMktFDLVMJ1pO9UVpHSknrr9EMs39h4Hdz3Ek4pA6td5r/CDeZu5QDZ5pwaLJhSEQ8xLxQr93r3YueDDt5R1uwPKvjJgqBH+HZe3xLjTc9EP8a5SphfEMX2tjLYIYUMaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfzrfcZk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07C1C2BD10;
	Thu,  4 Jul 2024 02:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720061759;
	bh=9fXtVVKjRUcsO0cFEvge/ottyvWiD9LC/p97wP1XV6g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pfzrfcZktlxrPQEaigXVnJ/ZuIAaVF8w5nC1dOZQY0CuTOys1yjtvZhhPtRsXjp8t
	 yI6gEm+KMfP4/xLzUp6LL0ta9E5HZi3Pim09iRtnTnAzNROjfR6mY+2chEi21O6qXT
	 0qzs9pJhxEvMXqqqbWL1sitQal5ZI6OzcZMiwblgKGOJKzj5+a/BnCL5d3UbwTq0Qy
	 KWh4Rx2uR46xW+HZsF4NJ6AFwCpIyDsKtKznEnkfQCDx+SoSli55miS2V54leIt2X2
	 fXCM/Lv7EiUzPNspMC+1Xw5o9lpZU/fKLq4hxtZrg7mckqlKkurZ9snnSL4seTubor
	 ZhqVSXaWcXFEw==
Date: Wed, 3 Jul 2024 19:55:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, Anil Samal <anil.samal@intel.com>, Simon Horman
 <horms@kernel.org>, Jesse Brandeburg <jesse.brandeburg@intel.com>, Pucha
 Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net-next 2/3] ice: Implement driver functionality to
 dump fec statistics
Message-ID: <20240703195557.4b643f90@kernel.org>
In-Reply-To: <20240702180710.2606969-3-anthony.l.nguyen@intel.com>
References: <20240702180710.2606969-1-anthony.l.nguyen@intel.com>
	<20240702180710.2606969-3-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Jul 2024 11:07:06 -0700 Tony Nguyen wrote:
> +	pf = np->vsi->back;
> +	hw = &pf->hw;
> +	pi = np->vsi->port_info;
> +
> +	if (!hw || !pi)
> +		return;

nit: hw can't possibly be NULL, it's pf + offset, even if pf is null hw
won't be; maybe also combine the pi check with the type check below?
to make it look less like defensive programming..

next patch has the same isse

> +	/* Serdes parameters are not supported if not the PF VSI */
> +	if (np->vsi->type != ICE_VSI_PF)
> +		return;
> +
> +	err = ice_get_port_topology(hw, pi->lport, &port_topology);
> +	if (err) {
> +		netdev_info(netdev, "Extended register dump failed Lport %d\n",
> +			    pi->lport);
> +		return;
> +	}
> +
> +	/* Get FEC correctable, uncorrectable counter */
> +	err = ice_get_port_fec_stats(hw, port_topology.pcs_quad_select,
> +				     port_topology.pcs_port, fec_stats);
> +	if (err) {
> +		netdev_info(netdev, "FEC stats get failed Lport %d Err %d\n",
> +			    pi->lport, err);
> +	}

unnecessary brackets
-- 
pw-bot: cr

