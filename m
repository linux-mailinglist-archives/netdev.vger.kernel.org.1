Return-Path: <netdev+bounces-199975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7563AE29A3
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 16:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70743189B452
	for <lists+netdev@lfdr.de>; Sat, 21 Jun 2025 14:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D580A191F92;
	Sat, 21 Jun 2025 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRM4ORya"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF825E56A
	for <netdev@vger.kernel.org>; Sat, 21 Jun 2025 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750517745; cv=none; b=rhYqoYbAFMfXKjdurfFakIr5rY+eLBiIP4D7NLXiw5L9Z+7Z0soKfjvyna+dYUr6iERk2j/72kRxqC6gOWz++AolxS0Ve3tkYJRLGYoCT7luH+fTSQN8NlnkqjdV4UkLPA7Bn073fJy1cXASwKwLGI1Ytvd6Eksz3CG/PVOYqpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750517745; c=relaxed/simple;
	bh=rSB82irnNz0YGKFyiPHX14pEevrv/10ujSAVq4Gx5rY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B2OhN+B19aF23+8GHn5LO0/IlpnnYwPgE7azhaeJodWlSynfyloMwmFquh2lEtQ0mfHrvvEN2RdUHDvp7/YH5/uZak5DV78yFY92cbtXz02vbVdu13Mi4c1KwN17x5I80nFeUE/8VSRyFC+w9z2AoaHpTykhZmasqc5eZpqInIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRM4ORya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7ECC4CEE7;
	Sat, 21 Jun 2025 14:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750517745;
	bh=rSB82irnNz0YGKFyiPHX14pEevrv/10ujSAVq4Gx5rY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QRM4ORyaM7Rpm+k8sbzbfDXBZHY9iVkOo5X9KkCqg4NvhDIQ3Qbnp4R3o6HQkThq3
	 5Q9ouZeM+XlrmyzADWfjg5iD6TFcM2Qgqdz7KrM97yOVktO+sY0UXZHXl9YPxA025o
	 kBCL3xEDCmfaqIC2dc98gnDqQmpe+OodwLIz6TAeiqBRUMRNxxIK31JTtHsUAFHeOR
	 2zvrlayanIAH/xCl2b5T3dB1FNkUul3GPQuQZ6sRijobDd37SDmzH4hkKGOQt37dz9
	 BXyD/QZjp+Ml+YdHKwWG2B1NWFlSLa3rH3JNuTbkJJ686E0lUfQD14eiDyW8xTgH4a
	 tVOE0XFJ6+baQ==
Date: Sat, 21 Jun 2025 07:55:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, ajit.khaparde@broadcom.com,
 sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
 shenjian15@huawei.com, salil.mehta@huawei.com, shaojijie@huawei.com,
 cai.huoqing@linux.dev, saeedm@nvidia.com, tariqt@nvidia.com,
 louis.peens@corigine.com, mbloch@nvidia.com, manishc@marvell.com,
 ecree.xilinx@gmail.com, joe@dama.to
Subject: Re: [PATCH net-next 04/10] eth: benet: migrate to new RXFH
 callbacks
Message-ID: <20250621075543.17fb100d@kernel.org>
In-Reply-To: <20250620094852.GA194429@horms.kernel.org>
References: <20250618203823.1336156-1-kuba@kernel.org>
	<20250618203823.1336156-5-kuba@kernel.org>
	<20250620094852.GA194429@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Jun 2025 10:48:52 +0100 Simon Horman wrote:
> > -static int be_set_rss_hash_opts(struct be_adapter *adapter,
> > -				struct ethtool_rxnfc *cmd)
> > +  
> 
> super nit: there are two consecutive blank lines are here now

Fixed when applying, thanks for catching!

