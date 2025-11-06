Return-Path: <netdev+bounces-236144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CD1C38D3D
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 03:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BF7A188308B
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 02:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FED145FE0;
	Thu,  6 Nov 2025 02:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nOjhscal"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4A31940A1
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 02:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762395228; cv=none; b=uC2lqnRaKmyCfhbgnMc6vTGEin/Eo+YJdDH8KTZPYFdb433bIwHTAjpzk1AwJVsm6yB+THgJ6uzOKvT9yQXqkkkJwKEbWxP2W7PbXOlKqWXrSRbaDVDfIKaleAwNh2k6cocTWIyt6kbdlPG/hGUWhYVz0IYjGHGRbxgnfEOBbKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762395228; c=relaxed/simple;
	bh=7f9TmHFLejyXW6WhmX5o56MsGgwlFZNqHjxJrarpNq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tTwPa6Q5WH3GG5Nm1zcASug+C0Z9UnIyz69MDCvXb/mbfjmP9P6OganTBCn4x9CYQZlbOqf7fkaRga7MUrBkYeag4YmNKL7sQ6zrho4ckJNc7Pl46o/xM1UnrI1OrVzI5/puaWFL29pn9UsfXyliXHLwxIsfd/tCHQNhMZZcuf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nOjhscal; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0a3c4937-e4fd-49b6-a48c-88a4aa83e8a1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762395224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZdGB0owro0db2EQkneQ5txCo722w+01VqSOHUYGf7Q=;
	b=nOjhscallN6/ZyKoiZpsoBUHFJ05AYQQL0gguDvHOpsscYcFZIzogq1erR70YfjxVuEJ5g
	1A1JHy65FQ1cYW9d7VM8KDTGM90esTZ6cmEQbWGsz4Et806BxSpO4yDHRekBIZJLtkBb8n
	kNR9BFXXBCDU4G3DFVI5sH+l/DSd7Sc=
Date: Wed, 5 Nov 2025 18:13:39 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v5 3/7] bpf: Pin associated struct_ops when
 registering async callback
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org,
 kernel-team@meta.com, bpf@vger.kernel.org
References: <20251104172652.1746988-1-ameryhung@gmail.com>
 <20251104172652.1746988-4-ameryhung@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20251104172652.1746988-4-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/4/25 9:26 AM, Amery Hung wrote:
> Take a refcount of the associated struct_ops map to prevent the map from
> being freed when an async callback scheduled from a struct_ops program
> runs.
> 
> Since struct_ops programs do not take refcounts on the struct_ops map,
> it is possible for a struct_ops map to be freed when an async callback
> scheduled from it runs. To prevent this, take a refcount on prog->aux->
> st_ops_assoc and save it in a newly created struct bpf_async_res for
> every async mechanism. The reference needs to be preserved in
> bpf_async_res since prog->aux->st_ops_assoc can be poisoned anytime
> and reference leak could happen.
> 
> bpf_async_res will contain a async callback's BPF program and resources
> related to the BPF program. The resources will be acquired when
> registering a callback and released when cancelled or when the map
> associated with the callback is freed.
> 
> Also rename drop_prog_refcnt to bpf_async_cb_reset to better reflect
> what it now does.
> 

[ ... ]

> +static int bpf_async_res_get(struct bpf_async_res *res, struct bpf_prog *prog)
> +{
> +	struct bpf_map *st_ops_assoc = NULL;
> +	int err;
> +
> +	prog = bpf_prog_inc_not_zero(prog);
> +	if (IS_ERR(prog))
> +		return PTR_ERR(prog);
> +
> +	st_ops_assoc = READ_ONCE(prog->aux->st_ops_assoc);
> +	if (prog->type == BPF_PROG_TYPE_STRUCT_OPS &&
> +	    st_ops_assoc && st_ops_assoc != BPF_PTR_POISON) {
> +		st_ops_assoc = bpf_map_inc_not_zero(st_ops_assoc);

The READ_ONCE and inc_not_zero is an unusual combo. Should it be 
rcu_dereference and prog->aux->st_ops_assoc should be "__rcu" tagged?

If prog->aux->st_ops_assoc is protected by rcu, can the user (kfunc?) 
uses the prog->aux->st_ops_assoc depending on the rcu grace period alone 
without bpf_map_inc_not_zero? Does it matter if prog->aux->st_ops_assoc 
is changed? but this patch does not seem to consider the changing case also.


