Return-Path: <netdev+bounces-191670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43157ABCA81
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 23:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF7A53A4D89
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 21:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8F521A444;
	Mon, 19 May 2025 21:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="12GZywJJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hqct0cwJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cJMWSYfp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aUbMs0/W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBC37261D
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 21:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747691953; cv=none; b=dTAkw8hMn+mG8uEtxp6lK8fYU/rrl3SL0Rm3PT0Cc7qkTVgzGHI3izRvX+c8YYnNZFL0ZBZxtBeDsHPVDpgPzDnMT/Wfd1d9wbtjP6j3tfneEQLLveSm2njxaFuU/iMICJoEkgQfFf1EBQ2gNamqO4zXuWtA/P8w3RXwtBSw2Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747691953; c=relaxed/simple;
	bh=lXmv/Rqksl0SaSCt2m2IK0OIwyCGrsVP1itMsdtxY00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoIqPK9mw38aG4MgByLq9EikkhU3hKLHJnyC8MY/iHLbUqfPU93TC3n/q/pIl6y55aK4bz8wYseivad/CYjsqNjRYY2mnU+6IgczTvnrC0iEdn3SS9/9RC5skJ7wrnxVeyz6WSEMaEGj4frT07EqockNtbpla0TK8CMo8mkbxmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=12GZywJJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hqct0cwJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cJMWSYfp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aUbMs0/W; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED5C6204E9;
	Mon, 19 May 2025 21:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747691950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lXmv/Rqksl0SaSCt2m2IK0OIwyCGrsVP1itMsdtxY00=;
	b=12GZywJJcTVSLN5tUtNSv/snsgFBAbDmNPuL3DxfeZro+y1j7DMG0bmmqwlgFGGTGMvZRY
	DMu5EScu95quhL+PyNdXEUdmlsWOdU1aQBcvAnKBFfO1vtjqWFs2oYzh6WSmekDWtcD8HT
	v6f+wcbXnPniTuGPbVS7TlLg+uM5vzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747691950;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lXmv/Rqksl0SaSCt2m2IK0OIwyCGrsVP1itMsdtxY00=;
	b=Hqct0cwJ7AiZ3hF2RJOxY/ekMaXsJgEKQlqIDOWMRKVzzs/GCgKSG02HlYUytGZ5MpBNor
	jEi2FWrmLodnTnCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cJMWSYfp;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="aUbMs0/W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1747691949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lXmv/Rqksl0SaSCt2m2IK0OIwyCGrsVP1itMsdtxY00=;
	b=cJMWSYfp/uVeubv+HCsSLRcvedsOOfZ5PJCqa7fLyvYaBQJPp3pYdvX0rP/TR5FP6rBABL
	Uzr5yS84HJmVZgxiVcIldSm+oUT94fWcaVybwuG2/Fl4lvqsm5tYGRwDQZalRItLcsabWG
	KSqL6wmAjkp0FNnWpjAudmFg9E4yc00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1747691949;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lXmv/Rqksl0SaSCt2m2IK0OIwyCGrsVP1itMsdtxY00=;
	b=aUbMs0/WiCyym42UBTMhCMc3jizdNwV1iuBs7FrYq+646L7Jwfu/flCoradaHtyN0yZTAQ
	AtaLagbYw8j92jBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3F361372E;
	Mon, 19 May 2025 21:59:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hELYJq2pK2ipLgAAD6G6ig
	(envelope-from <mkubecek@suse.cz>); Mon, 19 May 2025 21:59:09 +0000
Date: Mon, 19 May 2025 23:59:04 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Jijie Shao <shaojijie@huawei.com>
Cc: shenjian15@huawei.com, wangpeiyang1@huawei.com, liuyonglong@huawei.com, 
	chenhao418@huawei.com, sudongming1@huawei.com, xujunsheng@huawei.com, 
	shiyongbang@huawei.com, libaihan@huawei.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH ethtool] hibmcge: add support dump registers for hibmcge
 driver
Message-ID: <hef5kevhdatkodjyhdqpmwoezgiovls7jicjpubj4dvx3bj4hw@towdjgja5h2o>
References: <20250307113932.821862-1-shaojijie@huawei.com>
 <34b4e4ba-d831-41de-a45a-53920d8b9f0d@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qptmhz5ln4kq26go"
Content-Disposition: inline
In-Reply-To: <34b4e4ba-d831-41de-a45a-53920d8b9f0d@huawei.com>
X-Spamd-Result: default: False [-6.11 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -6.11
X-Rspamd-Queue-Id: ED5C6204E9
X-Spam-Level: 
X-Spam-Flag: NO


--qptmhz5ln4kq26go
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 11:12:33AM +0800, Jijie Shao wrote:
> Hi:
>=20
> The query result shows that this patch has been accpected:
> https://patchwork.kernel.org/project/netdevbpf/list/?series=3D&submitter=
=3DJijie+Shao&state=3D3&q=3D&archive=3Dboth&delegate=3D123907
>=20
> But I cannot find it from
> https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/log/?qt=3Dgrep=
&q=3DJijie+Shao

I'm sorry, you are right. I forgot to merge this review branch before
pushing to git.kernel.org.

> I'm not sure what happened.
> Does this patch need to be resent?

No, I'll do it with this week's batch.

Michal

--qptmhz5ln4kq26go
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmgrqaMACgkQ538sG/LR
dpWTJAf9FMri1nijesDCNCZ5YL8xHl2w7JOuml30JaOXWl1fGDzLsmYF7o4Y/Oxb
TCr3S2crswREaZVZqN50OoALef7/UyTarKqrWjkoJAMsxEqLdUB9VHF6jhRqSfLK
usDAFlLsDimhaBINqesDVMPBWNDpR0c3yXmrGw4KBntRcyaA3cR9y+BjBpg+T7wO
fBMD/ew84S+RAVJjdFEYATku/UJ5QV1aus1uLKx6kY/b4xIvWuF2fljQmfZatyB2
KRr9D2o+LuCwx1Dzz5cNrG6nLvhQLq/Au/cyDPxmTXFmYRbBGU+XCEJJr/LWlDtB
cu3vJAoiiC2UgqXygNpfA2cO5cHIjg==
=ONlJ
-----END PGP SIGNATURE-----

--qptmhz5ln4kq26go--

