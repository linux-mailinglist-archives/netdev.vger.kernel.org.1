Return-Path: <netdev+bounces-250535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1EDD3227A
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 14:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E5D013002867
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 13:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5CC285CBC;
	Fri, 16 Jan 2026 13:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="K9BQh4a8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE53284B4F
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 13:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768571670; cv=none; b=QFmJkXyEUTcEIvazd6w1sLdMPlfPcV2ymsZv/eI8Qjf911r1dGoftYur5NaTx6OHsNbTa7nfYdl3NjGBxcmVkmPyky4c3X1S5ujod+bQCUN9ZoZ3dY7w/zUVKNZJg+x84W0d1nWqpstzT0gK2k8s16W0BrTt5z4glHNvH8Fid7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768571670; c=relaxed/simple;
	bh=2Jyc4vjPWHQ8N29GFPPd4QPUxfDxmdAZddY3K56YrUM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZcJLsmF6785zCEs/sUYt2S8MGxJw3y9k86n55A5xalymGE6NWINa84svYZRfHLuf1oTrDd6VRWMc2VPFklxyIKnZP1xuCzVNzB5BQXONhfprtDKUXG42eFA7kGP6grB9IykE+l7pQ4Hgz+LPMgbhnzNUBG5gwN36nXU78YXowCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=K9BQh4a8; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42fbc544b09so1465858f8f.1
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 05:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768571667; x=1769176467; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Jyc4vjPWHQ8N29GFPPd4QPUxfDxmdAZddY3K56YrUM=;
        b=K9BQh4a8aZ5mcKvc22cHMHLYT6xwWRlRDeFBc2yLrCgG0AD47CVxTHoudVy98hUYOc
         8bz86qaXlX2ZPMbs6RD/y5QKpWaA2GaVWL1SlttExDux1BkhdSSjJGj5/ElT8LfTRm0+
         dj11njKu65iXAGj2QJJmrd4/HlC/cezwhU90d5bCTuuOxZZguFikqJKi4Zt3Q+he34s/
         x546B1I5RhsHx3bVNBC5pay8PP+oIJKrC3sfGWazehRAVlttZgr5xF9YLRMrNBHA/fzP
         SOvipZeJoypOVTD+4P+zmxHD/tNOqnJRl42CfhiuvQllYWg/t6psKMiZNwSnWmO4I2BZ
         kWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768571667; x=1769176467;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Jyc4vjPWHQ8N29GFPPd4QPUxfDxmdAZddY3K56YrUM=;
        b=Ae7zJvecU8MZPV5kuYeY8Gjufl9gNXxom7eT02RjnOwsYQlSmOy49G7Qg6AQgNvBAz
         eKdwPTHz/lxyArB6JJzxomAw3xok8QtVtaS/NaiyVwwEwzcBrkTexx7VAXJVlcCIyXS+
         10tfjl33SP3mxAsA4SXBema1FNUgOAUg8XHm+xNRZ+EfuoS5dRM3/IO4FXTZJLOIgOxx
         eNfQAJFvJa6CWwfBxgsx16W0eiMX3O2KBt6MlnfXJzrnTU8Wml/xduY7oOZtGenOymp3
         kheh6FYR9t/p3LL26WcJlnAjC+6enaYGqvK6jz1LaEZFwz6LE7DrFHlZhfklgp4prTUG
         PBSw==
X-Forwarded-Encrypted: i=1; AJvYcCWJ52X5F2wQMthKsSXFtulhDRO/R2c8qegv7FqB+oCoiA3M0L1U/Z769lUqhhMXhg4pZJ7z/6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ebxwlYFtHHx2PqK85XNEUXxTO4geMPu13vIgJcg1E5MtvEje
	kWigMRM2WJ/6kUrupOxMjlJTi2W6mPV820tbt9V3cN8xWyuuC0RehGA7QXLbMuHLEWQ=
X-Gm-Gg: AY/fxX6abZ+Ofs6+XTBht+tU8MtdpiiKSyGt8ZKR2THIz9pxsHzA+2sf//RAnf6ExDz
	SfCgrqhX8G9KDKTZ0XAcPzV1E96fLSGdtoGCDYxliquADxLDtiF8cpKn8HIdOzk+XH5AJ+/8+bw
	WygGP6ODi2rxeeySuAYaLTWP17NSKVod8TJU6HMN/V+BcrJwwrIVjpEN4WU3XdujbbwDpKmtEk3
	wxlyYcb+osG9BUSrCKpgt5F4HTsxg7m4Uc9xhB8RJHdl2T1yNFsbMA18PbEHNib9lN2d0AbUCQ1
	zyJXAekNoiSjTEG4ATWG9v4uwGRIM+LTRa6MddN+kTDToZ0Z5EEsrAGf2kavq1EJc8yAkgjrX88
	Mic5ey4jATvcY5JLzcObhPfMgEKQ3o+Alg2EYJHOIXzH7SOK6/QzwgXED0rr6JQi7Lf6RF2WlrO
	jPe47Qrve++JUpWOqnA7luLABFEhouxNdry+LV6Tw=
X-Received: by 2002:a05:6000:4387:b0:431:1ae:a3d0 with SMTP id ffacd0b85a97d-435699810a1mr3695386f8f.25.1768571667158;
        Fri, 16 Jan 2026 05:54:27 -0800 (PST)
Received: from [192.168.3.33] (97.36.160.45.gramnet.com.br. [45.160.36.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435696fbea8sm5433542f8f.0.2026.01.16.05.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 05:54:26 -0800 (PST)
Message-ID: <6168099632390068c8544b48f2e81bf737aa10d7.camel@suse.com>
Subject: Re: [PATCH 14/19] drivers: hwtracing: stm: console.c: Migrate to
 register_console_force helper
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Richard
 Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg	
 <johannes@sipsolutions.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>, Douglas Anderson	
 <dianders@chromium.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt	
 <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, Jiri Slaby <jirislaby@kernel.org>,
 Breno Leitao <leitao@debian.org>,  Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet	
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni	
 <pabeni@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook	
 <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"	
 <gpiccoli@igalia.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy	 <christophe.leroy@csgroup.eu>, Andreas Larsson
 <andreas@gaisler.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Jacky Huang	
 <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, Laurentiu
 Tudor	 <laurentiu.tudor@nxp.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org, 
	netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	sparclinux@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Date: Fri, 16 Jan 2026 10:54:14 -0300
In-Reply-To: <83zf6daetu.fsf@black.igk.intel.com>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
	 <20251227-printk-cleanup-part3-v1-14-21a291bcf197@suse.com>
	 <83zf6daetu.fsf@black.igk.intel.com>
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

On Fri, 2026-01-16 at 14:04 +0100, Alexander Shishkin wrote:
> Marcos Paulo de Souza <mpdesouza@suse.com> writes:
>=20
> > The register_console_force function was introduced to register
> > consoles
> > even on the presence of default consoles, replacing the CON_ENABLE
> > flag
> > that was forcing the same behavior.
> >=20
> > No functional changes.
> >=20
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
>=20
> Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>

Thanks Alexander!

>=20
> Should I pick this up or will you send this with the rest of the
> series?

I'll need a v2, since some things will also change in other parts of
the patchset, so I would wait for the next version.

>=20
> Cheers,
> --
> Alex

