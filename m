Return-Path: <netdev+bounces-129547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B41E298463A
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 14:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 696021F23FAD
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 12:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949F01A7271;
	Tue, 24 Sep 2024 12:52:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D741A7040;
	Tue, 24 Sep 2024 12:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727182322; cv=none; b=T9KQyKnUiPbgHIQ1CLeP2BA01jlONjKsYjURzV2X/6sYowgyEg9JmzppMVA8kwenWoBdb8L0mXrHad6wMRe3nK/uCN1rN1xZmM4+rhnVh55jUuvxAMv5ndaETl/jVrAubXImk91S2F9Eke21Ad/H4jiVj1CvuiphK9nnevQKdws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727182322; c=relaxed/simple;
	bh=7+Wnivh5gMS2m/v/PySxyqQQftEbg/uzMWIvMfcAnJY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F6JhM5UX2pj0wxqV7VIWYgpCgvFWnqn24oyKmAKctoqNskZSPQrPO1Kp+U8WlURp6oc4T3Oe9AkwQdlhz8EvNettKGsKVVw8Bd1F3DZ7KSpqTl49/VLKStXxdGNr3oRwAAQOi/iv6HgC89LDKXz8Q/JVz5DQixdivg4znvFf7Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XCflz6FwCz6DB5R;
	Tue, 24 Sep 2024 20:47:59 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D73D1408F9;
	Tue, 24 Sep 2024 20:51:56 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Sep
 2024 14:51:48 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: <lulie@linux.alibaba.com>
CC: <antony.antony@secunet.com>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<dust.li@linux.alibaba.com>, <edumazet@google.com>,
	<fred.cc@alibaba-inc.com>, <jakub@cloudflare.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <steffen.klassert@secunet.com>,
	<willemdebruijn.kernel@gmail.com>, <yubing.qiuyubing@alibaba-inc.com>
Subject: [RFC PATCHv2 net-next 1/3] net/udp: Add a new struct for hash2 slot
Date: Tue, 24 Sep 2024 15:51:01 +0300
Message-ID: <20240924125101.1688823-1-gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240924110414.52618-2-lulie@linux.alibaba.com>
References: <20240924110414.52618-2-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 frapeml500005.china.huawei.com (7.182.85.13)

> @@ -224,13 +224,12 @@ struct sock *__udp6_lib_lookup(const struct net *net,
>  			       struct sk_buff *skb)
>  {
>  	unsigned short hnum = ntohs(dport);
> -	unsigned int hash2, slot2;
>  	struct udp_hslot *hslot2;
>  	struct sock *result, *sk;
> +	unsigned int hash2;
>
>  	hash2 = ipv6_portaddr_hash(net, daddr, hnum);
> -	slot2 = hash2 & udptable->mask;
> -	hslot2 = &udptable->hash2[slot2];
> +	hslot2 = udp_hashslot2(udptable, hash2);
>

Why not minimize the code change by using udptable->hash2[slot2].hslot?
Especially since later you do it in __udp6_lib_mcast_deliver.
I think that many developers would find usage of C primitives more
readable.

