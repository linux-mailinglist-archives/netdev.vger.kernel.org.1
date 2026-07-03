Return-Path: <netdev+bounces-304317-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V+PWBQQER2p3RAAAu9opvQ
	(envelope-from <netdev+bounces-304317-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 02:36:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 599286FD9F6
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 02:36:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=multikernel-io.20251104.gappssmtp.com header.s=20251104 header.b=0hTBxw0X;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304317-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304317-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F5B3300B447
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 00:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC7B1ABEDE;
	Fri,  3 Jul 2026 00:36:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354D913C918
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 00:36:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783038977; cv=none; b=D3ZWaae1vEtvGEyYibs4vpMwHvCPP5NYkTjMoixBMj04CRhnJwGih4WJs8istflyWpkg2CAuBoZ8otSos4WHPs23kOQdRh0PXnEyjAZsMK7QJ5Grx25wEQJkeU2hCMFsDVN+EfuiYXcyysyvm+MYt6esA8mjuzEXZTY7KSYhJGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783038977; c=relaxed/simple;
	bh=5z8N/QiWCvj3vEit/8s5bt1UdT/rffcHxaZBfybXDQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/kZKzrpiUWl4tss4oV5TCbJPGliuZ/EDbcutFRISsQxwNXgmAI788q83uhrHbs+BG7X1GOr7Zyu+zGI6TRLD4SaCJTYk99Xk1qnHDUHKUihQEjHX7cQ4DO4q6MiL3PKYn6YF8HcLjv/aRXCY+luIGCyfyYI6JuE/JXZrWPSGfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io; spf=pass smtp.mailfrom=multikernel.io; dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b=0hTBxw0X; arc=none smtp.client-ip=209.85.215.178
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so2544a12.2
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 17:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=multikernel-io.20251104.gappssmtp.com; s=20251104; t=1783038975; x=1783643775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jh1w4bBQmtbh9hEILC33sf11bPAm+ubAluEoBZExokU=;
        b=0hTBxw0X5bwd8Xr/Ohd5S+8QSQq+qXWCFxlTf8KKoUjPGO4b/9K6Rt/9NYwYgfsSVB
         UURHxXcz6UhcLjc8rKC88G10XItWvyW3QxHrEpuCL0DdzzYXSEzst3h3o+fr90TrKq8K
         MhstOv2e+auVHqN4+s1FFd9j/bODF0+iJf3i9o/L2Rg2f9sk9Tt7T8SnrNA8hHAJd2rI
         MbkrgO1RX9VVyC+7Ci2OybAgKPfYkkkvDOZXQRcwuxL42eVPnJj7e5Xlooslno4kGFIS
         0i0DDB8qW+8lTD34V1aVd9X32ft39YpVxcrM5vH3BteEHtoaVyZoRQhQWUqwcInbya7g
         hY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783038975; x=1783643775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jh1w4bBQmtbh9hEILC33sf11bPAm+ubAluEoBZExokU=;
        b=VD495BvmN87a1axqu0F3e/mNXc2KfOIoF0xU9lABkZRIxcKAF+SIFJ3bUm7KCaQHFU
         qtQ8070DO091Gh0KDWuDc2eeH5WeUCAc8IKd0xajdy2ootWbKU0lgNj0B5OUNmOWtpt4
         fYrwDYsKRWGO3JmKK5d3NwGnplc9YZ1t9p/DlVXqm1lc3hPSYQKI1BLrZQPudigxF9S2
         4YTBZZ29cSqD8msH3MXe8Ta9vrpTFClqOTJeo3BQcCiX1dFAR5l+K3/2m4gmC8+bThZN
         Qh4QII1tS2oRdooWMBeIM7io3dguFMnqzwTO1OPko5LCOnVYzp1/xc7i/T7wxkFc1XqW
         ncpg==
X-Forwarded-Encrypted: i=1; AFNElJ/KEmxVuSvY9XZS6/gAmNAI3ACEYmcSzpoOM9xENMl129EIyHZyD5iaBiTPHgJCI3RB9a1/dLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTtlzzIYQyAVp8ICFfhDSxhs9MUF85hD427NTjH1c5GXJHU2g6
	02S5wc/wdwsZiFjvaTPYh6NUFbPt9gD9PnbKRScz938xkvyi03nNvs1BGjWL2YVkO2s=
X-Gm-Gg: AfdE7cmSldp2rKMtopglGcsr/+8dB41QlG2c8Nx3/BqsPp+i7MBBkz/hw3G4PvaGcx8
	25FUDRqxsQHakilFhs4qLMHKHpI2gJmdw9f0vdYwVeR30HzjzziSIVBd1OY9f2zKf66al0FQ4VR
	tDxernOCH+pL2LV8lxlFdNmwgS3v+LmSsGJx5UULlsKK//mtAMyMd3IU7hOcfQzZJ+kjg2ksC+n
	zaAggA8WTRS/fwOpv+xw8c8zaDECuIK1yv3LmtOl/4lfuNWwWPoe6JLYealzkPiegH/3YVCTeaX
	0YA307oewyGMQWC2RaPT1JQatib+UZe5lNt42Pflxu0NIM2K6Brb0Rs08F9qrGP9V62gV95y8yW
	5GoljoIJQQBoKNY//A2GDu3vYa5XRXw2OHfEIA3MWMeXiyVuZs1Z4iIVNBkTqyZSo2hqs7VT8lP
	l+qvZWKobOTV8XWuplRRaCXqs8mYBOfm0GnFTfV98WOro=
X-Received: by 2002:a05:6a21:b89:b0:3ba:dd07:9a07 with SMTP id adf61e73a8af0-3bfed3e8afcmr8451002637.34.1783038975260;
        Thu, 02 Jul 2026 17:36:15 -0700 (PDT)
Received: from localhost ([50.191.166.190])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813d37sm14173921eec.10.2026.07.02.17.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 17:36:14 -0700 (PDT)
Date: Thu, 2 Jul 2026 17:36:13 -0700
From: Cong Wang <cwang@multikernel.io>
To: John Ericson <John.Ericson@obsidian.systems>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	John Ericson <mail@johnericson.me>, Simon Horman <horms@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	David Rheinsberg <david@readahead.eu>,
	Sergei Zimmerman <sergei@zimmerman.foo>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] af_unix: fix listen() succeeding on sockets in the
 wrong state
