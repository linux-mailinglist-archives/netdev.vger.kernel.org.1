Return-Path: <netdev+bounces-181052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19CCA8376B
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 05:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE112443E96
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 03:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20611F0E34;
	Thu, 10 Apr 2025 03:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ytpi1G9Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF46763B9;
	Thu, 10 Apr 2025 03:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744257235; cv=none; b=on1JjtgTloDTHHEd/pX1mW6x/x64czGqegbktaJn6/qwKroUB4K9qSGs9t7kE3Yi3919zH8WgfNasv/TeC+ptrcy2o+H2RPL6fpSCZpjnsLcIZ6dtp0jxI8SeiAVvIRNKU7ReZnhhkxt4g2GdPmQJy5H1MogHap3nnCbpF6pl4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744257235; c=relaxed/simple;
	bh=MvSveTKGzuHPxV7zmQJcTgZJSm9PvBc8MfXIc+knpbA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s5w2cwnyZ7pewHICUCpKZothFp8pA7wMmmNUvZ3R1cWtsTo95Kadwvvw5vaKoTSzc8H4q38oHFNL/EC/IcvUmrRTkBb62ySxgIsiaDR1UtK0rSVRpEr0DC7IUry56b8Pc7mw4JgTsZppt6Kh230RUnTPmJqTWz187OWU5x5Sih4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Ytpi1G9Y; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744257234; x=1775793234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CmU79LkKcLpR1+rc6dP6IimxkoEC9s58c2Q8VzFz5qw=;
  b=Ytpi1G9Ymcc7gKQOzVCGhsuaheDxZvb9IuoCbK0dt6hIRc5XwCGggPtd
   vUDvSCrVOjoVL1lDX1jEoeHL7qkj53bAmTlKBUwKA3DA1i+nUQM/7cEqy
   IUg8M4fuZnYhNNq0hQdeYwxoVwXvd0nuqdFt3LXHXjRmMA90g+nMs4+fZ
   k=;
X-IronPort-AV: E=Sophos;i="6.15,201,1739836800"; 
   d="scan'208";a="814851038"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 03:53:47 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:64291]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.147:2525] with esmtp (Farcaster)
 id 9e7fb818-17e6-44cc-8de9-ff6c8e677134; Thu, 10 Apr 2025 03:53:47 +0000 (UTC)
X-Farcaster-Flow-ID: 9e7fb818-17e6-44cc-8de9-ff6c8e677134
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 03:53:45 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 03:53:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <zijun_hu@icloud.com>
CC: <dada1@cosmosbay.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <quic_zijuhu@quicinc.com>, <willemb@google.com>,
	<xemul@openvz.org>
Subject: Re: [PATCH net-next v2] sock: Correct error checking condition for (assign|release)_proto_idx()
Date: Wed, 9 Apr 2025 20:53:26 -0700
Message-ID: <20250410035328.23034-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410-fix_net-v2-1-d69e7c5739a4@quicinc.com>
References: <20250410-fix_net-v2-1-d69e7c5739a4@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

> [PATCH net-next v2] sock: Correct error checking condition for (assign|release)_proto_idx()

Maybe net instead of net-next ?


From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 10 Apr 2025 09:01:27 +0800
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> (assign|release)_proto_idx() wrongly check find_first_zero_bit() failure
> by condition '(prot->inuse_idx == PROTO_INUSE_NR - 1)' obviously.
> 
> Fix by correcting the condition to '(prot->inuse_idx == PROTO_INUSE_NR)'
> 
> Fixes: 13ff3d6fa4e6 ("[SOCK]: Enumerate struct proto-s to facilitate percpu inuse accounting (v2).")
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

