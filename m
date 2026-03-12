Return-Path: <netdev+bounces-267142-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAaeKNbjsmnyQgAAu9opvQ
	(envelope-from <netdev+bounces-267142-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:03:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4D9275231
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 17:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 10355302F15E
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 16:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BE63F1652;
	Thu, 12 Mar 2026 15:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="C5yvQQjo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OKMxq6pl"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FC23CAE88;
	Thu, 12 Mar 2026 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331142; cv=none; b=MJZxOc/CgPjeK7jCfoPRdXD5NBnN9/XIxYrN7HURklzKtFxbaCrIXiPL8BEt2nLno5clxBn0TCpulaObkSXdd+G7l1oMNM9UBTMxaoY8ADFdjsjLasHigCXVDGPeGMGgdZ88rOYMU+VTJn2jolBhqOQKMx06xsT6VM9QYf0SVWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331142; c=relaxed/simple;
	bh=U5y6aIZPDqLmVyCtYKlXy3hJtlLer5kyuyz1ZHgIcNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qc/R8l66228XWAAXeooj8pxvWJgm5Z5F2ojBKBs0KmkskocZZ4O492ycgnPtelm8iqLjjspwnhfPcVk8oibzC5BAgCKblKaKHbQpkmxDSIrAUeg7/UDPBHGqv4seaDHJDM3Qu5BV7hg1tRIR2MEDNFYssqwfIThcDqV9f9039UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=C5yvQQjo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OKMxq6pl; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 52EA17A01DF;
	Thu, 12 Mar 2026 11:58:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 12 Mar 2026 11:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773331136; x=
	1773417536; bh=9oTlu2XKdmLapb218LpEbDHgHpWfKS4EuHhcw93dxyY=; b=C
	5yvQQjoTdTdvzrmWXAroLuZQJVcI6OeUbzVp0YsNYSdnsNkxuNfJ6eC9fCAVEFqe
	4MMkxzk8frjBQmNwdsoRr8ZsCzIeHnBYua/0/765UsW0QM8ICoYcE9ZaerIztPV7
	G363EtBLRqmINLAPGsVP6xy1feBrXFYnw78XciMNxXwoIk4PmA9uGKqbJNH1oCn2
	kYLpHuf7rhjEHb8po+dGRUy01JG1IneiGz8G4eojxnqzxb0MfqVScVy13B5qCuhO
	J+keFEmjEuOrv4jw5ejRe4OvZbBnG5BrtfXk2eDAyRTVBl7yLql+533T2q/35Twe
	5d+L8wJAW8Cgrv3kYTLmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773331136; x=1773417536; bh=9oTlu2XKdmLapb218LpEbDHgHpWfKS4EuHh
	cw93dxyY=; b=OKMxq6plyu/i8T2ZDtO6XIfMojAOCxEq/AnXULGORgq53Frza/F
	y0m5v+96MhEETOQIALwoqiov9FkC4fsHVgR8GW9YUNozLEpdNFANFvjGkGxhlzsT
	RiOTvt7jwCbj1UkhQokAg92iPRJJk5bwheN4wka2b5wsr1FNL94Js89ioXFX9L91
	XRAN29ocxEFuGe7ihy/xpXbvURCX9HYdJVFvui+w7eaWdk4ucmqg3QxAprRIifmO
	LRXYqI3SmC9mCl1bOlX+UIfLmcI2GK6OFG8I3U8rR0v+E58N22Wvu3ZsFHAkfSX9
	acD6LPTof0NLIDasg7haE2gqSIxlBPpuWfg==
X-ME-Sender: <xms:v-KyaUSjhYv4NaSs5Axh2WMtBnkO-4eLjdMbmOPWN1SgXXJ3Pv2MXw>
    <xme:v-KyaVtb_I6wTGsx6bJkzLYeePwQICMnMUXOyzLGREafLhZf3Ww4qnt7R3HW6Penl
    wPJiUTVw-u3apPrB22kH_GnQahoSbz61mELiATcbLT5iwf0mS028g>
X-ME-Received: <xmr:v-KyaWZeYcFsS94zi_CpAw9g9EPtfu6voZjL9kL0KDrytAgPHZ6WgSodeQYk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepuefhhfffgfffhfefueeiudegtdefhfekgeetheegheeifffguedvueff
    fefgudffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopedukedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhiuhhhrghnghgsihhnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthho
    pehshiiisghothdotghitdelkehfrgejtgdujeelhegvtggvrggtsehshiiikhgrlhhlvg
    hrrdgrphhpshhpohhtmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhn
    nhdrtghhpdhrtghpthhtohepsghrihgughgvsehlihhsthhsrdhlihhnuhigrdguvghvpd
    hrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegv
    ughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepihguohhstghhsehnvhhiughirgdrtghomh
X-ME-Proxy: <xmx:v-Kyaf_e8mBWnzVfH7IPRmntaxaV_na1oev4ynVO-UhJ6GrYEmmyhA>
    <xmx:v-KyaSpquUXfvTWeBhTQYUA5nD29uwdsQO5TL5r7byDBhge4MIyrUw>
    <xmx:v-KyaSFC-0Hi809j0cjcD6GyIRlh9BIJhQueKPm-iDmx4J2GAOas0A>
    <xmx:v-KyaSkGh47do7xV70GDK5w3P_dYmQKoR4yUVMbIwVvTwNDcUmUw4A>
    <xmx:wOKyad4fnDVu7utjaf11nPLRi37uwJKO7A1A00E4I9Fq8SV_kETz7RcQ>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 11:58:54 -0400 (EDT)
Date: Thu, 12 Mar 2026 16:58:52 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>,
	syzbot ci <syzbot+ci098fa7c1795eceac@syzkaller.appspotmail.com>,
	andrew@lunn.ch, bridge@lists.linux.dev, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org, idosch@nvidia.com,
	jiri@resnulli.us, jv@jvosburgh.net, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	razor@blackwall.org, sridhar.samudrala@intel.com,
	syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot ci] Re: net: move netdev_compute_master_upper_features
 to ndo_set_features
