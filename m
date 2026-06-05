Return-Path: <netdev+bounces-295723-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Lug7FYWKImqhZwEAu9opvQ
	(envelope-from <netdev+bounces-295723-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 10:36:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB63B646705
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 10:36:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Sr2t+Rg+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295723-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-295723-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28D5430465D4
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 08:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD0E3CAA5F;
	Fri,  5 Jun 2026 08:23:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069653C9888
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 08:23:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780647804; cv=none; b=e6AfHAIimnqwmtJna8AwOe8Hbd7M6uZDLsyKRTpkBWSBGOUdD35OA73bd+HgY/yPIc8K/z8HWd5GuiqGa39OHQMRKXgFwsJrieGLw9oLlEomrzm4IgwuzhBuWg5zrv1NtNMVPp1b982eHsNyO38OM20rkVAfnT1B6RYzd2t6cyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780647804; c=relaxed/simple;
	bh=eAlKvP2gsEfRQmVOZv1allmZysrFKO1fn5IMvtPZQiI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6HrV1l8KEsHa/higSKq1/YxJiBpNBQVXa4CWhMhBu2hXBj8SPAz5KyGlfCM3RZMIpzuUzTaNQo2HZ1J35GvzbNw16KrDZnVq1x5ZXgsOLmeTN8aCEwo1cLruoM0wfJomSaHbk+Dc8MA8nznWP+yaB2Q1V5Kg4qEA6u4HyrFFQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sr2t+Rg+; arc=none smtp.client-ip=209.85.221.50
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45f3cf907ceso762895f8f.2
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 01:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780647801; x=1781252601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ncylH/iADc8ME04RgleGvGv2QOfG/3EuEqLEAZ+XWA=;
        b=Sr2t+Rg+htecQ7mMDjt3jafvQkDhGt20df/P3Cs/4kP9/frGVSzMbw4gnwBzd7/Glb
         LQbaGgyEOKmp0NA0I7tpfquCUZnW5dx7ofSQTISET7S9/TSCx/edEE44cAlsU8t/C1A7
         QxxeGoSuXd/6QdVNsPk5sz9NtojZ2YzWl4Py5FhloNRfW4Y56av/HK5gGGjDf9vUPM0E
         jvDA2EXN6mQYtlbAwAa9ZI8nojXgk5RPdnMQl2lQdGDHELa2SpxkDw48WGMtqqgTyYlY
         aahI9vhG463Zn0IB/786cAmx0P9o+uy1XxsGb0uTPK7rSpGsf1H74Q1M1BWfiZDNXwaL
         SiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780647801; x=1781252601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/ncylH/iADc8ME04RgleGvGv2QOfG/3EuEqLEAZ+XWA=;
        b=mKdqluqgeoixxOeMSP7fMa/aSSJ18GIUKuoRulScLvzAlcY7tWRR6M8I+b60FEkz6+
         GTnUW7eX0jT5EG36rS6zj5htbM+m41hNZ049LPpqx9pWGFHf2HfLQP90Eugk88gZKsKB
         5Ftn250U3wTxnPcqakpuO6iqQEtYzm9YtedPmmH/FbTcBDI0lye9NRnt9lpbHXUQ3ULY
         akVFHelslTneNcFLRRYXi/GrBuhUALMz496vgSlJlk61OK3NAtvdgDVjR9kUcA2zaa+k
         eIQIgUuWlfRqmZFEbkbp9pqnSEg5mgJmPIf9v8VTtdvjkksiMrxYaorw66WF4f7EM9Um
         SSyQ==
X-Forwarded-Encrypted: i=1; AFNElJ9h6Yfcd1yHRakRt4hYrTlS5utpUreij1qIkkjK+MUexdYOhheQniYoZLNLL1JNhuFzAJILRZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBCPbh97CuvnL1692UgLGcP3wrHVCMPQqIwgby61HR7kBk2O8D
	trer8c7eU6MInBTq3jHemLFx1wifOGcEBjAEyjcvj9IIuIaipD4txa36
X-Gm-Gg: Acq92OG/IR9QarOjlmEz9XMWxKi8eBD0teSP8u4+Tz1X1F2wOQaVp+ScR9oepydTsgH
	ZJm0d/2/Sf6vweeWZFF6990VgYmKrMSRnB6MTCG4e4VJ6/t4FFoUSCmvXIY4L+3+PN1Q1KS5em+
	P8CzhePQ0+6+R05v5jhKFPrUTmGg3PjJf0+9uVw3Dz7X3bPZVDusXXHf54asZzxCYsA7IyikYz5
	n42Z7ZDLUEicXEpRTh/l+1kKCrNylPl5TKLIozZl5j6eJoDIXqQL1iDKzL4QMOENI1CyyoeBdc+
	7bj1x2rN2XEU6Apc8u7a0dTT6UiDhQ6JqqA4e54kuDYuQ3SueAfmAil7HQllHDdVvvjZ/MEBmq3
	P5Ifq/Aul1T2ygTvCnpsykmp9rE+AEOdzx8ncG6yXPu2TzrUAxxcx8lRAF/DvjNRSnlMN9pg9d7
	oQyfon5ipT32bhXsKZS8O/7LReZxHDTXX+YNywmYjnaIlxxGQkE8I6ITHmSm24S+Cs700JMecmw
	3zh89YatQ==
X-Received: by 2002:a05:600c:4fc6:b0:490:51e9:deba with SMTP id 5b1f17b1804b1-490c2615a5cmr34498005e9.27.1780647801274;
        Fri, 05 Jun 2026 01:23:21 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2f67c6sm23925419f8f.16.2026.06.05.01.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 01:23:20 -0700 (PDT)
Date: Fri, 5 Jun 2026 09:23:19 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Askar Safin
 <safinaskar@gmail.com>, metze@samba.org, akpm@linux-foundation.org,
 axboe@kernel.dk, brauner@kernel.org, david@kernel.org, dhowells@redhat.com,
 hch@infradead.org, jack@suse.cz, linux-api@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, miklos@szeredi.hu, netdev@vger.kernel.org,
 patches@lists.linux.dev, pfalcato@suse.de, viro@zeniv.linux.org.uk,
 willy@infradead.org
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
Message-ID: <20260605092319.5a1bba74@pumpkin>
In-Reply-To: <20260605015724.GA520134@ax162>
References: <f919874c-065e-48be-ac5b-300c4ab86d4e@samba.org>
	<20260603211736.755139-1-safinaskar@gmail.com>
	<20260604100609.6b37f500@pumpkin>
	<CAHk-=wjvb56qo27-axALOKCY-CjLsj9_294zeBovPVJaYm14dA@mail.gmail.com>
	<20260604183829.63c35fd9@pumpkin>
	<CAHk-=wip3mwLOHOYJ9TtjDxOaq9YUXmuCg2AycyASGgeY6qqUw@mail.gmail.com>
	<20260604223216.73468830@pumpkin>
	<20260605015724.GA520134@ax162>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295723-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:nathan@kernel.org,m:torvalds@linux-foundation.org,m:safinaskar@gmail.com,m:metze@samba.org,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,samba.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,zeniv.linux.org.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pumpkin:mid,godbolt.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB63B646705

On Thu, 4 Jun 2026 18:57:24 -0700
Nathan Chancellor <nathan@kernel.org> wrote:

> On Thu, Jun 04, 2026 at 10:32:16PM +0100, David Laight wrote:
> > Talking of broken compilers, had you noticed that:
> > struct foo {
> >     int a;
> >     char c[32];
> > };
> > 
> > int b(struct foo *f)
> > {
> >     return __builtin_object_size(f->c, 1);
> > }
> > returns -1 (size unknown/indefinite).
> > You can't use __builtin_object_size() to stop code running off the end
> > of anything referenced by address - even when the size is constant.  
> 
> That is the entire point of using '-fstrict-flex-arrays=3' in the
> kernel:
> 
>   df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3")
>   https://godbolt.org/z/bvfrh7W58
> 
> Without it, all trailing arrays in structures are treated as flexible
> arrays, even those with fixed sizes.
> 

strict-flex-arrays got added in gcc 13.1 and clang 15.0; it isn't supported
by the gcc 12.2 on the debian 12 system I'm building kernels on.
__buitin_object_size() itself is in gcc 4.1.2 and clang 3.0.

Neither are flex arrays mentioned in the gcc docs for __builtin_object_size().

Someone might have used (eg) 'char x[4]' as a flex array to include the
padding, but no one would have used anything that extended the structure.
And the chance of those hitting __builtin_object_size() is even smaller.

-- David


