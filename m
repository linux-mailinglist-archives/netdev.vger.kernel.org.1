Return-Path: <netdev+bounces-81051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DB288595A
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 13:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C36282308
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 12:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFED83CBA;
	Thu, 21 Mar 2024 12:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Ja8pHUrU"
X-Original-To: netdev@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A03A76029
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 12:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711025270; cv=none; b=S/AtjmzZFyKARif1FNmCyBXdPFyd2HpBX9pNqbsA566P7MW8ka1AUsm3NU6YIQdv7F6V6nC21Gi6A9r6gcWHGpV7+TCKoTGEHz2gaJHHjbvaa4QdEKVT20vYQimG323u5vQYbFiktNIScbzpFL0MFFxqPDSk+qqJGVd9fSJhHng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711025270; c=relaxed/simple;
	bh=1c3ojoTL56EbnU4NtNLQXUjfDG51FKcjYr23h72rp+Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mIy7OHiCL0V3hj9mG/c8MmtxanqvDzuYj73Z0KWSxZsib/BHfOdBTF05XlgvJv2zbFz/ULirgSw7KlvIVDi1w/vo/5ByPCtE5CazVoXp30j3RC225ix5Ic7zxLff0hzmxYGTz5XDYf93DTocQnboXCQb99OrKULDTisJSEPTFIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=Ja8pHUrU; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1711025264;
	bh=VpTgsHsE8Gwfx7YFHfRPL4F/osaBTmZy0HilednQEpY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ja8pHUrUQvzu5RY8zFcgOwKslWfGRly7LXNffj17mBPyISG4D9nO5B4xwkMcsDUCG
	 cIMcvey7zJjBOZwfSMY+LNafAC55wMlzZm8O8hBODwzTCxgJKR9EFnSDH9h5Ot3XJe
	 yd2tvTiJDTeS2MbssbzK1fULqtg4gYUgU8TUy+di12moX1whg+7rKsKrxC2MuyihA0
	 KlWpUQXCmytoN6ZbBCjM0kaQMVsbZVuI4Wd2esQjZXsrNr8wMxKxGATiAiEET8ke5O
	 LPZXVzbUVfooAqrB3DOpHr51RDxmhwkneZ0/02M11IsLVaU/a667pG2wWKeVENYoOC
	 uDuMVGhWqeJDQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V0lbx3xtpz4wc1;
	Thu, 21 Mar 2024 23:47:41 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc: netdev@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 linuxppc-dev@lists.ozlabs.org, wireguard@lists.zx2c4.com,
 dtsen@linux.ibm.com, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Cannot load wireguard module
In-Reply-To: <20240320160428.GQ20665@kitsune.suse.cz>
References: <20240315122005.GG20665@kitsune.suse.cz>
 <87jzm32h7q.fsf@mail.lhotse> <87r0g7zrl2.fsf@mail.lhotse>
 <20240318170855.GK20665@kitsune.suse.cz>
 <20240319124742.GM20665@kitsune.suse.cz> <87le6dyt1f.fsf@mail.lhotse>
 <20240320160428.GQ20665@kitsune.suse.cz>
