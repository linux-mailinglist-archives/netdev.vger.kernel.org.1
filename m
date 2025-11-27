Return-Path: <netdev+bounces-242340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8B4C8F713
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 17:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E29F4E035B
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 16:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF28D2C158D;
	Thu, 27 Nov 2025 16:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tx61MBgV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA90A246BC7
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 16:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764259669; cv=none; b=q1inhKzHu1K/oBiWMLrEN7SffWzAf7lTBmtmgNp1vKa16XcY+WWoDMFQOm1yosnt4AYmbzj/Oc53KrXWCya1Bz2yZ3SVWBkoz4d64FEQXiAO4UnWEG1L1E25CMDLXKoI92d6VaJozwv9+tZKSA/9bwaUUtLe6bXXDAsl9DFtG7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764259669; c=relaxed/simple;
	bh=aPR5QSQpzNk9LARbOQi6Bh0V16jVHhd7FqDaQ0KfWEs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aoYRfzvL0QL9JjzxOajW+ZhuXyKVd0uzb75gpl9wZi34WPZfiLg1dahkAQ6twg9MAetBR+RLzOmGR+gg8tAGNqOZ/c4rnH6THiVvm6uIZ/vF2x4Fh62uUB5udKC2nuc9jpVvMvQ3QEHpbUybmPP6rmRdjEDNCdLjAjDMb+PgjY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tx61MBgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F71C4CEF8;
	Thu, 27 Nov 2025 16:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764259669;
	bh=aPR5QSQpzNk9LARbOQi6Bh0V16jVHhd7FqDaQ0KfWEs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tx61MBgVz6Tip3Gi2313MSHIpfyBSGkxmtCoeb65VxcYJ8imoxfKrfFNN9WOkowsH
	 UBVBzSD+lU+21fjnzTX+tIs/wXxygiLz/tXDl/grO42y8TQlGRd28AwAs0PLZBkQgo
	 xmClv7pmJIWjcWSawf5wKyjX1WIo+cFcyq6LMjoZyPpa/1k3jUTjll/wBz/ngQQv9j
	 6EPk40VAkVoCKwyGZmLGXAcUSeog0C6RP8OS2Etrh915e3v62U2e6dd5lTIavFQV2O
	 q1tYXPpJCBtqtMJpSQ/dpdmdHxMmGVk/AHivde41+kN38WXT0EvZx9383Gch7NJ3wS
	 GNOVPnOyQbd5A==
Date: Thu, 27 Nov 2025 08:07:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Paul Menzel
 <pmenzel@molgen.mpg.de>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Rinitha S <sx.rinitha@intel.com>
Subject: Re: [PATCH net-next 03/11] ixgbe: Add 10G-BX support
Message-ID: <20251127080748.423605a3@kernel.org>
In-Reply-To: <93508e7f-cf7e-40f6-bf28-fb9e70ea3184@birger-koblitz.de>
References: <20251125223632.1857532-1-anthony.l.nguyen@intel.com>
	<20251125223632.1857532-4-anthony.l.nguyen@intel.com>
	<20251126153245.66281590@kernel.org>
	<93508e7f-cf7e-40f6-bf28-fb9e70ea3184@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Nov 2025 07:33:13 +0100 Birger Koblitz wrote:
> > In ixgbe_identify_sfp_module_generic(), what happens when a module has
> > the 10G-BX characteristics (empty comp_codes_10g, bitrate 0x67, fiber
> > mode) but the link length check fails (both sm_length values < 1km)?
> > 
> > The outer else-if condition matches, so we skip the final else clause
> > that sets sfp_type to unknown. But the inner if condition fails, so we
> > don't set the 10g_bx type either. This leaves hw->phy.sfp_type
> > unchanged from whatever value it had previously.
> > 
> > All other branches in this if-else chain explicitly set sfp_type, but
> > this path only conditionally sets it. Should there be an else clause
> > after the inner if to set sfp_type = ixgbe_sfp_type_unknown when the
> > link length requirement isn't met?  
> The ixgbe_identify_sfp_module_generic detects SFP modules that it knows 
> how to initialize in a positive manner, that is all the conditions have 
> to be fulfilled. If this is not the case, then the default from 
> ixgbe_main.c:ixgbe_probe() kicks in, which sets
> 	hw->phy.sfp_type = ixgbe_sfp_type_unknown;
> before probing the SFP. The else is unnecessary.
> 
> If the SFP module cannot be positively identified, then that functions 
> logs an error:
> 	e_dev_err("failed to load because an unsupported SFP+ or QSFP module 
> type was detected.\n");
> 	e_dev_err("Reload the driver after installing a supported module.\n");

Got it! perhaps add a note to the commit msg or a comment somewhere to
avoid AI flagging this again?

