Return-Path: <netdev+bounces-246041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53769CDD629
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 07:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0C803011740
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 06:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9D923F42D;
	Thu, 25 Dec 2025 06:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucloud.cn header.i=@ucloud.cn header.b="OPbvJ352"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m15599.qiye.163.com (mail-m15599.qiye.163.com [101.71.155.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB0B1DED4C
	for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 06:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766644761; cv=none; b=VSOHZM6tCqynKbz5p2agWRtvGzq5S4kaMOSghCY4jDU0Vlpr8BGURSwrhY3dgvW/TrNGCWmkfi5f9XhD+J+hxJpCyR/4y/7V2JeGW7Bby7lmlOpCB8FSbVsByq7sHBmZLNpJkticKkPzllU8/NBWIT4Jn0mPjrHsv/6q3DJAihw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766644761; c=relaxed/simple;
	bh=yueAwh9XaDE782GLpxjmrE3RplviqBCvyr0erJ+ZcXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6SfWCOKQT1sP1OsbW5+13ls/vANWOpHuKQAKNVNtgciGXTe3pjmCMI4xb/x8bfL7auj7x0DvM+H8FXGLEKkY3D8RigRnzWqDU1YbK8355rnC8/g0yRS/yEOOsWJudjvsIARIMIvk1ZagssX8T27z3+3wHbg3EY7kL/49R0kQJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucloud.cn; spf=pass smtp.mailfrom=ucloud.cn; dkim=pass (1024-bit key) header.d=ucloud.cn header.i=@ucloud.cn header.b=OPbvJ352; arc=none smtp.client-ip=101.71.155.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucloud.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucloud.cn
Received: from localhost (unknown [106.75.220.2])
	by smtp.qiye.163.com (Hmail) with ESMTP id 14c86e535;
	Thu, 25 Dec 2025 14:39:08 +0800 (GMT+08:00)
Date: Thu, 25 Dec 2025 14:39:08 +0800
From: "yuan.gao" <yuan.gao@ucloud.cn>
To: Ido Schimmel <idosch@idosch.org>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	segoon@openwall.com, netdev@vger.kernel.org
Subject: Re: [PATCH] inet: ping: Fix icmp out counting
Message-ID: <20251225063908.bumdfwiq7hz4ebeq@yuangap>
References: <20251224063145.3615282-1-yuan.gao@ucloud.cn>
 <aUwQDxibc1lw9mrG@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUwQDxibc1lw9mrG@shredder>
X-HM-Tid: 0a9b543b90a30229kunmaa9f5462100ca6
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGEsaVhhLGUpDTUMaSEIdSFYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlKS01VTE5VSUlLVUlZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
DKIM-Signature: a=rsa-sha256;
	b=OPbvJ352dePfmyCEjaeKBn0WoZ3A34KqZlpfUMjOBMfMdYf9laWPWC1oDo4CkEPhyN49TjFLHGt2AIFCW7Ba2AfPwFrtMsnJI+6qFNKshRs+oqJ46FMdL2J2koJ/134/TMArM0gJ7RfG36LQ1bwn+katuzjnA1RK5M6QKxEeQkY=; c=relaxed/relaxed; s=default; d=ucloud.cn; v=1;
	bh=4p5feBfEb0/YlZVdKdUJVGkpm9UV/9+RWWE1Nbsrl4M=;
	h=date:mime-version:subject:message-id:from;

On Wed, Dec 24, 2025 at 06:08:47PM +0200, Ido Schimmel wrote:
> Next time, please tag the patch as [PATCH net]. See:
> 
> https://docs.kernel.org/process/maintainer-netdev.html
> 
> On Wed, Dec 24, 2025 at 02:31:45PM +0800, yuan.gao@ucloud.cn wrote:
> > From: "yuan.gao" <yuan.gao@ucloud.cn>
> > 
> > When the ping program uses an IPPROTO_ICMP socket to send ICMP_ECHO
> > messages, ICMP_MIB_OUTMSGS is counted twice.
> > 
> >     ping_v4_sendmsg
> >       ping_v4_push_pending_frames
> >         ip_push_pending_frames
> >           ip_finish_skb
> >             __ip_make_skb
> >               icmp_out_count(net, icmp_type); // first count
> >       icmp_out_count(sock_net(sk), user_icmph.type); // second count
> > 
> > However, when the ping program uses an IPPROTO_RAW socket,
> > ICMP_MIB_OUTMSGS is counted correctly only once.
> > 
> > Therefore, the first count should be removed.
> 
> Looks correct.
> 
> Before:
> 
> # sysctl -wq net.ipv4.ping_group_range="0 4294967294"
> # nstat -z -j | jq '.[]["IcmpOutEchos"]'
> 0
> # ping -c1 127.0.0.1 &> /dev/null
> # nstat -z -j | jq '.[]["IcmpOutEchos"]'
> 2
> 
> After:
> 
> # sysctl -wq net.ipv4.ping_group_range="0 4294967294"
> # nstat -z -j | jq '.[]["IcmpOutEchos"]'
> 0
> # ping -c1 127.0.0.1 &> /dev/null
> # nstat -z -j | jq '.[]["IcmpOutEchos"]'
> 1
> 
> And it's consistent with IPv6:
> 
> # sysctl -wq net.ipv4.ping_group_range="0 4294967294"
> # nstat -z -j | jq '.[]["Icmp6OutEchos"]'
> 0
> # ping -c1 ::1 &> /dev/null
> # nstat -z -j | jq '.[]["Icmp6OutEchos"]'
> 1
> 
> > 
> > Fixes: c319b4d76b9e ("net: ipv4: add IPPROTO_ICMP socket kind")
> > Signed-off-by: yuan.gao <yuan.gao@ucloud.cn>
> 
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Tested-by: Ido Schimmel <idosch@nvidia.com>

Thanks for the reminder!

Cheers,
Yuan Gao

