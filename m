Return-Path: <netdev+bounces-212011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC307B1D267
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 08:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12DEA16167F
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 06:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98D22147E6;
	Thu,  7 Aug 2025 06:20:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361701A705C
	for <netdev@vger.kernel.org>; Thu,  7 Aug 2025 06:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754547651; cv=none; b=Dz+KbY092WBy15T3rEQMHo+0dM/Aza1+BBy2wNnHOJ7MRBCqqtVnjYKVZgZAPmr9zhwUS34wTwEWEx80i8RpcqY+jthKWrEBwRfGitVgSmSJUU9X22h0bic8eFXA+NKnb6LeTHDyp9vssZhjFKc3OR0sIYw40yFm9VhyQYYSbNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754547651; c=relaxed/simple;
	bh=Pbb/7E0PL4v5H4esXE+QrmXjVLcgWQPCAUQgzROjKV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYFV+MkWN0aO/Lynbef8DcB0JNcbye9xAUgrpUiQj7/u+gXHEpW4FXxxVebdshgMG4fF2qsWfc495dM/WOZNg7YxFI+I6zJFcbZyX40zAUC/5T/CIGeBWGFc33euNChcRGJ2aTj/5Slp2VYdOFcFXv0ajQmXuqW2AR3OUu0EDfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 36D86200A446;
	Thu,  7 Aug 2025 08:20:46 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 28FD54953CB; Thu,  7 Aug 2025 08:20:46 +0200 (CEST)
Date: Thu, 7 Aug 2025 08:20:46 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, Akeem G Abodunrin <akeem.g.abodunrin@intel.com>,
	netdev@vger.kernel.org, nhorman@redhat.com, sassmann@redhat.com,
	jeffrey.t.kirsher@intel.com,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Andrew Bowers <andrewx.bowers@intel.com>
Subject: Re: [net-next 04/15] ice: Add advanced power mgmt for WoL
Message-ID: <aJRFvuh8F-jQd0rz@wunner.de>
References: <20200723234720.1547308-1-anthony.l.nguyen@intel.com>
 <20200723234720.1547308-5-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723234720.1547308-5-anthony.l.nguyen@intel.com>

On Thu, Jul 23, 2020 at 04:47:09PM -0700, Tony Nguyen wrote:
> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> 
> Add callbacks needed to support advanced power management for Wake on LAN.
> Also make ice_pf_state_is_nominal function available for all configurations
> not just CONFIG_PCI_IOV.

The above was applied as commit 769c500dcc1e.

> +static int ice_resume(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	enum ice_reset_req reset_type;
> +	struct ice_pf *pf;
> +	struct ice_hw *hw;
> +	int ret;
> +
> +	pci_set_power_state(pdev, PCI_D0);
> +	pci_restore_state(pdev);
> +	pci_save_state(pdev);
> +
> +	if (!pci_device_is_present(pdev))
> +		return -ENODEV;
> +
> +	ret = pci_enable_device_mem(pdev);
> +	if (ret) {
> +		dev_err(dev, "Cannot enable device after suspend\n");
> +		return ret;
> +	}

You're calling pci_enable_device_mem() on resume without having called
pci_disable_device() on suspend.  This leads to an imbalance of the
enable_cnt kept internally in the PCI core.

Every time you suspend, the enable_cnt keeps growing.

The user-visible effect is that if you suspend the device at least once
and then unbind the driver, pci_disable_device() isn't called because
the enable_cnt hasn't reached zero (and will never reach it again).

I recommend removing the call to pci_enable_device_mem() in ice_resume():
The call to pci_restore_state() should already be sufficient to set the
Memory Space bit in the Command register again on resume.

I cannot test this for lack of hardware but can provide a patch if you
want me to.

Thanks,

Lukas

