Return-Path: <netdev+bounces-74047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F1A85FBE0
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 16:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7CCC287FA1
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 15:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE471474C2;
	Thu, 22 Feb 2024 15:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ccpkY8OQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6961468ED
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614485; cv=none; b=EVTyC3rYpRXSindni22rmppVVtjET52VjjG4Pp28W91LFOi6H4vymbyNuo+hbeHwhztYS+QGZXisIsZ67uGvHXeQUF2NAD4ZaUN0V3bBbbuyUa3w9ZuylfeuqH0ESlvtVcd8pM5pzZCWTFqxw3kcmx0cD4GoE5g9N393JNBF70w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614485; c=relaxed/simple;
	bh=AR/o67tXIL6monXwVy+cidG5Xc9ygQgWKPDRK3VosOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZzzcatS20IBWLUTXCYuEk8VFcD4HNxa8whrf7CxcgBVSxFLShM5srn2N0NTs3/geTMvl8d9EU473RJBxOZuTiB5Cz+LDFV6IDTSvW1j1otMBVc73GL7I+uD4jWJOoBmxxyPJ1XGOhhrheReTbLTsS6peQQD+X8xhk74O+yeMU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ccpkY8OQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=p+c4fBqclsjWBb1LeYOcVFsfWCYTjPFl4k/ApJnIQCI=; b=ccpkY8OQl1Zi/+AF6dtxADFu7W
	SyOr8vSIWSIuKoF1kCf5ZnfoQdoNNbmzqpu2lalTm1u6h7sSdH3IbopZujpXpwxnPdDZh7vXPUYIv
	d+K5edG5d0479QazKSYPcQPm6b2AN7qbbSeVS26FVN2BlsyI9Ri87BtJK0zifSC5ABTA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rdAfx-008S4y-3J; Thu, 22 Feb 2024 16:07:53 +0100
Date: Thu, 22 Feb 2024 16:07:53 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, maciej.fijalkowski@intel.com,
	netdev@vger.kernel.org, mengyuanlou@net-swift.com
Subject: Re: [PATCH] net: txgbe: fix GPIO interrupt blocking
Message-ID: <91d182fe-179b-4fad-9d67-3b62230dcb86@lunn.ch>
References: <20240206070824.17460-1-jiawenwu@trustnetic.com>
 <9259e4eb-8744-45cf-bdea-63bc376983a4@lunn.ch>
 <003801da6249$888e4210$99aac630$@trustnetic.com>
 <33eed490-7819-409e-8c79-b3c1e4c4fd66@lunn.ch>
 <00e301da63de$bd53db90$37fb92b0$@trustnetic.com>
 <96b3ed32-1115-46bf-ae07-9eea0c24e85a@lunn.ch>
 <021e01da6532$6ab0e900$4012bb00$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <021e01da6532$6ab0e900$4012bb00$@trustnetic.com>

> There are flags passed in sfp.c:
> 
> err = devm_request_threaded_irq(sfp->dev, sfp->gpio_irq[i],
> 				NULL, sfp_irq,
> 				IRQF_ONESHOT |
> 				IRQF_TRIGGER_RISING |
> 				IRQF_TRIGGER_FALLING,
> 				sfp_irq_name, sfp);

Does you hardware support edges for GPIOs? And by that, i mean the
whole chain of interrupt controllers? So your GPIO controller notices
an edge in the GPIO. It then passed a notification to the interrupt
controller within the GPIO controller. It then sets a bit to indicate
an interrupt has happened. At that point you have a level
interrupt. That bit causes a level interrupt to the interrupt
controller above in the chain. And it needs to be level all way up.

	Andrew

