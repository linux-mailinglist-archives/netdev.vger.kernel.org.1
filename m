Return-Path: <netdev+bounces-163789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B03A2B91E
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 03:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64DC1887AAC
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 02:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7C6282E1;
	Fri,  7 Feb 2025 02:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcwn6q13"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0CF7E9
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 02:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738895636; cv=none; b=BOTfTXNc77gMngCJzJJWoOd4H9jXn5El7Y4rTt04NZFq2hfHFYq6N43zqFQjEcJTcLQzAeZDmhEeBQAaaw6lP2xqI0Uwrhi7mwO7RWJEDn14O0oim7HcDTKUo4l0Sfkv+ggbLOrTfbnCPDEOAAS7LkmbPz5BRXgZAccLLYVL8N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738895636; c=relaxed/simple;
	bh=GdDbyGIzviXjTeSXk/FPXDQ2vguVeuJkFIC2V1e/OoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NBnybfSevj0NtfJIOvSkmsxD1l8aQaSEpkMO1/jK8mtydDTQTHUegcfEqWJnM5CvqFnJm04/mHQbIBGKpNSVHNqasWMPscS26X1O9X2+IL1Yu12N/0x84E7r6vdZehXupAavjD4logshig7m/vKDczDi/id2DuTKO0S0LIUZyBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcwn6q13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A292C4CEDD;
	Fri,  7 Feb 2025 02:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738895634;
	bh=GdDbyGIzviXjTeSXk/FPXDQ2vguVeuJkFIC2V1e/OoQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pcwn6q13hRXYMLVPzLkpUE3XNdu5FK8aSZaVdBXIT3SlnQ3hEFO/9VHDf2myjE9RZ
	 NmYaM32lmEPEMtDRzpHbnYDR5zaTNEkYR6XHJEq1hyWkkBAS4s32vF05Mwg8fcxA2Z
	 etsT1WQzHfZA1fAAXpGGVr4/b9M+92Nqu9wx7jAh2M4/9187ovosBft3hEzg9TFk21
	 iUe4gjPaJAid6Rn8P/9p6e67kLK1RMtKD0tLyFUxuvECO3PyO61FzY8A0jN1lBoA97
	 v+o7KW8WwIH+vSIe/VYfHGx8flmtqQcnBwb3qXjkUMCmhbnp3w7dGQDCM6VrgrAtN1
	 eyie2xQ1JAwuw==
Date: Thu, 6 Feb 2025 18:33:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: Joe Damato <jdamato@fastly.com>, <netdev@vger.kernel.org>,
 <intel-wired-lan@lists.osuosl.org>, <andrew+netdev@lunn.ch>,
 <edumazet@google.com>, <horms@kernel.org>, <pabeni@redhat.com>,
 <davem@davemloft.net>, <michael.chan@broadcom.com>, <tariqt@nvidia.com>,
 <anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
 <shayd@nvidia.com>, <akpm@linux-foundation.org>, <shayagr@amazon.com>,
 <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net-next v7 2/5] net: napi: add CPU affinity to
 napi_config
Message-ID: <20250206183352.4cecc85e@kernel.org>
In-Reply-To: <8270a43c-61f8-446d-8701-4fbd13a72e32@intel.com>
References: <20250204220622.156061-1-ahmed.zaki@intel.com>
	<20250204220622.156061-3-ahmed.zaki@intel.com>
	<Z6KYDs0os_DizhMa@LQ3V64L9R2>
	<8270a43c-61f8-446d-8701-4fbd13a72e32@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Feb 2025 08:20:20 -0700 Ahmed Zaki wrote:
> >> +	if (napi->dev->rx_cpu_rmap_auto) {
> >>   		rc = napi_irq_cpu_rmap_add(napi, irq);
> >>   		if (rc)
> >>   			netdev_warn(napi->dev, "Unable to update ARFS map (%d)\n",
> >>   				    rc);
> >> +	} else if (napi->config && napi->dev->irq_affinity_auto) {
> >> +		napi->notify.notify = netif_napi_irq_notify;
> >> +		napi->notify.release = netif_napi_affinity_release;
> >> +
> >> +		rc = irq_set_affinity_notifier(irq, &napi->notify);
> >> +		if (rc)
> >> +			netdev_warn(napi->dev, "Unable to set IRQ notifier (%d)\n",
> >> +				    rc);
> >>   	}  
> > 
> > Should there be a WARN_ON or WARN_ON_ONCE in here somewhere if the
> > driver calls netif_napi_set_irq_locked but did not link NAPI config
> > with a call to netif_napi_add_config?
> > 
> > It seems like in that case the driver is buggy and a warning might
> > be helpful.
> >   
> 
> I think that is a good idea, if there is a new version I can add this in 
> the second part of the if:
> 
> 
> if (WARN_ON_ONCE(!napi->config))
> 	return;

To be clear, this will make it illegal to set IRQ on a NAPI instance
before it's listed. Probably for the best if we also have auto-remove
in netif_napi_del().

