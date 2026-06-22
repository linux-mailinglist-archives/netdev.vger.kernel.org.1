Return-Path: <netdev+bounces-301092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ICf7AQkpOWqPngcAu9opvQ
	(envelope-from <netdev+bounces-301092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 14:22:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 694FE6AF682
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 14:22:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="UGA/fVkZ";
	dkim=pass header.d=redhat.com header.s=google header.b=FrOuaElU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301092-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301092-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A077302845B
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D063A6EF0;
	Mon, 22 Jun 2026 12:22:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFB336F427
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 12:22:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782130941; cv=none; b=JVlYzn58f+F96hLKc+YI6QkhpEmRLaTpgiReEICN4mrSf9OFhy9i+5NvQTR+SpgsDXxD/aX5Bzrq6bjgPd9mkpTzQ5ystxWZ21xWBpLemBqlp+6ongHxGu37lyREIEN2FqiztJ11IWJ/f+kO/v7kOTzbxMecaX1SNpoJierZgUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782130941; c=relaxed/simple;
	bh=ROjtMhAJVqAplE9ZCKI+gepuDwCOm8vYUnpYF87scYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xi1RT5v8AaHlEH1K57O9gjIPvurK7c1MsViwBOW5y7CNTin7TAcjsEj6/N0HAv1g9k10zQ3t0DmSUVFZcsZQiyuqd13tLbkaZa7re4CH5V1NeDEL1JVhUAxPaq9zjtj61DiAov9oJxMAcDATSDKUFNUcwXdnj5HcGBWONDazrEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UGA/fVkZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FrOuaElU; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782130939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NE61WDsqzyH4+WIlfYLsAL+lHpKgDOSKscv3FLr3jxs=;
	b=UGA/fVkZuoG+nTf4hGUN13LAJ4FCpakLu6lVW6RJX6AbmO202MKS1JqsywVKn48gCqczJn
	cRxxgtIiGgM1GYjTfc4HCTnBd++eYdG0qlxDfpDDgJgdQdHVTsC8EB+uEs2yNLETxb4LI8
	ZoKtgu9NZbOpaBoJqG+NhpAGH3Noonw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-T85I3E4AMWOeDfocqnZZwQ-1; Mon, 22 Jun 2026 08:22:17 -0400
X-MC-Unique: T85I3E4AMWOeDfocqnZZwQ-1
X-Mimecast-MFC-AGG-ID: T85I3E4AMWOeDfocqnZZwQ_1782130936
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490a767b782so29625655e9.2
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 05:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782130936; x=1782735736; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NE61WDsqzyH4+WIlfYLsAL+lHpKgDOSKscv3FLr3jxs=;
        b=FrOuaElU7tcVLBEpK03HOHt+zo52scmlRr82q/oNCRzsq/KnswTTKi2sO9CgIEe1/C
         KVhxtLb/Kn/93vLazh082SedQ1jyoy8dxoVmbNiMh2jvFta+Xy/kH7ryuumTUvlitt4s
         1jVrK1rW8DbrkfD7Hcxp9jgVI26BC16uXUnIgUmWGS2PQ/E6r/Rv7ge3bIw+HehU+scC
         mb8R4eu3XiRDv/kRoWO/6y4PaUfeK+iqY2KQR9qX4YlRc/IS2seQi3aM2PqhOxiSKAYp
         NmWAdg61zc6RuilLiozrRXEE9D2iYeMwqURAFfQyyXfN034/sxEfJhBpTdUhfqSWMiLj
         DlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782130936; x=1782735736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NE61WDsqzyH4+WIlfYLsAL+lHpKgDOSKscv3FLr3jxs=;
        b=MxW/wfZvKB49rri2BOeRkMHJoOq4ueR/yHvkT8GYR7+wISCF3w2+Wo9zd0x2GIsk/4
         kGeO6AyOjn8HOapRRJRuB0JusqfE+ioIq3Ajh3ysLG9ttpVReJZdGs0ox1+TVP9fqwwZ
         HYov6w9JhvC0W5t9jCkS2jMVrMCDp2RhLxM0/Erh4tl+6AT+/jOfJexJbzriOynHtRWL
         vjnjj0WAnz7e5Z/ZORVuqfLAfVjb++SpoiTDqLYOP8sK7OOrK03fKUUoIQg93pRhtNCw
         qWOO/4NBOcVWEWCRhrFNKAKCp0nfZBmjEWBLL5nH6Pkn2UnKGevXKawX3odIFckYeOKa
         dFzA==
X-Gm-Message-State: AOJu0Yx8f91/zt9zyKRf+z+RUHUnXY9PPbzViV6p9BPhb4SiTBXqoUNN
	p90FR0N43KtY5IQG6FjxF1xlDsvoJ+XeXeegzI+S8mDj6Dv2odZFQJ7P8RbkbKKpMRnW52QD+uU
	s6n4vs9Hc3fUgSddTaC+oPXT1ZG7/OowTMSgY2uJtcmpvNHZqiejc1U0fWQ==
X-Gm-Gg: AfdE7cmkpUyjJYDNdmUfKhb4fKtF6gczbNiaKswkThL+128Nl1B9PvRnrWN8S3zInlz
	6a1X5t07VqdC8UhJShCbYw6CF7o7OKmD1rMH3VITpHKRCPz46nlILYGJ97BthXwaENWb6dVdAOj
	q7UCMahzDx+Skvd7I16E8ZrWYeBZJmyzPLnUoFM7B7DyYNJ8pSfYAFIdfcIyY2woVB9BCMajqif
	zt7SXSZnhuruZZxggbCrZCVPwSammv0529+aD1jOvdBjuD4GPawMdwBN34u+Vm3XtfLv54c7iMI
	ooSuVnhRML2Hn9J1ikbUVKwlgyb1CJStmnoyezH/V2pBj2WITzEQdROl6h/Un36BiTUUQPSgWXW
	pqfTFTDmWTyYAyEi5dQrC76+g3nCjHf/BXdUWpyYlJXpdIor9FPKBsE2U9JU/
X-Received: by 2002:a05:600c:1c1c:b0:490:b724:507d with SMTP id 5b1f17b1804b1-49240e40a01mr263798015e9.11.1782130936105;
        Mon, 22 Jun 2026 05:22:16 -0700 (PDT)
X-Received: by 2002:a05:600c:1c1c:b0:490:b724:507d with SMTP id 5b1f17b1804b1-49240e40a01mr263797255e9.11.1782130935490;
        Mon, 22 Jun 2026 05:22:15 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466667881bfsm27415740f8f.22.2026.06.22.05.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 05:22:14 -0700 (PDT)
Date: Mon, 22 Jun 2026 14:22:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Brien Oberstein <brienpub@gmail.com>
Cc: netdev@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org
Subject: Re: [REGRESSION 6.12.90 -> 6.12.94] vsock/virtio: large AF_VSOCK
 transfers reset under backpressure
Message-ID: <ajkmjgGdJp9Dj6em@sgarzare-redhat>
References: <467b01dd017b$733792d0$59a6b870$@gmail.com>
 <ajkAlpiyPWmNPWfx@sgarzare-redhat>
 <618701dd023e$063de350$12b9a9f0$@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <618701dd023e$063de350$12b9a9f0$@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301092-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brienpub@gmail.com,m:netdev@vger.kernel.org,m:regressions@lists.linux.dev,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sgarzare-redhat:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 694FE6AF682

On Mon, Jun 22, 2026 at 07:55:30AM -0400, Brien Oberstein wrote:
>Hi Stefano,
>
>Thanks, that matches what I'm seeing: large transfers reset mid-stream
>instead of the sender being throttled (reliable above ~1.5 MB, fine below
>~90 KB).
>
>The bind for me: it's not just this mail bridge -- I use AF_VSOCK for a few
>host/guest services, some of which open their own sockets, so the per-socket
>buffer workaround can't cover them all. That leaves pinning 6.12.90 (losing
>the DoS fix and further kernel updates) as the only blanket option.

Okay, but in that case did it work?

>
>A few quick questions:
>
>1. Is a -stable backport of the merging fix likely, and roughly when?

We don't have a fix yet.

>2. Could a smaller interim land in -stable sooner (e.g. more default
>   headroom) without reopening the DoS?

What we've merged so far is the best we can do for now, but anyone who 
wants to help improve the situation is welcome to submit patches.

>3. Will the fix guarantee backpressure for any packet size, or just widen
>   the margin?

It should fix STREAM sockets for any packet size.
SEQPACKET/DGRAM is a bit different since we need to keep boundaries, so 
it will come later if needed.

>
>Happy to test any patch

THanks, I'll ask you to test.

>I have a solid reproducer and can turn it around
>in a day. I'll also file this as a tracked regression so it's not lost.

Unfortunately, it's always been partially broken, using more memory than 
specified, so I don't know if this is actually a full regression, but I 
understand.

Thanks,
Stefano


