Return-Path: <netdev+bounces-144622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 373CF9C7F19
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 01:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0560284698
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 00:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D433D81;
	Thu, 14 Nov 2024 00:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lrlKN1uT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29632817;
	Thu, 14 Nov 2024 00:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731542537; cv=none; b=XnQfmApiEz8X4PtizISHW+ojdH251Qrh6C/GhDG67xubTkpbILONyb/eJjDOr3LtdzLLM6OZHgNufECGnFAqcWc/yaWTC8b2GuSoLTIdEmv4fD0CEVYORWZec2mCcRDOseoePfemdbgn+CFpK1pL5amsJMDlWGCfKmKshTRKakw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731542537; c=relaxed/simple;
	bh=OGf/ZTZKvELNBg/gjtbeiUzLpSgVjmweUm4Y9oVAEpk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2Ii03Rt5tnnbByUWDEYLosnGLrLEBdt9dRgS738o0EXXdQuxkK83ljw7ZUaOnjTvhJf3coYouVZk0WcwiOA+tLtHLWYJ5pqde7P6VXiXH0w+SEqu/b/1NC7BKzdY5MEOfwbJuN7wF6C+HcPX03pzKDNcwMc8umNB7rKidToPmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=lrlKN1uT; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731542536; x=1763078536;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=maNdqHYuoGEBlAJl6fKzox0ktKWtaRjAxlSJ21lw9TI=;
  b=lrlKN1uTXZD3j9V+JqjGUWnVGj7qEXrs4NzwDwg4C6NVATfIeXgHVpz5
   N0+FJVDrMQJJWuf1UWRq6sFGufnrEWvi0JzPm88hbptkvdPtNRh393F/G
   cndVHXdT87kC4bRaepXT8iaJLHvM9N8AYOqgkzlyFpD/sWX4lmnS4P+JJ
   8=;
X-IronPort-AV: E=Sophos;i="6.12,152,1728950400"; 
   d="scan'208";a="775470449"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 00:02:10 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:1588]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.96:2525] with esmtp (Farcaster)
 id a9caf9d4-5a3d-445a-aadc-386611a50c1d; Thu, 14 Nov 2024 00:02:09 +0000 (UTC)
X-Farcaster-Flow-ID: a9caf9d4-5a3d-445a-aadc-386611a50c1d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 14 Nov 2024 00:02:09 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 14 Nov 2024 00:02:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <devnull+manas18244.iiitd.ac.in@kernel.org>
CC: <anupnewsmail@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<manas18244@iiitd.ac.in>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<shuah@kernel.org>, <syzbot+d4373fa8042c06cefa84@syzkaller.appspotmail.com>,
	<kuniyu@amazon.com>
Subject: Re: [PATCH] Add string check in netlink_ack_tlv_fill
Date: Wed, 13 Nov 2024 16:02:02 -0800
Message-ID: <20241114000202.82838-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241114-fix-netlink_ack_tlv_fill-v1-1-47798af4ac96@iiitd.ac.in>
References: <20241114-fix-netlink_ack_tlv_fill-v1-1-47798af4ac96@iiitd.ac.in>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

> [PATCH] Add string check in netlink_ack_tlv_fill

Please specify the target tree and add prefix like

  [PATCH net v2] netlink: Add string...

We use net.git for fixes and net-next.git for others.
https://www.kernel.org/doc/html/v6.11-rc6/process/maintainer-netdev.html


From: Manas via B4 Relay <devnull+manas18244.iiitd.ac.in@kernel.org>
Date: Thu, 14 Nov 2024 04:14:25 +0530
> From: Manas <manas18244@iiitd.ac.in>
> 
> netlink_ack_tlv_fill crashes when in_skb->data is an empty string. This
> adds a check to prevent it.
>


Fixes: tag is needed here.

> Reported-by: syzbot+d4373fa8042c06cefa84@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=d4373fa8042c06cefa84
> Signed-off-by: Manas <manas18244@iiitd.ac.in>
> ---
> netlink_ack_tlv_fill crashes when in_skb->data is an empty string. This
> adds a check to prevent it.

You need not duplicate commit message here.

under --- you can add extra info that will not be included in the
actual commit, e.g. changes between each version of patches.


> ---
>  net/netlink/af_netlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 0a9287fadb47a2afaf0babe675738bc43051c5a7..ea205a4f81e9755a229d46a7e617ce0c090fe5e3 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -2205,7 +2205,7 @@ netlink_ack_tlv_fill(struct sk_buff *in_skb, struct sk_buff *skb,
>  	if (!err)
>  		return;
>  
> -	if (extack->bad_attr &&
> +	if (extack->bad_attr && strlen(in_skb->data) &&
>  	    !WARN_ON((u8 *)extack->bad_attr < in_skb->data ||
>  		     (u8 *)extack->bad_attr >= in_skb->data + in_skb->len))
>  		WARN_ON(nla_put_u32(skb, NLMSGERR_ATTR_OFFS,
> 
> ---
> base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
> change-id: 20241114-fix-netlink_ack_tlv_fill-14db336fd515
> 
> Best regards,
> -- 
> Manas <manas18244@iiitd.ac.in>
> 

