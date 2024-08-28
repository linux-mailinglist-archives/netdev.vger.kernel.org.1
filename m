Return-Path: <netdev+bounces-122668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87928962236
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 10:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACA5B1C22111
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 08:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189FE15B12A;
	Wed, 28 Aug 2024 08:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dYPTbQdG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B2D156967
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 08:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724833241; cv=none; b=rLmk1XUt9G6+jvumg3w/996412AOjs5+FGyy2SU4PEUWNi7+H5RPyyk7XG88z8tK5+1hxdis+ax7RXtszDyKpjp7jHnuj0SMJFLPXzY4AVnZ8Nu3kFNeM5nJFKvs9LEcBRAUAD8k0xhs/4hDarCnBLmMU8ytTxGBkK87g7539rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724833241; c=relaxed/simple;
	bh=1lx02cr09o0GvC4pP+O93KnU2VBN6Uii6gCTgj3Z0xE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mgrrKvoGxJHRO/H6VgSVaDayhsxZhiim7iJOCSxs8D+MhI8h3vXsufdl8sgtVt+uV8lhm82g1FpWiUFHaz+1twmtjD1t0xvff9N7aaBNhxv2HdoZZMOjJXZ5M5sh2Hh79nguJQkJuZ3s3ZeOYf7olc//wGaqR6w2AjASedxhVJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dYPTbQdG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724833238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RB+6lhxu3ehfP+zrXXgfWhDBZmy97wctUMf7QuJM/wI=;
	b=dYPTbQdG8TTYum38gPkB1OF/+MV2ldS6hSu2fc+gvHD4Kl5y7x+0kujnm/4RyDi59PZ7k8
	B4k0MN/R6CCr0Y1jKu1ywR+UPbRxWNIqhgKMshyBG9zoh76hGcSQ+zcF9j82jfcIQdSPVv
	H40F39uLzsH03vqOV8kIl2AMDaFKcT0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-tQv7xDZJOli7zXX1OzHMjw-1; Wed, 28 Aug 2024 04:20:36 -0400
X-MC-Unique: tQv7xDZJOli7zXX1OzHMjw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4280a39ecebso1904075e9.0
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 01:20:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724833235; x=1725438035;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RB+6lhxu3ehfP+zrXXgfWhDBZmy97wctUMf7QuJM/wI=;
        b=K2fETckj3syi5uuRV1duP1FR/LFi7sKtTE6DYzjp8zywR3XU6QPX0CEbYBjua4CXzw
         THP8oAt208AzYCFBXlolQ4xO26UzE5W2Yd2HtrC6JbMWbwsTmOgBtPpsfhfj8laVONqu
         101gbLti/FGPECyQY4+RuDtm98lugbXQXQkXuPiEABeO7TtE/TTsKylZkzaMonpz8bXz
         /1LOeQmtJF73u1fTGWrJ4l9CDqj4SmRco7lVONfMOGK4sBU98+Qvh1ZjVKGXSueBC5ds
         6+0qvS7+OKoTExDarMpQxyYLxBPsr8YFT1Ywvv+A8En17V7EbYBw+y7Mm8z0AgdkTGXU
         U/Fg==
X-Forwarded-Encrypted: i=1; AJvYcCVyGuXdLpxu1giqfviV/etNHTypPWUKKCOHOIFuYtxE94YIY7INBo4T44oeHz/3WlSN5RGPdKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXitgS/FKfMWKc7IfBau7Qix3pi4jkd/PtuZeqnWTMVSZfKYCR
	ZR+V1E02DkYLphLVhRv18zhal5KlV0m6puRdxulMOCQIn7vPK48US/XOKuqz4GT5JdTXBEnU5TW
	g1jXihrHjIgWyWRoTWuSFYCkDw601X41Su1weh4A2wby8prTQviLlZQ==
X-Received: by 2002:a05:600c:468a:b0:428:b4a:7001 with SMTP id 5b1f17b1804b1-42ba572f39fmr7389855e9.15.1724833234650;
        Wed, 28 Aug 2024 01:20:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHsbTzYkFGfKQB6RCD+HDMcq6rBfUzAZuckOuRNsoFpeBcypplDnwz5Dg+z2fP7injSiDcAw==
X-Received: by 2002:a05:600c:468a:b0:428:b4a:7001 with SMTP id 5b1f17b1804b1-42ba572f39fmr7389605e9.15.1724833233996;
        Wed, 28 Aug 2024 01:20:33 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b50:3f10:2f04:34dd:5974:1d13? ([2a0d:3344:1b50:3f10:2f04:34dd:5974:1d13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba63d816bsm13471755e9.36.2024.08.28.01.20.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 01:20:33 -0700 (PDT)
Message-ID: <401f173b-3465-428d-9b90-b87a76a39cc8@redhat.com>
Date: Wed, 28 Aug 2024 10:20:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next RFC] selftests/net: integrate packetdrill with
 ksft
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 ncardwell@google.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 fw@strlen.de, Willem de Bruijn <willemb@google.com>,
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, martineau@kernel.org
References: <20240827193417.2792223-1-willemdebruijn.kernel@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240827193417.2792223-1-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Adding Mat(s) for awareness, it would be great (but difficult) to have 
mptcp too in the long run ;)

