Return-Path: <netdev+bounces-95939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3806B8C3E2D
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 11:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E165F1F221FC
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 09:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887D81487E7;
	Mon, 13 May 2024 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeWDe5Hb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6411A1474CF
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715592879; cv=none; b=bo4seeR2J2eB9SwaIdpy0g9oUxZ4Owt4YDAYcxuxdnJpfUyg1dUA2ygqrLdAha03HKuN6GMkt1mLdxjsvgvuwllZ8u9XZTv9xq/gZChyqydhFQGZ6DkJiBMctOWxSqECocNvL5P5O8yk0S+M37M9PeEDzJn1/8BDVUIgXeK/a2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715592879; c=relaxed/simple;
	bh=mNbQd9AfzW1aynCc7OuyM1YQDMI6pZ/WTPsO2obfyjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nwn7t2FZlinWOki6UhvkriFXqNpOH+FbOWGpUzfjMShwFhRbD7ZzYqZzpYXyE7uCj0l/g2YtCM/g1d4od4AzgyuPl3zuXvF/6FJsl2hT9KziVlw+OxzL+BhuxUvDuAFDmk+ptb/xuTM2rjj8vb/xmfLK/I5WiYDPl9Eh/0IBVdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeWDe5Hb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D29C113CC;
	Mon, 13 May 2024 09:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715592878;
	bh=mNbQd9AfzW1aynCc7OuyM1YQDMI6pZ/WTPsO2obfyjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CeWDe5Hbd0zNijkoGhi/0FcHG4FQAkJM5bfJ3T5ty8adjV2gwg8S0CYZKJfY9i2Lb
	 /ANBeiop8TqpODbg6MhZgf34cEF9KiRTIbHpNBQ5rnOe2c7rDw4NkSFCM0ftEf15vA
	 iVbpB2kflQ2lQfocZY9Dq/JTZAoIC2zT6VluEkKeVGbGvoEmXOU6VmwJlb1ruCSQiZ
	 Fmi6d1NVwfcnKk5iKuqTtsoglLHnh3JltcGnIYgzQujTQoHQIK8qiNqvundyqNcpwY
	 MwLR2PljM0iL+gXuUIufcB8VHtsZz3xUUEdt3iFCdK/8uCwsGreuXrP8T/MYkUxmpP
	 npqVd82ZsUMMg==
Date: Mon, 13 May 2024 10:34:32 +0100
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
Subject: Re: [PATCH v2 net-next 2/5] net: ena: Reduce holes in ena_com
 structures
Message-ID: <20240513093432.GF2787@kernel.org>
References: <20240512134637.25299-1-darinzon@amazon.com>
 <20240512134637.25299-3-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240512134637.25299-3-darinzon@amazon.com>

On Sun, May 12, 2024 at 01:46:34PM +0000, darinzon@amazon.com wrote:
> From: David Arinzon <darinzon@amazon.com>
> 
> This patch makes two changes in order to fill holes and
> reduce ther overall size of the structures ena_com_dev
> and ena_com_rx_ctx.
> 
> Signed-off-by: Shahar Itzko <itzko@amazon.com>
> Signed-off-by: David Arinzon <darinzon@amazon.com>

Reviewed-by: Simon Horman <horms@kernel.org>


