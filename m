Return-Path: <netdev+bounces-18138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 523E47558AF
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 01:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 252451C2095D
	for <lists+netdev@lfdr.de>; Sun, 16 Jul 2023 23:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D9C945A;
	Sun, 16 Jul 2023 23:57:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1848F7D
	for <netdev@vger.kernel.org>; Sun, 16 Jul 2023 23:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F19C433C7;
	Sun, 16 Jul 2023 23:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689551833;
	bh=+2BhqY9zrhKuYyQ9etJS5H8r5edL7fVLVmdomTcsJy0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TBFRNmShB+QtUymfhfsuzlj3mrAUiU+5Hg+ldphDuktGwVKO+KxXQagpUkGBQJbWl
	 hXyeF+Rfg6ewUcNhDMsuBvqcdWqvqawpVMD6yWImZiyxQtdvTYWzL+kMpw5xzqpRhG
	 zeXaT0cOS+lRpVDZ6s045vluNNr6NG8cNDQ0AcffxOFmBiEOaCwDgVYYnRJ3T4sqWQ
	 wzLuT7zwBFRFCBLF6Pt82BWVaS82xTXICHEGNuTljfml0iqwe6rpTBHVuINaJ0uP2a
	 1u6ABa3DonIrUNt5odDi+lmA05AzQN6US36BEfW0zBjuLP3/0xlzgySFmJCGVXiatb
	 uc5uAgsCg/N8w==
Message-ID: <73971895-6fa7-a5e1-542d-3faccbc4a830@kernel.org>
Date: Sun, 16 Jul 2023 16:57:07 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 06/10] net: add SO_DEVMEM_DONTNEED setsockopt to
 release RX pages
Content-Language: en-US
To: Mina Almasry <almasrymina@google.com>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, netdev@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Arnd Bergmann
 <arnd@arndb.de>, David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, jgg@ziepe.ca
References: <20230710223304.1174642-1-almasrymina@google.com>
 <20230710223304.1174642-7-almasrymina@google.com>
From: Andy Lutomirski <luto@kernel.org>
In-Reply-To: <20230710223304.1174642-7-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/23 15:32, Mina Almasry wrote:
> Add an interface for the user to notify the kernel that it is done reading
> the NET_RX dmabuf pages returned as cmsg. The kernel will drop the
> reference on the NET_RX pages to make them available for re-use.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---

> +		for (i = 0; i < num_tokens; i++) {
> +			for (j = 0; j < tokens[i].token_count; j++) {
> +				struct page *pg = xa_erase(&sk->sk_pagepool,
> +							   tokens[i].token_start + j);
> +
> +				if (pg)
> +					put_page(pg);
> +				else
> +					/* -EINTR here notifies the userspace
> +					 * that not all tokens passed to it have
> +					 * been freed.
> +					 */
> +					ret = -EINTR;

Unless I'm missing something, this type of error reporting is 
unrecoverable -- userspace doesn't know how many tokens have been freed.

I think you should either make it explicitly unrecoverable (somehow shut 
down dmabuf handling entirely) or tell userspace how many tokens were 
successfully freed.

--Andy

