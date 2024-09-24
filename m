Return-Path: <netdev+bounces-129540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E10499845F7
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 14:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 970A21F211DA
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 12:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285C11A7247;
	Tue, 24 Sep 2024 12:32:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC631A4F3E;
	Tue, 24 Sep 2024 12:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727181138; cv=none; b=pV24us5GAV5puEY0oK0vcHM7xhynPqAkLMmWmDgQoL49bMJv9WvBb+WxTp7Hl4IYBVb6ppaWq367dwREO363/Dz1VTONR1wN5mdQvHyrnvoqQjcBSv6FaJIhNYhUH0HINKUZ076cgsnba69SehW0WlhDdBoXmkciG2qkdtF5EnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727181138; c=relaxed/simple;
	bh=Cq3TOQ8GB/OUb+ArAGG8i9QFwKNG5obi228waKeC/20=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FADvGHVSDPw6qOSjnqVWeN6kFxsWPb1pJd/2bM5kNaEsvAlxaAd8WZyqVD402JoE/iWOiNbTNccGgrmNiR+UH3FvyYPPL/gY0KwSUhMGBQD+htnbDbbg5L62k9o8J2juzCzX4x6+RgnmVkjWibv8Bup3GjyP3dUsQue8AN5x+z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XCfJW1HlNz6K99N;
	Tue, 24 Sep 2024 20:27:39 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 6147D1408F9;
	Tue, 24 Sep 2024 20:32:13 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Sep
 2024 14:32:05 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: <lulie@linux.alibaba.com>
CC: <antony.antony@secunet.com>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<dust.li@linux.alibaba.com>, <edumazet@google.com>,
	<fred.cc@alibaba-inc.com>, <jakub@cloudflare.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <steffen.klassert@secunet.com>,
	<willemdebruijn.kernel@gmail.com>, <yubing.qiuyubing@alibaba-inc.com>
Subject: [RFC PATCHv2 net-next 3/3] ipv4/udp: Add 4-tuple hash for connected socket
Date: Tue, 24 Sep 2024 15:31:13 +0300
Message-ID: <20240924123113.1688315-1-gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240924110414.52618-4-lulie@linux.alibaba.com>
References: <20240924110414.52618-4-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 frapeml500005.china.huawei.com (7.182.85.13)

> +/* In hash4, rehash can also happen in connect(), where hash4_cnt keeps unchanged. */
> +static void udp4_rehash4(struct udp_table *udptable, struct sock *sk, u16 newhash4)
> +{
> +	struct udp_hslot *hslot4, *nhslot4;
> +
> +	hslot4 = udp_hashslot4(udptable, udp_sk(sk)->udp_lrpa_hash);
> +	nhslot4 = udp_hashslot4(udptable, newhash4);
> +	udp_sk(sk)->udp_lrpa_hash = newhash4;
> +
> +	if (hslot4 != nhslot4) {
> +		spin_lock_bh(&hslot4->lock);
> +		hlist_del_init_rcu(&udp_sk(sk)->udp_lrpa_node);
> +		hslot4->count--;
> +		spin_unlock_bh(&hslot4->lock);

I realize this is copied from udp_lib_rehash, but isn't it an RCU bug?
Once a node is removed from a list, shouldn't synchronize_rcu be called
before it is reused for a new list? A reader that was traversing the
old list may find itself on the new list.

> +
> +		spin_lock_bh(&nhslot4->lock);
> +		hlist_add_head_rcu(&udp_sk(sk)->udp_lrpa_node, &nhslot4->head);
> +		nhslot4->count++;
> +		spin_unlock_bh(&nhslot4->lock);
> +	}
> +}
> +

