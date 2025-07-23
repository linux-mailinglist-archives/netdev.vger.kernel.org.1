Return-Path: <netdev+bounces-209274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EEEB0EDFC
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 11:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AA473A4AB7
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 09:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394412494ED;
	Wed, 23 Jul 2025 09:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HzWSeog1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A4423C51B
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 09:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261370; cv=none; b=H3/+PfTHv4KE9k/Il+mW+W/JQlh2AyKGNz3Heg8d6sKoSATm3Rq1s5pOfArFZ3B/IHwdnQT7TUeHrA5uj8c4l49S0IN14m/tgsmXqkoyd5K0evO9oI/3EY3WzXqT3Lm8pFttgx5d4xFHvO8yzRmD0n6Rt6CKuz5wmbpY4KS3yfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261370; c=relaxed/simple;
	bh=ygKB/3qV/yZcQeyHE3M5GxconkSriNyOxhJHjVlIEjc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UzpfZBlVf//zYCgb5olBsOU5d0i61t7+vkP8LJqY8PtaeqJT/dHYGSLVdS74QC1yJjpQaiY187SSaOWlWpePmyDquWQkE+ezlEbVLkXWNbI8h7D0zXOswaaAp6dN1q8DuFPpxLLzd0Ly19y1EEkCDjdmlaexImfkcdNUH9/pB9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=HzWSeog1; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-af0dc229478so427839966b.1
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 02:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753261365; x=1753866165; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hytbl13aqp6nVCmL/eVfqPUZ9T67TEgc4air/Um7YUA=;
        b=HzWSeog1bAxl8zEaI1uinY9jxRTT+QAu644DT3q/jNvAMU1yEerUys4N8URrYEeiLh
         VHy1iM/5qudXvCWS2ukm1GmHYQNqGLhvJUGZBP08Hb3Gn5wKh4d5fOHwxefo9xMX6GOX
         PnAfIx4smF6cbzcxjcnG+ihtiRi1gku2YM7PD4EAElCFOK/ZNoYoL8nFo3S/weJbEs92
         WecCX5JNClEhLg+Q2ISm2DEYf6WTZLoXjr/BVNyC+R8ukgE0ndH5g3d4nd98v0BDAfSZ
         +syBwPln71+Yf1KzGaeNH/SlR17JF7EOysVbFqzPNKkM7GUhENhYt1JKhUYP1bU24S+b
         LDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753261365; x=1753866165;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hytbl13aqp6nVCmL/eVfqPUZ9T67TEgc4air/Um7YUA=;
        b=JGuiKfVNWz2otXRcYkCHZNELkmHQGt6ulge9wYg3HiiD9UzhPDWASHWypTy8NZXOsC
         y4Kq8viZe2fK6vhVT2PTJrOEI6okp3JkXVm6mB9S8i5c+YR4lNlmFWLr1ubUn32kWnqG
         kfCzTu6Vlic8Ln5BfIia8ODsiYJyK1VyO44F7bYeY8EzztCWbtxNTWRjA6LVlD3gsVTq
         PSrryc5v8/RHctkMwgzBQCs/deCU3EXJXtr7aLUfbfdbJyBND7dIAde20JaZVBXboPs6
         a5BCsRI3J4HLkvPIIeJUwVxaWN0quHkV+n1U9KtVmIdpmDS1fJ4Hk6WyaRfDjg4hmxLd
         xNVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJlbmKZ3/6k6d45vBP+fSuRckymaxSWhXLZ+9ii4MKXTTMn6i6SdGQGOLcOak692arYVhxZCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRV3dmHLHEQw39oC6pP4RFfi4HOKibWNwXHLHjOzks2wkjmW8t
	dVN7o+UDK+pebYO6XWVqVuj792h00uZ8SOreMSlkFc66iZ7w6RjxBCWULPqlEwqv5H4=
