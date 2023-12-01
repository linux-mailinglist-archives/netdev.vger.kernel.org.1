Return-Path: <netdev+bounces-52809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D7D800430
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 07:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71441B20E6D
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 06:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B68A11700;
	Fri,  1 Dec 2023 06:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pc0kazKs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202613D75
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 06:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93EFC433CA;
	Fri,  1 Dec 2023 06:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701413726;
	bh=rvlUpmCWet3DQSETpKuQuIH6X2X3rucwyaSzL3cBqiA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pc0kazKsvlCfPs4Z3xYAx0puK+inFDLkK4qFrkNh8zKe4t1UwmC8qYzYiWmHRUPHJ
	 lcOj9w/9965gZb+M30Y1vBvNU6rkgVBW2tWol+SKtsndToHXvY1LL79b/XeZlWVird
	 HZ2kQbcUuscBK38s/3Vd3Z0lD9d8caViEk02OudksTno6ezB//2npADfKRHfA4w9Kz
	 jqKTO4NWB5faullFHz+7PG8dUi91obE6Mlv4L5GYCm5dYuICUeUov9ll9L3GRLjSn4
	 HyRxjgh3gKM3QWOitiqCLDCLF+Ro9XzjqmDHH5G18pQXJ7Qi6wDn+01NMhT+EDARgp
	 XWdqR+sSu+/ig==
Date: Thu, 30 Nov 2023 22:55:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Michal Kubiak <michal.kubiak@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>, Alexander Duyck
 <alexanderduyck@fb.com>, Yunsheng Lin <linyunsheng@huawei.com>, "David
 Christensen" <drc@linux.vnet.ibm.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Paul
 Menzel" <pmenzel@molgen.mpg.de>, <netdev@vger.kernel.org>,
 <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 13/14] libie: add per-queue Page Pool stats
Message-ID: <20231130225524.76d41381@kernel.org>
In-Reply-To: <289bf666-b985-4dc4-bf0a-16b1ae072757@intel.com>
References: <20231124154732.1623518-1-aleksander.lobakin@intel.com>
	<20231124154732.1623518-14-aleksander.lobakin@intel.com>
	<e43fc483-3d9c-4ca0-a976-f89226266112@intel.com>
	<20231129062914.0f895d1c@kernel.org>
	<f01e7e91-08f1-4548-8e73-aa931d5b4834@intel.com>
	<289bf666-b985-4dc4-bf0a-16b1ae072757@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Nov 2023 17:45:10 +0100 Alexander Lobakin wrote:
> > Meh, this way the stats won't survive ifdown/ifup cycles as usually
> > page_pools get destroyed on ifdown :z
> > In that patch, I backup the PP stats to a device-lifetime container when
> > the pool gets destroyed, maybe we could do something similar?  
> 
> I still can pull the PP stats to the driver before destroying it, but
> there's no way to tell the PP I have some archived stats for it. Maybe
> we could have page_pool_params_slow::get_stats() or smth like this?

Why do you think the historic values matter?
User space monitoring will care about incremental values.
It's not like for page pool we need to match the Rx packet count.

