Return-Path: <netdev+bounces-104323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8305390C270
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 05:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3FD2B22EE0
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 03:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8124D8BF;
	Tue, 18 Jun 2024 03:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwZ9H22r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3022219B583
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 03:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718681062; cv=none; b=E4DStP7DkyMUJP1JisU1mrGFsMRU/SlEjdiGUCX0iAwTsUD07FSfU51is0W/rw2GwaGriFL1t3AWwUqoO/Ki8pqKxlNwwwa1z2XhO/FS8v3tnnXjtmJItYcy9QlF87YBU2yXVWbOhbJG6ZPoo5A+NQIWlXaZrth4E881hS6UGNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718681062; c=relaxed/simple;
	bh=pPEUsGW/eF/9IKpsK1htRnRpQ5LxpD3U6gYDClUBsTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JM84QW7NIUeCJGonJaxZarK6gptr/V4F7B2j0/NGX2vC/WALeUcj0ouufUzUNFz+/tLOSW+vgXHULAz3LTZwkHOrh4bzmmWcxnEa07/kDRuy0xrpOQgaaaS6hBYbouYlF+af6vJCseKpxgy0kbOEHEXBVRoyEE57inMXmd5r4oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwZ9H22r; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70436ac8882so3782571b3a.2
        for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 20:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718681060; x=1719285860; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jqm+bbmcohTo/Q3GXTm2wVKHO1pQpSJS+IoRqXoxbVI=;
        b=NwZ9H22rwdi4i5buyvwrXR2HxGJ9IYh4Z7xA2EihTogMIXeUO339KQNXiXJUvJ1dc1
         klbgxGahmj7snrEWeFSam0XKd5xgcY4he477r0wiShfb9UgbGn00vm94hBFS3lDoeUIR
         tUea3KG4bpWG2Hn7DeXYDUoIy2A+AN2Xjm90cbwXzb3ryPFBx3W16E2yPN8dPdVgfsyD
         1rpCsxHRiBC9DtWL83w4zXVuF0f2dx19nxN2mtwDMS8UeznuYe+w6DSljpt8TQxt6xac
         QofYr20WTzSBvfghdqSpRZsj6dOW2roOopZ+RenKlM+UBMO9+Hd1z6sxouk1ITzewuHj
         R32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718681060; x=1719285860;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jqm+bbmcohTo/Q3GXTm2wVKHO1pQpSJS+IoRqXoxbVI=;
        b=UBuVIESzBPQCfGHgOhTbAAczDvqC5rhnsmJ8VDmsGBGG+Rirk8UtMZUN7AyRCarEo9
         E+vGKFmCYYl3XqvpWVVbILer7HtMMDIO6HN88yfK+YhQjFeAM8aQNi0kH9RR6CJHT3z2
         870Wcipp7dkCj9WwRFoZOsxcST1gxGyYU5b+dejgcGUulyohc4ZhOQbjeI48Nsi47p0l
         3HlSJIAbMF0AMCxn5AHma2Zal5ysd70nwXeFWwNmj/TKKbaHzwnGW++1JSpTdU1h/q4F
         3M/GEI6uJKXCwkLhDSjT2KT/GinLKLBiyVFkAn40D6ikG8spykjTm8ta2YBqpwHl6Cu4
         4GDg==
X-Gm-Message-State: AOJu0YywxLX8X8VKoIc3ISvVqV3qw8+wAZyR1CEGLYxgnCW1rOfgAEcU
	WvaEzzNqLup8xb6D5U3/Q5PeXbKtybrV7ETnGIVOoQdKN86gAFyShj3vAVh3njH5UBuDSyIEMeg
	1zZDsy8xCniMThHFImpbROxUdjx0=
X-Google-Smtp-Source: AGHT+IEVJxX7iDQIFKLHxLhONMT+yyD5ZEvWLIsBvsVoV0RxbIv16zELcNTXUh/8wOeILKkbkHtG0MnvX4ee7GQo2fY=
X-Received: by 2002:a05:6a20:a123:b0:1b1:f7a1:df91 with SMTP id
 adf61e73a8af0-1bae8353db0mr12186923637.61.1718681060258; Mon, 17 Jun 2024
 20:24:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617072451.1403e1d2@kernel.org>
In-Reply-To: <20240617072451.1403e1d2@kernel.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Tue, 18 Jun 2024 04:24:08 +0100
Message-ID: <CAJwJo6ZjhLLSiBUntdGT8a6-d5pjdXyVv9AAQ3Yx1W01Nq=dwg@mail.gmail.com>
Subject: Re: [TEST] TCP MD5 vs kmemleak
To: Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Jakub,

thanks for pinging,

On Mon, 17 Jun 2024 at 15:24, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Hi Dmitry!
>
> We added kmemleak checks to the selftest runners, TCP AO/MD5 tests seem
> to trip it:
>
> https://netdev-3.bots.linux.dev/vmksft-tcp-ao-dbg/results/643761/4-unsigned-md5-ipv6/stdout
>
> Could you take a look? kmemleak is not infallible, it could be a false
> positive.

Sure, that seems somewhat interesting, albeit at this moment not from
the TCP side :D

There is some pre-history to the related issue here:
https://lore.kernel.org/lkml/0000000000004d83170605e16003@google.com/

Which I was quite sure being addressed with what now is
https://git.kernel.org/linus/5f98fd034ca6

But now that I look at that commit, I see that kvfree_call_rcu() is
defined to __kvfree_call_rcu() under CONFIG_KASAN_GENERIC=n. And I
don't see the same kmemleak_ignore() on that path.

To double-check, you don't have kasan enabled on netdev runners, right?

And then straight away to another thought: the leak-report that you
get currently is ao_info, which should not happen if kfree_rcu() is
properly fixed.
But I'd expect kmemleak to be unhappy with ao keys freeing as well:
they are currently released with call_rcu(&key->rcu,
tcp_ao_key_free_rcu), which doesn't have a hint for kmemleak, too.

I'm going to take a look at it this week. Just to let you know, I'm
also looking at fixing those somewhat rare flakes on tcp-ao counters
checks (but that may be net-next material together with tracepoint
selftests).

Thanks,
             Dmitry

