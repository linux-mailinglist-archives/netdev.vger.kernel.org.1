Return-Path: <netdev+bounces-153527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 041739F8858
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 00:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B71E16504E
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 23:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCAB1B4237;
	Thu, 19 Dec 2024 23:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WFB3XZ//"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFA919E98C
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 23:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734649597; cv=none; b=ZCCt2bajD1+AmuXbGZdmNwwGk1EthIJI4dk2fGhldmrEip5uOj1qMWxB6jfHlY0bOrB5X7msAaEHOJ6mv8VuQyf7Iu1UgaWIGBqbs/G1lKEnOrJE9U2XEBwLwqDtUq/5tRaxYlpw1v6TZru5ByEwNm+V2g7BXf+uA7fcg+1dF2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734649597; c=relaxed/simple;
	bh=Y5OzaKZMCYXt6ImRQ4NwELmCZEm8qS/Pf5ET66+CEOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U6zeONwod1Cb/YN3eosHWFczEub3n/gOAB2x2DaTa4vPt4VeucrQYMTnmiG0CC9yKqPNWl1++01WqbbtVzYxik40lOwXCQkJrgusU2qILjZJjYS2gPqmRkdr1mkoMt4N39hiYK1nYtVJrtxX1NcByY4+MTh8KyacpPJamQNSRJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WFB3XZ//; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0d09a543-b98c-4618-93e2-eef7bf8aec63@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734649593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2F97ZfMcDXZXw+wAaQ3beY+1mlMVHbm4KJmVwhLsHEc=;
	b=WFB3XZ//lhr3Z9PFgvebFs9vA7EzTzfi5/78oVzJnMHB4Yvn9VWV09J4/BD5qARU6rohUU
	WVU6WTGpOsVc9L2ACmkZdpitnqW9M+45iZumRXiCqKMibBLswTSssCAtbOCrpPOw5entqN
	mfAOf97Ap7JDyynSfhyW7ygxAD71qNk=
Date: Thu, 19 Dec 2024 15:06:28 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 01/13] bpf: Support getting referenced kptr
 from struct_ops argument
To: Amery Hung <ameryhung@gmail.com>
Cc: Amery Hung <amery.hung@bytedance.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 alexei.starovoitov@gmail.com, martin.lau@kernel.org, sinquersw@gmail.com,
 toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, stfomichev@gmail.com,
 ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn,
 xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com
References: <20241213232958.2388301-1-amery.hung@bytedance.com>
 <20241213232958.2388301-2-amery.hung@bytedance.com>
 <65399ffd-da8a-436a-81fd-b5bd3e4b8a54@linux.dev>
 <CAMB2axOPhr4fMa0J+u_V4TauohzUTwEex6HMwtgdoa8pqT0Mgw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAMB2axOPhr4fMa0J+u_V4TauohzUTwEex6HMwtgdoa8pqT0Mgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/18/24 8:57 AM, Amery Hung wrote:
>> At the first glance, the ref_obj_id assignment looks racy because ctx_arg_info
>> is shared by different bpf progs that may be verified in parallel. After another
>> thought, this should be fine because it should always end up having the same
>> ref_obj_id for the same arg-no, right? Not sure if UBSAN can understand this
>> without using the READ/WRITE_ONCE. but adding READ/WRITE_ONCE when using
>> ref_obj_id will be quite puzzling when reading the verifier code. Any better idea?
>>
> It looks like ref_obj_id cannot be reused (id always comes from
> ++env->id_gen), and these will be the earliest references to acquire.
> So, maybe we can assume the ref_obj_id without needing to store it in
> ctx_arg_info? E.g., the first __ref argument's ref_obj_id is always 1.

That seems reasonable to me. Then ctx_arg_info can stay read-only after the very 
first initialization during bpf_struct_ops_desc_init().

