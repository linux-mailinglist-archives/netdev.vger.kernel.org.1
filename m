Return-Path: <netdev+bounces-56633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F4A80FA8A
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 23:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28E1281BEF
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 22:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133C21A739;
	Tue, 12 Dec 2023 22:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HsO1x5sF"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95324AA
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 14:49:35 -0800 (PST)
Message-ID: <6436a347-c4b1-4260-8f4f-96ed133626a8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702421373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0nsWTOhCGXNAvvoNntKuIieUmUGFpzsKdJEkYYNqg5E=;
	b=HsO1x5sF+1snzbLUHDunpv606DwjR5FyzqZlagz1c0o28u9EPDe1X/64GnTccEEyn0bU/f
	/YVFJWEMz5DSJOU0Md0nwHKo5lh3mjokp8swFpnULsUj4TTIOefIsCNb6bQQ0BJiaEwEST
	CEBgRuQa5KFLjmi/grUw6f9mEQpDMUM=
Date: Tue, 12 Dec 2023 14:49:28 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] ss: add support for BPF socket-local storage
Content-Language: en-US
To: Quentin Deslandes <qde@naccy.de>
Cc: David Ahern <dsahern@gmail.com>, Martin KaFai Lau
 <martin.lau@kernel.org>, kernel-team@meta.com, netdev@vger.kernel.org
References: <20231208145720.411075-1-qde@naccy.de>
 <20231208145720.411075-2-qde@naccy.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231208145720.411075-2-qde@naccy.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/8/23 6:57 AM, Quentin Deslandes wrote:
> +static inline bool bpf_map_opts_is_enabled(void)

nit.

This is the only "inline" usage in this file. I would avoid it and depend on the 
compiler to decide.

> +{
> +	return bpf_map_opts.nr_maps;
> +}
> +

[ ... ]

>   static int inet_show_sock(struct nlmsghdr *nlh,
>   			  struct sockstat *s)
>   {
> @@ -3381,8 +3620,8 @@ static int inet_show_sock(struct nlmsghdr *nlh,
>   	struct inet_diag_msg *r = NLMSG_DATA(nlh);
>   	unsigned char v6only = 0;
>   
> -	parse_rtattr(tb, INET_DIAG_MAX, (struct rtattr *)(r+1),
> -		     nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*r)));
> +	parse_rtattr_flags(tb, INET_DIAG_MAX, (struct rtattr *)(r+1),
> +		nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*r)), NLA_F_NESTED);
>   
>   	if (tb[INET_DIAG_PROTOCOL])
>   		s->type = rta_getattr_u8(tb[INET_DIAG_PROTOCOL]);
> @@ -3479,6 +3718,11 @@ static int inet_show_sock(struct nlmsghdr *nlh,
>   	}
>   	sctp_ino = s->ino;
>   
> +	if (tb[INET_DIAG_SK_BPF_STORAGES]) {
> +		field_set(COL_SKSTOR);
> +		show_sk_bpf_storages(tb[INET_DIAG_SK_BPF_STORAGES]);
> +	}
> +
>   	return 0;
>   }
>   
> @@ -3560,13 +3804,14 @@ static int sockdiag_send(int family, int fd, int protocol, struct filter *f)
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
> @@ -3619,6 +3864,17 @@ static int sockdiag_send(int family, int fd, int protocol, struct filter *f)
>   		iovlen += 2;
>   	}
>   
> +	if (bpf_map_opts_is_enabled()) {

This will have compiler error when HAVE_LIBBPF is not set.

> +		bpf_stgs_rta = bpf_map_opts_alloc_rta();
> +		if (!bpf_stgs_rta) {
> +			fprintf(stderr, "ss: cannot alloc request for --bpf-map\n");
> +			return -1;
> +		}
> +
> +		iov[iovlen++] = (struct iovec){ bpf_stgs_rta, bpf_stgs_rta->rta_len };
> +		req.nlh.nlmsg_len += bpf_stgs_rta->rta_len;
> +	}
> +
>   	msg = (struct msghdr) {
>   		.msg_name = (void *)&nladdr,
>   		.msg_namelen = sizeof(nladdr),

[ ... ]

> @@ -5712,6 +5982,16 @@ int main(int argc, char *argv[])
>   		case OPT_INET_SOCKOPT:
>   			show_inet_sockopt = 1;
>   			break;
> +#ifdef HAVE_LIBBPF
> +		case OPT_BPF_MAPS:
> +			if (bpf_map_opts_add_all())
> +				exit(1);
> +			break;
> +		case OPT_BPF_MAP_ID:
> +			if (bpf_map_opts_add_id(optarg))
> +				exit(1);
> +			break;
> +#endif
>   		case 'h':
>   			help();
>   		case '?':
> @@ -5810,6 +6090,9 @@ int main(int argc, char *argv[])
>   	if (!(current_filter.states & (current_filter.states - 1)))
>   		columns[COL_STATE].disabled = 1;
>   
> +	if (bpf_map_opts.nr_maps)

same here when HAVE_LIBBPF is not set

> +		columns[COL_SKSTOR].disabled = 0;
> +
>   	if (show_header)
>   		print_header();
>   
> @@ -5845,6 +6128,7 @@ int main(int argc, char *argv[])
>   
>   	if (show_processes || show_threads || show_proc_ctx || show_sock_ctx)
>   		user_ent_destroy();
> +	bpf_map_opts_destroy();

same here.

A #ifdef is needed.
Another option is to create an empty or always-return-false function.

>   
>   	render();
>   