Message-ID: <abLivB2KPK0JcTFR@krikkit>
References: <20260310-offload_compute-v1-0-3df79c09ea65@gmail.com>
 <69b04e91.a70a0220.51e36.0000.GAE@google.com>
 <abBuLV3P6aTzUg3W@krikkit>
 <abC7rdjxv9ENw-tA@fedora>
 <abHcP3GTO29rfKML@krikkit>
 <bcc536ac-dde1-4b63-8fed-70850818472b@redhat.com>
 <abKf8Fg865Fhipwk@krikkit>
 <abLPBEg_-j5rp4IM@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abLPBEg_-j5rp4IM@fedora>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-267142-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	TAGGED_RCPT(0.00)[netdev,ci098fa7c1795eceac];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 0C4D9275231
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-03-12, 14:34:44 +0000, Hangbin Liu wrote:
> On Thu, Mar 12, 2026 at 12:13:52PM +0100, Sabrina Dubroca wrote:
> > Proper fix (so that the notification we're sending during
> > upper_dev_link has full linkinfo) would be to move
> > netdev_upper_dev_link() to after macsec_changelink_common() and fix up
> > the error handling. I don't see anything in macsec_add_dev or
> > macsec_changelink_common that needs the device to be linked. But
> 
> If we move the netdev_upper_dev_link() after macsec_changelink_common(),
> we will not goto nla_put_failure via default, right?

Yes.

> > anyway it doesn't make sense for macsec_fill_info to return -EMSGSIZE
> > on invalid data, so the "bandaid" should be included as well.
> > 
> > Should this be part of this series (either just the "bandaid" or the
> > "proper fix"+bandaid), since we never saw a problem before?
> 
> Since macsec need the "bandaid" fix either way. How about you post the
> "bandaid" fix to net. And I include the "proper fix" in this series for
> net-next?

But I don't think it's needed in net. Am I missing a codepath (before
your series) where macsec_fill_info could be called for the new device
before macsec_newlink returns? If not, it doesn't really qualify as a
fix, that's why I was asking Paolo.


> BTW, here is my draft patch, would you like to review it first?
> 
> diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
> index f6cad0746a02..1f8da4c291c6 100644
> --- a/drivers/net/macsec.c
> +++ b/drivers/net/macsec.c
> @@ -4161,10 +4161,6 @@ static int macsec_newlink(struct net_device *dev,
>  	lockdep_set_class(&dev->addr_list_lock,
>  			  &macsec_netdev_addr_lock_key);
>  
> -	err = netdev_upper_dev_link(real_dev, dev, extack);
> -	if (err < 0)
> -		goto unregister;
> -
>  	/* need to be already registered so that ->init has run and
>  	 * the MAC addr is set
>  	 */
> @@ -4177,12 +4173,12 @@ static int macsec_newlink(struct net_device *dev,
>  
>  	if (rx_handler && sci_exists(real_dev, sci)) {
>  		err = -EBUSY;
> -		goto unlink;
> +		goto unregister;
>  	}
>  
>  	err = macsec_add_dev(dev, sci, icv_len);
>  	if (err)
> -		goto unlink;
> +		goto unregister;
>  
>  	if (data) {
>  		err = macsec_changelink_common(dev, data);
> @@ -4190,6 +4186,10 @@ static int macsec_newlink(struct net_device *dev,
>  			goto del_dev;
>  	}
>  
> +	err = netdev_upper_dev_link(real_dev, dev, extack);
> +	if (err < 0)
> +		goto unlink;

This one shouldn't be "goto unlink" since we haven't linked yet. I'm
not sure netdev_upper_dev_unlink can handle "not linked yet" devices.

Otherwise this looks ok.

-- 
Sabrina

