Return-Path: <netdev+bounces-262111-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPYUHdDPomnW5gQAu9opvQ
	(envelope-from <netdev+bounces-262111-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 12:21:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A44061C2892
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 12:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C65A302A041
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 11:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA1242DFF5;
	Sat, 28 Feb 2026 11:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="aTMahbfv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ODGZRcly"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB2642B754
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772277709; cv=none; b=KDQ/o+J9yF+Nz4OhGj5MnMX1z8pBfLpNo7ByWdP2MMCONZemF7U8YmdGPXPscBy4gcl3WIbPg9lHyhTu8xx2ETtTTWrObK0p+5lEhV5c5mpzNTDHcy7cTIoBxfMZGCI9pYiiL6a7TwEwgmyfDoDJvPUHpyC8XHPCztvC0tD9DfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772277709; c=relaxed/simple;
	bh=4NJsdHpJv2GquJS2OgvsvP46KG2uKuws/+rrvdkYpD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJBr9z/3pux5D9uW5hoOAdmVItoP+h1VBROa/rynYuXqpFoq1baAEK12Ou1i8CUEvCxk7eCFsDptzf8lh9bWr9d+uVhfKSz6WzUTncrCNQS9FeTi/6FhGgwvxQ0H1ikkrUiJr6BJPI65QNDfwNif102yXcuAJV5tdSmxr8swIVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=aTMahbfv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ODGZRcly; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2553A140023C;
	Sat, 28 Feb 2026 06:21:45 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Sat, 28 Feb 2026 06:21:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1772277705; x=
	1772364105; bh=VISe9Tv/YRlfokLkRlMZQjenaMOhaY27e0QOreiDsoA=; b=a
	TMahbfv3J50fuJFxPs1cq2Rweztwd8JXPsDDjGfj7TP4/MIoJtYJ+XDK+hdB5INf
	4YEMi8oP1YQP2X3t+5kqlGJW7x19nQaAxvhGwe+XKN/oCrMjQJapRvBpbPU7Piga
	Vg7q5TdCvteNdDctGjI4e3IS3gRidvhDSlTo57hJ/jmzI++6sPVehBYEoUd/YRBW
	16xwEHzfCR5wQg6F6D+cYRkXlNvGqAdSigTHmvk/axfXer3iPk1kYEUdkaBNJzbI
	p5/axyJy58T6NCVStMB6zSh4xHdTYpL7taokGyeqATDRqr0bxPiWKiZTe+3c0T1O
	J+KOp64H8R17ROwrtH1cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772277705; x=1772364105; bh=VISe9Tv/YRlfokLkRlMZQjenaMOhaY27e0Q
	OreiDsoA=; b=ODGZRcly2WDiAvuO1d8lI22nKdf+AyjkIFj9ka5hwi1YhD1QV2X
	tiye6u1ZpBxv1gMTbtHgbzNPXjrCsskIrvmSf3IIHZH1rTS7BqRPNtXuYApp15xj
	65PSfD/08UPgg2btLnRNUGQcGO98TviIW3j8DcW4FJnxiK89GmsGUj901swiYW9y
	mnQgEFZvuTAxpniqKt59+qwZjY58dCKuGGMqfxtDlbxQDApIDWszQlD/1vniRS4f
	GrYnAicfCirjbA/yo45VCqpIF2cLRzXE1Mk4d5+rsIumRtIYjpCLVqq3Urw0TraU
	h3ld9qVhWou4/6DXHkOgRxtyjt4H7hxEp4w==
X-ME-Sender: <xms:yM-iaYCcvGoIBe7Lr4wbS69wgzGUI5zo5wFrT9md-NIWPVTT04422w>
    <xme:yM-iaZmdUrsJoW5XMyD-I4aG0PUoXEketnzal5st80sVXUkSTzlXuxMs6sJRNS0N4
    Lt2Lic8rs3gK1lb6v7oDmGII3JX10N9py8TRLDiyNEUKnbFjP0Kh9g>
X-ME-Received: <xmr:yM-iaRxOXYbR38uCK9RnLpyI2-ZpskF4fQLO7O0LTexo1BvIazZJcbjMluaF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvhedujeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegtrhgrthhiuhesnhhvihguihgrrdgtohhmpd
    hrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvg
    hmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohho
    ghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeguthgrthhulhgv
    rgesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:yM-iabSHoMihXENIi9POM9C1Vy9jhl8Quc34yJeQnoxpagJPevExSQ>
    <xmx:yM-iaR8OdABYFNGgj4LidAjtmnqk5AlBxdHxU9tm5-FqUwLlk7eKZA>
    <xmx:yM-iaRvbZT2CKpqDzI6gQO9aNXf8CNBEX_LV-EV86mvN7tM0B2mf-A>
    <xmx:yM-iaRPd35BI7bRF6TNz9plb4n2Ce3VtSgofZD9tl0fjpk3OhOTJpA>
    <xmx:yc-iaRM0I4TexLG_QqRt27Yf3BIx6VmQnP8P0IWHtLyrFFezEd-AuJR5>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Feb 2026 06:21:44 -0500 (EST)
Date: Sat, 28 Feb 2026 12:21:42 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next v2 1/3] nsim: Add support for VLAN filters
Message-ID: <aaLPxrqoWsVC7PkB@krikkit>
References: <20260227090227.1552512-1-cratiu@nvidia.com>
 <20260227090227.1552512-2-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260227090227.1552512-2-cratiu@nvidia.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262111-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: A44061C2892
