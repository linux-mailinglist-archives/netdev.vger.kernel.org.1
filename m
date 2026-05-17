Return-Path: <netdev+bounces-288736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NhmDQnGCWpYpAQAu9opvQ
	(envelope-from <netdev+bounces-288736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 15:43:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9A3561401
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 15:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E19D3009B33
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 13:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481ED3B47D7;
	Sun, 17 May 2026 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="RfHiPhhn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8474337CD40
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779025399; cv=none; b=Yw1nkyhMzQeUZaGyJ/9iHz/d3KrLVB4d4UVF+/mYZ0g767oZ2DqHIjTJSlwsVYnzJzHxvlHS9oqVodG4wFRQUmL6RwNfRvyvB29TbOjaYrMK7vJDP9Y1WLe6lF3cUeJJx3yr1SzDp/16AWM8wKmQx0R4BHY0m5Um/GB5efu1FUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779025399; c=relaxed/simple;
	bh=sMLXXNEtNM9byc9cxRPZeXDbmGRBMfUm3b7miLj3Ocs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+8Haq9uAPJ+ZTfZ1T5zxu5THAzzrP7X/ubyZj2gysUJcmJI9AkU1t0s1t5fH92Dk7vsTcj8/9CmCvd7KsD/7/PY219TVXSH1qpo4i38Q9KCMHNLUaRCzgx8eQUkVeH4zeBQ3IAytO0cwHe1jIUVL1la3xcYoEENBlZ9rwH3mnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=RfHiPhhn; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488ad135063so8477155e9.0
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 06:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1779025396; x=1779630196; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+HArGPzJ3JrxUqYbJRCQTeZdStWSHyJjxqFBR8YJCaA=;
        b=RfHiPhhn5+zzdES6i5no8nNOpmLntxv+Vc16dvCSH4gB4lCYaiqUKcGXllPsA2IG7N
         sGD1GG13JZ/bvoNY1RTPMh/0JvV7jVjoZn/Vo40b6EYYRjY8f431NI4Sr9euwyBOrevF
         gxh4xz1YcUeHHGFabHwyncM5+oDEPYtav/Agfms3zwQdkitbSrc8o9ily7zo+je0/Rbn
         M28N0UDC0FCr/ZaY8NsajRM1bR7CZAfw4n3XlMCGPs1xs9RkpjUaseIJF7Pk0XC5FyTf
         TJsaoprHvjkFknof9xIR1Ajpq0vkOI3oIebG2J1BL1lPaozlc+w9eMI/egMvaf4Fs2mG
         qFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779025396; x=1779630196;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+HArGPzJ3JrxUqYbJRCQTeZdStWSHyJjxqFBR8YJCaA=;
        b=hktAUaXGmNPk/9RjtBwpK8z/GcNvnRN2aC+vNZUt92PzY+z3QrBK4FqkXDqg6OfsLl
         YMLCeSuFbU4pdAeM7nPPzpOQi4AgahraYR6p/0HJqy0xhIrEJIc4MwrzAKVLtXQm8PC+
         PKePB0mxVd1/QFVyndbpJNoqGLL44WT0Cj7MyaS4PIalm2ONRAgqcNbCjf8AfmNWruop
         9ls3A9Pum3afwXI7z8OMTvGXgrZ2C3TCE6sRrfp0p2Fz/BHhtxU0twaAMdDeGEid26Zj
         9VIDyLWDoEKAhU3paqp4fA8X2Vau1t7M+ihBsEtkVRjLKZ0IKx7f6OraVAeU6OfN9onV
         nfjQ==
X-Gm-Message-State: AOJu0YwPUXul/ajM+1ALcD8K5oeIIATXPKbmpX+WHzLF1JnModxICFy+
	tRHGk+4Blm7yTZlGYwykKtJT2NFvjh5n1X+2rjoyMUBZxN3aiMsraAONOAnAJenvJ0g=
X-Gm-Gg: Acq92OFaIHZI36y0p4lHVcFFFOYz8qqQD2adLcgCA+8DHdeXsAgWSuRneNhl4wFDyK3
	cCNfbTRah/pTKH7wO+9s8Y3z8rG5C3Ln12LbBR0NWLXsqRQK60I6M6OO0C0B7X57gYK3RvKZB9I
	PZDIZxXjiHAZJtSqWIXdrOQX5qN1tm9PcSaJFLKfkfCKiTL0p4WPK80WKhg7iwLKWZgDCwi8HyG
	dbZgwoN0S3gvTQq+iYpIKITz36nwtX/NZgOr+cR9merepaIDY30BkAhDvNR51cE6I+e6wo5nnVW
	dnrRZ/1awH5vui6Z3YF+X633QNBDTyNyJeKG7JT2jY9RWXYqPxx/fyrrhepOFs2RG/6iLO1fbXz
	GUTJyqYdqV0+wJJtKRQxA3TadU0ZPURMzytzlUrHyDc945VwAa6RAC/Q9TCljhzavnVd5HBMUPp
	k/girWS/842MfRf2DllmDW3uX03Q3v0Yc+7LbeoLb2zCdei11BgnF/NdguKg==
X-Received: by 2002:a05:600c:3f0f:b0:48f:99a9:bbcc with SMTP id 5b1f17b1804b1-48fe60ecb9cmr152488335e9.10.1779025395675;
        Sun, 17 May 2026 06:43:15 -0700 (PDT)
Received: from localhost (176.111.181.159.kyiv.nat.volia.net. [176.111.181.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed30110sm32700649f8f.13.2026.05.17.06.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 06:43:15 -0700 (PDT)
Date: Sun, 17 May 2026 16:43:12 +0300
From: Nikolay Aleksandrov <razor@blackwall.org>
To: David Carlier <devnexen@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, andrew@lunn.ch,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	horms@kernel.org
Subject: Re: [PATCH net-next v1] net: tpmr: add Two-Port MAC Relay driver
Message-ID: <agnF8KScbKxtUite@penguin>
References: <20260517041306.24841-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260517041306.24841-1-devnexen@gmail.com>
X-Rspamd-Queue-Id: BA9A3561401
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[blackwall.org];
	TAGGED_FROM(0.00)[bounces-288736-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,blackwall.org:dkim]
X-Rspamd-Action: no action

On Sun, May 17, 2026 at 05:13:06AM +0100, David Carlier wrote:
> Add a driver implementing the Two-Port MAC Relay as defined by IEEE
> 802.1Q-2014 §6.7.1. A TPMR is a minimal L2 relay between exactly two
> member ports: no FDB, no MAC learning, no STP, and -- by
> specification -- it forwards most of the 01:80:C2:00:00:0X reserved
> group address range that a regular bridge would consume. This makes
> it suitable as a bump-in-the-wire element that is transparent to the
> control plane on both sides (LACP, LLDP, EAPOL, and so on continue
> to reach the far end as if the relay were not present).
> 
> The driver is created with "ip link add type tpmr" and slaves are
> attached through ndo_add_slave, with a hard cap of two members.
> Forwarding is implemented as an rx_handler: a frame arriving on one
> slave is sent out the other via dev_queue_xmit(), with no FDB
> lookup. The IEEE-permitted subset of reserved multicasts is relayed;
> the remainder is delivered to the host stack via RX_HANDLER_PASS,
> preserving today's behaviour for protocols that genuinely target the
> local machine. Only 01:80:C2:00:00:01 (IEEE 802.3x PAUSE) is
> terminated, as required by the MAC layer.
> 
> The master's carrier follows the logical AND of both slaves'
> carriers, propagated via a netdev notifier. Both slaves enter
> IFF_PROMISC on enslave (and the refcount is balanced on detach) so
> the relay sees all unicast on the wire. rx_handler_register()
> provides exclusivity for free: a netdevice that is already a member
> of a bridge, bond, team, or macvlan is rejected with -EBUSY at
> enslave time.
> 
> MTU consistency is enforced at enslave: a second slave whose MTU
> differs from the first is rejected. Subsequent member MTU changes
> are blocked via NETDEV_PRECHANGEMTU; to change a member's MTU,
> detach it first.
> 
> Inspired by OpenBSD's tpmr(4) (David Gwynne, 2019), reimplemented
> against Linux's rx_handler / rtnl_link_ops infrastructure.
> 
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
> 
> v1 (from RFC, addressing Andrew Lunn review):
>   - Inline reserved-address check; only PAUSE is passed up,
>     gated on is_multicast_ether_addr() + unlikely().
>   - Fix MTU check that assumed ports[0] is always the
>     surviving slot after a detach-then-add sequence;
>     iterate ports[] to find the populated entry instead.
>   - Reject member MTU changes via NETDEV_PRECHANGEMTU.
>   - Drop driver version string; let ethtool core fill it.
>   - Keep driver in drivers/net/ (precedent: veth, bonding,
>     macvlan).
> RFC: https://lore.kernel.org/netdev/20260516050858.23858-2-devnexen@gmail.com/
> 
 
Hi David,
Please give people more time to review the proposed RFCs before sending v1.
Also you specifically asked bridge maintainers to comment and did not
wait for us to do so.

Now to the point - I don't think this device is needed at all, this task can
be accomplished in multiple ways with what we currently have, there is no 
need to add another software device for something so simple.

First, I'd like to ask: could you please elaborate why bridge's group_fwd_mask
isn't working out for you? How exactly are you trying to use it?
It was added for this purpose, to forward link-local frames and should be
able to do the same as what you're describing. If there is a problem I'd
rather we fix it or extend the bridge if something's missing instead of
adding so much new code that we'll have to maintain forever.

Second, what else did you try and how exactly did you try it?

Examples of a few ways to solve this:
 - tc: why dismiss mirred so fast, it can do the same combined with some matching?
       Did you check mirred redirect?
       cls_bpf/ebpf - definitely can do it as well
 - nftables: should be able to solve it, too
 - XDP: I wouldn't dismiss it because network managers cannot control it,
        all modern network managers support custom scripts in some form
        where you can load your custom XDP program and solve the problem

Cheers,
 Nik

