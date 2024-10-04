Return-Path: <netdev+bounces-132270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C366991258
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 00:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 356131F239BB
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12D314659A;
	Fri,  4 Oct 2024 22:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NeSJBxX0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2284A13B59A
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 22:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728081160; cv=none; b=TNRZ0lTICcDJfb7+cN6s8OjynQPMG2zARJ3RbmBzGz4UFUXwkSn0/OCkWt79/jyzCehbg9RuhJrLsdS/fWAOx3TU/MO7o31AfkycFx5QinAUp1iFOAZuBHJqctLcbz8H1AjlwkS4+JM/x0JS5aeg2KjeaJNVoD3wlxSpZF7g7OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728081160; c=relaxed/simple;
	bh=VSAsbxDvxYsPDcIVxb7coa8991kkx/AMAqEou1kWbAA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qu61Au4sZTtn5vA4cu5uHqYps4z3Bo6PTMcPOPibycvA5pdDPiHSCk7JCVef6RQZaccbOdcpZYSAsPd47k9EmQ2Hkr6++T+wk83MuMrThZ3tYiV1q6V4KMdSsoh15bbTA3Tai/nLd5xxDjZdIYWUF3O4zb4HW2OSVw/xvXJU3Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NeSJBxX0; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728081160; x=1759617160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xdhEA9ZT+f7zF6MV2ptJP9SbichfddEnth530Zg4noU=;
  b=NeSJBxX0ERouchg/k8Eqv2dZppVqAOpIjfnlEr80lf4NYfyNbTY2UHRq
   OWefnPR9NYMZNEhdDIV/+YBYCTN1cO2WU4H1hnC47mnqanwPc1v1Qi3E1
   HNqqXMYI+nw9fE7XZMn7oMO2bN5YjfYFS7DkAYOuw/q60YtERThY7i5bE
   s=;
X-IronPort-AV: E=Sophos;i="6.11,178,1725321600"; 
   d="scan'208";a="30768216"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 22:32:38 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:58359]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.158:2525] with esmtp (Farcaster)
 id b274c8c2-566a-4d12-9618-8401cf088a75; Fri, 4 Oct 2024 22:32:36 +0000 (UTC)
X-Farcaster-Flow-ID: b274c8c2-566a-4d12-9618-8401cf088a75
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 22:32:36 +0000
Received: from 88665a182662.ant.amazon.com (10.88.184.239) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 4 Oct 2024 22:32:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <alexandre.ferrieux@orange.com>, <davem@davemloft.net>,
	<dsahern@kernel.org>, <eric.dumazet@gmail.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/4] ipv4: remove fib_devindex_hashfn()
Date: Fri, 4 Oct 2024 15:32:24 -0700
Message-ID: <20241004223224.81122-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241004134720.579244-2-edumazet@google.com>
References: <20241004134720.579244-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri,  4 Oct 2024 13:47:17 +0000
> fib_devindex_hashfn() converts a 32bit ifindex value to a 8bit hash.
> 
> It makes no sense doing this from fib_info_hashfn() and
> fib_find_info_nh().
> 
> It is better to keep as many bits as possible to let
> fib_info_hashfn_result() have better spread.
> 
> Only fib_info_devhash_bucket() needs to make this operation,
> we can 'inline' trivial fib_devindex_hashfn() in it.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

