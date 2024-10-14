Return-Path: <netdev+bounces-135375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E194699DA61
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 01:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 678C1B20D7E
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 23:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFA01D5AB6;
	Mon, 14 Oct 2024 23:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Vr5Yo8u6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC5E1E4A6
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 23:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728950160; cv=none; b=sGe2OdhoiV0MTLDS/DeEEdfxekApxxiW9f9edU90/iEAbJjGnmHTpXCQn2T8eA8VXB+BkFYsEl+xUNhtLNTAWKls5pJqwKiQZF2lmwNmMTRGY6nf6AI6qdWuld/LFQ05b1G4+MbfY1uhjAVBldLf0a21FyM9IlBPOvnHdfmWbZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728950160; c=relaxed/simple;
	bh=c7yxaMzCKeveFTTA8XQ2kKP9MWaeFNlnQn6g4CGnxtg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCdIao1PCze2WD4ftbGrxcxqc/fQDXXKhSRxxYNml8yCK8zeyIWmv07EgFEZT3Q5////dDnV/qtxvrJ89UWs2AOY5pnzzkmiWV69Ekoc1IdipndMEdTFSm9qRdCGJmRnkwGrQi9e1JpvW7ca0R2NlQJANNe/RAqSoLaMPRtDEAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Vr5Yo8u6; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728950160; x=1760486160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zchUIoEOt/4Lp6wN/NrcfCTz5EE6xKERHH/LDGIs/gE=;
  b=Vr5Yo8u681I2NTKtGJ7i/bBbbjbBhOrePDpnsRrxgRhoxm4jNhDhIZ8f
   CcdWjWaiitFD89jRlTDOuWzHSdN2tzR+t/NF6c3tnmzSqAEbZ/PCBXdZ+
   C8emHUsMJG6zXwgNWo8JQ6+b7Lq+3YMacAF5ZYTCoNX9p8iqDfxx2My07
   M=;
X-IronPort-AV: E=Sophos;i="6.11,203,1725321600"; 
   d="scan'208";a="766542083"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 23:55:54 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:32336]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.26:2525] with esmtp (Farcaster)
 id bc83abbf-b8f9-4a6b-bd7a-47473e8d692a; Mon, 14 Oct 2024 23:55:53 +0000 (UTC)
X-Farcaster-Flow-ID: bc83abbf-b8f9-4a6b-bd7a-47473e8d692a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 14 Oct 2024 23:55:53 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 14 Oct 2024 23:55:50 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <gilad@naaman.io>,
	<gnaaman@drivenets.com>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH net-next v3 2/2] Create netdev->neighbour association
Date: Mon, 14 Oct 2024 16:55:47 -0700
Message-ID: <20241014235547.11090-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241014231917.7858-1-kuniyu@amazon.com>
References: <20241014231917.7858-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB004.ant.amazon.com (10.13.139.150) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Mon, 14 Oct 2024 16:19:17 -0700
> From: Gilad Naaman <gnaaman@drivenets.com>
> Date: Thu, 10 Oct 2024 12:01:25 +0000
> > diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
> > index 1b018ac35e9a..889501a16da2 100644
> > --- a/Documentation/networking/net_cachelines/net_device.rst
> > +++ b/Documentation/networking/net_cachelines/net_device.rst
> > @@ -186,4 +186,5 @@ struct dpll_pin*                    dpll_pin
> >  struct hlist_head                   page_pools
> >  struct dim_irq_moder*               irq_moder
> >  u64                                 max_pacing_offload_horizon
> > +struct hlist_head                   neighbours[3]
> 
> I think 2 should be enough as DECnet was removed two years ago.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1202cdd66531
> 
> MPLS also does not support DECnet via RTA_VIA, see nla_get_via().

FYI, I posted a patch to remove NEIGH_DN_TABLE.
https://lore.kernel.org/netdev/20241014235216.10785-1-kuniyu@amazon.com/T/#u

