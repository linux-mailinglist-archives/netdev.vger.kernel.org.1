Return-Path: <netdev+bounces-177511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8982DA70695
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 17:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9577E7A15B8
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59401A5B9E;
	Tue, 25 Mar 2025 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="YxD5vfMQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s10QHe38"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCBB1B392B
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 16:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919457; cv=none; b=hBj8zMZGZnXgaWz/FYkmDH91xzFoN4Rk/UeTsTznsw9vHa6LVHOBJC8VxNH7oVHt2NIGVD7DLOBP4uokgpxJVXJZhUZ/+BqxTQoX8Ps91exq+Yqh8rN68pzjnrPeYEhTEPid3858OoAYQcHnOFI5T1fk1bW+tN3dDDBCYwE2Nbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919457; c=relaxed/simple;
	bh=karpnuxO92DbU8vhQ+W8zL5xXOdw0D2rsY+2MTeb/mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAGjP479SCnH+yAOK6P/7vShclFqvkdvRkNtr8GyzNL8yH6CxbktkHQttADUdSCD5hqgH4Mq4xEY+7+2A+5yp0cyukoD1LbolD7cLxWAp7Hq1cU5Jg5xuVIAmLMEsM2R9Mwi5rbJ3jOmNyk7cfwS3ZI08EJ1egaSxrcPmYd3OhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=YxD5vfMQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s10QHe38; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 203211382D37;
	Tue, 25 Mar 2025 12:17:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 25 Mar 2025 12:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1742919455; x=
	1743005855; bh=4AvkagMd9WGcLm92jbZj+2TIECg9pAl8P/CSSr7X/7M=; b=Y
	xD5vfMQHWcu/oat+OkAAe+NnEXbPNwneUCJP3NOSGcWuXbvkd3GaQ512Mu7eIe6k
	hjWRDhwFaT7tQMWjz7VX3aW59kqlrcI5l37p+jh9doivmgqwZONcWcbQsuOc8k0g
	9M/7KdBiJpn8nHXF/mjXn1IYvjwtpyUHO2YSsd/Qjt4SAuwf7OVA7ZpyeSdwbOyv
	uW+p8fEoeqFoC62VZXwyVGbZl8yaJvNPwsvHXynbkRaUCafK+VQff+W62Y5e0YY3
	aw4/O1u5Y0Vb1YU3Ytt3XqrBwyS6ZFtQI7mNMDQENERamn9TdmiOqkCM4rIzf/Ph
	IZ4tR0AvsZsfKMrZFrs5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742919455; x=1743005855; bh=4AvkagMd9WGcLm92jbZj+2TIECg9pAl8P/C
	SSr7X/7M=; b=s10QHe38U5kQYemSNKy40xv7uCq+/K5oRtPCRmhCejgn1JSmvEf
	aFFFYH7O1rCx0+ihJFQDZrVaJtHS0omW9sKQWosnq3BQwdKTFZnfElruQd0pt9K+
	u4JTxNCUVhf68VJWNvuWGpFHbRZe7Gklrur+GN5oDZjq4WQsSR35q0aAyTx1ksRb
	PqoUGKRkzTiQFL4+9dyi+jCaY1UBduHpgdXLP/oDomTTJutNz73pFnf4511ikPBY
	iA9aaTSM9ptsBWemqrC/VPIXUt9naKWjgJHL/AfINy6QKF9eNbe1tmwyqRthtkx3
	XI0xj2q5FYLb+nf7O3/bfjD76nvUfi8bLhg==
X-ME-Sender: <xms:HtfiZ5qUGvIRCl_uOAKXzkf80zhOKrEuCHLYBC9_a6jWnVwvIhPYZw>
    <xme:HtfiZ7q9wchP0Is6342CVTz7nkmTjKty6-EFdYXs1ham7l3kpSpeRszL41Iqh7kHY
    7c_ot0ri1hRNzqMwtA>
X-ME-Received: <xmr:HtfiZ2M8y7Vq5UbowkWew5-psEN0y3pngf3tjASbM-dNVp_lvpeY02Qbhmdy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieefudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    jeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihsh
    hnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepuefhhfffgfffhfefueeiudegtdef
    hfekgeetheegheeifffguedvuefffefgudffnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhn
    sggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprggsvg
    hnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvth
    dprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    khhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlh
    drohhrghdprhgtphhtthhopeifihhllhgvmhguvggsrhhuihhjnhdrkhgvrhhnvghlsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepughsrghhvghrnheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepnhgrthhhrghnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:HtfiZ04U8cnZHbW4Xvujo_KeBomj5ZveL_5QEh20JWLksyxNp2NZMA>
    <xmx:HtfiZ459DywPKTILImF_vkN7hlIJVH97QK5aO-SK8yYf4TMSHi9E2A>
    <xmx:HtfiZ8ilNBHl2rm68wugHO5JtyBH787YRDBwaH0osXeILKo4bm1DnA>
    <xmx:HtfiZ67XWVdMsy-yjKgZK80MXiVl0u2-asjpq8WUpiOb5gr5m4tT8Q>
    <xmx:H9fiZ5Hky7ipJOqf0EewnHRqxL804rEBeUSFNzk5Ed7DB3BoDg9EK0Gx>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 12:17:34 -0400 (EDT)
Date: Tue, 25 Mar 2025 17:17:32 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH net-next v2 4/5] udp_tunnel: avoid inconsistent local
 variables usage
Message-ID: <Z-LXHKBKbW3NyOv1@krikkit>
References: <cover.1742557254.git.pabeni@redhat.com>
 <0d33ffb4f809093d56f3ebdffd599050136f316a.1742557254.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0d33ffb4f809093d56f3ebdffd599050136f316a.1742557254.git.pabeni@redhat.com>

2025-03-21, 12:52:55 +0100, Paolo Abeni wrote:
> In setup_udp_tunnel_sock() 'sk' and 'sock->sk' are alias. The code
> I introduced there uses alternatively both variables, for no good
> reasons.
> 
> Stick to 'sk' usage, to be consistent with the prior code.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

