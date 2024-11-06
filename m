Return-Path: <netdev+bounces-142157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5EE9BDAC8
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAD271C22E29
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 00:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7821547DE;
	Wed,  6 Nov 2024 00:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="r8gJ6i7S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE86113D52B
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 00:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730854716; cv=none; b=DRO5D1q1ygZt5UJwFZYOoEcPLaox/gdFtHqrOkwhZtJsuDEqRlgbNi/DJZd0UnJUZ6UUP4JbadPUPw+uanO2D/bbkljQi3gUpefRxnrgE0teKEAl7l91pXPq+whyUM0IF/MrAUCe2QSuW9bLkSIfeSut+tJ0axVkjNWeb4iEtfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730854716; c=relaxed/simple;
	bh=wdGbt4mg2Su2rk6udi8v26wBZOuSHBlU++Zpl1RKapk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lz3aecozqgk4agqm5JhUqRm+gakmZkfDsx6KrotMYD0tELYRw0vUuFyua0KWsmgkTW426RmkFocmYx+4DqoQQVRxw66PGHwn66Q/XjAZgqEn/rf2vbuA5lEmdlUm3cPi3RUewpg9Ttr26yuy4grGwF0UJkKEBk8H8enix+H6bEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=r8gJ6i7S; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730854715; x=1762390715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9gRaAqHOAcTiAlLAj0++sKU5P/TtoMr5iPmsg0Zg84I=;
  b=r8gJ6i7S2vu/Qn6brWZRhqX75bxkNvKL5RGMVPRkk1hw8IuXcMKbDI3P
   BYzprmPbU888nd9l4ZqsXoDrBYfUkjHClOf9EKQysQZS6COBt9milj/sD
   31tfC/rwUzBqXLPbCbCOu759RovB6/PmzFE2TjpTwtG6CMw+qTOJEetWc
   o=;
X-IronPort-AV: E=Sophos;i="6.11,261,1725321600"; 
   d="scan'208";a="671923456"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 00:58:32 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:53039]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.121:2525] with esmtp (Farcaster)
 id 78e1d9b0-4b59-47d6-9fca-c58790d66f0a; Wed, 6 Nov 2024 00:58:31 +0000 (UTC)
X-Farcaster-Flow-ID: 78e1d9b0-4b59-47d6-9fca-c58790d66f0a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 6 Nov 2024 00:58:30 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 6 Nov 2024 00:58:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <andrew+netdev@lunn.ch>, <daniel@iogearbox.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <horms@kernel.org>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <mailhol.vincent@wanadoo.fr>, <mkl@pengutronix.de>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <razor@blackwall.org>
Subject: Re: [PATCH v1 net-next 3/8] rtnetlink: Add peer_type in struct rtnl_link_ops.
Date: Tue, 5 Nov 2024 16:58:25 -0800
Message-ID: <20241106005825.3537-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241106005237.2696-1-kuniyu@amazon.com>
References: <20241106005237.2696-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC004.ant.amazon.com (10.13.139.254) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Tue, 5 Nov 2024 16:52:37 -0800
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Tue, 5 Nov 2024 16:39:57 -0800
> > On Tue, 5 Nov 2024 16:39:11 -0800 Jakub Kicinski wrote:
> > > On Mon, 4 Nov 2024 18:05:09 -0800 Kuniyuki Iwashima wrote:
> > > > +	const unsigned char	peer_type;  
> > > 
> > > technically netlink attr types are 14b wide or some such
> > 
> > I guess compiler will warn if someone tries to use < 255
> 
> I chose 1 just because all of the three peer attr types were 1.

s/chose 1/chose u8/ :)


> Should peer_type be u16 or extend when a future device use >255 for
> peer ifla ?
> 
>   VETH_INFO_PEER
>   VXCAN_INFO_PEER
>   IFLA_NETKIT_PEER_INFO

