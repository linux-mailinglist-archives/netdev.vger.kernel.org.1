Return-Path: <netdev+bounces-19641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D0975B87E
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 22:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADF94281FD1
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 20:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D5B1BE77;
	Thu, 20 Jul 2023 20:05:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E151BE75
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 20:05:52 +0000 (UTC)
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F34270D;
	Thu, 20 Jul 2023 13:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689883548; x=1721419548;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n0V9Ssl4foYYslO6teD3c2aPdxXDj7QzX+mBq/yTlwU=;
  b=ipeaJGuz+0rhl7DCw0FaVWpuTTsk3W2p1GVvysrBFA7M48/CycM6okWf
   qEtOLa9sAci6nFBgMxS0nDFbtnNtUjEss/RE6TbQoewY/HbhzPfdb8gBK
   lg+C7KtPpVGi+s1Q1zzt/1ZmPH9JjCHh2pnTl7oa3a4YnakYbfVgZYJ78
   U=;
X-IronPort-AV: E=Sophos;i="6.01,219,1684800000"; 
   d="scan'208";a="296451431"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 20:05:41 +0000
Received: from EX19MTAUWA002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
	by email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com (Postfix) with ESMTPS id DD9E540D5F;
	Thu, 20 Jul 2023 20:05:38 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 20:05:38 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 20 Jul 2023 20:05:36 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <linus.luessing@c0d3.blue>
CC: <edumazet@google.com>, <netdev@vger.kernel.org>,
	<netfilter@vger.kernel.org>, <kuniyu@amazon.com>
Subject: Re: skb->mark not cleared for MLDv2 Reports? (skb->mark == 212 / 0xd4)
Date: Thu, 20 Jul 2023 13:05:27 -0700
Message-ID: <20230720200527.25978-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <ZLUkWyFiwEqi721V@sellars>
References: <ZLUkWyFiwEqi721V@sellars>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.101.12]
X-ClientProxiedBy: EX19D038UWB003.ant.amazon.com (10.13.139.157) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Date: Mon, 17 Jul 2023 13:22:03 +0200
> Hi,
> 
> I noticed that MLDv2 Reports don't seem to have a default
> skb->mark of 0. Instead it is 212 / 0xd4 for me:
> 
> ```
> $ ip link add dummy0 type dummy
> $ ip link set up dummy0 arp on
> $ ip6tables -I INPUT -i dummy0 -j LOG --log-ip-options
> [ send an MLDv2 Query, for instance via the ipv6toolkit
>   https://github.com/T-X/ipv6toolkit/tree/pr-mldq6-mldv2

I haven't looked yet though, a complete repro would make
us debug it easier.  (Same for MLDv1)

Thanks!


> ]
> $ dmesg
> ...
> [38336.524879] IN= OUT=dummy0 SRC=fe80:0000:0000:0000:1c01:1cff:fec1:5669 DST=ff02:0000:0000:0000:0000:0000:0000:0016 LEN=76 TC=0 HOPLIMIT=1 FLOWLBL=0 OPT ( ) PROTO=ICMPv6 TYPE=143 CODE=0 MARK=0xd4
> ...
> ```
> 
> For MLDv1 Reports I don't see this issue, there it's always
> 0 by default.
> 
> I'm wondering if this 212 value comes from the
> skb->reserved_tailroom (formerly avail_size) which the skb->mark
> is unioned with? Am I reading
> a21d45726a ("tcp: avoid order-1 allocations on wifi and tx path")
> correctly that the IPv6 stack should have reset skb->mark to 0
> before transmission?
> 
> Initially observed on a Linux 5.10.184. But I can reproduce
> this on a Linux 6.3.7, too.
> 
> Regards, Linus

