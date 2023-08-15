Return-Path: <netdev+bounces-27623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FCF77C921
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 10:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B77AC1C20C5B
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 08:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6997BBA35;
	Tue, 15 Aug 2023 08:09:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449E5AD5F
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 08:09:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32CAC433C7;
	Tue, 15 Aug 2023 08:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692086940;
	bh=lqbUawOPb6gef1kFI6LqqmLQUbvAydpSBx1GfJO78/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pW7MsH8R4/fK+2yQ6INiZioclq8jGQrOpu/KON5oiQKygxTry9B+ek77X6ow+MkfS
	 gLw+/bLTZ2NAOtitptO0aGHglZn/tNCS4hbzoorzVvnA+ij41YYExvCJdxBlsCCgEj
	 U62ZOWYZrcEamP2dUha31qwa3xyMQXVCflpnXzcW5PiXHNa5He0P7Wi+1Yl1JtlwS5
	 rsOsN/LI9y60hZdi7NZYHU4/DiSXgODv4T9OBAuXyaYyxtKIqhjFEz0JhlM3+XAVcL
	 yqgS4Ztgm1UOlZtroqKkz5Fxp2Yf+mADUX1Lvm/1glBNgFafAF4s/hxN8DDMIXvlw1
	 PkDhuKPkr+GSQ==
Date: Tue, 15 Aug 2023 10:08:56 +0200
From: Simon Horman <horms@kernel.org>
To: Ziyang Xuan <william.xuanziyang@huawei.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	idosch@idosch.org, kaber@trash.net
Subject: Re: [PATCH net] team: Fix incorrect deletion of ETH_P_8021AD
 protocol vid from slaves
Message-ID: <ZNsymO9HyhmFhDCJ@vergenet.net>
References: <20230814032301.2804971-1-william.xuanziyang@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814032301.2804971-1-william.xuanziyang@huawei.com>

On Mon, Aug 14, 2023 at 11:23:01AM +0800, Ziyang Xuan wrote:
> Similar to commit 01f4fd270870 ("bonding: Fix incorrect deletion of
> ETH_P_8021AD protocol vid from slaves"), we can trigger BUG_ON(!vlan_info)
> in unregister_vlan_dev() with the following testcase:
> 
>   # ip netns add ns1
>   # ip netns exec ns1 ip link add team1 type team
>   # ip netns exec ns1 ip link add team_slave type veth peer veth2
>   # ip netns exec ns1 ip link set team_slave master team1
>   # ip netns exec ns1 ip link add link team_slave name team_slave.10 type vlan id 10 protocol 802.1ad
>   # ip netns exec ns1 ip link add link team1 name team1.10 type vlan id 10 protocol 802.1ad
>   # ip netns exec ns1 ip link set team_slave nomaster
>   # ip netns del ns1
> 
> Add S-VLAN tag related features support to team driver. So the team driver
> will always propagate the VLAN info to its slaves.
> 
> Fixes: 8ad227ff89a7 ("net: vlan: add 802.1ad support")
> Suggested-by: Ido Schimmel <idosch@idosch.org>
> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


