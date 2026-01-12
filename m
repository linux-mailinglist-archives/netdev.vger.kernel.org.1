Return-Path: <netdev+bounces-249002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B63CD128E1
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 13:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 677893036C7B
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 12:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADF2224AFA;
	Mon, 12 Jan 2026 12:31:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223EB1A9FB7
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 12:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768221117; cv=none; b=J7ztwYKiDdvJAQ4DMSALL1xtCZfSV3MSPFv4b5B+Y5FQDxqVsQhx9+oZdYTZDDhIKvnuyMyMu7O9IO6wL7EFIhLWclzRlmXa8a4b1sts24T4zzKHeZXTfk7oI2UHxNv/yzzdbheEDbKQbySSKcGKH83oQmgE8lQozancwgUUiuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768221117; c=relaxed/simple;
	bh=D+eSIORp6hkFjtzYOBatu8K5maR1eLde4wH4IDQSgv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bckJbRSsmbm6k9+dqKKaWQ/e7Afw/U+847HtAcoQcVHRQrlSV85ODNkb6yPHwgbp8TG+4TOWe+A9tQkwjrgrvL3DXiihilAGUt96opSdpTB99uuPPMOUck7aEJf4dcVmv6ECvZS9qEEEOFS/R+tRD04uM2Wo9ZTQ4U8QR8UdOoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5efa4229bd2so1821850137.0
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 04:31:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768221115; x=1768825915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t872TIfE/0yLSN2fTJlE7imIk93fYjUN6CJU2FvEfLA=;
        b=nI/MUg2c2qoUQUgNn/T4D3j8yavr08qz2zwWWi+jFAeAGhv47FByX5TE5fO3rxZ0Wv
         BRcCF2o+iEFEtNVbCKumobrZvXv1Xap4SODIm3Wtl/s3DBkzk05rcGyx+uZIaspIjOKK
         WtTWoBpQNeujQMLrOvG2ly8ai9Q/atv1KQ4Bd4pp3lAoCl1EZcr+IAtJqvmt06XfzXp8
         Fi4ZilbKDygQQ0r6/1EKwyV5Z9nVVCJgeL7SgcNLoWFvfaLNCTB3jXkjWOlSpo6QrCsa
         A6ixb2XOkDOuWlhRgJFeKPwZgJDsb5epWhz6JjeFn2lgIpRdMrz4kAPXg+bKtqYNswOs
         8u8g==
X-Forwarded-Encrypted: i=1; AJvYcCWRn+F6N/VS74tCUR4S7SN+T14DcRRdX9kZ7zoV8Icc5cDF76qvferBB2tiEU4A/Gox+36Za4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6DsNqFBwvbPOAPVHhoKNX1+dqQ5Qlf7jF3a8A4KwJwNbWY1mu
	nwgd4m8GMWsCtKBOnyZk6BIE8TEU/Gvx+TFwF3cQMhgjiPpzk8FGOY/Rf6uAXvVk
X-Gm-Gg: AY/fxX6NvJSIkTrRJc9X4C0h8dZwUyaO3lAZoLXHD6A5K9QmFskB1s0yUkNeTiWUrG/
	GKziOnYtEkTCEs4ooaU0fQTxRMv/NICKEaNqI71XLkVUp6USVhCiSjuS5McQ6GdPDT2apoDy/4n
	k7LdRbklkbbPCbwEqTVq9ZWZjmp+WuQVsaIfd3Xl9HmO4uRtkOIrfJvlR4/mhyrXEjQGJDe3z0y
	9XLDFuWCqFNElm3LDEt9oQcKsdS+3EFvtdeVVTsrQOeFuP7hZ+YkxacsyBiw6LJHouqFr2WisB8
	4oMcydjBGdjNkc1KCrr6I1UzhQPB0nlnE7RsMShgbg7xzED5zHvjwFoEx3ABtrJDBZe0enR2rmG
	kS9I0hchtepL2J1AqhJCY7vCtLI0e8EFxvT9cGcbLzPQ4V1spT0opXJaq1ZEic49/HqF5HvkZ3F
	Fomg==
