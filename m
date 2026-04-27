Return-Path: <netdev+bounces-281511-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDsqDyzc72kiHAEAu9opvQ
	(envelope-from <netdev+bounces-281511-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 23:59:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C5D47B031
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 23:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EDB753009F08
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 21:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CB837F8A4;
	Mon, 27 Apr 2026 21:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DtaZXDyY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEB835A393
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 21:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777327121; cv=none; b=VntiHF1TfHoDzSm8FTOV6etRHJOm0qH89kumZfPcrmc351ogfc9oBYsPvGNHuYS14V6Whe7Y2kNa71Adu5Vtl6Ov9zuxtrNioouvKEsh63QKu8SoWx174i7i9MPRhDfDpDznrWcwtYsNybwPdlJ/kWeVDEB32btQ41+XgO60XIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777327121; c=relaxed/simple;
	bh=7P7VU36hQu4iMsGekLZKiPL3rBFQOW0TOaXA+fXfycA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lONrAOLMxs+7YJB3H2wFoWi6C1EcVbQ67mmPuWAD7HyOuFFSdcp5zg42evdM1dWkPL4WugBYGbaN40+AQ7YNXLgadtONlSPL6aQiPd35q8bHnh1TUyhLwJAo/jaRCzgM4+kc7ium9PceipqqiO8VgBZdj2F3uz2TaGCQerQ8IeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DtaZXDyY; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ba92146cc86so1162515966b.1
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 14:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777327119; x=1777931919; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=DtaZXDyYEoIgGtXwFVNJEMtvUyj3shNDBsRE/s4Q0FpZ4u+DORHfGVen5G7FpaPfTD
         SX508qZ/a+fTyQCl7vX3eGaWqUHIBUc/AbFMIBsCF29VL2f42EN/m6HQTa9gyGwpIHeD
         cJ06tz8k5OwxAVarZkY3lQXTFGTLv0+pFeFnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777327119; x=1777931919;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=D6xQprIhkHQN2Rxrwny0YdNvyRt6VHL3w9hRXghTAAPFzirVGdLW7fSFzjPwBdWXd9
         j7EI7ghFn5O6mks8WPSetMCrw0u2bkk45tEMXxTQy45NHMvV4wD//6r5Uqh1PNakSLA0
         kwUE9XcTWNseTdltmTgPHC43Ig2+uHe1flfVucsKcVJP48MBmk/HxbFxR4Vrbm8NjnK7
         CKVIkiSoYf0Hsf+SvQ068Bd4XcgFu7Xwrq4q3rgU2HeMWeMLMIssd/bOG0KQ0yibAvck
         VeIY9fFY0EQ/U5OsgOLCUROV6+uPNGOps+VZQketR65x63VWeDhgiqEQ14WlX/oy1LLz
         wSNQ==
X-Forwarded-Encrypted: i=1; AFNElJ/sMCaYLNmXbQFksI1op713JJA7T7qEt0nCaG22WEDm0p6PQv6Rw0zK9OPyMy3MPRxgrkmcl7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNaeB1vyprob5V0IhklNKcqJYKOkQlKfaYbWZmLCpeLYn6XLih
	Ow2S6lMrX4a4sYZ26aR7pv1zkHbRsPdqjwVjo6XT0e/+3GCi9Gk5NDi+ZGgS2NAmLeffYH6GPEI
	pzDNQvz0v9A==
X-Gm-Gg: AeBDieucIjgDbdbFhqK3rPgIz+RKG0fJq1Wam76QmpT50IFvOUWW/8J42qSDc9VnE87
	LOsBP+lNlc60gtqT8sm2jtWjykAq08B8pvNN/0PIZ61VUEEQn/AyNsRvJQBFTpIWLwb9/AFzohT
	BC1OPAVAaPjgTmFbb4mwNALfQryGBOyxi8dEW2IAXCK/R4I3nbpFqcxH90ki+vAoxsj8zcwafHH
	T6KmASeFR93fy5OY0ui5XnT47wZRfUSO/Waj19vjmqGRPWSfODOSE0sw8D4eMTgvgLmdo76yF/j
	D4bYz87xD5ncJHGMq5hv9xcepRH3e2KymvF6iGuxLCanTHR+A8Yz5e1hRbEWANwRjp1LZ0etAvB
	aleMdxF0Yap217Yt+56GUIEnK8dQ1a5wUAG6RmnDsbXXh4Z6Gv6Riocts8AQNKR4G6JtlZQ8vuD
	7crly15Nl7aLRdgrhRDSLoYyY1xScLrtaqXv6Br/RgSukVAqLe75MwP4HZVOSpoOJyqxf8FYdKZ
	EbGp5GTk/I=
X-Received: by 2002:a17:907:25c2:b0:b9d:872f:f5b9 with SMTP id a640c23a62f3a-bb8037799c8mr30006666b.23.1777327118601;
        Mon, 27 Apr 2026 14:58:38 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80853c8a1sm11337466b.5.2026.04.27.14.58.38
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:58:38 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-676e62faf2bso10759941a12.1
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 14:58:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9426h1WZKPKrMsEV9zqI2rIbvQKelD0BYLqvheKWqjc/YfQ/4W+10oNyuQ6/h4j168JH6HHxk=@vger.kernel.org
X-Received: by 2002:a05:6402:35c2:b0:677:270f:6f4b with SMTP id
 4fb4d7f45d1cf-679bb04a8a7mr185115a12.1.1777326742385; Mon, 27 Apr 2026
 14:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <0ee46bb228d97163fbdc14f2a7c52b93d8bc34ce.1777306795.git.chleroy@kernel.org>
 <ae-j2_QirCySZD02@yury> <63a4d0f6-0eb3-48cd-9f98-bf7b223b2606@kernel.org> <ae-2yLWSGnfeTvh1@yury>
In-Reply-To: <ae-2yLWSGnfeTvh1@yury>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:52:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
X-Gm-Features: AVHnY4LQUFWo9ODz4M3q2vZC9Gn8nsdYr95Nd4ky5ERVHHxIyN_9ZXY5zjebfdc
Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 7/9] x86: Add unsafe_copy_from_user()
To: Yury Norov <ynorov@nvidia.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Laight <david.laight.linux@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, Yury Norov <yury.norov@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 43C5D47B031
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281511-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,gmail.com,linutronix.de,vger.kernel.org,lists.infradead.org,lists.ozlabs.org,lists.freedesktop.org,lists.linux.dev,lists.xenproject.org,googlegroups.com,kvack.org,alsa-project.org,lists.linux-m68k.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux-foundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email]

On Mon, 27 Apr 2026 at 12:19, Yury Norov <ynorov@nvidia.com> wrote:
>
> This is what Linus said when added x86 implementation for copy_from_user()
> in c512c69187197:

Note that some things have happily changed in the six+ years since...

>   That's partly because we have no current users of it, but also partly
>   because the copy_from_user() case is slightly different and cannot
>   efficiently be implemented in terms of a unsafe_get_user() loop (because
>   gcc can't do asm goto with outputs).

now everybody can do asm goto with outputs.

Yes, it's disabled on older versions, so it's not *always* available,
but all modern versions do it. And if you care about performance, you
won't be using an old compiler.

             Linus

