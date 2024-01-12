Return-Path: <netdev+bounces-63368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 872AA82C76F
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 23:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F90B28398E
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 22:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36F518B0C;
	Fri, 12 Jan 2024 22:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UMx6ymTY"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D3418B06
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 22:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <75243f6c-f316-47f5-89ae-f203174cd0ad@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705099848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7p5iISSMNnP3Z0sj/fzOFp1Qmq9AkIjImjGlrJuMPBk=;
	b=UMx6ymTYFOZTTpXdFxF+j3GX+AEqc5o/IvRfJNdGHS29BokMAYqZ1NfLdS6BoC7zCtt3qb
	ZOYyUCuZNBvgK4MaPSLTwP44CINRtyj6Zmi5FX6z3b8VOjM+U2ESR0r4OV/E2e8y3vUhc5
	zIUZMCQ86IljNUIDLBOTSBPPr3mflQI=
Date: Fri, 12 Jan 2024 14:50:41 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/3] ss: add support for BPF socket-local storage
Content-Language: en-US
To: Quentin Deslandes <qde@naccy.de>
Cc: David Ahern <dsahern@gmail.com>, Martin KaFai Lau
 <martin.lau@kernel.org>, kernel-team@meta.com, netdev@vger.kernel.org
References: <20240112140429.183344-1-qde@naccy.de>
 <20240112140429.183344-2-qde@naccy.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240112140429.183344-2-qde@naccy.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/12/24 6:04 AM, Quentin Deslandes wrote:
> +static int bpf_map_opts_load_info(unsigned int map_id)
> +{
> +	struct bpf_map_info info = {};
> +	uint32_t len = sizeof(info);
> +	int fd;
> +	int r;
> +
> +	if (bpf_map_opts.nr_maps == MAX_NR_BPF_MAP_ID_OPTS) {
> +		fprintf(stderr, "ss: too many (> %u) BPF socket-local storage maps found, skipping map ID %u\n",
> +			MAX_NR_BPF_MAP_ID_OPTS, map_id);
> +		return 0;
> +	}
> +
> +	fd = bpf_map_get_fd_by_id(map_id);
> +	if (fd == -1) {

I also just noticed libbpf returns -errno (from libbpf_err_errno()), so better 
check for < 0 here.

> +		if (errno == -ENOENT)
> +			return 0;
> +
> +		fprintf(stderr, "ss: cannot get fd for BPF map ID %u%s\n",
> +			map_id, errno == EPERM ?
> +			": missing root permissions, CAP_BPF, or CAP_SYS_ADMIN" : "");
> +		return -1;
> +	}
> +
> +	r = bpf_obj_get_info_by_fd(fd, &info, &len);
> +	if (r) {
> +		fprintf(stderr, "ss: failed to get info for BPF map ID %u\n",
> +			map_id);
> +		close(fd);
> +		return -1;
> +	}
> +
> +	if (info.type != BPF_MAP_TYPE_SK_STORAGE) {
> +		fprintf(stderr, "ss: BPF map with ID %s has type '%s', expecting 'sk_storage'\n",
> +			optarg, libbpf_bpf_map_type_str(info.type));
> +		close(fd);
> +		return -1;
> +	}
> +
> +	bpf_map_opts.maps[bpf_map_opts.nr_maps].id = map_id;
> +	bpf_map_opts.maps[bpf_map_opts.nr_maps++].fd = fd;
> +
> +	return 0;
> +}
> +
> +static struct bpf_sk_storage_map_info *bpf_map_opts_get_info(
> +	unsigned int map_id)
> +{
> +	unsigned int i;
> +	int r;
> +
> +	for (i = 0; i < bpf_map_opts.nr_maps; ++i) {
> +		if (bpf_map_opts.maps[i].id == map_id)
> +			return &bpf_map_opts.maps[i];
> +	}
> +
> +	r = bpf_map_opts_load_info(map_id);
> +	if (r)
> +		return NULL;
> +
> +	return &bpf_map_opts.maps[bpf_map_opts.nr_maps - 1];
> +}
> +
> +static int bpf_map_opts_add_id(const char *optarg)
> +{
> +	size_t optarg_len;
> +	unsigned long id;
> +	char *end;
> +
> +	if (bpf_map_opts.show_all) {
> +		bpf_map_opts_mixed_error();
> +		return -1;
> +	}
> +
> +	optarg_len = strlen(optarg);
> +	id = strtoul(optarg, &end, 0);
> +	if (end != optarg + optarg_len || id == 0 || id >= UINT32_MAX) {
> +		fprintf(stderr, "ss: invalid BPF map ID %s\n", optarg);
> +		return -1;
> +	}
> +
> +	// Force lazy loading of the map's data.
> +	if (!bpf_map_opts_get_info(id))
> +		return -ENOENT;

nit. may be also "return -1;" here to be consistent with the above error returns.

Other than the minor nits, lgtm, you can carry my ack in the next spin:

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>



