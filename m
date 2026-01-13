Return-Path: <netdev+bounces-249435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2623D18EE6
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 13:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CA0A309A883
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 12:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FC238F949;
	Tue, 13 Jan 2026 12:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fRVKHqti"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E0738BF9E
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 12:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768308116; cv=none; b=UnKnQlGpA4srJecwI55mihAg1FubfwSgwb8qL26d04l2XfYqMu2XNnl3T41FtRXpYpkkADQNCz9PFCrMeEGBFpMFJVjeWdSVFp/bOAupFZn4Yl+h8EyWM5HV2/KtuAKHfLoBQhrOHEheEBkwLvApQ2FXMMxY0hwNhIj8uXQHwhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768308116; c=relaxed/simple;
	bh=4O/QKnJy0mgeinip5BHk/HuNTgwgeS2i878VGcuximU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R4tZJ9gQ1eLDZhpcnLkpRJzWU/1K62Vd0MyJhEtmFC+LEyZWQq1IXxDefMxZn1n5kDIMM6SBe7z+pSt79isPVMDtELKKZSfqLjY/tC2bymAZm8NY0CZA0XME33KSZKVMLJnBkfWgqVj72vdePyYvhYi25e6i1jNsT20xehh3sL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fRVKHqti; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so71987895e9.1
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 04:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768308113; x=1768912913; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2dC4SplNK0CZduFW6/ZkQ29d/9pNlTULD+NHFTfquXY=;
        b=fRVKHqtitRt7aDAXPRYu506G5Ytwzf8hcFy27vH8i+FlRo+tkbAGjcjtXvKoMHUPci
         RHxMzomlVLe76t9tcFgiVsqr2QxQqxck+pSkDKfh9VNKxojK/Smo2Z5AmrptYdJI59M3
         A6y+LbDMWuXyXpbzNdgaPeAgxmE+RJuxtW+xoegjeajNbe1ANij7BBQPRW61gwEXxV4o
         A+t4h7l4xZoC3ymVTqnksmU0IvSChVgNeDGoL0j/XFaShdI6SUjv3CyUiA5rwq7FAJQ0
         L92eXpwJU2MbdacV3ijX3WwllU7V1dRBFwbPgHQJbmPP8Lfa6zjxFsRTB0kQn2Qr8oqF
         O/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768308113; x=1768912913;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2dC4SplNK0CZduFW6/ZkQ29d/9pNlTULD+NHFTfquXY=;
        b=b0mM+OUMKJMxNRyj44Dgu7ApQmu6QeDRJE1FUN8TVgELuKcmqYc2mt0wYsGmBA1hrR
         Xxd6UMXSbQjGzgTNx1LJy6d8wpXIsa3naO/3DIRlyhtteW0Bk3JfhXz4x0u3N8DBqG0E
         XqEFce4TMZ6NF0lG+HL8XVoxejYmkWKlELPoEMwxcvxIgwW+xqM4hFPv9clmcK4eDyuc
         mXNuVzMwXeLOlfhLTa4q+W73MfeLNHM+s+3TXC8TOfYZljxuGMhkm8G4Cuo2314ec1vf
         6P/Kf3jqD32271g5Cg87s8F+L5VafgDwTaT9/zHORQXLj1gCqbEI4EDzIPBos3p8zrcd
         QiSA==
X-Forwarded-Encrypted: i=1; AJvYcCUqhVlr4WOML8N8RNj1JSyw5CWW2TaD/VO1a5wmY2MQUg5kj/cWY/PclzXzYTM7aVnG0p6lwHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTOSKC97iuiNcfXotPCUtAmtlAvnIM1cH8B8wlFS7jnBsrhJdf
	DAtAexXb3iY+q4Zq8ew0fpkqpiuuSZWt1G22TkqbfSkuyhGt/a6bkI6px376JHgTdtQ=
X-Gm-Gg: AY/fxX7k9ZXpH48qlgVtf3q+qPZmh5m+KcLnKi0FaUU4cCb4iAl0RMI99OJJKMYCM7X
	JR/pd6Q7zwPS22fQfXRazJ5/SAsmRHBZ3jRqLsTHZmZxxaJvFy3MbDsTjnBG0K3Io0+WQpM3IPK
	yTdeW9OKHpO/psijPHHkjkx/AdiYBrdOmUfaIwNYnBjDWO3C0Z01Bo+nk8xgz0vnt9YedWZZpT1
	U0imHGnzEJf4C7cTQId570EjV6Bd0IUSxEMTLW2aEHlptZujjbBU1LWRodBojvxohPNFEsCGk90
	B/df7gfT8tdlsGr7ssvokRJmBw0+Uq6WedybRhjZTPFh6bO7dg7nqrYP/Cl7Aox//1gJFspVdWN
	k0jNSJ2QBtoZ32jQB3zFGLhQLdcXfPa2p5vetvgOIJT+e7+oPD+e9/QFClcvCdFQfmYCJDh8+rt
	tAP0xUvGG0EXqUmhM2eV4o1eDFkDG0xR8n//QYM1MScQ==
X-Google-Smtp-Source: AGHT+IFNQeuw9WMG2h1Davmi36cm1P3WLycSIMCVChnxdfpM9EbZrc4Y9nv7bv2r6hTzREDcGxTpbg==
X-Received: by 2002:a05:600c:a08:b0:477:79c7:8994 with SMTP id 5b1f17b1804b1-47d84b4900bmr279773315e9.30.1768308112530;
        Tue, 13 Jan 2026 04:41:52 -0800 (PST)
