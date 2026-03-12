Return-Path: <netdev+bounces-267171-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOAXKxTzsmmLRAAAu9opvQ
	(envelope-from <netdev+bounces-267171-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 18:08:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E0C27664C
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 18:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 055DF3014A0C
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD473FB078;
	Thu, 12 Mar 2026 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="bpoPhnD1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tZGbEI2U"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496923B27DB;
	Thu, 12 Mar 2026 17:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773335286; cv=none; b=fbmmCGeV62ZzXlOwxnJCqPnXTE1KLAoIUFxUMqrFzd9wUmrle20TavxU2fMpZ+XfMYEMv3uKAARK9Z+opi4JEf+RCl6AYPbdJN/fSSbP4/zs+UHnAFjfR9d3AbQhjhSKUxjoAct6aP75hHtHm24M7gohy1xf8UKwr4qZnog74oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773335286; c=relaxed/simple;
	bh=9GUkX1UymzuCmF+KVbUDSfJHfjasrgyAK24MrqryyCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohgbqUALtpWoJ1ketslDlwtC+of2vydfaMU+rajLzK6p8ilbnrBT2c4dDpV4bRIeZZJOG9irN6zct6R7VWhL/BH4+adx7wb2wh23qSfop2UZuxYiOLGQe/ltooH/7XKTgaSADM4AYNdtNuYlv6tHRWrROQv4/FkV42HScODVJHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=bpoPhnD1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tZGbEI2U; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 67AFA7A0188;
	Thu, 12 Mar 2026 13:07:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 12 Mar 2026 13:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773335275; x=
	1773421675; bh=IoHMK1Z5v/Far6DHpNRk4L2RknvP1nvllRWb9YRM5ro=; b=b
	poPhnD19l6zP3OhPXXt7rqc0r7xNFyQDJpertDLSn6S797mUwW3BYmGSGR2+RzbQ
	T6E3gs8Aepw2O0NkMySke902zenrCaSTzbJHt3TK6XDpJGfx68PA7+imBkCp33xu
	yuBaSOY2D2qlfzsHokLy1XoZDgHBhSMFLu3dfxGQoSRaX32fJjqZbDBEheCFuWQ2
	IfSnC4Car5NHtLTEkGcihx2mrkW/Pjxu3GciPeoW/nR4fHie6rf0dH4X1ZqkqB39
	vAb+tJdtkuK7Id+qXxlXyosVyx6/h1KhFGw123ffYz4X4fblYLAD8XcHpA0csmQk
	nfIx2Gh5yPOHXdlvxDAjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773335275; x=1773421675; bh=IoHMK1Z5v/Far6DHpNRk4L2RknvP1nvllRW
	b9YRM5ro=; b=tZGbEI2U8nOqovnVql7AVObILEhslHJFP5BnxjbqUbCGeVPe12a
	5K7RBtn+llzttiM4YH2cw6VJtQRrrJE5UHF+ZlYD5z8PJCfLrxBUqYqwJZyWO/+Z
	tc6AHE/2DUnn5xyir1Np95LN5/iEOj1F3NXkZfKqRJM6OhwD7KcAdln0wbeb/4Vs
	2qNOc0R7o2i2NKZzQM1aP3IcS854qrP26qzrQm1xCmhafzmeYZpr3vYT+5+QOW9a
	PvFvEC9qEbRdWTQmFtpdoxIgjZasTzHvAAEQpMAS7tvTCYbzTO+VmBe71k/hhEeN
	qgj2FUXBDZB7WSVNAD9zASxqIhPONBV3GLg==
X-ME-Sender: <xms:6vKyabQs5P9vaG1ziPRYpzX31kJ3SGSPwC8lpi9LRwq9SD5rtEIpGw>
    <xme:6vKyaeJXW6Q6lEOQEN_0DYIcKKb_795Fk-F8SIg_1a8_ZNbRcM2k-lQqg1YN9bZtl
    JCw2L1Dgs9V2UgQov19_Fk8N3Q6bhk2HfifWGMX0ICsrur5gFskemU>
X-ME-Received: <xmr:6vKyaaE26KepPkc5aKpgH0sSbkzyESmDfsJBx50hpwkWfccUv15n6JEvqVfZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedukedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
    dprhgtphhtthhopehlihhuhhgrnhhgsghinhesghhmrghilhdrtghomhdprhgtphhtthho
    pehshiiisghothdotghitdelkehfrgejtgdujeelhegvtggvrggtsehshiiikhgrlhhlvg
    hrrdgrphhpshhpohhtmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhn
    nhdrtghhpdhrtghpthhtohepsghrihgughgvsehlihhsthhsrdhlihhnuhigrdguvghvpd
    hrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegv
    ughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepihguohhstghhsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:6vKyaTSfVh1FJzPyOUGL7DhbTwDn-Yp2V5srIUhMolYZADoMz53vjg>
    <xmx:6vKyabWKgELkT5Y-lS2bhMwf1MJ-i6hQwewQQ54T8c-AgozTwoQZCA>
    <xmx:6vKyaagKGbcFb7ArRNNCo5UZ-iOz1l7ZQhhDgDeg8ZmY-aB_1A5rtg>
    <xmx:6vKyacfLC6q9OM5IgI9MOYrtNGt_zgZ_4st5VI9l1njoK4qVM3DFNA>
    <xmx:6_KyacB1FvP7GYWqNBuuNTjbi9Dh11w-wtP0EsDuHahZ5x-ObUBSyHgD>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 13:07:53 -0400 (EDT)
Date: Thu, 12 Mar 2026 18:07:51 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>,
	syzbot ci <syzbot+ci098fa7c1795eceac@syzkaller.appspotmail.com>,
	andrew@lunn.ch, bridge@lists.linux.dev, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org, idosch@nvidia.com,
	jiri@resnulli.us, jv@jvosburgh.net, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	razor@blackwall.org, sridhar.samudrala@intel.com,
	syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot ci] Re: net: move netdev_compute_master_upper_features
 to ndo_set_features
