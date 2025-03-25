Return-Path: <netdev+bounces-177348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8222CA6FAD6
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 13:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D8F3A628D
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 12:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162E3254B1B;
	Tue, 25 Mar 2025 12:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="HcNUhYj+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UO9vB2bh"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC11D255E40
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 12:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742904809; cv=none; b=QRpFtRMFKJ4ujVMTGvNMvqIKLN1NmdDk/uwcAYSCefG39JMyB8r9rNOjKNNsbNIe4fiQmd965mGJxfNSa/MNDYikov0pntEgpEKLmhI4OLr0MH1u1jollqNWe4rwZpVghv6J7kd4lw/FFQ6wqHZLoQ0OqJQ5Fsjc8LGtvTmGuR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742904809; c=relaxed/simple;
	bh=BKTozao8GZc+UZok2CGM3Q2kN0R71PdtG9BtRt+Z8bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZ1yT71x/e5csU4+fTH/zYwnk7APOPgNhjAvHUZ5UXIpVhwrtfLeEHmMZtMaMzPSAExD6khmGhTyXj4vCWrBL4SYOnny4uDuSREmzrKxHPt+eeSoCMyVauaBjPCb2WQUZxNlbj/w4RG81B0eWKJq2HRIif27CMIIBconKKsayJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=HcNUhYj+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UO9vB2bh; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5339411400FC;
	Tue, 25 Mar 2025 08:12:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 25 Mar 2025 08:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1742904755; x=
	1742991155; bh=ck5OhvMMt4irGrWpXsOw+SumFavrLUenbqs6aMCgdUQ=; b=H
	cNUhYj+qzoQ30Q6MsANPMaVSwFEaLyZ/qp/8zRjx1gjxqYCldCF0dv2iwZkjQpDk
	mwYl3HMnH9CNfnI9GbuHX6E1G9PdVw2N+L6PgvHABlkKOIp8D61Ysf+vVNOtgVyS
	LT/s8KrkcbVJCpbw+uIcW0+hKAwHI0yh147rNJhCrpIXsUHtJph+Orcw+mhx6Kqh
	m/6d78oraVmIfczzfTgehQEJH+vPqXXKCKypkkw3WLzI3O5DkPF3aPOi/vyRgLJh
	+kapGjLf/o8rlLU0D0V/aCuOjRwRMgn7Q5yHDQnDq48TbP9b9DZ2kiPeZ3trAJMl
	lYJaK7DjC9D6poUUTxeSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742904755; x=1742991155; bh=ck5OhvMMt4irGrWpXsOw+SumFavrLUenbqs
	6aMCgdUQ=; b=UO9vB2bh9Ao2+6YzO1jeS86c5TgLf0vHFabg5yoTPZRMykPPc6u
	SFmPDfJ24i0DNqhb8VIhY2Fi0RDYIe2JQUPRjA0tCtOJ5wSR34eyUL9WPNOpGf9p
	+GTxfazvHpYxraVnniFAUhYvC3IJBRbJhNhKPCjqx8+0ZZyoeFswDorFH9L6iWDl
	ik45Urnic7xLa7Eef3wCRtqm0wqSej/s11VLbpO7H0XDyGaX2zokPfnbApUxQvhL
	V/MaluPOY0g1S17eENKjhG7ZTBw8pZXIWo5k9jB+4GB5uo+UXmU2nnGF0xgHZHch
	GoFFQxuQkif/dIsFS5gUu5QHNFxDxwBt8Mg==
X-ME-Sender: <xms:sp3iZ_-bc2XaPnMcnbv45WhaV2pwoC08dbxXXlm5ydTIBe0kcvv58A>
    <xme:sp3iZ7uhaklfQf8b0Ne-k0hR26Zyj_axZw3vFZr8P_HtjRCKGT_AvLv0uYb3zWSz1
    xWd3-BuBByE_ysuZnw>
X-ME-Received: <xmr:sp3iZ9A2eUlaikNXIE3AKlcz5BOb9NLZHBGc8A-lKryCyJrSDAFGJmgoUfFC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedviedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    jeenucfhrhhomhepufgrsghrihhnrgcuffhusghrohgtrgcuoehsugesqhhuvggrshihsh
    hnrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhephffggeeivedthffgudffveegheeg
    vedvteetvedvieffuddvleeuueegueeggeehnecuffhomhgrihhnpehshiiikhgrlhhlvg
    hrrdgrphhpshhpohhtrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtph
    htthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprggsvghnihesrhgv
    ughhrghtrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphht
    thhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopeifihhllhgvmhguvggsrhhuihhjnhdrkhgvrhhnvghlsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepughsrghhvghrnheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepnhgrthhhrghnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:s53iZ7eiflxk6um2p7jdwFZFaCD-hXeetBxv5ocscEBxyIstGceiWA>
    <xmx:s53iZ0N2ExdwGxni_XNWqCc8uOYxqV9ZB-SsYSlSmXf7qL4X-mWpNg>
    <xmx:s53iZ9koNPAZEWAA5HF3AEt1EWZ2UfbCBZ2WhwWmFz_DUrdk6Fk6aQ>
    <xmx:s53iZ-vrkWsu92aLe6SNLzHTBsLxNZapuc5ex1izqHKpEGIbPuRy0w>
    <xmx:s53iZzrfbfF4AGIJC8bsdjl5CfSDjrfqC074yZpew8s8IFiSoQ7nYCff>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 08:12:34 -0400 (EDT)
