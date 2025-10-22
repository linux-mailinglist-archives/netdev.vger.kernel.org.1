Return-Path: <netdev+bounces-231576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8972BFACA5
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 10:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D396A18C1E90
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 08:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C126F2FFF81;
	Wed, 22 Oct 2025 08:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="IFUL31HQ"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CDD2FE066
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 08:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120383; cv=none; b=eiJqrY6Ji9YDnN+Wd2YQ2NFdjFuMxI+VFK4JpUzkdh/gT7BC1zlftF8APPk6THRC0qG6h4jGRuuOumvyM7ik6Rb9KL5BW7uq2/bztwHvjnJzywl1Qr5QTA8cDG8ClqVB8ShfKV7qEg9/zsBtoH8/xdoOsIbh+eifBgu+af9YoCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120383; c=relaxed/simple;
	bh=yWIeJqkzJzUgwFQVm2LP4N2Gl6smrwgcJkkztltZDdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebRMlOuAoRBoCbX+eDkCNp6LPlVoDUAC0/NcBmMNFPrbR/wGpga0Nvd1pyhgifUpYea3WfwosWuU3VWEab+/3ple4bDjbCs/0wkfcbd+lbudn1FXEi1rrc1DAqaQZ5cBpvNDEve1Cl7VQxInxlyfFB7I/2zhPtAkE/fiv0PeKkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=IFUL31HQ; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=oy/leNuOhLsaHyRbn+AQnGgzNKYI5Ga3as/aT1bKXyw=; 
	b=IFUL31HQDI6O6QAqEt97SaMw7Ov8qwBVCcCUpm5t9Lh8qR1Fhrd5HuQSq+BQHTyapeDWl9RxyO8
	X0g5Rxs99j+RxNCUVdoO9zjL1Y6wmQFLHT8OypISuM0W11AnFKeQBN794J94Gnmmy1CWvdKFRzW+v
	y0FrHEpPtUUAmz0voMcQIKTv8uV2/0LJDjZ5ngCyno1JILDt0iJdgSg04ExByn+ySSK9VrWla/Jjw
	BuaNq6Gks4W5MfI1JEwXh3cL1iu6p32YCLFtY81rg4I+KP9YWGUttmFDW+Xt94qicOtzqSUuBNv3E
	CS2pHaDkhywsSOLatB80XZHtRyEx2rE/ZnSw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vBTqZ-00EcOZ-0Z;
	Wed, 22 Oct 2025 16:05:28 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 22 Oct 2025 16:05:27 +0800
Date: Wed, 22 Oct 2025 16:05:27 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Paul Wouters <paul@nohats.ca>,
	Andreas Steffen <andreas.steffen@strongswan.org>,
	Tobias Brunner <tobias@strongswan.org>,
	Antony Antony <antony@phenome.org>, Tuomo Soini <tis@foobar.fi>,
	"David S. Miller" <davem@davemloft.net>,
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	devel@linux-ipsec.org
Subject: Re: [PATCH ipsec-next] pfkey: Deprecate pfkey
Message-ID: <aPiQR7cRRGBNC8dT@gondor.apana.org.au>
References: <aPh1a1LeC5hZZEZG@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPh1a1LeC5hZZEZG@secunet.com>

On Wed, Oct 22, 2025 at 08:10:51AM +0200, Steffen Klassert wrote:
> The pfkey user configuration interface was replaced by the netlink
> user configuration interface more than a decade ago. In between
> all maintained IKE implementations moved to the netlink interface.
> So let config NET_KEY default to no in Kconfig. The pfkey code
> will be remoced in a secomd step.
> 
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> Acked-by: Antony Antony <antony.antony@secunet.com>
> Acked-by: Tobias Brunner <tobias@strongswan.org>
> ---
> 
> Antony, Tobias, I kept the Acked-by tags from the RFC version.
> Let me know if that's ok.
> 
>  net/key/af_key.c |  2 ++
>  net/xfrm/Kconfig | 11 +++++++----
>  2 files changed, 9 insertions(+), 4 deletions(-)

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

