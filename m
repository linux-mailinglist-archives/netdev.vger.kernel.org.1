Return-Path: <netdev+bounces-14979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFD8744BDE
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 02:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24849280C68
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 00:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB6C17E;
	Sun,  2 Jul 2023 00:01:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEB01361
	for <netdev@vger.kernel.org>; Sun,  2 Jul 2023 00:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0168C433C8;
	Sun,  2 Jul 2023 00:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688256117;
	bh=NqLNDmFMcizqeVHlDcBPeBF36DGYb2uyWd6Mia+2mzw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pFyUf4ETYCnFFxaPskSP/0ChlKq8IMxk9nF6US1rs9vig43letAIEOneUM68wE/cz
	 Gw16ewiaYsPQdAZTTBJnkLRGjFf6K6ZIp3dmOm4A6Dkq/QDTbv0k+U7NoysA7hKyR+
	 tBLQbcX13nX9hmfOFGtyah1QyCGASEdsKyBxuXa+ZOODM1p4dRuyO9nltIQMlqhDbw
	 SRQYx9THVFVpkIIlQk3ODzGdOITOmLUA8Np1PE6AEfiRaVBE4oyGXDPuBsiv/sw2Cs
	 PKL4CVwLuHGh6zM5y/LKv3ezidpF/lgFRTCEfcCDnRpHotbln+TJo23VqiVaBZW0fU
	 EGH5j/1FOirjA==
Date: Sat, 1 Jul 2023 17:01:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Larysa Zaremba <larysa.zaremba@intel.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, Alexander Duyck
 <alexanderduyck@fb.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 0/4] net: page_pool: a couple assorted
 optimizations
Message-ID: <20230701170155.6f72e4b8@kernel.org>
In-Reply-To: <20230629152305.905962-1-aleksander.lobakin@intel.com>
References: <20230629152305.905962-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Jun 2023 17:23:01 +0200 Alexander Lobakin wrote:
>  #3: new, prereq to #4. Add NAPI state flag, which would indicate
>      napi->poll() is running right now, so that napi->list_owner would
>      point to the CPU where it's being run, not just scheduled;
>  #4: new. In addition to recycling skb PP pages directly when @napi_safe
>      is set, check for the flag from #3, which will mean the same if
>      ->list_owner is pointing to us. This allows to use direct recycling  
>      anytime we're inside a NAPI polling loop or GRO stuff going right
>      after it, covering way more cases than is right now.

You know NAPI pretty well so I'm worried I'm missing something.
I don't think the new flag adds any value. NAPI does not have to 
be running, you can drop patch 3 and use in_softirq() instead of 
the new flag, AFAIU.

The reason I did not do that is that I wasn't sure if there is no
weird (netcons?) case where skb gets freed from an IRQ :(

