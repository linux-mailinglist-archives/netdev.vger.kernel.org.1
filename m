Return-Path: <netdev+bounces-42271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 243D67CDFFE
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 16:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5594A1C20ADA
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 14:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AF83589D;
	Wed, 18 Oct 2023 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWMV5zOo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FFC37C97
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 14:35:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4884C433C8;
	Wed, 18 Oct 2023 14:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697639731;
	bh=hZ6MWb2wS/ozdOhFylNGseFc9D51aEdVMirjh/944Ws=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IWMV5zOoAvfNPy5L+OEaQluOkm8jQeaPSjuPrEWPzGdeHxVbb3bMgt7xwKXS4hLHl
	 16MZXogna4xScK0F5rsm6AsUUVU+xrS6NsJaUaEThvsY749oS22EPSA/vMUnQGwfMH
	 W7EdavK4W4fHa/qCgVs2pURYD6F0inh+2LlFbSbjxkYHeziDLy2jsJUHTjN2FrjNj3
	 GBY9JUR5tvY4voKLtO4Iqi8k3+ypYf365pl6Q21a3O7WdLX3DgQVkkJc4h6d0mjrM2
	 GmHKzBUUfd4Vs75BNfD+cNW7sbW/vGorGPfrUF3MxV2v4qbmY7Z6cnAuvKIp9yl6Y5
	 Wa25V521s52WA==
Message-ID: <5a7efbd1-f05b-4b49-d9a8-ef5c4c6b8ee0@kernel.org>
Date: Wed, 18 Oct 2023 08:35:30 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH iproute2-next 2/2] bpf: increase verifier verbosity when
 in verbose mode
Content-Language: en-US
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
References: <20231018062234.20492-1-shung-hsi.yu@suse.com>
 <20231018062234.20492-3-shung-hsi.yu@suse.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231018062234.20492-3-shung-hsi.yu@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/18/23 12:22 AM, Shung-Hsi Yu wrote:
> diff --git a/lib/bpf_libbpf.c b/lib/bpf_libbpf.c
> index f678a710..08692d30 100644
> --- a/lib/bpf_libbpf.c
> +++ b/lib/bpf_libbpf.c
> @@ -285,11 +285,14 @@ static int load_bpf_object(struct bpf_cfg_in *cfg)
>  	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, open_opts,
>  			.relaxed_maps = true,
>  			.pin_root_path = root_path,
> -#ifdef (LIBBPF_MAJOR_VERSION > 0) || (LIBBPF_MINOR_VERSION >= 7)
> -			.kernel_log_level = 1,
> -#endif
>  	);
>  
> +#if (LIBBPF_MAJOR_VERSION > 0) || (LIBBPF_MINOR_VERSION >= 7)
> +	open_opts.kernel_log_level = 1;
> +	if (cfg->verbose)
> +		open_opts.kernel_log_level |= 2;
> +#endif
> +
>  	obj = bpf_object__open_file(cfg->object, &open_opts);
>  	if (libbpf_get_error(obj)) {
>  		fprintf(stderr, "ERROR: opening BPF object file failed\n");

Why have the first patch if you redo the code here?

