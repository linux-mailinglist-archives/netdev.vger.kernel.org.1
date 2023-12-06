Return-Path: <netdev+bounces-54284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCDA806741
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 07:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A2D28167C
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 06:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA00210A16;
	Wed,  6 Dec 2023 06:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="po4AQ53T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6481137;
	Tue,  5 Dec 2023 22:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1701844053; x=1733380053;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=URrKC2syfT3NOO+9W05M8GidiFZ7ofUg/IW+ajEM/7w=;
  b=po4AQ53T55fCTq+LA04QBjNthlbs4Kn9Qvz/AdoyKVPTZWjvEFNFXE+B
   7XRwfQrt3VwS7V1DdERgIcSibEJxbmxfdDkmob/EEF95sLLbYH22TXGg9
   UntFRt6wMvptpbXk/qi3L6aWYXkF6/T6+l4KBrq/w9vN1Ji7lStQ44II6
   4=;
X-IronPort-AV: E=Sophos;i="6.04,254,1695686400"; 
   d="scan'208";a="170252860"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-b538c141.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 06:27:31 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-b538c141.us-east-1.amazon.com (Postfix) with ESMTPS id C0F3FA3DFB;
	Wed,  6 Dec 2023 06:27:27 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:48660]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.214:2525] with esmtp (Farcaster)
 id da322ed0-0adf-49eb-a4b8-2f69e33d60e6; Wed, 6 Dec 2023 06:27:26 +0000 (UTC)
X-Farcaster-Flow-ID: da322ed0-0adf-49eb-a4b8-2f69e33d60e6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Dec 2023 06:27:26 +0000
Received: from 88665a182662.ant.amazon.com.com (10.119.13.242) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Dec 2023 06:27:22 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <eadavis@qq.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzbot+b5ad66046b913bc04c6f@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH] llc: fix uninit-value in __llc_lookup_established
Date: Wed, 6 Dec 2023 15:27:12 +0900
Message-ID: <20231206062712.41467-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <tencent_269592755DA55D9B19384F870D9D25B18D07@qq.com>
References: <tencent_269592755DA55D9B19384F870D9D25B18D07@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

From: Edward Adam Davis <eadavis@qq.com>
Date: Wed,  6 Dec 2023 09:55:15 +0800
> llc only supports ETH_P_802_2 protocol, so drop the skb when the protocol is 
> not it.

This is not true.  ETH_P_TR_802_2 is also processed by llc_rcv().

Let me post this formally.
https://lore.kernel.org/netdev/20231206005340.11534-1-kuniyu@amazon.com/

> 
> Reported-by: syzbot+b5ad66046b913bc04c6f@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  net/llc/llc_input.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
> index 51bccfb00a9c..16b2c57f38c2 100644
> --- a/net/llc/llc_input.c
> +++ b/net/llc/llc_input.c
> @@ -141,7 +141,8 @@ static inline int llc_fixup_skb(struct sk_buff *skb)
>  			return 0;
>  		if (unlikely(pskb_trim_rcsum(skb, data_size)))
>  			return 0;
> -	}
> +	} else
> +		return 0;
>  	return 1;
>  }
>  
> -- 
> 2.43.0

