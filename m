Return-Path: <netdev+bounces-249123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B84D14902
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 18:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F9D830217AD
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 17:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4718374171;
	Mon, 12 Jan 2026 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HIrT55Tp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3FF35503F
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 17:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240414; cv=none; b=sFQ31PaM1KRP5/kzS8y69FsX/sIX8V3aJNYlEso9/2Kb/QGswcdfBdhojnPiTQiavOHE0z3+yukc7H3Q0PdyAT06gzSVrA5VZKpbiyQOQoLwzGsqYCuNy4waf4AwS59gaYBg3Ke549wp3sO0BBWxjcofas14+aEK6/SIOcxWBzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240414; c=relaxed/simple;
	bh=y6BPssvuqQ/qH26ZtP7OKYRtO9FGOS74oztLC07SRNg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pXLcuNGU7O6E43WPIWN4Amc0mUf7ZBddJJFr+gUDkh5S7Z02TRIvCX3cQLoRrd02UQ/Jtmnv7Hrzzm/RiIU19lgN0XNU5nn45Vv4MUIRVAlGwiRifa293mEaO2xIkau90EBFwgoqoniCGqmM904MWoOWe4D6J/2YqOq6si/dgV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HIrT55Tp; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so68404265e9.1
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 09:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768240410; x=1768845210; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y6BPssvuqQ/qH26ZtP7OKYRtO9FGOS74oztLC07SRNg=;
        b=HIrT55Tppvg0XFYV5zS20v5xaWtuqbHwmR0+5GnSOqV3Zkqr+5e4bRVOWGa7T+G+dc
         d5rshviEoUDadI8tfAjFRPSFxopu/3PZCFonHcYWFfwYqBaRD1P2ccUPAZOw57poJIgk
         2o8Rq8MaIxKEDfVpi5OxW0oI7odIOVqyt0hNuhOTtPiDtjFXs91fI/lOWlNPLoY/ZaeM
         mV7icrjbWluhuD2o9cvBSF4+skVjcVoRRmaIlc9BDsb4AbDqtsuQdXMpggf1CiXHQlfo
         0FMj/pO63Bpync6rTiNgO02fKipgreSs9DrEqYwDCCSf/g0s+4H5xMDOF0UtZgbuZmby
         4Rrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768240410; x=1768845210;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y6BPssvuqQ/qH26ZtP7OKYRtO9FGOS74oztLC07SRNg=;
        b=M/9ae7uCx4nj17VAdMJGqdFxR4qs5yOs9etKtaJpaMUPsq/x/ohqBTVEzm/rPKjI1J
         ZWcL1xCI28XBlPatqqmQsgU5mjlhOMEHEUgaZzMB/aFv1K/l0sKoYJE5xJmT7DZXMCaf
         6G/Kf8Ib3j5dfb0YGmLGKoKSM9QVRfK4Xs0RX6FlVwJrNDcyGrOM9p0pkURvUqjfC0NT
         WxWy9eh/Q1H1sG8q46PHCcPBr3T1msMxAbAwj54PVux5HkyVfJ+Tewv4t2So+z0BWmit
         DMDrQB9hi7Rbr3hcbl3s39ohCG64m72IHudd8Lx+z/3woBR/Xu1lhLLuO67hI3mn8y8y
         TopA==
X-Forwarded-Encrypted: i=1; AJvYcCU2eOhDjCcN3wLCh7/+vkGNInTk40PVmJbRNJ6dK+XqxcCWJE0PIXuT8747CyWD55dGAQPmOtE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3OPKTjKv6/FFj7DhH79mrBF/7vabfcn74bIYk8wCfs/WKih2S
	mNKfWWsjR+obSJvG3TktU2WGJk/optgJ/6daNSOk1Ptzy5cHK4W0cA9WM4q9fLisnK4=
X-Gm-Gg: AY/fxX4jl5j3vjnuUY16oFVskY76jvqz69BNb9yrJvoYPZSDjpjwE8XoC5dmpjwL3pb
	D0J5Vzt8WcNZ2OAJW8Wre1mUEf5LKiXyTGD5xLaJcfB5NQnFqGOiEuQRQT5OZlpoRImwfDtYDd0
	vdo1IH+bzdK49QcDRNxP6WFFDh+HxJgrR5xkMVxrmzahzDfSCN0dtziw1T3sBwi+AfVb7zxoVrv
	a48a29YM1t81BAzmNKwWpIyu435T1SaqdYo02560aNRe4j1XKCp26jIt3g2Vlwzi0uycy5Hycq7
	MPEuddlcYG0mUt1eshUK5486N6+Y+ZMbbSHH3HZmosHZRV0tbxUxK9UUwc2zfhGX+I5oFE+j4NM
	uwPl6ZsarC4BOXqmeYlrdQEryETQ1JYAZBWeyetPe3vWsfox9eMnN1YNOSXmJcOnf3Ec4q4Ul5e
	ONTnpl0ena2QK45lsCx1VUxXvkpgXOZq+olK0kFxj+/Q==
X-Google-Smtp-Source: AGHT+IGfCgsoYudB43gyY5VgiMyajRCyMKVvdA/K1TPc0FTW2J7Pqnzu3xNux2u9C7uenfxIM0LM/g==
X-Received: by 2002:a05:600c:4e8a:b0:479:1b0f:dfff with SMTP id 5b1f17b1804b1-47d84b170famr247229235e9.10.1768240410449;
        Mon, 12 Jan 2026 09:53:30 -0800 (PST)
Received: from [192.168.3.33] (218.37.160.45.gramnet.com.br. [45.160.37.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f69e13bsm368953115e9.7.2026.01.12.09.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 09:53:30 -0800 (PST)
Message-ID: <0585581cd2f19544c5e1565a9d241697d812b5f9.camel@suse.com>
Subject: Re: [PATCH 00/19] printk cleanup - part 3
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Andreas Larsson <andreas@gaisler.com>, Richard Weinberger
 <richard@nod.at>,  Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes
 Berg <johannes@sipsolutions.net>, Greg Kroah-Hartman
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
 Christophe Leroy	 <christophe.leroy@csgroup.eu>, Alexander Shishkin	
 <alexander.shishkin@linux.intel.com>, Maxime Coquelin	
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>,  Jacky Huang <ychuang3@nuvoton.com>,
 Shan-Chun Hung <schung@nuvoton.com>, Laurentiu Tudor	
 <laurentiu.tudor@nxp.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org, 
	netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	sparclinux@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Date: Mon, 12 Jan 2026 14:53:12 -0300
In-Reply-To: <836139d1-1425-4381-bb84-6c2654a4d239@gaisler.com>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
	 <836139d1-1425-4381-bb84-6c2654a4d239@gaisler.com>
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

On Wed, 2026-01-07 at 11:22 +0100, Andreas Larsson wrote:
> On 2025-12-27 13:16, Marcos Paulo de Souza wrote:
> > The parts 1 and 2 can be found here [1] and here[2].
> >=20
> > The changes proposed in this part 3 are mostly to clarify the usage
> > of
> > the interfaces for NBCON, and use the printk helpers more broadly.
> > Besides it, it also introduces a new way to register consoles
> > and drop thes the CON_ENABLED flag. It seems too much, but in
> > reality
> > the changes are not complex, and as the title says, it's basically
> > a
> > cleanup without changing the functional changes.
>=20
> Hi,
>=20
> Patches 7-17 all say "replacing the CON_ENABLE flag" in their
> descriptions, which should rather be "replacing the CON_ENABLED
> flag".

That's true, thanks for spotting!

>=20
> Cheers,
> Andreas

