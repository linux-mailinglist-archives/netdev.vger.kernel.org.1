Return-Path: <netdev+bounces-51918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A68237FCAEA
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 00:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2851C20B2A
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 23:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892E55B5BE;
	Tue, 28 Nov 2023 23:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ajn513uH"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [IPv6:2001:41d0:203:375::aa])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774DD197
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 15:35:35 -0800 (PST)
Message-ID: <9f1b0310-25c5-4791-a825-e67cd59fea18@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701214533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mV7vct0LbFclU1P3KGydTmgKT/t1omR3pm0cLucjshQ=;
	b=Ajn513uHnsFcPxqIQl4kHvQRtWv16Be2IEsOEItZDO3tgcB/Y1f8JsVpJBHAQwCDatQfyo
	RAQmYLLn3Y7T0vNlcTR7MKSSf2s0L67sjOR2CMGoYfSvZUOWW5HqOGD0Lm6+Q6qMkit3rt
	yjg5AEkPyHOcfbV9eVfv5WZT9KWFoQU=
Date: Tue, 28 Nov 2023 15:35:27 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] ss: add support for BPF socket-local storage
Content-Language: en-US
To: Quentin Deslandes <qde@naccy.de>
Cc: David Ahern <dsahern@gmail.com>, Martin KaFai Lau
 <martin.lau@kernel.org>, netdev@vger.kernel.org
References: <20231128023058.53546-1-qde@naccy.de>
 <20231128023058.53546-3-qde@naccy.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231128023058.53546-3-qde@naccy.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/27/23 6:30 PM, Quentin Deslandes wrote:
> diff --git a/misc/ss.c b/misc/ss.c
> index 09dc1f37..5b255ce3 100644
> --- a/misc/ss.c
> +++ b/misc/ss.c
> @@ -51,6 +51,11 @@
>   #include <linux/tls.h>
>   #include <linux/mptcp.h>
>   
> +#ifdef HAVE_LIBBPF
> +#include <bpf/bpf.h>
> +#include <bpf/libbpf.h>
> +#endif
> +
>   #if HAVE_RPC
>   #include <rpc/rpc.h>
>   #include <rpc/xdr.h>
> @@ -101,6 +106,7 @@ enum col_id {
>   	COL_RADDR,
>   	COL_RSERV,
>   	COL_PROC,
> +	COL_SKSTOR,
>   	COL_EXT,
>   	COL_MAX
>   };
> @@ -130,6 +136,7 @@ static struct column columns[] = {
>   	{ ALIGN_RIGHT,	"Peer Address:",	" ",	0, 0, 0 },
>   	{ ALIGN_LEFT,	"Port",			"",	0, 0, 0 },
>   	{ ALIGN_LEFT,	"Process",		"",	0, 0, 0 },
> +	{ ALIGN_LEFT,	"Socket storage",	"",	1, 0, 0 },
>   	{ ALIGN_LEFT,	"",			"",	0, 0, 0 },
>   };
>   
> @@ -3368,6 +3375,222 @@ static void parse_diag_msg(struct nlmsghdr *nlh, struct sockstat *s)
>   	memcpy(s->remote.data, r->id.idiag_dst, s->local.bytelen);
>   }
>   
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

The map might be gone. Check for errno == -ENOENT and "continue;" instead of 
"goto err;".

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

Not sure how the ss takes care of the fd/memory resources before process exit.

May be the fd(s) need a close() at some point?

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
> +
> +static int bpf_map_opts_add_id(const char *optarg)
> +{
> +	struct bpf_map_info info = {};
> +	uint32_t len = sizeof(info);
> +	size_t optarg_len;
> +	unsigned long id;
> +	unsigned int i;
> +	char *end;
> +	int fd;
> +	int r;
> +
> +	if (bpf_map_opts.show_all) {
> +		bpf_map_opts_mixed_error();
> +		return -1;
> +	}
> +
> +	optarg_len = strlen(optarg);
> +	id = strtoul(optarg, &end, 0);
> +	if (end != optarg + optarg_len || id == 0 || id > UINT32_MAX) {

id >= INT32_MAX

> +		fprintf(stderr, "ss: invalid BPF map ID %s\n", optarg);
> +		return -1;
> +	}
> +
> +	for (i = 0; i < bpf_map_opts.nr_maps; i++) {
> +		if (bpf_map_opts.maps[i].id == id)
> +			return 0;
> +	}
> +
> +	if (bpf_map_opts.nr_maps == MAX_NR_BPF_MAP_ID_OPTS) {
> +		fprintf(stderr, "ss: too many (> %u) BPF socket-local storage maps found, skipping map ID %lu\n",
> +			MAX_NR_BPF_MAP_ID_OPTS, id);
> +		return 0;
> +	}
> +
> +	fd = bpf_map_get_fd_by_id(id);
> +	if (fd == -1) {
> +		fprintf(stderr, "ss: cannot get fd for BPF map ID %lu%s\n",
> +			id, errno == EPERM ?
> +			": missing root permissions, CAP_BPF, or CAP_SYS_ADMIN" : "");
> +		return -1;
> +	}
> +
> +	r = bpf_obj_get_info_by_fd(fd, &info, &len);
> +	if (r) {
> +		fprintf(stderr, "ss: failed to get info for BPF map ID %lu\n", id);
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
> +	bpf_map_opts.maps[bpf_map_opts.nr_maps].id = id;
> +	bpf_map_opts.maps[bpf_map_opts.nr_maps++].fd = fd;
> +
> +	return 0;
> +}
> +
> +static inline bool bpf_map_opts_is_enabled(void)
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
> +	stgs_rta = malloc(RTA_LENGTH(0));

stgs_rta is malloc()-ed here.

> +	stgs_rta->rta_len = RTA_LENGTH(0);
> +	stgs_rta->rta_type = INET_DIAG_REQ_SK_BPF_STORAGES | NLA_F_NESTED;
> +
> +	buf = malloc(total_size);
> +	if (!buf)
> +		return NULL;
> +
> +	stgs_rta = buf;

and then overwriteen by buf. doesn't look right.

> +	stgs_rta->rta_type = INET_DIAG_REQ_SK_BPF_STORAGES | NLA_F_NESTED;
> +	stgs_rta->rta_len = total_size;
> +
> +	buf = RTA_DATA(stgs_rta);
> +	for (i = 0; i < bpf_map_opts.nr_maps; i++) {
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



