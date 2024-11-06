Return-Path: <netdev+bounces-142317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5719BE404
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 11:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2D6F1F220A3
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B7D1DA622;
	Wed,  6 Nov 2024 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlLr7ecB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7D91D0F44
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 10:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730888162; cv=none; b=uwdkGxb+2UtOacuvRSjj7H+t1r4gcb4JtZavKNDQWcInFdnESuf51f4sVnSAEb6jOOzozOCEsHAsVtjXP8QCKRBaTdrGbpYSxwiWvzWZuhN9Y7Akj4zQWEl4pd2XJZDDE0rOoh4xUUBh+75885PBn/wz2FaOQrihi6v8ZSv1Gfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730888162; c=relaxed/simple;
	bh=JBiKP71syN8Q643QFajEkYNhL/SmW4bQrOt/g1OYi2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qN55VAf77Ghm5BsXkh7roxWGbgb+KwjSKOznaVGhl8FJgbVZKQCWyDzaH0HZ4bZigWavgF72U20uUExtAl1hkiY2QPHDcbPLiuvUkeLQv7rKWs90IXw1ZVXsILYomxI0d6ml7MY82c5mdAytTGDGjaO7CBgH3fHuYPxJqiBY6Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlLr7ecB; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb587d0436so67498181fa.2
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 02:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730888159; x=1731492959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GoGUhWDfpMLjcCBvR2pPGqCoUKrtSns5tcHsprvL00c=;
        b=KlLr7ecBwr5+3klTHL0UdN49ts41bqQQtHTYXrRnPCRWI1eF7nsPmUHOG/rQVj/KFL
         9w2d1/UlpAu6O/UsMBqp5Ghi1+HGm6RJ+d5aK2PKkcnVsmRcsRSnarXDpDy3lARA6Z/O
         z054FMCjQ/9S4p3kPJQYyBLda5DL3gna2T1tD3lX592w0Y0H734CjFm5W035rB8Qs5np
         Nhcdk3FAzPotuxpmnyRSQFVJUoTmASOtmVERxMogeq5OPEd5A5Dxsv30pd/K+DkYckq5
         fd6qhKRaI9ZliS074AklkOAXU+PxfqQZCRH60CLnNTwv2GXVhyOjQithBzh3Uy8o3aGf
         jwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730888159; x=1731492959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GoGUhWDfpMLjcCBvR2pPGqCoUKrtSns5tcHsprvL00c=;
        b=w1LodKtl0yhW4Yl21LSHPZvvGs4o7s7XHUdcq8GQ8a7EDzq7VXaNNiyC4sqJT9f3Jp
         aJ8N/K451aeL9Lp67pkXf6SsuNWlVmHGhfHuCQYGLiyZxqTi91J37Vx7gxGBRsdznRIJ
         T3q/EZtKlJFJ7Zq5WEAoGgH6ZzfE87KdZzKLui7YpjkB0vBMBzVngPP4ci4VOjqTUlWz
         rOiqCl+/Wq2eLJOYhG7OLyD+aVUYIcd8CoMtTNDtZ2y5yX6QRkUjtLepjJKZQE8tBUkJ
         +iKR7KmmWx9CgcCd0a/gzGu+k6Bzec/VMKxYSS6bwXzppzurS3GL2Z4biPeHWv2idplx
         5iLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGP6qCSumb9HYMtpT35H7Al5H9BNhbdgD7pr9I6YhHRoeUodXARMWqpAEIENEZ0Rwe3GBwGE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHitt8rA5/VcxWUr0tWmy0h5ahsIs5YVzT+AnyD0WNOXjAK8xO
	swdSRG0gKRQQjmgvwpVtnYjPXcwFwH1YOBLMKoABJYzzCGr6U6gm
X-Google-Smtp-Source: AGHT+IEiy+ZrIxdk+HK/wiGnfvakwnzQY787xq3Wp4NqmUevec2YHWFvmOGM082u5ND5w8K1QKo8XQ==
X-Received: by 2002:a2e:a88b:0:b0:2fa:d67a:ada7 with SMTP id 38308e7fff4ca-2fedb7ca0c0mr89867991fa.23.1730888158331;
        Wed, 06 Nov 2024 02:15:58 -0800 (PST)
