Return-Path: <netdev+bounces-165817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5F8A336CF
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 05:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77601640F3
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 04:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D4C41C6A;
	Thu, 13 Feb 2025 04:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QrFQCtyc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D73D2063DA
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 04:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739420437; cv=none; b=XjqVmPRHvrTqFBvr77ESDejeW8rfiaVQii39wfU2PjNVO7rHh8o04FEA95b4NTUSr+dLqb/UtYLVZIwgqalDxBTDWenygXqtAYgnc/G9a8EQlUacnQBabjJ1lxa/6/7ve0kQvLrqUSVUFuPFqTJS+zstDNggykMUXT4ERtk731I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739420437; c=relaxed/simple;
	bh=GYX8efpz8hfwBimZ5FvgvvnBwWH/DufJNl96Tu+20R0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P1JprSb4NO73EcZbvfWElV4I/IRIAq3fSUyoRcihdmA3FumTlYkOKmGaio387aMvTirzk2+1BmG/+tX1tTsVRhcJhnUjpUWgKi8eT92CgnduOAbrtaw362Pnm1VMxM/pcc+sXGH2QlPHeq0ZrDPdxLofrjFW+Nf8RsPtDXeR6Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=QrFQCtyc; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739420437; x=1770956437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=29l9mthmpqUYTOFINgvO0y4kBGvDGGIo2PwSIp6tJBk=;
  b=QrFQCtycEQeO+aRxSk3CiteinM3OpdmHotTdhXklQ0eDoy19Ia4MlM4V
   a2AZfsGeiJBV58So1vGJF+EoIjHbvSBiLVADK0/1cVqxYkAp59Tn4hKyO
   SILB87pgF8PP+1CTyFnW0DRgz6BRh1lUMwk4JHn6q/5gH9WKZBFV98ll6
   U=;
X-IronPort-AV: E=Sophos;i="6.13,281,1732579200"; 
   d="scan'208";a="408212099"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 04:20:31 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:19610]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.133:2525] with esmtp (Farcaster)
 id b89387e0-51b2-4f9a-b25d-5d19bad7a502; Thu, 13 Feb 2025 04:20:30 +0000 (UTC)
X-Farcaster-Flow-ID: b89387e0-51b2-4f9a-b25d-5d19bad7a502
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 04:20:29 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Feb 2025 04:20:25 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <mateusz.polchlopek@intel.com>,
	<ncardwell@google.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<sd@queasysnail.net>, <willemb@google.com>
Subject: Re: [PATCH v2 net-next 3/4] tcp: use EXPORT_IPV6_MOD[_GPL]()
Date: Thu, 13 Feb 2025 13:20:14 +0900
Message-ID: <20250213042014.89490-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250212132418.1524422-4-edumazet@google.com>
References: <20250212132418.1524422-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC001.ant.amazon.com (10.13.139.213) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Wed, 12 Feb 2025 13:24:17 +0000
> Use EXPORT_IPV6_MOD[_GPL]() for symbols that don't need
> to be exported unless CONFIG_IPV6=m
> 
> tcp_hashinfo and tcp_openreq_init_rwin() are no longer
> used from any module anyway.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

allmodconfig + IPV6=y built successfully.

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

