Return-Path: <netdev+bounces-100558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BFD8FB2FB
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 14:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F8782821E7
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 12:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583B01465A4;
	Tue,  4 Jun 2024 12:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3KdnjRs0"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5031459F5;
	Tue,  4 Jun 2024 12:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717505679; cv=none; b=Yg+YDXciZelul0I8PA1+hiVBbktTPu99PK+AGLywAyMS1P7H+zsLNdUoaK3ltQsy7LU+RoEwVZbOg2/fF6Yz1bB6rrWmTiKL9CsHmK3r1wbtGsMyLrcaTk2CLcTEnPn0Dz6fkeyHEong/f7cqJjbkz3S+v9sI6BsW7x1lMRHJ2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717505679; c=relaxed/simple;
	bh=oKPIUnQ8NiMX8mTL6yCMUTijSz2W1I1iwjC/sDG5wv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxXBzgX26sB9x/+nNWZFtwh7Hq4S2fj1nfQqv4ZCQZt6pxaf9dqiUyEf69VWBiljFfwO0LR6fJ3N45QgEIaz1q1yY9H5iQ4f3TE9X/xhxSTgpl1Bq7ZYH+ElQGRsF8IhMcgsKjP1Oec4l0SvktRvSttJfX/yBy/kmhwlGeG3MM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3KdnjRs0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ETTIRp6+sIjU+IWTI+nRyjXxT3ESKvDw8LivhS9+14U=; b=3KdnjRs0saRERtsNQaPkPtxdUn
	vR7XhNZpVZPu6ScMFo6Lu2Quk6XowS/HlD+m4N2odifHbxs2u/KLRjUSPm+kMn+rhLk65QKgNQktm
	AbHxNI24Z2nl7+COPAqcvfv3pubBdOGRGEh6o9pCssG+DqLxAvXxUtnQ2ntAu5zilB0M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sETgC-00GnoP-3T; Tue, 04 Jun 2024 14:54:20 +0200
Date: Tue, 4 Jun 2024 14:54:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yojana Mallik <y-mallik@ti.com>
Cc: schnelle@linux.ibm.com, wsa+renesas@sang-engineering.com,
	diogo.ivo@siemens.com, rdunlap@infradead.org, horms@kernel.org,
	vigneshr@ti.com, rogerq@ti.com, danishanwar@ti.com,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com, rogerq@kernel.org,
	Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH net-next v2 2/3] net: ethernet: ti: Register the RPMsg
 driver as network device
Message-ID: <f14a554c-555f-4830-8be5-13988ddbf0ba@lunn.ch>
References: <20240531064006.1223417-1-y-mallik@ti.com>
 <20240531064006.1223417-3-y-mallik@ti.com>
 <4416ada7-399b-4ea0-88b0-32ca432d777b@lunn.ch>
 <2d65aa06-cadd-4462-b8b9-50c9127e6a30@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d65aa06-cadd-4462-b8b9-50c9127e6a30@ti.com>

> >> +	u32 buff_slot_size;
> >> +	/* Base Address for Tx or Rx shared memory */
> >> +	u32 base_addr;
> >> +} __packed;
> > 
> > What do you mean by address here? Virtual address, physical address,
> > DMA address? And whos address is this, you have two CPUs here, with no
> > guaranteed the shared memory is mapped to the same address in both
> > address spaces.
> > 
> > 	Andrew
> 
> The address referred above is physical address. It is the address of Tx and Rx
> buffer under the control of Linux operating over A53 core. The check if the
> shared memory is mapped to the same address in both address spaces is checked
> by the R5 core.

u32 is too small for a physical address. I'm sure there are systems
with more than 4G of address space. Also, i would not assume both CPUs
map the memory to the same physical address.

	Andrew

