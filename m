Return-Path: <netdev+bounces-212006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CAAB1D1B6
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 06:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 733783AA36B
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 04:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF181198A2F;
	Thu,  7 Aug 2025 04:50:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B0272622
	for <netdev@vger.kernel.org>; Thu,  7 Aug 2025 04:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754542220; cv=none; b=Ddi+r8JXBoARinyiHvgungY3HxMF1sYeNW72AsezhzoQhFL20u3h8jymyZGbApWN6Q0b3UZ28aCxNm/E8uAoUxUc6n1jC9mqnaeI4a650InOvEvkj+uvZsFHUatlGCD1BFXr2KNTwkaZS/nvVIz8QFlRwM/BJipIaH52FuokZNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754542220; c=relaxed/simple;
	bh=6ofBkLaP+Qh3wSD9LlRMfxMZj74oX8KP4UIL5jrjdMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coY9SX+fmqEh8Q8Z+jqTMXzdBlIiXzOx9T4jsyZ5MOwZgEVtV09sS4AvFzE6kQ68QVtSvzNjEiJ7vkJLLdiFpV/1dRvUWZ2L9EghLWttpT+PGuFx9LwRLaHJ3iGh/2hpkjS+XDzxSGmewaiT96xqqhrhkd/88bUoTCE/jqaZjys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 10B01200A446;
	Thu,  7 Aug 2025 06:50:10 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 088D3493353; Thu,  7 Aug 2025 06:50:09 +0200 (CEST)
Date: Thu, 7 Aug 2025 06:50:09 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Thinh Tran <thinhtr@linux.ibm.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com, przemyslaw.kitszel@intel.com,
	pmenzel@molgen.mpg.de, jesse.brandeburg@intel.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, rob.thomas@ibm.com,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH iwl-net V4,2/2] i40e: Fully suspend and resume IO
 operations in EEH case
Message-ID: <aJQwgTbRY59C196Z@wunner.de>
References: <20240515210705.620-1-thinhtr@linux.ibm.com>
 <20240515210705.620-3-thinhtr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515210705.620-3-thinhtr@linux.ibm.com>

On Wed, May 15, 2024 at 04:07:05PM -0500, Thinh Tran wrote:
> When EEH events occurs, the callback functions in the i40e, which are
> managed by the EEH driver, will completely suspend and resume all IO
> operations.
> 
> - In the PCI error detected callback, replaced i40e_prep_for_reset()
>   with i40e_io_suspend(). The change is to fully suspend all I/O
>   operations
> - In the PCI error slot reset callback, replaced pci_enable_device_mem()
>   with pci_enable_device(). This change enables both I/O and memory of
>   the device.
> - In the PCI error resume callback, replaced i40e_handle_reset_warning()
>   with i40e_io_resume(). This change allows the system to resume I/O
>   operations

The above was applied as commit c80b6538d35a.

> @@ -16481,7 +16483,8 @@ static pci_ers_result_t i40e_pci_error_slot_reset(struct pci_dev *pdev)
>  	u32 reg;
>  
>  	dev_dbg(&pdev->dev, "%s\n", __func__);
> -	if (pci_enable_device_mem(pdev)) {
> +	/* enable I/O and memory of the device  */
> +	if (pci_enable_device(pdev)) {
>  		dev_info(&pdev->dev,
>  			 "Cannot re-enable PCI device after reset.\n");
>  		result = PCI_ERS_RESULT_DISCONNECT;

Why was this change made?

The driver calls pci_enable_device_mem() in i40e_probe(),
so calling pci_enable_device() here doesn't seem to make any sense.

The difference between pci_enable_device() and pci_enable_device_mem()
is that the former also enables access to the I/O Space of the device.
However I/O Space access is usually not used outside of x86.
And your patch targets powerpc because you seek to support EEH,
a powerpc-specific mechanism.

Unfortunately the commit message is not helpful at all because it
merely lists the code changes in prose form but doesn't explain
the *reason* for the change.

Thanks,

Lukas

