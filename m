Return-Path: <netdev+bounces-56635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0C080FA9D
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 23:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86F1F281C85
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 22:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2BA446A3;
	Tue, 12 Dec 2023 22:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QACrS6pc"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [IPv6:2001:41d0:1004:224b::bb])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2628AA
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 14:58:05 -0800 (PST)
Message-ID: <ccd44586-cb37-4bae-81b5-c20cab4f4e74@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702421884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2DFFp8Sb1pVlnd1Q/pcyH5VUlyHbdo2n0MhI7xlXSbA=;
	b=QACrS6pc7uC0OSNZQQ1IqjBTLtrEGNYQbpb6hR+2NqoyHLoYUwaPlE2TonlSexXNAT7wZH
	mItrREmm3wsKZtKgZnK2AzgI+FPWpt3dppvR+WY209UL1HrzxwBEZlZt6oRpqgeJHG/kHE
	8ptm4R2Xg/f28B3gv/6uOvS9FpdPY5s=
Date: Tue, 12 Dec 2023 14:58:01 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] ss: pretty-print BPF socket-local storage
Content-Language: en-US
To: Quentin Deslandes <qde@naccy.de>
Cc: David Ahern <dsahern@gmail.com>, Martin KaFai Lau
 <martin.lau@kernel.org>, kernel-team@meta.com, netdev@vger.kernel.org
References: <20231208145720.411075-1-qde@naccy.de>
 <20231208145720.411075-3-qde@naccy.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231208145720.411075-3-qde@naccy.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/8/23 6:57 AM, Quentin Deslandes wrote:
> @@ -1039,11 +1044,10 @@ static int buf_update(int len)
>   }
>   
>   /* Append content to buffer as part of the current field */
> -__attribute__((format(printf, 1, 2)))
> -static void out(const char *fmt, ...)
> +static void vout(const char *fmt, va_list args)
>   {
>   	struct column *f = current_field;
> -	va_list args;
> +	va_list _args;
>   	char *pos;
>   	int len;
>   
> @@ -1054,18 +1058,27 @@ static void out(const char *fmt, ...)
>   		buffer.head = buf_chunk_new();
>   
>   again:	/* Append to buffer: if we have a new chunk, print again */
> +	va_copy(_args, args);
>   
>   	pos = buffer.cur->data + buffer.cur->len;
> -	va_start(args, fmt);
>   
>   	/* Limit to tail room. If we hit the limit, buf_update() will tell us */
>   	len = vsnprintf(pos, buf_chunk_avail(buffer.tail), fmt, args);

hmm... based on the changes made in this function, I am pretty sure the 
intention is to pass the "_args" here instead of passing the "args". Please 
double check.

> -	va_end(args);
>   
>   	if (buf_update(len))
>   		goto again;
>   }
>   
> +__attribute__((format(printf, 1, 2)))
> +static void out(const char *fmt, ...)
> +{
> +	va_list args;
> +
> +	va_start(args, fmt);
> +	vout(fmt, args);
> +	va_end(args);
> +}
> +
>   static int print_left_spacing(struct column *f, int stored, int printed)
>   {
>   	int s;
> @@ -1213,6 +1226,9 @@ static void render_calc_width(void)
>   		 */
>   		c->width = min(c->width, screen_width);
>   
> +		if (c == &columns[COL_SKSTOR])
> +			c->width = 1;
> +
>   		if (c->width)
>   			first = 0;
>   	}
> @@ -3392,6 +3408,8 @@ static struct bpf_map_opts {
>   	struct bpf_sk_storage_map_info {
>   		unsigned int id;
>   		int fd;
> +		struct bpf_map_info info;
> +		struct btf *btf;
>   	} maps[MAX_NR_BPF_MAP_ID_OPTS];
>   	bool show_all;
>   	struct btf *kernel_btf;
> @@ -3403,6 +3421,22 @@ static void bpf_map_opts_mixed_error(void)
>   		"ss: --bpf-maps and --bpf-map-id cannot be used together\n");
>   }
>   
> +static int bpf_maps_opts_load_btf(struct bpf_map_info *info, struct btf **btf)
> +{
> +	if (info->btf_value_type_id) {
> +		*btf = btf__load_from_kernel_by_id(info->btf_id);
> +		if (!*btf) {
> +			fprintf(stderr, "ss: failed to load BTF for map ID %u\n",
> +				info->id);
> +			return -1;
> +		}
> +	} else {
> +		*btf = NULL;
> +	}
> +
> +	return 0;
> +}
> +
>   static int bpf_map_opts_add_all(void)
>   {
>   	unsigned int i;
> @@ -3418,6 +3452,7 @@ static int bpf_map_opts_add_all(void)
>   	while (1) {
>   		struct bpf_map_info info = {};
>   		uint32_t len = sizeof(info);
> +		struct btf *btf;
>   
>   		r = bpf_map_get_next_id(id, &id);
>   		if (r) {
> @@ -3462,8 +3497,18 @@ static int bpf_map_opts_add_all(void)
>   			continue;
>   		}
>   
> +		r = bpf_maps_opts_load_btf(&info, &btf);
> +		if (r) {
> +			fprintf(stderr, "ss: failed to get BTF data for BPF map ID: %u\n",
> +				id);
> +			close(fd);
> +			goto err;
> +		}
> +
>   		bpf_map_opts.maps[bpf_map_opts.nr_maps].id = id;
> -		bpf_map_opts.maps[bpf_map_opts.nr_maps++].fd = fd;
> +		bpf_map_opts.maps[bpf_map_opts.nr_maps].fd = fd;
> +		bpf_map_opts.maps[bpf_map_opts.nr_maps].info = info;
> +		bpf_map_opts.maps[bpf_map_opts.nr_maps++].btf = btf;

The "err:" path of this function needs a btf__free().

>   	}
>   
>   	bpf_map_opts.show_all = true;
> @@ -3482,6 +3527,7 @@ static int bpf_map_opts_add_id(const char *optarg)
>   	struct bpf_map_info info = {};
>   	uint32_t len = sizeof(info);
>   	size_t optarg_len;
> +	struct btf *btf;
>   	unsigned long id;
>   	unsigned int i;
>   	char *end;
> @@ -3539,8 +3585,17 @@ static int bpf_map_opts_add_id(const char *optarg)
>   		return -1;
>   	}
>   
> +	r = bpf_maps_opts_load_btf(&info, &btf);
> +	if (r) {
> +		fprintf(stderr, "ss: failed to get BTF data for BPF map ID: %lu\n",
> +			id);

close(fd);

> +		return -1;
> +	}
> +
>   	bpf_map_opts.maps[bpf_map_opts.nr_maps].id = id;
> -	bpf_map_opts.maps[bpf_map_opts.nr_maps++].fd = fd;
> +	bpf_map_opts.maps[bpf_map_opts.nr_maps].fd = fd;
> +	bpf_map_opts.maps[bpf_map_opts.nr_maps].info = info;
> +	bpf_map_opts.maps[bpf_map_opts.nr_maps++].btf = btf;
>   
>   	return 0;
>   }



