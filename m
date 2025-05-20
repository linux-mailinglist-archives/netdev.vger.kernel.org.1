Return-Path: <netdev+bounces-191716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36375ABCDB0
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 05:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF65B8A08D2
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 03:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F53257429;
	Tue, 20 May 2025 03:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHcFmAlk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22841C3306;
	Tue, 20 May 2025 03:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747710822; cv=none; b=HRPu9Y92m925FwIrNYZ9IJ7MUS0vu8MROu+Khy7abmo30pWt4MOsnHrdzHw82Y+S3aSus7rfL8fssyqg/GTE1UnNO3IemFSkXa899RBIWpaMXMEbCRFyfPe30s0xgT4R0RDg7XC8vnf3hnmjclvA1SieQ8Rl5cYgXhDgJlZpatM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747710822; c=relaxed/simple;
	bh=8Cobphk6r51dMXzBM8pd1XqlT8rwpbR5fZWejWw6pLM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WWKx0DIgqWdrWd9+NfaJfriyYdgcc0s1MQCkx1a8ifL/9bLvNT+e5GmQFgwiWssYz61c54VwqV/d3XoY1DPAdqSPTsB9xgwJTpDY4qNKzhM0EwZddKaqRKBOcD7S6pWN5y8G3PgycGsnCVD6rtDvvOf2+USASbjXFKCBkRqR24Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHcFmAlk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0AD1C4CEE4;
	Tue, 20 May 2025 03:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747710821;
	bh=8Cobphk6r51dMXzBM8pd1XqlT8rwpbR5fZWejWw6pLM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uHcFmAlkKZJaM1T9E73QGGBke82b49ji5/nRcOy+4+K8neCJCI+KySzTysDS3T455
	 P7TLHf0kSvoHdw55RgJjGVoDAdql7BjGLnmO9um9ahTvmGtCuyahFXPmdaU+ZUG8sN
	 EHgH9silMhnY84C0GZA86n2k0oE5rSxIms5WSkGKm9SvwgVAkXwOWreluj/azxmDHy
	 nVa4bC+YG/KSxZLkdEEDmyV/sxH9CLnDO2lvKvgIjmbNXbJxjjUT9W2tR0MgcCdKsk
	 U+DZgXNKVvKempkMPX0kG28ckWFDNbRvt6I1S5WJic8gnNUAv1AkFyuYHKLpOWXlLf
	 K2Yv9wv1O0z4g==
Date: Mon, 19 May 2025 20:13:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Gur Stavi <gur.stavi@huawei.com>
Cc: Fan Gong <gongfan1@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn
 Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
 <guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
 <shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>, Lee Trager
 <lee@trager.us>, Michael Ellerman <mpe@ellerman.id.au>, Suman Ghosh
 <sumang@marvell.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, Joe
 Damato <jdamato@fastly.com>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH net-next v16 1/1] hinic3: module initialization and
 tx/rx logic
Message-ID: <20250519201340.4eda0aae@kernel.org>
In-Reply-To: <507a27deb49315dd98192b13414dade82fe12622.1747640393.git.gur.stavi@huawei.com>
References: <cover.1747640393.git.gur.stavi@huawei.com>
	<507a27deb49315dd98192b13414dade82fe12622.1747640393.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 May 2025 12:19:28 +0300 Gur Stavi wrote:
> +	if (unlikely(hinic3_wq_free_wqebbs(&txq->sq->wq) < wqebb_cnt)) {
> +		if (likely(wqebb_cnt > txq->tx_stop_thrs))
> +			txq->tx_stop_thrs = min(wqebb_cnt, txq->tx_start_thrs);
> +
> +		netif_subqueue_try_stop(netdev, tx_q->sq->q_id,
> +					hinic3_wq_free_wqebbs(&tx_q->sq->wq),
> +					tx_q->tx_start_thrs);
> +
> +		return -NETDEV_TX_BUSY;

Why flip the value to negative here?
Should be just:

		return NETDEV_TX_BUSY;

right?

The rest looks good.
-- 
pw-bot: cr

