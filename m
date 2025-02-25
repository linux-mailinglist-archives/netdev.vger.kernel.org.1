Return-Path: <netdev+bounces-169288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87937A43365
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 04:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4686C3B3BA6
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 03:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E5918EFED;
	Tue, 25 Feb 2025 03:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lExKAS+i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B02718E05F;
	Tue, 25 Feb 2025 03:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740452979; cv=none; b=e0hbFUQPcT8YOVywOemtD535IIgU4AJqJUFEyhneEiozCLUzvHr/7IAA7RDXT5OuK6ZfvLUz3PzYJ8FcXd6K4dAxCbT+3QkDXcozyATCNPPM6DF2PlxWvnDOURCCKG+LigdLivJD/XXF7FpNrJ3CzvHIKEHHzozf+s9y4TZsHFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740452979; c=relaxed/simple;
	bh=kdtRcNi50xB1wE2p+xzNsZHE2d/xUjVZETvAdPb/ZQg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mqLOJF645cR4uZg5DDcVRJLOVfZq/9idQOrk7rt9NuuBWNzMwefxqm/GRqWTnb9DzrZyC2Q3gv4HMkfyc1SLq95u6biwuB9KiRDiNfvdmZf6KgNKfiDNkwW8Id/jP4IkpOrUlGFvl+Y+SuMViBqGEJcSJMjtAxbLXLCO+y7Dzno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lExKAS+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC8CC4CED6;
	Tue, 25 Feb 2025 03:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740452978;
	bh=kdtRcNi50xB1wE2p+xzNsZHE2d/xUjVZETvAdPb/ZQg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lExKAS+iMJnSDphHl5Ezijg+e86CjE4XDST84+HdxjALEP+NdIdV6hsmynbzs8vTj
	 NY60EL5rhLvwvkmRF2mQgHhr4odKM7JIbzuUe+5Dy05o8D3hfAWfP/5wyX252XxUqa
	 i2ksLwCkpg27t6NgykApU58jKH9nKWgEcvfzN3VDN65fyX/5h1rozzBXG7/qt6gFgP
	 gp8pX6joFHZ0Vftu5t8apn/Va2Mb9pxJ6z0WWuVKH/nf2nosszrLHRWQasM7fKo/Cd
	 DCsb62tAsXDUn1oK8v6xlQcW0pd5nZpLoP3xLk2BbImf1MYKVi7ZYGjQt/DeIbm99J
	 VeS3P3SCBXPlg==
Date: Mon, 24 Feb 2025 19:09:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <shenjian15@huawei.com>,
 <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
 <chenhao418@huawei.com>, <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
 <shiyongbang@huawei.com>, <libaihan@huawei.com>,
 <jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
 <salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH v3 net-next 2/6] net: hibmcge: Add support for rx
 checksum offload
Message-ID: <20250224190937.05b421d0@kernel.org>
In-Reply-To: <20250221115526.1082660-3-shaojijie@huawei.com>
References: <20250221115526.1082660-1-shaojijie@huawei.com>
	<20250221115526.1082660-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 19:55:22 +0800 Jijie Shao wrote:
> +#define HBG_SUPPORT_FEATURES (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | \

these are tx not rx

> +			     NETIF_F_RXCSUM)

I don't see you setting the checksum to anything other than NONE

