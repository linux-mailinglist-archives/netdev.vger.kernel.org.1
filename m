Return-Path: <netdev+bounces-166657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F8AA36D12
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 10:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6AB1894737
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 09:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1D519D09C;
	Sat, 15 Feb 2025 09:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BD/vFss+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897B61922ED
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 09:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739612599; cv=none; b=JcUDksgZyz1/Fe11Uwc0hVS63gI+dn8y11n1h4tWQd074Z2NLnvprsulRtEmo6U2VFr820GlMqkq5E7XaKp3FxdtoBgk3E/D8TXLsCZkaqQHWIsYWe8v2e3AwI7SPBd2Pw4HF4SoNdqQfSbTiF01d4Jz0xcLf8V25GPL175SqsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739612599; c=relaxed/simple;
	bh=Swksr/PmYOf+GBVpFOrfwGWLcs0dWlCbQjBcuYE4s0Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d38jmX58wxvtv3g4fFejOj5SvJ98kZNXp9CTfIoF5cZFn8aLbAGr8exXp/Dx4bIijEwrMwOU7sYimGp6fbgC4x2N5p/NJxzEDY4LgInzalI84/TC+O0CxYNm7A3cqvaCnsXMorzvc8ug1ABiFHlKy98pjz6R3FKbDpcTE9EAomY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BD/vFss+; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739612597; x=1771148597;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AiujpX/yENDdxtCykiLZ/te6vWbTQRbEEnMMTYm3tdc=;
  b=BD/vFss+4B2nJu14cGqET6XWUVu3yR4RBVPLHEMTgTqLVTWIUoZaQZ2p
   tqMJVYtGiHz9i8khpeXfW0qr7j4bvLtRJEuDDdekg9E9zpjCrmDdJBU7d
   9Gk/quMM2ifAbEpFzV8umPMXqGOQL8ZiufjC8gx3F980zo40idtoE3JuJ
   g=;
X-IronPort-AV: E=Sophos;i="6.13,288,1732579200"; 
   d="scan'208";a="719039423"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 09:43:14 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:36209]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.245:2525] with esmtp (Farcaster)
 id 0a5dc21f-c683-4bc3-9814-2e3c6be72420; Sat, 15 Feb 2025 09:43:13 +0000 (UTC)
X-Farcaster-Flow-ID: 0a5dc21f-c683-4bc3-9814-2e3c6be72420
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 15 Feb 2025 09:43:13 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 15 Feb 2025 09:43:09 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 1/3] pfcp: Convert pfcp_net_exit() to ->exit_batch_rtnl().
Date: Sat, 15 Feb 2025 18:42:59 +0900
Message-ID: <20250215094259.12720-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250214081818.81658-2-kuniyu@amazon.com>
References: <20250214081818.81658-2-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC001.ant.amazon.com (10.13.139.218) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Fri, 14 Feb 2025 17:18:16 +0900
> pfcp_net_exit() holds RTNL and calls unregister_netdevice_queue() for
> dev in the netns.
> 
> Let's convert pfcp_net_exit() to ->exit_batch_rtnl to save RTNL dances
> for each netns.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  drivers/net/pfcp.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/pfcp.c b/drivers/net/pfcp.c
> index 68d0d9e92a22..5cb8635ada20 100644
> --- a/drivers/net/pfcp.c
> +++ b/drivers/net/pfcp.c
> @@ -244,30 +244,35 @@ static int __net_init pfcp_net_init(struct net *net)
>  	return 0;
>  }
>  
> -static void __net_exit pfcp_net_exit(struct net *net)
> +static void __net_exit pfcp_destroy_links(struct net *net,
> +					  struct list_head *dev_kill_list)
>  {
>  	struct pfcp_net *pn = net_generic(net, pfcp_net_id);
>  	struct pfcp_dev *pfcp, *pfcp_next;
>  	struct net_device *dev;
> -	LIST_HEAD(list);
>  
> -	rtnl_lock();
>  	for_each_netdev(net, dev)
>  		if (dev->rtnl_link_ops == &pfcp_link_ops)
> -			pfcp_dellink(dev, &list);
> +			pfcp_dellink(dev, dev_kill_list);

I got a report regarding this part and will post a fix conflicting
with this hunk, so please ignore this series

pw-bot: cr

