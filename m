Return-Path: <netdev+bounces-248572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E0AD0BBC4
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 18:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 24FC6303F4DB
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 17:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5068A366DD7;
	Fri,  9 Jan 2026 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HzxOPOtS"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A987133BBC6
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 17:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767980550; cv=none; b=CIkMjFbgkh+/8sXDD48qeDcCDOr6lyiegleSouMWWIJcevEr7zyfyEr7f3HczKJMFTt4dlD6thznS2zKdV+IBRcSvGdVe91DEKLV/oSIeE84tQrD7ZhlPujdDEwFwPAu1jf8yOLV+7ZCUem8Z3QcMXd7rsluGq7oyued5ls3X9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767980550; c=relaxed/simple;
	bh=jDaE/4G9sH62rAQhGnpFwOhs1DBKjM2F+Y2i75/gnro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LoQXw9vtrbbMoEi7J/Pg9Wmozsgv/wjTmYV9EBT5CzcSIZJGSBGgaq5ii5sN+yLAUSzJ9RKMgCV4r8bvKRJWkp0knGs5+a2wCor5lFcKzQUzv0TA2T+ZEokLDEIXxTjBwvhUhDlpG5ajG01TjHIj0K6PLC/IB7YdUaNcuWjbvAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HzxOPOtS; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <429e4120-b973-4b26-9c50-2e03c104253a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767980536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lj5W6kqh7lX+37IEEa43roJ1s1YmsxJY/0Lu06gUPJ4=;
	b=HzxOPOtSH8uzHCJC7tgY0UY+bxOxuL+YBklu2aqFT2Rr5h1KEhn1pFcZVCFso9gwlYshBt
	zh25HdWCiqm+IoxSgcMN5ZhzYvoszX2F5Gin3upo1L1eQGG4pYUW7QrnMOXj2fJOFZiEVk
	Vu4eOYrwy7puoxx+UlEkwj/ZERSxhWQ=
Date: Fri, 9 Jan 2026 09:42:04 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 03/16] bpf: Open code bpf_selem_unlink_storage
 in bpf_selem_unlink
To: Amery Hung <ameryhung@gmail.com>
Cc: netdev@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org,
 daniel@iogearbox.net, memxor@gmail.com, martin.lau@kernel.org,
 kpsingh@kernel.org, yonghong.song@linux.dev, song@kernel.org,
 haoluo@google.com, bpf@vger.kernel.org, kernel-team@meta.com
References: <20251218175628.1460321-1-ameryhung@gmail.com>
 <20251218175628.1460321-4-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251218175628.1460321-4-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/18/25 9:56 AM, Amery Hung wrote:
> @@ -396,17 +369,39 @@ static void bpf_selem_link_map_nolock(struct bpf_local_storage_map *smap,
>   
>   void bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)

bpf_selem_unlink() will not be used by bpf_local_storage_map_free() in 
the later patch, so the "bool reuse_now" arg is no longer needed and 
should be cleaned up.




