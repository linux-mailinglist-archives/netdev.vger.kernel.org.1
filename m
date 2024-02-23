Return-Path: <netdev+bounces-74220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05FD860862
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 02:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E26E71C228DD
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 01:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA13171BA;
	Fri, 23 Feb 2024 01:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afmZSlBL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37942171B8
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 01:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708652225; cv=none; b=TEEmxrm4miaomOLbBriuc2PBootKTnvjSX8LZRFxNpbXb2ca+i/Qfnym/pNiecOm7Fq0GBE4klgY+nakkh89yYo1zfH2wVOk+u9Gbwoof+gOzIMG4FrZDbq9es/AnP74jcw4MIuCuiRYETMM9rhBO1v3YWMz7/jDluejkm9XRDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708652225; c=relaxed/simple;
	bh=vEKErCSIv5LAt2EKDe1Xso6r1/EfqRXG5mKtYRbtWLo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mhRxuh6t7R1I7A7MqPKOVpc6fEuu9c0ei3m69uBDbSTPJ23mX/zauNjM2cR7+JAy1rOzpdWYRSOFY6ZPU0TPKb1qRc9A3X1HavOyFkvrX/vOMP3NAymiCFF7t5eXBTyhXEI/YRBCtS9KQSI+BECdN6fTLdaZhE1fHDa9Q2n0jJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afmZSlBL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4721CC433C7;
	Fri, 23 Feb 2024 01:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708652224;
	bh=vEKErCSIv5LAt2EKDe1Xso6r1/EfqRXG5mKtYRbtWLo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=afmZSlBLiKqPChSXJ96rZsWDzWNqmbaBnRAN0dnvsouiC3ijiWK/7g/z220jT2V6C
	 GvqpQhV6oD1u36C+KRI+euP/vhXLjb8oyrmiW4Zs8KzHyNy33Teh10BPcN01gxvSfQ
	 2JIyP3VieNBfOI3TsY+LGmqhEbsduvCejF6TUCvqWzZ/ctLBNxntReZkufbvDdvXQK
	 wIaqkxnbk5RENGNvaQhdvRP6AdQAXuzbLQyQMWW1hUIJcVPbxkU2l74oidAoXV0hCk
	 SshQkEhJTefC4bnvmKgrkgYv1b99b1yE/DxOpfoiOHK5evf/A4kG8em1l0bUjWhj8b
	 Ovn1HHLPmPA2g==
Date: Thu, 22 Feb 2024 17:37:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Nambiar, Amritha" <amritha.nambiar@intel.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <danielj@nvidia.com>, <mst@redhat.com>,
 <michael.chan@broadcom.com>
Subject: Re: [RFC net-next 1/3] netdev: add per-queue statistics
Message-ID: <20240222173703.08c442e9@kernel.org>
In-Reply-To: <835c44da-598b-4c33-8a4d-14e946a8f451@intel.com>
References: <20240222223629.158254-1-kuba@kernel.org>
	<20240222223629.158254-2-kuba@kernel.org>
	<835c44da-598b-4c33-8a4d-14e946a8f451@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Feb 2024 16:23:57 -0800 Nambiar, Amritha wrote:
> > +int netdev_nl_stats_get_dumpit(struct sk_buff *skb,
> > +			       struct netlink_callback *cb)
> > +{
> > +	struct netdev_nl_dump_ctx *ctx = netdev_dump_ctx(cb);
> > +	const struct genl_info *info = genl_info_dump(cb);
> > +	enum netdev_stats_projection projection;
> > +	struct net *net = sock_net(skb->sk);
> > +	struct net_device *netdev;
> > +	int err = 0;
> > +
> > +	projection = NETDEV_STATS_PROJECTION_NETDEV;
> > +	if (info->attrs[NETDEV_A_STATS_PROJECTION])
> > +		projection =
> > +			nla_get_uint(info->attrs[NETDEV_A_STATS_PROJECTION]);
> > +
> > +	rtnl_lock();  
> 
> Could we also add filtered-dump for a user provided ifindex ?

Definitely, wasn't sure if that's a pre-requisite for merging,
or we can leave it on the "netdev ToDo sheet" as a learning task 
for someone. Opinions welcome..

