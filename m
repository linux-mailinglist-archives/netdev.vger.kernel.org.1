Return-Path: <netdev+bounces-106992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4059991863B
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 17:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE57C1F21E87
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 15:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB5B186E38;
	Wed, 26 Jun 2024 15:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGKZdkB9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698961836DD
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 15:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719417019; cv=none; b=k8IrTIQnsWtWwdzpRg26kXnKRnugfepWQeG2eWpWuZ6JocQ7ZDGH3BRoPx5ci0CB2oMa1BALVHjjMd8G7UsFz9EfVFYbzjrGkKgWcTjFJtGFebt/3pfgvuINgO+zys+8Krr3mg/zavvLzeRWQbMzoWzmMIFUTC8MeGexXygOej0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719417019; c=relaxed/simple;
	bh=udilUP9QJArcgyMP6AgqugC0tzaFDqpIwZeV/EYoOjw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oT0InhT4K+kb/SdBlCdmI7G08dgpTNUbnWtyd25Oh5UnLrbWxtLjje10q3eOxKr5XJWVOldONEg7cxy21ViVNJz5G8C/SbYnevoF8lbAz64SKOwrHDVmnjC5S+dQ9sIG0WiX14/qZ/fLu6+6FN6Z7blbUFLZ9I0xdoSa/JktUJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGKZdkB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707C4C116B1;
	Wed, 26 Jun 2024 15:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719417019;
	bh=udilUP9QJArcgyMP6AgqugC0tzaFDqpIwZeV/EYoOjw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NGKZdkB9wmHhzG1udefXK8CwYhsvgWTSxQF4so9tYeWPv2xt2NFJKOeCh84sEDUAe
	 MAQIF9W5vjTpp7MMCzDd3iVWR2y2SI6cTu+QH4wDVaA9qZhsNYnjBHiMcs1dgm3gYp
	 TOaIlj27JITIV/4mMXTOhwcqMgnsd+ovaNRaYKw6SLrsCoWYleP/WsgdO4vzNUhPf5
	 xdEumhD4xXpkBFqBj5o9H1sO1NHt+NFCNi08mLsSijrAomVDTgn5R8YP4FU1L40Mqm
	 C7Yr/W1hKYdK0q6tRq9eTr8XvdsdITf5eMsImtCSCBOEwLn4qVVrx386TzS62oWpFb
	 J3vXLCn+g/HVg==
Date: Wed, 26 Jun 2024 08:50:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>, Chaitanya Kulkarni
 <chaitanyak@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>, Shai
 Malin <smalin@nvidia.com>, "malin1024@gmail.com" <malin1024@gmail.com>,
 Yoray Zack <yorayz@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Tariq
 Toukan <tariqt@nvidia.com>, mgurtovoy@nvidia.com, galshalom@nvidia.com,
 borisp@nvidia.com, ogerlitz@nvidia.com
Subject: Re: [PATCH v25 00/20] nvme-tcp receive offloads
Message-ID: <20240626085017.553f793f@kernel.org>
In-Reply-To: <253v81vpw4t.fsf@nvidia.com>
References: <20240529160053.111531-1-aaptel@nvidia.com>
	<20240530183906.4534c029@kernel.org>
	<9ed2275c-7887-4ce1-9b1d-3b51e9f47174@grimberg.me>
	<SJ1PR12MB60759C892F32A1E4F3A36CCEA5C62@SJ1PR12MB6075.namprd12.prod.outlook.com>
	<253v81vpw4t.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 18:21:54 +0300 Aurelien Aptel wrote:
> We have taken some time to review your documents and code and have had
> several internal discussions regarding the CI topic. We truly appreciate
> the benefits that a CI setup could bring. However, we believe that since
> this feature primarily relies on nvme-tcp, it might achieve better
> coverage and testing if integrated with blktest. Your design focuses on
> the netdev layer, which we don't think is sufficient.
> 
> blktests/nvme is designed to test the entire nvme upstream
> infrastructure including nvme-tcp that targets corner cases and bugs in
> on-going development.  Chaitanya, Shinichiro, Daniel and other
> developers are actively developing blktests and running these tests in
> timely manner on latest branch in linux-nvme repo and for-next branch in
> linux-block repo.
> 
> Again, we are open to provide NIC so that others can also test this
> feature on upstream kernel on our NIC to facilitate easier testing
> including distros, as long as they are testing this feature on upstream
> kernel. In this way we don't have to replicate the nvme-block storage
> stack infra/tools/tests in the framework that is focused on netdev
> development and yet achieve good coverage, what do you think?

I'm not sure we're on the same page. The ask is to run the tests on 
the netdev testing branch, at 12h cadence, and generate a simple JSON
file with results we can ingest into our reporting. Extra points to
reporting it to KCIDB. You mention "framework that is focused on
netdev", IDK what you mean.

