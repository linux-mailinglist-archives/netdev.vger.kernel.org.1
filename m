Return-Path: <netdev+bounces-191977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E8FABE159
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 18:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321E01BA7286
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 16:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38522242D85;
	Tue, 20 May 2025 16:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7xbo8ki"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1402222083
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747760200; cv=none; b=nOmRpGvepIo1T1Lkv4wJ2YaX5mmuqEhjr4gq5wpawZY6i4F+Y/zY8M7dMR9XKtzYf8Z/STJ+bf1+rOmodQ59I66wY8NDDAWuvSYma8+aPIrbaAER8V8uOuQVklsRJuw44zyHoeskS5aD6Sh/fBfZAeEMA+4+Yyc2dEGpKM1W8Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747760200; c=relaxed/simple;
	bh=R2LH2rZEfsv4i6o4b0WSOGbE7Y7H3Up5vJnZGEZucM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSbMluAy1Q+39ZKkqtRtKRv1KcRR1Gi3C6srkyZws54QQXVf6z48XcNckl4Qvh2BHUMCC9NON9nFX4rcLGCTSt8Qxs6YaG1N3fz9TaKSQs+95SCgq1fxxlImfTzEwWDDfvzI4UYzahj1QH/QVAR0yBMmKOHotUmpslgStwSuAT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7xbo8ki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE29CC4CEE9;
	Tue, 20 May 2025 16:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747760199;
	bh=R2LH2rZEfsv4i6o4b0WSOGbE7Y7H3Up5vJnZGEZucM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F7xbo8kiBZvLKEhVVE6zvdir338QOg71Mg0mYqNzqgxR6Gr/oG/jgYDVhGjiChnNF
	 czD5BdRT6pHqtKM/O0gb6VwnHh8GnUWuymo2JnI6wxa+vEIWiawS/TE0QJIqacs891
	 I0x0KvKUtjj68aXZePwVMdKOaxiiTvPD5DWqId0FYDTRo0ty0H8QCPDAFJTZ94K+7A
	 FbGOaXqQmJ/rvkjvoO4AF+qG52K0RnCXZ7ZIrA1JtnMLumchlVeK08FQs35YbPv5Cz
	 io2e/3ZG9Vk/CoeFlh3YHjPscUbenYjAjS2wNRwAebrgBfzFpFl3xcBqadY1jNlJzJ
	 0W5KlnDg8xmEg==
Date: Tue, 20 May 2025 17:56:35 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, richardcochran@gmail.com,
	linux@armlinux.org.uk, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 2/9] net: wangxun: Use specific flag bit to
 simplify the code
Message-ID: <20250520165635.GH365796@horms.kernel.org>
References: <20250516093220.6044-1-jiawenwu@trustnetic.com>
 <328F8950017A7028+20250516093220.6044-3-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <328F8950017A7028+20250516093220.6044-3-jiawenwu@trustnetic.com>

On Fri, May 16, 2025 at 05:32:13PM +0800, Jiawen Wu wrote:
> Most of the different code that requires MAC type in the common library
> is due to NGBE only supports a few queues and pools, unlike TXGBE, which
> supports 128 queues and 64 pools. This difference accounts for most of
> the hardware configuration differences in the driver code. So add a flag
> bit "WX_FLAG_MULTI_64_FUNC" for them to clean-up the driver code.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Simon Horman <horms@kernel.org>


