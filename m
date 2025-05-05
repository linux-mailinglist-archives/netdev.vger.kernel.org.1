Return-Path: <netdev+bounces-187978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D705AAAE7F
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 04:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5725189E843
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 02:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6E938534C;
	Mon,  5 May 2025 23:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9fXRjxE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35E33635ED
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 22:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485492; cv=none; b=XifsA/n6HssC+D9R9hRugDakz0nfH5bIbN7YzBVXta3CUQjJZ6ZfijRFHr5VBunayN95zAh3wrcc+lvQOawEVQF0BUkNnECcODXXLfdspcQ4wUNEeQHAaUc5vXsgB/gLV+bUc2bU4nMEHEEgVknypcO/j+b0kGgHrwThi2nzeic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485492; c=relaxed/simple;
	bh=Fv7tOcmIH8k0UEu1oeq8fVLRh8TtLCZmxeQiaSFWbC8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Teahvwnzg1s9inCuUFkEBS7PxbmCmqTlCBmzhf5FDoPG0/n5NCBZ7fYwjawEW7/4Li1LJc1ENa4d8bXYm1YXWE65jMD8YjfzuQfREca5J5C2BA4vvaAy2MdEtw78IWkPPZ1cGCA2tOT6xJ18t+/kdZwWsn7T60cdKWN4wac1IjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9fXRjxE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D43C4CEED;
	Mon,  5 May 2025 22:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485491;
	bh=Fv7tOcmIH8k0UEu1oeq8fVLRh8TtLCZmxeQiaSFWbC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K9fXRjxE/jzp5T7JufShItC4QtV89AbCu62dyrao4T8eJBhlslig3WFvxOiCnt9S3
	 aRUxeT7OZ+KDt1ZB5u1dwVUgjO5jcUMdJUr2ngmK2HyFmG4Ml1ot/Zw5W9moid9esS
	 uH5uCsuBVetm7EaMgdJ9FbKpMWwz5ew45ZV4mphYUKkhxYkbkEUnpVf742v34kFDD1
	 qo6T2vhdRMEN07HBOeiR+JuiNWpcopTUix94McNnMA2CsosqLWJB6P3lQPGojtgqsb
	 h3PNA6ojCnaFt2gZicjTjPDCqz/rvabBMmmnGouGPYQQEBILXYAsaTZ/6hXwxud6VD
	 euZFM89CYCaVg==
Date: Mon, 5 May 2025 15:51:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Gustavo Padovan <gus@collabora.com>, Aurelien Aptel <aaptel@nvidia.com>,
 linux-nvme <linux-nvme@lists.infradead.org>, netdev
 <netdev@vger.kernel.org>, sagi <sagi@grimberg.me>, hch <hch@lst.de>, axboe
 <axboe@fb.com>, chaitanyak <chaitanyak@nvidia.com>, davem
 <davem@davemloft.net>, "aurelien.aptel" <aurelien.aptel@gmail.com>, smalin
 <smalin@nvidia.com>, malin1024 <malin1024@gmail.com>, ogerlitz
 <ogerlitz@nvidia.com>, yorayz <yorayz@nvidia.com>, borisp
 <borisp@nvidia.com>, galshalom <galshalom@nvidia.com>, mgurtovoy
 <mgurtovoy@nvidia.com>, tariqt <tariqt@nvidia.com>, edumazet
 <edumazet@google.com>
Subject: Re: [PATCH v28 00/20] nvme-tcp receive offloads
Message-ID: <20250505155130.6e588cdf@kernel.org>
In-Reply-To: <aBky09WRujm8KmEC@kbusch-mbp.dhcp.thefacebook.com>
References: <20250430085741.5108-1-aaptel@nvidia.com>
	<19686c19e11.ba39875d3947402.7647787744422691035@collabora.com>
	<20250505134334.28389275@kernel.org>
	<aBky09WRujm8KmEC@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 May 2025 15:51:15 -0600 Keith Busch wrote:
> On Mon, May 05, 2025 at 01:43:34PM -0700, Jakub Kicinski wrote:
> > Looks like the tests passed? But we'll drop this from our PW, again.
> > Christoph Hellwig was pushing back on the v27. We can't do anything
> > with these until NVMe people are all happy.  
> 
> FWIW, I believe Sagi is okay with this as he has reviewed or acked all
> the patches. I am also okay with this, though I'm more or less neutral
> on the whole since it's outside my scope, but the nvme parts look fine.
> The new additions are isolated to hardware that provides these offloads,
> so I'm not really concerned this is going to be a problem maintaining
> with the existing nvme-tcp driver. I trust in Sagi on this one.

Thanks, so we have two "yes" votes. Let's give it a week and if there
are no vetoes / nacks we can start.. chasing TCP maintainers for an ack?

