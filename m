Return-Path: <netdev+bounces-86631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E0889FA7C
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 16:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14F01F2E5AC
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 14:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C36616DED8;
	Wed, 10 Apr 2024 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwOEbeOb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9F516D9D0
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712760086; cv=none; b=rjV5WTZmDB0m2HTe1MB2R3GTl+/rhVw/ThxCOArkdEJ1QsuukVakkE64lnyroPPGguH3kTmOIc+MPyHNoz44uDqth1pWpK0dhUZEKuSzIRhdIjLSIKvbGDlwmeSwl64DaUF1mPdEhfHvHqFn6PQ2Ds1vAlBXFmuTkbg9d7NvfRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712760086; c=relaxed/simple;
	bh=n3YAqjAx71/wSKLtYaMdGmf44ywxmNX1QDQGVv5v8Mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQ0Yo1+kc5wgNhw1Ri1/ly09E44f63zhcZDoeeBSTCqa9zvySP+dP0bL/VKUyo0yUVknSif3tYyEd+s3Hjj+bs3lXJNEfxtOrjcu6FxX4tmX8P/vjKkoEQF0X3h7Lul41pnH9qiMackqZIGBQobufVkWG97oCKdcq+gDldlZg5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwOEbeOb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4901FC433C7;
	Wed, 10 Apr 2024 14:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712760085;
	bh=n3YAqjAx71/wSKLtYaMdGmf44ywxmNX1QDQGVv5v8Mc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AwOEbeOb/HJBg2lPui30OhbaM6M32DH1QkGo7D6b75Lhyw3bvj04P+WGYvTMIJGXM
	 hGodl1uaPWQ2k75JN7XaRGc9MKTD2F8mPgJWG7fZy1ieVJOxC1QIyH9kldRtaqtxRF
	 yXHWR/8C+6LWFwOWVn9ESAmOO9+LXWQmgpKoDkh/kE4hizLR/8I+saragL0P/CDMhx
	 +Xqbk3K+AZ633sjRbLfhqqQzNeTJ8bst5GpO0nWQLDNEsm5xdnT4wXI04CYY59WdfU
	 MZc4mN9OkpKxS3hLcOF67TdVJMRTfz2enZBdDOSvzhJSCl6Z91qlTwXtiiGC+bYL8x
	 F1ImQuh0e6vEA==
Message-ID: <b6ee53c0-ed4b-4d23-9fe9-9a33f162d472@kernel.org>
Date: Wed, 10 Apr 2024 08:41:24 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv4: Remove RTO_ONLINK.
Content-Language: en-US
To: Guillaume Nault <gnault@redhat.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org
References: <57de760565cab55df7b129f523530ac6475865b2.1712754146.git.gnault@redhat.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <57de760565cab55df7b129f523530ac6475865b2.1712754146.git.gnault@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/24 7:14 AM, Guillaume Nault wrote:
> RTO_ONLINK was a flag used in ->flowi4_tos that allowed to alter the
> scope of an IPv4 route lookup. Setting this flag was equivalent to
> specifying RT_SCOPE_LINK in ->flowi4_scope.
> 
> With commit ec20b2830093 ("ipv4: Set scope explicitly in
> ip_route_output()."), the last users of RTO_ONLINK have been removed.
> Therefore, we can now drop the code that checked this bit and stop
> modifying ->flowi4_scope in ip_route_output_key_hash().
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>
> ---
>  include/net/route.h |  2 --
>  net/ipv4/route.c    | 14 +-------------
>  2 files changed, 1 insertion(+), 15 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



