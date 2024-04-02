Return-Path: <netdev+bounces-84060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 048D1895607
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 16:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36E181C220EE
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 14:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C2D84FCC;
	Tue,  2 Apr 2024 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="CPtOGAR4"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E512582893;
	Tue,  2 Apr 2024 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712066533; cv=none; b=lP6bOkWHPQnTs/6fIMWYPgCuinn1GEuFtSA9PnXh/eJ/FD+MJF1Xc9wSaNMHlct6bBJ2FU8pMfE+liFAEi7IpQA+vOwYuAyDfF0kpbGBkXCCliMu5wMO6sxm8+f7QCpm1F01TXrD5MX718ZS/ngqbpJtqTbnFzmYKEpY0aBxw5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712066533; c=relaxed/simple;
	bh=MOhwCxMQctbQFU+axR1Gekz5rCSR4g5hpIDWONlTUOc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ohKxYHQDZPh8MqlZAaVFEMpb8E/oyUn7tndSGW8sSGmR+bdO+BxSXJUtR7TJydOhlmjewLDx8K8hRfenXMEO92sS/UflEAR++v6b75OjRydhV9V9JB6sH93h7fDiZBK7GqM0W52UlQ6vCGtkYJ/yh4W9ZVVOdMVb85zA0CTm9z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=CPtOGAR4; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=sDKSBKctIHDpPvXzGMLCuAyCRKl5uTk+wKlRRmtyYU8=; b=CPtOGAR4IzTp1fXZss506ooEAh
	61WURTi40li+u+jDmEa2wooqXUZTNEm1PkmZFeqN48swERppVnyqRhInsf3ExyJBJ7RemR1SSTvTL
	I/WY6e/RbmANMoB7LMyiT0IyN+gQMNTOrR4NDfUgBA6XGKJzYeUu9gUpF1g+1yo1N8q68jQy9Yj4+
	1Xb2oRGPbig7E5Ts0kZ7pgbpHE3VhvdBBgy19P3z56xnHqgJrD6372tlzjo32n7p/K+drreEMRYG1
	SJsT02XTfZaeYZD1We0RtoOkIvudvKgIKO3yvKfUvmIVDeFYaUobxZiyZnDFtFYJR7EbceJ+HeYxv
	+IREPgLQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rreiE-000C7B-Cn; Tue, 02 Apr 2024 16:02:06 +0200
Received: from [178.197.248.12] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1rreiD-00Er11-12;
	Tue, 02 Apr 2024 16:02:05 +0200
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add testcase where 7th
 argment is struct
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Pu Lehui <pulehui@huawei.com>
References: <20240331092405.822571-1-pulehui@huaweicloud.com>
 <20240331092405.822571-3-pulehui@huaweicloud.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <967f996f-f660-4615-696e-95c5db0542ad@iogearbox.net>
Date: Tue, 2 Apr 2024 16:02:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240331092405.822571-3-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27233/Tue Apr  2 10:26:21 2024)

On 3/31/24 11:24 AM, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> Add testcase where 7th argument is struct for architectures with 8
> argument registers, and increase the complexity of the struct.
> 
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 19 ++++++++++
>   .../selftests/bpf/prog_tests/tracing_struct.c | 13 +++++++
>   .../selftests/bpf/progs/tracing_struct.c      | 35 +++++++++++++++++++
>   3 files changed, 67 insertions(+)

The last test from this patch fails BPF CI, ptal :

https://github.com/kernel-patches/bpf/actions/runs/8497262674/job/23275690303
https://github.com/kernel-patches/bpf/actions/runs/8497262674/job/23275690364

Notice: Success: 519/3592, Skipped: 53, Failed: 1
Error: #391 tracing_struct
   Error: #391 tracing_struct
   test_fentry:PASS:tracing_struct__open_and_load 0 nsec
   libbpf: prog 'test_struct_arg_16': failed to attach: ERROR: strerror_r(-524)=22
   libbpf: prog 'test_struct_arg_16': failed to auto-attach: -524
   test_fentry:FAIL:tracing_struct__attach unexpected error: -524 (errno 524)
Test Results:
              bpftool: PASS
           test_progs: FAIL (returned 1)
Error: Process completed with exit code 1.

