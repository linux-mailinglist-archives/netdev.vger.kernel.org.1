Return-Path: <netdev+bounces-80854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D651188152A
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 17:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E18FB22F38
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 16:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBE254661;
	Wed, 20 Mar 2024 16:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZM1IHRuJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lfgEkScD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Xi6MSutC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AoEpC++p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B4F53E1B
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 16:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710950674; cv=none; b=S1rdzJvca84WWdugOOiJaRwcQtIy7vRA5X7gtIiIuxwi96lMozVFUx+DRm9+0zTlxb6XB9tTAmRLvAzAGTeRjylUceGlRGx+tYq41JYeHkbxTgMwvDorqoDa5GbAAVAhJVa1+X6q/vQktAtZkBzB/cYDmGmrobr8Qe9GUgMOOpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710950674; c=relaxed/simple;
	bh=W+EY++8gJz6A80dzzLCLhXh98dB4o5XVv4gM5/Bf13U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCQVmicpw8hLocFlhguhgqNzbHcAL2i4Mgyy6WRpZydb4aLE8iYvQtgp8fgCer9iowaCCZqZkw7lh78xE9UBTsRLRocm/V3yB5bEoexMtKzXRdylLgwLR6CSvN0PV4FKJR2fQ3b9v7G1y78UsaUPF4etb8EPAur/vJomAkuMLu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZM1IHRuJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lfgEkScD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Xi6MSutC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AoEpC++p; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CC70734774;
	Wed, 20 Mar 2024 16:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710950670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QjX69h01GVJIX3aWH8s2p5XVScnEQmomDafkyDxLNA0=;
	b=ZM1IHRuJywSxvY8A+4nEfPdAHQLhQX9C8iD67BDfskczwGODJvUjL0/NWVXtfcflvsU6Xk
	bmLgY4vKUFvWA4EIoXA6nHan3DOqoUyXiuQOS07XWugAGH8uoYUNgRDENUzJYa7DwWYcBH
	H0ZNex80ESA6hsqs9yN3NYtk+sutzFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710950670;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QjX69h01GVJIX3aWH8s2p5XVScnEQmomDafkyDxLNA0=;
	b=lfgEkScD99ZVyS2EFPayeinSdqUVXY8mobLEvk1s6AB/OwUaRBuJaWXW/xQg8tHni1VA2V
	rZsMybeRo+yFy0DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710950669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QjX69h01GVJIX3aWH8s2p5XVScnEQmomDafkyDxLNA0=;
	b=Xi6MSutCQfz591Wl1UJwUi0ajdVP6Mwbm+63KHXpmMBPmdImS6M3cKMXe2E6y37gAYPDgN
	5ZL8DzPKyXHozyH9xcX9kYWug2AjmGBCjxgEWUfftUP1o90zjgWvCQ9dQKSk2pU873w2dH
	zs4Ct5kATobPicpB3CjFjQXxgIHwM7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710950669;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QjX69h01GVJIX3aWH8s2p5XVScnEQmomDafkyDxLNA0=;
	b=AoEpC++pSxac76w/vY/ydJS6TK/GV/j2smtUlKSZse5XoRiuNW96Rg32n6ZfQ65hR0e70u
	cvHHS2eDDWI4IDAQ==
Date: Wed, 20 Mar 2024 17:04:28 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: netdev@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
	linuxppc-dev@lists.ozlabs.org, wireguard@lists.zx2c4.com,
	dtsen@linux.ibm.com, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Cannot load wireguard module
Message-ID: <20240320160428.GQ20665@kitsune.suse.cz>
References: <20240315122005.GG20665@kitsune.suse.cz>
 <87jzm32h7q.fsf@mail.lhotse>
 <87r0g7zrl2.fsf@mail.lhotse>
 <20240318170855.GK20665@kitsune.suse.cz>
 <20240319124742.GM20665@kitsune.suse.cz>
 <87le6dyt1f.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87le6dyt1f.fsf@mail.lhotse>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -7.54
