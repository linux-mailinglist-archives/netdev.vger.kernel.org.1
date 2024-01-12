Return-Path: <netdev+bounces-63369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4010482C781
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 23:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D287A2820F7
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 22:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76C818C01;
	Fri, 12 Jan 2024 22:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h/pENF9/"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C966514F6D
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 22:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <33db92ee-e6aa-49e6-94f5-89c44c32f044@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705100386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eZmveDznq2njkk2SuZgdEN7szK/7fWx7nXrQwcFPKT0=;
	b=h/pENF9/UrK+1Z7JX5J2gEWJNWN1tbgkMr1UiH6Y8LVBV/KbIvLiNTB9R1yyjnJQxzvsQr
	DGMmOkhkbeX4LRxNy8m6ndNcbuh2axwOhU7mTWlhDcvuLK1g8m9zQ8+BklG0snklvVxZ7L
	COybnlvrpq8eR542f+g1Ff5RcnHVXss=
Date: Fri, 12 Jan 2024 14:59:43 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/3] ss: pretty-print BPF socket-local storage
Content-Language: en-US
To: Quentin Deslandes <qde@naccy.de>
Cc: David Ahern <dsahern@gmail.com>, Martin KaFai Lau
 <martin.lau@kernel.org>, kernel-team@meta.com, netdev@vger.kernel.org
References: <20240112140429.183344-1-qde@naccy.de>
 <20240112140429.183344-3-qde@naccy.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240112140429.183344-3-qde@naccy.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/12/24 6:04 AM, Quentin Deslandes wrote:
> @@ -3445,8 +3478,16 @@ static int bpf_map_opts_load_info(unsigned int map_id)
>   		return -1;
>   	}
>   
> +	r = bpf_maps_opts_load_btf(&info, &btf);
> +	if (r) {
> +		close(fd);
> +		return -1;
> +	}
> +
>   	bpf_map_opts.maps[bpf_map_opts.nr_maps].id = map_id;
> -	bpf_map_opts.maps[bpf_map_opts.nr_maps++].fd = fd;
> +	bpf_map_opts.maps[bpf_map_opts.nr_maps].fd = fd;
> +	bpf_map_opts.maps[bpf_map_opts.nr_maps].info = info;
> +	bpf_map_opts.maps[bpf_map_opts.nr_maps++].btf = btf;
>   
>   	return 0;
>   }
> @@ -3469,6 +3510,29 @@ static struct bpf_sk_storage_map_info *bpf_map_opts_get_info(
>   	return &bpf_map_opts.maps[bpf_map_opts.nr_maps - 1];
>   }
>   
> +static void out_bpf_sk_storage_print_fn(void *ctx, const char *fmt, va_list args)
> +{
> +	vout(fmt, args);
> +}
> +
> +static struct btf_dump *bpf_map_opts_get_btf_dump(
> +	struct bpf_sk_storage_map_info *map_info)
> +{
> +	struct btf_dump_opts dopts = {
> +		.sz = sizeof(struct btf_dump_opts)
> +	};
> +
> +	if (!map_info->dump) {
> +		map_info->dump = btf_dump__new(map_info->btf,
> +					       out_bpf_sk_storage_print_fn,
> +					       NULL, &dopts);

A nit/simplification for the consideration. May be initialize the map_info->dump 
in the bpf_map_opts_load_info() also together with other map_info->* 
initialization? It is likely map_info->dump will be needed anyway.

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>


> +		if (!map_info->dump)
> +			fprintf(stderr, "Failed to create btf_dump object\n");
> +	}
> +
> +	return map_info->dump;
> +}
> +

[ ... ]

> +static void out_bpf_sk_storage(int map_id, const void *data, size_t len)
> +{
> +	uint32_t type_id;
> +	struct bpf_sk_storage_map_info *map_info;
> +	struct btf_dump *dump;
> +	struct btf_dump_type_data_opts opts = {
> +		.sz = sizeof(struct btf_dump_type_data_opts),
> +		.indent_str = SK_STORAGE_INDENT_STR,
> +		.indent_level = 2,
> +		.emit_zeroes = 1
> +	};
> +	int r;
> +
> +	map_info = bpf_map_opts_get_info(map_id);
> +	if (!map_info) {
> +		/* The kernel might return a map we can't get info for, skip
> +		 * it but print the other ones. */
> +		out(SK_STORAGE_INDENT_STR "map_id: %d failed to fetch info, skipping\n",
> +		    map_id);
> +		return;
> +	}
> +
> +	if (map_info->info.value_size != len) {
> +		fprintf(stderr, "map_id: %d: invalid value size, expecting %u, got %lu\n",
> +			map_id, map_info->info.value_size, len);
> +		return;
> +	}
> +
> +	type_id = map_info->info.btf_value_type_id;
> +
> +	dump = bpf_map_opts_get_btf_dump(map_info);
> +	if (!dump)
> +		return;
> +
> +	out(SK_STORAGE_INDENT_STR "map_id: %d [\n", map_id);
> +	r = btf_dump__dump_type_data(dump, type_id, data, len, &opts);
> +	if (r < 0)
> +		out(SK_STORAGE_INDENT_STR SK_STORAGE_INDENT_STR "failed to dump data: %d", r);
> +	out("\n" SK_STORAGE_INDENT_STR "]");
> +}
> +


