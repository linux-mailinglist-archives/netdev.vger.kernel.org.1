Return-Path: <netdev+bounces-180424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A6EA8147A
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 20:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA398885AA1
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D6323E333;
	Tue,  8 Apr 2025 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bzy5346g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546A522D4E3;
	Tue,  8 Apr 2025 18:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744136497; cv=none; b=bRD+TLmP6MFC4N6PSMPAOdqYRIf0py7jOuq92tQKc0n3+OnGx3kcilmrBseBPYWyQrniPUKGkQdMy9APE3CLj3xqp5WOBK40HUg/tyhXJhqkseqvURD8gr1Q4PWcBOCuwd/pJ4gKO5PYGrN93zCE9MY0l+WQZUJ3oBmCpjCPBe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744136497; c=relaxed/simple;
	bh=w/wtZwp4S+W1MVCbnnYE1DIpmI5YnNFyH4JdLkLeeH4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p1Rj5Za2eBj5k9KSMfJiGHKfaf8TRkKv5Nly/s9R3BGdML5RcZz4HP96te+E+MqWMAplOGs4X0KkZoS3KMUjPZFT4sNhoyFV7lVrEdeXo73YlrgWoNBAhU1CUVBzgqQxudJZMx1YkMwthKOv4PaR7J+RNfGIEY5g8nrBKyw+zRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bzy5346g; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744136496; x=1775672496;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OEXDD2pAHOlDSkU4MwJdAg7iSPu5cX3tXDgUUdSq4cc=;
  b=bzy5346gCm2AZlQJjWfYMUEo1Wzc8tSNzTCdNe/tzGbsLvro8faLlh4l
   pSLp17RncebiuZFgC6HlDvvhkCoL7l4G24XYX49ootbfpMgFABqUM9d3B
   Ej9HGwDan1QjcbD/n8mdqEZrz22CJjo174ZtpNhr62UhKol4/DQonPjiN
   g=;
X-IronPort-AV: E=Sophos;i="6.15,198,1739836800"; 
   d="scan'208";a="487699298"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 18:21:30 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:12463]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.132:2525] with esmtp (Farcaster)
 id b5d6e786-97b8-4ca7-acd1-d064dc9b4553; Tue, 8 Apr 2025 18:21:29 +0000 (UTC)
X-Farcaster-Flow-ID: b5d6e786-97b8-4ca7-acd1-d064dc9b4553
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Apr 2025 18:21:27 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 8 Apr 2025 18:21:24 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <zijun_hu@icloud.com>
CC: <dada1@cosmosbay.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <quic_zijuhu@quicinc.com>, <willemb@google.com>,
	<xemul@openvz.org>
Subject: Re: [PATCH net-next] sock: Correct error checking condition for assign|release_proto_idx()
Date: Tue, 8 Apr 2025 11:21:14 -0700
Message-ID: <20250408182116.45882-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250408-fix_net-v1-1-375271a79c11@quicinc.com>
References: <20250408-fix_net-v1-1-375271a79c11@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA002.ant.amazon.com (10.13.139.81) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 08 Apr 2025 21:42:34 +0800
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> assign|release_proto_idx() wrongly check find_first_zero_bit() failure
> by condition '(prot->inuse_idx == PROTO_INUSE_NR - 1)' obviously.
> 
> Fix by correcting the condition to '(prot->inuse_idx == PROTO_INUSE_NR)'
> Also check @->inuse_idx before accessing @->val[] to avoid OOB.
> 
> Fixes: 13ff3d6fa4e6 ("[SOCK]: Enumerate struct proto-s to facilitate percpu inuse accounting (v2).")
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  include/net/sock.h | 5 ++++-
>  net/core/sock.c    | 7 +++++--
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 8daf1b3b12c607d81920682139b53fee935c9bb5..9ece93a3dd044997276b0fa37dddc7b5bbdacc43 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -1421,7 +1421,10 @@ struct prot_inuse {
>  static inline void sock_prot_inuse_add(const struct net *net,
>  				       const struct proto *prot, int val)
>  {
> -	this_cpu_add(net->core.prot_inuse->val[prot->inuse_idx], val);
> +	unsigned int idx = prot->inuse_idx;
> +
> +	if (likely(idx < PROTO_INUSE_NR))
> +		this_cpu_add(net->core.prot_inuse->val[idx], val);

How does the else case happen ?


>  }
>  
>  static inline void sock_inuse_add(const struct net *net, int val)
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 323892066def8ba517ff59f98f2e4ab47edd4e63..92f4618c576a3120bcc8e9d03d36738b77447360 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -3948,6 +3948,9 @@ int sock_prot_inuse_get(struct net *net, struct proto *prot)
>  	int cpu, idx = prot->inuse_idx;
>  	int res = 0;
>  
> +	if (unlikely(idx >= PROTO_INUSE_NR))

Same here.


> +		return 0;
> +
>  	for_each_possible_cpu(cpu)
>  		res += per_cpu_ptr(net->core.prot_inuse, cpu)->val[idx];
>  
> @@ -3999,7 +4002,7 @@ static int assign_proto_idx(struct proto *prot)
>  {
>  	prot->inuse_idx = find_first_zero_bit(proto_inuse_idx, PROTO_INUSE_NR);
>  
> -	if (unlikely(prot->inuse_idx == PROTO_INUSE_NR - 1)) {
> +	if (unlikely(prot->inuse_idx == PROTO_INUSE_NR)) {
>  		pr_err("PROTO_INUSE_NR exhausted\n");
>  		return -ENOSPC;
>  	}
> @@ -4010,7 +4013,7 @@ static int assign_proto_idx(struct proto *prot)
>  
>  static void release_proto_idx(struct proto *prot)
>  {
> -	if (prot->inuse_idx != PROTO_INUSE_NR - 1)
> +	if (prot->inuse_idx != PROTO_INUSE_NR)
>  		clear_bit(prot->inuse_idx, proto_inuse_idx);
>  }
>  #else
> 
> ---
> base-commit: 34a07c5b257453b5fcadc2408719c7b075844014
> change-id: 20250405-fix_net-3e8364d302ff
> 
> Best regards,
> -- 
> Zijun Hu <quic_zijuhu@quicinc.com>

