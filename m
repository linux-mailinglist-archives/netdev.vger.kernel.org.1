Return-Path: <netdev+bounces-295909-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id STCPAu0FI2rYggEAu9opvQ
	(envelope-from <netdev+bounces-295909-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 19:22:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F19864A1F5
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 19:22:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=google header.b=go8bEeXS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295909-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295909-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A938D302924A
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 17:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3BC30C16B;
	Fri,  5 Jun 2026 17:12:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A624B2FE071
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 17:12:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679547; cv=none; b=CyWdRl+r/K8m5gKkJAUbEcrEjgU4WCOlBYbC4Fi92rGlg+6ClFtrTlnTbxvMxLSSJnbj+u+KWEtHtvcyNM7lkC4fcfAUdXA2vrHwWZ3hV2VQuL76gzRBRnyQ/SZshfwBobuC9uyNBaoMMGqHr+yOMzoid7z6SuVJQfiYlBL/PdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679547; c=relaxed/simple;
	bh=cx8Rkcij++nIhZcQtMX+8UhBOPSebFuHtinR8U8Auj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l49g5I4StvcJNSowtayUlh8aF54IMpy1d8ixYE8DFQom9Epd9FHMom8YwCGqUILj/TLq9T3mUC11e05H1HlrHpQz5WWg2NMpJpMREhumUwhVpOvgOv9sPLi9ph27+4RCfNGKm7OzUVPq2UVNPVqmsbS3Oqt5HEh8Z1rwb5cMe7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=go8bEeXS; arc=none smtp.client-ip=209.85.208.52
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-68c32f3c6d6so2293075a12.3
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 10:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780679544; x=1781284344; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zbDn0l7MCqGrATagRYR/CBho/Q+7UgNMgo5uDntFVrI=;
        b=go8bEeXSnWjaNHIJD7YZKQYx0dM0RujBhpcQt7s3KA66SkCjFKqis/X40Oql2z+ufU
         lBEXb+ph21EirEdB2AphGmZ0wMiCgeWfcd9jkjHF+xQjCrLXgodDkAbJP3yO79oUKpFo
         qhUD/Jh+5fcwguYF/vuqh1M04rqsuLrf46jJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780679544; x=1781284344;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbDn0l7MCqGrATagRYR/CBho/Q+7UgNMgo5uDntFVrI=;
        b=OID0MROgTJmhWmonwXTBYHt3OBYBue+U256Ix3hxo8wkQLeNJfGfxkjY0PXaWqI5oG
         X2UXXBCPx6zDRs+vn1wRir9RYno+AuAn6WHRCcR8lCyCFTj3jHv6GLdO04Wos6OMx5Km
         E8g9y1Rvatt4u7GYMlBQ6PuIY4Y5Mjjgl22hfXon4Vkahf9pZ29Uzjphvw04fzmKwMO9
         Gdwg6oZ5fm45HCRO+vRpxCzCU3ZEmOQ0yf89h6hudTJ+9S0YxJYiZfi0N8UCPF0KLLW2
         Vx3cmY9Jkup24DEWggOXUShuxNDMNCQ69PNyGLNt7G0XgZe51GO295O65A7mrJM6O6zJ
         UJqA==
X-Forwarded-Encrypted: i=1; AFNElJ+CIGL5pb1ajgxH1VqbtlDpACfPTnAWQLw2KkXKuoQ4JgoOpwzjY5158vE0YQ2+4R1+M8uF09g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2prtxalfOrVLtckER8dyHE7QtJLaYiCto+YmO4QYQw11UpkAN
	rc2MEEgTGYZv4/6cNC0PYhT90CmBzlYFlOeNQYtfmuc0CY3wlvV9ye2M/ENM7UNoRX5ZnVoqQmr
	2veQDneXepw==
X-Gm-Gg: Acq92OH00fSri0FM9gMVJNn2sHEnYyiMfvc26Rp262ARcsH3jZ33q3dWzUzcXNk2m5K
	h7d+lV5WORgvBx/TbWsy2NU1R21dp7hHyro983fhCBg4eRkN5aVd5jCEgAt+IZd5ry4JxP+H1g8
	ovHODG+maGQ/BMRI25qXQQKMbxUv1s96vJIx1HU7mYU4ucNwH8QuFXPIleahpYXLXeuVrRUmoNv
	oSUCpEIwLARTyybiMAdWsDP5w8/2ksYjBH+CtWwG0Mx3nhC9QhssZOxQouDlQIqB9stahElQp3l
	xgV2uR87F5BkSig/PW8aI5oOAjESZ5S2fQiLYTmuOsoyhsaI9nzlJsvDFUDU3B2AwpuY+1ji9vk
	8RR5BMEhBbw8ATIiuc35YQY5DQqTMgGap6Jq18q5gz7Qu5ZHC4dIh30ScSUdCqXD8kVWMGYaQ/5
	cCSLR9pJp970UsORtP759Uw1YoQqMnaZIZBa7NjHN/KbhptFmgWDPAqeCPHpMNWaPda/CU8TMNB
	PUg8dhQJ2PsgHQb10v1cQ==
X-Received: by 2002:a05:6402:210e:b0:674:5b2c:d42c with SMTP id 4fb4d7f45d1cf-68fa4c16c11mr2446452a12.3.1780679544152;
        Fri, 05 Jun 2026 10:12:24 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64c2ef2dsm3909143a12.1.2026.06.05.10.12.23
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 10:12:24 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bec3ffb95dbso354917366b.0
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 10:12:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+2OYHeAmk6+jW5kTZ+Xrt4vPGIqBGv+5PHNiN02LSCo5uCPErnDgVz+YModpRX/B9jvYmiMI0=@vger.kernel.org
X-Received: by 2002:a17:907:2d92:b0:bf0:59a2:4ccc with SMTP id
 a640c23a62f3a-bf36fd9bc68mr283989066b.3.1780679543586; Fri, 05 Jun 2026
 10:12:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f919874c-065e-48be-ac5b-300c4ab86d4e@samba.org>
 <20260603211736.755139-1-safinaskar@gmail.com> <20260604100609.6b37f500@pumpkin>
 <CAHk-=wjvb56qo27-axALOKCY-CjLsj9_294zeBovPVJaYm14dA@mail.gmail.com>
 <20260604183829.63c35fd9@pumpkin> <CAHk-=wip3mwLOHOYJ9TtjDxOaq9YUXmuCg2AycyASGgeY6qqUw@mail.gmail.com>
 <20260604223216.73468830@pumpkin> <CAHk-=wh1Avi8FGbWkt9k0Z-KXWB0spo5mQyowO8PB2sJ3unbkw@mail.gmail.com>
 <87se71jps4.fsf@oldenburg.str.redhat.com> <CAHk-=wjkZSAhxykvG6tQM5DnBoS30_XCKkYpCsQwEGcxJb=i3Q@mail.gmail.com>
 <87wlwdhrvr.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87wlwdhrvr.fsf@oldenburg.str.redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Jun 2026 10:12:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiTQr4YYYUH38srGvWAq3_UpDeAPR+qZWVyf-ZU7z8Hzw@mail.gmail.com>
X-Gm-Features: AVVi8CckZsnJXSGEqzilnfJFExIfoQ08Dq0LHvA2PxDFlkolpXQtrHtyU3UQHDE
Message-ID: <CAHk-=wiTQr4YYYUH38srGvWAq3_UpDeAPR+qZWVyf-ZU7z8Hzw@mail.gmail.com>
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Florian Weimer <fweimer@redhat.com>
Cc: David Laight <david.laight.linux@gmail.com>, Askar Safin <safinaskar@gmail.com>, metze@samba.org, 
	akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org, 
	david@kernel.org, dhowells@redhat.com, hch@infradead.org, jack@suse.cz, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295909-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:fweimer@redhat.com,m:david.laight.linux@gmail.com,m:safinaskar@gmail.com,m:metze@samba.org,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,samba.org,linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,zeniv.linux.org.uk];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux-foundation.org:from_mime,linux-foundation.org:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5F19864A1F5

