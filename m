Return-Path: <netdev+bounces-86674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6FB89FD75
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 18:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA400286AF9
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 16:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED3A17B501;
	Wed, 10 Apr 2024 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PrXe/Wxh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3927A53361
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712767990; cv=none; b=YJEfwFg8WM71kkmagnbgJmolUcXsJP1LlbmHN4HgFv7/AhEdWzMBAfhdKAxitQ3i7p3HWq8x9lqpmtdiWlDiZ+UvvF3SkEQItb9IlH1oIFMzWeuARKxQtZsTMjRebXkze2zSXr25I4RTDzfuSo8K3mnIo8Nbx6X1xA1aJi1bf0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712767990; c=relaxed/simple;
	bh=1buMSf+mkfPCfxOL+faGtBah4O/LAvls/oJxZ8vwEio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rEdpK18E+lJIEKB7xTw4oyKx8OfuPNE2ArTJc2Nvu0glam7p1D0t+d3fEXmmtstkIu8EWjtCWc4DNhhuvkUQfIUo5xTXPH6tDWnwgNZ7aAXzOcr75t0reNFiBPM/zZzmNv+d5cxX7DyBw4BFhXWzs0bGmZ6NCnzHEqlRbv25nBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=PrXe/Wxh; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712767989; x=1744303989;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B+yKj88z3y4l7/ZiHFtRrafqr/B3YInGuDY21ITbniI=;
  b=PrXe/WxhjNQqIGFVh6529VREo+tEPxwp2kJj17yN8jxG+k65RHUeCHy7
   zzCuoVIiO/09oBICjIgbHJvL6l5coH6TkSKyIrKofATnQvU9LtiVJX6GF
   SkRiXGFzE1E+QbGWOkq9rJhG1p0z4KYca1biVx6Whdel269BZWGqtFntq
   8=;
X-IronPort-AV: E=Sophos;i="6.07,190,1708387200"; 
   d="scan'208";a="80240451"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 16:53:07 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:45279]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.109:2525] with esmtp (Farcaster)
 id efd4fed8-3363-49cc-a331-f80954d1a558; Wed, 10 Apr 2024 16:53:07 +0000 (UTC)
X-Farcaster-Flow-ID: efd4fed8-3363-49cc-a331-f80954d1a558
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 10 Apr 2024 16:53:06 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 10 Apr 2024 16:53:04 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <rao.shoaib@oracle.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
Subject: Re: [PATCH v1 net 3/3] af_unix: Prepare MSG_OOB deprecation.
Date: Wed, 10 Apr 2024 09:52:56 -0700
Message-ID: <20240410165256.5843-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <0ff1d6c8-d56d-4f73-b5be-d0ce2a223d28@oracle.com>
References: <0ff1d6c8-d56d-4f73-b5be-d0ce2a223d28@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Rao Shoaib <rao.shoaib@oracle.com>
Date: Wed, 10 Apr 2024 01:36:01 -0700
> It is used by Oracle products.

This is what I wanted to know, and then I'm fine to respin v2
without this patch.

Thank you.


> File bugs and someone from Oracle will 
> fix it (most likely me). Oracle has addressed any bugs reported in a 
> very timely manner. So in summary the feature is being used and is 
> actively maintained.
>
> You can also turn off the feature in your private/closed distro and not 
> worry about it.
> 
> That is all I have to say on this subject.
> 
> Shoaib

