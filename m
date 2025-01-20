Return-Path: <netdev+bounces-159871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13082A173FE
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 22:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75591883318
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 21:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFAF1E9B18;
	Mon, 20 Jan 2025 21:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="jrJ9ATjS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A6B188A0E
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 21:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737407651; cv=none; b=NRDXRfSp/WzvqY8OefGZ74mqXkJZQp1hNHRLvfjrBvtHbSaeAD1DwlYX2L8Q4HR4M1t4jlwdGs2fMehZkW6K7oL+Lx3NxMY1InXXjgELnO40kNOzZj5lcsYNn8ujkkBZ0ixdm1Zbn1RX6pU1fst4r+FdAscsxgL5pPECbJaj34A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737407651; c=relaxed/simple;
	bh=dDaiObEUCJuXNkdiPXiiZviq1Fhr5P1tDBSwVyZkTYw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OXyxR91OcFDFq1G9xWyWccgFsDiqS22yps4WBGiSmLHAbaEBljZb16zFQeXi0gcMbw0YuhvPT67OvweQ+z3gBMgqwovEKjI/haWHhhMvlkzmWkkJGpBMzSxSSLJKfYROCnYMpD0iqZtXZWycy7zfvMjPz4N0Jd7pnwXNJDBKl0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=jrJ9ATjS; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737407647; x=1768943647;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=j1LG0FMxSKGfvKenkdWNkoLg97yHDtjYNKMnKBt2Lz4=;
  b=jrJ9ATjSMZDJhDub+6qF4GOpvOP2ai+4RVTl3GydnJy3aNo8sxz25v1m
   7C6xrbntC3mCQAPR57DQbtMWw6QrgAdye9WsRwf9ZJhCI+Q9fXp0ZbFlI
   wIKQ5i6a9ybYFV9rB70VPxBX02T6weTdRbSl+Jjhdt+uTmrbBlRYb2eL4
   w=;
X-IronPort-AV: E=Sophos;i="6.13,220,1732579200"; 
   d="scan'208";a="690559381"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2025 21:14:03 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:50779]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.114:2525] with esmtp (Farcaster)
 id 853bbeb8-e78d-4df5-a9d2-8565152b5e07; Mon, 20 Jan 2025 21:14:03 +0000 (UTC)
X-Farcaster-Flow-ID: 853bbeb8-e78d-4df5-a9d2-8565152b5e07
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 20 Jan 2025 21:13:58 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.57) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 20 Jan 2025 21:13:56 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next 09/11] ipv6: Move lifetime validation to inet6_rtm_newaddr().
Date: Mon, 20 Jan 2025 13:13:48 -0800
Message-ID: <20250120211348.88128-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250120122945.1bfd7435@kernel.org>
References: <20250120122945.1bfd7435@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA004.ant.amazon.com (10.13.139.93) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 20 Jan 2025 12:29:45 -0800
> On Wed, 15 Jan 2025 17:06:06 +0900 Kuniyuki Iwashima wrote:
> > +	expires = 0;
> > +	flags = 0;
> 
> Any reason not to add these to the cfg struct?
> Because these are not strictly attributes for the address?

Yes, I thought it's for fib6_config, but I have no strong
preference.  I can post a follow-up or v3.