Received: from [127.0.0.1] ([193.252.113.11])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cee6a9a410sm2519104a12.13.2024.11.06.02.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 02:15:57 -0800 (PST)
Message-ID: <7cbd8419-2c74-4201-b5a3-7b88c3ec83fe@gmail.com>
Date: Wed, 6 Nov 2024 11:15:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Fix u32's systematic failure to free IDR entries for
 hnodes.
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Pedro Tammela <pctammela@mojatatu.com>, edumazet@google.com
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 netdev@vger.kernel.org
References: <20241104102615.257784-1-alexandre.ferrieux@orange.com>
 <433f99bd-5f68-4f4a-87c4-f8fd22bea95f@mojatatu.com>
 <b08fb88f-129d-4e4a-8656-5f11334df300@gmail.com>
 <27042bd2-0b71-4001-acf8-19a0fa4a467b@linux.dev>
 <46ddc6aa-486e-4080-a89b-365340ef7c54@gmail.com>
 <9dbb815a-0137-4565-ad91-8ed92d53bced@gmail.com>
 <771bd976-e68c-48d0-bfbd-1f1b73d7bb91@linux.dev>
Content-Language: en-US
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
In-Reply-To: <771bd976-e68c-48d0-bfbd-1f1b73d7bb91@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/11/2024 00:42, Vadim Fedorenko wrote:
> On 05/11/2024 22:14, Alexandre Ferrieux wrote:
>> 
>> Can you please explain *why* in the first place you're saying "'static inline'
>> is discouraged in .c files" ? I see no trace if this in coding-style.rst, and
>> the kernel contains hundreds of counter-examples.
> 
> The biggest reason is because it will mask unused function warnings when
> "static inline" function will not be used because of some future
> patches. There is no big reason to refactor old code that's why there
> are counter-examples in the kernel, but the new code shouldn't have it.

A macro doesn't elicit unused function warnings either, so this looks like a
very weak motivation. While coding-style.rst explicitly encourages to use static
inline instead of macros, as they have better type checking and syntaxic isolation.

Regarding old vs new code, below are the last two month's fresh commits of
"static inline" in *.c. So it looks like the motivation is not shared by other
maintainers. Do we expect to see "local styles" emerge ?


$ git log --pretty='%h %as %ae'   -p | gawk
'/^[0-9a-f]{12}/{c=$0;next}/^diff/{f=$NF;next}/^[+].*static.inline/{if
(f~/[.]c$/){print c "\t"gensub(/.*\//,"","1",f)}}'

baa802d2aa5c 2024-10-21 daniel@iogearbox.net    verifier_const.c
baa802d2aa5c 2024-10-21 daniel@iogearbox.net    verifier_const.c
d1744a4c975b 2024-10-21 bp@alien8.de    amd.c
d1744a4c975b 2024-10-21 bp@alien8.de    amd.c
a6e0ceb7bf48 2024-10-11 sidhartha.kumar@oracle.com      maple.c
78f636e82b22 2024-09-25 freude@linux.ibm.com    ap_queue.c
19773ec99720 2024-10-07 kent.overstreet@linux.dev       disk_accounting.c
9b23fdbd5d29 2024-09-29 kent.overstreet@linux.dev       inode.c
9b23fdbd5d29 2024-09-29 kent.overstreet@linux.dev       inode.c
3d5854d75e31 2024-09-30 agordeev@linux.ibm.com  kcore.c
3d5854d75e31 2024-09-30 agordeev@linux.ibm.com  kcore.c
38864eccf78b 2024-09-30 kent.overstreet@linux.dev       fsck.c
d278a9de5e18 2024-10-02 perex@perex.cz  init.c
f811b83879fb 2024-10-02 mpatocka@redhat.com     dm-verity-target.c
4c411cca33cf 2024-09-13 artem.bityutskiy@linux.intel.com        intel_idle.c
42268ad0eb41 2024-09-24 tj@kernel.org   ext.c
56bcd0f07fdb 2024-09-05 snitzer@kernel.org      localio.c
1b11c4d36548 2024-09-01 kent.overstreet@linux.dev       ec.c
7a51608d0125 2024-09-04 kent.overstreet@linux.dev       btree_cache.c
7a51608d0125 2024-09-04 kent.overstreet@linux.dev       btree_cache.c
691f2cba2291 2024-09-05 kent.overstreet@linux.dev       btree_cache.c


