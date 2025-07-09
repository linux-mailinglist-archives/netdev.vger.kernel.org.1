Return-Path: <netdev+bounces-205268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A9EAFDF5D
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 07:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7111C22524
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 05:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1528826A0DD;
	Wed,  9 Jul 2025 05:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="OJj8VuxQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE911C860E
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 05:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752039788; cv=none; b=jiE/nD4xbzl3Tia7atsrw3Aa54I4bfyyN06v+iSd91UFLLMSjmfhRzXO0UgRulw0LT3JRuhYLsSDXntUqf82i6eultPxB3l320POO3xEGXvqjMSG9US16JvVTdT/xC/3fXqM/TZq1h3fEXMq77Sl2F6kf20QA+FtVX0DreY0rtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752039788; c=relaxed/simple;
	bh=SIXZE24PyghJGVkgKu0XjAqjgH0GjUlM0cEYNv0iNPU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgJ2myHKUvCtBwjj6HcTTBfSb4AnUxtBmOnxYjSmwCr35QPzT1NS0PeGa8yRISVb3BpoBq0Z9b1ceEUU1ZkhsbdqmrJqgrcJJzXglnmmF1951ikiR/6+3/xZrDV/biwexkywwmB8w9ueKCHlAkq8MpvnLCpTUtfcnZxxQiAU3sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=OJj8VuxQ; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id A4F91207B0;
	Wed,  9 Jul 2025 07:42:56 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2kUI_GFA-SCr; Wed,  9 Jul 2025 07:42:56 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 0D7962064C;
	Wed,  9 Jul 2025 07:42:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 0D7962064C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1752039776;
	bh=giKehZyBlT8OVOfRbY3DK/cJ1Uw3oBQ9QM08TJu0jaE=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=OJj8VuxQusB3IQolmlT0kAqXuMefthiAm1r7msle4hu1XTbklNM86tnujO56Vs40J
	 ZT9xQn9MihBwj89lxIE/IGrRMZs8Ky71uILkgQn7NtCIJmE+g6ajaAAiXSe2Dr3uO8
	 Qy5aWGzKJu2eqK/yGaexmrMiHjO3DAbGIGRA/GQEQ63W6CR6rACdTVZsU0qr+SulG0
	 MdRd3K910HjKeJcgn1NvvlSqDMLFeUhDhF7k38cKbkebwuefmV8Xv+7tXhVHhHIOzy
	 R2aBvIoxTmSap2tXLCuqyRvHthEe3aQf8OlNXm4mC9t2SSgYcCl2AEWoVrBTtR7nF/
	 X8qJhAg6T5Mvg==
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 9 Jul 2025 07:42:55 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Jul
 2025 07:42:55 +0200
Date: Wed, 9 Jul 2025 07:42:47 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Paul Wouters <paul@nohats.ca>,
	Andreas Steffen <andreas.steffen@strongswan.org>, Tobias Brunner
	<tobias@strongswan.org>, Antony Antony <antony@phenome.org>, Tuomo Soini
	<tis@foobar.fi>, "David S. Miller" <davem@davemloft.net>,
	<netdev@vger.kernel.org>, <devel@linux-ipsec.org>, Leon Romanovsky
	<leon@kernel.org>
Subject: Re: [devel-ipsec] [PATCH RFC ipsec-next] pfkey: Deprecate pfkey
Message-ID: <aG4BV8I8ig67NhXS@moon.secunet.de>
Reply-To: <antony.antony@secunet.com>
References: <aGd60lOmCtytjTYU@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aGd60lOmCtytjTYU@gauss3.secunet.de>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, Jul 04, 2025 at 08:55:14 +0200, Steffen Klassert via Devel wrote:
> The pfkey user configuration interface was replaced by the netlink
> user configuration interface more than a decade ago. In between
> all maintained IKE implementations moved to the netlink interface.
> So let 'config NET_KEY' default to no in Kconfig. The pfkey code
> will be removed in a second step.
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>

Acked-by: Antony Antony <antony.antony@secunet.com>

I have tested libreswan and strongSwan CONFIG_NET_KEY=n; without HW offload.

And I would also like to get a confirmation Hardware offload, crypt
offload and packet offload works with CONFIG_NET_KEY n.

I undderstand this patch is independent of HW offload.

However, IMHO it is good to confirm now.  Otherwise I imagine
distributions will flip CONFIG_NET_KEY=y to get HW offload working,
which will make it harder to depreciate PF_KEY/NET_KEY

Paul or Leon - would you like to confirm with
CONFIG_NET_KEY=n XFRM HW offload still works?

-antony

> ---
>  net/xfrm/Kconfig | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/net/xfrm/Kconfig b/net/xfrm/Kconfig
> index f0157702718f..aedea7a892db 100644
> --- a/net/xfrm/Kconfig
> +++ b/net/xfrm/Kconfig
> @@ -110,14 +110,17 @@ config XFRM_IPCOMP
>  	select CRYPTO_DEFLATE
>  
>  config NET_KEY
> -	tristate "PF_KEY sockets"
> +	tristate "PF_KEY sockets (deprecated)"
>  	select XFRM_ALGO
> +	default n
>  	help
>  	  PF_KEYv2 socket family, compatible to KAME ones.
> -	  They are required if you are going to use IPsec tools ported
> -	  from KAME.
>  
> -	  Say Y unless you know what you are doing.
> +	  The PF_KEYv2 socket interface is deprecated and
> +	  scheduled for removal. Please use the netlink
> +	  interface (XFRM_USER) to configure IPsec.
> +
> +	  If unsure, say N.
>  
>  config NET_KEY_MIGRATE
>  	bool "PF_KEY MIGRATE"
> -- 
> 2.43.0
> 
> -- 
> Devel mailing list -- devel@lists.linux-ipsec.org
> To unsubscribe send an email to devel-leave@lists.linux-ipsec.org

