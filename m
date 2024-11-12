Return-Path: <netdev+bounces-144048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 417CA9C560E
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 12:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05A622817B3
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 11:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7FF21FDAE;
	Tue, 12 Nov 2024 10:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="isDiJkf0"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2F6215010;
	Tue, 12 Nov 2024 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408622; cv=none; b=GZZeF7YHmj+ktDqqYi+2agcEHH8Xc6EITlvxbOYdv3Za8tvyulirD4eIhDczStthOo5hiIHs9FcYaCstf650g0XtbYNUI+klvXt3vtmmb71cgf2m8xUKCPmRDU3EIFzl3OSPBb9ZkxF94l1Bu+mD+eZxFKa7rp7xQAIkmk66+xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408622; c=relaxed/simple;
	bh=K2Y9eESSp12JxRvCw+HrqqAyHVYfLWQIkdTY+grbKwY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FnkLr686q9n1YaVveY7/p4H4u7lfmamnmoyo9dTfuHzC9YCLFYrlLIpqcImkJ6xwDDsP9AN7HVzZQfQWJKIbafYZwO3X8N7d1GJuVMhrmeHlVzLdSwC5qhcniZpk5s0lNazmjK62y3kZwrxk2e81utZLnz5Zkvt01e3qTGccLmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=isDiJkf0; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 37DEC1BF205;
	Tue, 12 Nov 2024 10:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731408613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xkaaHxYMcgWp/Jayi5yY0YVWgrdbJQW2Bo/aXyuAcTM=;
	b=isDiJkf0oDX77LXbJdSdCzRBNxcVXYU8Eai4pp6HN/z63vhnavWl1UtE70ItXhyv7QDcXF
	Hgo8EJb7GPFkqIdTH9q/pUSAacJc7nfeAzL2kdSlKlv/Iy0k0uih6Dw0d+aJVBQ4QBW+16
	UTjWOTeDMrFkVK1WXoIcFnZlfsDpSZDRaqIF0Ip1YFVNWBhmiS6udn0QDmXrDY/mqt9kAU
	rReUKiWoFRLHv461lr7igdYCGG8/l1RDYhXE/IrLkZYhweOB2kEZvjgOVLsy8nhlPWOnGH
	W4YleSe/ON9aFboToWLe5yXSTIPpSoglbRTZRjlXLyQSa5EBspMWShEGQeYvVA==
Date: Tue, 12 Nov 2024 11:50:09 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Richard
 Cochran <richardcochran@gmail.com>, Alexis =?UTF-8?B?TG90aG9yw6k=?=
 <alexis.lothore@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/9] net: stmmac: Introduce dwmac1000
 ptp_clock_info and operations
Message-ID: <20241112115009.028b8724@fedora.home>
In-Reply-To: <1b335330-900e-4620-8aaf-a27424f44321@redhat.com>
References: <20241106090331.56519-1-maxime.chevallier@bootlin.com>
	<20241106090331.56519-5-maxime.chevallier@bootlin.com>
	<20241111161205.25c53c62@kernel.org>
	<1b335330-900e-4620-8aaf-a27424f44321@redhat.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Jakub, Paolo,

On Tue, 12 Nov 2024 10:28:21 +0100
Paolo Abeni <pabeni@redhat.com> wrote:

> On 11/12/24 01:12, Jakub Kicinski wrote:
> > On Wed,  6 Nov 2024 10:03:25 +0100 Maxime Chevallier wrote:  
> >> +		mutex_unlock(&priv->aux_ts_lock);
> >> +
> >> +		/* wait for auxts fifo clear to finish */
> >> +		ret = readl_poll_timeout(ptpaddr + PTP_TCR, tcr_val,
> >> +					 !(tcr_val & GMAC_PTP_TCR_ATSFC),
> >> +					 10, 10000);  
> > 
> > Is there a good reason to wait for the flush to complete outside of 
> > the mutex?   
> 
> Indeed looking at other `ptpaddr` access use-case, it looks like the
> mutex protects both read and write accesses.
> 
> @Maxime: is the above intentional? looks race-prone

You're right, this is racy... It wasn't intentionnal, it's actually the
same logic as dwmac4 uses so looks like dwmac4 is also incorrect in
that regard.

I'll send a v4 with that change, and a fix for dwmac4 along the way
then.

Thanks for spotting this,

Maxime


