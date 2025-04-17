Return-Path: <netdev+bounces-183665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0C6A9174A
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 11:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B083C3A8ECE
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 09:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059E8226527;
	Thu, 17 Apr 2025 09:07:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE9B20ADCA;
	Thu, 17 Apr 2025 09:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744880825; cv=none; b=OfdDLZZYkmWER2bx9xaiD7vKQRSSFCrCXVDWJDnalaFyMs6/NnW2tnRapdl4glrFfSrtG8wsApuGRcTGI9KJmaKUiCNXzyIhCQ3GGPN2EKxuVYPUFwXKkBGfnSpoGIe8iSZco5e+/16rSH7R+46dZJIYKGjfAUSP00bOZKW7BCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744880825; c=relaxed/simple;
	bh=k/6qOXNpTtlyhLYgzioOeKPvYKeWft9iF+ovWqX6wSI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thEt/5SN7I3WnHWnf8xG85rapLJX43fsXImEP29piKHooOyB1L435GZJq3BgDT97S9SpnH5u0yPjSFiyLDfsE43wGDY16OnhwesItJB/QMDevAalivyHwFmVVzuyw29YNPu8/kA9kUF/IIBlHKBavaSwLYUS5KwBgoF6WvmIZRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id B75D2207AC;
	Thu, 17 Apr 2025 11:07:00 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S_hhJOjrkFp7; Thu, 17 Apr 2025 11:06:59 +0200 (CEST)
Received: from EXCH-01.secunet.de (unknown [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id DD7C2201AE;
	Thu, 17 Apr 2025 11:06:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com DD7C2201AE
Received: from mbx-essen-02.secunet.de (10.53.40.198) by EXCH-01.secunet.de
 (10.32.0.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 17 Apr
 2025 11:06:59 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 11:06:59 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 2BC8B3182C91; Thu, 17 Apr 2025 11:06:59 +0200 (CEST)
Date: Thu, 17 Apr 2025 11:06:59 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Thomas Winter <Thomas.Winter@alliedtelesis.co.nz>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<dsahern@kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC net] net: Prevent sk_bound_dev_if causing packet to
 be rerouted back into tunnel
Message-ID: <aADEs1L5i6raVrWh@gauss3.secunet.de>
References: <20250415045051.1913231-1-Thomas.Winter@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250415045051.1913231-1-Thomas.Winter@alliedtelesis.co.nz>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)

On Tue, Apr 15, 2025 at 04:50:51PM +1200, Thomas Winter wrote:
> We have found a situation where packets going into an IPsec tunnel get
> encapsulated twice. For example, an icmp socket using SO_BINDTODEVICE
> of a tunnel and some mangle rules to implement policy based routing.
> After the first ESP encapsulation and running through the mangle table
> again, a difference in skb->mark causes ip_route_me_harder to be called
> but skb->sk->sk_bound_dev_if is still the tunnel. This causes the ESP
> packet to get routed back into the tunnel and get xfrm'd again using
> the same SA. The double encapsulated is then routed correctly out the
> physical interface.
> 
> With a xfrmi interface on the other side, it was dropping the packet
> with LINUX_MIB_XFRMINTMPLMISMATCH. A ipvti interface would accept it.
> However the transmitting side should not have been doing the double
> ESP encapsulation in the first place.
> 
> A potential fix for this is to drop the reference to skb->sk using
> skb_orphan before transmission. scrub_packet would do this but only
> if the packet is traversing namespaces. This allows ip_route_me_harder
> to select the correct route for the ESP packet without getting fooled
> by a sk_bound_dev_if of itself and get forwarded out the physical
> interface.
> 
> Signed-off-by: Thomas Winter <Thomas.Winter@alliedtelesis.co.nz>

This looks ok to me.

