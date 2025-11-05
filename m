Return-Path: <netdev+bounces-235910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2794C37285
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 18:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D861366732E
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 17:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F09345CD4;
	Wed,  5 Nov 2025 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="19e4sJuY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SMd+CvQg"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967DD335579
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 17:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362015; cv=none; b=j2xW37fJlbMzgFoZcDtG9bHQavu52Qac/r3EtOBmlRyO3wVE51B04+zKqOtacNyDHtja3xm92QxiLjjwVjU8hJlpPDFc3wDKFekiydvZoIr6awIEQ4VKbgI8xAM78pWAr3xM4mk0hYLCy/fKWkL1Sh/L36YjUpk0daXOjpfA5c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362015; c=relaxed/simple;
	bh=zPdznhTge+PgGtBqOKvsAocZq3Z6m2N20URPcRYojZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iic4Pt8k7PDR8Jy5bcrvIxoyop4VwCTiU4AfLlm855uHg+Z4lXu3JAZz+ZffmJiht2kPzgFNLvZOTyJOV+vq2SjjSW4Aw1LyP0GbdIrqeo/+u42Uaaap+DGxr+SqnO87q8Sui6uvOD4toAlVAMmu+RY7Q5k10O7buzxCYRb8E5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=19e4sJuY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SMd+CvQg; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 41C201D0019F;
	Wed,  5 Nov 2025 12:00:10 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 05 Nov 2025 12:00:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1762362010; x=
	1762448410; bh=VX78VuQnvam3rOplEeE9vVZPoR4/HSPkHCJZW2Ri2qA=; b=1
	9e4sJuYyhho0AcDAN7OiE089UgYem5ZEBX5l+NRtLyePPavjmzS6INfq1dzp0M5N
	zlCinT2EyJgDn1En/3C2U92Ejg4VrU4pEigD8AfwDXd6XHL77OlUgoasQkEI3WoF
	bfTVY66j7cDvQCShVmBie71YoH+xGH+FsqiDxZyC7FPlifKv2MuPiuZ6aP/5vNrc
	ug3dpvs5WWYULtBiXSK8X6+dqJJhZBg6iSzRZDG/KczoB1eFR+H1qzxQG/xZ8ue0
	VpyWZkYdoD5z6icOqn1CMig8XcsqjhqJtA20NjbOD3CiDksiaQ3pxzfrBM3o7z0u
	pDdVBbNI1Y8aMJ0nUXwJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762362010; x=1762448410; bh=VX78VuQnvam3rOplEeE9vVZPoR4/HSPkHCJ
	ZW2Ri2qA=; b=SMd+CvQgcf4k1UDfP80+0KK172/5Hd1C2Si+pfZWCOJrH8jahuR
	r5Xb/HNc8r7fhkRNNipgU5zKdeH53Eup5QqovR8bGFGa+35AhomFpkNHslgBmYAJ
	m3YX/4s/kdPM3bQsb9cQ+hWLi1Zo3tsUeQRrALNxLk4uewll+uGtNl5wk3bU5PF8
	V9Qhxz11VUk/z2d8QHnvwzTyr/vJRe4eCtEHTsWCSF+Zh6dyAoQsJubI3QV0rIk0
	PC5CXJlL2rpfLdZhbW0RMdXkOABL329cgOqfAf+oJ+ssUODfdLsJWVy6BLqyRxjQ
	U5HP1u+jWX+WObyvJO1/mvR77DOtGjvlajw==
X-ME-Sender: <xms:mYILaQ4j6vJS_uixXj8md8oSALqM3tRBBdO0TPnKUfke0YpesLMhjw>
    <xme:mYILaeQA-H6H9Th3eSHNDz_JnBS85UIiyjqMxMnksDbNLaxJip2pYDI0zmr4ICa1c
    t_ua8llbMiaxhkGgSaLbs9qG7yU9JcP8mF8DF-lABwuZcrSXo3jrq0>
X-ME-Received: <xmr:mYILaT7KUK20bn6KbwyKSPnJBqq8zmLS5bm6PGBO47n3lm9bBAhIgz0Jn0rI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeeggeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduhedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhiuhhhrghnghgsihhnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepughonhgrlhgurdhhuhhnthgvrhesghhmrghilhdrtghomhdprhgtphhtth
    hopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgv
    mhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehh
    ohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjshhtrghntggvkhesrhgvug
    hhrghtrdgtohhm
X-ME-Proxy: <xmx:mYILaTTldh1y4ssaTWX6rc_wHcFDNSdohFa6BrV9MiW1Z1gwAxGh_A>
    <xmx:mYILaQnvQm6f45MO0FEjHkrHdHYj44h_jgiBcmZvHQP5lNyvVY7GwA>
    <xmx:mYILafQA9Voef3j8EvzLucS_A-GHI8hta_HvUAEELvT_HKMZfux0DQ>
    <xmx:mYILafukR-YmK8ANHoxU-Hyik_87RdYJtAdON-2yRlZgdJz44Wpxtg>
    <xmx:moILaf22OBTAw4bidh2A6ABZz-buWSKUMmDvy2g9MJ05YqSEbcTMRH7A>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 12:00:08 -0500 (EST)
Date: Wed, 5 Nov 2025 18:00:06 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jan Stancek <jstancek@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCHv2 net-next 3/3] tools: ynl: add YNL test framework
Message-ID: <aQuClqhaV-GiBxFZ@krikkit>
References: <20251105082841.165212-1-liuhangbin@gmail.com>
 <20251105082841.165212-4-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251105082841.165212-4-liuhangbin@gmail.com>

2025-11-05, 08:28:41 +0000, Hangbin Liu wrote:
> +setup() {
> +	if ! modprobe netdevsim &>/dev/null; then
> +		echo "SKIP: all YNL CLI tests (netdevsim module not available)"

Can we maybe find a way to try to load the module and still run the
test if modprobe fails but netdevsim is built-in? I usually do my
testing in VMs with kernels where everything I need is built in, so I
don't do "make modules_install" and "modprobe netdevsim" fails even if
netdevsim is actually available (because it's built in).

For some modules it may be difficult, for netdevsim we could just run
modprobe (but ignore its return value) and check if
/sys/bus/netdevsim/new_device exists to decide if we need to skip the
tests?


Or do we only expect selftests/those new tests to run with the
standard net selftests config, and not with custom configs that also
provide all the required features?

-- 
Sabrina

