Return-Path: <netdev+bounces-44802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F30CC7D9EA1
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 19:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99B01B2134E
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 17:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C343984F;
	Fri, 27 Oct 2023 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D/Le1jI3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563C43984A
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 17:06:40 +0000 (UTC)
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ad])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F306190
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 10:06:21 -0700 (PDT)
Message-ID: <b3f421b5-e9e2-4719-8529-56f2a0cf1cdf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698426179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QPrWm9vrW74blopqiHBg8E9fZAJbeACGgI3525E4PmU=;
	b=D/Le1jI3A2BRXH8isiIqCnpFNe9giI2cUUh1/6tCO+SQASF1UMTN9EtTihKMFZFcVziJ65
	rOmGkphIZrDdjKa8GCa6MFhYOFkGF+rC41md3+Hkc10WQB+JG7aQgwUBaWcYPg4L14rQns
	uid+isiu8LjULYqoE0N3pagTrI7472M=
Date: Fri, 27 Oct 2023 18:02:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: add skcipher API support to TC/XDP
 programs
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Vadim Fedorenko <vadfed@meta.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20231026015938.276743-1-vadfed@meta.com>
 <20231026144759.5ce20f4c@kernel.org>
 <a10cdab4-ab67-1cd2-0827-52c3755a464f@linux.dev>
 <20231026183509.471af050@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20231026183509.471af050@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 27/10/2023 02:35, Jakub Kicinski wrote:
> On Fri, 27 Oct 2023 00:29:29 +0100 Vadim Fedorenko wrote:
>>> Does anything prevent them from being used simultaneously
>>> by difference CPUs?
>>
>> The algorithm configuration and the key can be used by different CPUs
>> simultaneously
> 
> Makes sense, got confused ctx vs req. You allocate req on the fly.
> 
>>>> +	case BPF_DYNPTR_TYPE_SKB:
>>>> +		return skb_pointer_if_linear(ptr->data, ptr->offset, __bpf_dynptr_size(ptr));
>>>
>>> dynptr takes care of checking if skb can be written to?
>>
>> dynptr is used to take care of size checking, but this particular part is used
>> to provide plain buffer from skb. I'm really sure if we can (or should) encrypt
>> or decrypt in-place, so API now assumes that src and dst are different buffers.
> 
> Not sure this answers my question. What I'm asking is basically whether
> for destination we need to call __bpf_dynptr_is_rdonly() or something
> already checks that.

Well, I actually went to simpler implementation. As it's only needed for
dst buffer, move __bpf_dynptr_is_rdonly to helpers and use it to check
dst only and break earlier in case of error. If there will be other
customers of __bpf_dynptr_data_ptr helper, I'll implement it other way.

