Return-Path: <netdev+bounces-42796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD537D02AF
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 21:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB4811C20BB4
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 19:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3BE3C099;
	Thu, 19 Oct 2023 19:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCm2RjcW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB11F39853
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 19:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A02C433C8;
	Thu, 19 Oct 2023 19:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697744675;
	bh=izDj2zYP8DwXSby60R50T3IYz+d8XUEVmrldIQeBva0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UCm2RjcWqXVqVkEROSO9nnloY4kIlW3yurrtOiyCgfg1Cim+EMiGA0EQqenAQzWyT
	 OlnKkpyYNB5N08HTt4RIzOqLIqwup1YDENDtoMhhymz3pqLWsiJW9PZBeQ6b1CLlbI
	 K1yzOBuzxsyKXbYSI/kArRaBv/RkRYPhs6SToW+Kl238mwQGrChuRButIlE0aJd2q+
	 LLv//cqzun0Ctg2NTlsUk5pKf+DvzFe9iJ0cdzzkbxxkZ0FYbPCWUalFaaVlpPdEDj
	 nmwCMsUFrNle0T319Y+3IBmqiyXFT0NF/vrm0bRhlNvQlBxfNFDDNA33z7HGE3JwtY
	 WtJWybb9l+jKQ==
Message-ID: <820ce6d0-4c36-59c9-f26b-e79a04b56a1e@kernel.org>
Date: Thu, 19 Oct 2023 13:44:34 -0600
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
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>
References: <20231018062234.20492-1-shung-hsi.yu@suse.com>
 <20231018062234.20492-3-shung-hsi.yu@suse.com>
 <5a7efbd1-f05b-4b49-d9a8-ef5c4c6b8ee0@kernel.org> <ZTCD2v7RuQojbkn-@u94a>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <ZTCD2v7RuQojbkn-@u94a>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/18/23 7:18 PM, Shung-Hsi Yu wrote:
> Ah, good point. I was trying to separate out libbpf-related changes from
> verbosity-increasing changes, hence the first patch. And there I add the
> .kernel_log_level field within DECLARE_LIBBPF_OPTS() because that seems to
> be how it's usually done.
> 
> In the second patch I tried to make log-level changes consistent, having
> them all done with `|= 2`, which isn't possible within
> DECLARE_LIBBPF_OPTS().
> 
> Maybe I should have just have `open_opts.kernel_log_level = 1;` outside of
> DECLARE_LIBBPF_OPTS() in the first patch to begin with.
> 
> +#if (LIBBPF_MAJOR_VERSION > 0) || (LIBBPF_MINOR_VERSION >= 7)
> +	open_opts.kernel_log_level = 1;
> +#endif
> 
> Followed by
> 
>  #if (LIBBPF_MAJOR_VERSION > 0) || (LIBBPF_MINOR_VERSION >= 7)
>  	open_opts.kernel_log_level = 1;
> +	if (cfg->verbose)
> +		open_opts.kernel_log_level |= 2;
>  #endif
> 

that is less confusing for a patch sequence.


