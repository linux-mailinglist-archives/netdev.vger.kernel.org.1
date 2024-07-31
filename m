Return-Path: <netdev+bounces-114658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EE39435C0
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 20:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E50F92854A3
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 18:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CE04779F;
	Wed, 31 Jul 2024 18:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QfF+w6ou"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0DD381AD
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 18:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722451449; cv=none; b=eqaJfuxR09WikvGlqnwY66lV1KgKS/CmePR2XHnMVv8dLZkWkZtpeTVcqNGYAAHr8czc9IG1MM7AbhKzfjqMUsOFPT43TYb9VLbdAD0JRGH91iIrjuN5tQvoPaN3hVZQrQ1EvdYn0aDLdYqoCzDw0+vRzmd2KgWVyg7d8Sp/zUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722451449; c=relaxed/simple;
	bh=2lWbtXqpHtVYJozojmMEbbQ7rq3n2TGMAcIc+Xzs/14=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h/GgLAs1LTMFWZkfQIQIEx0QHOtbBV40B2vGdS31wUm8LyLjzPRLXMQh2ujy4tWlw+hF+DhQOYrSLSkIuiQlgS4TtqAnwMO9gAAuEPBpZx2PhOTPY+Rpt75tz/qu7KGDY//mPfQYT8U5dQxaBFDd1nsfsevlqJic+HersT7yEYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=QfF+w6ou; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722451448; x=1753987448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z0mZZ0bbSQ5WxoPwdoz0CXze76av2pl0+dBsnBI4NMc=;
  b=QfF+w6ouMT59nUx7mZRaGc/PdVPckGpukKweE4BAY4vNMHDBBxAKao3j
   W1VeocTUJua6yjVEdcttuMnHJmpdyB5fT7VfPKkmH/ZsrC+gAoN9Q/FS2
   qHFcDV6zAFfYMf2SS3Cn5zKJBvtL6GkbkC5lUTOOVMAJw8vcJ5LnB67OQ
   4=;
X-IronPort-AV: E=Sophos;i="6.09,251,1716249600"; 
   d="scan'208";a="359832595"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 18:44:02 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:6379]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.88:2525] with esmtp (Farcaster)
 id 6916a654-9447-4e98-8923-a3e89908aa1f; Wed, 31 Jul 2024 18:44:01 +0000 (UTC)
X-Farcaster-Flow-ID: 6916a654-9447-4e98-8923-a3e89908aa1f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 31 Jul 2024 18:44:00 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.100.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 31 Jul 2024 18:43:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 2/6] net: Don't register pernet_operations if only one of id or size is specified.
Date: Wed, 31 Jul 2024 11:43:49 -0700
Message-ID: <20240731184349.49985-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240730185412.2a18262c@kernel.org>
References: <20240730185412.2a18262c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 30 Jul 2024 18:54:12 -0700
> On Mon, 29 Jul 2024 14:07:57 -0700 Kuniyuki Iwashima wrote:
> > +	if (WARN_ON((ops->id && !ops->size) || (!ops->id && ops->size)))
> 
> I'd write as:
> 
> 	if (WARN_ON(!!ops->id != !!ops->size))
> 
> or
> 
> 	if (WARN_ON(!!ops->id ^ !!ops->size))
> 
> but not 100% sure if it's idiomatic or just my preference..

Actually I wrote the latter first so will use it in v2.
Just not confident about which was easier to read.

Thanks!

