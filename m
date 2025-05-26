Return-Path: <netdev+bounces-193433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E33CAAC3F8B
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 14:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40E933AF66A
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 12:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FAA2036E8;
	Mon, 26 May 2025 12:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cnFqwu23"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7393A202980
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 12:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748263912; cv=none; b=i5OidRz3F8uFaE3nNU9aVeCMeY5TfMCBNDmGv3IIG0SNQJLas2mM8kCWJC0IectPr1ZUukPhTV9vzpASligVy6yoiSGME7wCc4/nG7Bs6QkdynChMa8AxjD9K+W5nlpY9QJJstHX1OJD+DV1XXD71B0HHozfb1e2Nn9klauD9no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748263912; c=relaxed/simple;
	bh=xGtgOVGl/7+FDUtfK4xwWE1CZC1f6N33ajHG2jCeSsU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=orj/MBSiGVVRlMIuZn1gXf8dP6MculZ1dvNhAeiPtYJ8OFEYIMxmglXuVsUP/1zKYXPdlVB3BykhSp5Zgbo3XMXzCLFEftJBdSm+3YxJdAJFKBXnOP1x57JPlDxodEM6799xGawIBOOrZTE2QlOdjYleP4aVrKm72iYQ7j2r8B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cnFqwu23; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748263909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5h5iun9WeuvV4gJlQiA1mE7zK3XNw6p2G6AruARxVOU=;
	b=cnFqwu23iW0paQrGc/xvzZZDMwyaHqFd3ju6QonvMBD/D/y6klkb3H7AoQ9+aMlR7rrV8+
	yhbzjAsBzy98PgDRaG4+ScufqwV59nFF4TzEnSuHdmQWEC6J1ZN40sa2hS+cXvj/d1r4w3
	6TMr9O3y++k2xuoSsre0htBYJ15lRbk=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-jc-_vbpYOgOKjy9xv8eobw-1; Mon, 26 May 2025 08:51:47 -0400
X-MC-Unique: jc-_vbpYOgOKjy9xv8eobw-1
X-Mimecast-MFC-AGG-ID: jc-_vbpYOgOKjy9xv8eobw_1748263906
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-551ec3101c7so1043272e87.2
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 05:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748263906; x=1748868706;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5h5iun9WeuvV4gJlQiA1mE7zK3XNw6p2G6AruARxVOU=;
        b=JekJTa4YyoCkAQe4UPCkTh7APjfokceV+mCvD0+mwDNBFASG1mfqy8jlgoM0rbcb+F
         Nn5Y+yijozCtWkkEd1IVnw6QYJUTpcqvpy+2JhCOKAtK+MsFyHW9TjKUi9h1XrgZBy7m
         Hcy2tnhj0I13ZHP1CJEdMWKHtom+SFRTVLZ5WdNnQoKaumNeL/oguDJCSGC1+uk+bcu5
         2hjcfEykebt4FCvp0FZODcgbnkmXswCLAWLKZxlfD5xoP8/Kw/vgUehiBGHLh6HzClSt
         25VLqmINw0Fg6S2KWX4qHE/1Ts5Evsdv3cWG08XO0rwWkI8NfWSobBiKCliqRYQka5zU
         R9yw==
X-Forwarded-Encrypted: i=1; AJvYcCX2SgZFpAFND17aNktYbAYeI9qDAwT/f691Zhz+acOvF1t9r2XQPKlh281+GueqbEOJtgvJyyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YymHo4gyxvtOxk9cF+UuoV5iufuF0izHTmGiyh6FnKjH7HLMI67
	9JBRdvoj4ZE3DRTmEGdw5Zf7w5v95TqGXX2chOa605pvV+cOQDWZtdEQQB3Q4IUu55r9hYfmOeH
	4AfA3lX0RnThwKU3vLz8jtV5XStLo0sr59ztPghICTVdf1YdFOmp37AqzYA==