X-Spamd-Result: default: False [-7.54 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.15)[-0.760];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,wireguard.com:url,ellerman.id.au:email,zx2c4.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 R_MIXED_CHARSET(0.71)[subject];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Wed, Mar 20, 2024 at 11:41:32PM +1100, Michael Ellerman wrote:
> Michal Suchánek <msuchanek@suse.de> writes:
> > On Mon, Mar 18, 2024 at 06:08:55PM +0100, Michal Suchánek wrote:
> >> On Mon, Mar 18, 2024 at 10:50:49PM +1100, Michael Ellerman wrote:
> >> > Michael Ellerman <mpe@ellerman.id.au> writes:
> >> > > Michal Suchánek <msuchanek@suse.de> writes:
> >> > >> Hello,
> >> > >>
> >> > >> I cannot load the wireguard module.
> >> > >>
> >> > >> Loading the module provides no diagnostic other than 'No such device'.
> >> > >>
> >> > >> Please provide maningful diagnostics for loading software-only driver,
> >> > >> clearly there is no particular device needed.
> >> > >
> >> > > Presumably it's just bubbling up an -ENODEV from somewhere.
> >> > >
> >> > > Can you get a trace of it?
> >> > >
> >> > > Something like:
> >> > >
> >> > >   # trace-cmd record -p function_graph -F modprobe wireguard
> >
> > Attached.
> 
> Sorry :/, you need to also trace children of modprobe, with -c.
> 
> But, I was able to reproduce the same issue here.
> 
> On a P9, a kernel with CONFIG_CRYPTO_CHACHA20_P10=n everything works:
> 
>   $ modprobe -v wireguard
>   insmod /lib/modules/6.8.0/kernel/net/ipv4/udp_tunnel.ko
>   insmod /lib/modules/6.8.0/kernel/net/ipv6/ip6_udp_tunnel.ko
>   insmod /lib/modules/6.8.0/kernel/lib/crypto/libchacha.ko
>   insmod /lib/modules/6.8.0/kernel/lib/crypto/libchacha20poly1305.ko
>   insmod /lib/modules/6.8.0/kernel/drivers/net/wireguard/wireguard.ko
>   [   19.180564][  T692] wireguard: allowedips self-tests: pass
>   [   19.185080][  T692] wireguard: nonce counter self-tests: pass
>   [   19.310438][  T692] wireguard: ratelimiter self-tests: pass
>   [   19.310639][  T692] wireguard: WireGuard 1.0.0 loaded. See www.wireguard.com for information.
>   [   19.310746][  T692] wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> 
> 
> If I build CONFIG_CRYPTO_CHACHA20_P10 as a module then it breaks:
> 
>   $ modprobe -v wireguard
>   insmod /lib/modules/6.8.0/kernel/net/ipv4/udp_tunnel.ko
>   insmod /lib/modules/6.8.0/kernel/net/ipv6/ip6_udp_tunnel.ko
>   insmod /lib/modules/6.8.0/kernel/lib/crypto/libchacha.ko
>   insmod /lib/modules/6.8.0/kernel/arch/powerpc/crypto/chacha-p10-crypto.ko
>   modprobe: ERROR: could not insert 'wireguard': No such device
> 
> 
> The ENODEV is coming from module_cpu_feature_match(), which blocks the
> driver from loading on non-p10.
> 
> Looking at other arches (arm64 at least) it seems like the driver should
> instead be loading but disabling the p10 path. Which then allows
> chacha_crypt_arch() to exist, and it has a fallback to use
> chacha_crypt_generic().
> 
> I don't see how module_cpu_feature_match() can co-exist with the driver
> also providing a fallback. Hopefully someone who knows crypto better
> than me can explain it.

Maybe it doesn't. ppc64le is the only platform that needs the fallback,
on other platforms that have hardware-specific chacha implementation it
seems to be using pretty common feature so the fallback is rarely if
ever needed in practice.

Thanks

Michal

> 
> This diff fixes it for me:
> 
> diff --git a/arch/powerpc/crypto/chacha-p10-glue.c b/arch/powerpc/crypto/chacha-p10-glue.c
> index 74fb86b0d209..9d2c30b0904c 100644
> --- a/arch/powerpc/crypto/chacha-p10-glue.c
> +++ b/arch/powerpc/crypto/chacha-p10-glue.c
> @@ -197,6 +197,9 @@ static struct skcipher_alg algs[] = {
>  
>  static int __init chacha_p10_init(void)
>  {
> +	if (!cpu_has_feature(PPC_FEATURE2_ARCH_3_1))
> +		return 0;
> +
>  	static_branch_enable(&have_p10);
>  
>  	return crypto_register_skciphers(algs, ARRAY_SIZE(algs));
> @@ -207,7 +210,7 @@ static void __exit chacha_p10_exit(void)
>  	crypto_unregister_skciphers(algs, ARRAY_SIZE(algs));
>  }
>  
> -module_cpu_feature_match(PPC_MODULE_FEATURE_P10, chacha_p10_init);
> +module_init(chacha_p10_init);
>  module_exit(chacha_p10_exit);
>  
>  MODULE_DESCRIPTION("ChaCha and XChaCha stream ciphers (P10 accelerated)");
> 
> 
> Giving me:
> 
>   $ modprobe -v wireguard
>   insmod /lib/modules/6.8.0-dirty/kernel/net/ipv4/udp_tunnel.ko
>   insmod /lib/modules/6.8.0-dirty/kernel/net/ipv6/ip6_udp_tunnel.ko
>   insmod /lib/modules/6.8.0-dirty/kernel/lib/crypto/libchacha.ko
>   insmod /lib/modules/6.8.0-dirty/kernel/arch/powerpc/crypto/chacha-p10-crypto.ko
>   insmod /lib/modules/6.8.0-dirty/kernel/lib/crypto/libchacha20poly1305.ko
>   insmod /lib/modules/6.8.0-dirty/kernel/drivers/net/wireguard/wireguard.ko
>   [   19.657941][  T718] wireguard: allowedips self-tests: pass
>   [   19.662501][  T718] wireguard: nonce counter self-tests: pass
>   [   19.782933][  T718] wireguard: ratelimiter self-tests: pass
>   [   19.783114][  T718] wireguard: WireGuard 1.0.0 loaded. See www.wireguard.com for information.
>   [   19.783223][  T718] wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
>   
> 
> cheers

