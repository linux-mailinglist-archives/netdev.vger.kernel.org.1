Return-Path: <netdev+bounces-67285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1870842981
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 17:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D257286C9F
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 16:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FCE128371;
	Tue, 30 Jan 2024 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ku+/KYPL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6699B1272BA;
	Tue, 30 Jan 2024 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706632697; cv=none; b=YSt2CRqgk1/ihKi9hfMjRxQ5w6TBjWd8ZtujmIEALiiDZg2RXNnms8nEOm1myWBR/dgNwvMdExiOTp+ZmJ/ckrvR4JXg046BfzekmnPGgEjGCgRR3Q4+y/q4zQnR2eluhULRav8eoMW/OVWoEu/1Kuk8zELCjiPPbWY7wQTjdkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706632697; c=relaxed/simple;
	bh=nxkTY64kn3vx0ZxOVuDzgl6Ifx+sox0ekL5shkpfVRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jeRKoYvqqPTRpcfpuZtN7Hj+42umcU5dT/tTO3YvsapWAWTO49YFb8Pg7nu6SgxShle2aWgTzcizcAG2/JuqajUmYF8IMG9eHsqjqy0H43B8CcWFdR1M4uSsszKMNfMuYpBbdZQLeLVQxRosiLmviqkWECJvpCx/+u4qysk/CQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ku+/KYPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1FFC433F1;
	Tue, 30 Jan 2024 16:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706632697;
	bh=nxkTY64kn3vx0ZxOVuDzgl6Ifx+sox0ekL5shkpfVRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ku+/KYPLHs5whcJsK1PPmUFRNk2CkjQG9ouTyx2VT3jhSakcZPee5xPYYgjHBexsZ
	 9RkLDgh/1IQicIunWIT6KmQwsue8ZafyGuiviVKL6idccXDnHAMuIi7ZIL1fZzV4qr
	 FEsVfEYAUvIWfxvWPT7rBlKWKKvx1gpFWq8++VTg=
Date: Tue, 30 Jan 2024 08:38:16 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mpatocka@redhat.com,
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
	msnitzer@redhat.com, ignat@cloudflare.com, damien.lemoal@wdc.com,
	bob.liu@oracle.com, houtao1@huawei.com, peterz@infradead.org,
	mingo@kernel.org, netdev@vger.kernel.org, allen.lkml@gmail.com,
	kernel-team@meta.com, Alan Stern <stern@rowland.harvard.edu>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 5/8] usb: core: hcd: Convert from tasklet to BH workqueue
Message-ID: <2024013008-throbbing-radiated-5644@gregkh>
References: <20240130091300.2968534-1-tj@kernel.org>
 <20240130091300.2968534-6-tj@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130091300.2968534-6-tj@kernel.org>

On Mon, Jan 29, 2024 at 11:11:52PM -1000, Tejun Heo wrote:
> The only generic interface to execute asynchronously in the BH context is
> tasklet; however, it's marked deprecated and has some design flaws. To
> replace tasklets, BH workqueue support was recently added. A BH workqueue
> behaves similarly to regular workqueues except that the queued work items
> are executed in the BH context.
> 
> This patch converts usb hcd from tasklet to BH workqueue.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: linux-usb@vger.kernel.org
> ---
>  drivers/usb/core/hcd.c  | 23 ++++++++++++-----------
>  include/linux/usb/hcd.h |  2 +-
>  2 files changed, 13 insertions(+), 12 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

