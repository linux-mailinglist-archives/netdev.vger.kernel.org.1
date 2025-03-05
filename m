Return-Path: <netdev+bounces-172102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 439F2A5038F
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 16:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BDB9167278
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 15:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EF324CEE3;
	Wed,  5 Mar 2025 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KvRhJpWL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F5F248877
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 15:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741188953; cv=none; b=P32PuNK4nXEGhFYAGh1xTPftrUMWTSi6VJkycDv0wNidJtZmdolQngv3Dlf+7J1Jxnn22PwYAnalCo/enIn+vOHQFvMu/6nj+xseFiJgyyYgkhjjzBvy9419uA9b3SmkFd1G2jPpqYWhs+HfS9MDRp4mbbvfCSL9VicHPNrweRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741188953; c=relaxed/simple;
	bh=hn+LTlEEvxgUtujMdQGt3SHhLz++LC07q8bRfVn1FIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4BdK06O5g93o5Zmg9FG2jWFUDeBuIX9I05NtVyYioaWbBuBlM25sVlc0eS6L3uTFJjD3BwJyax5+eCWn1cGWS5X7SLnElO+8u6hLnK/8xi0F4azALKAjcIggMkEwaPW2kkNFqHezGqZ5aqZ2vBtzCRYOfrvCO8ZU8a9VBtNNjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KvRhJpWL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0cQbDIAVjsRunUVMDEbYfBBpbv2ABSG1qqUzL4lPzY0=; b=KvRhJpWLNIPgt44n7cuamfIzUv
	qtQ/rsOqqd3ZIhKr2UrKyO+Hog/pRZcbcpe2GTPc0hNPNPZQw+G01JK4HPiWGQWznD9qV2L5IT97s
	soTneBlWdmeK5EQ4WbUpRpj1219TCRu/8N7Ws1VcHgooedTqFeENehf7xMKm0deAVKeA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tpqmi-002WD4-5y; Wed, 05 Mar 2025 16:35:48 +0100
Date: Wed, 5 Mar 2025 16:35:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Arinzon, David" <darinzon@amazon.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	"Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>,
	"Bshara, Saeed" <saeedb@amazon.com>,
	"Wilson, Matt" <msw@amazon.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	"Bshara, Nafea" <nafea@amazon.com>,
	"Schmeilin, Evgeny" <evgenys@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bernstein, Amit" <amitbern@amazon.com>,
	"Allen, Neil" <shayagr@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>,
	"Tabachnik, Ofir" <ofirt@amazon.com>,
	"Machnikowski, Maciek" <maciek@machnikowski.net>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: Re: [EXTERNAL] [PATCH v8 net-next 5/5] net: ena: Add PHC
 documentation
Message-ID: <be15e049-c68a-46be-be1e-55be19710d6a@lunn.ch>
References: <20250304190504.3743-1-darinzon@amazon.com>
 <20250304190504.3743-6-darinzon@amazon.com>
 <aecb8d12-805b-4592-94f3-4dbfcdcd5cff@lunn.ch>
 <a4be818e2a984c899d978130d6707f1f@amazon.com>
 <65d766e4a06bf85b9141452039f10a1d59545f76.camel@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65d766e4a06bf85b9141452039f10a1d59545f76.camel@infradead.org>

> If you read the actual code in that patch, there's a hint though.
> Because the actual process in ena_phc_enable_set() does the following:
> 
> +	ena_destroy_device(adapter, false);
> +	rc = ena_restore_device(adapter);
> 
> Is that actually tearing down the whole netdev and recreating it when
> the PHC enable is flipped?

Well Jakub said it is a pure clock, not related to the netdev. If that
is true, i don't see why this should be needed. But i've not looked at
the code...

	Andrew

   