On 8/27/24 21:32, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Lay the groundwork to import into kselftests the over 150 packetdrill
> TCP/IP conformance tests on github.com/google/packetdrill.
> 
> Florian recently added support for packetdrill tests in nf_conntrack,Addin
> in commit a8a388c2aae49 ("selftests: netfilter: add packetdrill based
> conntrack tests").
> 
> This patch takes a slightly different implementation and reuses the
> ksft python library for its KTAP, ksft, NetNS and other such tooling.
> 
> It also anticipates the large number of testcases, by creating a
> separate kselftest for each feature (directory). It does this by
> copying the template script packetdrill_ksft.py for each directory,
> and putting those in TEST_CUSTOM_PROGS so that kselftests runs each.
> 
> To demonstrate the code with minimal patch size, initially import only
> two features/directories from github. One with a single script, and
> one with two. This was the only reason to pick tcp/inq and tcp/md5.
> 
> Any future imports of packetdrill tests should require no additional
> coding. Just add the tcp/$FEATURE directory with *.pkt files.
> 
> Implementation notes:
> - restore alphabetical order when adding the new directory to
>    tools/testing/selftests/Makefile
> - copied *.pkt files and support verbatim from the github project,
>    except for
>      - update common/defaults.sh path (there are two paths on github)
>      - add SPDX headers
>      - remove one author statement
>      - Acknowledgment: drop an e (checkpatch)
> 
> Tested:
> 	make -C tools/testing/selftests/ \
> 	  TARGETS=net/packetdrill \
> 	  install INSTALL_PATH=$KSFT_INSTALL_PATH
> 
> 	# in virtme-ng
> 	sudo ./run_kselftest.sh -c net/packetdrill
> 	sudo ./run_kselftest.sh -t net/packetdrill:tcp_inq.py
> 
> Result:
> 	kselftest: Running tests in net/packetdrill
> 	TAP version 13
> 	1..2
> 	# timeout set to 45
> 	# selftests: net/packetdrill: tcp_inq.py
> 	# KTAP version 1
> 	# 1..4
> 	# ok 1 tcp_inq.client-v4
> 	# ok 2 tcp_inq.client-v6
> 	# ok 3 tcp_inq.server-v4
> 	# ok 4 tcp_inq.server-v6
> 	# # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0
> 	ok 1 selftests: net/packetdrill: tcp_inq.py
> 	# timeout set to 45
> 	# selftests: net/packetdrill: tcp_md5.py
> 	# KTAP version 1
> 	# 1..2
> 	# ok 1 tcp_md5.md5-only-on-client-ack-v4
> 	# ok 2 tcp_md5.md5-only-on-client-ack-v6
> 	# # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
> 	ok 2 selftests: net/packetdrill: tcp_md5.py
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> 
> ---
> 
> RFC points for discussion
> 
> ksft: the choice for this python framework introduces a dependency on
> the YNL scripts, and some non-obvious code:
> - to include the net/lib dep in tools/testing/selftests/Makefile
> - a boilerplate lib/py/__init__.py that each user of ksft will need
> It seems preferable to me to use ksft.py over reinventing the wheel,
> e.g., to print KTAP output. But perhaps we can make it more obvious
> for future ksft users, and make the dependency on YNL optional.
> 
> kselftest-per-directory: copying packetdrill_ksft.py to create a
> separate script per dir is a bit of a hack. 

Additionally, in some setups the test directory is RO, avoding file 
creation there would be better.

What about placing in each subdiretory a trivial wrapper invoking the 
'main' packetdrill_ksft.py script specifying as an argument the 
(sub-)directory to run/process?

> A single script is much
> simpler, optionally with nested KTAP (not supported yet by ksft). But,
> I'm afraid that running time without intermediate output will be very
> long when we integrate all packetdrill scripts.

If I read correctly, this runs the scripts in the given directory 
sequentially (as opposed to the default pktdrill run_all.py behavior 
that uses many concurrent threads).

I guess/fear that running all the pktdrill tests in a single batch would 
take quite a long time, which in turn could be not so good for CI 
integration. Currently there are a couple of CI test-cases with runtime 
 > 1h, but that is bad ;)

> nf_conntrack: we can dedup the common.sh.
> 
> *pkt files: which of the 150+ scripts on github are candidates for
> kselftests, all or a subset? To avoid change detector tests. And what
> is the best way to eventually send up to 150 files, 7K LoC.

I have no idea WRT the overall test stability, is some specific case/dir 
is subject to very frequent false positive/false negative we could 
postpone importing them, but ideally IMHO all the github scripts are 
good candidates.

Side note: I think it would be great to have some easy command line 
parameter to run only the specified script/test-case.

Thanks!

Paolo


