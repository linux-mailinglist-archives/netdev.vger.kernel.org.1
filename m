Return-Path: <netdev+bounces-129538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2246E9845EB
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 14:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C16B21F2112D
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 12:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E9D12A14C;
	Tue, 24 Sep 2024 12:31:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E2E2907;
	Tue, 24 Sep 2024 12:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727181081; cv=none; b=sk/VL/oT0P5u/TrRV4Rq20vgRDnqpTnNKtaaFQU7E9pPDYSgcmdpKH/HTTZKpcT3JZiL54fQOiiSigopl6cEm3O2WTFTtF7qON5CL3/uX7zOYk0DgSvGBVwrEh6ENxwTW3pTj1gv+F+/Psw3ECnz8brOJR1ucpK2XOTT9kWbO9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727181081; c=relaxed/simple;
	bh=2HSP/osZlh6WUE0YGHVXPnPvUS6ksAmCCDb0idG3ElI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RM0LvwuGqDCPSLcy33YyKoGmgcRrOq1Sj7146eSBFTHMy03jl/xVhCi1P8LOaHYr4ZaszOvAjgjl8vrzfFsQPUn5s5aWZKp5mYF/M9umQlm1mKeTt6iLvJmjn+y6M0UxahwBOh61uoML4Eac/O5V/FWpBqG7SQzeZ5tmhqk7tps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XCfN169f3z6K6rH;
	Tue, 24 Sep 2024 20:30:41 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id BC3E91404F5;
	Tue, 24 Sep 2024 20:31:10 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Sep
 2024 14:31:02 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: <lulie@linux.alibaba.com>
CC: <antony.antony@secunet.com>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<dust.li@linux.alibaba.com>, <edumazet@google.com>,
	<fred.cc@alibaba-inc.com>, <jakub@cloudflare.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <steffen.klassert@secunet.com>,
	<willemdebruijn.kernel@gmail.com>, <yubing.qiuyubing@alibaba-inc.com>
Subject: [RFC PATCHv2 net-next 1/3] net/udp: Add a new struct for hash2 slot
Date: Tue, 24 Sep 2024 15:30:17 +0300
Message-ID: <20240924123017.1688277-1-gur.stavi@huawei.com>
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
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 frapeml500005.china.huawei.com (7.182.85.13)

> + *	@hslot:	basic hash slot
> + *	@hash4_cnt: number of sockets in hslot4 of the same (local port, local address)
> + */
> +struct udp_hslot_main {
> +	struct udp_hslot	hslot; /* must be the first member */
> +	u32			hash4_cnt;
> +} __aligned(2 * sizeof(long));
> +#define UDP_HSLOT_MAIN(__hslot) ((struct udp_hslot_main *)(__hslot))

Wouldn't container_of be more suitable than brutal cast?

> @@ -91,7 +110,7 @@ static inline struct udp_hslot *udp_hashslot(struct udp_table *table,
>  static inline struct udp_hslot *udp_hashslot2(struct udp_table *table,
>  					      unsigned int hash)
>  {
> -	return &table->hash2[hash & table->mask];
> +	return (struct udp_hslot *)udp_hashslot2_main(table, hash);

Why cast and not use ->hslot. Preferably with a local variable?

> @@ -3438,16 +3436,17 @@ void __init udp_table_init(struct udp_table *table, const char *name)
>  					      UDP_HTABLE_SIZE_MIN,
>  					      UDP_HTABLE_SIZE_MAX);
>
> -	table->hash2 = table->hash + (table->mask + 1);
> +	table->hash2 = UDP_HSLOT_MAIN(table->hash + (table->mask + 1));

Wouldn't it be simpler to just cast to void? It is pure pointer
arithmetic where type checking is meaningless.
(void *)(table->hash + (table->mask + 1))
I realize now why UDP_HSLOT_MAIN couldn't use container_of but it
just demonstrates how convoluted this is.


