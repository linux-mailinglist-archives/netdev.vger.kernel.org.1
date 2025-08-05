Return-Path: <netdev+bounces-211741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1A6B1B6FC
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 17:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D9A43AB351
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 15:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5DD272E5E;
	Tue,  5 Aug 2025 15:01:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFAE85260
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406096; cv=none; b=NF9Lm2F4VWyS13vwfRwc9FlS+ZmJSnCe327CXbvXSCqcXKhcU+KsCLFFxakzCOEJUdVfWIGdi1+LRaxWzgwgHHeudbX9L1IRO8aGomKdXcRAxONaTJHlWZYvsRCXgFcDqog1zeX7MGenCxfOIB5nv+vNDkePr9brQ4hutAcJAMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406096; c=relaxed/simple;
	bh=a3Uz+bhDtLO3f6036QZs0JsOCd6UC/nrk30XAQqav9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eqx955DxeKTuMNAsk3s7eA+9f3byL/gkXcx15boTmdoMdr94c5pod65C5oREUwMq16Ise/7KKukJ7FiLOJoQOLbI8dVvtSTYwW/lLrc7dzGmYI/j1+aH/xGkFYzCh2Yq4lNTWF0/5AGLWvaZx6RWLwanPKkXOSjhGqAlKGzAS68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id D040F2C02AC4;
	Tue,  5 Aug 2025 17:01:30 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B8919357A5F; Tue,  5 Aug 2025 17:01:30 +0200 (CEST)
Date: Tue, 5 Aug 2025 17:01:30 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, brett.creeley@amd.com,
	drivers@pensando.io
Subject: Re: [PATCH net-next 1/3] pds_core: add simple AER handler
Message-ID: <aJIcyjyGxlKm382t@wunner.de>
References: <20240216222952.72400-1-shannon.nelson@amd.com>
 <20240216222952.72400-2-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216222952.72400-2-shannon.nelson@amd.com>

On Fri, Feb 16, 2024 at 02:29:50PM -0800, Shannon Nelson wrote:
> Set up the pci_error_handlers error_detected and resume to be
> useful in handling AER events.

The above was committed as d740f4be7cf0 ("pds_core: add simple
AER handler").

Just noticed the following while inspecting the pci_error_handlers
of this driver:

> +static pci_ers_result_t pdsc_pci_error_detected(struct pci_dev *pdev,
> +						pci_channel_state_t error)
> +{
> +	if (error == pci_channel_io_frozen) {
> +		pdsc_reset_prepare(pdev);
> +		return PCI_ERS_RESULT_NEED_RESET;
> +	}
> +
> +	return PCI_ERS_RESULT_NONE;
> +}

The ->error_detected() callback of this driver invokes
pdsc_reset_prepare(), which unmaps BARs and calls pci_disable_device(),
but there is no corresponding ->slot_reset() callback which would invoke
pdsc_reset_done() to re-enable the device after reset recovery.

I don't have this hardware available for testing, hence do not feel
comfortable submitting a fix.  But this definitely looks broken.

Thanks,

Lukas