X-Google-Smtp-Source: AGHT+IFUh41EDGB00B1ng9zvevzsW5YndFOwaUcgnhcK73da0G9DNjBeIh1Xql/tMhA/jjXPanwVdA==
X-Received: by 2002:a05:6870:d187:b0:3ff:68aa:ebb0 with SMTP id 586e51a60fabf-3ffc0bd60fdmr8472571fac.52.1768215308916;
        Mon, 12 Jan 2026 02:55:08 -0800 (PST)
Received: from gmail.com ([2a03:2880:10ff:40::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa507235fsm12386412fac.13.2026.01.12.02.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 02:55:08 -0800 (PST)
Date: Mon, 12 Jan 2026 02:55:06 -0800
From: Breno Leitao <leitao@debian.org>
To: John Ogness <john.ogness@linutronix.de>, pmladek@suse.com, 
	osandov@osandov.com
Cc: Petr Mladek <pmladek@suse.com>, mpdesouza@suse.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de, 
	gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net, kernel-team@meta.com, 
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, rostedt@goodmis.org
Subject: Re: [PATCH net-next 0/2] net: netconsole: convert to NBCON console
 infrastructure
Message-ID: <44upa7szd563kggh4xolznmfcwfnhrrh5guvecp6pzlvp5qvic@w7hxtzy7huzf>
References: <20251222-nbcon-v1-0-65b43c098708@debian.org>
 <5mpei32y7sl5jmi2ciim4crxbc55zztiucxxsdd633mvzxlk7n@fowtsefym5y6>
 <87zf6pfmlq.fsf@jogness.linutronix.de>
 <4dwhhlnuv2n3f7d3hqoulcnsg6ljucd6v47kqcszcwcshfoqno@rzxvg456q4fi>
 <j764nuipx4nvemd3wlqfyx77lkdf7wgs5z452hlacwglvc2e7n@vsko4bq5xb2f>
 <87eco09hgb.fsf@jogness.linutronix.de>
 <aWECzkapsFFPFKNP@pathway.suse.cz>
 <875x9a6cpw.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875x9a6cpw.fsf@jogness.linutronix.de>

On Fri, Jan 09, 2026 at 04:19:31PM +0106, John Ogness wrote:
> On 2026-01-09, Petr Mladek <pmladek@suse.com> wrote:

...

> Crash/dump tools that are not updated would at least continue to print
> the text at the beginning of the line. Here are a few projects that I
> track and how they would react (unmodified):
> 
> makedumpfile
> - https://github.com/makedumpfile/makedumpfile/blob/master/printk.c#L134
> - will print "\x00" between the fields
> 
> vmcore-dmesg
> - https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/tree/util_lib/elf_info.c?h=main#n904
> - will print "\x00" between the fields
> 
> crash
> - https://github.com/crash-utility/crash/blob/master/printk.c#L210
> - will print "." between the fields

drgn:

I know that drgn also parses it, and has a if depending the kernel
version (before or after commit commit 896fbe20b4e2 ("printk: use the
lockless ringbuffer")

https://github.com/osandov/drgn/blob/44ba3eb43a44f246fe3e65a728aa2594a19f15ee/drgn/helpers/linux/printk.py#L252C1-L255C55

> > My opinion:
> > ===========
> >
> > I personally think that the approach B) is the best compromise for now
> > because:
> >
> > 1. We really should distinguish task/interrupt context. IMHO, it is
> >    a very useful information provided by the caller_id now.

Agree. I don't have it in netconsole yet, but, this is I would like to
implement.

> My ordered preferences for right now would be:
> 
> 1. keeping @caller_id semantics + adding @cpu + adding @comm (similar to
> your C)

This is similar the PoC I wrote earlier in this thread [0] plus @comm.

Link: https://lore.kernel.org/all/j764nuipx4nvemd3wlqfyx77lkdf7wgs5z452hlacwglvc2e7n@vsko4bq5xb2f/ [0]

Let me hack a new version of it with @comm, and post here to check how
it looks likes.

