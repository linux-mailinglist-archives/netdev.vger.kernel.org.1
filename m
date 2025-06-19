Return-Path: <netdev+bounces-199621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C8AAE0FE8
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 01:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3D264A1DB5
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 23:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA0428C870;
	Thu, 19 Jun 2025 23:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJCwf2fb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB8C2111;
	Thu, 19 Jun 2025 23:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750374632; cv=none; b=kIKC7amCmsdZykCmNVgWjvP2wZSfWj+v1+mQZMirXM4ppfmFBXBSWlNLQlB8TDd5ZkwLKNtc4mJ8rKLVEscD8XVQDkqF6IpaUQjENObcP6d+etfwq1cGxRgVnB48SiZWyleQPh2LcjOnF6vqK1r4iH8fdd1Dg9s4xqI2GrYJTJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750374632; c=relaxed/simple;
	bh=rnVGVNG7SOYESn+2orXzfsDBfz1d8U4NDTEnCFm0dE8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FNNiM2k74uKfrMjviqHFzoPRucnnS9apcmRK5yHA32K9zRvgSBEwtXwaIq9qMOyonbezLU1dVEvfJlOz3CBVkR7TbdS66gROS9548hrmbYdSe7ugb0wzY93I2NIGPkr9eXettNKPBFLJD2pJEb/zvEJBXd4fHR6u5XpgbcQTAR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJCwf2fb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9EEC4CEEA;
	Thu, 19 Jun 2025 23:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750374631;
	bh=rnVGVNG7SOYESn+2orXzfsDBfz1d8U4NDTEnCFm0dE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tJCwf2fbGxdSVgK9Drd/CsR1mKOia0H+KByw58GuiVjufxkDflRyHQJsFiC8Jw3/X
	 PzK7Ivn0g3s30WXb/sX69Psc66rs5qOWZ80vUNfG6rXhndrQlz1qSRFhQP0RVErcDS
	 s6zIxnoxny50AuSZt55K6UTOy5ilFptvMzmB82Gq2rPU2+bNiBtVdYml8gAgfNiaBA
	 H5XvoKPDROMxDiJPnKKUwkn/UhawdllQEiWXZn3en31eKlqDBaCUBzIazwDuS/W5Mk
	 /2UDjmhXAREdDDuKFD2yuc+SU8Fv6wVKO6Isiy3rbyzmf8DfB/uqZxJ4uqNyMIQWeH
	 E85H3tOrscgEQ==
Date: Thu, 19 Jun 2025 16:10:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michal Simek <michal.simek@amd.com>, Saravana Kannan
 <saravanak@google.com>, Leon Romanovsky <leon@kernel.org>, Dave Ertman
 <david.m.ertman@intel.com>, linux-kernel@vger.kernel.org, Ira Weiny
 <ira.weiny@intel.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net 4/4] net: axienet: Split into MAC and MDIO drivers
Message-ID: <20250619161030.6f14def9@kernel.org>
In-Reply-To: <20250619200537.260017-5-sean.anderson@linux.dev>
References: <20250619200537.260017-1-sean.anderson@linux.dev>
	<20250619200537.260017-5-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Jun 2025 16:05:37 -0400 Sean Anderson wrote:
> Returning EPROBE_DEFER after probing a bus may result in an infinite
> probe loop if the EPROBE_DEFER error is never resolved. For example, if
> the PCS is located on another MDIO bus and that MDIO bus is missing its
> driver then we will always return EPROBE_DEFER. But if there are any
> devices on our own MDIO bus (such as PHYs), those devices will be
> successfully bound before we fail our own probe. This will cause the
> deferred probing infrastructure to continuously try to probe our device.
> 
> To prevent this, split the MAC and MDIO functionality into separate
> auxiliary devices. These can then be re-probed independently.

There's a, pardon the expression, C++-like build failure here
culminating in:

drivers/net/ethernet/xilinx/xilinx_axienet_main.c:3225:1: error: redefinition of '__exittest'
drivers/net/ethernet/xilinx/xilinx_axienet_main.c:3225:1: error: redefinition of '__inittest'
drivers/net/ethernet/xilinx/xilinx_axienet_main.c:3225:1: error: redefinition of 'init_module'
drivers/net/ethernet/xilinx/xilinx_axienet_main.c:3225:1: error: redefinition of 'cleanup_module'

I'm guessing the existing module_platform_driver() and the new
module_auxiliary_driver() don't want to be friends when this 
code is built as a module?
-- 
pw-bot: cr

