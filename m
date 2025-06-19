Return-Path: <netdev+bounces-199622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A8FAE0FED
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 01:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 213474A0B5E
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 23:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923AE21D3C0;
	Thu, 19 Jun 2025 23:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wwk4E4C2"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4181A20E711
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 23:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750375174; cv=none; b=t7pBatnFI/ZNgtP0u+JlLAUsjlV9ZKYQhnHOwgmJMyWigi1iEb9E3P0rkWLBj4IiduoTdgwLG8gtxwDgwnAJwGnLCWI3e/WwVx3ec7BmWTvDmIAPYfYrQ0sZhJS73bGloX/bAYDaV0LJcVc0Z35Hd2K1z842fgq3eWJLlRIQdAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750375174; c=relaxed/simple;
	bh=qkF4P7fPLySORTd7l5qaEb+29XEJDlsACaybE1ReOoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VFViYMdMSl1ZYSmToPYrY/z/4Q5DRc4xGA5Y4JlrYyUCgfwX66R9itCSS7TII8tVqaMaXEt/407XFy/LlemezTEa6IUPxo51TsFgDLPUsmvdH/Sg2V0cd5JjXIXrM2L3nODH7JOolygkJ0hlu/ZLd4Dv97Q7WMiHgXVPA8YqDW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wwk4E4C2; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5a69ba82-813e-4f6f-9f62-7d68a9c74197@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750375164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jWjprf8y6cAF4Vs6ys1NyVQMZL58pnQZ4Y/NPoHcBJ8=;
	b=Wwk4E4C2IvGBD9QrcvoNNDOOLPT/KnHLPLgEpFIN6dxZdSEIArJKhd7PM+PP/qFm/SlN+u
	jw5wupAx8JwpsMMEIxQcZM06V1qD4gLm3l4wJFS8WgWF4Y8HSplK7e2yE3KKMCwT80CaW7
	x+rlS2wEUJ6DeykVAgqnr+tK0VIFYfA=
Date: Thu, 19 Jun 2025 19:19:15 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 4/4] net: axienet: Split into MAC and MDIO drivers
To: Jakub Kicinski <kuba@kernel.org>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michal Simek <michal.simek@amd.com>, Saravana Kannan <saravanak@google.com>,
 Leon Romanovsky <leon@kernel.org>, Dave Ertman <david.m.ertman@intel.com>,
 linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
 linux-arm-kernel@lists.infradead.org
References: <20250619200537.260017-1-sean.anderson@linux.dev>
 <20250619200537.260017-5-sean.anderson@linux.dev>
 <20250619161030.6f14def9@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250619161030.6f14def9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/19/25 19:10, Jakub Kicinski wrote:
> On Thu, 19 Jun 2025 16:05:37 -0400 Sean Anderson wrote:
>> Returning EPROBE_DEFER after probing a bus may result in an infinite
>> probe loop if the EPROBE_DEFER error is never resolved. For example, if
>> the PCS is located on another MDIO bus and that MDIO bus is missing its
>> driver then we will always return EPROBE_DEFER. But if there are any
>> devices on our own MDIO bus (such as PHYs), those devices will be
>> successfully bound before we fail our own probe. This will cause the
>> deferred probing infrastructure to continuously try to probe our device.
>> 
>> To prevent this, split the MAC and MDIO functionality into separate
>> auxiliary devices. These can then be re-probed independently.
> 
> There's a, pardon the expression, C++-like build failure here
> culminating in:
> 
> drivers/net/ethernet/xilinx/xilinx_axienet_main.c:3225:1: error: redefinition of '__exittest'
> drivers/net/ethernet/xilinx/xilinx_axienet_main.c:3225:1: error: redefinition of '__inittest'
> drivers/net/ethernet/xilinx/xilinx_axienet_main.c:3225:1: error: redefinition of 'init_module'
> drivers/net/ethernet/xilinx/xilinx_axienet_main.c:3225:1: error: redefinition of 'cleanup_module'
> 
> I'm guessing the existing module_platform_driver() and the new
> module_auxiliary_driver() don't want to be friends when this 
> code is built as a module?

Hm, I thought I had built this as a module. I guess not. Will fix.

--Sean

