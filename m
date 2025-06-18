Return-Path: <netdev+bounces-198890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BEFADE2C8
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 06:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5058D7A32D7
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 04:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2931DE2A7;
	Wed, 18 Jun 2025 04:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lnMT4wNg"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901371A23AF
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 04:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750222416; cv=none; b=ChvGwKAFa0ACCrcyhOOki8/+v6V9E89fkcH40zB1pOodl7Knntv9+UxcfYL/shzhgeZGdVmjmuQtlH0aFo5Zb6sTEGsDX94bKdcAL/vlvN43pUL5tyaCDmEGC/LAshaGYhniVK2rQzKa+JFowMCIZ1nQvt1h+PhYk4fc/lQTYLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750222416; c=relaxed/simple;
	bh=zO/QWeCuvhA7ohivgbuHPzwD6QjGZ9IN22QBznmeZfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c1nBCVWbJUvbCwW8QSgDCXelGK7W8a5SoCaunEvftYCcZ3CEAbfMhxScekF1LG7adpkaboN/5sqqNdahQzQTEZ9KA9npqNPX4hjBrrzzouXzSPczeSs66VwNGmGu+6rtShcB7I489WGRgdWLXAhbgqz72jGb/OeyJUNSdmW0tGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lnMT4wNg; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <80df50e4-a215-4d19-801d-f1d24b91af1c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750222412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dH6u3GOQfFu1T5AIDUtZg/PlqJv3Ej6CGixoT3h+h4Y=;
	b=lnMT4wNgiqDW+FHUxvsVuSwsxthB+v7vNd5uwP2XinVbKpswtd1MsN3ZPdO3P5K6WYoc3f
	63W3ZsLx9rOQBpYK1Z7gYN9FwIYS0uKiCWCOgU3uwwuPPjU8oU58t4cjjOdEa23c6n1QLJ
	bv1aXP44w5adctq1aC9RNnAmhXSj1Ns=
Date: Tue, 17 Jun 2025 21:53:18 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next 0/2] Add multiple priorities support to mlx5
 RDMA TRANSPORT tables
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
 Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Patrisious Haddad <phaddad@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
References: <cover.1750148083.git.leon@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <cover.1750148083.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/6/17 1:19, Leon Romanovsky 写道:
> Hi,
> 
> This short series from Patrisious extends mlx5 flow steering logic to
> allow creation rule creation with priorities in RDMA TRANSPORT tables.
         ^^^^^^^^
This "creation" should be removed?

Yanjun.Zhu

> 
> Thanks
> 
> Patrisious Haddad (2):
>    net/mlx5: fs, add multiple prios to RDMA TRANSPORT steering domain
>    RDMA/mlx5: Add multiple priorities support to RDMA TRANSPORT userspace
>      tables
> 
>   drivers/infiniband/hw/mlx5/fs.c               | 40 ++++++++++++-------
>   drivers/infiniband/hw/mlx5/fs.h               |  8 +++-
>   drivers/infiniband/hw/mlx5/mlx5_ib.h          |  4 +-
>   .../net/ethernet/mellanox/mlx5/core/fs_core.c | 30 ++++++++++----
>   include/linux/mlx5/fs.h                       |  2 +-
>   5 files changed, 56 insertions(+), 28 deletions(-)
> 


