Return-Path: <netdev+bounces-203812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C2CAF750D
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 15:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5919F484A85
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 13:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2272E3AE0;
	Thu,  3 Jul 2025 13:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="jvP1BLrk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PWzd/NTI"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4C3B67A
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 13:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751548078; cv=none; b=EBt4t0kyfYB4fxkQE6ZeHwk2DxqnNrFx1gpsCZY4/cMY7nouC+DPrqSJWSX+q7bXa91XnLpui3ssdXD1QHviXUKCnSagfv2Rr7jNvv2KrLSCXFEpZCAn/sicISqODs1Z0Yo/T8w7EaddiIp6peaAxd5+Y96wyooxoxfv21PaUgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751548078; c=relaxed/simple;
	bh=hVh297b6pv4owa1j4OMrH2hzWwWI7/ySezh33c3r2SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7zenRh+BHiBtlQobUTtvfGR9tJxKdYOWFxWuSDmOli5knP+j08ruAEUJmQPjlrnocJwD6rWY49MuuIPoZB12bBJVpL9j6XfswhhSh28y76gDkoTSpOTvsM+Jp0gi4bHJh1CZXLyNg6miIWpRRXDXkON2B1n7YlOXtmRDBrDA/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=jvP1BLrk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PWzd/NTI; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 7395D1D00278;
	Thu,  3 Jul 2025 09:07:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 03 Jul 2025 09:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1751548074; x=
	1751634474; bh=AG2gTOnr1ac+UKze1zR8JAfxizvdjiqC6MRed58gQA8=; b=j
	vP1BLrk44qgPnKmGqORSI7gpzMwUO8peBkCLjA7/c+xHJ2i6X0IJ39qHdvJV1EKJ
	NSqfi6TQH+nmCR4IyCMnrbjdxpz8pd22fEnAASkRcaZEqQszM1TZHNQQTr3iGDmX
	mm3Dbs6d1J0k93KoaOm+s0cxlbYZV5jhM1FPHBoYsfYNt2Vyhfh5RqJ0iguqWDU3
	EKbzBznncgS6k6onRVyNFwtg4rHnEKnGswBvWtDXogNdfeTOXfg1sSznXWG2lfb2
	13ihehGpSHm6v4yI8Jdx9/jSny9pXi7PBv5AwdBYPee988KIqQgNhxY7NqGuvusE
	Q8Sz8zMLR9jlKUzTwaw7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751548074; x=1751634474; bh=AG2gTOnr1ac+UKze1zR8JAfxizvdjiqC6MR
	ed58gQA8=; b=PWzd/NTI+j7TGuuZot3kTjhcbn6FTvK1UvYQR1Lx+wsaGdWiMn5
	mbLWqnsclhtrB5jMCyci2pKU9jPh5oBwhf1VkuZBBSnHZzEQit5RceOxaro56OJz
	VZorfiihgUhaff/+jHmwDvR/r41b+KRd1Vqs5hipXzR6FfY7AHuDZy3NXc2mS03J
	f6g+lBvM4O5DAo/yEpT83tPIzwJzMxQYVwbYbs78j7AlZ0kGjqEnk1PM6Z1QKw8/
	kNHUbW9zbLd8KZj8jMsT2GO0X3K3PVzRHW9olm+wsn+LrVdOwnIEPLGBenVoH7pj
	L7oj0hZvBzKZ5G9CtFVAIAqWz8zyHJvH/Pg==
X-ME-Sender: <xms:qYBmaLgLsYimCA6oOYuuzx18CcEGceFJnt3tYtLw-h0gsjj9sVjjRA>
    <xme:qYBmaIBpf-n8WnDKO9rl_aNqOYcsmVE5yxmizojWMTs95q6TRX1rJ9XM5mjfLiVSe
    LtEPgtpkDxvpEAw6jU>
X-ME-Received: <xmr:qYBmaLFDaR0jjZIdvxXcmqLrxNQI9_VfmzJfHYfAxRORiWFaVB3AqQTV-wyh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvtdefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpedtvdfhhffhudfggedvjeeftedutddtjeetheefjedvueegffekhffgffeh
    ueduffenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhn
    vghtpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    guohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhusggr
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhhtohhnihhosehophgvnhhvphhnrd
    hnvghtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvug
    humhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvggu
    hhgrthdrtghomhdprhgtphhtthhopehrrghlfhesmhgrnhguvghlsghithdrtghomh
X-ME-Proxy: <xmx:qYBmaIREskIsJV8FgcuWuRavRJva94c37H9FQx5EeGJCbebUEnkGMA>
    <xmx:qYBmaIyIaW1fiGFVMRFxbwJnyZ9iO8zc8V2ZH2IgCmxtYoInEIQJSA>
    <xmx:qYBmaO6HkzDndphfxX-KvXO7ZcTkuoTlvwRA_2xnO9ujiaPFROkRWw>
    <xmx:qYBmaNxF9mBgiSc-zueaJOa93U2BM5cMi25ncXrZ3qAslBe2jYi1Tg>
    <xmx:qoBmaJ2E0TdBeupxkWko5oRd0h6y1xvQJYNpQCMTMzrRFGkzSbYS3YwG>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 09:07:53 -0400 (EDT)
Date: Thu, 3 Jul 2025 15:07:51 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Ralf Lici <ralf@mandelbit.com>
Subject: Re: [PATCH net 2/3] ovpn: explicitly reject netlink attr
 PEER_LOCAL_PORT in CMD_PEER_NEW/SET
Message-ID: <aGaApy-muPmgfGtR@krikkit>
References: <20250703114513.18071-1-antonio@openvpn.net>
 <20250703114513.18071-3-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250703114513.18071-3-antonio@openvpn.net>

2025-07-03, 13:45:11 +0200, Antonio Quartulli wrote:
> The OVPN_A_PEER_LOCAL_PORT is designed to be a read-only attribute
> that ovpn sends back to userspace to show the local port being used
> to talk to that specific peer.

Seems like we'd want NLA_REJECT in the nla_policy instead of
NLA_POLICY_MIN, but my quick grepping in ynl and specs doesn't show
anything like that. Donald/Jakub, does it already exist? If not, does
it seem possible to extend the specs and ynl with something like:

name: local-port
type: reject(u16)

or maybe:

name: local-port
type: u16
checks:
  reject: true

(or maybe "read-only", and I don't know if yaml tolerates
"checks:\n reject" without the ": true". we can bikeshed the syntax
later :))


> However, we forgot to reject it when parsing CMD_PEER_NEW/SET messages.

Right :( Also a bunch of others: OVPN_A_PEER_SOCKET_NETNSID, all the
packets/bytes stats.

> This is not a critical issue because the incoming value is just
> ignored, but it may fool userspace which expects some change in
> behaviour.
> 
> Explicitly error out and send back a message if OVPN_A_PEER_LOCAL_PORT
> is specified in a CMD_PEER_NEW/SET message.
> 
> Reported-by: Ralf Lici <ralf@mandelbit.com>
> Closes: https://github.com/OpenVPN/ovpn-net-next/issues/19
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>

Either way I'm ok with this patch.

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

