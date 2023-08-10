Return-Path: <netdev+bounces-26126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6A2776E14
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 04:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA3AA1C213ED
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 02:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B7D7EF;
	Thu, 10 Aug 2023 02:28:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769507E4
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 02:28:10 +0000 (UTC)
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DB61BD9;
	Wed,  9 Aug 2023 19:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1691634489; x=1723170489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bzEek1zgt1wND7V2uHTMP/IFQxtrm8y1bob9SqKo9zI=;
  b=KaHzKPDBA3kBwQqdbVZf12BH8MpzsD74JdEC7brZTSu//iFSrFFgQBW8
   RNc6YMSpIUYhOtId+9vp3Q/UaKaSZll2tuoFBOnsr9r2pLwZ+gO4K8jIp
   PC93U3GbFLJkkhKSeFIZ5w/WKKJZ0ODjYLNs3VBMDskeSGAM/uFm5nTSc
   Y=;
X-IronPort-AV: E=Sophos;i="6.01,160,1684800000"; 
   d="scan'208";a="147646150"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-9fe6ad2f.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 02:28:07 +0000
Received: from EX19MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1a-m6i4x-9fe6ad2f.us-east-1.amazon.com (Postfix) with ESMTPS id 159B08057B;
	Thu, 10 Aug 2023 02:28:05 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 10 Aug 2023 02:27:46 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 10 Aug 2023 02:27:43 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <sishuai.system@gmail.com>
CC: <horms@verge.net.au>, <ja@ssi.bg>, <lvs-devel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <kuniyu@amazon.com>
Subject: Re: Race over table->data in proc_do_sync_threshold()
Date: Wed, 9 Aug 2023 19:27:34 -0700
Message-ID: <20230810022734.47246-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <B6988E90-0A1E-4B85-BF26-2DAF6D482433@gmail.com>
References: <B6988E90-0A1E-4B85-BF26-2DAF6D482433@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.100.32]
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Sishuai Gong <sishuai.system@gmail.com>
Date: Wed, 9 Aug 2023 20:30:37 -0400
> Hi,
> 
> We observed races over (struct ctl_table *) table->data when two threads
> are running proc_do_sync_threshold() in parallel, as shown below:
> 
> Thread-1			Thread-2
> memcpy(val, valp, sizeof(val)); memcpy(valp, val, sizeof(val));
> 
> This race probably would mess up table->data. Is it better to add a lock?

Yes, we should acquire mutex/seqlock etc.

