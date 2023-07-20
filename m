Return-Path: <netdev+bounces-19680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 418DA75BA46
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 00:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71AD31C2148A
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 22:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC55D1DDCD;
	Thu, 20 Jul 2023 22:08:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6762FA49
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 22:08:37 +0000 (UTC)
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1D5E68
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 15:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689890917; x=1721426917;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dB3fEsSHCfxxXV9VTGXUNDHCJuDcBGfcwVOGmNdXvLA=;
  b=m9rE+l/NgNKo4yZzTLEa6WjYWdqSZ/HS7m2Ta9gd799YmtIuc6SsFZjh
   9NPemUKb5OD8UV5M0pHkAUUrE/4SsHgFAjMvoXqlnAIeSySm8TAOPPCIf
   z/ZmY2bMbjdbDXo0pl+11p6Sm1dggAe9L54/uuT9CzyF89Lsqd7qZ0mc8
   s=;
X-IronPort-AV: E=Sophos;i="6.01,219,1684800000"; 
   d="scan'208";a="597478821"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-94edd59b.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 22:08:34 +0000
Received: from EX19MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2c-m6i4x-94edd59b.us-west-2.amazon.com (Postfix) with ESMTPS id AFCC040D57;
	Thu, 20 Jul 2023 22:08:32 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 22:08:32 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 22:08:29 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <ruc_gongyuanjun@163.com>
CC: <chris.snook@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <kuniyu@amazon.com>
Subject: [PATCH 1/1] ethernet: atheros: fix return value check in atl1_tso()
Date: Thu, 20 Jul 2023 15:08:20 -0700
Message-ID: <20230720220820.40712-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230720144154.38922-1-ruc_gongyuanjun@163.com>
References: <20230720144154.38922-1-ruc_gongyuanjun@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.101.12]
X-ClientProxiedBy: EX19D038UWC004.ant.amazon.com (10.13.139.229) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Yuanjun Gong <ruc_gongyuanjun@163.com>
Date: Thu, 20 Jul 2023 22:41:54 +0800
> in atl1_tso, it should check the return value of pskb_trim(),
> and return an error code if an unexpected value is returned
> by pskb_trim().
>

Please add Fixes tag and specify the target tree as net in Subject.

Also, it would be better to post related patches as a single series:

https://lore.kernel.org/netdev/20230720144208.39170-1-ruc_gongyuanjun@163.com/T/#u
https://lore.kernel.org/netdev/20230720144219.39285-1-ruc_gongyuanjun@163.com/T/#u


> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
> ---
>  drivers/net/ethernet/atheros/atlx/atl1.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/ethernet/atheros/atlx/atl1.c
> index c8444bcdf527..02aa6fd8ebc2 100644
> --- a/drivers/net/ethernet/atheros/atlx/atl1.c
> +++ b/drivers/net/ethernet/atheros/atlx/atl1.c
> @@ -2113,8 +2113,11 @@ static int atl1_tso(struct atl1_adapter *adapter, struct sk_buff *skb,
>  
>  			real_len = (((unsigned char *)iph - skb->data) +
>  				ntohs(iph->tot_len));
> -			if (real_len < skb->len)
> -				pskb_trim(skb, real_len);
> +			if (real_len < skb->len) {
> +				err = pskb_trim(skb, real_len);
> +				if (err)
> +					return err;
> +			}
>  			hdr_len = skb_tcp_all_headers(skb);
>  			if (skb->len == hdr_len) {
>  				iph->check = 0;
> -- 
> 2.17.1