Message-ID: <abLy56AN2BgUI1nG@krikkit>
References: <20260310-offload_compute-v1-0-3df79c09ea65@gmail.com>
 <69b04e91.a70a0220.51e36.0000.GAE@google.com>
 <abBuLV3P6aTzUg3W@krikkit>
 <abC7rdjxv9ENw-tA@fedora>
 <abHcP3GTO29rfKML@krikkit>
 <bcc536ac-dde1-4b63-8fed-70850818472b@redhat.com>
 <abKf8Fg865Fhipwk@krikkit>
 <abLPBEg_-j5rp4IM@fedora>
 <abLivB2KPK0JcTFR@krikkit>
 <2d1e0acc-efad-4166-b738-721d88d533ca@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2d1e0acc-efad-4166-b738-721d88d533ca@redhat.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267171-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[gmail.com,syzkaller.appspotmail.com,lunn.ch,lists.linux.dev,davemloft.net,google.com,kernel.org,nvidia.com,resnulli.us,jvosburgh.net,vger.kernel.org,blackwall.org,intel.com,googlegroups.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,ci098fa7c1795eceac];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 90E0C27664C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-12, 17:47:45 +0100, Paolo Abeni wrote:
> 
> 
> On 3/12/26 4:58 PM, Sabrina Dubroca wrote:
> > 2026-03-12, 14:34:44 +0000, Hangbin Liu wrote:
> >> On Thu, Mar 12, 2026 at 12:13:52PM +0100, Sabrina Dubroca wrote:
> >>> Proper fix (so that the notification we're sending during
> >>> upper_dev_link has full linkinfo) would be to move
> >>> netdev_upper_dev_link() to after macsec_changelink_common() and fix up
> >>> the error handling. I don't see anything in macsec_add_dev or
> >>> macsec_changelink_common that needs the device to be linked. But
> >>
> >> If we move the netdev_upper_dev_link() after macsec_changelink_common(),
> >> we will not goto nla_put_failure via default, right?
> > 
> > Yes.
> > 
> >>> anyway it doesn't make sense for macsec_fill_info to return -EMSGSIZE
> >>> on invalid data, so the "bandaid" should be included as well.
> >>>
> >>> Should this be part of this series (either just the "bandaid" or the
> >>> "proper fix"+bandaid), since we never saw a problem before?
> >>
> >> Since macsec need the "bandaid" fix either way. How about you post the
> >> "bandaid" fix to net. And I include the "proper fix" in this series for
> >> net-next?
> > 
> > But I don't think it's needed in net. Am I missing a codepath (before
> > your series) where macsec_fill_info could be called for the new device
> > before macsec_newlink returns? If not, it doesn't really qualify as a
> > fix, that's why I was asking Paolo.
> 
> FWIW, I don't see a codepath calling into rtmsg_ifinfo_build_skb()
> before device initialization, so I would be fine targeting net-next with
> the EMSGSIZE-related change.
> 
> Side note, it looks like that the WARN() in the rnnetlink code here
> helped identifying a real problem and correctly returning 0 when the
> key_len is not yet initialized will silence it forever, what about
> preserving a warning for this kind of race? something alike:

Right, I was thinking about putting a DEBUG_NET_WARN_ON_ONCE there.

-- 
Sabrina

