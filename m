Return-Path: <netdev+bounces-161491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CC8A21D6C
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 14:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBCDE161F97
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 13:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1EADDA9;
	Wed, 29 Jan 2025 13:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cju5zJgv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64CFDF78;
	Wed, 29 Jan 2025 13:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738155707; cv=none; b=I9T5Ol+EoYeWsdENj/mDnbvWn4zFrgvd1QRl3H868FWXHADcmWgGPzq2+p4eEu4PSJoSRNN507442unf+mAb1rJxL4kkDuIXsGmPQr7eE8dlYFF8U3c/YffcaaJPMVnXRZ7Aw8hEFgTNqb9t13CrsW3UYSn5lWOGM5fwOXe19Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738155707; c=relaxed/simple;
	bh=4AI+Fm08nheOH11DrjdsHuMLkFKIId0rP5Kx1B2yzoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSZfzT6zz3iXgSm4g33eP/2VF0N7jogw2ZbfBCbGP7dOftmcruQyWmPFcr76vIjjgW/zvh6oZAe7vaAqNAuXNB8usS3Lf+JLqj+j4/pExsVIvVwSO9Tr0uroqp4uJtsoEbnUVspuMQmN5NEZ7udw52uZOwS9EoBD7brP+Mmdan0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cju5zJgv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bPfF7tWGgIi6QwyGI04z66zIqd+2JEVIDkcPLUeXhus=; b=cju5zJgvOX+7ImKdA5tVG6fcMz
	VdvaVvwCdT3YzfVtMA5mFgkhZ6L+XHXjMrz8yfSeZdi57m2QYhlCt2F/xZG3wctCrnZJovopUXnpK
	tVhmZW0PZUBfM9orfkgwdCfeFMOvL0ig7aMTVkxsH+PUHRMafWPsUJ9SXf5bzYMmC420=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1td7hD-00986o-0i; Wed, 29 Jan 2025 14:01:31 +0100
Date: Wed, 29 Jan 2025 14:01:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Swathi K S <swathi.ks@samsung.com>
Cc: krzk@kernel.org, robh@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	conor+dt@kernel.org, richardcochran@gmail.com,
	mcoquelin.stm32@gmail.com, alim.akhtar@samsung.com,
	linux-fsd@tesla.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, alexandre.torgue@foss.st.com,
	peppe.cavallaro@st.com, joabreu@synopsys.com, rcsekar@samsung.com,
	ssiddha@tesla.com, jayati.sahu@samsung.com,
	pankaj.dubey@samsung.com, ravi.patel@samsung.com,
	gost.dev@samsung.com
Subject: Re: [PATCH v5 2/4] net: stmmac: dwc-qos: Add FSD EQoS support
Message-ID: <8b0f068c-26f7-455a-a546-65531cd7fe48@lunn.ch>
References: <20250128102558.22459-1-swathi.ks@samsung.com>
 <CGME20250128102732epcas5p4618e808063ffa992b476f03f7098d991@epcas5p4.samsung.com>
 <20250128102558.22459-3-swathi.ks@samsung.com>
 <63e64aa6-d018-4e45-acc7-f9d88a7db60f@lunn.ch>
 <002c01db722e$5abc8d10$1035a730$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002c01db722e$5abc8d10$1035a730$@samsung.com>

> > It looks like you should be able to share all the clk_bulk code with
> > tegra_eqos_probe(). The stmmac driver suffers from lots of cut/paste code
> > with no consolidation. You can at least not make the tegra code worse by
> > doing a little refactoring.
> 
> Hi Andrew, 
> Just to clarify, you were referring to refactoring tegra code to use
> clk_bulk APIs, right?

Yes.

	Andrew

