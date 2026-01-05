Return-Path: <netdev+bounces-247068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66525CF4338
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 15:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C743316153E
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 14:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894EB33B6FE;
	Mon,  5 Jan 2026 14:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="H9+hkPjh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3625C33A6F1
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 14:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767622120; cv=none; b=M+MzOg2pKnX0KTal6UfiH12qK/6Q4IVuqnuDK32Gh3NU1+WXef/gUC5HZECUhx2LQDuRZ0GRwBPKAXNbxwleRUy9ckX13TO68d2NjZVTb7ZG+3lF3wOw93Yj66A74ooqfMavy8WGhsjx94snZEHZ9fEP/PMljvzsmxRMajcLq1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767622120; c=relaxed/simple;
	bh=r3I6M7kWHIbwx8pg9jWTMfz8fscetYU9L971EGe7OZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8bJ516jrxkvBj9YQGoGkdbfeSsSZyB78MbP3n1TQZPZc4/0X1TYSUedOJ0Tl1Z9Wm6TY7Q8ad5I3w7f5BthueEvBYCviSKe/jAtXwwVf6E+vogAvHWHV1NhHT4MDqXYg6C7O7m58e7xwVbZrhGqrk/DSdWciqtplO1i7E/NIM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=H9+hkPjh; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-432777da980so4216057f8f.0
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 06:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1767622109; x=1768226909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kq3TtsxUy/q4IZcqauYlg+KhZOOjIgyB7YRbMBjceZQ=;
        b=H9+hkPjhAyTEos4JbC3SAHaK4U1jFi/jCKRwkG3H3+42Ugy69WLCmKacOeNmxPOKw0
         Ix+pwpDSjEpf1yAwNXdsT20c7NqUd5oHunNPqzsePlSzps5WYOiSx5uiCtjGUY1TIUPv
         t3T9IoS8ShGcJgfzjL2u6Q1kdVMwGv1f8pIgH0DMcox24h5IEYh+Atzg4WxOTvniWzK+
         G51sNEh08yMuuRlk8CmnRljUjsg5kNffJGszJhny8HWJRogQSvnCbU6DTnjhLeuxTHmy
         I4XskcK1GoHISE8qrTfNJmMx/D+rH0FMktQJVeTsE0D2xA7ox80+XRiyZ3oSBGef62e1
         HWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767622109; x=1768226909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kq3TtsxUy/q4IZcqauYlg+KhZOOjIgyB7YRbMBjceZQ=;
        b=UaNilKmAoyfNEWgnaANA46ik5bAeqb3YxLL5N3Cd6E298CPChBQIiYLNnGZL3FgYvl
         AcCTFNjFBxoxHilauZVBQriEIQlnzW8Xri+jfPZcQ/dn0oDd6J1S02IWvaoXkI8zjGKj
         HBWaMctjvTHslTlElUO5MGb82sNvPDGwWAjm0l71OzNCozBXBxdvIIz51PH0xz3Jds7R
         4tzNaf67SewM+b/KvmtMc94C2ZXZrDJOCZp+UVGMixgn0pWyl8Oh1bPaeYHnXrVZFb//
         eGxxzCilwdI4SIlgcPxN4AZjEsbCp5nPtHDOWf2+SkzTSUF09MO87mnWKOoBMfZTIgJY
         KAfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4mXvQ1JAP+qETPXM9IZ5onakfvZhhj6MxxLOyv4+ILZUY6eyKpNwEeWSPVHmzMAi2SCRtWkw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp8j6uo0bbiVco1ibINs27n+qQwf+m4ZzRq8kI9EDNOhrv3XQ+
	TaaJM5cBuMJRumHSZW/UnLehIPLEUTkYjwoyez2TX0egpBYERF7xN2tc8zSUnzHdQ20=
