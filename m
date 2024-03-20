Return-Path: <netdev+bounces-80800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EB38811C7
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 13:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D40D3B23833
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 12:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940F33D54C;
	Wed, 20 Mar 2024 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="pDysZXTz"
X-Original-To: netdev@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488C83FE44
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 12:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710938504; cv=none; b=EpkDa1ZWWLMTZ1jN0DXeXdpNRkFmw9hmhA8ZY0Qjm2SR0oPR8Brb8nCNpDk24/ZokPldKWCCEFSzRt6yyZUSftlOexQwPDUBxqAEEy5ctX0NLL6nHhGfgh57BwgHVg3gncBu6pClwteuK//VBifWo7bJ6hkZ9Xb4ccVmJhrj6ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710938504; c=relaxed/simple;
	bh=arxfMtvbE3UkaOKrWrDNAGgyTvYCOusVPmXj3GnyAzo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RwimTWxNxULCIVHJDhHaJr0lv+gAZtPunCjwpxGqT1X5biTEBjAaOMWATs4NVwCAQFHVmm2aUbVO5hCwcmrzQlYmxCynOns4OZhGI4NFmZb74X5+DVS1T+txUloczxnYA3fmxpzYZblf8tsA83/C7pLiIW7goxkxoxm9LLkEoE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=pDysZXTz; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1710938498;
	bh=aAUO3lBXXGEBX6m0mDWiKt/o6NIO+aW9sgNR3bVCTzM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pDysZXTzTiDSH5YK83UMRNylp4bt3GRo9FqWpe4cSIZaBBNSpjoWU4c8LgsbhE/fO
	 X6odEhE6xCTe/ljsHRjTiypNHXMRrRuLN0Jzr1ijy3wx6sdbjDAAD6ANTVsuiYgGqP
	 KvdJhqtU/7p0prvn4cQit8rb/kknkkiYK+gl00l6bCaMDfld2Dz0EUNFKN6MHmgSHr
	 fpNcLtH5iVCiEo35T2c6jwEPJ3CF5cW8uG2cIgdO2A/Kq43uA9A2L4REaElcaavRkI
	 YYc2ExUMozicvZxsnZ7AMzsh69Li6ZSVxoSj4g4xx/z/0NrXlCrzaOmeJa1qSBOLvi
	 mHIZqaIMWlFng==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V07WP12Rxz4wcQ;
	Wed, 20 Mar 2024 23:41:36 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc: netdev@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 linuxppc-dev@lists.ozlabs.org, wireguard@lists.zx2c4.com,
 dtsen@linux.ibm.com, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Cannot load wireguard module
In-Reply-To: <20240319124742.GM20665@kitsune.suse.cz>
References: <20240315122005.GG20665@kitsune.suse.cz>
 <87jzm32h7q.fsf@mail.lhotse> <87r0g7zrl2.fsf@mail.lhotse>
 <20240318170855.GK20665@kitsune.suse.cz>
 <20240319124742.GM20665@kitsune.suse.cz>
Date: Wed, 20 Mar 2024 23:41:32 +1100
Message-ID: <87le6dyt1f.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Michal Such=C3=A1nek <msuchanek@suse.de> writes:
> On Mon, Mar 18, 2024 at 06:08:55PM +0100, Michal Such=C3=A1nek wrote:
>> On Mon, Mar 18, 2024 at 10:50:49PM +1100, Michael Ellerman wrote:
>> > Michael Ellerman <mpe@ellerman.id.au> writes:
>> > > Michal Such=C3=A1nek <msuchanek@suse.de> writes:
>> > >> Hello,
>> > >>
>> > >> I cannot load the wireguard module.
>> > >>
>> > >> Loading the module provides no diagnostic other than 'No such devic=
e'.
>> > >>
>> > >> Please provide maningful diagnostics for loading software-only driv=
er,
>> > >> clearly there is no particular device needed.
>> > >
>> > > Presumably it's just bubbling up an -ENODEV from somewhere.
>> > >
>> > > Can you get a trace of it?
>> > >
>> > > Something like:
>> > >
>> > >   # trace-cmd record -p function_graph -F modprobe wireguard
>
> Attached.

Sorry :/, you need to also trace children of modprobe, with -c.

But, I was able to reproduce the same issue here.

