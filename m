Return-Path: <netdev+bounces-183466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AD1A90BE3
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 21:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88E6519E077C
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 19:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B702C2139C4;
	Wed, 16 Apr 2025 19:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="smKe4Vyp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3A2215F52
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 19:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744830306; cv=none; b=hOVx8bzKyuyau9w6ZIXdT0nv/LxpHXqS8UAlCtq6J2xNB/iR769oy/bN2Nu+B0XugQ+QtGmhGRv0oaTJKudVqKjaoGO+J50PV7qQP/bAR2MubU3spv1+vQWFVZKdUfvJnImUBS2rcG7u+NnGuC9E+rx38ztxGb7/9vzodh4+N+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744830306; c=relaxed/simple;
	bh=fQn2CJ3ZewAXs0R85e6Ocd6wXUrKWjC+ZlsGy4cQkkE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JtCFqnRQ+TkvxtYo/fyxML4dykQztqdkfQgX28ilHImYr3RtoG4Z0vEOR8yV5UN0Skm+Zn62gNZgzx8NLSod86i1roNVk/kELwqgaRltY5Gd2NwuEv1g3TWKQfvv0w1RNRh9Mqyf48xbq31KHRF63713Sv+JNWND23gS84tGaO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=smKe4Vyp; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744830305; x=1776366305;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WkHEBwJEx0GPjmQbFNByuyNcX8zwkwrur8tTxjWkPO8=;
  b=smKe4VyprBdJx5tnLFoXMFHCL+1tphEIWTLE9pKDDRRNIIe08WiJoKe/
   fTs33kms3G95dBrEMMMn5wzUp0c4+f7OSi767PVBAv0B1O7mofh3aZscb
   LA6QklWMgumK/iR+d7BT44OMan1fPVysEE+Wy/ydIe44nJ6XNwV9Nlz2x
   c=;
X-IronPort-AV: E=Sophos;i="6.15,216,1739836800"; 
   d="scan'208";a="188014561"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 19:05:03 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:51274]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.150:2525] with esmtp (Farcaster)
 id 08f98724-4950-4e2e-869a-3262c3a413c7; Wed, 16 Apr 2025 19:05:02 +0000 (UTC)
X-Farcaster-Flow-ID: 08f98724-4950-4e2e-869a-3262c3a413c7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 19:05:02 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 19:04:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH RESEND v2 net-next 14/14] ipv6: Get rid of RTNL for SIOCADDRT and RTM_NEWROUTE.
Date: Wed, 16 Apr 2025 12:04:46 -0700
Message-ID: <20250416190451.3064-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <77c438b9-2186-49f4-b95b-5e2df61a573b@redhat.com>
References: <77c438b9-2186-49f4-b95b-5e2df61a573b@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA003.ant.amazon.com (10.13.139.37) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Wed, 16 Apr 2025 17:26:49 +0200
> On 4/14/25 8:15 PM, Kuniyuki Iwashima wrote:
> > @@ -5250,7 +5252,7 @@ static int rtm_to_fib6_config(struct sk_buff *skb, struct nlmsghdr *nlh,
> >  		cfg->fc_encap_type = nla_get_u16(tb[RTA_ENCAP_TYPE]);
> >  
> >  		err = lwtunnel_valid_encap_type(cfg->fc_encap_type,
> > -						extack, newroute);
> > +						extack, false);
> 
> It looks every caller always pass 'false' as last argument to
> lwtunnel_valid_encap_type(), so such argument could/should be dropped
> (as a follow-up if this is too big)

Yes, it will be a follow-up.

Thanks again for reviewing!

