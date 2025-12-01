Return-Path: <netdev+bounces-242914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D075C963A2
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 09:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C7293A174C
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 08:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6AD2EBB8B;
	Mon,  1 Dec 2025 08:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Mvdcja1L"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2002F0C64
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 08:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764578586; cv=none; b=n18rP10FyvzAwSki7bAfSmEdvwVXzP/+F2Ih75tbKwJK3Ct6eGjtROFZ3JKCvG3lB3q5pq+KgVSifzrSpe1IhY2/a2HovppSWFp1JFkkeYHM0PD0XrwwUNTjUjvdxmDCTbptIPKiRNrTWi7qGkyA2fNAkJSJuUToUDO1zvOHqpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764578586; c=relaxed/simple;
	bh=z+YRsa4VST9+zvpB9gN4V5gI2/qPmOPWbcHlJBIIHgc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0A0OpUAf2JRX1ANIoa19zz4WLSVmG2x+M8925gwlVcL/yfYkmz2fJRQTLs7jxIUkVjK9Vu8gGCVZFqMuKwvbawkymlVTJNCr4wQSWtoxSrTtWFstdYyAawkHvR22vmZ8D7Cr/lkJJqeTu/LzhT8IyfGcRSG1QvCh8rLfE7GwM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Mvdcja1L; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 16867205E5;
	Mon,  1 Dec 2025 09:42:55 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2FsMKjFBjTqA; Mon,  1 Dec 2025 09:42:54 +0100 (CET)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 7AB16201E2;
	Mon,  1 Dec 2025 09:42:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 7AB16201E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1764578574;
	bh=KrvPcgcL019dBrR8fDyUJ4M31N7dOzMZCDUSKuDf6jY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Mvdcja1LI2efCC3rZb0tGdBebZK6LqeVmc6FMfrDnGkBexdyn8J7yex4Ivr1DToIa
	 doSf4Ew5L7Lm2FUspWBqCcW16yRq2J0LAh72MqhBdGz+dZUlmzcHmzQMlWtDuBxX7G
	 3D1we3LSx51RiEuU05QTbto1lFFHOlih1BgZty+uyEz/jvJShPWEUeLsNNnhH6z4br
	 OJ/JY44euFulbqt4hjT9CDQmSzLVBLTRpRJhL1gs2x152KG78KXMyLLO0sIq+lFCyo
	 Q6Y0hJSHgKgmWErSaTnJzsgJTKjVeYElRw1JKB4WYykKf/+nMBCjykV+pw1Pean7xs
	 eKDNPdpawQ+uw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 1 Dec
 2025 09:42:53 +0100
Received: (nullmailer pid 1109103 invoked by uid 1000);
	Mon, 01 Dec 2025 08:42:53 -0000
Date: Mon, 1 Dec 2025 09:42:53 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: Cosmin Ratiu <cratiu@nvidia.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"ap420073@gmail.com" <ap420073@gmail.com>, "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>, Leon Romanovsky <leonro@nvidia.com>,
	"jv@jvosburgh.net" <jv@jvosburgh.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"horms@kernel.org" <horms@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Jianbo Liu <jianbol@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH ipsec v2 1/2] bond: Use xfrm_state_migrate to migrate SAs
Message-ID: <aS1VDd1sQroZtZAg@secunet.com>
References: <20251113104310.1243150-1-cratiu@nvidia.com>
 <aRcnDwyMn11TfRUG@krikkit>
 <88f2bf5ef1977fcdd4c87051cd54a4545db993da.camel@nvidia.com>
 <aR79MCBdyx2oTcp2@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aR79MCBdyx2oTcp2@krikkit>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 EXCH-01.secunet.de (10.32.0.171)

On Thu, Nov 20, 2025 at 12:36:16PM +0100, Sabrina Dubroca wrote:
> 2025-11-17, 12:48:20 +0000, Cosmin Ratiu wrote:
> > On Fri, 2025-11-14 at 13:56 +0100, Sabrina Dubroca wrote:
> 
> > All other callers of xfrm_state_delete() don't care about free, it will
> > be done when there are no more refs.
> > 
> > So right now for devices that implement xdo_dev_state_free(), there's
> > distinct behavior of what happens when xfrm_state_delete gets called
> > 
> > So right now, there's a difference in behavior for what happens with
> > in-flight packets when xfrm_state_delete() is called:
> > 1. On devs which delete the dev state in xdo_dev_state_free(), in-
> > flight packets are not affected.
> > 2. On devs which delete the dev state in xdo_dev_state_delete(), in-
> > flight packets will see the xs yanked from underneath them.
> > 
> > This makes me ask the question: Is there a point to the
> > xdo_dev_state_delete() callback any more? Couldn't we consolidate on
> > having a single callback to free the offloaded xfrm_state when there
> > are no more references to it? This would simplify the delete+free dance
> > and would leave proper cleanup for the xs reference counting.
> > 
> > What am I missing?
> 
> I don't know. Maybe it's a leftover of the initial offload
> implementation/drivers that we don't need anymore? Steffen?

The xfrm states are deleted in two stages. xfrm_state_delete
removes the states from the lists so they don't get used anymore.
In a second step the states are freed once all inflight packets
that used the state left the system. The xdo_dev_state_delete
and xdo_dev_state_free were an offer to the driver to do something
at both stages. I don't remember anymore how it was used in the
beginning. But if one callback is sufficient for all the drivers,
I'm ok with having just one callback.


