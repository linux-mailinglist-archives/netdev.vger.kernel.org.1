Return-Path: <netdev+bounces-163804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 497F5A2B9C3
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 04:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780C43A7E07
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 03:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE77B4EB51;
	Fri,  7 Feb 2025 03:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="B7W/5vOC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01765A2D
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 03:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738899091; cv=none; b=U+b2uaYx8LYfrQC0+bkVe+3/eoRRCsgblBexA5410QUMXxZ37Y63s/8XGnHJgEe4/U2OaiOsOs/lapvz+u3lZXQLR4ZmdAesRbv5VPKWgHN4Vf4k09Kg7JxEcMkpuCVaYHn4+K6iKqphc8LLZSEDSf3M0G3IGb1xOfuZ5kIq0N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738899091; c=relaxed/simple;
	bh=4++Ue0T4B5zQhOJrLV1B0rd7csFW6tr3TJnFd5toZuk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CXFfrKsdIPmHpbg+/Vsd5mCJkQtG2YwvJSMj4dsztFJmth8B+tPAUe9gaYVIL34AaOVMVYJ03ERlZZAkLvM2HNGCBCpLJ1ZzOmpHMZ547OjDMh4sC4CGVitXRl5kAmR02Ohi6Uv3ZZF/lOQ1gXRoMxwtr+4fA4r2u9rBi3AoihE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=B7W/5vOC; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738899091; x=1770435091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cEtyaBrJg8GR7KmmVVrdNI3wkuaRh2lBDwZIL75Rsj0=;
  b=B7W/5vOC2Kl9mzCAzR9VT7bPtCA72GGOdZ2Vg9jwEq/Jiz8xq05fw9X6
   /HTQCdrSqg3uYP2n7Sau0bnH68mBhhFIJBecvOj8WAsOqooyHSvFOi5yD
   Ly39yLk62IDQFUB9tkirid9BsWzYqaJhjoM02IhGPp6xP/8JDtdkeA7Vd
   0=;
X-IronPort-AV: E=Sophos;i="6.13,266,1732579200"; 
   d="scan'208";a="464802181"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 03:31:26 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:39551]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.44:2525] with esmtp (Farcaster)
 id 2ce07464-bb52-4df5-88bc-0930e0a71b94; Fri, 7 Feb 2025 03:31:25 +0000 (UTC)
X-Farcaster-Flow-ID: 2ce07464-bb52-4df5-88bc-0930e0a71b94
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 7 Feb 2025 03:31:24 +0000
Received: from 6c7e67bfbae3.amazon.com (10.118.243.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 7 Feb 2025 03:31:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <ncardwell@google.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next] tcp: do not export tcp_parse_mss_option() and tcp_mtup_init()
Date: Fri, 7 Feb 2025 12:31:12 +0900
Message-ID: <20250207033112.46144-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250206093436.2609008-1-edumazet@google.com>
References: <20250206093436.2609008-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC001.ant.amazon.com (10.13.139.197) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Thu,  6 Feb 2025 09:34:36 +0000
> These two functions are not called from modules.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

