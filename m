Return-Path: <netdev+bounces-237380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D3236C49D0A
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 00:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C2C24E3DCE
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 23:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48F4303CA2;
	Mon, 10 Nov 2025 23:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYhj8Lbf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F665194A73
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 23:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762818625; cv=none; b=MgTblfLpb1xnfyKk9clyJLulej0txhiv/iDy7K6e9gT+Ose2ETw3ZWr+aKDxiiI7dzt3L6mWs0M6BCRiRQW1r1rrtxnUQMcYLYXTuRoJCUakmnujJfkxfsWyeMEuqc5Fr2IgMhAPKho8gd9tYPRNH9ct5VrBWMj0PtN10T3y7HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762818625; c=relaxed/simple;
	bh=y45suLg81vCAyMVQdSL4eUJYbnZsIPoSZLQ0cfyNDfE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O3d8RPyjrYe72TcOsxMeW5fsweiyQ8wrOnbweDlzTfZOS8DkTpMHLsSE6vwipVOXiMF8/60O/FwTiYha+NW9BHAxNMFSrG5XXadKyKJLIcUG4ECTBthfKh83IjyREo0l9lZCqCsL0Au6aa6WOP1eMU4D4DaL7l/eI6VtafpYZUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYhj8Lbf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5BAC4CEFB;
	Mon, 10 Nov 2025 23:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762818625;
	bh=y45suLg81vCAyMVQdSL4eUJYbnZsIPoSZLQ0cfyNDfE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kYhj8LbfK5g8lfZRdGQnSNWzaOXlQU06NYbUCKg1kw0Ei4hRfhhtANqtaOGkiNkCh
	 f5qYs8PP9t2EdPUwzY6KF6DWa/b11JzSKp7TAw/GB+CDQmgrYsBu53LsvjtNZr6sDu
	 w8A9WscSMMc53mG6OoBZ5RpvY1DiWJQUiZE59/z1E6f4uyO3pJIKnL3SZxBHQhEXhd
	 AxkZ8awod3mKmfXPaVfaNHs9vVVlnshD7LzFs1FebVzCDRz/1+7OiG5CmuFdUVDHh3
	 MW1tIOeZYi+O6xIZL36wC3zQ9fQOFOFiD4frUIUzCPo6xwhs7AM1DRC/GNK82eX7SM
	 LUDGNunbPo5Eg==
Date: Mon, 10 Nov 2025 15:50:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Manish Chopra
 <manishc@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Simon Horman <horms@kernel.org>, Kory Maincent <kory.maincent@bootlin.com>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/2] bnx2x: convert to use ndo_hwtstamp
 callbacks
Message-ID: <20251110155024.0436b087@kernel.org>
In-Reply-To: <8a91d75b-3ba7-47be-9176-5d2245ac4fd5@intel.com>
References: <20251106213717.3543174-1-vadim.fedorenko@linux.dev>
	<20251106213717.3543174-2-vadim.fedorenko@linux.dev>
	<20251107184102.65b0f765@kernel.org>
	<dd7258b4-266f-420a-b751-4429772a47b5@linux.dev>
	<8a91d75b-3ba7-47be-9176-5d2245ac4fd5@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Nov 2025 15:23:23 -0800 Jacob Keller wrote:
> On 11/8/2025 4:38 AM, Vadim Fedorenko wrote:
> > On 08/11/2025 02:41, Jakub Kicinski wrote:  
> >> On Thu,  6 Nov 2025 21:37:16 +0000 Vadim Fedorenko wrote:  
> >> This is the wrong way around, if someone adds a new value unsupported
> >> by the driver it will pass. We should be listing the supported types
> >> and
> >>
> >> 	default:
> >> 		...ERR_MSG..
> >> 		return -ERANGE;
> >> 	}  
> > 
> > But that's the original logic of the driver. Should I change it within
> > the same patch, or is it better to make a follow-up work to clean such
> > things in net-next?  

That's partially true, note that the original code did not have a
default clause. So (IIUC) compiler would warn us if we added a new 
enum value without adding it in this driver. You're adding defaults.

> I'd prefer a separate patch for clarity. A backport is probably
> unnecessary since I doubt we'll add a new timestamp mode in such a
> backport in the future.. but functional changes like that make sense as
> a separate patch.

Yup, I think I asked for separate patch originally. Perhpas I wasn't
clear enough.