Received: from [192.168.3.33] (218.37.160.45.gramnet.com.br. [45.160.37.218])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5013bd680a1sm10831771cf.16.2026.01.13.04.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 04:41:51 -0800 (PST)
Message-ID: <a5d83903fe2d2c2eb21de1527007913ff00847c5.camel@suse.com>
Subject: Re: [PATCH 00/19] printk cleanup - part 3
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Daniel Thompson <daniel@riscstar.com>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov	
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson	 <danielt@kernel.org>, Douglas Anderson
 <dianders@chromium.org>, Petr Mladek	 <pmladek@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, John Ogness	 <john.ogness@linutronix.de>, Sergey
 Senozhatsky <senozhatsky@chromium.org>,  Jiri Slaby <jirislaby@kernel.org>,
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook	
 <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"	
 <gpiccoli@igalia.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy	 <christophe.leroy@csgroup.eu>, Andreas Larsson
 <andreas@gaisler.com>,  Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue	
 <alexandre.torgue@foss.st.com>, Jacky Huang <ychuang3@nuvoton.com>, 
 Shan-Chun Hung <schung@nuvoton.com>, Laurentiu Tudor
 <laurentiu.tudor@nxp.com>, linux-um@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, 
	linux-serial@vger.kernel.org, netdev@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-hardening@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, 	linux-fsdevel@vger.kernel.org
Date: Tue, 13 Jan 2026 09:41:34 -0300
In-Reply-To: <aVvF2hivCm0vIlfE@aspen.lan>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
	 <aVuz_hpbrk8oSCVC@aspen.lan> <aVvF2hivCm0vIlfE@aspen.lan>
Autocrypt: addr=mpdesouza@suse.com; prefer-encrypt=mutual;
 keydata=mDMEZ/0YqhYJKwYBBAHaRw8BAQdA4JZz0FED+JD5eKlhkNyjDrp6lAGmgR3LPTduPYGPT
 Km0Kk1hcmNvcyBQYXVsbyBkZSBTb3V6YSA8bXBkZXNvdXphQHN1c2UuY29tPoiTBBMWCgA7FiEE2g
 gC66iLbhUsCBoBemssEuRpLLUFAmf9GKoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 QemssEuRpLLWGxwD/S1I0bjp462FlKb81DikrOfWbeJ0FOJP44eRzmn20HmEBALBZIMrfIH2dJ5eM
 GO8seNG8sYiP6JfRjl7Hyqca6YsE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-01-05 at 14:08 +0000, Daniel Thompson wrote:
> On Mon, Jan 05, 2026 at 12:52:14PM +0000, Daniel Thompson wrote:
> > Hi Marcos
> >=20
> > On Sat, Dec 27, 2025 at 09:16:07AM -0300, Marcos Paulo de Souza
> > wrote:
> > > The parts 1 and 2 can be found here [1] and here[2].
> > >=20
> > > The changes proposed in this part 3 are mostly to clarify the
> > > usage of
> > > the interfaces for NBCON, and use the printk helpers more
> > > broadly.
> > > Besides it, it also introduces a new way to register consoles
> > > and drop thes the CON_ENABLED flag. It seems too much, but in
> > > reality
> > > the changes are not complex, and as the title says, it's
> > > basically a
> > > cleanup without changing the functional changes.
> >=20
> > I ran this patchset through the kgdb test suite and I'm afraid it
> > is
> > reporting functional changes.
> >=20
> > Specifically the earlycon support for kdb has regressed (FWIW the
> > problem bisects down to the final patch in the series where
> > CON_ENABLED
> > is removed).
> >=20
> > Reproduction on x86-64 KVM outside of the test suite should be
> > easy:
> >=20
> > =C2=A0=C2=A0=C2=A0 make defconfig
> > =C2=A0=C2=A0=C2=A0 scripts/config \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --enable DEBUG_INFO \
> > 	--enable DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
> > 	--enable DEBUG_FS \
> > 	--enable KALLSYMS_ALL \
> > 	--enable MAGIC_SYSRQ \
> > 	--enable KGDB \
> > 	--enable KGDB_TESTS \
> > 	--enable KGDB_KDB \
> > 	--enable KDB_KEYBOARD \
> > 	--enable LKDTM \
> > 	--enable SECURITY_LOCKDOWN_LSM
> > =C2=A0=C2=A0=C2=A0 make olddefconfig
> > =C2=A0=C2=A0=C2=A0 make -j$(nproc)
> > =C2=A0=C2=A0=C2=A0 qemu-system-x86_64 \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -m 1G -smp 2 -nographic \
> > 	-kernel arch/x86/boot/bzImage \
> > 	-append "console=3DttyS0,115200 kgdboc=3DttyS0
> > earlycon=3Duart8250,io,0x3f8 kgdboc_earlycon kgdbwait"
>=20
> Actually I realized there was a simpler reproduction (hinted at by
> the
> missing "printk: legacy bootconsole [uart8250] enabled" in the
> regressed
> case). It looks like the earlycon simply doesn't work and that means
> the
> reproduction doesn't require anything related to kgdb at all. Simply:
>=20
> =C2=A0=C2=A0=C2=A0 make defconfig
> =C2=A0=C2=A0=C2=A0 make -j$(nproc)
> =C2=A0=C2=A0=C2=A0 qemu-system-x86_64 -m 1G -smp 2 -nographic -kernel
> arch/x86/boot/bzImage \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -append "earlycon=3Duart8250,i=
o,0x3f8"
>=20
> With the part 3 patchset applied I get no output from the earlycon
> (without the patch set I get the early boot messages which, as
> expected,
> stop when tty0 comes up).

Hi Daniel, sorry for the late reply! Lots of things to check lately :)

Ok, I reproduced here, thanks a lot for testing kgdboc, it's a quick
way to check that the new register_console_force is not working. Let me
take a look to find what's wrong. Thanks a lot for finding this issue!

>=20
>=20
> Daniel.

