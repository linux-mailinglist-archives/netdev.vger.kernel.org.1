Return-Path: <netdev+bounces-200394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BBCAE4CCD
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 20:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4673B7CDC
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 18:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362FB1C84D0;
	Mon, 23 Jun 2025 18:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YXI94wCG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10911C07F6;
	Mon, 23 Jun 2025 18:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750703247; cv=none; b=GAqeZ6qhHBeDIBx4GJ1Bt5nO+7lyLX3vimEnJ667UjAkIbLYvFDmqHI/SvoLlXz3DJHGIegmTC3MH9aOTvq0SPh7aAhLmyGmt5AZ4FNV04TUKpODAPGFkw2IZq1Pm830idxDrMolIhI7X00XMdSctnlVAZeKNi6Q36gtP2JQyQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750703247; c=relaxed/simple;
	bh=QKXndZMyfb7p1e0Wg1A7S+bTfVPj5+F3kMyJbJcoiAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4LW8tdzHjsr3JFGUGL1fln4dpS4yl3aWVN8aVGfD0J4LrViZ7xWR0BcnZvKhQyhEI1UgHhwt44lvzJrMrJjmQA0xGvlh2vriAjK3c6/WnNQ0kEoeWP4Va/9XZbZVbskKSy7TgPfC8XqHL+eZu/U+SdLDyUbA6X5MEo2cwrn84Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YXI94wCG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yTO3YdBSku104YsDHmadAMJYlJFGtvsp+k7l1sVkgSg=; b=YXI94wCGPdOe2CSM6CC4T+f6Rk
	s67hx3V6dimXQeRJaWcv0iJpYTreqPJ1GAJtE2RG6zijyvgwEotQkcTR6PkSPsSECwHwMobeAY0WT
	tbRRgl3SMECeUH7B5QTEI0gX6c1f6+vslJkZ1kIGzRKmVZ/+Cpp8BePYS5rAEztTIUVg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uTlsv-00Gij3-1s; Mon, 23 Jun 2025 20:27:13 +0200
Date: Mon, 23 Jun 2025 20:27:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michal Simek <michal.simek@amd.com>,
	Saravana Kannan <saravanak@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net 4/4] net: axienet: Split into MAC and MDIO drivers
Message-ID: <c543674a-305e-4691-b600-03ede59488ef@lunn.ch>
References: <20250619200537.260017-1-sean.anderson@linux.dev>
 <20250619200537.260017-5-sean.anderson@linux.dev>
 <16ebbe27-8256-4bbf-ad0a-96d25a3110b2@lunn.ch>
 <0854ddee-1b53-472c-a4fe-0a345f65da65@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0854ddee-1b53-472c-a4fe-0a345f65da65@linux.dev>

On Mon, Jun 23, 2025 at 11:16:08AM -0400, Sean Anderson wrote:
> On 6/21/25 03:33, Andrew Lunn wrote:
> > On Thu, Jun 19, 2025 at 04:05:37PM -0400, Sean Anderson wrote:
> >> Returning EPROBE_DEFER after probing a bus may result in an infinite
> >> probe loop if the EPROBE_DEFER error is never resolved.
> > 
> > That sounds like a core problem. I also thought there was a time
> > limit, how long the system will repeat probes for drivers which defer.
> > 
> > This seems like the wrong fix to me.
> 
> I agree. My first attempt to fix this did so by ignoring deferred probes
> from child devices, which would prevent "recursive" loops like this one
> [1]. But I was informed that failing with EPROBE_DEFER after creating a
> bus was not allowed at all, hence this patch.

O.K. So why not change the order so that you know you have all the
needed dependencies before registering the MDIO bus?

Quoting your previous email:

> Returning EPROBE_DEFER after probing a bus may result in an infinite
> probe loop if the EPROBE_DEFER error is never resolved. For example,
> if the PCS is located on another MDIO bus and that MDIO bus is
> missing its driver then we will always return EPROBE_DEFER.

Why not get a reference on the PCS device before registering the MDIO
bus?

	Andrew

