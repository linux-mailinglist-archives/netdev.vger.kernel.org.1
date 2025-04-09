Return-Path: <netdev+bounces-180665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 567AAA8211B
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 11:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37E244A3C04
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 09:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E7B23E351;
	Wed,  9 Apr 2025 09:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3feIENW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0891D63C5;
	Wed,  9 Apr 2025 09:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744191455; cv=none; b=J5lyVOqUxWHIP+l/mrtKmuhMD18jOsRK5s3qL5e9yAVp3gvDQ7EC3xWdB5veTbGMv55e30ji2xijE9k+uHigP4oa+mtt2fTeP1OeKRQo1hSrldYillgfRiXXebG/9j5VLgzH0m++QBwdxIn8NkEjgQv0Hba+24SRV7tz0LKSEtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744191455; c=relaxed/simple;
	bh=WuVr9GOH0hdHsvLA7SJmBIgzMsKM3RIkhcK79j5FJiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCDgMBa77xuag0NXHUJwc5uwD+YJM/PsVAgYkyCXXLgY26lPDjxRf4grkcQp00kWWJSBohGY+hBNKv0Z6YJw3aMOby9q5SnRvEewsbKcABDZZ6Gb4td7e++zTOjFqJfKSKi1QLnwfWRb9S07vDv3PvCqUrp2JEdBjX5UjN/4SOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3feIENW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5167C4CEE3;
	Wed,  9 Apr 2025 09:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744191454;
	bh=WuVr9GOH0hdHsvLA7SJmBIgzMsKM3RIkhcK79j5FJiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B3feIENW/TN+f5EuO2LePWNVd17yqQxaLWGHDVRsj490Hv5wFxGeH6BX/yDh+dEno
	 QrxmZdPkXY62lc3xxMetHwJXy6sSekzUr+BdEHzARKD4Ta3B2ktJ+iEb4WDGRoQeo1
	 +KAfIeYS/I9cp+kn1c3Q8nPJuD9Vi363xzA3vREVjLD+h+WGt0OkOczW/fGfk5l0Od
	 ZjpawiHmoDkojyifCXWhg3LYbCIKfz9yE15+ADqZq50q3ENgmwVOKCLHnO7c229JT1
	 O1HrMRgwDDdNACKBDCFcBPxQuENSc352BWEbfAOJXpJDOt+AHuQ+2W7bou0wb3oqrs
	 BKQm/D1aNbZ6g==
Date: Wed, 9 Apr 2025 10:37:30 +0100
From: Simon Horman <horms@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: andrew+netdev@lunn.ch, brett.creeley@amd.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	michal.swiatkowski@linux.intel.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net 1/6] pds_core: Prevent possible adminq overflow/stuck
 condition
Message-ID: <20250409093730.GJ395307@horms.kernel.org>
References: <20250407225113.51850-1-shannon.nelson@amd.com>
 <20250407225113.51850-2-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407225113.51850-2-shannon.nelson@amd.com>

On Mon, Apr 07, 2025 at 03:51:08PM -0700, Shannon Nelson wrote:
> From: Brett Creeley <brett.creeley@amd.com>
> 
> The pds_core's adminq is protected by the adminq_lock, which prevents
> more than 1 command to be posted onto it at any one time. This makes it
> so the client drivers cannot simultaneously post adminq commands.
> However, the completions happen in a different context, which means
> multiple adminq commands can be posted sequentially and all waiting
> on completion.
> 
> On the FW side, the backing adminq request queue is only 16 entries
> long and the retry mechanism and/or overflow/stuck prevention is
> lacking. This can cause the adminq to get stuck, so commands are no
> longer processed and completions are no longer sent by the FW.
> 
> As an initial fix, prevent more than 16 outstanding adminq commands so
> there's no way to cause the adminq from getting stuck. This works
> because the backing adminq request queue will never have more than 16
> pending adminq commands, so it will never overflow. This is done by
> reducing the adminq depth to 16.
> 
> Fixes: 792d36ccc163 ("pds_core: Clean up init/uninit flows to be more readable")

Hi Brett and Shannon,

I see that the cited commit added the lines that are being updated
to pdsc_core_init(). But it seems to me that it did so by moving
them from pdsc_setup(). So I wonder if it is actually the commit
that added the code to pdsc_setup() that is being fixed.

If so, perhaps:

  Fixes: 45d76f492938 ("pds_core: set up device and adminq")

> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

...

