Return-Path: <netdev+bounces-16655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2119674E27A
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 02:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FC7E1C20C4B
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 00:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5DB363;
	Tue, 11 Jul 2023 00:14:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF350361
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 00:14:45 +0000 (UTC)
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F67FFB
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 17:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1689034484; x=1720570484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8/GTH1UD5rohElzwZnuTrt2lQwLVVXmI38sXXvpkKUI=;
  b=H2JzBlCSPDIYG9MOXyg3b3WzWJ4OtKELypI3sSNAl+Nl5ctZNQzLzWES
   k83VuugldDsIGR6mMF1AGSJ22AHcO5SCFaRcO6CtqWHcpYVAtm2gy//Wv
   AIaFfziV6MC/14hCKe+WQRtpea2twtHS+xsxXcMjEH5SvjlT18x6knHnL
   E=;
X-IronPort-AV: E=Sophos;i="6.01,195,1684800000"; 
   d="scan'208";a="346012548"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1box-1dm6-7f722725.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 00:14:41 +0000
Received: from EX19MTAUWC001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
	by email-inbound-relay-iad-1box-1dm6-7f722725.us-east-1.amazon.com (Postfix) with ESMTPS id C80B886FED;
	Tue, 11 Jul 2023 00:14:37 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 11 Jul 2023 00:14:37 +0000
Received: from 88665a182662.ant.amazon.com (10.119.65.132) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 11 Jul 2023 00:14:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pctammela@mojatatu.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <jhs@mojatatu.com>,
	<jiri@resnulli.us>, <kuba@kernel.org>, <mysuryan@cisco.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <vijaynsu@cisco.com>,
	<xiyou.wangcong@gmail.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH net] net/sched: make psched_mtu() RTNL-less safe
Date: Mon, 10 Jul 2023 17:14:26 -0700
Message-ID: <20230711001426.24422-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230711000429.558248-1-pctammela@mojatatu.com>
References: <20230711000429.558248-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.119.65.132]
X-ClientProxiedBy: EX19D038UWC002.ant.amazon.com (10.13.139.238) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Pedro Tammela <pctammela@mojatatu.com>
Date: Mon, 10 Jul 2023 21:04:29 -0300
> Eric Dumazet says[1]:
> ---

I think we shouldn't use `---` here, or the message below will
be dropped while merging.


> Speaking of psched_mtu(), I see that net/sched/sch_pie.c is using it
> without holding RTNL, so dev->mtu can be changed underneath.
> KCSAN could issue a warning.
> ---
> 
> Annotate dev->mtu with READ_ONCE() so KCSAN don't issue a warning.
> 
> [1] https://lore.kernel.org/all/CANn89iJoJO5VtaJ-2=_d2aOQhb0Xw8iBT_Cxqp2HyuS-zj6azw@mail.gmail.com/
> 
> Fixes: d4b36210c2e6 ("net: pkt_sched: PIE AQM scheme")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> ---
>  include/net/pkt_sched.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
> index e98aac9d5ad5..15960564e0c3 100644
> --- a/include/net/pkt_sched.h
> +++ b/include/net/pkt_sched.h
> @@ -134,7 +134,7 @@ extern const struct nla_policy rtm_tca_policy[TCA_MAX + 1];
>   */
>  static inline unsigned int psched_mtu(const struct net_device *dev)
>  {
> -	return dev->mtu + dev->hard_header_len;
> +	return READ_ONCE(dev->mtu) + dev->hard_header_len;
>  }
>  
>  static inline struct net *qdisc_net(struct Qdisc *q)
> -- 
> 2.39.2

