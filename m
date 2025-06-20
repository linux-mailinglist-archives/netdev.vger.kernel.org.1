Return-Path: <netdev+bounces-199666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1151DAE1538
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 09:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50840188951F
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 07:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9016B22E3E9;
	Fri, 20 Jun 2025 07:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yzl19JMI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BB322DFAD
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 07:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750405768; cv=none; b=AJ+iAey3ydus2eB+rbzXeNvvOKX7vdgPFMMmWIeCNNn7EEWCOHeAjKedBy7sc9ZCHg0oSsJpiS6kbKuLLGIRftA02s6tMa2hben/wJ5IcvY2Y/OTvSLPfXyAQ5P1oakzulRqOTsyAIU6LtEhRVpUgGKl0dZTttWYii5srtcq7t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750405768; c=relaxed/simple;
	bh=lPTn097d3RKmYQXcQJXHtz90CBTGa1mOLWU8ZI0qkp8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VrzVQfwM3UgNftBF6B+O+6eWYPYNW3kzoAg3AgC4aRKlcb7xyvcweKDNieI3clNGlVa+HJGNVs9UK10JDoo3OFfuM+c0ZYVoqN11LnBF/vrh6XSFPW5tvI8M37/YaTKxl9LbeXwQU7pIV96TNIA+5sUN3sEwPvPYGnRMwrLYkBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yzl19JMI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750405764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/NfKHQF9oEI9qiwLXTW6bFDUNC1qeYOK5nIoYRGjPo=;
	b=Yzl19JMIY5R14RaRYubJV+78OEkgc0EwUAINugJyMGuDWanK89ac8gFMOd1mWQRdvGggA/
	hDN2eA21a2zwwAt+9Xrdp91M7hP3bf0C11Phu5ytWHKnd27FXIagXx+YsEHlMi80eAVx1V
	mW2ZkwsX4UwTJS34UszRG/z+s35ZBM4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-DHDoMLfXMTyDyloDM2LAEg-1; Fri, 20 Jun 2025 03:49:22 -0400
X-MC-Unique: DHDoMLfXMTyDyloDM2LAEg-1
X-Mimecast-MFC-AGG-ID: DHDoMLfXMTyDyloDM2LAEg_1750405761
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-553b902b3cdso840941e87.1
        for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 00:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750405761; x=1751010561;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/NfKHQF9oEI9qiwLXTW6bFDUNC1qeYOK5nIoYRGjPo=;
        b=MvqzGIJe+ddVzMpiyzO5I3IkdzCpeyk0aNV24f4glvX9YYwRA6hOtHGRFmJovWWJkN
         UDXpRiUC5dpKAm4ArVOysCTmSHaVtwDVfRgXaHVvoPyv4XgPUD3WcP5dkKB79fASFdKD
         PBTc8nd+Zapbwd0yTJ9JgJNee7Skq+s2AdtPhQg8gU2OawWqRbiVxTmp84xdOXy3gZd6
         ZJ36N4eJRfyUJL1sMgcxVZMYMarGl1sVI4ZKa6FRRemGr1y06iUlBMSy8tA9mEZzVx7/
         bga2MT0Zc64WUycbju3cksj4eK3TCWWcj1FJw6owYNXH1i6OZz3+2LLGOncna9ctc94F
         mmcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0U+YuE3bssgd6Aa9tX1br5sLFnJt0HZYXiOf8XD+voKKhuYnlYLbOfsd8PaQyAhOSudJN1L4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjtzurHCpkM8Ur6pFgCrp1NrpxOTKlWWmn3PQQ4gmFl0CUAjCQ
	cHE4CTQLAU0ZYMN4mRV25xSPulqNvqcMcphZN4mqQdGfcjNuuRg/+KJlpIfrbm9XZfkKeym6m4E
	J+Tqj0JEQAmRTXX2EcfJD8c7SOlSblU+ByPhUB1hLcADgLyHQAYqJO7ax7A==
X-Gm-Gg: ASbGncuZJvkNr8XYXSYl+W34W5wV5Yz/SwqD7VSLA8qH0D/RtXFv9CcDH+dpwGe754K
	NbLRhdeLSF31hhXvYScK4MT5TMMvge9nEBNREdGZpWnlGEg9reuO5Op20qMMpg7JG1cMDwg1yi0
	1cILFnOCW9C0mnlugad6Y8qOmYneI7FIzitNgCNAf/YyrszYLWuBzmYq807NV3/70Hvt/dsd/HX
	FraV3dO3iHb2tyVLbe5KMbkMKYuIC912sEZzPnguza/9LJB9KedP0mrRfGGcGX5B2s8j5vjP7If
	QLXv9QD8+Q9DeI6LXqU=
X-Received: by 2002:a05:6512:1323:b0:553:accf:d75 with SMTP id 2adb3069b0e04-553e3cfdb6bmr549354e87.26.1750405761120;
        Fri, 20 Jun 2025 00:49:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLy5SMi0UipUNre443G7f4CTQNRiybWOKExd4GM5/+BAIumn05sVzdmmKiq+TDs10cab3gRg==
X-Received: by 2002:a05:6512:1323:b0:553:accf:d75 with SMTP id 2adb3069b0e04-553e3cfdb6bmr549341e87.26.1750405760660;
        Fri, 20 Jun 2025 00:49:20 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553e41bbdcesm187600e87.116.2025.06.20.00.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 00:49:19 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A6FAA1B372DF; Fri, 20 Jun 2025 09:49:18 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Mina Almasry <almasrymina@google.com>
Subject: Re: [PATCH net-next v5] page_pool: import Jesper's page_pool benchmark
In-Reply-To: <20250619181519.3102426-1-almasrymina@google.com>
References: <20250619181519.3102426-1-almasrymina@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 20 Jun 2025 09:49:18 +0200
Message-ID: <87ecvezwch.fsf@toke.dk>
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
> Note that by default, the Makefile will build the benchmark for the
> currently installed kernel in /lib/modules/$(shell uname -r)/build. To
> build against the current tree, do:
>
> make KDIR=3D$(pwd) -C ./tools/testing/selftests/net/bench
>
> Output (from Jesper):
>
> ```
> sudo ./test_bench_page_pool.sh
> (benchmark dmesg logs snipped)
>
> Fast path results:
> no-softirq-page_pool01 Per elem: 23 cycles(tsc) 6.571 ns
>
> ptr_ring results:
> no-softirq-page_pool02 Per elem: 60 cycles(tsc) 16.862 ns
>
> slow path results:
> no-softirq-page_pool03 Per elem: 265 cycles(tsc) 73.739 ns
> ```
>
> Output (from me):
>
> ```
> sudo ./test_bench_page_pool.sh
> (benchmark dmesg logs snipped)
>
> Fast path results:
> no-softirq-page_pool01 Per elem: 11 cycles(tsc) 4.177 ns
>
> ptr_ring results:
> no-softirq-page_pool02 Per elem: 51 cycles(tsc) 19.117 ns
>
> slow path results:
> no-softirq-page_pool03 Per elem: 168 cycles(tsc) 62.469 ns
> ```
>
> Results of course will vary based on hardware/kernel/configs, and some
> variance may be there from run to run due to some noise.
>
> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


