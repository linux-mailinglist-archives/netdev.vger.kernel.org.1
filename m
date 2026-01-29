Return-Path: <netdev+bounces-254839-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HNEBEOGe2lOFQIAu9opvQ
	(envelope-from <netdev+bounces-254839-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:09:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A5BB1DB2
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 17:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 072A13051EA7
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 16:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99AF3382D2;
	Thu, 29 Jan 2026 16:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Rp5qcXQ0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TVXxIpso"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5711F2DF14C
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 16:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769702739; cv=none; b=iOLxevqQwgxNKsW/RFegncUdjYjZOJNNXlD4RA++0vu0DhYMW87rE9CU1WvubUcFHxR+dgi6vMX6324JCKYnaLP1AfBeLfxF8Ps8D/C7psRWfX8/w5eA3Uw4Zeh65LAs2eXxsv/pY9klct0FmHBD1kR6m1huWuZC+UjfFgRBUII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769702739; c=relaxed/simple;
	bh=kLg0F8tT/ad5OM4Ry7CO76NQ696xuhsA+vCaKr/rr9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/VcePINW68tmUt928xXIPTE9Ei/cN1ZphB0UyBRO5iyU7Jap2pBhlGnvI4H2EJ+GCSvXinjFveR6DC5wuxaxHPi52/LpcsZq8Vwbg3wlaX3XRzdRZNWFfoheCrkwCyCi/67hhGGKVa/dzt7ty/4QHDbUF3lbTjXxEpdyT6rqs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Rp5qcXQ0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TVXxIpso; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 73C397A012D;
	Thu, 29 Jan 2026 11:05:35 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 29 Jan 2026 11:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1769702735; x=
	1769789135; bh=5C/0w9828r3/pM8qUF6Phk7KB/JC1AyC7NztzYLbxg4=; b=R
	p5qcXQ0Jg+y8DlDMl0iMjC2tsOB66eFEerLZzYuRuxUaeShm39TKmpj7CTCkJ4yD
	pE53F6Js/J9og4izdtWfQBtJnLDffwWuQfdwbuGybJu4gM24Pv9dq5ImNEhN3rTs
	+H4lWr/Dz0UJjnMzoh/6kmpmdQmTMHHE43r7tf6eSuk5iQKZumbNgGimfThrmMN2
	8a7dCYRJMdXoAhJKgWVugq50F+spsN/YV/+f1HjFPSkll/ThBVPB2TXoVg447IgT
	d4A7QvO+hIbcjHBtaDu+tAJstsWvjdV12nEVuXBwA186duoJ/LHBvdza0TcqLCeX
	LM+Am5VlQSCTXQ4QTJ2yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769702735; x=1769789135; bh=5C/0w9828r3/pM8qUF6Phk7KB/JC1AyC7Nz
	tzYLbxg4=; b=TVXxIpsovasxwXH8qUx4Z7RckR/O039DYwOzSLCeCPwVd0i8u3y
	936AJn0Qr7N43FzhFhEuW2d4LjjuHJcKtjnaTVAxqIm0U1T7q9jz4a2B2jcDa71Z
	J3vwJrDdOF+WWPqio2z3M6Xzpq+taB8TYU5/XTvvvz3mo9AUkQEcE4FXz/pow8IA
	9ybC7RcVZecHM6/WTYeOERlnJQkOP50QcncTy6639cwjWV9wPOTB+ZfkCf+bnWzB
	mSQt7xM3Ftv5rvOd4T/Zw0jR+PXxnkMJ1vvUC9yoaFXO2XAbeoDXoWr0JC/Cta7f
	zhLkZS5WKPZQhegZ+FxloKwmJuK4IrjJKNg==
X-ME-Sender: <xms:ToV7aWUxYZ7Q-KpOSZcwHhFfj-zfbjgLGNa3xDdQm9x9vlfbWwEmMA>
    <xme:ToV7aRFOSQB7XfDlczq2ijZBvhawbFZr80BYKEVEEJUQt0AUKRGJ5aDWYs0-gkRTp
    UxU2KZ2LIALa8sotBSiipVB8JGcRVhU_CxXZTb-QSdOTjyPPtY8deo>
X-ME-Received: <xmr:ToV7aV7CI08yfmyyJXzeuvK67jqmIANpThOV6gLzryatddu0LcXUjMNU0n92>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieeiheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepheeljefgveehudetieejjeefffetgfduudehfeevjeelvdduhefghffh
    ueeikefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsuges
    qhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepudefpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehpvghnghhuihhnqdhkvghrnhgvlhesihdqlhhovhgv
    rdhsrghkuhhrrgdrnhgvrdhjphdprhgtphhtthhopehlvghonheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshhtvghffhgvnhdrkhhlrghsshgvrhhtsehsvggtuhhnvghtrdgt
    ohhmpdhrtghpthhtohephhgvrhgsvghrthesghhonhguohhrrdgrphgrnhgrrdhorhhgrd
    gruhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthht
    ohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdp
    rhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ToV7aXfJ_WdBZXO7bW44VnkXBebpp8NcAfO-wwMUTNpshFSmvHdQdQ>
    <xmx:ToV7aZkxpHZvOyTiy_Holvq_LP6rK8TMv-Mv3_Qs2dk2gBF490qYfg>
    <xmx:ToV7aU8lQLLGHoKpoiaqoVwtFCd3eIOUJANXKE3fCVA4yGwhQdLQWQ>
    <xmx:ToV7aXHx3fS-EQfAAQPX5SVYy5UJ74Sz_coQRx7mRgZVV3jlRk2O2Q>
    <xmx:T4V7aYCIGyiXi5KbASqVpZT2yC1-8o78Vk3t11zmoyFOQ_VotC7CFGTS>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jan 2026 11:05:34 -0500 (EST)
Date: Thu, 29 Jan 2026 17:05:32 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Leon Romanovsky <leon@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Ilan Tayari <ilant@mellanox.com>,
	Guy Shapiro <guysh@mellanox.com>,
	Yossi Kuperman <yossiku@mellanox.com>,
	Network Development <netdev@vger.kernel.org>
Subject: Re: [PATCH net] xfrm: always flush state and policy upon
 NETDEV_DOWN/NETDEV_UNREGISTER events
Message-ID: <aXuFTJZ3SvaCBXj5@krikkit>
References: <1de734e2-1da6-4b5c-8e03-66af7f88d074@I-love.SAKURA.ne.jp>
 <20260128102404.GC12149@unreal>
 <83d06aca-4437-4d61-9c99-ac19b797a243@I-love.SAKURA.ne.jp>
 <20260128123546.GC40916@unreal>
 <b91432c3-5ed4-4669-8d7c-02cf7ea6f8fa@I-love.SAKURA.ne.jp>
 <20260129090959.GD10992@unreal>
 <d0aa3c51-291b-40fd-82b4-15024dc4404b@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d0aa3c51-291b-40fd-82b4-15024dc4404b@I-love.SAKURA.ne.jp>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	TAGGED_FROM(0.00)[bounces-254839-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:url,messagingengine.com:dkim,queasysnail.net:dkim]
X-Rspamd-Queue-Id: 86A5BB1DB2
X-Rspamd-Action: no action

2026-01-29, 19:16:30 +0900, Tetsuo Handa wrote:
> On 2026/01/29 18:09, Leon Romanovsky wrote:
> > On Thu, Jan 29, 2026 at 05:06:08PM +0900, Tetsuo Handa wrote:
> >> On 2026/01/28 21:35, Leon Romanovsky wrote:
> >>> On Wed, Jan 28, 2026 at 07:44:02PM +0900, Tetsuo Handa wrote:
> >>>> On 2026/01/28 19:24, Leon Romanovsky wrote:
> >>>>> I think this can work, but IMHO the more robust approach is to ensure that all
> >>>>> states and policies are removed when the NETIF_F_HW_ESP feature bit is cleared.
> >>>>
> >>>> The transaction will become complicated, for dev->features manipulation
> >>>> function can fail.
> >>>
> >>> Line above returning NOTIFY_OK, check that NETIF_F_HW_ESP is cleared,
> >>> and remove everything.
> >>
> >> That answer needs more clarification. I came to get confused about what we should do.
> >>
> >> Question 1:
> >>
> >>   Since NETIF_F_HW_ESP is a hardware dependent flag, not all "struct net_device"
> >>   support NETIF_F_HW_ESP flag. Is this interpretation correct?
> > 
> > Yes, however any device (SW or HW) should set this flag if they want to
> > provide IPsec offload.
> 
> OK. There are "IPsec with offload" and "IPsec without offload".
> Both cases use code in net/xfrm/ directory.
> 
> Users (not the kernel source but Linux administrator) can choose
> "IPsec without offload" by clearing the NETIF_F_HW_ESP bit via
> "ethtool -K $dev esp-hw-offload off" command even if $dev supports
> both "IPsec with offload" and "IPsec without offload".

We should avoid talking about "IPsec with/without offload" when this
can mean multiple different things:

 - ip xfrm state add ... offload ...
   (and the offload request actually succeeded)
 - packet going through all the offload code and to the device
 - device with NETIF_F_HW_ESP set in dev->features
 - device with ->xdo_dev_state_add

(I'm probably forgetting a few more)

> >> Question 2:
> >>
> >>   Sabrina Dubroca commented
> >>
> >>     But the current behavior ("ignore NETIF_F_HW_ESP and call
> >>     xdo_dev_state_add for new states anyway") has been established for
> >>     multiple years. Changing that now seems a bit risky.
> >>
> >>   at https://lkml.kernel.org/r/aXd3QjzwOVm0Q9LF@krikkit .
> >>
> >>   Is that comment saying that we have been permitting a "struct net_device"
> >>   to be selected by xfrm_dev_state_add() even if that "struct net_device"
> >>   does not support NETIF_F_HW_ESP flag. Is this interpretation correct?
> > 
> > I don't understand what does it mean "device doesn't support offload but
> > state was offloaded anyway".

To Leon: this is not what Tetsuo wrote.
(but to be fair, "net_device does not support NETIF_F_HW_ESP flag" is
a bit confusing)

> Users (not the kernel source but Linux administrator) who are using $dev
> which supports only "IPsec without offload" can call xfrm_dev_state_add()
> because xfrm_dev_state_add() does not check for the NETIF_F_HW_ESP bit.
> 
> Therefore such users can create "struct xfrm_state" with a reference to
> "struct net_device" held at
> https://elixir.bootlin.com/linux/v6.19-rc5/source/net/xfrm/xfrm_user.c#L986 .
> 
> > 
> >>
> >> Question 3:
> >>
> >>   Leon Romanovsky suggested that, as a more robust approach, remove all states
> >>   and policies when the NETIF_F_HW_ESP feature bit is cleared.
> >>
> >>   But I consider that such approach will not work, for (according to Q2 above)
> >>   xfrm_dev_state_add() can be called even if the NETIF_F_HW_ESP feature bit is not
> >>   set. Also, I think that there is no guarantee that dev->features manipulation
> >>   function is called after xfrm_dev_state_add() was called.
> >>
> >>   Therefore, we need an event that are guaranteed to be called.
> >>   The NETDEV_UNREGISTER event is guaranteed to be called when unregistring
> >>   a "struct net_device", and therefore a good place to remove all states and
> >>   policies.
> >>
> >>   Is this interpretation correct?
> 
> Since we don't have a syzbot reproducer, I can't tell whether syzbot is manually
> clearing the NETIF_F_HW_ESP bit or not. But as described above, a syzbot report
> 
>   unregister_netdevice: waiting for netdevsim0 to become free. Usage count = 2
>   ref_tracker: netdev@ffff888052f24618 has 1/1 users at
>        __netdev_tracker_alloc include/linux/netdevice.h:4400 [inline]
>        netdev_tracker_alloc include/linux/netdevice.h:4412 [inline]
>        xfrm_dev_state_add+0x3a5/0x1080 net/xfrm/xfrm_device.c:316
> 
> indicates that "struct xfrm_state" with a reference to "struct net_device" held
> is remaining because xfrm_dev_state_flush() is not called upon NETDEV_UNREGISTER
> event.

I don't know what syzbot did, but this triggers the same symptoms for
me:

echo 0 > /sys/bus/netdevsim/new_device
dev=$(ls -1 /sys/bus/netdevsim/devices/netdevsim0/net/)
ip x s a src 192.168.13.1 dst 192.168.13.2 proto esp spi 0x1000 mode tunnel aead 'rfc4106(gcm(aes))' $key 128 offload crypto dev $dev dir out
ethtool -K $dev esp-hw-offload off
echo 0 > /sys/bus/netdevsim/del_device

-- 
Sabrina

