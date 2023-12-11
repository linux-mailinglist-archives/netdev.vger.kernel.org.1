Return-Path: <netdev+bounces-55974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CBB80D03C
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 16:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 569D11C2098D
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 15:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8BF4C3A5;
	Mon, 11 Dec 2023 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RDahEyiw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B9ED67
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 07:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702310294; x=1733846294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HXYwtHf1crZ+2R2c/ebu/5qXB2tr3ce7Wh+7+A6s3a4=;
  b=RDahEyiwofZOUkNeCmV6FVfH73NaooSFrDOznoBJnzUdp1zxRuF64xgF
   bjYfLTaJIHYnC+IfUO8oUHeLMeWG5ZwUZZzPb5WyMt0Q5gFGJf3RHtA21
   SjyhmmRb/E5X2ZqFGc9DcBuNFdOdJgaVxLowNLkXK+ZPoOpB+zExMNOpz
   c=;
X-IronPort-AV: E=Sophos;i="6.04,268,1695686400"; 
   d="scan'208";a="373069424"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-e7094f15.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 15:58:11 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-e7094f15.us-west-2.amazon.com (Postfix) with ESMTPS id 3F74240BBD;
	Mon, 11 Dec 2023 15:58:10 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:39557]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.33:2525] with esmtp (Farcaster)
 id 6e28f5eb-e4d4-4630-8c60-59d7042c6070; Mon, 11 Dec 2023 15:58:09 +0000 (UTC)
X-Farcaster-Flow-ID: 6e28f5eb-e4d4-4630-8c60-59d7042c6070
Received: from EX19D003UWC004.ant.amazon.com (10.13.138.150) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 15:58:09 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D003UWC004.ant.amazon.com (10.13.138.150) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 15:58:09 +0000
Received: from dev-dsk-abuehaze-1c-21d23c85.eu-west-1.amazon.com
 (10.13.244.41) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server id 15.2.1118.40 via Frontend Transport; Mon, 11 Dec 2023 15:58:09
 +0000
Received: by dev-dsk-abuehaze-1c-21d23c85.eu-west-1.amazon.com (Postfix, from userid 5005603)
	id D84D9172A; Mon, 11 Dec 2023 15:58:08 +0000 (UTC)
From: Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>
To: <edumazet@google.com>
CC: <alisaidi@amazon.com>, <benh@amazon.com>, <blakgeof@amazon.com>,
	<davem@davemloft.net>, <dipietro.salvatore@gmail.com>, <dipiets@amazon.com>,
	<dsahern@kernel.org>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: [PATCH] tcp: disable tcp_autocorking for socket when TCP_NODELAY flag is set
Date: Mon, 11 Dec 2023 15:58:08 +0000
Message-ID: <20231211155808.14804-1-abuehaze@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <CANn89i+BNkkg1nauBiKH-CfjFHOaR_56Fq6d1PiQ1TSXdFUCAw@mail.gmail.com>
References: <CANn89i+BNkkg1nauBiKH-CfjFHOaR_56Fq6d1PiQ1TSXdFUCAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: Bulk

It will be good to submit another version changing the documentation https://docs.kernel.org/networking/timestamping.html editing "It can prevent the situation by always flushing the TCP stack in between requests, for instance by enabling TCP_NODELAY and disabling TCP_CORK and autocork." to "It can prevent the situation by always flushing the TCP stack in between requests, for instance by enabling TCP_NODELAY and disabling TCP_CORK."


