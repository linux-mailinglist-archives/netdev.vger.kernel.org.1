Return-Path: <netdev+bounces-63383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 929D282C911
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 03:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96AF61C215FA
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 02:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AB018C29;
	Sat, 13 Jan 2024 02:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aBkgoBv+"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC5E17C8B
	for <netdev@vger.kernel.org>; Sat, 13 Jan 2024 02:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f730b229-4851-4021-9800-f0aa265a729f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705111943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lq0EWgx6wOvrQ3H7sXURbnp11m4aM5S+ux6iFW/KRIM=;
	b=aBkgoBv+Dx6RZwl70Ku1da0QXSlT+SfAb7L370BYBNH2Grwuo1KCt+7xiOrHE330U4qU9+
	/BRYwB03FBNntxlvNE9KN6+zb0djmERObnBOXHDsOb7ijqPRmDy3SngubGXL6M+odzPov0
	a0W1RQ+xl7aiPAzoYIqF1QcrRjrNRN0=
Date: Fri, 12 Jan 2024 18:12:17 -0800
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
> +static struct rtattr *bpf_map_opts_alloc_rta(void)
> +{
> +	struct rtattr *stgs_rta, *fd_rta;
> +	size_t total_size;
> +	unsigned int i;
> +	void *buf;
> +
> +	/* If bpf_map_opts.show_all == true, then bpf_map_opts.nr_maps == 0. We
> +	 * will send an empty message to the kernel, which will return all the
> +	 * socket-local data attached to a socket, no matter their map ID. */
> +	total_size = RTA_LENGTH(RTA_LENGTH(sizeof(int)) * bpf_map_opts.nr_maps);

I have been trying the patch in some heavier traffic machines because I am over 
excited :)

The "--bpf-maps" result is pretty flaky. It does not always print all the 
sk_storage_map.

This line has a bug when using with the "--bpf-maps" cmd opts. The nr_maps will 
become non-zero and will end up not printing all sk_storage_map. Take a look at 
the inet_show_netlink() and there is a "goto again" case.

It really has to test with the bpf_map_opts.show_all here.


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

> @@ -3564,13 +3767,14 @@ static int sockdiag_send(int family, int fd, int protocol, struct filter *f)
>   {
>   	struct sockaddr_nl nladdr = { .nl_family = AF_NETLINK };
>   	DIAG_REQUEST(req, struct inet_diag_req_v2 r);
> +	struct rtattr *bpf_stgs_rta = NULL;
>   	char    *bc = NULL;
>   	int	bclen;
>   	__u32	proto;
>   	struct msghdr msg;
>   	struct rtattr rta_bc;
>   	struct rtattr rta_proto;
> -	struct iovec iov[5];
> +	struct iovec iov[6];
>   	int iovlen = 1;
> 
>   	if (family == PF_UNSPEC)
> @@ -3623,6 +3827,19 @@ static int sockdiag_send(int family, int fd, int protocol, struct filter *f)
>   		iovlen += 2;
>   	}
> 
> +#ifdef HAVE_LIBBPF
> +	if (bpf_map_opts_is_enabled()) {
> +		bpf_stgs_rta = bpf_map_opts_alloc_rta();
> +		if (!bpf_stgs_rta) {
> +			fprintf(stderr, "ss: cannot alloc request for --bpf-map\n");
> +			return -1;
> +		}
> +
> +		iov[iovlen++] = (struct iovec){ bpf_stgs_rta, bpf_stgs_rta->rta_len };
> +		req.nlh.nlmsg_len += bpf_stgs_rta->rta_len;
> +	}
> +#endif
> +
>   	msg = (struct msghdr) {
>   		.msg_name = (void *)&nladdr,
>   		.msg_namelen = sizeof(nladdr),
> @@ -3631,10 +3848,13 @@ static int sockdiag_send(int family, int fd, int protocol, struct filter *f)
>   	};
> 
>   	if (sendmsg(fd, &msg, 0) < 0) {
> +		free(bpf_stgs_rta);
>   		close(fd);
>   		return -1;
>   	}
> 
> +	free(bpf_stgs_rta);
> +
>   	return 0;
>   }


