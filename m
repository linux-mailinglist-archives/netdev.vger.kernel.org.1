Return-Path: <netdev+bounces-174963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 407D2A61AB9
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 20:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84C76171454
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 19:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C19156F44;
	Fri, 14 Mar 2025 19:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cAk5r7vo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603711E521;
	Fri, 14 Mar 2025 19:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741980905; cv=none; b=tHjtg0sC8+Qr67I6gqI5UIusad/dgicETHiqK2jr48nkphFJqjIqkGEEbj5GgiT7eY6OVL9ZuZ8XAWWzjPF2FzT/N8sgrKPznPqeUL1v3K0VQJmj9ClN61ZPGqSicUbuXox/PTtXhmp4bY53FxtonuB0KSMsc1Mvf6oL0fo1zNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741980905; c=relaxed/simple;
	bh=u6pYaIUSlIhp06+qImIcSSLIYJdqfmb5VYF7EzlNOtw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X4JUpJ7VlQJMc/cigeZAokRIWGfwktT0NC7YJtfyc302h5g1b9fa4yKg8DiuG5nIQZZi2BB/KfuXhtbLFmngTJfwkzKCkBOcIBRacO0ABOODOQQQHP5XmpjM6Hl1JwxeB5IDj2wqsZi4UBgwsJ6yWjqTH+9hiHYex0GH2peIOuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=cAk5r7vo; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741980905; x=1773516905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uuc0tqWY3GKjPk2lk41qIHNDa1aDEdFdztuPFonfLZI=;
  b=cAk5r7vohCNincUhWYK7I2sZMtSkNrk8XOJ3dBol+vuuC7iRu0omRUiM
   F3HGLNFtwjV0HpoB0LwTEhEI1BcSoaIsaLEOwm5cIi05+VSLrE1J5MQat
   o2U9L0LTX83HbI8eOXtqHn+Ol0UCxW4Ey5VKPtri6nyp8dwjAz5EA6Oar
   w=;
X-IronPort-AV: E=Sophos;i="6.14,246,1736812800"; 
   d="scan'208";a="32025508"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2025 19:35:03 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:28298]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.127:2525] with esmtp (Farcaster)
 id 8dd8bf03-971d-4054-a1a3-49ad34eff961; Fri, 14 Mar 2025 19:35:02 +0000 (UTC)
X-Farcaster-Flow-ID: 8dd8bf03-971d-4054-a1a3-49ad34eff961
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 14 Mar 2025 19:34:56 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.227.109) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 14 Mar 2025 19:34:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <linma@zju.edu.cn>
CC: <davem@davemloft.net>, <edumazet@google.com>, <gnaaman@drivenets.com>,
	<horms@kernel.org>, <joel.granados@kernel.org>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>, <lizetao1@huawei.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH net] net/neighbor: add missing policy for NDTPA_QUEUE_LENBYTES
Date: Fri, 14 Mar 2025 12:34:44 -0700
Message-ID: <20250314193445.26852-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250314155237.81071-1-linma@zju.edu.cn>
References: <20250314155237.81071-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Lin Ma <linma@zju.edu.cn>
Date: Fri, 14 Mar 2025 23:52:37 +0800
> Previous commit 8b5c171bb3dc ("neigh: new unresolved queue limits")
> introduces new netlink attribute NDTPA_QUEUE_LENBYTES to represent
> approximative value for deprecated QUEUE_LEN. However, it forgot to add
> the associated nla_policy in nl_ntbl_parm_policy array. Fix it with one
> simple NLA_U32 type policy.
> 
> Fixes: 8b5c171bb3dc ("neigh: new unresolved queue limits")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> ---
>  net/core/neighbour.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index bd0251bd74a1..b4f89fbb59df 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -2250,6 +2250,7 @@ static const struct nla_policy nl_neightbl_policy[NDTA_MAX+1] = {
>  static const struct nla_policy nl_ntbl_parm_policy[NDTPA_MAX+1] = {
>  	[NDTPA_IFINDEX]			= { .type = NLA_U32 },
>  	[NDTPA_QUEUE_LEN]		= { .type = NLA_U32 },
> +	[NDTPA_QUEUE_LENBYTES]	= { .type = NLA_U32 },

Please keep this line alinged with other lines; add one more tab
before '='.


>  	[NDTPA_PROXY_QLEN]		= { .type = NLA_U32 },
>  	[NDTPA_APP_PROBES]		= { .type = NLA_U32 },
>  	[NDTPA_UCAST_PROBES]		= { .type = NLA_U32 },
> -- 
> 2.39.0

