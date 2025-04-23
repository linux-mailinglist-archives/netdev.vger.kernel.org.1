Return-Path: <netdev+bounces-185296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DCFA99B4F
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 00:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43AFF5A6E99
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 22:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25771E1308;
	Wed, 23 Apr 2025 22:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="riwSNAm/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E741885B4;
	Wed, 23 Apr 2025 22:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745446490; cv=none; b=ZAVWcbS7CmjLMpwlRgg85l7HvecH0DhTTMwvHLr9QkX/K9/TPkC3vsIZoOp0EGaVpBv6HWmeEl1CSy9J1VNJkbp5DW6naFjzQ2BH3kyCywwqIaDuGsGN1AEw2KTkk98/Pnr/ihV19enPYoa2PVK7nKHqIr0TWMtWSeHEaFa5MNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745446490; c=relaxed/simple;
	bh=yA5ENDOU6WR/6eoqizFm8BUxphmvVuGLV+xi0KRrHsc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l2JIO8ArVv1cQLV9gVjMqGvCnGabPkSSqAoJ5hOG+S6hODicdqA1+NZuShLW46AfRqIFlxixHYTYJmP5BBzlJmoZYFdUd+0yjhRhCM1HtPhbNPdetcadwflX4zb90ijdJR2dGglhjXCEGd0nUe4fAXARZ+p8f0lOOc11Ft0XhFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=riwSNAm/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14146C4CEE2;
	Wed, 23 Apr 2025 22:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745446489;
	bh=yA5ENDOU6WR/6eoqizFm8BUxphmvVuGLV+xi0KRrHsc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=riwSNAm/IP7hpOveudhoxer5Kf/aotbjwxCXUtk3nzygYvgSsL6ONNw1BRs54fBDb
	 Yfe6SP7JqDLkwCMjTytT1pow9SxXz9vaO2aKzm8yShqTD9bkayFdWVmdJDO6+hFV5B
	 QGr8wGMsp+Blk+SaETw9oSmG47z9ithxfSLJI2DoieZGg0QFXF7ZMH8ocXhpyy12Jv
	 Cq5IFsSwbaEZFInLrNCnX0bm3FrKvXlRf6uny3iL0r80RC+Gk8vqTPZKoLiczx6s9f
	 52JzTTWyJw45ekwLLIjoIUzt2xfez0G/unjv0b3jivQQO+Dtn2oDk32xFQECWPEXKz
	 OADngvh80wKPQ==
Date: Wed, 23 Apr 2025 15:14:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Philipp Stanner <phasta@mailbox.org>
Cc: phasta@kernel.org, Sunil Goutham <sgoutham@marvell.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Geetha
 sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 hariprasad <hkelam@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>,
 Taras Chornyi <taras.chornyi@plvision.eu>, Daniele Venzano
 <venza@brownhat.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Helge Deller
 <deller@gmx.de>, Ingo Molnar <mingo@kernel.org>, Simon Horman
 <horms@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Sabrina Dubroca
 <sd@queasysnail.net>, Jacob Keller <jacob.e.keller@intel.com>,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: Re: [PATCH 2/8] net: octeontx2: Use pure PCI devres API
Message-ID: <20250423151448.15a4a13e@kernel.org>
In-Reply-To: <00189e0a036e1bc7af8f78cc9fa934f1ad23efba.camel@mailbox.org>
References: <20250416164407.127261-2-phasta@kernel.org>
	<20250416164407.127261-4-phasta@kernel.org>
	<20250422174914.43329f7f@kernel.org>
	<5e20b320cbbe492769c87ed60b591b22d5e8e264.camel@mailbox.org>
	<00189e0a036e1bc7af8f78cc9fa934f1ad23efba.camel@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 10:38:01 +0200 Philipp Stanner wrote:
> > > This error path should be renamed. Could you also apply your
> > > conversion
> > > to drivers/net/ethernet/marvell/octeontx2/af/ ?  
> > 
> > Hm, those must have slipped me for some reason. Will reiterate with
> > them and the error path.  
> 
> Wait, false alarm. I actually did look at them and those in af/ don't
> seem to use the combination of pcim_enable_device() + pci_request_*
> 
> Only users of that combination have to be ported. Users of
> pci_enable_device() + pcim_* functions and pcim_enable_device() +
> pcim_* functions are fine.
> 
> Correct me if I missed the first mentioned combination up there.

I think you're right, there are apparently multiple but separate
drivers in that directory.

