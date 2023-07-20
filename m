Return-Path: <netdev+bounces-19595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6A775B527
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 19:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38B331C2148B
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 17:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB662FA3C;
	Thu, 20 Jul 2023 17:03:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38A82FA20
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 17:03:07 +0000 (UTC)
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93113119
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 10:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689872586; x=1721408586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xQmJahfbWux03iWex/nMItH6A8UOTVyOFELiV1iV6u4=;
  b=oRkeSIc4HCgyHkbui7S0QFDHX+ctL6IZvtGGDgLxBETBVMrENLsrzxda
   2pg2/ldVkrWmo1/8McIjKsOeHbk4irOhta1hFlkvfLCaImvjnzttMlwn/
   zr5d4jWO9lYuCVtT9Mj2Dge8/kXRMmSokf9mNSJPqzlVIOJoYe+5VioI9
   Y=;
X-IronPort-AV: E=Sophos;i="6.01,219,1684800000"; 
   d="scan'208";a="661011543"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 17:02:59 +0000
Received: from EX19MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2c-m6i4x-fa5fe5fb.us-west-2.amazon.com (Postfix) with ESMTPS id 60DF340DB0;
	Thu, 20 Jul 2023 17:02:58 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 17:02:49 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 17:02:45 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <keescook@chromium.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <gustavoars@kernel.org>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<leitao@debian.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzkaller@googlegroups.com>, <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v2 net 2/2] af_packet: Fix warning of fortified memcpy() in packet_getname().
Date: Thu, 20 Jul 2023 10:02:36 -0700
Message-ID: <20230720170236.3939-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <202307200753.7B071AC7B@keescook>
References: <202307200753.7B071AC7B@keescook>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.101.12]
X-ClientProxiedBy: EX19D033UWC004.ant.amazon.com (10.13.139.225) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kees Cook <keescook@chromium.org>
Date: Thu, 20 Jul 2023 08:04:53 -0700
> On Wed, Jul 19, 2023 at 05:44:10PM -0700, Kuniyuki Iwashima wrote:
> > syzkaller found a warning in packet_getname() [0], where we try to
> > copy 16 bytes to sockaddr_ll.sll_addr[8].
> > 
> > Some devices (ip6gre, vti6, ip6tnl) have 16 bytes address expressed
> > by struct in6_addr.  Also, Infiniband has 32 bytes as MAX_ADDR_LEN.
> > 
> > The write seems to overflow, but actually not since we use struct
> > sockaddr_storage defined in __sys_getsockname() and its size is 128
> > (_K_SS_MAXSIZE) bytes.  Thus, we have sufficient room after sll_addr[]
> > as __data[].
> 
> Ah, so the issue here is that the UAPI for sll_addr is lying about its
> size. I think a better fix here is to fix the structure (without
> breaking UAPI sizes or names):

Doesn't it forcify sll_addr here ?


> 
> diff --git a/include/uapi/linux/if_packet.h b/include/uapi/linux/if_packet.h
> index 9efc42382fdb..4d0ad22f83b5 100644
> --- a/include/uapi/linux/if_packet.h
> +++ b/include/uapi/linux/if_packet.h
> @@ -18,7 +18,11 @@ struct sockaddr_ll {
>  	unsigned short	sll_hatype;
>  	unsigned char	sll_pkttype;
>  	unsigned char	sll_halen;
> -	unsigned char	sll_addr[8];
> +	union {
> +		unsigned char	sll_addr[8];
> +		/* Actual length is in sll_halen. */
> +		__DECLARE_FLEX_ARRAY(unsigned char, sll_addr_flex);
> +	};
>  };
>  
>  /* Packet types */
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 85ff90a03b0c..8e3ddec4c3d5 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -3601,7 +3601,7 @@ static int packet_getname(struct socket *sock, struct sockaddr *uaddr,
>  	if (dev) {
>  		sll->sll_hatype = dev->type;
>  		sll->sll_halen = dev->addr_len;
> -		memcpy(sll->sll_addr, dev->dev_addr, dev->addr_len);
> +		memcpy(sll->sll_addr_flex, dev->dev_addr, dev->addr_len);
>  	} else {
>  		sll->sll_hatype = 0;	/* Bad: we have no ARPHRD_UNSPEC */
>  		sll->sll_halen = 0;
> 
> We can't rename sll_data nor change it's size, as userspace uses it
> pretty extensively:
> https://codesearch.debian.net/search?q=sizeof.*sll_addr&literal=0
> 
> -- 
> Kees Cook

