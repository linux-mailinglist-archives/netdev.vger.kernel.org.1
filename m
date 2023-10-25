Return-Path: <netdev+bounces-44054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AD27D5F03
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 02:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01DD2B20F61
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 00:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549A2199;
	Wed, 25 Oct 2023 00:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjxOhjtw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FD3197
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 00:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25CEFC433C7;
	Wed, 25 Oct 2023 00:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698193312;
	bh=bSb6lFJWhOO+xj/NDMEeOkBFoXydyY6bxf7XMv2ArVg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NjxOhjtwoKdQ3UgCoeY/58mRDR40YFwMjdJFTvXp8v3ZwzkpUSTo3371ZEgcQ/MD3
	 g7fVYkajpSDQK9il3+2Lv3bO6Bc5iNUZs/joAZY/06zhS/nXgqb2vHQBhbCPRFhjsi
	 BYNPM6nexCdjqmwlTY7cgBU2h9SzEu6MwpHfpmR0/T2HMGRpzUQnsw0NQhxaBnnN7L
	 2xq/yXV+N35C6I7d6ZwT3Od/hqLfZRB1Sum41gCz8uN6o5ZpuOF1xthJVkOmhObt2/
	 XaEhON5dyV4l9JSxY97k0wrGNZdnvsak4F8KCa4AsR6IrX5jrJjmiTVgoG8NQwdzgz
	 a+mUugyhSxphA==
Date: Tue, 24 Oct 2023 17:21:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
 <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
 <davem@davemloft.net>, <wizhao@redhat.com>, <konguyen@redhat.com>,
 "Veerasenareddy Burru" <vburru@marvell.com>, Sathesh Edara
 <sedara@marvell.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 3/4] octeon_ep: implement xmit_more in
 transmit
Message-ID: <20231024172151.5fd1b29a@kernel.org>
In-Reply-To: <20231024145119.2366588-4-srasheed@marvell.com>
References: <20231024145119.2366588-1-srasheed@marvell.com>
	<20231024145119.2366588-4-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Oct 2023 07:51:18 -0700 Shinas Rasheed wrote:
>  	iq->host_write_index = wi;
> +	if (xmit_more &&
> +	    (atomic_read(&iq->instr_pending) <
> +	     (iq->max_count - OCTEP_WAKE_QUEUE_THRESHOLD)) &&
> +	    iq->fill_cnt < iq->fill_threshold)
> +		return NETDEV_TX_OK;

Does this guarantee that a full-sized skb can be accommodated?
If so - consider stopping stopping the queue when the condition
is not true. The recommended way of implementing 'driver flow control'
is to stop the queue once next packet may not fit, and then use
netif_xmit_stopped() when deciding whether we need to flush or we can
trust xmit_more. see 
https://www.kernel.org/doc/html/next/networking/driver.html#transmit-path-guidelines

>  	/* Flush the hw descriptor before writing to doorbell */
>  	wmb();
> -
> -	/* Ring Doorbell to notify the NIC there is a new packet */
> -	writel(1, iq->doorbell_reg);
> -	iq->stats.instr_posted++;
> +	/* Ring Doorbell to notify the NIC of new packets */
> +	writel(iq->fill_cnt, iq->doorbell_reg);
> +	iq->stats.instr_posted += iq->fill_cnt;
> +	iq->fill_cnt = 0;
>  	return NETDEV_TX_OK;

