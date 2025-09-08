Return-Path: <netdev+bounces-220843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25EABB490EC
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 16:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297D2188EBC0
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 14:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A6C222568;
	Mon,  8 Sep 2025 14:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="L54thWEY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BnD7ztQz"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E8D3081AC
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 14:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340781; cv=none; b=huRd84fTuOS4uWN+q+w48p1Znxt60fi8u/6jKdVmAXTRnjuULo92Ql4yMqPyW043BMFvzZSQr5azft6U+l0B0eNUergIAQNJ6zMlBJ5gqk97lA5p9WZ0qhZT5WWDTCMo6r+MOacPF7ga6zbiyU8Pz5zlsCzIa/zJIrrTZjCDLug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340781; c=relaxed/simple;
	bh=4XgXqp9p1yKWy7A+O6Vc1YTYk1dYX40/dD4C/EBeheI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IumlOv/hZvySbvqdPwKvCoo+2QTMDwbcgG9l+Zz3Q4FzI5/065Qe4k5PXkr0sJf9TPZV3ZnEbwhLBGY8H1Pn4Ly3TL7UjRbNjSVFaSdEHzQIc3htNhJXH0ru5jLVUkoLSeaWBbtjbbiBYMQCByIL9kKx3C2+NFzdb+Kv0icHmQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=L54thWEY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BnD7ztQz; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0ACBE7A0029;
	Mon,  8 Sep 2025 10:12:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 08 Sep 2025 10:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1757340777; x=
	1757427177; bh=WAZW71TH+73r/7TXs46nfxBqNlhFMfqX5lIu0v+M4dY=; b=L
	54thWEY1gIvupO7zKsFT1or4z/5aL9LviFCq/OmGMmn6BQszMVNVvCuE1bEAoz1c
	qQ56n+PBqAfpxuqumIj3AXx7GCNZVkQrQ28qsUuIfpj7Vtzbrm6MP78zb34s0vP3
	YLeuq+14HV0RIz1wUBfcviMcbOJMgKMQ+xW71KaWJCj3eRHWTrAi7ThWRr3BRypW
	XgkXUdqrUa14NaEBaK/vZCRSjA9GMLAa95QGQuT7wiA1QV3O/AzaXrrTdlOso1RD
	k5qM2ck4F8qvkyfv6R2dqJelPJPSvcymZXsTQpDX240l+Z9XUhTjEgifR0GtjlWs
	8K3h4SO/xdIgVhlgeFx8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757340777; x=1757427177; bh=WAZW71TH+73r/7TXs46nfxBqNlhFMfqX5lI
	u0v+M4dY=; b=BnD7ztQzDmEVujVnpBexlGfBMvrG5dhKZ+WvWufodw2mt76sqtn
	6au4sx4422L6wHY1lAscfInZhk3PNAIvuyYh+UgW3lRGj5nTw6GHcxBG3UkWf+ao
	J3ay5P2ozft3pUti1BHfftj507Ho64NVZW3O/PMwxTET3ASG1BGQiePceKbXp+lD
	7Qn8d/HKM8cDxq2wMX0LOnu6CDgOFIN2firxmgooqKI2bS9rETdQJI7QyHMQQU/M
	4wmLOhbD2BkpPG3yyj07gkY2CWMS5rSlgkGa3z6h6+/ZVIcPfYF+t3fTJYgOcC4z
	NxWXWHds6nxLvMfXIXFPTw7iqCgYlC9UNUw==
X-ME-Sender: <xms:aeS-aFZ2IrG731heKXjIXd_w2MEr6x24Ls0CjLonjxi_33RLMqnwkQ>
    <xme:aeS-aMFowJbv33kHjkEYQGElJzjP1orLD8Gd3vfXGmQopwNjbUSjGjyg05X6zjkC5
    OtBDuUqHA5sQGfOiL0>
X-ME-Received: <xmr:aeS-aDmGbmBR90ttzKguXVJ1zeF1d787clRcYi-whIwEiouiqM0q-S8oufKE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffef
    gfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepuddupdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthho
    pehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhh
    grthdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphht
    thhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrghmihgvrd
    gsrghinhgsrhhiughgvgesghhmrghilhdrtghomhdprhgtphhtthhopehrrgifrghlrdgr
    sghhihhshhgvkhelvdesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:aeS-aPefgH07P7MMZzuOzFZeuLfHdhrsoPDrtZIpfJVxGIXiD6augw>
    <xmx:aeS-aBHZFKALMWB4PQcQcZ4_IWZHgRGgyeqW8k7j4RkKGGqSgocVVw>
    <xmx:aeS-aFjNXI3sJY994mtfxiETC6JwsRxVbAEv-tjgD9pgiUG7qRmfAQ>
    <xmx:aeS-aF3pUetNku2mn92QMfeevnAbcLZLPhog3w1nTLQl-TwHTWbCPw>
    <xmx:aeS-aG_5KDgm3tf8mcQ_Y4HmrnwUa18HTKHOqXzxqlFpAIerIJ28_l2c>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 10:12:56 -0400 (EDT)
Date: Mon, 8 Sep 2025 16:12:55 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Jamie Bainbridge <jamie.bainbridge@gmail.com>,
	Abhishek Rawal <rawal.abhishek92@gmail.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH v2 net-next 8/9] xfrm: snmp: do not use SNMP_MIB_SENTINEL
 anymore
Message-ID: <aL7kZ8ox2C3kr817@krikkit>
References: <20250905165813.1470708-1-edumazet@google.com>
 <20250905165813.1470708-9-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250905165813.1470708-9-edumazet@google.com>

2025-09-05, 16:58:12 +0000, Eric Dumazet wrote:
> Use ARRAY_SIZE(), so that we know the limit at compile time.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Steffen Klassert <steffen.klassert@secunet.com>
> ---
>  net/xfrm/xfrm_proc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

