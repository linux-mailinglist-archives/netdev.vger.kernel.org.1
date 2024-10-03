Return-Path: <netdev+bounces-131557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C83A98ED9D
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 13:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2534C1F22B67
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 11:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2984B1514F8;
	Thu,  3 Oct 2024 11:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MbTzEAbj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GKVedhf9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MbTzEAbj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GKVedhf9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4433E1474B8
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727953791; cv=none; b=b8Xl4cXjAUK2XlDQ9d6TGIx0hcwNe2PCHnyckd+pZT/MJHaEXjnVFy/VQ0x3a823Ks8G9wdVjnmfXhZ9iWFv3tOM9RIPU38HRQqM2AfE98b4XiWaPuytYvIO9QtIdoekuduFyF8K/s/VE9qWHHv0/PjRh7ypNHUSgDyH0GzkBqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727953791; c=relaxed/simple;
	bh=VL2CAIFNk/cRg3uxiMf+OZajrk5r1cSGt/+SMldKK0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3g9pmecdEc330uLEoXa8K5NAmoUfYNLedtumT8V2a6iGkcjG/LQ7HDOv3KecJhhW/rReYP97I2gu6bLHEv2fVkMPC8fV+ox2MRNTBwKzmx7eza7BlcxUUEBsE3jQol8DGgGHDnIHFJPds3LQJ/RWuRBmhstcSmK5zQLlPk0tEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MbTzEAbj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GKVedhf9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MbTzEAbj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GKVedhf9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.100.225.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 782C021D45;
	Thu,  3 Oct 2024 11:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727953787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VL2CAIFNk/cRg3uxiMf+OZajrk5r1cSGt/+SMldKK0I=;
	b=MbTzEAbjYwVMnM460e8QQG9s3/ngAl+2dCVvWcx7sxjVo1fdbz71KRrdHT0mzn8ODZ1uHJ
	8OpNgJ0+pmpUB66IOLdV0sZhOCg1XiGs/RRfBTo4pXc0W8WcPsKLM4FiQOyBHg7xWWyFNd
	X5Xcqn51x2RNWqtRLpZhlekVbwCTcHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727953787;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VL2CAIFNk/cRg3uxiMf+OZajrk5r1cSGt/+SMldKK0I=;
	b=GKVedhf9yF1IUvycwH4loQKQhEVQLS33vFja3z4OXlRnU8yqq2RwqXFnzpiEmoihEZpw0j
	oKgQawPPg8l9tqDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727953787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VL2CAIFNk/cRg3uxiMf+OZajrk5r1cSGt/+SMldKK0I=;
	b=MbTzEAbjYwVMnM460e8QQG9s3/ngAl+2dCVvWcx7sxjVo1fdbz71KRrdHT0mzn8ODZ1uHJ
	8OpNgJ0+pmpUB66IOLdV0sZhOCg1XiGs/RRfBTo4pXc0W8WcPsKLM4FiQOyBHg7xWWyFNd
	X5Xcqn51x2RNWqtRLpZhlekVbwCTcHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727953787;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VL2CAIFNk/cRg3uxiMf+OZajrk5r1cSGt/+SMldKK0I=;
	b=GKVedhf9yF1IUvycwH4loQKQhEVQLS33vFja3z4OXlRnU8yqq2RwqXFnzpiEmoihEZpw0j
	oKgQawPPg8l9tqDg==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 66A802012C; Thu,  3 Oct 2024 13:09:47 +0200 (CEST)
Date: Thu, 3 Oct 2024 13:09:47 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
	"Mogilappagari, Sudheer" <sudheer.mogilappagari@intel.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH ethtool] netlink: rss: retrieve ring count using
 ETHTOOL_GRXRINGS ioctl
Message-ID: <dcdnyuvjksvebfgcavogszlcoro3gwinzc6fzfjjtijadyg3km@7spc2j4v2ci6>
References: <20240913093828.2549217-1-vladimir.oltean@nxp.com>
 <IA1PR11MB6266964963DBC6242C5CC6DEE4652@IA1PR11MB6266.namprd11.prod.outlook.com>
 <20240913224858.foaciiwpxudljyxn@skbuf>
 <IA1PR11MB62661EF398124FC523CC3C03E4652@IA1PR11MB6266.namprd11.prod.outlook.com>
 <45327ee6-e57c-4fec-bf43-86bd1338f5fb@intel.com>
 <20241003091810.2zbbvod4jqq246lq@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z3j7qzowozptxlyg"
Content-Disposition: inline
In-Reply-To: <20241003091810.2zbbvod4jqq246lq@skbuf>
X-Spam-Score: -5.85
X-Spamd-Result: default: False [-5.85 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.15)[-0.731];
	RCVD_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Flag: NO
X-Spam-Level: 


--z3j7qzowozptxlyg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 03, 2024 at 12:18:10PM +0300, Vladimir Oltean wrote:
> Hello Jake,
>=20
> On Thu, Sep 19, 2024 at 10:58:48AM -0700, Jacob Keller wrote:
> > We could extend the netlink interface to add this over netlink instead
> > of ioctl, but that hasn't been done yet.
>=20
> Let me understand how this will play out. So you're proposing that we
> add a new netlink attribute in ETHTOOL_MSG_RSS_GET_REPLY, with Fixes:
> 7112a04664bf ("ethtool: add netlink based get rss support"), and this
> gets backported to all stable kernels which include this commit?
>=20
> And then also 'fix' ethtool to parse this new netlink attribute instead
> of ETHTOOL_A_CHANNELS_RX_COUNT? Thus introducing another breakage: when
> the new ethtool program runs with the old (aka unpatched stable) kernel?

I'm afraid we will have to keep the unfortunate ioctl fallback for quite
long. The only other option would be to only use netlink for RSS against
kernel which provides full information and use only ioctl against those
which don't.

Michal

--z3j7qzowozptxlyg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmb+e3cACgkQ538sG/LR
dpWY0ggAhtP/m7BFZI5Am/1t79TwStDi2/m96SQ5h4dIExzcvhFuGh4j7Yo1alzs
0iAa7EZQqGijvuUNNxRKQylgIzRz+9nzLd1qIfJjYz6vVvEMjY8aU4Ip+6MBpwTO
t9vE04+QFd4q9h41X4e1Uczi9yiqupIzLWODsCBYR8DSKYD0PtucGImsgbNZCH1D
pemOzohnoDJ7jUe7uY4rpN2wFMB3gQJAobWRdeysBpw9J01OL0GEljHTIj9u6lEB
5M65gt0K46D4IzUaUL0u8rYwzBDHVTiQxeACK/4D3nlBrg8U3yQR02Zsn6fIt4GM
w4Lx86Nfm0Fd1r4LHf+CjcvFB99e1Q==
=hpKn
-----END PGP SIGNATURE-----

--z3j7qzowozptxlyg--