X-Rspamd-Action: no action

2026-02-27, 11:02:25 +0200, Cosmin Ratiu wrote:
> Add support for storing the list of VLANs in nsim devices, together with
> ops for adding/removing them and a debug file to show them.
> 
> This will be used in upcoming tests.
> 
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> ---
>  drivers/net/netdevsim/netdev.c    | 59 +++++++++++++++++++++++++++++--
>  drivers/net/netdevsim/netdevsim.h |  8 +++++
>  2 files changed, 65 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> index 6285fbefe38a..7177711cf9fc 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -602,6 +602,36 @@ static int nsim_stop(struct net_device *dev)
>  	return 0;
>  }
>  
> +static int nsim_vlan_rx_add_vid(struct net_device *dev, __be16 proto, u16 vid)
> +{
> +	struct netdevsim *ns = netdev_priv(dev);
> +
> +	if (vid >= VLAN_N_VID)
> +		return -EINVAL;
> +
> +	if (proto == htons(ETH_P_8021Q))
> +		set_bit(vid, ns->vlan.ctag);

Maybe

    DEBUG_NET_WARN_ON_ONCE(test_and_set_bit(vid, ns->vlan.ctag));

> +	else if (proto == htons(ETH_P_8021AD))
> +		set_bit(vid, ns->vlan.stag);
> +
> +	return 0;
> +}
> +
> +static int nsim_vlan_rx_kill_vid(struct net_device *dev, __be16 proto, u16 vid)
> +{
> +	struct netdevsim *ns = netdev_priv(dev);
> +
> +	if (vid >= VLAN_N_VID)
> +		return -EINVAL;
> +
> +	if (proto == htons(ETH_P_8021Q))
> +		clear_bit(vid, ns->vlan.ctag);

and

    DEBUG_NET_WARN_ON_ONCE(!test_and_clear_bit(vid, ns->vlan.ctag));


> +	else if (proto == htons(ETH_P_8021AD))
> +		clear_bit(vid, ns->vlan.stag);
> +
> +	return 0;
> +}


and in nsim_destroy, something like:

    for_each_set_bit(vid, ns->vlan.ctag, VLAN_N_VID)
        DEBUG_NET_WARN_ON_ONCE(1);
    for_each_set_bit(vid, ns->vlan.stag, VLAN_N_VID)
        DEBUG_NET_WARN_ON_ONCE(1);

just to make sure that we did all the accounting correctly?


This last one would catch problems like the error handling spotted by
AI (just add 3 offloaded devices + one non-offloaded, then try to
offload the last one, netdevsim accepts only 3 secys so mdo_add_secy
will fail):


# echo 1 > /sys/bus/netdevsim/new_device
# ip link add link eni1np1 type macsec port 5 offload mac
# ip link add link eni1np1 type macsec port 6 offload mac
# ip link add link eni1np1 type macsec port 7 offload mac
# ip link add macsec_H link eni1np1 type macsec offload off
# ip link add link macsec_H type  vlan id 20
# cat /sys/kernel/debug/netdevsim/netdevsim1/ports/0/vlan
# ip link set macsec_H type  macsec offload mac
RTNETLINK answers: No space left on device
# cat /sys/kernel/debug/netdevsim/netdevsim1/ports/0/vlan
ctag 20
# echo 1 > /sys/bus/netdevsim/del_device
<splat>

-- 
Sabrina

