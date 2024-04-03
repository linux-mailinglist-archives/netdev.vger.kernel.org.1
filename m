Return-Path: <netdev+bounces-84529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4018972E8
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 16:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E513B29D02
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE9859B6C;
	Wed,  3 Apr 2024 14:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="IPdAwJab"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863AD433C6;
	Wed,  3 Apr 2024 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712155245; cv=none; b=R7OEWLl+JIjnAfcVjP77MqhKTRc4d1tSZ+EcYGfhms6XLvtEyS8oDp9Xt2UqIKaASzGZMvFE0PxMngZ5kS3OgBJFhBSNHbDoKs7Y07l/zyEjZiu5zgqd0iMLW2qox0Kpiam5ccJxPVSk3dd0TV0Vbmqlg1cZ8Q5v4WkmvOP3zyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712155245; c=relaxed/simple;
	bh=rT8sHi1P6vKvW4jge+5i6dqA062uBbrUeQnCV3IwOqg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=gE6qzQE1e08Cj3okd+U/OegW7Fo5vgc131+DfAH2u9s4mNFGdp55J21XeWz7GoeYyctJE8qKCPyZw4fT/ZJB8fVsDUWRQ6py/To5/uDqLmwOWoXC4UTTOstON7N/QHErA/x90k6F2X2fDzFtQhuvbOqsKhX3NfxZipvX5tiqrG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=IPdAwJab; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=uicBnio8bSF9DNnpycUBJL1Q+Lal4LWdPwlItPeKwW8=; b=IPdAwJabygxRsrSF9Q+IWM4qvL
	DkEc3QUZnw0Hfp0paVdxSRdz/YF3XvHnIx5vZDQ6VEbqjmKXWScvLYOh18FCMfIcwdV0UeKhOKTAO
	rWgyf9XmSmOEx75/T5fAFJbfgNkuqPzeS2rwzc19BsbboL2qler/bq8/4GkWjfqWUuVgH+Mkshx/r
	ouABhQnMmViDhug5/DN1P10PAUO0I7Lj0KoBEp8u8PDGdYDFTC4FFd1EAIXEtr4/z1ggbMfeIiXoo
	vRpclL+AtnZsqgunSl3N5KMB3iQ3mBoUbR8jGN8Pdyre7mvKCR7QPY1GDUgkRtUbAeGrhXO9do2e3
	mTnKXw2g==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rs1n6-000Oqk-CH; Wed, 03 Apr 2024 16:40:40 +0200
Received: from [178.197.248.12] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1rs1n5-001zbP-0p;
	Wed, 03 Apr 2024 16:40:39 +0200
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add testcase where 7th
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
References: <20240403072818.1462811-1-pulehui@huaweicloud.com>
 <20240403072818.1462811-3-pulehui@huaweicloud.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0f459fc1-1445-6e83-ace4-b2c42abfe884@iogearbox.net>
Date: Wed, 3 Apr 2024 16:40:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240403072818.1462811-3-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27234/Wed Apr  3 10:25:27 2024)

On 4/3/24 9:28 AM, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
> 
> Add testcase where 7th argument is struct for architectures with 8
> argument registers, and increase the complexity of the struct.
> 
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> Acked-by: Björn Töpel <bjorn@kernel.org>
> Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
> ---
>   tools/testing/selftests/bpf/DENYLIST.aarch64  |  1 +
>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 19 ++++++++++
>   .../selftests/bpf/prog_tests/tracing_struct.c | 13 +++++++
>   .../selftests/bpf/progs/tracing_struct.c      | 35 +++++++++++++++++++
>   4 files changed, 68 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/DENYLIST.aarch64 b/tools/testing/selftests/bpf/DENYLIST.aarch64
> index d8ade15e2789..639ee3f5bc74 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.aarch64
> +++ b/tools/testing/selftests/bpf/DENYLIST.aarch64
> @@ -6,6 +6,7 @@ kprobe_multi_test                                # needs CONFIG_FPROBE
>   module_attach                                    # prog 'kprobe_multi': failed to auto-attach: -95
>   fentry_test/fentry_many_args                     # fentry_many_args:FAIL:fentry_many_args_attach unexpected error: -524
>   fexit_test/fexit_many_args                       # fexit_many_args:FAIL:fexit_many_args_attach unexpected error: -524
> +tracing_struct                                   # test_fentry:FAIL:tracing_struct__attach unexpected error: -524

Do we need to blacklist the whole test given it had coverage on arm64
before.. perhaps this test here could be done as a new subtest and only
that one is listed for arm64?

>   fill_link_info/kprobe_multi_link_info            # bpf_program__attach_kprobe_multi_opts unexpected error: -95
>   fill_link_info/kretprobe_multi_link_info         # bpf_program__attach_kprobe_multi_opts unexpected error: -95
>   fill_link_info/kprobe_multi_invalid_ubuff        # bpf_program__attach_kprobe_multi_opts unexpected error: -95

Thanks,
Daniel

