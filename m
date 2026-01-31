Return-Path: <netdev+bounces-255290-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIeTKNpYfWlDRgIAu9opvQ
	(envelope-from <netdev+bounces-255290-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:20:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A3FBFF17
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC49A302353D
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 01:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C98322C77;
	Sat, 31 Jan 2026 01:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gDWK7k95"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FCA2DC322
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 01:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769822415; cv=none; b=fBvHsqnA7WkjW5GrvrRpQ9Q/7AwuQ8tF27SORKv7iIJkK+0ACBgucpr9E6uL0fI1szi3650GfsYoacbnxogpOMupB+rf4MRo0zBb1u4lyrJrmpLgAGOjm8a5D6f773kAJIjRbt5IGKPbXyXyEPW/9XdXpSkxmb0rd5+oGykWI8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769822415; c=relaxed/simple;
	bh=LqjG26iPcgUJUjdKHHQUCfcuvzKdnJ4bXKdhZ7B7/mk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKkVobuLsgM93HYMNUnJN3ZpEwPu0mO7N9Za/LTjfq86sxBkSt1GW10VaEMtMGQndWb/24adXX31jy8CcOyva4+Oh2Z7vxkH1ZgVKBnpKvo5L2DIzjfGW1I0wVFGb9Dz7dv5NovNi4TUSwK4TCduw9p2/Y0sH6jIBYA3WiVOhyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gDWK7k95; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-658b9e95990so5137807a12.1
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 17:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1769822412; x=1770427212; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X+Zsir5E/r34txHH39Th9Cb+s5GtaeVJrYm06jsRDB0=;
        b=gDWK7k95+T9tBUJaJRgHf5i5t6K1bqoA4B5gvxrN7jjmKBMkgkshdjlMkiMCEHZdz6
         YzEZpoZ00ydhqkmKe4XJ2HrM1YV8QqlophejXtAJGkEk4DZdmSAd33sfYdUzEPlPYQjj
         d7nIwDFam6mZE9Vh9QTEngqLAG8F4bUvh5bRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769822412; x=1770427212;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+Zsir5E/r34txHH39Th9Cb+s5GtaeVJrYm06jsRDB0=;
        b=C9MMO/+/RzL9XCzVH563GuXBuNL5GVOBARTj0AJBIlYqQDBE1oOWdtWnAT2xiCtyPb
         UY2dpossgRWlHOG2CeQRC8vn2Oi1cYFWF+GmKfh7IW/X6cvAkxjdqf00OwRKMURnw5Y/
         W998/CoBDUPAD1liAcf8eyyCExzigiFjfT1k+dySryOtzrk97W4CdeW5kGD5ETEr2cE7
         w8Sl3KnGaOHz7HOvgZcrakfLFEeE1nkQEiDA6ktiraXTYR7RwiNxKPFDyW0fdmQsGBP7
         GrZbJ+AVGMMPNP1tXWgcG6VILxCx+SfRyfGKjEhl0snMcoR+jOnQwL/oA1DKg/7+YEbw
         JtUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhhcMyW1/ILUMKlZ5AC6TVLOMIrzXAcA1+Lk+3VbGGctMVmsj8XuPsYF1/DE+JQdin2M5i9qI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4MyjGQW+gpHhkudSCvnZy0fB/fE0H3D4/LmnF+1/gFALRl8md
	2SrqrqbFfHRcx0qAhkDs+qDQimea3whtDs87U3oazarzzBFPTYKKx4ZhFMf1C+mL/uKy1VLNLRW
	4KoR1njd3MA==
X-Gm-Gg: AZuq6aLTO+6mKfatKr/ljCJs9v1gRYqz7ZWUsZ8HZPNyXN25AWQGnoGusT01bkw7+b6
	i9UMn7iMcPD2qxo1NKeD5UPTRw4wwdMxtRjIVi5jW5oMq3H2l64l3GryLUz8wH6pD/WqlCDEtwg
	j1U3TN+VlHTktQyscIwzdNcpFmzmzs+FvgOW5wwUCEtcZe1WkCv52jozIARc7t29+SIrh36k73E
	prwj9YwEMGUan5Kz/7aQ7pXutfMKdz7WO59btEMlLsRj7bZcQl3FHCwBUysbRvAVVOEqnTg1s88
	iQaj3r/8wg/JfiFmdCzqN2KeZyXisF70YHvjKwMcZRo6pDRifzt5wEfC1ouliHBoXX7owruKukC
	vKAFRST6siXncNGsG3hX9YmI40+Ai4DfY1eCaa2hO3NQg4VV7J9wD7/PCLlQ3kE8JN+1xZi2lqz
	cmXx4a8C0t4qCGbJLV8/VMjzbIKoLhhgruqxSQPS1oojaNu9KhjyMgPDGNhhMf
X-Received: by 2002:a17:907:1b28:b0:b88:e09b:88ac with SMTP id a640c23a62f3a-b8dff64270fmr255886966b.29.1769822412570;
        Fri, 30 Jan 2026 17:20:12 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf2f1f55sm502172766b.70.2026.01.30.17.20.11
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 17:20:12 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b8863db032dso444216066b.0
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 17:20:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUiFYYh/f5ofmBeWMolJoS4yxbzvGtJOwBZC0oPUvv+yhkmatObduGrAV1RgcWTAUn2VjJ7NLY=@vger.kernel.org
X-Received: by 2002:a17:906:6a1f:b0:b87:701d:341a with SMTP id
 a640c23a62f3a-b8dff607a33mr279550266b.25.1769822411525; Fri, 30 Jan 2026
 17:20:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130-getsockopt-v1-0-9154fcff6f95@debian.org> <20260130205227.6fb1d9ad@pumpkin>
In-Reply-To: <20260130205227.6fb1d9ad@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 30 Jan 2026 17:19:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiiPxGrVxFzzf1nbx7_0abjZkhmd9oPximUxUyDM7gwug@mail.gmail.com>
X-Gm-Features: AZwV_QicYb2Y4IsMdcHkp6aaLn_xxvWlOuA7e1nJwap4TdBtycKshhvQFgQOM3M
Message-ID: <CAHk-=wiiPxGrVxFzzf1nbx7_0abjZkhmd9oPximUxUyDM7gwug@mail.gmail.com>
Subject: Re: [PATCH net-next RFC 0/3] net: move .getsockopt away from __user buffers
To: David Laight <david.laight.linux@gmail.com>
Cc: Breno Leitao <leitao@debian.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, metze@samba.org, axboe@kernel.dk, 
	Stanislav Fomichev <sdf@fomichev.me>, io-uring@vger.kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255290-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux-foundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03A3FBFF17
X-Rspamd-Action: no action

On Fri, 30 Jan 2026 at 14:40, David Laight <david.laight.linux@gmail.com> wrote:
>
> There is not much point making the 'optval' parameter more than
> a structure of a user and kernel address - one of which will be NULL.

That's exactly what we do *NOT* want. Because people will get it
wrong, and then we're back to the bad old days where trivial bugs
result in security issues.

Can you point to an actual case where setsockopt / getsockopt would be
performance-critical? Typically you do it once or twice.

              Linus

