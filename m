Return-Path: <netdev+bounces-211865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF88B1C0FF
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 09:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B23423BF4D9
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 07:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F41F21423C;
	Wed,  6 Aug 2025 07:08:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F070B219311
	for <netdev@vger.kernel.org>; Wed,  6 Aug 2025 07:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754464090; cv=none; b=ihYCouFOlGAfb3O2H5aDpBMNVIGGSQgkXofsG3qQJz44E7XllC2ecN1u4QaCCJ0MdwjFMPjuqmNx07LRb6bfTJO5zgyIgi4sCsTtNzYbgzuhS8ac3/kVjAnT7joGKnymz4Iu0cYJsnkjabq+9sn1380VTKfqkqD0aG0CXDIr+Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754464090; c=relaxed/simple;
	bh=ZjjvuP8eOI4Cc5fQEbIlLuCclzbSkbwAvcRUhHwz8dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uE+Qo4sdFllzDS3zovLKb36aNM50UW40vt+7mMOKXhJCJt6ag/BHkKGlOuPn22KaiiX5XwDs+e5KifDPbGg8pYZ3l1f3uyyk+E8TrkSytq+Ang4Ymg7I8X0wV1iXoQaKRb1W+BWcjjssX2CA5of92KS4GumokVN0fEHGXwQxeB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id C1AA72C06E34;
	Wed,  6 Aug 2025 09:08:04 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B650C375CA6; Wed,  6 Aug 2025 09:08:04 +0200 (CEST)
Date: Wed, 6 Aug 2025 09:08:04 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Brett Creeley <bcreeley@amd.com>
Cc: Shannon Nelson <shannon.nelson@amd.com>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, brett.creeley@amd.com, drivers@pensando.io
Subject: Re: [PATCH net-next 1/3] pds_core: add simple AER handler
Message-ID: <aJL_VN0pvC9slprc@wunner.de>
References: <20240216222952.72400-1-shannon.nelson@amd.com>
 <20240216222952.72400-2-shannon.nelson@amd.com>
 <aJIcyjyGxlKm382t@wunner.de>
 <48ffde5c-084f-4ad6-8be7-314afb14b2ac@amd.com>
 <aJL9IBagGNUagEbv@wunner.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJL9IBagGNUagEbv@wunner.de>

On Wed, Aug 06, 2025 at 08:58:40AM +0200, Lukas Wunner wrote:
> My point is, you're calling pdsc_reset_prepare() but you're never calling
> pdsc_reset_done().  The former performs various teardown steps and calls
> pci_disable_device(), which disables MMIO access to the device.  Since
> you're never calling pdsc_reset_done(), you're not re-enabling MMIO
> access to the device and re-initializing the device.  So I'd expect
> any subsequent device access to fail.
> 
> Normally you'd have a ->slot_reset() callback which would call
> pdsc_reset_done().  Then the code would look sane.
> 
> Moreover, the AER driver in the PCI core performs an unconditional 
> Secondary Bus Reset on Fatal Errors (channel state pci_channel_io_frozen).
> You're performing an additional reset of the PCI Function in
> pdsc_pci_error_resume().  At least for Fatal Errors, this seems
> superfluous.

I note that the pensando ionic driver uses the same weird pattern,
see commit c3a910e1c47a ("ionic: fill out pci error handlers").

So I suppose it got copy-pasted from there to the pds_core driver.

Thanks,

Lukas

