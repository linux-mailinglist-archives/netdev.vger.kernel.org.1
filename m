Return-Path: <netdev+bounces-95942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7366A8C3E33
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 11:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A875F1C211E7
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 09:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4211487EC;
	Mon, 13 May 2024 09:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdxjV24a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC67D1474B1
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 09:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715592940; cv=none; b=GKMEypWtH7w45UTPh1RPN2vGqxEjTmyTJI5MIBUztqLPgIo7Xjqg47bZds+oB5o/jQnY1u46aC0ZSV1FLhzkhigHZgW3J/OtXTgQ+6RVkG3TGeNjR8H2ZmA2S7ql7YYi7yMmZRKAXqfbdKqIRmmfz3oFT+rDU0EUW0H2QfCgbfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715592940; c=relaxed/simple;
	bh=xx8wLHIUtTBc9vrQICq/qOKu6/jmom3sE/YkUk0iOuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCnr/CLAzcZgT/0pGHwrEvrDxvrAHdweMwAb/n1Xy/w6kHuwAOWHlgAX30l5Qk79oh++aJnAefygz6+GFv8V50gueGzdeM70hK6bMka+gcNh2q0ktA4qwlUOwc3F5AjVnLUdkNcKPCvVOinzQX3kd85z88zsppc46KK1wv1SFFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdxjV24a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7164EC113CC;
	Mon, 13 May 2024 09:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715592940;
	bh=xx8wLHIUtTBc9vrQICq/qOKu6/jmom3sE/YkUk0iOuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PdxjV24amUv+AHNkHwB9Mf4NHHse77dk/Iv7GXeT66iM7M5vWPDQZoj47HlbjL6MH
	 S989F9XepliMthrNGN0ffOF0gIMDLAKkLAOBwxyFow56jNeeAg79s18ngRlr+uOaRN
	 Gto21bC+ebuVZAbvJhPSqBs1Hu1nGbcDVVOjgOLWujnTNkXanQhj9rbvBCCUGPLxVi
	 uTIjZY9fME7A3mre4TNLO58EZElPUokEknrAcBAJiSvRYNLyxQ6c2G2/XiRpQiroDn
	 X3UZuNd+QKMGx0e4s2IV+rVSvvJbiDb57TTy3S3SXnWMbFQFd3BtPeEV/lwMIBbDg6
	 lFayAN3MopC+A==
Date: Mon, 13 May 2024 10:35:34 +0100
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
Subject: Re: [PATCH v2 net-next 5/5] net: ena: Change initial rx_usec interval
Message-ID: <20240513093534.GI2787@kernel.org>
References: <20240512134637.25299-1-darinzon@amazon.com>
 <20240512134637.25299-6-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240512134637.25299-6-darinzon@amazon.com>

On Sun, May 12, 2024 at 01:46:37PM +0000, darinzon@amazon.com wrote:
> From: David Arinzon <darinzon@amazon.com>
> 
> For the purpose of obtaining better CPU utilization,
> minimum rx moderation interval is set to 20 usec.
> 
> Signed-off-by: Osama Abboud <osamaabb@amazon.com>
> Signed-off-by: David Arinzon <darinzon@amazon.com>

Reviewed-by: Simon Horman <horms@kernel.org>


