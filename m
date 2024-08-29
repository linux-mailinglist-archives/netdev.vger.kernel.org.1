Return-Path: <netdev+bounces-123531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D0796535D
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 01:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C724284331
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 23:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48D618E776;
	Thu, 29 Aug 2024 23:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EL3yjhHU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB002C18C
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 23:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724973638; cv=none; b=XW0XDBefHScKNmAWYSNehNfDnQyQDHD5LQWYhbGBLmpUO6plZJqQqaP3BctP70PfqPDUJ9GfKR5C1EM85HmHYHK8h3u1tkkrjPYdR2eKNRpjBaw0puec6qQXJpL+feXJgj9PCSJDqP6KrUEDnsAa4nGz2wJk3kilb7EEqqDuQpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724973638; c=relaxed/simple;
	bh=Km0FYpSTIoCeekn0R5YAcUjjqbMJl1hvUz5SeKaRqLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIOyqId73Z8fuKUSmuZqJAQH6XPu7EbZ1yriCHe8CmbIIWtmP+jKQUOT2X23f2P5ph8Kv3F7/hoWdWoG0z/fXuClY7JRDes2daU2S95QR/yi3GBWgTrPJsBTVqu1GGUWf0ngTNOUPnyHxR1QOBdZRCrCkrb5M63H1dS+ss87Ti0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EL3yjhHU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D77DC4CEC1;
	Thu, 29 Aug 2024 23:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724973638;
	bh=Km0FYpSTIoCeekn0R5YAcUjjqbMJl1hvUz5SeKaRqLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EL3yjhHUCTX8ljTG+04izvwbN5ciwQSy8QuOnuqCUTmgvKtbrhOs4KN1yFamvR6Eb
	 SrNstlgI0UoVJschhe1ufEBmId4G25SskBtSJB9GDVG5MH0ew+jGVPPBXJfeNObp6i
	 cM8X9+wmp+1CQxNR3HVBe3v5h/ottxL8k2eLmZ06x//8jOTR5aiRxRpibtskItchg0
	 CKXPw6JlFuRv75ICLOxdVC39e+EcpTPkQWzdoYLLyVxJ/K3KQbIxgTVbzcTpfbMzvk
	 5ddVOlSEd5rZkPUrxueLcetZPf1ojbWwMLWIbxHYif/WD1raqvqyrdvqR6b/wk2tzd
	 +0NAMCdy9fdmQ==
Date: Thu, 29 Aug 2024 16:20:36 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Simon Horman <horms@kernel.org>, kuba@kernel.org
Cc: Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	"edumazet@google.com" <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH net-next 03/10] net/mlx5: hw counters: Replace IDR+lists
 with xarray
Message-ID: <ZtECRERXK7lZmbw6@x130>
References: <20240815054656.2210494-1-tariqt@nvidia.com>
 <20240815054656.2210494-4-tariqt@nvidia.com>
 <20240815134425.GD632411@kernel.org>
 <0dce2c1d2f8adccbfbff39118af9796d84404a67.camel@nvidia.com>
 <20240827150130.GM1368797@kernel.org>
 <20240827152041.GN1368797@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240827152041.GN1368797@kernel.org>

On 27 Aug 16:20, Simon Horman wrote:
>On Tue, Aug 27, 2024 at 04:01:30PM +0100, Simon Horman wrote:
[...]
>Thanks,
>
>as both counter->id and last_bulk_id are unsigned I agree with your
>analysis above, and that this is a false positive.
>
>I don't think any further action is required at this time.
>Sorry for the noise.
>
Jakub, can you please apply this one ? 


