Return-Path: <netdev+bounces-120405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0388959287
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 03:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EFF31C22B14
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 01:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CA0130E27;
	Wed, 21 Aug 2024 01:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+8k1KCe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE0B12C814;
	Wed, 21 Aug 2024 01:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724205311; cv=none; b=rlSUOm24nlHI2QeCWWMDr5NkwXjl7cf/WGkAHXkLTWmsac6TOTEHICBszPBpPZJLFhoMnnuqUcsqmXe3VLKDOhXcS3WeJIpJI3jggkQ10FCzyzlbjZjUO/UQvEzm+8k+qBMd9qA0l2qZZsXT6MxBA81Jn/9xNSNjAQgC4So10T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724205311; c=relaxed/simple;
	bh=xqK5MsfzBvLmIizQTEgeGza1eDu86IvEHJ9bKPOm1rY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0D67aYr7f5EPtWjhxxHf43s535ZGOEVIqwXfMhFZeFQcqzYbFRhVDCBjnt6DLhBxJ8Y0AG7+kTzzkpU0XN9Y3hHWGNgOUx6AsGcNs7EZtv2+Pv6ygbIRBjMRfTXE5Lrx0wwE6ZQkNCR87BndHRwGSu5MR/xUCszkUfl9T/ystk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+8k1KCe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BFEC4AF0B;
	Wed, 21 Aug 2024 01:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724205309;
	bh=xqK5MsfzBvLmIizQTEgeGza1eDu86IvEHJ9bKPOm1rY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P+8k1KCeGwdwTKK09PD4HX/GigWu9zW+Puzbs8C1fhHMtfa5dyG13v9+v9u4ZbqH0
	 hckf9NnouoARdk0ZslX6p5kbg0D8YacrPYZ+jWt5ysag/zGv1MxE5Nvau/8Gg873O3
	 mb4N6V3n/UFYlOpNPQ9YxOiiTVdm9fItu46vNAkGKSgazPJ1q3QINJ8HH2s1PZ0Rt1
	 /hBluAYPiM70byKXIrAwx77vFa4Qus33TunfaHtmr77gVoIBSzVKZ2i4gph1Gz7MT6
	 AetkmpSJaPpv+DC2VZP3OjiKQSsR4Qm0zEc44eIHfOQlEorEc0Am/ma8tSMK4FRd80
	 oY/JDySVH8buw==
Date: Tue, 20 Aug 2024 18:55:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
 <liuyonglong@huawei.com>, <sudongming1@huawei.com>,
 <xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
 <andrew@lunn.ch>, <jdamato@fastly.com>, <horms@kernel.org>,
 <jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
 <salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 net-next 11/11] net: add is_valid_ether_addr check in
 dev_set_mac_address
Message-ID: <20240820185507.4ee83dcc@kernel.org>
In-Reply-To: <20240820140154.137876-12-shaojijie@huawei.com>
References: <20240820140154.137876-1-shaojijie@huawei.com>
	<20240820140154.137876-12-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 22:01:54 +0800 Jijie Shao wrote:
> core need test the mac_addr not every driver need to do.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  net/core/dev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index e7260889d4cb..2e19712184bc 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -9087,6 +9087,8 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
>  		return -EOPNOTSUPP;
>  	if (sa->sa_family != dev->type)
>  		return -EINVAL;
> +	if (!is_valid_ether_addr(sa->sa_data))
> +		return -EADDRNOTAVAIL;

not every netdev is for an Ethernet device

