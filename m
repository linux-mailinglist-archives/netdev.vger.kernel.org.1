Return-Path: <netdev+bounces-141758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 802E29BC2F7
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 03:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E6B282BC3
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 02:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFEB2C190;
	Tue,  5 Nov 2024 02:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lj1rDYf+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B039418EB0;
	Tue,  5 Nov 2024 02:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730772612; cv=none; b=PncwZIC6OIcr5E/YmWwQ6KB4hpAJ6a1BAO1RPNqEoFY+AEwdYqPyuNWBuHOnb9AySaUqBoJIvAXBiRDrjzCtXoLUHxmJV7NsAW8f5Py3WOgfgXUMaQxqg4cxI2wJnIBDqMa/wUiNa+qZy5gAeDhqMNsTgqwlqjpXP/BNYrozEj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730772612; c=relaxed/simple;
	bh=S7Q8fgYdR5fmpu1jYGa1OhNRIdnVnHYg4/NuG030vkg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ff21BzbOaOXEl+BzfLuv1Ds8HareOFZ/Rl0QqrPGeti2RowfwJ9Z/uondWcjkpzLZqSKDXQFv+eq9eRHwnyOn56KKWPWNd8v6wt9WSLfx2FTtRLHyr71SwnBBjyT/2arsmt8aBxlv1o723mQX/uJdANIwIxsbJaaL5MhrX0qiEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lj1rDYf+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3B3C4CECE;
	Tue,  5 Nov 2024 02:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730772612;
	bh=S7Q8fgYdR5fmpu1jYGa1OhNRIdnVnHYg4/NuG030vkg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lj1rDYf+G7Y4lI2IMztFj6WZG3ZGyini0h4p3QvUzMuSOCRiGmn6Goq3xgzZoWoaM
	 Lk7FFF0AqZ50qVuR9Hxg46NLvGhy9xvWDgM4GRZVYsVdoiIAxvgSGaedm+gsUguBC/
	 eNAOx5UCB9VwogoD1U/dEJWqgtMGTEjkrBLT0FUG9vzJpN339l2MmwhAJlAkGlmi1r
	 5udxnWQg7o8AH9D6mbor4BbbUgUEHk6E6+YdT4pclGAVIxhN9qxUh+BuS3mqZpzYr6
	 48oG46k81e7TXnwpGiU0UwaUb2/7nNG0NQ3uQLPZRthhl2DGRCftGmxKbCoA0r/xWO
	 aPwrJLYSUSBHw==
Date: Mon, 4 Nov 2024 18:10:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Jian Shen <shenjian15@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>, Arnd Bergmann <arnd@arndb.de>, Will
 Deacon <will@kernel.org>, Joerg Roedel <jroedel@suse.de>,
 iommu@lists.linux.dev, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Jijie Shao <shaojijie@huawei.com>, Peiyang Wang
 <wangpeiyang1@huawei.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [net-next] net: hns3: add IOMMU_SUPPORT dependency
Message-ID: <20241104181010.3d1a53f1@kernel.org>
In-Reply-To: <069c9838-b781-4012-934a-d2626fa78212@arm.com>
References: <20241104082129.3142694-1-arnd@kernel.org>
	<069c9838-b781-4012-934a-d2626fa78212@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Nov 2024 10:29:28 +0000 Robin Murphy wrote:
> WTF is that patch doing!? No, random device drivers should absolutely 
> not be poking into IOMMU driver internals, this is egregiously wrong and 
> the correct action is to drop it entirely.

Sorry, reverted in
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=249cfa318fb1b77eb726c2ff4f74c9685f04e568

