Return-Path: <netdev+bounces-61315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BD0823581
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 20:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95841F24603
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 19:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC661CA8B;
	Wed,  3 Jan 2024 19:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IzLK8QiQ"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A931CA82
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 19:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <10ad9d34-8afa-444d-b5cc-ad81b5dd4469@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704309725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dva9AL5URtzE8JQp3STuomWZida6upbrmjTezv8uo+I=;
	b=IzLK8QiQDo9nbRulDYDu7icNM7qfMx2TErpAPF/SRrMbw+KL8ByhSH8t8prXlrvlCCqw8Y
	7S6OPZQvoPshQAgQLqwwTXjJKX21ViKtUuRVPK7JNuNMHooyXd1aoJ4tv9rTs/lmWETb/H
	1Pku0TtJQpBSfxiewMd4vq2M231IwBQ=
Date: Wed, 3 Jan 2024 11:21:58 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/2] ss: add support for BPF socket-local storage
To: Quentin Deslandes <qde@naccy.de>
Cc: David Ahern <dsahern@gmail.com>, Martin KaFai Lau
 <martin.lau@kernel.org>, kernel-team@meta.com, netdev@vger.kernel.org
References: <20231220132326.11246-1-qde@naccy.de>
 <20231220132326.11246-2-qde@naccy.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231220132326.11246-2-qde@naccy.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/20/23 5:23 AM, Quentin Deslandes wrote:
> +#ifdef HAVE_LIBBPF
> +
> +#define MAX_NR_BPF_MAP_ID_OPTS 32
> +
> +struct btf;
> +
> +static struct bpf_map_opts {
> +	unsigned int nr_maps;
> +	struct bpf_sk_storage_map_info {
> +		unsigned int id;
> +		int fd;
> +	} maps[MAX_NR_BPF_MAP_ID_OPTS];
> +	bool show_all;
> +	struct btf *kernel_btf;

Remove 'struct btf *kernel_btf;' which is not used.

> +} bpf_map_opts;
> +
> +static void bpf_map_opts_mixed_error(void)
> +{
> +	fprintf(stderr,
> +		"ss: --bpf-maps and --bpf-map-id cannot be used together\n");
> +}
> +
> +static int bpf_map_opts_add_all(void)
> +{
> +	unsigned int i;
> +	unsigned int fd;
> +	uint32_t id = 0;
> +	int r;
> +
> +	if (bpf_map_opts.nr_maps) {
> +		bpf_map_opts_mixed_error();
> +		return -1;
> +	}
> +
> +	while (1) {
> +		struct bpf_map_info info = {};
> +		uint32_t len = sizeof(info);
> +
> +		r = bpf_map_get_next_id(id, &id);
> +		if (r) {
> +			if (errno == ENOENT)
> +				break;
> +
> +			fprintf(stderr, "ss: failed to fetch BPF map ID\n");
> +			goto err;
> +		}
> +
> +		fd = bpf_map_get_fd_by_id(id);
> +		if (fd == -1) {
> +			if (errno == -ENOENT) {
> +				fprintf(stderr, "ss: missing BPF map ID %u, skipping",
> +					id);

nit. Remove this stderr fprint. The map just got freed after 
bpf_map_get_next_id, so better avoid the unnecessary noise.

> +				continue;
> +			}
> +
> +			fprintf(stderr, "ss: cannot get fd for BPF map ID %u%s\n",
> +				id, errno == EPERM ?
> +				": missing root permissions, CAP_BPF, or CAP_SYS_ADMIN" : "");
> +			goto err;
> +		}
> +
> +		r = bpf_obj_get_info_by_fd(fd, &info, &len);
> +		if (r) {
> +			fprintf(stderr, "ss: failed to get info for BPF map ID %u\n",
> +				id);
> +			close(fd);
> +			goto err;
> +		}
> +
> +		if (info.type != BPF_MAP_TYPE_SK_STORAGE) {
> +			close(fd);
> +			continue;
> +		}
> +
> +		if (bpf_map_opts.nr_maps == MAX_NR_BPF_MAP_ID_OPTS) {
> +			fprintf(stderr, "ss: too many (> %u) BPF socket-local storage maps found, skipping map ID %u\n",
> +				MAX_NR_BPF_MAP_ID_OPTS, id);
> +			close(fd);
> +			continue;
> +		}
> +
> +		bpf_map_opts.maps[bpf_map_opts.nr_maps].id = id;
> +		bpf_map_opts.maps[bpf_map_opts.nr_maps++].fd = fd;
> +	}
> +
> +	bpf_map_opts.show_all = true;
> +
> +	return 0;
> +
> +err:
> +	for (i = 0; i < bpf_map_opts.nr_maps; ++i)
> +		close(bpf_map_opts.maps[i].fd);
> +
> +	return -1;
> +}

[ ... ]

> +
> +static void bpf_map_opts_destroy(void)
> +{
> +	int i;
> +	
> +	for (i = 0; i < bpf_map_opts.nr_maps; ++i)
> +		close(bpf_map_opts.maps[i].fd);
> +}
> +
> +static bool bpf_map_opts_is_enabled(void)
> +{
> +	return bpf_map_opts.nr_maps;
> +}
> +
> +static struct rtattr *bpf_map_opts_alloc_rta(void)
> +{
> +	size_t total_size = RTA_LENGTH(RTA_LENGTH(sizeof(int)) * bpf_map_opts.nr_maps);
> +	struct rtattr *stgs_rta, *fd_rta;
> +	unsigned int i;
> +	void *buf;
> +
> +	buf = malloc(total_size);
> +	if (!buf)
> +		return NULL;
> +
> +	stgs_rta = buf;
> +	stgs_rta->rta_type = INET_DIAG_REQ_SK_BPF_STORAGES | NLA_F_NESTED;
> +	stgs_rta->rta_len = total_size;
> +
> +	buf = RTA_DATA(stgs_rta);
> +	for (i = 0; i < bpf_map_opts.nr_maps; i++) {

One thing that I just recalled from the kernel side.

For the bpf_map_opts.show_all == true case, there is no need to put any map_id 
in the nlmsg. Meaning the whole for loop can be avoided here. The kernel will 
also be a little more efficient in dumping all bpf_sk_storage_map for (each) sk. 
Take a look at bpf_sk_storage_diag_put_all() in the kernel 
net/core/bpf_sk_storage.c.

total_size will need to be adjusted here. Something like (uncompiled code):

	if (bpf_map_opts.show_all)
		total_size = RTA_LENGTH(0);
	else
		total_size = RTA_LENGTH(RTA_LENGTH(sizeof(int)) * bpf_map_opts.nr_maps);

> +		int *fd;
> +
> +		fd_rta = buf;
> +		fd_rta->rta_type = SK_DIAG_BPF_STORAGE_REQ_MAP_FD;
> +		fd_rta->rta_len = RTA_LENGTH(sizeof(int));
> +
> +		fd = RTA_DATA(fd_rta);
> +		*fd = bpf_map_opts.maps[i].fd;
> +
> +		buf += fd_rta->rta_len;
> +	}
> +
> +	return stgs_rta;
> +}
> +

[ ... ]


