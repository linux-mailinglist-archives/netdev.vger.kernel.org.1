Return-Path: <netdev+bounces-205271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6353FAFDFC4
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 08:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2C71887D18
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 06:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270A7265CBE;
	Wed,  9 Jul 2025 06:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=strongswan.org header.i=@strongswan.org header.b="S9LTCZ5O"
X-Original-To: netdev@vger.kernel.org
Received: from mail.codelabs.ch (mail.codelabs.ch [109.202.192.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD1B176ADB
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 06:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.202.192.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752041043; cv=none; b=PmYYX4RW8tOuoquHQfi0+W0Gto1x+XKYhlkGNa0pZxOaMK6htUsSZrKig4EOcXslcsWdNI/qoudqksrN3ntSYCE/Qb4Kk3hoQBFHUEELeEuIPnaaQ8dC4lr5kZ08WiZOxoWL6XejAlt3bz3k1+yZvHrYzo+FlvBsJMF2lMGiLZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752041043; c=relaxed/simple;
	bh=p/njsCtJJXwVxUS2Ilg5uxJ1bFEQJI0FFblvAXjsU1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TlqpYNHF+4X7GOk2FsnzD8fN7gDv/GBQ+Ks/O/wxKBF6gA76gmVTVXBC74prAXqNu4cyUPOzTh9Np9gsvrOGSjzjUx/JvzZQ7rrOHwkO/oh9IU19RfGPR1Y9yiiBkKPjtA7TWFO3g7FKo0VjQ17HTq0sNOqDyWMiOehrBlAge7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strongswan.org; spf=pass smtp.mailfrom=strongswan.org; dkim=pass (2048-bit key) header.d=strongswan.org header.i=@strongswan.org header.b=S9LTCZ5O; arc=none smtp.client-ip=109.202.192.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=strongswan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strongswan.org
Received: from localhost (localhost [127.0.0.1])
	by mail.codelabs.ch (Postfix) with ESMTP id BBCCF5A0004;
	Wed,  9 Jul 2025 07:56:55 +0200 (CEST)
Received: from mail.codelabs.ch ([127.0.0.1])
 by localhost (fenrir.codelabs.ch [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nAI3a8WkQ7eZ; Wed,  9 Jul 2025 07:56:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=strongswan.org;
	s=default; t=1752040614;
	bh=p/njsCtJJXwVxUS2Ilg5uxJ1bFEQJI0FFblvAXjsU1k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S9LTCZ5O0mLDqDmYmzhYGff1jqXfSElshfs9flKh2i8t2R3EKZLNZDbDDxc+vjA4N
	 kjq5Agn+Tfr4nIlJKbv0lYskRSLF/Hx/AyTEny+fG6+tgodoqf83ZZ/Ff6GDFYtxfA
	 0Nqx7LuXOdPIE9C7kQjumu7Qn133DG7DqHOh0lTnw+GGNpdkd4Uaekqk9LeDLZq+Dh
	 6cuROzQh16nYvo2Na77X1SRnNRjiUoE6cYVoQCi1WYylfs8/78Wg5pbJUFWalmVUFy
	 sdrq0johVwGIm2OUSkL0R+BiWtPiRBOkmfQmGHQB3oxQqgKhlE/tFL0KiR41mx5HYD
	 DPT6nJ1Gv/Kiw==
Received: from [IPV6:2a01:8b81:5406:7300:484c:4245:e897:1611] (unknown [IPv6:2a01:8b81:5406:7300:484c:4245:e897:1611])
	by mail.codelabs.ch (Postfix) with ESMTPSA id 5948F5A0003;
	Wed,  9 Jul 2025 07:56:54 +0200 (CEST)
Message-ID: <7d95ac8b-2240-4d5a-8626-f17e4fae7131@strongswan.org>
Date: Wed, 9 Jul 2025 07:56:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC ipsec-next] pfkey: Deprecate pfkey
To: Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Paul Wouters <paul@nohats.ca>,
 Andreas Steffen <andreas.steffen@strongswan.org>,
 Antony Antony <antony@phenome.org>, Tuomo Soini <tis@foobar.fi>,
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, devel@linux-ipsec.org
References: <aGd60lOmCtytjTYU@gauss3.secunet.de>
From: Tobias Brunner <tobias@strongswan.org>
Content-Language: de-CH, en-US
Autocrypt: addr=tobias@strongswan.org; keydata=
 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
 tvkh7XWO2ycrW1UlzUzM4KV3SDLIhfOU
In-Reply-To: <aGd60lOmCtytjTYU@gauss3.secunet.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04.07.25 08:55, Steffen Klassert wrote:
> The pfkey user configuration interface was replaced by the netlink
> user configuration interface more than a decade ago. In between
> all maintained IKE implementations moved to the netlink interface.
> So let 'config NET_KEY' default to no in Kconfig. The pfkey code
> will be removed in a second step.
> 
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
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

While we currently use this in our regression tests to test our PF_KEY
implementation (which is used on FreeBSD/macOS), I'm fine with
deprecating and eventually removing it.

Acked-by: Tobias Brunner <tobias@strongswan.org>

Regards,
Tobias


