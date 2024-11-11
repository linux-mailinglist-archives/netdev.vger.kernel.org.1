Return-Path: <netdev+bounces-143802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2366D9C44D5
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 19:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59186B295E5
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 17:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF8A1A9B33;
	Mon, 11 Nov 2024 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIc5/qKe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B5653389;
	Mon, 11 Nov 2024 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731347268; cv=none; b=T8Z91Uwvo8ddOuUk35R4h5hNl0ym+644iY/8m/4N2UyVAnRRm3nOWR4So2Q8hBl7h+oNpxEGpTIYMh7pVNdUpad1omvu05cE+ndg0ay5EdNPqus4bmHt3aIqZdhpLOHNlnPwkDyRr+XWTgFKdK7Xc+wlwXSoo7AlWz56F93OBF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731347268; c=relaxed/simple;
	bh=T403nzfrE5JL2WNCmm1K+m6rTp3MIRo8r9U3LdQV20w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbBtG4QyfoAcGnxWEnz16VlDZiLhQnDGqHPfXsszti/bplFkK3ersCz3kdxKzyzqR0suk36pRhLZvzAkJSFF2bEtt47R+pucztJl4tI0s/J9ZMxxsU3EmrZgQdR8UMlU3Gh4Y5CJA6cgOWFkEa4zUwLTfRwyV5Dcw4zmt3F4FME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIc5/qKe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91AEAC4CECF;
	Mon, 11 Nov 2024 17:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731347267;
	bh=T403nzfrE5JL2WNCmm1K+m6rTp3MIRo8r9U3LdQV20w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XIc5/qKeD9HcnR5O2gQLCSUJbHoxsynZa7NAE3OfwLfKoL8a4SfiosBEGLOQNsB+B
	 V/BMCC0JjBT6u3NdSglRcql4Gg0AHTrnw9q4Rd2fihCt8ktJmMVcLFC0xg1N87Yz/f
	 Q6GI0QN5DZoIjaKpzQc0WBM2Lp0siX1ydOXVklD9LeyP/E8aBoWSw5gn3UGH4V4Twx
	 yEI4Yw85HEOSkfGPRgfIkybL3mS0riDetn8uhe6tC1VtWasoOt2cb9DVZR090wRlVH
	 ynWwTB/ikB+v/UQGN1p4BRAp7oqJYpNFN2C3SUKWdmVwEQbPmtnKoZDRrRF5sBw6RT
	 oACuNqlQrLU7g==
Date: Mon, 11 Nov 2024 17:47:43 +0000
From: Simon Horman <horms@kernel.org>
To: Nelson Escobar <neescoba@cisco.com>
Cc: John Daley <johndale@cisco.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Benvenuti <benve@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/7] enic: Make MSI-X I/O interrupts come
 after the other required ones
Message-ID: <20241111174743.GH4507@kernel.org>
References: <20241108-remove_vic_resource_limits-v3-0-3ba8123bcffc@cisco.com>
 <20241108-remove_vic_resource_limits-v3-2-3ba8123bcffc@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108-remove_vic_resource_limits-v3-2-3ba8123bcffc@cisco.com>

On Fri, Nov 08, 2024 at 09:47:48PM +0000, Nelson Escobar wrote:
> The VIC hardware has a constraint that the MSIX interrupt used for errors
> be specified as a 7 bit number.  Before this patch, it was allocated after
> the I/O interrupts, which would cause a problem if 128 or more I/O
> interrupts are in use.
> 
> So make the required interrupts come before the I/O interrupts to
> guarantee the error interrupt offset never exceeds 7 bits.
> 
> Co-developed-by: John Daley <johndale@cisco.com>
> Signed-off-by: John Daley <johndale@cisco.com>
> Co-developed-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: Nelson Escobar <neescoba@cisco.com>

Reviewed-by: Simon Horman <horms@kernel.org>


