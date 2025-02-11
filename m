Return-Path: <netdev+bounces-164971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D46BCA2FF2D
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 01:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF591886BFC
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 00:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F67C1D514A;
	Tue, 11 Feb 2025 00:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PJQMFmG1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDEA1D416B;
	Tue, 11 Feb 2025 00:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739233945; cv=none; b=rlz8iUZge3SZ+aeQ0wfXues3j1DwvbJ1fUe/MPfVErFSINb9UXzMNs3vLDxyL2MmGI2eN9ZSpvL1W9/XYZ8Ucr177Lp8XkI6/SD+plXWtamUPREsM2iw6MRx68osQDTyve/lx6s9+SOvaX96qMsYERATSWDwG0dBVaqD/kgx7vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739233945; c=relaxed/simple;
	bh=8hnEEwumIACI2RGCX/n0ZCe7bepAH5Rf/UlOnNZ2eI0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OIE0e31sh/C+PmVjMh94NyKn9a9FezVqGs8mZq+fa+3fQ5y/K0+6VuzvIFrIxVp9CDaT7lXAHQJlgma+UHzWJ4obY4K+cbU/xOa5Zocm3WwJu3u383NgpcJFkBfXqHMV4mtaQ8bWwTx5OIu+lX/lj8SIJyk1vhA+lSx5HJhIMrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=PJQMFmG1; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739233944; x=1770769944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oodxLLIagUSjNK4OaEfKhxTLV4oY43xwOMwvm4NsIGg=;
  b=PJQMFmG1o9acKBlt80iAj4fl5hiGsyINKVAdYnJb7PNXaMQBfCDRy2zI
   74JrSlBMCVkwJA8p+aH3YpCUqMG5+S85sldw49/ZzdT2EB4gHhuB4PH/h
   88tAM9OmTIfaz3scVQVe/rkJ+E6K9bZhdb+bJLRQZW5PKRsqBwZRkA3tU
   w=;
X-IronPort-AV: E=Sophos;i="6.13,275,1732579200"; 
   d="scan'208";a="461407162"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 00:32:20 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:20934]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.40.1:2525] with esmtp (Farcaster)
 id c2741c6b-ce1f-40ff-9b5d-df50ce218835; Tue, 11 Feb 2025 00:32:19 +0000 (UTC)
X-Farcaster-Flow-ID: c2741c6b-ce1f-40ff-9b5d-df50ce218835
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 11 Feb 2025 00:32:18 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.10.138) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 11 Feb 2025 00:32:14 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <purvayeshi550@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <skhan@linuxfoundation.org>, Kuniyuki Iwashima
	<kuniyu@amazon.com>
Subject: Re: [PATCH net-next v2] af_unix: Fix undefined 'other' error
Date: Tue, 11 Feb 2025 09:32:03 +0900
Message-ID: <20250211003203.81463-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250210075006.9126-1-purvayeshi550@gmail.com>
References: <20250210075006.9126-1-purvayeshi550@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA002.ant.amazon.com (10.13.139.121) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Purva Yeshi <purvayeshi550@gmail.com>
Date: Mon, 10 Feb 2025 13:20:06 +0530
> Fix issue detected by smatch tool:
> An "undefined 'other'" error occur in __releases() annotation.
> 
> Fix an undefined 'other' error in unix_wait_for_peer() caused by  
> __releases(&unix_sk(other)->lock) being placed before 'other' is in  
> scope. Since AF_UNIX does not use Sparse annotations, remove it to fix  
> the issue.  
> 
> Eliminate the error without affecting functionality.  

The 5 lines of the 3 sentences above have trailing double spaces.
You may want to configure your editor to highlight them.

e.g. for emacs

(setq-default show-trailing-whitespace t)


> 
> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>

Otherwise looks good.

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

