Return-Path: <netdev+bounces-211864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C2FB1C0FC
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 09:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F13116FDCC
	for <lists+netdev@lfdr.de>; Wed,  6 Aug 2025 07:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE3321773F;
	Wed,  6 Aug 2025 07:05:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AB9217704
	for <netdev@vger.kernel.org>; Wed,  6 Aug 2025 07:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754463917; cv=none; b=tx98Zaa1feUZFZSv2WKgDeAIIr9+fVaQRO5S9lHUjYM4prraA0UdDjxYG44lF0QwoZA6JEgHzN/8mSwrbc7QjuwfRv1aM6rC9ewkYwfZMaXAjZV5axMLVroGijPnnfpnYPtaPTkjvrENMat0g1psGY+IJbplC38EVuOD4bDxKhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754463917; c=relaxed/simple;
	bh=TSMsU3BzsIxOAg+V7Vhpn7YaltEjDelc2C+eCCQ1/Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HV91TqvtS9e3XsFQGbzIXD3TDwFEq0YQYPJc1Sy1uZpfFM4H2dkQI6lBOEgY577qwBmjpTcNsoCzntgqSKw6cPmPebcq9rpgLPIxEc7csntKv8hX/vhdiKg4hVp3dCWa/xPm1u+YVWKReeMrIdiiq1V9c9tmfWxtrJ/mTl8Trlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 133812C000B5;
	Wed,  6 Aug 2025 08:58:41 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D3998375CBB; Wed,  6 Aug 2025 08:58:40 +0200 (CEST)
Date: Wed, 6 Aug 2025 08:58:40 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Brett Creeley <bcreeley@amd.com>
Cc: Shannon Nelson <shannon.nelson@amd.com>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, brett.creeley@amd.com, drivers@pensando.io
Subject: Re: [PATCH net-next 1/3] pds_core: add simple AER handler
Message-ID: <aJL9IBagGNUagEbv@wunner.de>
References: <20240216222952.72400-1-shannon.nelson@amd.com>
 <20240216222952.72400-2-shannon.nelson@amd.com>
 <aJIcyjyGxlKm382t@wunner.de>
 <48ffde5c-084f-4ad6-8be7-314afb14b2ac@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48ffde5c-084f-4ad6-8be7-314afb14b2ac@amd.com>

On Tue, Aug 05, 2025 at 03:10:19PM -0700, Brett Creeley wrote:
> On 8/5/2025 8:01 AM, Lukas Wunner wrote:
> > On Fri, Feb 16, 2024 at 02:29:50PM -0800, Shannon Nelson wrote:
> > > Set up the pci_error_handlers error_detected and resume to be
> > > useful in handling AER events.
> > 
> > The above was committed as d740f4be7cf0 ("pds_core: add simple
> > AER handler").
> > 
> > Just noticed the following while inspecting the pci_error_handlers
> > of this driver:
> > 
> > > +static pci_ers_result_t pdsc_pci_error_detected(struct pci_dev *pdev,
> > > +                                             pci_channel_state_t error)
> > > +{
> > > +     if (error == pci_channel_io_frozen) {
> > > +             pdsc_reset_prepare(pdev);
> > > +             return PCI_ERS_RESULT_NEED_RESET;
> > > +     }
> > > +
> > > +     return PCI_ERS_RESULT_NONE;
> > > +}
> > 
> > The ->error_detected() callback of this driver invokes
> > pdsc_reset_prepare(), which unmaps BARs and calls pci_disable_device(),
> > but there is no corresponding ->slot_reset() callback which would invoke
> > pdsc_reset_done() to re-enable the device after reset recovery.
> 
> Thanks for the note. It's been a bit since I have looked at this, but I
> believe that it's working in the following way:
> 
> 1. pds_core's pci_error_handlers.error_detected callback returns
> PCI_ERS_RESULT_NEED_RESET
> 2. status is initialized to PCI_ERS_RESULT_RECOVERED in the pci core and
> since pds_core doesn't have a slot_reset callback then status remains
> PCI_ERS_RESULT_RECOVERED
> 3. pds_core's pci_error_handlers.resume callback is called, which will
> attempt reset/recover the device to a functional state

My point is, you're calling pdsc_reset_prepare() but you're never calling
pdsc_reset_done().  The former performs various teardown steps and calls
pci_disable_device(), which disables MMIO access to the device.  Since
you're never calling pdsc_reset_done(), you're not re-enabling MMIO
access to the device and re-initializing the device.  So I'd expect
any subsequent device access to fail.

Normally you'd have a ->slot_reset() callback which would call
pdsc_reset_done().  Then the code would look sane.

Moreover, the AER driver in the PCI core performs an unconditional 
Secondary Bus Reset on Fatal Errors (channel state pci_channel_io_frozen).
You're performing an additional reset of the PCI Function in
pdsc_pci_error_resume().  At least for Fatal Errors, this seems
superfluous.

You're only resetting the PCI Function if the PDSC_S_FW_DEAD bit is set,
irrespective whether you're dealing with a Fatal or Non-Fatal Error.

Normally I'd expect that you need to perform some re-initialization
after resetting the PCI Function, so this also looks weird.

Thanks,

Lukas

