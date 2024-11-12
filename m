Return-Path: <netdev+bounces-143964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCEF9C4DAC
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 05:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E4AF284317
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 04:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDBD1A08B2;
	Tue, 12 Nov 2024 04:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="ZDyeuOUM"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918B916CD29
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 04:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731384968; cv=none; b=UHJqwdzGxyqfHs0feqarjLqWr/tdCc87vqmKL6TC2dekQFlGowdGgDxMgjHpyWxw5SIhP4LbgvF/0x03eghLwbd9v/aU+FtMgT8KE1Fdvrb4nAcqhYS7T2b8l9QtzIB3WT/0lhAQXwHVqgTs7L689xLFu0q1rP/GsylA7varbIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731384968; c=relaxed/simple;
	bh=uy3uqLRHfXPI001TOjpvjYyNZD0yjjOQwcAffxmdvlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rvtf2+gcKX27BRXKX2hoLagluR2dARDFrzvxi0ZK8qIcfysfVf4TfZmrkqrRCahvBrfnc34IxZo8ZSY0QF+gpFSvgYmK2JoCY3NYri32q4ljvz77Awc+F7D3Ji0uCIAJeb82z73Z/SBWkfWtN9rA1bjTQDUDg+784V9LUJm4+Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=ZDyeuOUM; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=4kYL+jth31n7Hz8rWiCyJvCyw0n/eS4R/2C2s6FINzw=; b=ZDyeuOUMx/Nx3hOaQGFa+MITkC
	6vRv39KZKuH46sI9HHEpMjvm92kOCUUc1eX20EpfcqPFoLq4RfwK1iRwlZoNwuKLWpgqnIO46vbax
	nVMtHDQLoA7rUgEAKJbSOrwF8Of/8mhHAHShOVNFwM5K/3W12kJ6TYcVsxs2JvCFfvQurmpgJSGZ6
	w2muvjuq7yScvYENDstM5BSdzaUyHMnq8w/ByRl8aYK09j/YdmyGCsAP0SqLX53NHVHTruMVZN+/z
	xnuZS0SNdCOzNZjyXUpvtd7DrRXlcfw1HnUX62yU1BzoBYgKsXW8dv9wX6YkLioxS/z0imJ5IUjsT
	cNDgdv2Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tAiJf-00G9OU-0P;
	Tue, 12 Nov 2024 12:15:48 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 12 Nov 2024 12:15:47 +0800
Date: Tue, 12 Nov 2024 12:15:47 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: "dongchenchen (A)" <dongchenchen2@huawei.com>,
	Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	yuehaibing@huawei.com, zhangchangzhong@huawei.com
Subject: Re: [PATCH net] net: Fix icmp host relookup triggering ip_rt_bug
Message-ID: <ZzLWcxskwi9e_bPf@gondor.apana.org.au>
References: <20241111123915.3879488-1-dongchenchen2@huawei.com>
 <ZzK5A9DDxN-YJlsk@gondor.apana.org.au>
 <8acfac66-bd2f-44a0-a113-89951dcfd2d3@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8acfac66-bd2f-44a0-a113-89951dcfd2d3@huawei.com>

On Tue, Nov 12, 2024 at 11:42:47AM +0800, dongchenchen (A) wrote:
>
> If skb_in is outbound, fl4_dec.saddr is not nolocal. It may be no input
> route from B to A for
> 
> first communication.

You're right.  So the problem here is that for the case of A
being local, we should not be taking the ip_route_input code
path (this is intended for forwarded packets).

In fact if A is local, and we're sending an ICMP message to A,
then perhaps we could skip the IPsec lookup completely and just
do normal routing?

Steffen, what do you think?

So I think it boils down to two choices:

1) We could simply drop IPsec processing if we notice that A
(fl.fl4_dst) is local;
2) Or we could take the __ip_route_output_key code path and
continue to do the xfrm lookup when A is local.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

