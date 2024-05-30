Return-Path: <netdev+bounces-99573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE178D554B
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 00:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 233F91C219A7
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 22:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731A417DE23;
	Thu, 30 May 2024 22:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqRAPOqh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5C21761AC
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 22:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717107471; cv=none; b=So2Zn9/9VGOUDQUnIM8/hLxmikMK8lPlwoocM9nqeSNQoefak9jz7uldFV0F8xtZRIH8cqdOJjXgld7t3eUybirIZhCX4fa8omdXqzo1zJQous6Wzu+FHDerHJnw3zUzd12MX/ZuQC2QGnYfqhNiSCMAd2Wzg0VvQOg7ttrKCkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717107471; c=relaxed/simple;
	bh=hfrqcqOwSHOsIrYCkE07jUl9xQmI1MwMU083qe7uD8k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ET51Z3EqewaIGu53isoCxI72uGT0yHxwMDhrcBfms+6I6Lb1J30jE9JZ68O/eA34qpLk3npyRx+TMgGRPtlcNwsPLY1Um8Sh2wKcn9NROGN0IGGx0kj3ior8HVKZOG2Ow9rN2IKK5lpUeEwzeFQovaEghR259KovSTv0h+3E5mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqRAPOqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97650C2BBFC;
	Thu, 30 May 2024 22:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717107470;
	bh=hfrqcqOwSHOsIrYCkE07jUl9xQmI1MwMU083qe7uD8k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iqRAPOqhVSj94kS5pxlRsjIh9L10WJiOSxJ/Obe5eApHuRNxrS0inXQTOjfQoNxEM
	 u1fd9hk7cr5eKFKJJC+rettvxS3kuO1CmMGaHnDpBguSq1Gl5WbEqva40CwSmDxiXd
	 KjX+1Riim3rsiFePULpbtUqIFvaFFyNokTNgvOoYiOsYPh0+IqmXhVJyeOdiZ+YmGL
	 VzfRBtf1YW3NW3airn3S0oiMji/y/Dl+jxOqJOLYAnobJvhNuc9fp8r8VyZHSyIO7s
	 EpjcBYlz4MzTbHlEw+8UxZT/YYK197e/DaMWiQ3yDhH6wftlIuJYoHo997e7tgMi0/
	 lNG/GJG95pNsQ==
Date: Thu, 30 May 2024 15:17:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthias Stocker <mstocker@barracuda.com>
Cc: "pv-drivers@vmware.com" <pv-drivers@vmware.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "doshir@vmware.com"
 <doshir@vmware.com>
Subject: Re: [PATCH] vmxnet3: disable rx data ring on dma allocation failure
Message-ID: <20240530151749.7118e4da@kernel.org>
In-Reply-To: <f3cee80744acbad74fed1b653f2b3bd32856bfb0.camel@barracuda.com>
References: <20240528100615.30818-1-mstocker@barracuda.com>
	<20240529175721.1e07b506@kernel.org>
	<f3cee80744acbad74fed1b653f2b3bd32856bfb0.camel@barracuda.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 May 2024 16:00:22 +0000 Matthias Stocker wrote:
> Whereas when I reverted the above mentioned commit 6f4833383e85 ("net:
> vmxnet3: Fix NULL pointer dereference and applied the patch I've
> submitted earlier, then everything seemed to work perfectly fine even
> with those allocations failing.
> 
> I assume that setting rq->data_ring.desc_size to zero in
> vmxnet3_rq_destroy_all_rxdataring is also needed for the data_ring that
> faild to allocate its base. Otherwise it will later on be handed over
> to Vmxnet3_RxQueueConf->rxDataRingDescSize in the function
> vmxnet3_setup_driver_shared thus allowing to reference the data_ring of
> this rx_queue, but I didn't have time to pursue it any further.

I see, the new stack trace makes sense.
I'm guessing hypervisor decides whether feature is enabled or not based
on the ring size, not the ring address.

Please respin with the updated commit message (stack trace, Fixes tag,
explanation).

