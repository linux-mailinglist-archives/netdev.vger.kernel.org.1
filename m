Return-Path: <netdev+bounces-61324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E8A8235EA
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 20:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AD781F25986
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 19:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737611CFBF;
	Wed,  3 Jan 2024 19:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oklhQV8X"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5181D529
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 19:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9a431b3e-a494-4fae-8965-215da0856db3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704311523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lyk7U3zTIgq98m5+oEGdsIlAJt9Nay1BbYBcDKn7rcQ=;
	b=oklhQV8XNHZvs250V26H40jxa+q0wSO1Q1kiUjQjXChsV/fETnF0DatSC9ett1l6Z1BJNI
	b2y8AH4rPpkiw7nn0cQVZ+sgwEVY4B+ftjrqqKW5T/p9axW6hI/o+ie8Cm6BCB4CYWWb++
	2z82swkDh97cwvQUvVQ9y25hwO62l5o=
Date: Wed, 3 Jan 2024 11:51:58 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/2] ss: pretty-print BPF socket-local storage
Content-Language: en-US
To: Quentin Deslandes <qde@naccy.de>
Cc: David Ahern <dsahern@gmail.com>, Martin KaFai Lau
 <martin.lau@kernel.org>, kernel-team@meta.com,
 Alan Maguire <alan.maguire@oracle.com>, netdev@vger.kernel.org
References: <20231220132326.11246-1-qde@naccy.de>
 <20231220132326.11246-3-qde@naccy.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231220132326.11246-3-qde@naccy.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/20/23 5:23 AM, Quentin Deslandes wrote:
> diff --git a/misc/ss.c b/misc/ss.c
> index 689972d7..6e1ddfa5 100644
> --- a/misc/ss.c
> +++ b/misc/ss.c
> @@ -51,8 +51,13 @@
>   #include <linux/tls.h>
>   #include <linux/mptcp.h>
>   
> +#ifdef HAVE_LIBBPF
> +#include <linux/btf.h>

nit. Instead of adding another "#ifdef HAVE_LIBBPF", move this line to the same 
"#ifdef HAVE_LIBBPF" below?

> +#endif
> +
>   #ifdef HAVE_LIBBPF
>   #include <bpf/bpf.h>
> +#include <bpf/btf.h>
>   #include <bpf/libbpf.h>
>   #endif
>   

[ ... ]

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

This will be a duplicated fprintf(stderr) with the bpf_maps_opts_load_btf() 
above. Remove either one of them.

The same goes for the bpf_map_opts_add_id().

[ ... ]

> +static void out_bpf_sk_storage(int map_id, const void *data, size_t len)
> +{
> +	uint32_t type_id;
> +	const struct bpf_sk_storage_map_info *map_info;
> +	struct btf_dump *dump;
> +	struct btf_dump_type_data_opts opts = {
> +		.sz = sizeof(struct btf_dump_type_data_opts),
> +		.indent_str = SK_STORAGE_INDENT_STR,
> +		.indent_level = 2,
> +		.emit_zeroes = 1
> +	};
> +	struct btf_dump_opts dopts = {
> +		.sz = sizeof(struct btf_dump_opts)
> +	};
> +	int r;
> +
> +	map_info = bpf_map_opts_get_info(map_id);
> +	if (!map_info) {
> +		fprintf(stderr, "map_id: %d: missing map info", map_id);

With the 'total_size = RTA_LENGTH(0)' change during show_all == true case in 
patch 1, this fprintf(stderr) should be removed. A new bpf_sk_storage_map has 
just been created after the ss has started which is fine to skip. The next ss 
run will be able to show it.

In the future, it could be improved to give it another try here to get the btf 
info of this new map on-demand.

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
> +	dump = btf_dump__new(map_info->btf, out_bpf_sk_storage_print_fn, NULL, &dopts);

nit. just noticed this one also. Instead of recreating the "dump" obj for each 
printed sk, can it be created once and stored in "struct bpf_sk_storage_map_info 
{ ... } maps[MAX_NR_BPF_MAP_ID_OPTS];"?

> +	if (!dump) {
> +		fprintf(stderr, "Failed to create btf_dump object\n");
> +		return;
> +	}
> +
> +	out(SK_STORAGE_INDENT_STR "map_id: %d [\n", map_id);
> +	r = btf_dump__dump_type_data(dump, type_id, data, len, &opts);
> +	if (r < 0)
> +		out(SK_STORAGE_INDENT_STR SK_STORAGE_INDENT_STR "failed to dump data: %d", r);
> +	out("\n" SK_STORAGE_INDENT_STR "]");
> +
> +	btf_dump__free(dump);
> +}
> +
>   static void show_sk_bpf_storages(struct rtattr *bpf_stgs)
>   {
>   	struct rtattr *tb[SK_DIAG_BPF_STORAGE_MAX + 1], *bpf_stg;
> -	unsigned int rem;
> +	unsigned int rem, map_id;
> +	struct rtattr *value;
>   
>   	for (bpf_stg = RTA_DATA(bpf_stgs), rem = RTA_PAYLOAD(bpf_stgs);
>   		RTA_OK(bpf_stg, rem); bpf_stg = RTA_NEXT(bpf_stg, rem)) {
> @@ -3605,8 +3731,13 @@ static void show_sk_bpf_storages(struct rtattr *bpf_stgs)
>   			(struct rtattr *)bpf_stg);
>   
>   		if (tb[SK_DIAG_BPF_STORAGE_MAP_ID]) {
> -			out("map_id:%u",
> -				rta_getattr_u32(tb[SK_DIAG_BPF_STORAGE_MAP_ID]));
> +			out("\n");
> +
> +			map_id = rta_getattr_u32(tb[SK_DIAG_BPF_STORAGE_MAP_ID]);
> +			value = tb[SK_DIAG_BPF_STORAGE_MAP_VALUE];
> +
> +			out_bpf_sk_storage(map_id, RTA_DATA(value),
> +				RTA_PAYLOAD(value));
>   		}
>   	}
>   }
> @@ -6004,6 +6135,11 @@ int main(int argc, char *argv[])
>   		}
>   	}
>   
> +	if (oneline && (bpf_map_opts.nr_maps || bpf_map_opts.show_all)) {

This will not compile if HAVE_LIBBPF is not set. Please test with the 
HAVE_LIBBPF is false condition.

May be revisit my earlier suggestion to create a few helper functions here when 
HAVE_LIBBPF is not set instead of adding "#ifdef HAVE_LIBBPF" here. Something like:

#ifdef HAVE_LIBBPF
static bool bpf_map_opts_is_enabled(void)
{
         return bpf_map_opts.nr_maps;
}
#else
static bool bpf_map_opts_is_enabled(void)
{
         return false;
}
#endif


> +		fprintf(stderr, "ss: --oneline, --bpf-maps, and --bpf-map-id are incompatible\n");
> +		exit(-1);
> +	}
> +
>   	if (show_processes || show_threads || show_proc_ctx || show_sock_ctx)
>   		user_ent_hash_build();
>   


