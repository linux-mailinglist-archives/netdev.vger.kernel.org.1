Return-Path: <netdev+bounces-138074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7EE9ABC6E
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 05:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17922B21A01
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 03:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ED712EBE9;
	Wed, 23 Oct 2024 03:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HptjKiwX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554D217741
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 03:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729655370; cv=none; b=LKeSVi5YKGN51EwCGcczWFUvYXdUlh7wNGJ48q51qskF6opcOEhfiolfgTsfUV1r+EFraXG7PbwFJj05wsvyJHs/WxaNhDsQPAsBgDrYjkufwRplgzOGb50MRA2Q+quBiytqVFEI7/uYAKpHuv3ZhBugJyZ8F/c0R0T3B/n/Xf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729655370; c=relaxed/simple;
	bh=tkl2XKi4nT6SltDFVTl8VQooiCz8+/VCIzCCAyP3XAo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fwYbgC8eDy7f14BST/MG5Dc2+v93lRnahWR24omxSPRfNbhw2V8pxJjLAeMxwMRWyierFJsV0XXOQbFZzFqoTJJW17l1N21ncwh3DaNbxDNK/3bcBI0DQnxf/2XlIGmaFbd8LAi3odCw50NCofTapdtSLSxlOHHv1of/oW3SRec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HptjKiwX; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729655369; x=1761191369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JWIrcjgegW4koi9DFZuhX/oHxsH7syPBgE6nxM18Kh0=;
  b=HptjKiwXvAMFVvdgzYPsQn93cS8E54HnXaTsfs3PPUh1OSOfNGpD6q5D
   d1QGQSuAj/ebSA5nRFF2Jh8SWN6LW9KEHxe/YcL+yeAkRCWyDTJTGZAmA
   E+QOay6iepBpR9yzAVEtOVbBoa3EutAlwmGxvjB1UnKVEQFgFz2ovC7CC
   Q=;
X-IronPort-AV: E=Sophos;i="6.11,223,1725321600"; 
   d="scan'208";a="443119300"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 03:49:23 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:35973]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.226:2525] with esmtp (Farcaster)
 id 0c4d3e24-2973-451e-ba4a-b82657342200; Wed, 23 Oct 2024 03:49:22 +0000 (UTC)
X-Farcaster-Flow-ID: 0c4d3e24-2973-451e-ba4a-b82657342200
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 23 Oct 2024 03:49:21 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.219.31) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 23 Oct 2024 03:49:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <shaw.leon@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<idosch@nvidia.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/5] rtnetlink: Lookup device in target netns when creating link
Date: Tue, 22 Oct 2024 20:49:16 -0700
Message-ID: <20241023034916.26795-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241023023146.372653-2-shaw.leon@gmail.com>
References: <20241023023146.372653-2-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Xiao Liang <shaw.leon@gmail.com>
Date: Wed, 23 Oct 2024 10:31:42 +0800
> When creating link, lookup for existing device in target net namespace
> instead of current one.
> For example, two links created by:
> 
>   # ip link add dummy1 type dummy
>   # ip link add netns ns1 dummy1 type dummy
> 
> should have no conflict since they are in different namespaces.
> 
> Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
> ---
>  net/core/rtnetlink.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 194a81e5f608..ff8d25acfc00 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -3733,20 +3733,24 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
>  {
>  	struct nlattr ** const tb = tbs->tb;
>  	struct net *net = sock_net(skb->sk);
> +	struct net *device_net;
>  	struct net_device *dev;
>  	struct ifinfomsg *ifm;
>  	bool link_specified;
>  
> +	/* When creating, lookup for existing device in target net namespace */
> +	device_net = nlh->nlmsg_flags & NLM_F_CREATE ? tgt_net : net;

Technically, this changes uAPI behaviour.

Let's say a user wants to

  1) move the device X in the current netns to another if exists, otherwise
  2) create a new device X in the target netns

This can be achieved by setting NLM_F_CREATE and IFLA_NET_NS_PID,
IFLA_NET_NS_FD, or IFLA_TARGET_NETNSID.

But with this change, the device X in the current netns will not be moved,
and a new device X is created in the target netns.


> +
>  	ifm = nlmsg_data(nlh);
>  	if (ifm->ifi_index > 0) {
>  		link_specified = true;
> -		dev = __dev_get_by_index(net, ifm->ifi_index);
> +		dev = __dev_get_by_index(device_net, ifm->ifi_index);
>  	} else if (ifm->ifi_index < 0) {
>  		NL_SET_ERR_MSG(extack, "ifindex can't be negative");
>  		return -EINVAL;
>  	} else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME]) {
>  		link_specified = true;
> -		dev = rtnl_dev_get(net, tb);
> +		dev = rtnl_dev_get(device_net, tb);
>  	} else {
>  		link_specified = false;
>  		dev = NULL;
> -- 
> 2.47.0

