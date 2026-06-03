Return-Path: <netdev+bounces-294547-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EXyMMJarH2pTogAAu9opvQ
	(envelope-from <netdev+bounces-294547-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 06:20:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B65663420C
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 06:20:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=google header.b=h55e6A0o;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294547-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294547-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE3923053335
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 04:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6398D35A3B8;
	Wed,  3 Jun 2026 04:20:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EBA202F71
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 04:20:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780460436; cv=none; b=bvwdMXFtMHhwU55D239qavWr8koiK85yYbySybkvBbJCWskjGj3XQdum8AJPUDROzyBpj9KHOP7dGgocXiWw9lDq8EYJ5HIwAsx8De1mVp9Dad3CpY/hYZj9k0qOKIwI8JsP6OJ/ne+JOa3GuLQ1JugCYXlFquzGUVJBO+PxgIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780460436; c=relaxed/simple;
	bh=9tQqNP43n5romnaq4BfFL2SfXA5Di4eDVrUHKrBpUCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjUPEUwZlRiXcV45rShJhXwJ9aPRKwNz8dACTn1O+lFYL14ow5lU4HtBELiy4WxyZVTYmpMfpyeC5m2oYt7Cr3J6xJtjSqGoYQcdNNVwxuI1DLmU+10SdwVG6hoEJcfxvuD7kqVV5mPJcQ8OtkHdQQOP3F77tyvMZcue3UR8a38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=h55e6A0o; arc=none smtp.client-ip=209.85.218.52
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bec429c2bb1so476812366b.1
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 21:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780460433; x=1781065233; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3SJtr+8Mfjo1TPz3VKjCaH7CMP6KY0W4WXb69Cl5TnE=;
        b=h55e6A0oYg6YUCrMBZmgsOkgYhJsXyuQoQH33kZOINJstrK4BB0m448Tbp7nXS8ACi
         ETTjU34DknjIsxchnZ4SVdGW6cW+oo5CjtFBLNz/f9nZORhMoBvV4R0Qf9pTdpJRYUSn
         lhH5xvkNikF1o+DC5HZhDkA6ON8lYagHQHWbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780460433; x=1781065233;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SJtr+8Mfjo1TPz3VKjCaH7CMP6KY0W4WXb69Cl5TnE=;
        b=GHUN/5TfqUf+xuFByYO1Si3tHfbY+XcW0f2kH7A68bi1TjkjxYPmaTayvZyTicfUCK
         IVveOXl3tISLf1HL0QwoHH1Rso84aZticXK8xLPw0zHL9hoHvNTC46ai0wy2pB3xP2Lk
         UCph7uA1IlvJ9j3fFwK9E3ljqkCRt6JoNM+CFJyvgbCb4dOOWN6YlOEiOhuczqaVsZzl
         tfbLiYcx+Oyz61N5YysW7ozHfIkLXBVVCJqJsmJ4jrFZdyeIvmmxJ1wtzbBemujOyOD7
         PFNAcjhgorz42HPbWm8rgUNfULOjqcj5c+RQFypn1m8lKhF3pyRZF4sQlEgm15wwDVNk
         0GLA==
X-Forwarded-Encrypted: i=1; AFNElJ+T/Kdx4Wr3WCIbKhWgJ8/e5tHLl1d+xBOpS+mWgZQudtLPjL7WPZO7nwjYx4kBeR3ND3B1Dxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz56R0eH9IIdlSPhIMRIrrIC0I/godBOo+Lmv5gi/RHLr1aQ0zQ
	YnvV2EC0dXog+OLl9/LttLD7nwTtqDNaG09qMJvVLR7BCoFyoKbBEfOjCrX8Cn5f/iyjrVRYieB
	0bH9E0poIdw==
X-Gm-Gg: Acq92OFxQU9kNrzPpRaw1gJnb7+R+bizdRoF94qBuzIu74/y537egN2YHp2FKw8bePX
	yLRokVPFUrLLEAGIiJKVoGFy9QOouV+Tx72NpAkTWy8Mrt/uAquJFMK/QZzH3I0DitL5gHyKoai
	TYVhp568I7Hovy9lu4fovfqiJTp2h2r3NBDHToAfBioIi9nE6TzO/S9+ryy89/bCbt76kdw3CJe
	YjQ6ouYndvXDTfKMgizlrfXXgZfFqgO41H4EO4QXhKXJZmBwDCqZS0ckGmAGmBLep6fqwLkTewl
	G+U6SzXVoTpTPhwutZ0DDhPz7P1z3Ehz7PmRI42EYmWdQDUumz3qrvKL5z+hKvlckxDfkFYRyeI
	4YucGn3v4yHf9LHZGCWotmEV13bIVUMr5bLwdRt93ZFGEia3J3uTp4+4nqD0ogXvOVqMddCLdu/
	dp8rHDM9KxwsCymxkJOKxgvu/icT7PfLn0oz2ELKRuJrT3Vlj97vx0ThxfTEVg1/h2+g8/i8zkQ
	UPbpVpVs40=
X-Received: by 2002:a17:906:4583:b0:bd8:d86d:568a with SMTP id a640c23a62f3a-bf0af800cf4mr38260066b.47.1780460432901;
        Tue, 02 Jun 2026 21:20:32 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf051c8d3f1sm78131066b.17.2026.06.02.21.20.31
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 21:20:31 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bec49f7e35eso427286966b.2
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 21:20:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+9NmnkdMF4VgNbMY/Qr7jKnFzvwGEIWOE2rkI2/KNnMOFCiUM3+R5Tj0ZI95+qCJ5LI5o9o1A=@vger.kernel.org
X-Received: by 2002:a17:906:8a48:b0:bea:4a9b:27e3 with SMTP id
 a640c23a62f3a-bf0ac20eef3mr38881066b.2.1780460431308; Tue, 02 Jun 2026
 21:20:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
 <20260602225426.122258-1-safinaskar@gmail.com> <CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
 <CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com>
In-Reply-To: <CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 2 Jun 2026 21:20:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wizkDXRut5xLXRF-CVUVYMaZ5AOexxeghOAoXPb4yAvQg@mail.gmail.com>
X-Gm-Features: AVHnY4IJxv2Bq-ytG67gbyDgK2Xm9CPUNF4PNLBHu-2R4s_ONl3Jl_5fsF1zxk4
Message-ID: <CAHk-=wizkDXRut5xLXRF-CVUVYMaZ5AOexxeghOAoXPb4yAvQg@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Andy Lutomirski <luto@amacapital.net>
Cc: Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org, axboe@kernel.dk, 
	brauner@kernel.org, david@kernel.org, dhowells@redhat.com, hch@infradead.org, 
	jack@suse.cz, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294547-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:luto@amacapital.net,m:safinaskar@gmail.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,zeniv.linux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amacapital.net:email,linux-foundation.org:from_mime,linux-foundation.org:dkim,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B65663420C

On Tue, 2 Jun 2026 at 20:51, Andy Lutomirski <luto@amacapital.net> wrote:
>
> Am I understanding correctly that this will completely break zerocopy
> sendfile?

Very much, yes.

And it's worth making it very very clear that ABSOLUTELY NONE of the
recent big security bugs were in splice.

They were all in the networking and crypto code that just didn't deal
with shared data correctly.

So in that sense, it's a bit sad to discuss castrating splice.

But it's probably still the right thing to at least try.

I've seen very impressive benchmark numbers over the years, but
they've often smelled more like benchmarketing than actual real work.

There's also a real possibility that a lot of the sendfile / splice
advantage has little to do with zero-copy, and more to do with the
cost of mapping and maintaining buffers in user space.

If you are sending file data using plain reads and writes, it's not
just the "copy from user space to socket data structures".

There's also the cost of populating user space in the first place:
page faults for mmap made *that* historical copy avoidance basically a
fairy tale.

And not using mmap means that you have the cost of double caching in
the kernel _and_ user space etc.

So sendfile() as a concept (whether you use combinations of splice()
system calls or the sendfile system call itsefl) isn't necessarily
only about the zero-copy, it's really also about avoiding the user
space memory management.

But yes, there's a very real question of performance.

I just suspect we'll never get real answers without going the "let's
just see what happens" route...

                Linus

