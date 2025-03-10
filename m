Return-Path: <netdev+bounces-173422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B9AA58BE1
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 07:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B0916938A
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 06:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3C51C3029;
	Mon, 10 Mar 2025 06:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xc33tu/A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D321AAC4
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 06:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741587762; cv=none; b=RTYdo0CwDkFia5rSZlaCaxjwtVO4tt5hwgyJbQWHR14t+ReQbzRvII8jrxSleQF54oshOeSiaiROV9VHTQg3L7Dstzc3aZdDC8V3Ad82Jt5n2v3aMUbW5+646nOr7K2M9ohDkIEAQ27JsIS+Go4UopenJ+1qmuXl8FS2Ri8bovA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741587762; c=relaxed/simple;
	bh=Heq9Vfd9RkINitmBqpLfkAzNT3H2R2CSZ/30mhG0gZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LR9F1dY4S0ewy8gsQdnSpQSsGvjefkV20h87gURJbJZHXFgDmbZjSgpr2w3KRklIsKh0xonJkJfD0gdkozB6Pp8MPaXvRA9BN1V3P1DPqVjFgFLkL9zeGCuStiPBAAxD/JxCtZzsfjjHg8k5y0CLiP7XMGDIOdFyfdcu1n39IGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xc33tu/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C14C4CEE5;
	Mon, 10 Mar 2025 06:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741587762;
	bh=Heq9Vfd9RkINitmBqpLfkAzNT3H2R2CSZ/30mhG0gZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xc33tu/AzUZBseja0is+oV6q0OgGC8WHWtgmzkHCCYVOiDa+lGm3vJbEEwALy7nOf
	 fZrjqTlhaOuQVY2vMM2n/ntBpVPFoH97WtrsS3UdBSvF7JtzBEH8n1WgenAHouSfNR
	 8eo9ixUpeamfmXTgXsIYXYM7adtbJqXbPRbBuLaDvVT+Eu8twLZYkTDUevOU0HOGl1
	 pxOzrCOmRI9qEp8RWwYeBmTQ8PJ6uk9QUbYv9H7gfo1YGnLHsgKPE0ktQBfgNvi5ap
	 TAGbOVTCiC84rIhfHetBGoUxdUCq/fa9xpJvW6P++CrTLHuNq3XyIRpEmKAn0lM0L5
	 0rNRBQTIrooTA==
Date: Mon, 10 Mar 2025 07:22:29 +0100
From: Simon Horman <horms@kernel.org>
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	decot@google.com, willemb@google.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, madhu.chittim@intel.com,
	Aleksandr.Loktionov@intel.com, yuma@redhat.com, mschmidt@redhat.com
Subject: Re: [PATCH iwl-net] idpf: fix adapter NULL pointer dereference on
 reboot
Message-ID: <20250310062229.GD4159220@kernel.org>
References: <20250307003956.22018-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307003956.22018-1-emil.s.tantilov@intel.com>

On Thu, Mar 06, 2025 at 04:39:56PM -0800, Emil Tantilov wrote:
> Driver calls idpf_remove() from idpf_shutdown(), which can end up
> calling idpf_remove() again when disabling SRIOV.
> 
> echo 1 > /sys/class/net/<netif>/device/sriov_numvfs
> reboot
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000020
> ...
> RIP: 0010:idpf_remove+0x22/0x1f0 [idpf]
> ...
> ? idpf_remove+0x22/0x1f0 [idpf]
> ? idpf_remove+0x1e4/0x1f0 [idpf]
> pci_device_remove+0x3f/0xb0
> device_release_driver_internal+0x19f/0x200
> pci_stop_bus_device+0x6d/0x90
> pci_stop_and_remove_bus_device+0x12/0x20
> pci_iov_remove_virtfn+0xbe/0x120
> sriov_disable+0x34/0xe0
> idpf_sriov_configure+0x58/0x140 [idpf]
> idpf_remove+0x1b9/0x1f0 [idpf]
> idpf_shutdown+0x12/0x30 [idpf]
> pci_device_shutdown+0x35/0x60
> device_shutdown+0x156/0x200
> ...
> 
> Replace the direct idpf_remove() call in idpf_shutdown() with
> idpf_vc_core_deinit() and idpf_deinit_dflt_mbx(), which perform
> the bulk of the cleanup, such as stopping the init task, freeing IRQs,
> destroying the vports and freeing the mailbox.

Hi Emil,

I think it would be worth adding some commentary on the rest of
the clean-up performed by idpf_remove() and why it is correct
to no longer do so directly from a call to idpf_remove() from
idpf_shutdown() (IOW, it isn't clear to me :).

...

