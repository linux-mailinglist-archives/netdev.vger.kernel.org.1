Return-Path: <netdev+bounces-131859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 627C698FBC9
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 03:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ECFF282079
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 01:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE951D5AB3;
	Fri,  4 Oct 2024 01:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="MYMD4QOA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364D71862
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 01:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728003662; cv=none; b=i+v/dFsRqDPD0e76JW7V/8/MlROIWIjkaeKSRKCbrwLEfg3mbACqd82arbMU2qc4qkkvOJYGelEA11I6PoAGHA3WmKhlDer5aibKES/uuA1/mQuLfSoSQ2VRJHBzzc5L/sJYSwYuixtAlfTCmSZXTmbEuSPM21EHB+86jRAll40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728003662; c=relaxed/simple;
	bh=EYP8pSgM8E/aGc55smk0namPehCl8IaAj/HXUD/J7Aw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJ7D6aBZvve9CclzP5VcJXrkTum5zA4TToI0tBcohbZG/Iq/hFDVnX43vdxnC2TogzlZy/GhbOw4scejnjxqnaNTE0YlfYNejFAEAw0S+OBBTAZPOeMf3Kd9B1D+e9G96SuX+aMbLKZYkGN7D6HB3e2s9/te4XQ9oWt9BdwC5Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=MYMD4QOA; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728003662; x=1759539662;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8vGMHm8S6n4bA0GeGT28M8Dr9U9LgqX6K0GMDsxw8hs=;
  b=MYMD4QOA/2eCgnF/oUU8MVmJiYzTV435PLidYuabfALbmsW/Uw9FiSJI
   adLrVqjtTTzjdF/8EF3pNiG4miJLyq8N8G1fXqgvck0zhRsccVUNdyUxs
   cH7lkym7O2p0Hwgt/VjF0VDMU8nvB5vc4DbPNJ3DFefo9e/4E6CHT/Cbq
   8=;
X-IronPort-AV: E=Sophos;i="6.11,176,1725321600"; 
   d="scan'208";a="339430159"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 01:01:00 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:60347]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.37.239:2525] with esmtp (Farcaster)
 id 1ab0cb2e-af65-47ec-8df1-2f723b07ef24; Fri, 4 Oct 2024 01:00:58 +0000 (UTC)
X-Farcaster-Flow-ID: 1ab0cb2e-af65-47ec-8df1-2f723b07ef24
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 01:00:58 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 4 Oct 2024 01:00:56 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <jk@codeconstruct.com.au>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <matt@codeconstruct.com.au>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net 4/6] mctp: Handle error of rtnl_register_module().
Date: Thu, 3 Oct 2024 18:00:48 -0700
Message-ID: <20241004010048.30542-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241003173928.55b74641@kernel.org>
References: <20241003173928.55b74641@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 3 Oct 2024 17:39:28 -0700
> On Thu, 3 Oct 2024 13:57:23 -0700 Kuniyuki Iwashima wrote:
> > Since introduced, mctp has been ignoring the returned value
> > of rtnl_register_module(), which could fail.
> > 
> > Let's handle the errors by rtnl_register_module_many().
> > 
> > Fixes: 583be982d934 ("mctp: Add device handling and netlink interface")
> > Fixes: 831119f88781 ("mctp: Add neighbour netlink interface")
> > Fixes: 06d2f4c583a7 ("mctp: Add netlink route management")
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> 
> Build's unhappy about the section markings:
> 
> WARNING: modpost: vmlinux: section mismatch in reference: mctp_init+0xb7 (section: .init.text) -> mctp_neigh_exit (section: .exit.text)

Thanks for catching, will remove __exit from mctp_neigh_exit().

BTW what option is needed to reproduce it ?
I tried W=1 C=1 but didn't see that warning.