Date: Thu, 21 Mar 2024 23:47:41 +1100
Message-ID: <87frwjzr82.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Michal Such=C3=A1nek <msuchanek@suse.de> writes:
> On Wed, Mar 20, 2024 at 11:41:32PM +1100, Michael Ellerman wrote:
>> Michal Such=C3=A1nek <msuchanek@suse.de> writes:
>> > On Mon, Mar 18, 2024 at 06:08:55PM +0100, Michal Such=C3=A1nek wrote:
>> >> On Mon, Mar 18, 2024 at 10:50:49PM +1100, Michael Ellerman wrote:
>> >> > Michael Ellerman <mpe@ellerman.id.au> writes:
>> >> > > Michal Such=C3=A1nek <msuchanek@suse.de> writes:
>> >> > >> Hello,
>> >> > >>
>> >> > >> I cannot load the wireguard module.
>> >> > >>
>> >> > >> Loading the module provides no diagnostic other than 'No such de=
vice'.
>> >> > >>
>> >> > >> Please provide maningful diagnostics for loading software-only d=
river,
>> >> > >> clearly there is no particular device needed.
>> >> > >
>> >> > > Presumably it's just bubbling up an -ENODEV from somewhere.
>> >> > >
>> >> > > Can you get a trace of it?
>> >> > >
>> >> > > Something like:
>> >> > >
>> >> > >   # trace-cmd record -p function_graph -F modprobe wireguard
>> >
>> > Attached.
>>=20
>> Sorry :/, you need to also trace children of modprobe, with -c.
>>=20
>> But, I was able to reproduce the same issue here.
>>=20
>> On a P9, a kernel with CONFIG_CRYPTO_CHACHA20_P10=3Dn everything works:
>>=20
>>   $ modprobe -v wireguard
>>   insmod /lib/modules/6.8.0/kernel/net/ipv4/udp_tunnel.ko
>>   insmod /lib/modules/6.8.0/kernel/net/ipv6/ip6_udp_tunnel.ko
>>   insmod /lib/modules/6.8.0/kernel/lib/crypto/libchacha.ko
>>   insmod /lib/modules/6.8.0/kernel/lib/crypto/libchacha20poly1305.ko
>>   insmod /lib/modules/6.8.0/kernel/drivers/net/wireguard/wireguard.ko
>>   [   19.180564][  T692] wireguard: allowedips self-tests: pass
>>   [   19.185080][  T692] wireguard: nonce counter self-tests: pass
>>   [   19.310438][  T692] wireguard: ratelimiter self-tests: pass
>>   [   19.310639][  T692] wireguard: WireGuard 1.0.0 loaded. See www.wire=
guard.com for information.
>>   [   19.310746][  T692] wireguard: Copyright (C) 2015-2019 Jason A. Don=
enfeld <Jason@zx2c4.com>. All Rights Reserved.
>>=20
>>=20
>> If I build CONFIG_CRYPTO_CHACHA20_P10 as a module then it breaks:
>>=20
>>   $ modprobe -v wireguard
>>   insmod /lib/modules/6.8.0/kernel/net/ipv4/udp_tunnel.ko
>>   insmod /lib/modules/6.8.0/kernel/net/ipv6/ip6_udp_tunnel.ko
>>   insmod /lib/modules/6.8.0/kernel/lib/crypto/libchacha.ko
>>   insmod /lib/modules/6.8.0/kernel/arch/powerpc/crypto/chacha-p10-crypto=
.ko
>>   modprobe: ERROR: could not insert 'wireguard': No such device
>>=20
>>=20
>> The ENODEV is coming from module_cpu_feature_match(), which blocks the
>> driver from loading on non-p10.
>>=20
>> Looking at other arches (arm64 at least) it seems like the driver should
>> instead be loading but disabling the p10 path. Which then allows
>> chacha_crypt_arch() to exist, and it has a fallback to use
>> chacha_crypt_generic().
>>=20
>> I don't see how module_cpu_feature_match() can co-exist with the driver
>> also providing a fallback. Hopefully someone who knows crypto better
>> than me can explain it.
>
> Maybe it doesn't. ppc64le is the only platform that needs the fallback,
> on other platforms that have hardware-specific chacha implementation it
> seems to be using pretty common feature so the fallback is rarely if
> ever needed in practice.

Yeah you are probably right.

The arm64 NEON code was changed by Ard to behave like a library in
b3aad5bad26a ("crypto: arm64/chacha - expose arm64 ChaCha routine as
library function").

Which included this change:

@@ -179,14 +207,17 @@ static struct skcipher_alg algs[] =3D {
 static int __init chacha_simd_mod_init(void)
 {
        if (!cpu_have_named_feature(ASIMD))
-               return -ENODEV;
+               return 0;
+
+       static_branch_enable(&have_neon);

        return crypto_register_skciphers(algs, ARRAY_SIZE(algs));
 }

It didn't use module_cpu_feature_match(), but the above is basically the
same pattern.

I don't actually see the point of using module_cpu_feature_match() for
this code.

There's no point loading it unless someone wants to use chacha, and that
should be handled by MODULE_ALIAS_CRYPTO("chacha20") etc.

cheers

