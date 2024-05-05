Return-Path: <netdev+bounces-93493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035938BC17C
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 16:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE01F2816BB
	for <lists+netdev@lfdr.de>; Sun,  5 May 2024 14:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0D628DD1;
	Sun,  5 May 2024 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebmwiV7M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EC0747F
	for <netdev@vger.kernel.org>; Sun,  5 May 2024 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714920462; cv=none; b=LSialTpvDzvks0xTIOjBOvELpRfqGeCJC3CxfMaA7rsI5nDYKOiWD0+pflTDy+B0FTpwKmoZLbl6J2UKejUIUjBd8OHb01aivjaaLcme0iNX+2zEPq2dFsEcnwPj4AITwQavkyBz9iHMaST3gRqclSNDIjEKT8Kedc5ijwjHOZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714920462; c=relaxed/simple;
	bh=gpaetghSHBDBIES+gtLPJrIBnWxHcLvADq/vuzqsX0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BupNhRenMAUySNspIfGX8yg2w6TeegrVjrliZ5z3vyAG/UmFir3eP4GmaQhWLyOyKCExPNRd0a3cLqvhNmRKlXwMLsCg0HrpVU0g7sQsnkwm2GNqma7d35FesdxtE/vIdUP2DQr83VVXNU0p42drhbAdyUsvNITzuJY/pyvOyME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebmwiV7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A16CC4AF18;
	Sun,  5 May 2024 14:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714920462;
	bh=gpaetghSHBDBIES+gtLPJrIBnWxHcLvADq/vuzqsX0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ebmwiV7Md/hGJC3Hl6tm7wkIPm3aEWwP7kamnLIbEHW/1iOAOn4YoQR98vrL/Il+S
	 h7XnkPlK2krskruwCnhW3KTJn83PxhIXRUP31YSfvDNRuJEKqSXxixNWrUmuF/Roqt
	 BHW0xmlKPxpvqeVEOdwbyiNAjx2L5CwX2GJXE7LtoXf8AWjP/Db/I0NDb8i8ROkTUs
	 oBVWdgw3j0Km+5WnuVo68Gygj4smsVXR5C512KYV5ucyt5ACn4YB3vrHUMi+LwcB3u
	 NxGDFMqfTOxMsLJ5RdoDLmLQdd840r0HLellxh70METPpqaxXxngIrIGHzfN64dzLG
	 bgAaaSFeoC6xA==
Date: Sun, 5 May 2024 15:46:08 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 5/8] rtnetlink: do not depend on RTNL for many
 attributes
Message-ID: <20240505144608.GB67882@kernel.org>
References: <20240503192059.3884225-1-edumazet@google.com>
 <20240503192059.3884225-6-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503192059.3884225-6-edumazet@google.com>

On Fri, May 03, 2024 at 07:20:56PM +0000, Eric Dumazet wrote:
> Following device fields can be read locklessly
> in rtnl_fill_ifinfo() :
> 
> type, ifindex, operstate, link_mode, mtu, min_mtu, max_mtu, group,
> promiscuity, allmulti, num_tx_queues, gso_max_segs, gso_max_size,
> gro_max_size, gso_ipv4_max_size, gro_ipv4_max_size, tso_max_size,
> tso_max_segs, num_rx_queues.

Hi Eric,

* Regarding mtu, as the comment you added to sruct net_device
  some time ago mentions, mtu is written in many places.

  I'm wondering if, in particular wrt ndo_change_mtu implementations,
  if some it is appropriate to add WRITE_ONCE() annotations.

* Likewise, is it appropriate to add WRITE_ONCE() to dev_set_group() ?

