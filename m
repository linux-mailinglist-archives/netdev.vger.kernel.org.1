Return-Path: <netdev+bounces-139614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683F49B390D
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 19:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2DE51C210AD
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 18:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973FD1DF74D;
	Mon, 28 Oct 2024 18:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="OLFasgRE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9DB1DF266;
	Mon, 28 Oct 2024 18:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730139873; cv=none; b=mtqhihepnPDBEu6cFgTbzKLKc7DSEVo+8et18Y0/7rwa+caA1X0l/zlJ/xEFS/WcEE5ySfSoe/3OsmZn0X4U/9UoH7ZlnH+aTsJjNf7diIi8qskW1i3UxU4xtLMdtC8dLffvq/h4eJy2UZijUuZHae1lDha3Ps9ISRoaa/PKNEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730139873; c=relaxed/simple;
	bh=59890qOtp2rV4MBmNztVSe7L9552PpBEvhMQVWu3lGI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YajOwhiGSgd1M8F2EqVYoy0IejsdV70EPuG6Gi6IWjONI9w89J3B4rlss7JApuPc3tn5DqQryvKCP1KsNj1INi1yqkGlfLOHps9tkiQaEC914TnWfQoNCJ0qOiutMZJH9YoMKhOQkmI4YAiB1P9ihhd8L6MpDRCOC3pXwQZnTlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=OLFasgRE; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730139871; x=1761675871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ybPpOlSTiFyR1M5ysEzQaHO0m4AwYHYAXSyN13/FqMA=;
  b=OLFasgRETbxVQJ9+fN4UiFEzQaffDZY9tAk+X+0HKtODVJIFnaJYckf3
   /SpZz/XbfsQskjgw2QpJGxHTyzZeEwQt7j/gfMR5teVtD2w+WFlI35KPR
   brJDdg1Y5MD8RW4PJP6nwwQ0C06hgVMT4+EU2NsApNRUG0WmL9x2uBtsk
   M=;
X-IronPort-AV: E=Sophos;i="6.11,239,1725321600"; 
   d="scan'208";a="141399243"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 18:24:29 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:1895]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.102:2525] with esmtp (Farcaster)
 id d542737d-7fb7-465d-adab-415491668269; Mon, 28 Oct 2024 18:24:29 +0000 (UTC)
X-Farcaster-Flow-ID: d542737d-7fb7-465d-adab-415491668269
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 28 Oct 2024 18:24:28 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 28 Oct 2024 18:24:25 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <ruanjinjie@huawei.com>
CC: <a.kovaleva@yadro.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <lirongqing@baidu.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net] netlink: Fix off-by-one error in netlink_proto_init()
Date: Mon, 28 Oct 2024 11:24:21 -0700
Message-ID: <20241028182421.6692-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241028080515.3540779-1-ruanjinjie@huawei.com>
References: <20241028080515.3540779-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jinjie Ruan <ruanjinjie@huawei.com>
Date: Mon, 28 Oct 2024 16:05:15 +0800
> In the error path of netlink_proto_init(), frees the already allocated
> bucket table for new hash tables in a loop, but the loop condition
> terminates when the index reaches zero, which fails to free the first
> bucket table at index zero.
> 
> Check for >= 0 so that nl_table[0].hash is freed as well.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  net/netlink/af_netlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 0a9287fadb47..9601b85dda95 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -2936,7 +2936,7 @@ static int __init netlink_proto_init(void)
>  	for (i = 0; i < MAX_LINKS; i++) {
>  		if (rhashtable_init(&nl_table[i].hash,
>  				    &netlink_rhashtable_params) < 0) {
> -			while (--i > 0)
> +			while (--i >= 0)
>  				rhashtable_destroy(&nl_table[i].hash);
>  			kfree(nl_table);
>  			goto panic;

I remember the same question was posted in the past.
https://lore.kernel.org/netdev/ZfOalln%2FmyRNOkH6@cy-server/

As Eric alreday pointed out (and as mentioned in the thread above too),
it's going to panic, and we need not clean up resources here, so let's
remove rhashtable_destroy() and kfree() instead of adjusting the loop
condition.

