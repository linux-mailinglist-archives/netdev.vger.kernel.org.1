Return-Path: <netdev+bounces-18411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC745756D18
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 21:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C3CD28134D
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 19:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B46C14A;
	Mon, 17 Jul 2023 19:24:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F20253CD
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 19:24:22 +0000 (UTC)
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD70D1B1;
	Mon, 17 Jul 2023 12:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689621861; x=1721157861;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K6aw8rLb0s3YE99yLXMvpaVZdlNBdVE1LKgt1NcjRvE=;
  b=vM42vVNrVNWzaafvohQuxYBcH+a6li5DAL7o5LiBtTp98fgcazB7d+cI
   uPyjZqWRYqgxy8Vm+j/8LOaRDBMcwdjnMyC/CB6GNkfdO6vYwCFafYSSu
   Q1i8lu5qilBnTbN5OY9k1Sp5aIjA6cd7wxIvK9PkDN+LfDX4M13x2F0B7
   Q=;
X-IronPort-AV: E=Sophos;i="6.01,211,1684800000"; 
   d="scan'208";a="345055172"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-3ef535ca.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 19:24:18 +0000
Received: from EX19MTAUWB002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2a-m6i4x-3ef535ca.us-west-2.amazon.com (Postfix) with ESMTPS id 1E69060F73;
	Mon, 17 Jul 2023 19:24:16 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 17 Jul 2023 19:24:15 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.21) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 17 Jul 2023 19:24:12 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <carlos.bilbao@amd.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <mchan@broadcom.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <prashant@broadcom.com>,
	<siva.kallam@broadcom.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH] tg3: fix array subscript out of bounds compilation error
Date: Mon, 17 Jul 2023 12:24:03 -0700
Message-ID: <20230717192403.96187-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230717143443.163732-1-carlos.bilbao@amd.com>
References: <20230717143443.163732-1-carlos.bilbao@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.100.21]
X-ClientProxiedBy: EX19D046UWB004.ant.amazon.com (10.13.139.164) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Carlos Bilbao <carlos.bilbao@amd.com>
Date: Mon, 17 Jul 2023 09:34:43 -0500
> Fix encountered compilation error in tg3.c where an array subscript was

What is the error ?


> above the array bounds of 'struct tg3_napi[5]'. Add an additional check in
> the for loop to ensure that it does not exceed the bounds of
> 'struct tg3_napi' (defined by TG3_IRQ_MAX_VECS).
> 
> Reviewed-By: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>  drivers/net/ethernet/broadcom/tg3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
> index 4179a12fc881..33ad75b7ed91 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -17791,7 +17791,7 @@ static int tg3_init_one(struct pci_dev *pdev,
>  	intmbx = MAILBOX_INTERRUPT_0 + TG3_64BIT_REG_LOW;
>  	rcvmbx = MAILBOX_RCVRET_CON_IDX_0 + TG3_64BIT_REG_LOW;
>  	sndmbx = MAILBOX_SNDHOST_PROD_IDX_0 + TG3_64BIT_REG_LOW;
> -	for (i = 0; i < tp->irq_max; i++) {
> +	for (i = 0; i < tp->irq_max && i < TG3_IRQ_MAX_VECS; i++) {

I'm not familiar with this driver, but it seem tg3_init_one() calls
tg3_get_invariants() before the loop and initialises irq_max as 1
or TG3_IRQ_MAX_VECS.

Where does tp->irq_max go over TG3_IRQ_MAX_VECS ?


>  		struct tg3_napi *tnapi = &tp->napi[i];
>  
>  		tnapi->tp = tp;
> -- 
> 2.41.0

