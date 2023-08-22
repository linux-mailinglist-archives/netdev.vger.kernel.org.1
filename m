Return-Path: <netdev+bounces-29542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565C6783B0D
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 09:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FF1E281011
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 07:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A0679EF;
	Tue, 22 Aug 2023 07:38:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DF179C8
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 07:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1EA9C433C8;
	Tue, 22 Aug 2023 07:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692689909;
	bh=mNom6X45L3pSYHHJJ0ucly7QGV2RJtygYKAMx6rhYzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VjgURwioC/4RpCnJAsEjnh/KjKVH482EEQveOZ740/KQE8WUgz1vny1blXoDPc7zc
	 kRg9z7i5MXa4hdIyx//0vRbDkhyItfpv1NHgYjLFFiA6ovhy0266NUj3vt7kYmpkHH
	 du2LI8EMJs3Wl6yPr1JuwhPXrF0VXe1SNh2KN1qaVH+4ADDY47lcCYCosVp6CKzN9V
	 juRWwmlcBWh4lMluPLWkhSuR7h4PCy/qKOOqyGmK0NxqG7HvqhOMdXHumbAsBwSPgx
	 BjZgt70BNB1hJm0EQ9bVixleXFBUrsxxMvG3eYWAe6yCcHZQPMUBSATpZ6RIpGzkXY
	 EkV3rUO8C3Jow==
Date: Tue, 22 Aug 2023 09:38:25 +0200
From: Simon Horman <horms@kernel.org>
To: edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com,
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
	habetsm.xilinx@gmail.com, Andy Moreton <andy.moreton@amd.com>
Subject: Re: [PATCH net] sfc: allocate a big enough SKB for loopback selftest
 packet
Message-ID: <20230822073825.GR2711035@kernel.org>
References: <20230821180153.18652-1-edward.cree@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821180153.18652-1-edward.cree@amd.com>

On Mon, Aug 21, 2023 at 07:01:53PM +0100, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Cited commits passed a size to alloc_skb that was only big enough for
>  the actual packet contents, but the following skb_put + memcpy writes
>  the whole struct efx_loopback_payload including leading and trailing
>  padding bytes (which are then stripped off with skb_pull/skb_trim).
> This could cause an skb_over_panic, although in practice we get saved
>  by kmalloc_size_roundup.
> Pass the entire size we use, instead of the size of the final packet.
> 
> Reported-by: Andy Moreton <andy.moreton@amd.com>
> Fixes: cf60ed469629 ("sfc: use padding to fix alignment in loopback test")
> Fixes: 30c24dd87f3f ("sfc: siena: use padding to fix alignment in loopback test")
> Fixes: 1186c6b31ee1 ("sfc: falcon: use padding to fix alignment in loopback test")
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


