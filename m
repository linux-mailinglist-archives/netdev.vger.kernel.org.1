Return-Path: <netdev+bounces-246873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AECE1CF2066
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 06:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 917593000930
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 05:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61822283FD9;
	Mon,  5 Jan 2026 05:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EvUXFoYx"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD645478D
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 05:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767592226; cv=none; b=ZEjhdertRyPn0qp8Ul00IYZq/KjLamrQQATwoZ6qznhEmbQU/Fwjisiy4eLpmNUFlrORJit8FmlzSf+LXZQfdVjGxl6JrkZWlBfZGPU8CUDdJK8uuRiMmjFYFVAonFiaPsoox67oQaVbE8Ih5E+8umHIgYyRFqI/PHs+H/PRJck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767592226; c=relaxed/simple;
	bh=V4KqZ3driE22w5/F97L1WeQ7I+Gqva5pvc8F8ol3oyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hQD6B5AqP5mzGNZKr0Wzso0FcqtaCb48E55qqBGwdYmKO87uoebe5Fdzrq18aMPT267nkLSr/5boVRiOvurLpVQ/pWACceZ5mN2jIelfPMF3TML3Y3+eCSm8Lk8FuC5Da8sVVH1kTbeE91WcNb1yhRc4LdtKEg7aBCvCFi4gP7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EvUXFoYx; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7a2d0d37-bcca-454f-85c3-063906ecd042@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767592212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V4KqZ3driE22w5/F97L1WeQ7I+Gqva5pvc8F8ol3oyk=;
	b=EvUXFoYxVWa/4DMrkhSmRnxwi2VMErcYLJXiOHBH2ZN21LtOHFGQ1HW38zsN6YgvrsPdGq
	62BwHeUixth06jLLS+oF3xW5CJJugPZTyVS4tOfCodTndgieesgjOVVWEWkUAYLCzx4JyY
	4VboiG+6LWkoraGtFHMwmO25hnNDHKM=
Date: Sun, 4 Jan 2026 21:50:04 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf-next: Prevent out of bound buffer write in
 __bpf_get_stack
Content-Language: en-GB
To: Arnaud Lecomte <contact@arnaud-lcm.com>,
 syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
 john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org,
 sdf@fomichev.me, song@kernel.org, syzkaller-bugs@googlegroups.com,
 Brahmajit Das <listout@listout.xyz>
References: <20260104205220.980752-1-contact@arnaud-lcm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260104205220.980752-1-contact@arnaud-lcm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 1/4/26 12:52 PM, Arnaud Lecomte wrote:
> Syzkaller reported a KASAN slab-out-of-bounds write in __bpf_get_stack()
> during stack trace copying.
>
> The issue occurs when: the callchain entry (stored as a per-cpu variable)
> grow between collection and buffer copy, causing it to exceed the initially
> calculated buffer size based on max_depth.
>
> The callchain collection intentionally avoids locking for performance
> reasons, but this creates a window where concurrent modifications can
> occur during the copy operation.
>
> To prevent this from happening, we clamp the trace len to the max
> depth initially calculated with the buffer size and the size of
> a trace.
>
> Reported-by: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/691231dc.a70a0220.22f260.0101.GAE@google.com/T/
> Fixes: e17d62fedd10 ("bpf: Refactor stack map trace depth calculation into helper function")
> Tested-by: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
> Cc: Brahmajit Das <listout@listout.xyz>
> Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>

LGTM.

Acked-by: Yonghong Song <yonghong.song@linux.dev>


