Return-Path: <netdev+bounces-95938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D16758C3E2B
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 11:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 369152826C1
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 09:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE09D1487E8;
	Mon, 13 May 2024 09:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sg4yzckz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D8E1474B1
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 09:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715592851; cv=none; b=Gi/K45eSPYtCVRH2KrpDbWX+u1LLrARdiI1GWB1I7brDnyQ55RO5v1GZtl48QHCRuXYAt2Z3++4FLVkIlawlGQxk6GH/En3gNj9fEi2qBzBa2YPRIRI23zY+EP7VQkj7kZgvlKpUVnvJV4ytpz+p/QZzPqM9SnCbr7ZVdYTv/gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715592851; c=relaxed/simple;
	bh=VyZQMB1jW8kr9z6S7BFAEzvZVTHi22+0Vg84gc4/QCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4SQttSPX+MuCmslnNNUxFoF4+mGMcw/sR+w5iI2oVpRjMDAogh11DniYwQKqbwX96nnpBIx6TbLzTxUtZ02GMUtuRq2rk7w0selXrzwr1liDXvrxVc9yp8iwjWYoh3XstPlU4nciVQFYpBw+vcVpLgJZZho947ZsIK8iWCX5Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sg4yzckz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57B4C113CC;
	Mon, 13 May 2024 09:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715592851;
	bh=VyZQMB1jW8kr9z6S7BFAEzvZVTHi22+0Vg84gc4/QCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sg4yzckz3vTIBrRFwGdqud8NipC15KlYsdysdXB7eUqKiWtSh+nzDh7/80M/o4RE0
	 QCtPitET6JGWkCIoNSqdE2sBM8XSIdR9JHJWmFTtgzPvSH2LQ9HB+nHLFYnk7UFMWS
	 VVOh8hJofp6jmTVijBOMZUaN+oLUjeYix1kVC37miecMynm8keSpelnhFViWSE8VCM
	 GUxY0GVHnDlf5wpoW/jmseTb373HtMgGqFpz16yvLMIQHiG0iRgrwf2/OFTENH/Ozj
	 Fh1cLRfQanPLnUzUnsDe/EnSzFH5KHIe3/Kkcw2wXQjJhCIC8DE5EIPR21UbEIVozj
	 IyDQJuj+rqh1w==
Date: Mon, 13 May 2024 10:34:04 +0100
From: Simon Horman <horms@kernel.org>
To: darinzon@amazon.com
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Woodhouse, David" <dwmw@amazon.com>,
	"Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>,
	Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	"Bshara, Nafea" <nafea@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Agroskin, Shay" <shayagr@amazon.com>,
	"Itzko, Shahar" <itzko@amazon.com>,
	"Abboud, Osama" <osamaabb@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>,
	"Tabachnik, Ofir" <ofirt@amazon.com>
Subject: Re: [PATCH v2 net-next 1/5] net: ena: Add a counter for driver's
 reset failures
Message-ID: <20240513093404.GE2787@kernel.org>
References: <20240512134637.25299-1-darinzon@amazon.com>
 <20240512134637.25299-2-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240512134637.25299-2-darinzon@amazon.com>

On Sun, May 12, 2024 at 01:46:33PM +0000, darinzon@amazon.com wrote:
> From: David Arinzon <darinzon@amazon.com>
> 
> This patch adds a counter to the ena_adapter struct in
> order to keep track of reset failures.
> The counter is incremented every time either ena_restore_device()
> or ena_destroy_device() fail.
> 
> Signed-off-by: Osama Abboud <osamaabb@amazon.com>
> Signed-off-by: David Arinzon <darinzon@amazon.com>

Reviewed-by: Simon Horman <horms@kernel.org>


