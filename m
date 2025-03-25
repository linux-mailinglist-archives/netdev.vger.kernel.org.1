Return-Path: <netdev+bounces-177516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B05A706BE
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 17:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958C61775F4
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A9D254B09;
	Tue, 25 Mar 2025 16:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="dsyMFzVF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IFbHNYbz"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37389259C8D
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 16:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919785; cv=none; b=EijPJoFWHA00ItB9xn+NUXOBpSPLl5hePF54g/zwVxOxKGP9PBODThNXf+5JjjpPv/iK0PB+3aDlfXTij4MSbC9RHQvSN3s0bA8pjTBqHSWdoTCWoA2mxnCUKxKAa5FQqxMBwkSKsJX2DLQBQpSrJczcqWSrBGqtAj9sc5ZSKs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919785; c=relaxed/simple;
	bh=gg60+IlyDnt3FNn1KjQCXaYLS1I//w//ekBNznU0i+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cr1dfufoGsJ1P728y32mulj8dKbCLgxsf//qvw9zhbEVmuCvX2LoJZPUWRPG35tZwWiuXpaGwdxhbQ9bMYEMycuZnhrZNSDQuhbjDcu9YgXtF4WF4Dd6gqcloU3J6flcGQ0c1LJZZIhP0TZpR5P/Ll6FYEhMwzwpKrTcGOVa34I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=dsyMFzVF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IFbHNYbz; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 0E0FB1382D55;
	Tue, 25 Mar 2025 12:23:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 25 Mar 2025 12:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1742919782; x=
	1743006182; bh=CbrCKZyF+0kENTKTGDCZQITuFNLacstY9TrvrKCECE8=; b=d
	syMFzVFztscS/qLtQGZAypvqHGgBiktxlwDiYbg3VTmwfOjmSwjy+dTaUXkHELG1
	IBuTzXUrGawBwUgqD7ZZf88kaDRp9t+AKJawUJTFaFDwT+sZceAaDKvjzcUrSI7f
	u/gI1RrqLU7a7FVuzmrnH0/KokPmBKzPHR5pn9JQ+Rdj8+Zi5UAsELOr7yp45E1T
	T67E4K4OFJ2AqeZc994LUsX6f8GwfDEV6h760KWFb/R59r+mT4ICBJo+6Hi24NM5
	5rkI2pEXahq+7BwuktUZ3CRbEUY+PXIoiN8Cj5Tbwj+1o6ZEebLB/Y6vOEgh8LQj
	8UaB2IZA9m6OgQ1uXs3sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742919782; x=1743006182; bh=CbrCKZyF+0kENTKTGDCZQITuFNLacstY9Tr
	vrKCECE8=; b=IFbHNYbzU3+Q6V8v9a9gT0R0EuceVgfDR9HD2SqkLp5igAQ4zt+
	eBctwJ/dAZrpNSOvcHahcuGYL5gS74XujnOo39WFUbqVQDZEUYvkaUX9ON8SOCGJ
	sUoapic4GY6HN0gG9yafHbY15/YGfTdYR78jM1KOUd9sLmpsanyWd8uYPUKCUJAN
	q82QXT3nUNWp417Z0aASbZhpM0iZtn05x8aOeNz2bnnXsovYdEeOHZrMBOfjNQwX
	UsW0WYKctJeH4uPmhP1CrxyeIhGTTYz7kZLn4sWKOFSeWJobfy7l2s19RVqkNYKd
	/bkek6ItU6zhlaGpbwAizgp2a09UoyPbzgw==
X-ME-Sender: <xms:ZdjiZ7iNS38vt4j436tzsPV85MQCRPLioxFcAl9FCAMRta7AyG4I2w>
    <xme:ZdjiZ4DDFJKSycqDydWRL55pj0mqZVUDv7OkYKEkrm6bFdWoWZsBtLtbtiHML_e2u
    FgSarYNfxCApsVHTMI>
X-ME-Received: <xmr:ZdjiZ7GV3Au7u4K_4RdACU3cP-lDpMhxjij0XA4cDnBnEH4WDjh1QGNZnltT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieefuddvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:ZdjiZ4QueP1QBqdfZ42OspD32VUpSc_FWZ-GatQm7i8dRn85u7UvZw>
    <xmx:ZdjiZ4wq6nsX9IfovPdEEcgOZ4o8O8dBGLQDMdoQxF-FjkqW7b2-9Q>
    <xmx:ZdjiZ-6B5EaSK2cO3gIVPkTpm0asHKl0WVDeDM1rvq51Chm-DH9BVw>
    <xmx:ZdjiZ9y3DBpx8YP3TJtEOwOwGk1FuYqB8M6n3uwgD0qIkLceqfKhfQ>
    <xmx:ZtjiZ0f4xfxJbxe07Sz3AiHKPCCRbC3N5KAsfvn8gVE-I710aumuwDVX>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 12:23:01 -0400 (EDT)
Date: Tue, 25 Mar 2025 17:22:59 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH net-next v2 5/5] udp_tunnel: prevent GRO lookup
 optimization for user-space sockets
Message-ID: <Z-LYY6xdo4XxFEB6@krikkit>
References: <cover.1742557254.git.pabeni@redhat.com>
 <e22492f139a67c34c639737cc54b3a57a8c78ef3.1742557254.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e22492f139a67c34c639737cc54b3a57a8c78ef3.1742557254.git.pabeni@redhat.com>

2025-03-21, 12:52:56 +0100, Paolo Abeni wrote:
> UDP tunnel sockets owned by the kernel are never disconnected/rebound
> after setup_udp_tunnel_sock(), but sockets owned by the user-space could
> go through such changes after being matching the criteria to enable
> the GRO lookup optimization, breaking them.
> 
> Explicitly prevent user-space owned sockets from leveraging such
> optimization.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

