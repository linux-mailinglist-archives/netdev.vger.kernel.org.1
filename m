Return-Path: <netdev+bounces-54922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 340C0808EF0
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 18:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCEF32816F1
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 17:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0784A9BE;
	Thu,  7 Dec 2023 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hO5ooNVg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F12481A7
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 17:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3035C433C7;
	Thu,  7 Dec 2023 17:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701970942;
	bh=XActvnt3u4hVPQCbSWjczs0CUksp+uATv6dyECFr7ds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hO5ooNVgtmHhpxNK2pAHaJJKLA0UwCH3ibX4kDCSuEbRyjoZ5qSC7cygJUi9d+/M+
	 SkzDG3gw1QKcPt9H5zbhqdQhGboNQUmbpANZMA8WAMb/pOU6pgoTA8v9CXKYFA4jLR
	 c1k9utyZwmRhhfFehCNCQexO5GVAWtka2DJ7BphUiwYyiSGmEcWSOweJLfIRhsmxZe
	 H4DT3Rv4O9VG/Si5ASZfjcumvO/yAsNjsQmXqfgdFRHylHPd12jaZwn6WydZ6QttdN
	 hva/cZFoy+fBfirtYNBmPXzbWiSJfnHJ+6PUnba4sbmOJrH1t+mWyWxHL5M3y0X1Y2
	 5Pvzis3iLwoFA==
Date: Thu, 7 Dec 2023 09:42:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: Zhipeng Lu <alexious@zju.edu.cn>, Chris Snook <chris.snook@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Yuanjun Gong <ruc_gongyuanjun@163.com>, Jie Yang
 <jie.yang@atheros.com>, Jeff Garzik <jgarzik@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] [PATCH] ethernet: atheros: fix a memleak in
 atl1e_setup_ring_resources
Message-ID: <20231207094220.77019dd0@kernel.org>
In-Reply-To: <SJ0PR18MB52161F73B08DA547F7A8F3B8DB8BA@SJ0PR18MB5216.namprd18.prod.outlook.com>
References: <20231207143822.3358727-1-alexious@zju.edu.cn>
	<SJ0PR18MB52161F73B08DA547F7A8F3B8DB8BA@SJ0PR18MB5216.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Dec 2023 17:08:15 +0000 Suman Ghosh wrote:
> >+		kfree(tx_ring->tx_buffer);  
>
> [Suman] I think we should do tx_ring->tx_buffer = NULL also, to avoid use after free?

It's up to the driver. Some may call that defensive programming.

