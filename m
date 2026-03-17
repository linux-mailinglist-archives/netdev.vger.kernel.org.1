Return-Path: <netdev+bounces-268580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKxyJFZDuWkk+QEAu9opvQ
	(envelope-from <netdev+bounces-268580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:04:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA15B2A973D
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D317C308860F
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D2D3B7779;
	Tue, 17 Mar 2026 11:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="sBGSXHmV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KoFhcBVO"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345163B776A;
	Tue, 17 Mar 2026 11:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773748742; cv=none; b=pEik2o/fWZW/GL2AfHRgLcywF27RXKYeANLFa6f1ZDuYeNrCIp/zWVG5cTl1kefd39oJHnMpvZv0DxooYLG7B/YgXbx4C3aI9Yt2qRE8Qxlitq9URyFUSKgUZ8kEe6mFpEM5zO8/7/jRMNQIs6s/aVbfJ07iASTpTU/5PX2Z/as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773748742; c=relaxed/simple;
	bh=WzpohQTFAg+/+5fjgYupL5nMEp8YLjnG0HBxCA/Fido=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKmB6nUrjVLGIjA7GhjAFBhgp6ltcQqGCNbFNi+uc8CnvfysVXBO68c5GLVMFUFmhrj8OUSbrZAQLkiN47uFTeVwx3S2Tftl2EzYpnrkhKolnSxiupUJCziZykxKuCPatxJSGW1XiO27gIgd/U7JRq0Fvvoxx+DKQcwiYoPq9lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=sBGSXHmV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KoFhcBVO; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id A68CB1D00175;
	Tue, 17 Mar 2026 07:58:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 17 Mar 2026 07:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773748737; x=
	1773835137; bh=LQKKJmXb+zrz4f+7W1idnzMcDl0vzLq+F8OkS2Y6DOc=; b=s
	BGSXHmVDI4CGagxvI+Aqoo7MErNV32aqTztJ67/hkY/49eLmgh9irqikMUvyhSKd
	6gmh5uc96OUkfeWNgy3NTMsIqVWaJxsO1vOz6YhUMUGK62zxxepU0D4Zxt75vTWe
	2kpbTiSJYg9NPmxmCD3xaPPTRzaY30OS2eoPxPEz5EQY6BfpELg0HKQGFD9a2ZT/
	+tvyZMsp9LCO+9mCAVVJ9ZCwGpBQFwINaoWUiMFhayV728yi7OQVSMFZWxNLOCCI
	RkXIZc30LOVfmPr/w4qQN+Z4ee5+vyelKDJm/WVUJBqdKPtLNUL3ezrmMOPOb0gy
	2AoYGXlrUKSsTtg+75tYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773748737; x=1773835137; bh=LQKKJmXb+zrz4f+7W1idnzMcDl0vzLq+F8O
	kS2Y6DOc=; b=KoFhcBVOcfAMJPRVhaorXh8apoVVymXAMIWNkDwQZ+MdwTs7WmE
	GwrJMTQZ44hKVUSw0DHXYRlc7z5ZvfFF7HdEo5S2Uc4lg1inmKqAfGt622Ez8NY8
	wshjKtNBgcUYFhbnQLh2UVWLgKPWZdT79gNvwgclu0jK8UuOqCv+M5koNif8TV3Y
	HSJWGjbmVXHpfxA2dTs33tjd4s5/snXNzeXZnr5yIdxpoiJZhbj9QdKU7ZdsW1da
	zOBGjRa8ZReTxjeb/3AMSvBnw02FNceMANYpdBuVMK7JJ2k/wfRqUMaZek2ITJgy
	ocwnf7Ud/Qhxv9XaTfYpQxtOxYGAleJurhA==
X-ME-Sender: <xms:AEK5aYBgOAUIMneYJa2E9tIMHlWwuvco_YDmcnmEiAlNa5oGB4PIKA>
    <xme:AEK5aZ86G_FBOs_yfE5kGGV4duJUZ2jRA7YhI9UtPjgxfP86Hriy2pACjYBcQXdk6
    FGMhEaA97nnN0Wq6dJfGRiYwO7m19U3DAvOGWpQOPObAxYZ5ZudLXeq>
X-ME-Received: <xmr:AEK5acrUAaDX-L7fqdcIX2uJg_tJCv6dGgtMC1KKO_50asgt8fM6-esKfgBN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdduudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeduhedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhiuhhhrghnghgsihhnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhhvsehjvhhoshgsuhhrghhhrdhnvghtpdhrtghpthhtohep
    rghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmse
    gurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehjihhrihesrhgvshhn
    uhhllhhirdhushdprhgtphhtthhopehrrgiiohhrsegslhgrtghkfigrlhhlrdhorhhg
X-ME-Proxy: <xmx:AEK5aTGJ108I1jkgAh5qvj26DOfg8XJL7Fk5wFfh8UUZJXfovuJscQ>
    <xmx:AEK5aQ_gFvwQxGKQFCZ9z2JXrQhXzuP2CSkX0Rw4SF-jSfnevmK10Q>
    <xmx:AEK5aQSwcMmWJpsOjK5wPX_scMjt8TKvg5MvQLPzC-OICIjKARZjTA>
    <xmx:AEK5aVqUedkZC0oMc44wEgQTf0pj5Fr5cDF4bYbcSNWoaa7EeJL-ag>
    <xmx:AUK5aTn9OHBOk8MwvW468Thfg8UQ9GotY6GAcUnEeOJibWZB90tl6RXK>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Mar 2026 07:58:55 -0400 (EDT)
Date: Tue, 17 Mar 2026 12:58:54 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bridge@lists.linux.dev
Subject: Re: [PATCH net-next v3 3/5] macsec: move netdev_upper_dev_link()
 after macsec_changelink_common()
Message-ID: <ablB_tdLxMPoYtv3@krikkit>
References: <20260316-offload_compute-v3-0-a5d4a07d86d3@gmail.com>
 <20260316-offload_compute-v3-3-a5d4a07d86d3@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260316-offload_compute-v3-3-a5d4a07d86d3@gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-268580-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:dkim,queasysnail.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA15B2A973D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-16, 12:26:11 +0800, Hangbin Liu wrote:
> After calling netdev_change_features() in __netdev_upper_dev_link(),
> the call stack looks like:
> 
> - netdev_upper_dev_link
>   - __netdev_upper_dev_link
>     - netdev_change_features
>       - notifier_call_chain
>         - rtnetlink_event
>           - rtmsg_ifinfo_event
>             - rtmsg_ifinfo_build_skb
> 
> In macsec, we call netdev_upper_dev_link() before
> macsec_changelink_common(), which causes the fields of the MACsec
> Security Entity to be uninitialized. Later, macsec_fill_info() returns
> -EMSGSIZE and triggers WARN_ON() in rtmsg_ifinfo_build_skb.
> 
> Fix this by moving netdev_upper_dev_link() after
> macsec_changelink_common(), and return 0 if secy->key_len is not
> initialized yet.
> 
> Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/macsec.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)

I'm not sure I'll manage to look at the rest of the series before it's
applied, but for this patch:

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

Thanks Hangbin.

-- 
Sabrina

