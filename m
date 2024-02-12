Return-Path: <netdev+bounces-70865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5525F850DE4
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 08:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D24C3B2582E
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 07:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9CA749F;
	Mon, 12 Feb 2024 07:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="fh+kSBdi"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A21AEAE3
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 07:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707722342; cv=none; b=GAsdL1U1d/+xIK6DxOwJLYZ2ZEu2mGefPyfG/NDZpfiNFVq8BuX4MiO+NXf7vU5lPROTLjWwwHTB0Yg2iwX9I917jQ8FX6KWqPp4HGFGxdSsC8GcdHY81IFwqhwztVFjJ3OfXvL9/I9wTrQRMprtol440ck4nKyVJB/VW0sA+cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707722342; c=relaxed/simple;
	bh=4vWqF5DsjiPs7c/0qy/Qc2LQ0dVlfANTAsBn2zR0u+4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jq7kMTh6CdBxXC/IHdlrcJbWUB7Ed18zzQrEno985lB5Fv2Ogi9vkcIQkKEgtzV2jbJFyxiyCvLnOqVxc3gnL/Sg6R91m53VEAjzouS/bO6AkhRi41tVdYBCZ780WYe1bLJF0fFwmWWIIj2JnJs+0F2Sxz+SU9BSFVi0f2Vdx0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=fh+kSBdi; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id A4327201AA;
	Mon, 12 Feb 2024 08:18:57 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v6hcJi_5evwr; Mon, 12 Feb 2024 08:18:57 +0100 (CET)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 1D7582019D;
	Mon, 12 Feb 2024 08:18:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 1D7582019D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1707722337;
	bh=x+j3ooG4CcS+WJVK9kB7HUD13TcWgmDrw0qsAXtfXwM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=fh+kSBdiTbR3w6O5royu49FI4vHnl1ae6UAWBpVAqgYmuauYV4ACEvkNvMKBK9Cgr
	 zS+jz7KdnXkQZnUmMcqHGfiaXBCfBtn2CPAyVcHFqe39Y9NX8GKIAzrmJkO+2NxWVt
	 yQtJwtIvTyjYVZGJFe39tw+Jedbhd6VmblEI43VeBxlO2gLqPxgYuTEbJnineQ7mb0
	 U+dp5g7tr46oK1uJEaANzghEXb1m0fyRnuUaOEaUTK1xD/D+V05ezFcVxXy2Qs44u7
	 W4C8kCSO8rWeoa1ZUnPf0BFjEU00e9nPnTLJWt5WIELGJd+jug3GD8VGxD/y3uNBWb
	 glREtsbCqe1gA==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id 0CC4E80004A;
	Mon, 12 Feb 2024 08:18:57 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 08:18:56 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 12 Feb
 2024 08:18:56 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 5B0F1318299F; Mon, 12 Feb 2024 08:18:56 +0100 (CET)
Date: Mon, 12 Feb 2024 08:18:56 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Eyal Birger <eyal.birger@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <herbert@gondor.apana.org.au>,
	<pablo@netfilter.org>, <paul.wouters@aiven.io>, <nharold@google.com>,
	<mcr@sandelman.ca>, <devel@linux-ipsec.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH ipsec-next,v3] xfrm: support sending NAT keepalives in
 ESP in UDP states
Message-ID: <ZcnGYKa1CvsnWA78@gauss3.secunet.de>
References: <20240128053257.851933-1-eyal.birger@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240128053257.851933-1-eyal.birger@gmail.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Sat, Jan 27, 2024 at 09:32:57PM -0800, Eyal Birger wrote:
> Add the ability to send out RFC-3948 NAT keepalives from the xfrm stack.
> 
> To use, Userspace sets an XFRM_NAT_KEEPALIVE_INTERVAL integer property when
> creating XFRM outbound states which denotes the number of seconds between
> keepalive messages.
> 
> Keepalive messages are sent from a per net delayed work which iterates over
> the xfrm states. The logic is guarded by the xfrm state spinlock due to the
> xfrm state walk iterator.
> 
> Possible future enhancements:
> 
> - Adding counters to keep track of sent keepalives.
> - deduplicate NAT keepalives between states sharing the same nat keepalive
>   parameters.
> - provisioning hardware offloads for devices capable of implementing this.
> - revise xfrm state list to use an rcu list in order to avoid running this
>   under spinlock.
> 
> Suggested-by: Paul Wouters <paul.wouters@aiven.io>
> Signed-off-by: Eyal Birger <eyal.birger@gmail.com>

We agreed to wait for antother test from the libreswan team.
So I've postponed the merge until we have this 'Tested-by'
tag.

