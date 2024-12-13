Return-Path: <netdev+bounces-151834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 841A79F1320
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 18:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBC0318866EE
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 17:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9B01BBBFD;
	Fri, 13 Dec 2024 17:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brun.one header.i=@brun.one header.b="WaP2LlmE"
X-Original-To: netdev@vger.kernel.org
Received: from mx.dolansoft.org (s2.dolansoft.org [212.51.146.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABB01422D4;
	Fri, 13 Dec 2024 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.51.146.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734109254; cv=none; b=cExvZ47KG5WbCoknv4LB3ZBKG63VqOYkkhRSwNdHoWh4RhittbB08Aqqh0xB5pgBcAo++qXtrnofLr2F+21xw4jNTqAaqSaHvIk4LYTITcSMYhM+vePY5Wq2Hdn8UMO4i1UZWiEGxPsOuI0QCvpHBt6bE6hpGTTtL3sU6ovSBy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734109254; c=relaxed/simple;
	bh=G36R8NXw7mb55c/2JQU0c3hGoc+MXWGbESzEI7JUUBc=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gEc67FFSpW+VM0+g2rxYFWOXPYBvnzbiMVxJGIwofgre60PA3o61Qtj0JaHsMGTeKxV6rvf7nk3fjMYUuvqyTjIjPxTu7yLHXGLVy0dHskq4mWevoh6TeXxIxMYaE5oK596w5/W/Ms6beNmqoeNLDIazxGZTyAf+tmNgTBFckXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brun.one; spf=pass smtp.mailfrom=brun.one; dkim=pass (2048-bit key) header.d=brun.one header.i=@brun.one header.b=WaP2LlmE; arc=none smtp.client-ip=212.51.146.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brun.one
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brun.one
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=brun.one;
	s=s1; h=MIME-Version:References:In-Reply-To:Message-Id:Cc:To:Subject:From:
	Date:From:To:Subject:Date:Message-ID:Reply-To;
	bh=Agp337t9HufqQqyypTdkJtJXEKPsUy8NiaqQfv8eEw8=; b=WaP2LlmE633wdtrQPxa6ZtXhfI
	be48Cls+N6m9midh/N9OpR5UwzePYlBCMJr8Uf+aGn1thnVblzsI9fjqGJJr+bO/bELlPmBlIcPnn
	JVP0uYQh456s2Tea4qmS5ZVIzHj0UifUs+pctZ5XIqkQ68pnFQwEBXxKksRStejt1hr6U8Ur7q9J2
	xeL1S55tejR9fRi9tt7dJ1Dq+R5GGx6+pE0+jSudwFfDBUx10Gedv9RYDtgXU7GL1TFPlPx3Bt32N
	iq8ILCwoYUO2Dis6+764sZmFYfSZ2qZ4in1+xsgtjyWi9fBcvAEUbXiCyq+onPUQXUw2H/akSSuV7
	q2nsLvCA==;
Received: from [212.51.153.89] (helo=[192.168.9.177])
	by mx.dolansoft.org with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98)
	(envelope-from <lorenz@dolansoft.org>)
	id 1tM91p-00000001WXO-2PAS;
	Fri, 13 Dec 2024 17:00:37 +0000
Date: Fri, 13 Dec 2024 18:00:31 +0100
From: Lorenz Brun <lorenz@brun.one>
Subject: Re: [PATCH net] net: atlantic: keep rings across suspend/resume
To: Andrew Lunn <andrew@lunn.ch>
Cc: Igor Russkikh <irusskikh@marvell.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Manuel Ullmann
	<labre@posteo.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <V8ZFOS.N7LNJ4P9ABW3@brun.one>
In-Reply-To: <bbcd37de-c731-4f0b-92f0-8c332bb01c5b@lunn.ch>
References: <20241212023946.3979643-1-lorenz@brun.one>
	<bbcd37de-c731-4f0b-92f0-8c332bb01c5b@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: lorenz@dolansoft.org



Am Do, 12. Dez 2024 um 18:20:26 +01:00:00 schrieb Andrew Lunn 
<andrew@lunn.ch>:
> On Thu, Dec 12, 2024 at 03:39:24AM +0100, Lorenz Brun wrote:
>>  The rings are order-6 allocations which tend to fail on suspend due 
>> to
>>  fragmentation. As memory is kept during suspend/resume, we don't 
>> need to
>>  reallocate them.
> 
> I don't know this driver. Are there other reasons to reallocate the
> rings? Change of MTU? ethtool settings? If they are also potentially
> going to run into memory fragmentation issues, maybe it would be
> better to use smaller order allocations, or vmalloc, if the hardware
> supports that, etc.
> 
> 	Andrew

ethtool settings do indeed reallocate, but not during unsuspend where 
we have GFP_NOIO. Smaller oder allocations would definitely be better, 
but on systems without IOMMU that would probably pose a problem as 
rings are generally assumed to be contigous by hardware (as far as I 
understand). I don't have access to hardware docs, so I don't know if 
you can make the HW work without physically-contiguous memory.

Linux just really doesn't handle high-order allocations well, I got one 
unsuspend failure with 6GiB (!!) of free space in the relevant region 
(but no order-6 or higher). I have no idea why it doesn't defragment 
before failing the allocation as it clearly has enough memory.

kworker/u97:14: page allocation failure: order:6, 
mode:0x40d00(GFP_NOIO|__GFP_COMP|__GFP_ZERO), 
nodemask=(null),cpuset=/,mems_allowed=0
Node 0 Normal: 787628*4kB (UME) 234026*8kB (UME) 50882*16kB (UME) 
13751*32kB (UME) 35*64kB (UME) 9*128kB (M) 0*256kB 0*512kB 0*1024kB 
1*2048kB (H) 0*4096kB = 6282304kB


Regards,
Lorenz



