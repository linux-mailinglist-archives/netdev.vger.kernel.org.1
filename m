Return-Path: <netdev+bounces-107059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FCA9198CD
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 22:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8337F1F21F83
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 20:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2826B19147D;
	Wed, 26 Jun 2024 20:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArW/+NlH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0408718FC9C
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 20:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719432864; cv=none; b=EUui57QeqRX+eMkwf4X4fxfw8EK7FgsXDRk3HxL3q3sbDy8LzUBOWrjdbHc5DadbUX8DrjieP9G6ifbQ7uf+Lis61wtL88iHp15VrgP9AlZEMrvCxVJGVYWd0etS8muN4mIpt8FUX3fkEa8zezAuaCdbFieCLqkYgjEZgyBPpAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719432864; c=relaxed/simple;
	bh=CMAaGZ+AZHbMdAhaJIFZn5YNhfegdNBmB1wWg2nw8vs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jixF7phelavpr6366p7KICf5ccGgdHAS4OFRpPmDbBp5o5RgmM0cufisVxcn/QZAE5agzAyCFzvOWp8pXdrUfAKPNn7aGqEqL8NGPAG/tcPi4sb4ISICfCmw1Qup/A+M1UvlzDMd+S2RfD32U0IE5FIo4oY7ArMjH3OxYcXwRr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArW/+NlH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E605FC116B1;
	Wed, 26 Jun 2024 20:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719432863;
	bh=CMAaGZ+AZHbMdAhaJIFZn5YNhfegdNBmB1wWg2nw8vs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ArW/+NlHnuZ3Do1CbYyRZbIjNh2yRnRRsMPT+uEzUCdw5soSdlwfh2Ogj8wRLjQlY
	 SnZZ4YvqkLuyrYkqIxDHFy6kZrTeBBuKcAn4mm0mP1rhOw5eUIvo10IU1LPmM6w0nt
	 hc+flhKHm0/5g5osGG2ulEQMb9XZ+i/vUc/9hWVWypp3GIs4ZaletnHXK7WVuOsyL/
	 2+kxdXEFPznMZU7OwWYWl/LqtEQBqaFI5laiEvMfJqJA+nHOa5QlShc+eVD6SwM5IO
	 eXvwhfErvu1uS3RfLxrkTplSK9WUOqRir6hRHwjhA13sP4cd8IPx/FShktdMVDqduR
	 Q7baKX1XcITRw==
Date: Wed, 26 Jun 2024 13:14:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>, "davem@davemloft.net"
 <davem@davemloft.net>, Shai Malin <smalin@nvidia.com>,
 "malin1024@gmail.com" <malin1024@gmail.com>, Yoray Zack
 <yorayz@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, Gal Shalom
 <galshalom@nvidia.com>, Boris Pismenny <borisp@nvidia.com>, Or Gerlitz
 <ogerlitz@nvidia.com>, Aurelien Aptel <aaptel@nvidia.com>
Subject: Re: [PATCH v25 00/20] nvme-tcp receive offloads
Message-ID: <20240626131422.1d39738c@kernel.org>
In-Reply-To: <475934b5-4e41-44c9-92c7-50ad04fa70d6@nvidia.com>
References: <20240529160053.111531-1-aaptel@nvidia.com>
	<20240530183906.4534c029@kernel.org>
	<9ed2275c-7887-4ce1-9b1d-3b51e9f47174@grimberg.me>
	<SJ1PR12MB60759C892F32A1E4F3A36CCEA5C62@SJ1PR12MB6075.namprd12.prod.outlook.com>
	<253v81vpw4t.fsf@nvidia.com>
	<20240626085017.553f793f@kernel.org>
	<d23e80c9-1109-4c1a-b013-552986892d40@nvidia.com>
	<20240626124301.38bfa047@kernel.org>
	<475934b5-4e41-44c9-92c7-50ad04fa70d6@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 20:10:41 +0000 Chaitanya Kulkarni wrote:
> My other question is how can we make progress on getting this
> code merge ? (assuming that we do all the above, but it will take some time
> to build the infra) IOW, can we get this code merge before we build above
> infrastructure ?
> 
> If we can, which repo it should go through ? nvme or netdev ?

Let's wait for the testing.

