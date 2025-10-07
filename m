Return-Path: <netdev+bounces-228054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A548FBC01D1
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 05:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98411189DF74
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 03:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842DD2036E9;
	Tue,  7 Oct 2025 03:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sHtHr9+4"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2998D20322
	for <netdev@vger.kernel.org>; Tue,  7 Oct 2025 03:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759809008; cv=none; b=ejUfjOhfKRFB9uEo8r+3OV2LP1lgs88zNPR6zwqk49EMHf7+O/xZ6siC7sLR5Pdt13XWoc5cZZAFRTrSRadC+rXJeDFLtq3VIde+aijLHBNZ1DhP0w+prRccV5jLdvXzHIKuD51A1jyrnmRuIA0PDDbxnJ1FTWx7TuutkmXz0+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759809008; c=relaxed/simple;
	bh=cNlI9bHI/ylXQMlNzU+Ogaqapl/G/HUfveqiYuJSf9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mcKFIDD9Zpf0T8PzKCf1EdJD1ObHhvs5eU+U+RMj6mPvMThBEKBwu4pMMQgrAus6Kx+L67T3BYBVhEK1R8f1ZONR0oa9XJBs7YvvtScOwbeicC8HGAVTrNy1KNz75MST7M1/dTpaPrH7/a1qzwzJqeUxSIS3/mCtLqX/WhTCM7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sHtHr9+4; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759808994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Hiokzts7PCRKt1OVuEkEGfOq4GhsmdPG6MMIx7taoM=;
	b=sHtHr9+4cBBh32A4cQH2VvK5uHIQpnTYzLql6prkqaJLjI/AtwzFWxpGRZTH188yEsCX9e
	fe7RzXPZ0LP/zmMJludJbuFqY8x/U2qXtxpqTaSgGuiFLKxT6OGYnGFHPY+Yx97OOjFqVU
	/tv2iMaa4OYCXP5muCy+TCQcYvYIUho=
From: Menglong Dong <menglong.dong@linux.dev>
To: Fushuai Wang <wangfushuai@baidu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, ast@kernel.org, martin.lau@kernel.org,
 houtao1@huawei.com, jkangas@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Fushuai Wang <wangfushuai@baidu.com>,
 bpf@vger.kernel.org
Subject:
 Re: [PATCH bpf-next] bpf: Use rcu_read_lock_dont_migrate() and and
 rcu_read_unlock_migrate()
Date: Tue, 07 Oct 2025 11:49:42 +0800
Message-ID: <3379803.44csPzL39Z@7950hx>
In-Reply-To: <20251005150816.38799-1-wangfushuai@baidu.com>
References: <20251005150816.38799-1-wangfushuai@baidu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/10/5 23:08, Fushuai Wang wrote:
> Replace the combination of migrate_disable()/migrate_enable() and rcu_read_lock()/rcu_read_unlock()
> with rcu_read_lock_dont_migrate()/rcu_read_unlock_migrate() in bpf_sk_storage.c.

Hi, Fushuai. There are some nits in you patch:

1. The title is too fuzzy. It can be
    "bpf: Use rcu_read_lock_dont_migrate in bpf_sk_storage.c"
2. You can wrap the commit log and don't exceed 75 character per line.
    This is not necessary, but it can stop the check_patch from
    complaining.

And I think you shoud CC bpf@vger.kernel.org too. Before you
send the patch, you can check it with ./scripts/checkpatch.pl to
find potential problems.

Thanks!
Menglong Dong

> 
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
> ---
>  net/core/bpf_sk_storage.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index 2e538399757f..bdb70cf89ae1 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -50,16 +50,14 @@ void bpf_sk_storage_free(struct sock *sk)
>  {
>  	struct bpf_local_storage *sk_storage;
>  
> -	migrate_disable();
> -	rcu_read_lock();
> +	rcu_read_lock_dont_migrate();
>  	sk_storage = rcu_dereference(sk->sk_bpf_storage);
>  	if (!sk_storage)
>  		goto out;
>  
>  	bpf_local_storage_destroy(sk_storage);
>  out:
> -	rcu_read_unlock();
> -	migrate_enable();
> +	rcu_read_unlock_migrate();
>  }
>  
>  static void bpf_sk_storage_map_free(struct bpf_map *map)
> @@ -161,8 +159,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
>  
>  	RCU_INIT_POINTER(newsk->sk_bpf_storage, NULL);
>  
> -	migrate_disable();
> -	rcu_read_lock();
> +	rcu_read_lock_dont_migrate();
>  	sk_storage = rcu_dereference(sk->sk_bpf_storage);
>  
>  	if (!sk_storage || hlist_empty(&sk_storage->list))
> @@ -213,9 +210,8 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
>  	}
>  
>  out:
> -	rcu_read_unlock();
> -	migrate_enable();
>  
> +	rcu_read_unlock_migrate();
>  	/* In case of an error, don't free anything explicitly here, the
>  	 * caller is responsible to call bpf_sk_storage_free.
>  	 */
> 