Message-ID: <akcD_YywrdvlkTPz@pop-os.localdomain>
References: <20260702202018.2280336-1-John.Ericson@Obsidian.Systems>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702202018.2280336-1-John.Ericson@Obsidian.Systems>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[multikernel-io.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:John.Ericson@obsidian.systems,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kuniyu@google.com,m:mail@johnericson.me,m:horms@kernel.org,m:brauner@kernel.org,m:david@readahead.eu,m:sergei@zimmerman.foo,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[multikernel.io];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c0a:e001:db::12fc:5321:from];
	FORGED_SENDER(0.00)[cwang@multikernel.io,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-304317-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[multikernel-io.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cwang@multikernel.io,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,multikernel.io:from_mime,multikernel-io.20251104.gappssmtp.com:dkim,johnericson.me:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 599286FD9F6

On Thu, Jul 02, 2026 at 04:20:15PM -0400, John Ericson wrote:
> From: John Ericson <mail@johnericson.me>
> 
> Commit fd0a109a0f6b ("net, pidfs: prepare for handing out pidfds for
> reaped sk->sk_peer_pid") inserted a `prepare_peercred()` call between
> `err = -EINVAL` and the socket-state check in `unix_listen()`. Since
> `prepare_peercred()` leaves `err` at 0 on success, `listen()` on an
> AF_UNIX socket that is not in `TCP_CLOSE` or `TCP_LISTEN` state (e.g.
> one that is already connected) now silently returns success without
> doing anything, instead of failing with `EINVAL` as it did before.

Do you mind adding a selftest for this?

Thanks,
Cong

