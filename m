Return-Path: <netdev+bounces-82943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 025B1890478
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 17:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9507E1F21DCE
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 16:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C1212DDAC;
	Thu, 28 Mar 2024 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4RGhuJ5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DD081AC8
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711641856; cv=none; b=YPWqHzsF5O3H7qK9cmBsAvul9Fl/eN8HpC0doB9JNrHoAlAmmBZubQe7GgDsSi/dlzfWkimSXB1ae604QTGe37uoEM6d1JBtK1h1yWlELmHSrNwLLaFylOEdV3XcyNHIQOwjIJoBmkedvHSgVePie0zu41Q+t+LIeks6Ni8sK54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711641856; c=relaxed/simple;
	bh=KK2v1418WypJheLGoKpRArY2cxHxE+8oYPik6mgxvOA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SfKcpuRcEM54WSHjyGY8clSPeNFpzuKZA30NosfDd2vEjzh27WKyxx/hqI1QZImvCigAUszilI0pjhj6FwFWRFVAOKjAQiMzlJBEWA6a3DlHyK+s3rcZ+V8ZFcL+5YUNiLM4e6LNwjv8KYHjt/OXMLumkbC9tiComMq11igGidE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4RGhuJ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040B6C433F1;
	Thu, 28 Mar 2024 16:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711641856;
	bh=KK2v1418WypJheLGoKpRArY2cxHxE+8oYPik6mgxvOA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m4RGhuJ5+tB5O0WnEURm52VlT1uZlUVhQ0ZbtdYEWj91dbv2UXmhwIe6Qm3tapx03
	 18+emVjrVQI0Bh65tslmKhGbCR0G/PlKe9+w2YeJhjp1EjXUZCmvnUqSGKTM4lbMHD
	 XOud7zWUCKQqNAe1uni+7Ter2XCrBTw8YuQaSX5h7f3wlqQZEMS5mX3X8+YhOT/6mJ
	 s7mPxokTUyXK9RqllGktY5fHrI9iFPjwKU4NPCnebQ63VJsdiW/1h/hHeDPMEeMpyl
	 0aolY21QIeG/X9v/lf+AiC7uvn9xMNDIHI7T4MhORY6+KcMRUyFC+ayjjv3vDPRwd8
	 QtmOaj2zpgBaw==
Date: Thu, 28 Mar 2024 09:04:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Donald
 Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jacob
 Keller <jacob.e.keller@intel.com>, Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH net-next 2/2] ynl: support un-nest sub-type for
 indexed-array
Message-ID: <20240328090415.3a6a7fb9@kernel.org>
In-Reply-To: <ZgUfQTtEjkFDwCX9@Laptop-X1>
References: <20240326063728.2369353-1-liuhangbin@gmail.com>
	<20240326063728.2369353-3-liuhangbin@gmail.com>
	<ZgUfQTtEjkFDwCX9@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Mar 2024 15:41:53 +0800 Hangbin Liu wrote:
> >  # ip link add bond0 type bond mode 1 \
> >    arp_ip_target 192.168.1.1,192.168.1.2 ns_ip6_target 2001::1,2001::2
> >  # ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/rt_link.yaml \
> >    --do getlink --json '{"ifname": "bond0"}' --output-json | jq '.linkinfo'
> > 
> >     "arp-ip-target": [
> >       {
> >         "1": "192.168.1.1"
> >       },
> >       {
> >         "2": "192.168.1.2"
> >       }
> >     ],  
> 
> For index array, do you think if we need to add the index in the result
> like upper example? Or we just omit the index and show it like:

Yes, the index in some funny dumps can actually be non-contiguous.
You should use the value from the attr, like the nest does.

