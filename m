Return-Path: <netdev+bounces-198813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86699ADDE94
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 00:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9BFF189395C
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 22:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2682F28C03E;
	Tue, 17 Jun 2025 22:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olo3GTuu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027CE1F4606
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 22:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750198472; cv=none; b=nd+/lY6ilgDrE8hP4y7BaCaaH1UWtITnDsEsXI3oJa7jUdMTbzlVrSJo4PttZE/t42bLwFQJX+x+QOHQewnMZv5F301SmGGZvN/yRj6ByeZ/OAwYyS/iQcitR7zVPIHP+o1wRdsMKJ5ML+63cI1NyGCBxDkvKfy+pOx2f9tUGsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750198472; c=relaxed/simple;
	bh=3WBs0Vxcd7g5HqGksekQQKU3x270qhjowvDnjQ5ZfYg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MLicMeePRDWiKW6bM4U9b248RK3X4X8ZzzELR2zADxun/yBjIVM+Ub4IX1UG2cXYh+qrpClsvF5lM9QVsdOM2tcRWIVC1v7DKXMvsw7zaO8MUIe0LejJItfK2+VqjfTCecHvgQdhio5faAyhgWIIPozqqPXBWAJ+Ez3GGns7bD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olo3GTuu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F06C4CEE3;
	Tue, 17 Jun 2025 22:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750198470;
	bh=3WBs0Vxcd7g5HqGksekQQKU3x270qhjowvDnjQ5ZfYg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=olo3GTuuBHk9L5JLctJUMvPoG8qNpMxI7l6VTsyGV+VduLD8xni5AbS0H3WH+gYap
	 mC8+R61ZS3l4oMaHa36F+rotg0DvwGsO3nQDcig24dzbi1C8O5rij46ARHZZ8NCbDC
	 tvBWhQa5VJlS8o6tp4aQ/AhP9Pb4BG2Y6lKA7iC9eBTPXVAe7rznXPKmJjH+4+2qnx
	 JSJiZ7vBr58c63Y3e3OSaJ2/3SoiNXEWr5KR+bPQ9u5FDnrXklMdQJwvfOqH8htW62
	 21TS+1MybqJPjlqxroYl2m7bmKSu0xOPYjmZBNyZdyxe5DXxqEjgxxnwb2yz+Z9fAX
	 CYEgZaMZSDUZA==
Date: Tue, 17 Jun 2025 15:14:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
 <shayagr@amazon.com>, <akiyano@amazon.com>, <darinzon@amazon.com>,
 <skalluru@marvell.com>, <manishc@marvell.com>, <michael.chan@broadcom.com>,
 <pavan.chebbi@broadcom.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
 <hkelam@marvell.com>, <bbhushan2@marvell.com>
Subject: Re: [PATCH net-next 1/5] eth: bnx2x: migrate to new RXFH callbacks
Message-ID: <20250617151428.499f80c2@kernel.org>
In-Reply-To: <aFENwzdHRYbjW2WX@9fd6dd105bf2>
References: <20250617014555.434790-1-kuba@kernel.org>
	<20250617014555.434790-2-kuba@kernel.org>
	<aFENwzdHRYbjW2WX@9fd6dd105bf2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Jun 2025 06:40:03 +0000 Subbaraya Sundeep wrote:
> > The driver as no other RXNFC functionality so the SET callback can  
> typo as -> has

I'll fix when applying, thanks

