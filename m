Return-Path: <netdev+bounces-183938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D6AA92CC4
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8258D446EE0
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA333204C0C;
	Thu, 17 Apr 2025 21:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="uwCbgFJv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0151F1172A;
	Thu, 17 Apr 2025 21:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744925878; cv=none; b=eFUaJwpQAK1+/0w80EIKby+Pb9uVYSAnru2FqBJjk0zcA4Gkq+UpECm4C2xU3Xu7EOqLUquNYJQI3OcdTXtlFtLt6yKmedxs4tJJO439bJsUCqTg2ivGqPqgEOQUdxJlC0V706zfJyCvO8Ti0Q6KaOStIav4cwOfVpzZjSlUeis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744925878; c=relaxed/simple;
	bh=dI/u1brOTbBY2QYC6N8ep8vlRUgehf+HocCQycmvAdo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E/pNYvllNwCNL8VBLacZqKXTqBrBvKdBG1iI1GKDrPG1unbeVsrU3ge1iMohgFLF4+wVr6tqa8JtoD1AXCSlkQxM+U6v+rMnRVbyOfynuxniiaCG3l48wsBx5giO6AHGMHXbAZzYrKwYzg4CSXyKgUYZfT/7+XdwHXsn4ShSmF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=uwCbgFJv; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744925877; x=1776461877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4nvjTcRRhpvpvzeZTi0W+LdOXLTC6ANdSWk96jB5ZcE=;
  b=uwCbgFJvS4W8bXhMPZrsImAv0p3u6u9FzdzjpzUX/ThYK2peDi9YLHiU
   uEC3m+KmNnkB+6eOoc46b7QK7SnzX/N0hlc1RriFjDgNuc4jQpYwimM1c
   0ARmOSS32vctDTNdkeugUvEyW+2Ni/3zCX1WUauARe3utpcsOdFbxrGa8
   g=;
X-IronPort-AV: E=Sophos;i="6.15,220,1739836800"; 
   d="scan'208";a="481402247"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 21:37:54 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:45462]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.80:2525] with esmtp (Farcaster)
 id 7b6f323c-b0bf-4282-9d13-df81afde94ba; Thu, 17 Apr 2025 21:37:53 +0000 (UTC)
X-Farcaster-Flow-ID: 7b6f323c-b0bf-4282-9d13-df81afde94ba
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 17 Apr 2025 21:37:52 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 17 Apr 2025 21:37:49 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <leitao@debian.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kernel-team@meta.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/2] net: Use nlmsg_payload in rtnetlink file
Date: Thu, 17 Apr 2025 14:37:39 -0700
Message-ID: <20250417213741.19342-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417-nlmsg_v3-v1-2-9b09d9d7e61d@debian.org>
References: <20250417-nlmsg_v3-v1-2-9b09d9d7e61d@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB003.ant.amazon.com (10.13.139.157) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Breno Leitao <leitao@debian.org>
Date: Thu, 17 Apr 2025 06:03:08 -0700
> Leverage the new nlmsg_payload() helper to avoid checking for message
> size and then reading the nlmsg data.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!