X-Gm-Gg: ASbGnct5fp/WMfIPec42YO1T0M8Smxykm1QL1PpAYFQSJM+/hyS1a7APC5tnm+GgfHZ
	0/faJWeSHhirZde0/wfquCsr8HpxMBpQlwJiygpi7jVMu4s2z2bHaVC5hCfo7CYgwvPXssiY5/Y
	IAdxk3sKqo02kfN8rnHp/zhDqW25fQC1gtV3DssMFfIEzYXas1+rGg+bgMbZE+JcJVFy6O93Pgh
	51RWdnZgxkdVTkSSxrreZBNJ3JQJ8WttTvfoX2f1qYEG1H2SthAXZr4ITERRhbTSkNT6EKp0K5f
	85nW4/n6NA0dLdkThiXDAGSNiThkaJ8j4qKw9vlYISxCkqlaiUdxpJNNDtpZkggQDhwmuJkwuge
	Dz7cS3C9u41dbVI4=
X-Google-Smtp-Source: AGHT+IEtmfosbL9HADnrTDM47eZxPqcaPYGnz5uE54cpkgA02QsDZ15GzaWfGfj2dkTKvvO6xws02g==
X-Received: by 2002:a17:907:788:b0:ade:450a:695a with SMTP id a640c23a62f3a-af2f9381584mr200492566b.61.1753261365414;
        Wed, 23 Jul 2025 02:02:45 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6cad3c4fsm1019228766b.153.2025.07.23.02.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 02:02:44 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,  Andrii Nakryiko
 <andrii@kernel.org>,  Arthur Fabre <arthur@arthurfabre.com>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Jesper Dangaard Brouer
 <hawk@kernel.org>,  Jesse Brandeburg <jbrandeburg@cloudflare.com>,  Joanne
 Koong <joannelkoong@gmail.com>,  Lorenzo Bianconi <lorenzo@kernel.org>,
  Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>,  Yan
 Zhai
 <yan@cloudflare.com>,  kernel-team@cloudflare.com,
  netdev@vger.kernel.org,  Stanislav Fomichev <sdf@fomichev.me>,
  bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 01/10] bpf: Add dynptr type for skb metadata
In-Reply-To: <5a43d42d-375d-4a90-b5ee-8e8ed239cefd@linux.dev> (Martin KaFai
	Lau's message of "Tue, 22 Jul 2025 17:37:03 -0700")
References: <20250721-skb-metadata-thru-dynptr-v3-0-e92be5534174@cloudflare.com>
	<20250721-skb-metadata-thru-dynptr-v3-1-e92be5534174@cloudflare.com>
	<5a43d42d-375d-4a90-b5ee-8e8ed239cefd@linux.dev>
Date: Wed, 23 Jul 2025 11:02:43 +0200
Message-ID: <87ecu7xoss.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 22, 2025 at 05:37 PM -07, Martin KaFai Lau wrote:
> On 7/21/25 3:52 AM, Jakub Sitnicki wrote:
>> @@ -21788,12 +21798,17 @@ static void specialize_kfunc(struct bpf_verifier_env *env,
>>   	if (offset)
>>   		return;
>>   -	if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb]) {
>> +	if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb] ||
>> +	    func_id == special_kfunc_list[KF_bpf_dynptr_from_skb_meta]) {
>
> I don't think this check is needed. The skb_meta is writable to tc.
>
>>   		seen_direct_write = env->seen_direct_write;
>>   		is_rdonly = !may_access_direct_pkt_data(env, NULL, BPF_WRITE);
>
> is_rdonly is always false here.
>
>>   -		if (is_rdonly)
>> -			*addr = (unsigned long)bpf_dynptr_from_skb_rdonly;
>> +		if (is_rdonly) {
>> +			if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb])
>> +				*addr = (unsigned long)bpf_dynptr_from_skb_rdonly;
>> +			else if (func_id == special_kfunc_list[KF_bpf_dynptr_from_skb_meta])
>> +				*addr = (unsigned long)bpf_dynptr_from_skb_meta_rdonly;
>> +		}
>
> [ ... ]
>
>> +int bpf_dynptr_from_skb_meta_rdonly(struct __sk_buff *skb, u64 flags,
>
> so I suspect this is never used and not needed now. Please check.
> It can be revisited in the future when other hooks are supported. It will be a
> useful comment in the commit message.

You're right. This is dead code ATM. I missed that. Will remove.

[...]

