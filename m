Return-Path: <netdev+bounces-25823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE25B775EE9
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 14:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902761C2119B
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 12:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1593E182A1;
	Wed,  9 Aug 2023 12:28:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8437817AB8
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 12:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A73C433C7;
	Wed,  9 Aug 2023 12:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691584114;
	bh=sEM6A7v8beM65GOpgbPHHqgeliizvdkk3E1U4YHkLoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lpoK/uANDrW8WWjFdIuPn8HIUyukQYCDHPHUzvttZ439ycDydHiICm5YqRDCqY6fX
	 GhUTaH+Tj/1szgSGYR7S6EQdOjsMVdj4pvqmSSrtvP5avxFBLiaWavN8Kb3h28jJXg
	 0VqS1lIIo9GuUeiOgZH1PUu7H7QSp23twNms3I9JUpceKvuKxSZpnG5ZNNoIHDz3Ed
	 UMGCP3VYYbXzf8n4GhWVDo8RVGAGAuw7lwGS4GMhtU3bZxpSZum6GlCMb07OXLrdwn
	 5fLzVBS/OUNhIv+pdDtHcBi114C5FDI0zl8wpha3dCK7Ny0bGlzjDJ21vQU6w/HEoR
	 FzVF/NRyH3dQQ==
Date: Wed, 9 Aug 2023 14:28:27 +0200
From: Simon Horman <horms@kernel.org>
To: "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wang Weiyang <wangweiyang2@huawei.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>, gongruiqi1@huawei.com
Subject: Re: [PATCH v3] netfilter: ebtables: fix fortify warnings in
 size_entry_mwt()
Message-ID: <ZNOGa02ymvkTAXPD@vergenet.net>
References: <20230809074503.1323102-1-gongruiqi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230809074503.1323102-1-gongruiqi@huaweicloud.com>

On Wed, Aug 09, 2023 at 03:45:03PM +0800, GONG, Ruiqi wrote:
> From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
> 
> When compiling with gcc 13 and CONFIG_FORTIFY_SOURCE=y, the following
> warning appears:
> 
> In function ‘fortify_memcpy_chk’,
>     inlined from ‘size_entry_mwt’ at net/bridge/netfilter/ebtables.c:2118:2:
> ./include/linux/fortify-string.h:592:25: error: call to ‘__read_overflow2_field’
> declared with attribute warning: detected read beyond size of field (2nd parameter);
> maybe use struct_group()? [-Werror=attribute-warning]
>   592 |                         __read_overflow2_field(q_size_field, size);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The compiler is complaining:
> 
> memcpy(&offsets[1], &entry->watchers_offset,
>                        sizeof(offsets) - sizeof(offsets[0]));
> 
> where memcpy reads beyong &entry->watchers_offset to copy

nit: beyong -> beyond

...