Date: Tue, 25 Mar 2025 13:12:32 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH net-next v2 1/5] udp_tunnel: properly deal with xfrm gro
 encap.
Message-ID: <Z-KdsLBF9lCM1m34@krikkit>
References: <cover.1742557254.git.pabeni@redhat.com>
 <f4659f17b136eaec554d8678de0034c3578580c1.1742557254.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f4659f17b136eaec554d8678de0034c3578580c1.1742557254.git.pabeni@redhat.com>

2025-03-21, 12:52:52 +0100, Paolo Abeni wrote:
> The blamed commit below does not take in account that xfrm
> can enable GRO over UDP encapsulation without going through
> setup_udp_tunnel_sock().
> 
> At deletion time such socket will still go through
> udp_tunnel_cleanup_gro(), and the failed GRO type lookup will
> trigger the reported warning.
> 
> Add the GRO accounting for XFRM tunnel when GRO is enabled, and
> adjust the known gro types accordingly.
> 
> Note that we can't use setup_udp_tunnel_sock() here, as the xfrm
> tunnel setup can be "incremental" - e.g. the encapsulation is created
> first and GRO is enabled later.
> 
> Also we can not allow GRO sk lookup optimization for XFRM tunnels, as
> the socket could match the selection criteria at enable time, and
> later on the user-space could disconnect/bind it breaking such
> criteria.
> 
> Reported-by: syzbot+8c469a2260132cd095c1@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=8c469a2260132cd095c1
> Fixes: 311b36574ceac ("udp_tunnel: use static call for GRO hooks when possible")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
>  - do proper account for xfrm, retain the warning
> ---
>  net/ipv4/udp.c         | 5 +++++
>  net/ipv4/udp_offload.c | 4 +++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index db606f7e41638..79efbf465fb04 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2903,10 +2903,15 @@ static void set_xfrm_gro_udp_encap_rcv(__u16 encap_type, unsigned short family,
>  {
>  #ifdef CONFIG_XFRM
>  	if (udp_test_bit(GRO_ENABLED, sk) && encap_type == UDP_ENCAP_ESPINUDP) {
> +		bool old_enabled = !!udp_sk(sk)->gro_receive;
> +
>  		if (family == AF_INET)
>  			WRITE_ONCE(udp_sk(sk)->gro_receive, xfrm4_gro_udp_encap_rcv);
>  		else if (IS_ENABLED(CONFIG_IPV6) && family == AF_INET6)
>  			WRITE_ONCE(udp_sk(sk)->gro_receive, ipv6_stub->xfrm6_gro_udp_encap_rcv);
> +
> +		if (!old_enabled && udp_sk(sk)->gro_receive)
> +			udp_tunnel_update_gro_rcv(sk, true);

We're not under any lock at this point, so this is a bit racy. I think
we'll "only" end up leaking a ref on cur->count if this happens. Not
ideal, but much better than the current situation.

>  	}
>  #endif
>  }
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index 088aa8cb8ac0c..02365b818f1af 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -37,9 +37,11 @@ struct udp_tunnel_type_entry {
>  	refcount_t count;
>  };
>  
> +/* vxlan, fou and xfrm have 2 different gro_receive hooks each */
>  #define UDP_MAX_TUNNEL_TYPES (IS_ENABLED(CONFIG_GENEVE) + \
>  			      IS_ENABLED(CONFIG_VXLAN) * 2 + \
> -			      IS_ENABLED(CONFIG_NET_FOU) * 2)
> +			      IS_ENABLED(CONFIG_NET_FOU) * 2 + \
> +			      IS_ENABLED(CONFIG_XFRM) * 2)
>  
>  DEFINE_STATIC_CALL(udp_tunnel_gro_rcv, dummy_gro_rcv);
>  static DEFINE_STATIC_KEY_FALSE(udp_tunnel_static_call);
> -- 
> 2.48.1
> 
> 

-- 
Sabrina