X-Gm-Gg: ASbGncs61cZQWG64AaLFI1EeR+DVj+dwyAdE762189Vs29ElL09dQ2bgoldDKUD8wM4
	JYwPqMDDGtXYaJtvfDHKTAmGlLnhhk0/suAk7XVE+cTug1hn3L1TP9rRIBKSGyd257IforEXlIX
	8o/+W7izvsdjeW1PCMuRRzSAqAI0PiN84oxkKv9WzumxAzH6x341mypQnwyJzL1TvCIWvCMv66k
	dfnkz638ssc07GUORY9RWBnBwFhTjO6AZm/9RjCHa3dUCtG1EMcCT8QNNCcb52efySSDCPOkk2E
	/Z3j/ww/
X-Received: by 2002:a05:6512:4147:b0:553:25e9:7f3a with SMTP id 2adb3069b0e04-55325e97fbdmr160073e87.36.1748263906265;
        Mon, 26 May 2025 05:51:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbUYYwfzZb+OGN39N2NMQpTC1fcBTwawJZeg/s6ljgk9Apq9BdD2PbfjdkZ+T1CNXKmlehQQ==
X-Received: by 2002:a05:6512:4147:b0:553:25e9:7f3a with SMTP id 2adb3069b0e04-55325e97fbdmr160062e87.36.1748263905761;
        Mon, 26 May 2025 05:51:45 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-550e702f1desm5129402e87.208.2025.05.26.05.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 05:51:45 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 427701AA3F2A; Mon, 26 May 2025 14:51:44 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Mina Almasry <almasrymina@google.com>
Subject: Re: [PATCH RFC net-next v2] page_pool: import Jesper's page_pool
 benchmark
In-Reply-To: <20250525034354.258247-1-almasrymina@google.com>
References: <20250525034354.258247-1-almasrymina@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 26 May 2025 14:51:44 +0200
Message-ID: <87iklna61r.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mina Almasry <almasrymina@google.com> writes:

> From: Jesper Dangaard Brouer <hawk@kernel.org>
>
> We frequently consult with Jesper's out-of-tree page_pool benchmark to
> evaluate page_pool changes.
>
> Import the benchmark into the upstream linux kernel tree so that (a)
> we're all running the same version, (b) pave the way for shared
> improvements, and (c) maybe one day integrate it with nipa, if possible.
>
> Import bench_page_pool_simple from commit 35b1716d0c30 ("Add
> page_bench06_walk_all"), from this repository:
> https://github.com/netoptimizer/prototype-kernel.git
>
> Changes done during upstreaming:
> - Fix checkpatch issues.
> - Remove the tasklet logic not needed.
> - Move under tools/testing
> - Create ksft for the benchmark.
> - Changed slightly how the benchmark gets build. Out of tree, time_bench
>   is built as an independent .ko. Here it is included in
>   bench_page_pool.ko
>
> Steps to run:
>
> ```
> mkdir -p /tmp/run-pp-bench
> make -C ./tools/testing/selftests/net/bench
> make -C ./tools/testing/selftests/net/bench install INSTALL_PATH=3D/tmp/r=
un-pp-bench
> rsync --delete -avz --progress /tmp/run-pp-bench mina@$SERVER:~/
> ssh mina@$SERVER << EOF
>   cd ~/run-pp-bench && sudo ./test_bench_page_pool.sh
> EOF
> ```
>
> Output:
>
> ```
> (benchmrk dmesg logs)
>
> Fast path results:
> no-softirq-page_pool01 Per elem: 11 cycles(tsc) 4.368 ns
>
> ptr_ring results:
> no-softirq-page_pool02 Per elem: 527 cycles(tsc) 195.187 ns
>
> slow path results:
> no-softirq-page_pool03 Per elem: 549 cycles(tsc) 203.466 ns
> ```
>
> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Back when you posted the first RFC, Jesper and I chatted about ways to
avoid the ugly "load module and read the output from dmesg" interface to
the test.

One idea we came up with was to make the module include only the "inner"
functions for the benchmark, and expose those to BPF as kfuncs. Then the
test runner can be a BPF program that runs the tests, collects the data
and passes it to userspace via maps or a ringbuffer or something. That's
a nicer and more customisable interface than the printk output. And if
they're small enough, maybe we could even include the functions into the
page_pool code itself, instead of in a separate benchmark module?

WDYT of that idea? :)

-Toke


