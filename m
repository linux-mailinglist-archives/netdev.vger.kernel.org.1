Return-Path: <netdev+bounces-203109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8ECAF086D
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 04:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FBAC1C05552
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 02:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D0819DF61;
	Wed,  2 Jul 2025 02:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/16/xLp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBF72770B;
	Wed,  2 Jul 2025 02:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751422900; cv=none; b=OK3LnJ0KsLermM3sV0MzyFGl1nXn+mva4cIxyLJ3BWC7JM7tM8zw6HfTy9xVvvXHIbpJv12R548OHnsTG0E3pzO6TTtQM9oKtYVkW/iaKclbKekg098EF9XRNY68KSbIXsbLQHOZDIEsEGsyazNkj+Xj9cxqbXqSldBMnEu5vXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751422900; c=relaxed/simple;
	bh=AI6ZA8/z6d+W8idBcQV0gfAup8r+MbXTAhgilOV0igY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G/Eu2OhT9UGJzLBSuRHxp6NRR7YqBAiOsalOG2ShakSRZlMDbhZC7ay/iVUtJnWAecevpAjIPBEiWs1st0T5l4CaQXms9E/xwZy9Ue0y8cikwP5TIPs2SUIfOA/0yKeARmUnLiUYGeU04fhXFnjO1vpnF6enmtngRIf4jVHNuXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/16/xLp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57453C4CEEB;
	Wed,  2 Jul 2025 02:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751422897;
	bh=AI6ZA8/z6d+W8idBcQV0gfAup8r+MbXTAhgilOV0igY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J/16/xLpFQ54gDTmFsiwViy7hKYXNFvOSg39FygcpPvv/b1B8BdW29VNREDVRfa+w
	 Sq2REbJVfVRjdxyc+2Wpzm3ZjBbpiJb9cbV2ixKSjCH4KtRp62k6r0x0bNCa8scrfO
	 28Vw5PYDuNftQCWyAvgOe28iT08bZNQ9BadrSHAqqnZmG1mw29Fd9tjCG85oCXVgzW
	 x8XBZcMh34xnzTkPBQEtpkZSEt8/w2EW9I0tWLS5qRMNQum4t8+9KWX2Pdlmrq0ZSy
	 0UcyJBC3DPS/nP8Msm47+m0OSMPbuiBBQmj1jhSl+53zdfMqTWswJQvLfcIAGhYIr1
	 QwItrUQdqcqNA==
Date: Tue, 1 Jul 2025 19:21:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, Eelco Chaudron <echaudro@redhat.com>, Aaron
 Conole <aconole@redhat.com>
Subject: Re: [PATCH net-next] net: openvswitch: allow providing upcall pid
 for the 'execute' command
Message-ID: <20250701192136.6b8f9569@kernel.org>
In-Reply-To: <20250627220219.1504221-1-i.maximets@ovn.org>
References: <20250627220219.1504221-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Jun 2025 00:01:33 +0200 Ilya Maximets wrote:
> @@ -616,6 +618,7 @@ static int ovs_packet_cmd_execute(struct sk_buff *skb, struct genl_info *info)
>  	struct sw_flow_actions *sf_acts;
>  	struct datapath *dp;
>  	struct vport *input_vport;
> +	u32 upcall_pid = 0;
>  	u16 mru = 0;
>  	u64 hash;
>  	int len;
> @@ -651,6 +654,10 @@ static int ovs_packet_cmd_execute(struct sk_buff *skb, struct genl_info *info)
>  			       !!(hash & OVS_PACKET_HASH_L4_BIT));
>  	}
>  
> +	if (a[OVS_PACKET_ATTR_UPCALL_PID])
> +		upcall_pid = nla_get_u32(a[OVS_PACKET_ATTR_UPCALL_PID]);
> +	OVS_CB(packet)->upcall_pid = upcall_pid;

sorry for a late nit:

	OVS_CB(packet)->upcall_pid =
		nla_get_u32_default(a[OVS_PACKET_ATTR_UPCALL_PID], 0);

?