On a P9, a kernel with CONFIG_CRYPTO_CHACHA20_P10=3Dn everything works:

  $ modprobe -v wireguard
  insmod /lib/modules/6.8.0/kernel/net/ipv4/udp_tunnel.ko
  insmod /lib/modules/6.8.0/kernel/net/ipv6/ip6_udp_tunnel.ko
  insmod /lib/modules/6.8.0/kernel/lib/crypto/libchacha.ko
  insmod /lib/modules/6.8.0/kernel/lib/crypto/libchacha20poly1305.ko
  insmod /lib/modules/6.8.0/kernel/drivers/net/wireguard/wireguard.ko
  [   19.180564][  T692] wireguard: allowedips self-tests: pass
  [   19.185080][  T692] wireguard: nonce counter self-tests: pass
  [   19.310438][  T692] wireguard: ratelimiter self-tests: pass
  [   19.310639][  T692] wireguard: WireGuard 1.0.0 loaded. See www.wiregua=
rd.com for information.
  [   19.310746][  T692] wireguard: Copyright (C) 2015-2019 Jason A. Donenf=
eld <Jason@zx2c4.com>. All Rights Reserved.


If I build CONFIG_CRYPTO_CHACHA20_P10 as a module then it breaks:

  $ modprobe -v wireguard
  insmod /lib/modules/6.8.0/kernel/net/ipv4/udp_tunnel.ko
  insmod /lib/modules/6.8.0/kernel/net/ipv6/ip6_udp_tunnel.ko
  insmod /lib/modules/6.8.0/kernel/lib/crypto/libchacha.ko
  insmod /lib/modules/6.8.0/kernel/arch/powerpc/crypto/chacha-p10-crypto.ko
  modprobe: ERROR: could not insert 'wireguard': No such device


The ENODEV is coming from module_cpu_feature_match(), which blocks the
driver from loading on non-p10.

Looking at other arches (arm64 at least) it seems like the driver should
instead be loading but disabling the p10 path. Which then allows
chacha_crypt_arch() to exist, and it has a fallback to use
chacha_crypt_generic().

I don't see how module_cpu_feature_match() can co-exist with the driver
also providing a fallback. Hopefully someone who knows crypto better
than me can explain it.

This diff fixes it for me:

diff --git a/arch/powerpc/crypto/chacha-p10-glue.c b/arch/powerpc/crypto/ch=
acha-p10-glue.c
index 74fb86b0d209..9d2c30b0904c 100644
--- a/arch/powerpc/crypto/chacha-p10-glue.c
+++ b/arch/powerpc/crypto/chacha-p10-glue.c
@@ -197,6 +197,9 @@ static struct skcipher_alg algs[] =3D {
=20
 static int __init chacha_p10_init(void)
 {
+	if (!cpu_has_feature(PPC_FEATURE2_ARCH_3_1))
+		return 0;
+
 	static_branch_enable(&have_p10);
=20
 	return crypto_register_skciphers(algs, ARRAY_SIZE(algs));
@@ -207,7 +210,7 @@ static void __exit chacha_p10_exit(void)
 	crypto_unregister_skciphers(algs, ARRAY_SIZE(algs));
 }
=20
-module_cpu_feature_match(PPC_MODULE_FEATURE_P10, chacha_p10_init);
+module_init(chacha_p10_init);
 module_exit(chacha_p10_exit);
=20
 MODULE_DESCRIPTION("ChaCha and XChaCha stream ciphers (P10 accelerated)");


Giving me:

  $ modprobe -v wireguard
  insmod /lib/modules/6.8.0-dirty/kernel/net/ipv4/udp_tunnel.ko
  insmod /lib/modules/6.8.0-dirty/kernel/net/ipv6/ip6_udp_tunnel.ko
  insmod /lib/modules/6.8.0-dirty/kernel/lib/crypto/libchacha.ko
  insmod /lib/modules/6.8.0-dirty/kernel/arch/powerpc/crypto/chacha-p10-cry=
pto.ko
  insmod /lib/modules/6.8.0-dirty/kernel/lib/crypto/libchacha20poly1305.ko
  insmod /lib/modules/6.8.0-dirty/kernel/drivers/net/wireguard/wireguard.ko
  [   19.657941][  T718] wireguard: allowedips self-tests: pass
  [   19.662501][  T718] wireguard: nonce counter self-tests: pass
  [   19.782933][  T718] wireguard: ratelimiter self-tests: pass
  [   19.783114][  T718] wireguard: WireGuard 1.0.0 loaded. See www.wiregua=
rd.com for information.
  [   19.783223][  T718] wireguard: Copyright (C) 2015-2019 Jason A. Donenf=
eld <Jason@zx2c4.com>. All Rights Reserved.
=20=20

cheers

