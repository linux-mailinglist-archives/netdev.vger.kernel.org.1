Return-Path: <netdev+bounces-51920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3D17FCAF0
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 00:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A00E41C20AD8
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 23:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41BA57333;
	Tue, 28 Nov 2023 23:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LKo/aF2a"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8051B4
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 15:42:19 -0800 (PST)
Message-ID: <d1cb4093-f20a-45c7-bfe3-5be6fd93c844@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701214937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/yaHcPbfeFenCF7sC9OA/U4qnbo3vk8i3ly7RzBTiB4=;
	b=LKo/aF2aasXoesaAOoEM+w1D5Iyyy2K3DOKgYO8QFchJCPvZtXjcJbP1/TEa6frcAFyyq9
	P1x60C76Y4MsT3E4OVDIMw19JEW8vr5ZenayxPqPQFFpnWtDdE1Mv+yanl4YObiVnnXmA7
	toUjcuZkowaXVCpbwRwf7R4LsK3piME=
Date: Tue, 28 Nov 2023 15:42:15 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/3] ss: pretty-print BPF socket-local storage
Content-Language: en-US
To: Quentin Deslandes <qde@naccy.de>
Cc: David Ahern <dsahern@gmail.com>, Martin KaFai Lau
 <martin.lau@kernel.org>, netdev@vger.kernel.org
References: <20231128023058.53546-1-qde@naccy.de>
 <20231128023058.53546-4-qde@naccy.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231128023058.53546-4-qde@naccy.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/27/23 6:30 PM, Quentin Deslandes wrote:
> +static int bpf_maps_opts_load_btf(struct bpf_map_info *info, struct btf **btf)
> +{
> +	if (info->btf_vmlinux_value_type_id) {
> +		if (!bpf_map_opts.kernel_btf) {
> +			bpf_map_opts.kernel_btf = libbpf_find_kernel_btf();
> +			if (!bpf_map_opts.kernel_btf) {
> +				fprintf(stderr, "ss: failed to load kernel BTF\n");
> +				return -1;
> +			}
> +		}
> +
> +		*btf = bpf_map_opts.kernel_btf;
> +	} else if (info->btf_value_type_id) {
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

[ ... ]

> +static void out_bpf_sk_storage(int map_id, const void *data, size_t len,
> +	out_prefix_t *prefix)
> +{
> +	uint32_t type_id;
> +	struct bpf_sk_storage_map_info *map_info;
> +
> +	map_info = bpf_map_opts_get_info(map_id);
> +	if (!map_info) {
> +		OUT_P(prefix, "map_id: %d: missing map info", map_id);
> +		return;
> +	}
> +
> +	if (map_info->info.value_size != len) {
> +		OUT_P(prefix, "map_id: %d: invalid value size, expecting %u, got %lu\n",
> +			map_id, map_info->info.value_size, len);
> +		return;
> +	}
> +
> +	type_id = map_info->info.btf_vmlinux_value_type_id ?: map_info->info.btf_value_type_id;

sk_storage does not use info.btf_vmlinux_value_type_id, so no need to handle 
this case. Only info.btf_value_type_id is used.

> +
> +	OUT_P(prefix, "map_id: %d [\n", map_id);
> +	out_prefix_push(prefix);
> +
> +	out_btf_dump_type(map_info->btf, 0, type_id, data, len, prefix);
> +
> +	out_prefix_pop(prefix);
> +	OUT_P(prefix, "]");
> +}
> +



