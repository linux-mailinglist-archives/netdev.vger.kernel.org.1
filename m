Return-Path: <netdev+bounces-219402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1B5B411F1
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 03:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDF1254819A
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381671DE3DC;
	Wed,  3 Sep 2025 01:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhp2yrNO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB1B1A23A9;
	Wed,  3 Sep 2025 01:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756863003; cv=none; b=XtG4LwsyQutxlRvVVrJwGzUgHfNDQm4S1HlWThkZAlh8xaJcYBruHJwMfrp2HzquvaD8YHJMzrBrm6v1FyA1Bgg0dO4O/tikNqPAf6rlRCWD49eqYeaEXjRWHmZQSjhZly85xn5p0YWPqW1GlzfRI5VQv52Np26k5HAtc+d08/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756863003; c=relaxed/simple;
	bh=mHq4+TZpEUvDqXkaL+VlRTib07rbFwudFeM+8pSuYdU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jWBBrNHgLsBrbKF+676jUnR27yFrzXj2W72tRHrgruz/zvf+CJ8fgAnR+ma1p/bzOZQQb9j+vL5TiJ5RCed4aXe5jRNwpKB1aU8O1CgPYZ90tyVX5xLJByf5XXIkdF6UmZD1Rb6OXosvlcOcfkMcpxTqb7tMEPoA9ypqeVEDwY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhp2yrNO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D43FC4CEED;
	Wed,  3 Sep 2025 01:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756863002;
	bh=mHq4+TZpEUvDqXkaL+VlRTib07rbFwudFeM+8pSuYdU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dhp2yrNOBeNOGYsohmgNzxVk+BJ1aqegAuXR31AMyTUBcA5LL7cBiODCpESA2JcBu
	 LJUGaQiUO/iGadgs+5b3zBUZHyqCN0u5WSW1JVJq8ekqSWMY9gBWyaRHU+cSgo3SMJ
	 EisN35RseOg777iBn/BRjUNXNyvyAB64hF62iI8e5q5iKuiUnf9fk+sVA/Beyt79sA
	 0S+qVIaSwY48YLkUWxbWLWz/S5XF1ZoETTkATLrfazAlxFltFw73CFdJiBMVsDs9GA
	 CMNXUHTHljt5rOJMqEyOwfy1ZLEwxAaOlmFLAMnR27l8QIxQ29d1YebYpDqy8SflxG
	 n4lo+Ja4s8s2w==
Date: Tue, 2 Sep 2025 18:30:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn
 Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
 <guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
 <shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi
 <gur.stavi@huawei.com>, Lee Trager <lee@trager.us>, Michael Ellerman
 <mpe@ellerman.id.au>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, Suman
 Ghosh <sumang@marvell.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Joe Damato <jdamato@fastly.com>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH net-next v03 12/14] hinic3: Add port management
Message-ID: <20250902183000.391e3254@kernel.org>
In-Reply-To: <0bcb99173702910b1ab901d455ea5ef3aa5c786a.1756524443.git.zhuyikai1@h-partners.com>
References: <cover.1756524443.git.zhuyikai1@h-partners.com>
	<0bcb99173702910b1ab901d455ea5ef3aa5c786a.1756524443.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Aug 2025 16:08:51 +0800 Fan Gong wrote:
> +	netif_set_real_num_tx_queues(netdev, nic_dev->q_params.num_qps);
> +	netif_set_real_num_rx_queues(netdev, nic_dev->q_params.num_qps);
> +	netif_tx_start_all_queues(netdev);

Use netif_set_real_num_queues() to set both Rx and Tx.
These functions may return an error.
-- 
pw-bot: cr

