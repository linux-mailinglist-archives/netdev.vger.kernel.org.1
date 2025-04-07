Return-Path: <netdev+bounces-179532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1955CA7D7E2
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 10:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 413613AEE55
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 08:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB65F211A33;
	Mon,  7 Apr 2025 08:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RPbgpXco"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39634226D1E
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 08:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744014615; cv=none; b=u9HjASYEPD2nPXVjYjcfgl1zyGERQldp8oETZIb9VNFKkE9B02fn/fSPKORdPENPVBgYgZ7mRBVx8vE5xTuDWbOoVIDbZu7uwwSN2Mmax1x4uCR5vLKLW0YHkD33vdcLoq1oeWMWYdIWYbCyVRfLGM9KpoAFWz/m5nBnMBqdZs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744014615; c=relaxed/simple;
	bh=NdxrZpkoAS5JiWYgZz3H6UVBi+3AhclDMA55q0fjY8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8iUC9Dg5dMWV0kA7ek6B+xEc5KsEhcuGWMPio2kDsohyaunvRmK5gVJnMtSZv3HnHjyS4n8F/9sXF+5KAyK828jUIPAMh97jDt1k/N1SJ1Tq7mJ28dfe08qlX0yDt3MElxue94FnaVVPeNVIOyGZHGFE5FaGdBvu4fQvWSd40k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RPbgpXco; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 342A91380228;
	Mon,  7 Apr 2025 04:30:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 07 Apr 2025 04:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744014613; x=1744101013; bh=SyWehjHb8zpXeJ45viskigR9BtioaZba5Zg
	A+Lsdhxg=; b=RPbgpXcoQMgTtWqOiV//r6KxMBrhuOw3Cslw11T89Cicmfsl5m+
	l723C5GdJlMN3CMAXQQAml/xR2wWtigHeoGCoAgSkCfB/nrkR/gRpv7DkVM1007i
	CDS8criM0ojxh7rQJAFX9oaJA6+uCv7oKdT5YbH+GenTbfRForm0Hkbkx8OA7t9g
	a/TKOEGNYDDNOrlIOoUljOLzdcY1x1sPWJj5GnexixoRGsOPuCM5lJOvLa4kK+Dh
	7XjajbyUIn6AJt1PJ4E63BSCj6DtKKeG/FAkKPRHyKJBmSE23LE1gktq23/AF/hT
	vXdgOWVSy1n0Q1GoE/Qe8E3zPMntJWSJv0w==
X-ME-Sender: <xms:FI3zZ18U1Ke5vixfd1ZgttVZ_6Z7IPbeKc6lPoVA54VS7JVjAyc3rg>
    <xme:FI3zZ5siJHF_bZ0tqdPsJz9FyegM4afHnvlYWYwNcbbhfl_G3OZG-NtHpE9sSjCNI
    Ntoosjf1ehGOVg>
X-ME-Received: <xmr:FI3zZzBWvuuIkiM_IcbYzmS2jkI_R9yG5kPOoLuozCiljOhclP2p-z-6YUya>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleeljeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthh
    drohhrgheqnecuggftrfgrthhtvghrnhephefhtdejvdeiffefudduvdffgeetieeigeeu
    gfduffdvffdtfeehieejtdfhjeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgt
    hhesihguohhstghhrdhorhhgpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhgpdhrtghpthht
    ohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrih
    gughgvsehlihhsthhsrdhlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphht
    thhopehrohhophgrsehnvhhiughirgdrtghomhdprhgtphhtthhopehiughoshgthhesnh
    hvihguihgrrdgtohhmpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhplhhu
    mhgsvghrrdhorhhgpdhrtghpthhtohepughsrghhvghrnheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:FI3zZ5c-nbqP8GJ2V7xC96KeEyKj0nBYfONH3D0AB_jQWiesWLci0w>
    <xmx:FI3zZ6MUp5yPeUR2hzj2S_ignBk8rwR_JLkMMouNp2c-L7rgpQ4Emg>
    <xmx:FI3zZ7nX2LCavDzzcUTh4F94_T8lDd0H_CKVQpdjm6KRw0rSgYWMiA>
    <xmx:FI3zZ0uhTd1Yqp-0zfCfyea35WUkQI1-MeJoP6vo6_hm4mZp-dewgw>
    <xmx:FY3zZ1O-3RE8nTU9Um103Lb92qmzGra_ZhwjtgOldYXjcQIAp45k_Cu2>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 04:30:11 -0400 (EDT)
Date: Mon, 7 Apr 2025 11:30:10 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org,
	Roopa Prabhu <roopa@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH iproute2] MAINTAINERS: update bridge entry
Message-ID: <Z_ONEvPRjiAgRRY9@shredder>
References: <20250405102504.219970-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250405102504.219970-1-razor@blackwall.org>

On Sat, Apr 05, 2025 at 01:25:04PM +0300, Nikolay Aleksandrov wrote:
> Sync with the kernel and update the bridge entry with the current bridge
> maintainers. Roopa decided to withdraw and Ido has agreed to step in.
> 
> Link: https://lore.kernel.org/netdev/20250314100631.40999-1-razor@blackwall.org/
> CC: Roopa Prabhu <roopa@nvidia.com>
> CC: Ido Schimmel <idosch@nvidia.com>
> CC: Stephen Hemminger <stephen@networkplumber.org>
> CC: David Ahern <dsahern@kernel.org>
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

