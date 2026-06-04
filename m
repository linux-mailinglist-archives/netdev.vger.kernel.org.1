Return-Path: <netdev+bounces-295282-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PZ48NzSNIWr/IgEAu9opvQ
	(envelope-from <netdev+bounces-295282-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 16:35:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9BE640EBF
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 16:35:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=google header.b=AnDFIE4n;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295282-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295282-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EFD0630BBF71
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 14:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC73480DEC;
	Thu,  4 Jun 2026 14:17:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A39948A2A6
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 14:17:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582652; cv=none; b=WEjtfGKw346BVBZXSN8w6UH8ZQVNfltVFZjzgc1+N0TT2pgg+/U3N6Tsb7F4m78wFgH1Fv5qlL1g7H92pWp8nKTlPkkYpE4IX9U8SHlykJalNxIhth0dgJgPX2nEZkLUXaOEf5LEU1oA8DgTaMN9mxyDxnec87QJ0S2y5FC9fcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582652; c=relaxed/simple;
	bh=Ecbl/t5OYeJ4mb+vVa4qoGM4jTXP3pkfic84pGx71kY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oveXSjstIRfwDYTgqqSDV1bQ3fEF37Z9uD8zsQFOQ0JDYPJ/GDWvNT8LBOcw/u7Z2kbwvSeJdtjZP15Nv/NcncrqUsEsiXl+qUMLwGaB0RRdmXKPi60oYe30/IgNZuRAW6Adr4NbTAa8r+vKooiDh/i4668PQo6D/j3v94jPw9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AnDFIE4n; arc=none smtp.client-ip=209.85.208.49
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6886be3d39bso1053771a12.3
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 07:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780582649; x=1781187449; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lAn7tUi15DsxPNLBVxb55DsaCLzi2ItCgQT81dYuAAI=;
        b=AnDFIE4nhC+oEk4gMhfoGEoOwpNt5mUZu3uKUrFBuSUf2EUdRc5MXOYrpBz6iF9vfn
         IhJDltT4lD1NPxNooyETlBA3+VUdZddE2V/gKvyK5ADvbn59wwe1HF+gCfSBqPS4QXyl
         e98mL/FQJby8htyVFxH1rzZOVVidrOLGBeA6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780582649; x=1781187449;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAn7tUi15DsxPNLBVxb55DsaCLzi2ItCgQT81dYuAAI=;
        b=W6MW470wfbNLGyLFr8/kvxvzasYw2AEfIoyl2j3k6cs8s5cUiPNfX678uxVnXa8lZl
         RG19p6fklt63TdwZgAYhRq5icr1AhkZKnG0JVvrhpNI9T6XMeE2Qs4SMtsYmRioZTSWc
         WqWjlMT9oMeqrs/+DaFE6PJLhPk0RDxqzbGBfCMGC5jggNadM/EC4XrMHiEcsyCofnay
         pbuQszbmnduEPQkg+Ha1JbnfzSjVbE7da6qPLVFwgAvgDlSXjV4muvAJCvzfCUdqTKM0
         4+PuXPmXMcI4GTJYAY6DJK2VJ9OentmLOwGcOdgyEIrHhPL95wZaSbo4RWeXQ451N1LD
         ih4g==
X-Forwarded-Encrypted: i=1; AFNElJ/mjVMbri/1ZaEHInZGdzKHTV7EIF1KbJbjX0GdAeqzFQoeepqk8Zo/QSex7FXGmOG5q29NlcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxhJxfWDydhKyjPvg14IhwFgyjokW4cjgdUHTaulT8GtcsMw0E
	OL+fMzGr/hA0FhpJQk0TPXF6t+Dfdm65Py1DLtQtKFzZNa8MxDNKu5y3ONHxAM38LnDGcp2AsFQ
	JHA4nVkD7Ow==
X-Gm-Gg: Acq92OFAwQJioAGlPtTYpljiNmkqXJzwZyLP7vgRWMJ6RDaUCLAYjYHkUQbkYhkM3SO
	2tpKt7MYs9PZrLizgzC9M0JwV4BspWEJHc42sOpx4Hhaa4Ifqs9Y5Ht6fCAapTX9jlcx1Xm1XFt
	Bf9EvPMfDz/2057HpwvRlJfE7z0Epr/LSoyVaayvZ+TMStKr+oAxSPpU0a7bppUFxa2WW/sniOx
	qjNU5O+rbW+6nNH4LhibiFgM6rzMJEiQp4DU0v9RyyjnnSdOx1A56dRrHHXQ3GoIFcQM84kTgKx
	YZ8Rd+2Xz46pnAkO9HA1OZZ/H8YXDho280pdIYkoU0V6B7krjBfxqAP8yzacRJumDUVwfwG4mll
	E34h4D2zRMPPytlnSpPxXAKHQMz9iQA+rWJrNfA2LhfBFzs36kD9Yd3+z+68QLJUVRqhGytB4PC
	/0gTIrFDJ5Dp1E/d80Pk6FmCejktW1+xQb5e20xRCdurvhF9PpDG10jmT95+E6135ypgf6Uw55L
	WlVQo7jA/M=
X-Received: by 2002:a17:907:6e89:b0:bed:5774:7c17 with SMTP id a640c23a62f3a-bf0ac20f0f2mr459040566b.5.1780582649312;
        Thu, 04 Jun 2026 07:17:29 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64c2f563sm2564584a12.5.2026.06.04.07.17.28
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 07:17:28 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-68c1653ea0cso1059207a12.2
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 07:17:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+vAyIUC+cmNKx1Y3U4j3GE6hLkGTNhPjuo3s56Nn1JR61DOHWnu8Q4A3KwfRkRzKF/WQcoAao=@vger.kernel.org
X-Received: by 2002:a05:6402:5296:b0:670:8add:2b8d with SMTP id
 4fb4d7f45d1cf-68e72739555mr4177743a12.24.1780582648047; Thu, 04 Jun 2026
 07:17:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f919874c-065e-48be-ac5b-300c4ab86d4e@samba.org>
 <20260603211736.755139-1-safinaskar@gmail.com> <20260604100609.6b37f500@pumpkin>
In-Reply-To: <20260604100609.6b37f500@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jun 2026 07:17:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjvb56qo27-axALOKCY-CjLsj9_294zeBovPVJaYm14dA@mail.gmail.com>
X-Gm-Features: AVVi8CcQ0yaowxPCFqM7JCGZCz4oCGBQaQ6sAmWXnRpVnXINniRqjS3Vb3FRVpM
Message-ID: <CAHk-=wjvb56qo27-axALOKCY-CjLsj9_294zeBovPVJaYm14dA@mail.gmail.com>
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: David Laight <david.laight.linux@gmail.com>
Cc: Askar Safin <safinaskar@gmail.com>, metze@samba.org, akpm@linux-foundation.org, 
	axboe@kernel.dk, brauner@kernel.org, david@kernel.org, dhowells@redhat.com, 
	hch@infradead.org, jack@suse.cz, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, miklos@szeredi.hu, netdev@vger.kernel.org, 
	patches@lists.linux.dev, pfalcato@suse.de, viro@zeniv.linux.org.uk, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:safinaskar@gmail.com,m:metze@samba.org,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295282-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,samba.org,linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,zeniv.linux.org.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux-foundation.org:from_mime,linux-foundation.org:dkim,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7C9BE640EBF

On Thu, 4 Jun 2026 at 02:06, David Laight <david.laight.linux@gmail.com> wrote:
>
> Something needs to ensure that the high 32bits of the fd get masked off
> on 64bit systems.

That something already exists: CLASS(fd, f)(fd);

It ignores the top bits, because 'fdget()' takes an 'unsigned int'.

We have been a bit random in how we declare the system calls in
general, and we mix 'unsigned int' and 'int' and 'unsigned long'
pretty much randomly when it comes to file descriptor arguments to
system calls.

fs/read_write.c in particular uses all three cases with no real logic to it all:

  SYSCALL_DEFINE3(lseek, unsigned int, fd, ..
  SYSCALL_DEFINE3(readv, unsigned long, fd, ..
  SYSCALL_DEFINE4(sendfile, int, out_fd, ..

but then anything that uses fdget() (through one of the helper classes
or not) will simply not care.

Does it make sense? Is it pretty? Nope. Does it matter? Also nope.

                  Linus