On Fri, 5 Jun 2026 at 09:30, Florian Weimer <fweimer@redhat.com> wrote:
>
> > Uhhuh. But that is only specific to 'bool', right?
>
> Also char and short.

That sounds like a complete ABI violation as far as I can tell.

Scary. Because I would not be surprised if we have code that assumes otherwise.

Now, the kernel *seldom* uses char/short types, and since compilers
are typically at least self-consistent in those cases and we don't
interact directly with untrusted sources.

The system call interface is special, but we wrap that for other
reasons so deeply these days that we'd not be impacted.

But we also do have various assembler code, and I certainly wasn't
aware that apparently compilers have been walking away from the old
ABI rules.

I did find assembler code that clearly uses just 8-bit register
accesses and function calls, but it was all _entirely_ within
assembler. The low-level debug printing in

    arch/x86/kernel/relocate_kernel_64.S

puts the character values in %al and then calls pr_char_8250() or
pr_char_8250_mmio32() with it, but that is *all* in asm code.

I didn't find anything obvious that calls C code with that kind of
argument though (which makes sense - we typically call the other way:
C code calling into asm code, not the other way around).

So at a guess we're fine, but it's still somewhat unsettling.

And maybe others were aware of this, and it's just me that has old
32-bit x86 code in mind.

              Linus

