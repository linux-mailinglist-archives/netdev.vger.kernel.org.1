Return-Path: <netdev+bounces-132348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FAF991521
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 09:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C0841F235B8
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 07:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873D78615A;
	Sat,  5 Oct 2024 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1RbpHHJL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gAmBCXOT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1RbpHHJL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gAmBCXOT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA3D535D8
	for <netdev@vger.kernel.org>; Sat,  5 Oct 2024 07:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728114394; cv=none; b=NWs22z5X4CSRMdFMLHEyS/qIHwGku/Pb7hwuw8981g2Du/odD8/NLYYWwVDPOGVQww00d1oayg9HkkHhBg0lvHM3o98iMMprkvtdZ4le4Nh160o+euO2jIKLvqvFeG12fFQyxlDqOMWkZzq0kJasfaLPl67QqwTSfwkwDTo96sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728114394; c=relaxed/simple;
	bh=kF4PS3LZjE+vxKJ03I01bzMFEJyYurQgropPZ5p/q4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXKsfC8Yy7q48J8yrFACsJJA97gSdexTnsbXz6UUaqg3g90AnGg6UwBk728YKdUN01mXDVnl8nEc33PthbSN05RyKH6Nez4iUF2K2E/j3bpWgd3p/1dEU8nPzm0QUULrN16fH+kOMB3NQOYdUSkEa2phlwuTRmHs6hlwIuPvwzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1RbpHHJL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gAmBCXOT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1RbpHHJL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gAmBCXOT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E1DD41FE45;
	Sat,  5 Oct 2024 07:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728114389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kF4PS3LZjE+vxKJ03I01bzMFEJyYurQgropPZ5p/q4w=;
	b=1RbpHHJLzoQg22Y9hTMok/AeUasaESQpa3Ay8GFKZyjmYv6RL8g/88HuNU4CWybizspO4f
	3nU2xWzrafS2v4lXD4c/84D9Pz2AzKJ9ZC9TRV+jwZINi65Z7wqBYDXSPlqssBkk2WSvct
	b/gWeNvpHA4FAHRlPcUlIxfGVFliE5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728114389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kF4PS3LZjE+vxKJ03I01bzMFEJyYurQgropPZ5p/q4w=;
	b=gAmBCXOTkzgom+4PyMk6bfYN6Iknorlr/c1cz4BH8XYH4bsAaBx4JJY6GlCZZz8rjWCdwo
	SwQfoohw/C/EVlAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728114389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kF4PS3LZjE+vxKJ03I01bzMFEJyYurQgropPZ5p/q4w=;
	b=1RbpHHJLzoQg22Y9hTMok/AeUasaESQpa3Ay8GFKZyjmYv6RL8g/88HuNU4CWybizspO4f
	3nU2xWzrafS2v4lXD4c/84D9Pz2AzKJ9ZC9TRV+jwZINi65Z7wqBYDXSPlqssBkk2WSvct
	b/gWeNvpHA4FAHRlPcUlIxfGVFliE5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728114389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kF4PS3LZjE+vxKJ03I01bzMFEJyYurQgropPZ5p/q4w=;
	b=gAmBCXOTkzgom+4PyMk6bfYN6Iknorlr/c1cz4BH8XYH4bsAaBx4JJY6GlCZZz8rjWCdwo
	SwQfoohw/C/EVlAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C58C713A8F;
	Sat,  5 Oct 2024 07:46:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XHcwL9XuAGdKGAAAD6G6ig
	(envelope-from <mkubecek@suse.cz>); Sat, 05 Oct 2024 07:46:29 +0000
Date: Sat, 5 Oct 2024 09:46:22 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, 
	"Mogilappagari, Sudheer" <sudheer.mogilappagari@intel.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH ethtool] netlink: rss: retrieve ring count using
 ETHTOOL_GRXRINGS ioctl
Message-ID: <lxkqtnik6q6xjpjhgmy4kwbbsgtxwa7mszz7gcv3i2aafhkx4n@tdudjcsuxg7z>
References: <20240913093828.2549217-1-vladimir.oltean@nxp.com>
 <IA1PR11MB6266964963DBC6242C5CC6DEE4652@IA1PR11MB6266.namprd11.prod.outlook.com>
 <20240913224858.foaciiwpxudljyxn@skbuf>
 <IA1PR11MB62661EF398124FC523CC3C03E4652@IA1PR11MB6266.namprd11.prod.outlook.com>
 <45327ee6-e57c-4fec-bf43-86bd1338f5fb@intel.com>
 <20241003091810.2zbbvod4jqq246lq@skbuf>
 <dcdnyuvjksvebfgcavogszlcoro3gwinzc6fzfjjtijadyg3km@7spc2j4v2ci6>
 <20241003134916.q6m7i3qkancqjnvr@skbuf>
 <tctt7svco2xfmp7qr2rrgrpx6kzyvlaia2lxfqlunrdlgjny3h@77gxzrjooolu>
 <CO1PR11MB5089C7F00BCDDCBB678AF260D6722@CO1PR11MB5089.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qvqquxe2qllzzhp4"
Content-Disposition: inline
In-Reply-To: <CO1PR11MB5089C7F00BCDDCBB678AF260D6722@CO1PR11MB5089.namprd11.prod.outlook.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-5.90 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-0.991];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Score: -5.90
X-Spam-Flag: NO


--qvqquxe2qllzzhp4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 04, 2024 at 07:19:24PM +0000, Keller, Jacob E wrote:
> I have no objection to your patch, I think its correct to do now. My
> suggestion was that we can improve the netlink interface for the
> future, and I believe we can make ethtool continue to use the existing
> ioctl interface on older kernels, but use the netlink interface once
> its available.

This is not the problem. It's what we have been doing since netlink
interface was introduced and it's what we are going to be doing for
quite long.

What I'm unhappy about is the mix of netlink and ioctl where we use
netlink request for RSS but also an ioctl request to get the ring count.
I can't help wondering if it wouldn't make more sense to fallback to
ioctl fully unless we can retrieve full information via netlink.

Michal

--qvqquxe2qllzzhp4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmcA7skACgkQ538sG/LR
dpVliwf+Lcmiq82XZztnVs66DnEKQ6CPnLBf2wl0AEJo5Xa2Q/BZTXUDwwSlOlEM
HhyL7IEarFmZkFg8W1m5z9CqqGYNkv6i4Qd4uuXTaL4JcFuYVpqYqEFU0z3bs2u0
KvQCzOmd/tze8lnj9Hbbtrb2Y10hitoJcc7k1d1McHYL02WMZ4/japRERUtpfkGg
fbmzT5Ja1oyK4XbCBsoL02jkI1DiYhxKESciXI6cVmB2b+4ve7TZs5gCDysRtiAB
UKc7ZFuAqfpZ2MFDHdnY0IZgfMX5WcItYS/NKOVNP5+wn1ApyazVmgqp189FMC39
0OgjolwgCrNjsONmnz7nGWQWDRqWYw==
=gGEu
-----END PGP SIGNATURE-----

--qvqquxe2qllzzhp4--