X-Gm-Gg: AY/fxX5wIMWsfd5MKXDAdf+V2vlgjZzP8z36rBWx/+UXNPyOvgF2OcQ3riUC4heIob9
	6CEGToSoyn9Z64FPxorrbANOHg7WNEiYUd0mE0Vuf+PQdbQSi4fNInMIwpqG70/Qk5S2YJZU8W2
	4tncs/3eIhb5FlMwtenK0pXvUy+Ia2TAWqth102dWcHxRbKVjYHSGNaaXEKzBPz+HevqAPO+xZ1
	d8I6lk4/n3tXJOqOIzfSgudwbre+TSh+c8RCaSQV+Jb28oRDzwF41q1kxOn0JvkLvQhM42YlErB
	4WCW1s+aplV+kCNEG4Ap+N8zbkD9fbJuncuhW1uuAlzbhatVasKu5lCt04AnPkiHKMUat9j0kaq
	YqfkrtHWc1z/NkCQiRx3rX2qbe71m9brhJLtytIXEKLUGqiPfsB8pyc8dkp7iysn22uz076XYK6
	QuS8tkepODcm9bT10KE7GbTx5UT5YuQ82/HfrTYtA201I3tfzXGObYcJBChlw44dyvjvQa6eo9Q
	hSj9gkOYBkfHmEK9qj14iX6hSGxiYpGurL/Zb+qiH16USeX8g2cDOClySHx1TIyTHM3MweB
X-Google-Smtp-Source: AGHT+IFtm/KgnS/DHXZ241C9Tii09D9IuHplpok3aN88rFmOsLWOymloQBuensoLNVO5jV8TaARwoQ==
X-Received: by 2002:a5d:4842:0:b0:432:84ee:186d with SMTP id ffacd0b85a97d-43284ee2de1mr31846134f8f.62.1767622109438;
        Mon, 05 Jan 2026 06:08:29 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1b1b1sm100250524f8f.3.2026.01.05.06.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 06:08:29 -0800 (PST)
Date: Mon, 5 Jan 2026 14:08:26 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andreas Larsson <andreas@gaisler.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
	netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/19] printk cleanup - part 3
Message-ID: <aVvF2hivCm0vIlfE@aspen.lan>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <aVuz_hpbrk8oSCVC@aspen.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVuz_hpbrk8oSCVC@aspen.lan>

On Mon, Jan 05, 2026 at 12:52:14PM +0000, Daniel Thompson wrote:
> Hi Marcos
>
> On Sat, Dec 27, 2025 at 09:16:07AM -0300, Marcos Paulo de Souza wrote:
> > The parts 1 and 2 can be found here [1] and here[2].
> >
> > The changes proposed in this part 3 are mostly to clarify the usage of
> > the interfaces for NBCON, and use the printk helpers more broadly.
> > Besides it, it also introduces a new way to register consoles
> > and drop thes the CON_ENABLED flag. It seems too much, but in reality
> > the changes are not complex, and as the title says, it's basically a
> > cleanup without changing the functional changes.
>
> I ran this patchset through the kgdb test suite and I'm afraid it is
> reporting functional changes.
>
> Specifically the earlycon support for kdb has regressed (FWIW the
> problem bisects down to the final patch in the series where CON_ENABLED
> is removed).
>
> Reproduction on x86-64 KVM outside of the test suite should be easy:
>
>     make defconfig
>     scripts/config \
>         --enable DEBUG_INFO \
> 	--enable DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT \
> 	--enable DEBUG_FS \
> 	--enable KALLSYMS_ALL \
> 	--enable MAGIC_SYSRQ \
> 	--enable KGDB \
> 	--enable KGDB_TESTS \
> 	--enable KGDB_KDB \
> 	--enable KDB_KEYBOARD \
> 	--enable LKDTM \
> 	--enable SECURITY_LOCKDOWN_LSM
>     make olddefconfig
>     make -j$(nproc)
>     qemu-system-x86_64 \
>         -m 1G -smp 2 -nographic \
> 	-kernel arch/x86/boot/bzImage \
> 	-append "console=ttyS0,115200 kgdboc=ttyS0 earlycon=uart8250,io,0x3f8 kgdboc_earlycon kgdbwait"

Actually I realized there was a simpler reproduction (hinted at by the
missing "printk: legacy bootconsole [uart8250] enabled" in the regressed
case). It looks like the earlycon simply doesn't work and that means the
reproduction doesn't require anything related to kgdb at all. Simply:

    make defconfig
    make -j$(nproc)
    qemu-system-x86_64 -m 1G -smp 2 -nographic -kernel arch/x86/boot/bzImage \
        -append "earlycon=uart8250,io,0x3f8"

With the part 3 patchset applied I get no output from the earlycon
(without the patch set I get the early boot messages which, as expected,
stop when tty0 comes up).


Daniel.

