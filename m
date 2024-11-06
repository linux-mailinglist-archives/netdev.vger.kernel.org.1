Return-Path: <netdev+bounces-142150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9DA9BDA78
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03A6C283D74
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 00:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D0F1F16B;
	Wed,  6 Nov 2024 00:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="K/n81rFk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6464A4F8A0
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 00:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730853691; cv=none; b=kpnDPog9ABUujGIeVdgev6VQmd4J5FNJIrTyxPk3v+7BzlgXBmajiGtaZCgtvAQkiRkl1+KPLp9uG+IBekVxmXVepEO/ccd90eBQxac6lgMq3qc95DU+oRQNwp4PdKo6IAgSqdfJPFdchCKXMihlMqte3xZa2+0lKbsX71Ht+ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730853691; c=relaxed/simple;
	bh=jrpj1eNYrukCltVGDtq1BaxQb+Ea+gGHl/+tLxE6jx0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CKDmglLtlyhWTCpitK///7gT7LICnK1M7yHR1YCb4fmPQLor3z58Rxpm0zHDUr2UpG26K8CzVOtnVVFpFswxbmo6ukb/4LIuP9ZWSncP19OUrrljDptLMy0HS+Nfk3grRUGXnxzcfWEDLI+tCBKOitrDEtt5IfBJyj6nkSTWYU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=K/n81rFk; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730853690; x=1762389690;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+2XrpfiC/2HpV9qQVdjWnTvrH6MnkAyRn+fC+RFkAu4=;
  b=K/n81rFkIjavHO86AB4ZeONoICLDDMddDwvLIiJnm164Y1uxBv7M76Op
   nt75Qc60LM3TpWlSJ+HZc+zUEEWoJULFIv09lpbO/55ydOc9fB5sZktkJ
   binblt6iCGYNfZU86j+FBBMx14Crf7C7Dyc6bFpBFI1sYP97UZZJ4YfMT
   s=;
X-IronPort-AV: E=Sophos;i="6.11,261,1725321600"; 
   d="scan'208";a="671920862"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 00:41:27 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:32300]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.16:2525] with esmtp (Farcaster)
 id a8f819fb-88ea-4726-a3a5-8b328fbb3d01; Wed, 6 Nov 2024 00:41:25 +0000 (UTC)
X-Farcaster-Flow-ID: a8f819fb-88ea-4726-a3a5-8b328fbb3d01
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 6 Nov 2024 00:41:24 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 6 Nov 2024 00:41:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <andrew+netdev@lunn.ch>, <daniel@iogearbox.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <horms@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <mailhol.vincent@wanadoo.fr>, <mkl@pengutronix.de>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <razor@blackwall.org>
Subject: Re: [PATCH v1 net-next 1/8] rtnetlink: Introduce struct rtnl_nets and helpers.
Date: Tue, 5 Nov 2024 16:41:19 -0800
Message-ID: <20241106004119.1571-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241105163506.7491f5d3@kernel.org>
References: <20241105163506.7491f5d3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB001.ant.amazon.com (10.13.139.132) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 5 Nov 2024 16:35:06 -0800
> On Mon, 4 Nov 2024 18:05:07 -0800 Kuniyuki Iwashima wrote:
> > +EXPORT_SYMBOL(rtnl_nets_add);
> 
> Will you need the export later?
> Current series doesn't use it in modules.

Ah, good catch.  I used it in each drivers in v0 but factorised
it to core, so the symbol no longer need to be exported.

Will remove in v2.

Thanks!

