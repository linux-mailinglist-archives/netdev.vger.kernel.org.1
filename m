Return-Path: <netdev+bounces-199702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC2FAE1847
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 11:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E645A5A3A
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 09:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D50286D61;
	Fri, 20 Jun 2025 09:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxWUvfxo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF8E2868B8
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 09:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750413002; cv=none; b=LwH2qaqH9mtzD13aHu1gIOCyoq4b4xgy/HiQMve09TaSFXADOZTbtE/h2bsdaUYO7KMixlSCvjVpSqxUYsn6d5tTi4yvaBC+nu0et+VskLPCj6muP3EtIVawS20k8El2EeM6uPHOVKSw2ck+KSPE3dvALGxgFoXzR8Ra3LEKgn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750413002; c=relaxed/simple;
	bh=EX+8RGsRRi72Ef6VMw4+jtUtjKfSDzrA///OK8AnJ34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvmDP+UVXzLbpNHMnX2v0Yuf/J6iss8HtqRaTt9SOvBFkMRBZ29rQsdrWNwtPgyr24OjziFN9c3PR5lHwihkZsv+eFaK8lSOUiDeBMZlcpq8n+tD5mt+ueHKCNCgDK7f9Te9K/1hDUufKAY02YNbMSpjyAB4vFxD12+vccPri2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxWUvfxo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2BBC4CEE3;
	Fri, 20 Jun 2025 09:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750413001;
	bh=EX+8RGsRRi72Ef6VMw4+jtUtjKfSDzrA///OK8AnJ34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XxWUvfxogkd6vbXBIAxAxEUyf8zpoYwJyzSuRAVFHApCp0b0ODHcDqaIJYCPUKH56
	 uvKKQ1bA6nZHkg6zAHeRSKZVroYTmFwCNvOts90Wbb4J0HG5Be2JEJYynBwEvOlP28
	 /wyjgr8XJgUfkHvn69EVFaB8PlHfKLaR4E1k6IgG2Hbt3MMVaiBLx3E4BDjv7/zyE1
	 fH0FenJMRj4byDU5KQYYuU15Tm+VWScoqMAHrggvDZzN6ChdKasja2KPkdL/V1eGKu
	 DSzu5gS3ZDLZEjih62KVcenUPW8SzVWnm/idmszjMusq3uF9PR6MnSREARE7/2cDXt
	 9Dv2x5Bvqldmg==
Date: Fri, 20 Jun 2025 10:49:55 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
	somnath.kotur@broadcom.com, shenjian15@huawei.com,
	salil.mehta@huawei.com, shaojijie@huawei.com, cai.huoqing@linux.dev,
	saeedm@nvidia.com, tariqt@nvidia.com, louis.peens@corigine.com,
	mbloch@nvidia.com, manishc@marvell.com, ecree.xilinx@gmail.com,
	joe@dama.to
Subject: Re: [PATCH net-next 08/10] eth: hinic: migrate to new RXFH callbacks
Message-ID: <20250620094955.GC194429@horms.kernel.org>
References: <20250618203823.1336156-1-kuba@kernel.org>
 <20250618203823.1336156-9-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618203823.1336156-9-kuba@kernel.org>

On Wed, Jun 18, 2025 at 01:38:21PM -0700, Jakub Kicinski wrote:
> Migrate to new callbacks added by commit 9bb00786fc61 ("net: ethtool:
> add dedicated callbacks for getting and setting rxfh fields").
> 
> Zeroing data on SET is not necessary, the argument is not copied
> back to user space. The driver has no other RXNFC functionality
> so the SET callback can be now removed.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


