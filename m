Return-Path: <netdev+bounces-142526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C9C9BF7FC
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 21:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0244B2123E
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 20:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5CC20C03A;
	Wed,  6 Nov 2024 20:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YWgNrkgJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D071DAC88
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 20:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730924926; cv=none; b=j2L/LQKDFPxDFPPPsmHUnXTR6MgSMtpY8Y6PEODEgnjTCNMF92CJ/33QxfMgN9NSDyJNIJJ1Wwz4bow7h7g7K6t6gcnoGYqRFhwqJzeRifnSL7qeOXA4dcBDfuuY9P+5DkNxPBAuvQjKYz2iXzMrQubZfXxL2mjHwTILvzcNY90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730924926; c=relaxed/simple;
	bh=5ASWrUmOUqKEKfoeaun8gJH85BoFCV5nXQrMcAjQ5MA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gwv+kMFt4HCPICSvmYZ4kLZiydzyAletx2n1haGkZNTzjUjzfJj42wPdWhsnOMEaljDVYnkGCM53haAC5J5rgOBVQ9rd2YIvngr2Q5CaKSWS+mSCUkmzjApNg87gHNbhFhfOJgYV4+SHtbSSVaybtWMhSGVg4DOg1abxNYKG/2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=YWgNrkgJ; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730924925; x=1762460925;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qd0E0w3LIYWKlb1vsPSkTK5pnguwwvnu89AOQBNGlQw=;
  b=YWgNrkgJ1ZAD4dJ8zvc1gmFPKbzbr5OflFzI6PMjeY0n5kMaeJenWd++
   SQhG6KjiO86NdkbuR3xIeJoCn48TB5eRpgo3npxAEKK8zajfBcPndgtmZ
   4sgx/g9nTlWij6pMbfJv7XgVXNW7l0Y719Tb/aUNNMSPrST6ZYwXrpIcL
   Q=;
X-IronPort-AV: E=Sophos;i="6.11,263,1725321600"; 
   d="scan'208";a="382987271"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 20:28:40 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:4639]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.80:2525] with esmtp (Farcaster)
 id 4f90f8f9-c1ba-4df5-a6b1-84fe35ece4b9; Wed, 6 Nov 2024 20:28:39 +0000 (UTC)
X-Farcaster-Flow-ID: 4f90f8f9-c1ba-4df5-a6b1-84fe35ece4b9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 6 Nov 2024 20:28:39 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 6 Nov 2024 20:28:36 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <gnaaman@drivenets.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next v8 2/6] neighbour: Define neigh_for_each_in_bucket
Date: Wed, 6 Nov 2024 12:28:32 -0800
Message-ID: <20241106202832.32701-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241104080437.103-3-gnaaman@drivenets.com>
References: <20241104080437.103-3-gnaaman@drivenets.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Gilad Naaman <gnaaman@drivenets.com>
Date: Mon,  4 Nov 2024 08:04:30 +0000
> Introduce neigh_for_each_in_bucket in neighbour.h, to help iterate over
> the neighbour table more succinctly.
> 
> Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

