Return-Path: <netdev+bounces-249007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B1CD12A2E
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 13:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D2A9E3023575
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 12:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234483590C0;
	Mon, 12 Jan 2026 12:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dVu6d5Nx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UvYoMKc0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EC43587D9
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768222501; cv=none; b=H/iTnZCsxt1I74j9s4Q67l3JSjt6Mds6JlGzZQJWguLZMdptEAH357Q2fRzjwI8AIXLK0xgLCK+uxzQKFdU8dn49BGxhdVQ2JkazFok2wnK+rpWnGmvvn4oX6epRdGVAnaSw/i0OoRTbkgS04w5x6MVsDX1PXJvQ7FCwKJHdr14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768222501; c=relaxed/simple;
	bh=9AA+6Xkc06ZNRttRTO7oNESMzk9GkeD69hB4TdB8dWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QjkU7j9Yz1B/YGWLS15juqcJ84E5Ow9HczslGfuDXZnYQE5O1eLvIV31D3+Vb7UMFnJDGvo8LznY9mrWfi1oOnOu9ihKeuABVLUUdt13IdCOeRU4vd45kzJ+3/MWtE9BNUNy3B8h6IzMNWJg5xDcrlft94uLgUuUgLQdgKMuDl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dVu6d5Nx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UvYoMKc0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768222496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aw/NV8LRyH0v6ORkecK6sJJhDNFc4SC6s3IiJQNZsCk=;
	b=dVu6d5Nx5yczr7v7xshGoVLgrFA+2+4Bx/HakJLjATpeBEAPwbJmjBVjW8WuS2ZIlwk2ik
	RjTqfDeLQ7DEzBjW4pwZg4OENXqoq1Mb2sl2tRib+0KbJKgwxYW7IYcvxHaIBCYxyqe1Zk
	afbROlkUdLVfuKefBa7tk0ZkOkN0TPs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-ToMT055HObah1kTe5qbH3Q-1; Mon, 12 Jan 2026 07:54:55 -0500
X-MC-Unique: ToMT055HObah1kTe5qbH3Q-1
X-Mimecast-MFC-AGG-ID: ToMT055HObah1kTe5qbH3Q_1768222494
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b870d3327baso108103866b.3
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 04:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768222494; x=1768827294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aw/NV8LRyH0v6ORkecK6sJJhDNFc4SC6s3IiJQNZsCk=;
        b=UvYoMKc0kKHzHOlmfPz746OTgXzILzb5qA9R/0Xv7FL7h7kvLMA4nZSHablQURMXSL
         x7t2Pzs/23OZhL4nPPY65DFjdM9XY+ac3pSA8P5mzsguFS7sC6Zy6IIM2jEZtPVbESuP
         AqH8aiuFL7i++fRBST5zLOY1rlbwBPhBR9oQmzrnfgAKyu90ASEpyGb50fPVMt8KJ/cs
         EbueGRx+IKpaR4x3X70Qm1Y821iO5EngzcUe9xzD5YZRBzbfpH18D/1+zdmdl9uQL2Kt
         zKCdOFI2aokPbRcV8dnnxnWgQbk6kJ8xEpJBOVx8HQBzO5xX/t2U9RI/9oKQsU6EzIbq
         uNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768222494; x=1768827294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Aw/NV8LRyH0v6ORkecK6sJJhDNFc4SC6s3IiJQNZsCk=;
        b=uDcAgkfwM9L9X5gBrXebW+loGEmI44LtkHZvKRiPLA/Zdo/66uvpTkbI094g/WSYQR
         2JaUZkPHEwtPgzL5DSWWJqsDyDkJS6MX3ihsW51YDL/I7D1V8nFXdd1E92BRcGmi31/w
         E7Cq3CyxZpEeD2HI9usXAsap6IeGnoDs1cs4Yxhw/Zi0G+xtlo9938wXhx+ziO1ekQqP
         iYuO8ZZavJLbCxbLmxV4S2M513mgN5LySjgaSwKySHMUf+ceglWVGTgjsO09Tq8dBvDD
         2DWeDa71AGGTeuuZLkWI/CrgeQV067/A9Vbl3ijdDKniaGyRG05Q5LsxQjWZ3oYuCauM
         +51w==
X-Forwarded-Encrypted: i=1; AJvYcCVqw+7lWwlqyopZKx6U4p5GwfDPnmPTBL4sglRwAdqxdbQUXp5HP9EUEbFOn7TXVzACK530oQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmoMqYZoWBSvNAAtcYkEpyownuSoG57bpQpnulF+Hewe8zhbzj
	1P8Yfc8NKuPCZ2dB4v5ZguGZ6okzI0/n0p6t12kMI6dq1v8HvT+N6xaQzPb1043QkZUAiMVwa36
	EajB6aZokiuKXeUAqvxq749XCdMcAOfWbmPPi/jqb6Aqew/mxfLMq4gMO/Q==
X-Gm-Gg: AY/fxX5OhAoaEf7Q/f1s/h6x+oPu4VSmf6rZJwCtMonw65UA7xFgm0dzUH5M3Z0vywv
	8H/QbBMFwh6mGGFuOGR+uwyIXFN3p+xPvRzK/221N9ys27FWdIIFBJHsweIPd7O6u+6GOKPjxDd
	zVyIgocjqdFArRmRG8FdXgFC2Mk+R1AnxykQ8u/jm0R8T1dVu640B7RrW+U1TlpEyPbMWvnZ9RZ
	RxDIIG75WQ7tzC0dNe747hQfYS+u7lTliL1mwU7ij+71gKza0ZxFlu6gmB3dzTtla+yf5YskZG+
	YmkP53Ai4YM6IRQ4CwmCEj3iQtdbR0ufN9t44YoQymVnm8kzlIZ5EzW2+kGx9MpHEgP8pj5AK1a
	eLGUcjiQtE6uJkUCD9GKrr+iHIGHOQvK3pnIeyhXTQDVCFoOt0QedvaGnu8A=
X-Received: by 2002:a17:907:b59c:b0:b86:eda4:f780 with SMTP id a640c23a62f3a-b86eda503ffmr427900466b.18.1768222493908;
        Mon, 12 Jan 2026 04:54:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQQUtq3Zy/c64KpzKtlRB+1NOLYJQC+enp8zQ7vlFIka+NmHMqyup9Wyx1StgQLyix4fqkyw==
X-Received: by 2002:a17:907:b59c:b0:b86:eda4:f780 with SMTP id a640c23a62f3a-b86eda503ffmr427897866b.18.1768222493414;
        Mon, 12 Jan 2026 04:54:53 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:ff56:9b88:c93b:ed43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8706c2604bsm497062466b.16.2026.01.12.04.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 04:54:53 -0800 (PST)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	linux-riscv@lists.infradead.org,
	linux-m68k@lists.linux-m68k.org,
	linux-s390@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [RFC PATCH 4/5] riscv: defconfig: replace deprecated NF_LOG configs by NF_LOG_SYSLOG
Date: Mon, 12 Jan 2026 13:54:30 +0100
Message-ID: <20260112125432.61218-5-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112125432.61218-1-lukas.bulwahn@redhat.com>
References: <20260112125432.61218-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

The config options NF_LOG_{ARP,IPV4,IPV6} are deprecated and they only
exist to ensure that older kernel configurations would enable the
replacement config option NF_LOG_SYSLOG. To step towards eventually
removing the definitions of these deprecated config options from the kernel
tree, update the riscv kernel configuration to set NF_LOG_SYSLOG and drop
the deprecated config options.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 arch/riscv/configs/defconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index cd736a1d657e..0b99a73f43b2 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -64,6 +64,7 @@ CONFIG_INET_ESP=m
 CONFIG_NETFILTER=y
 CONFIG_BRIDGE_NETFILTER=m
 CONFIG_NF_CONNTRACK=m
+CONFIG_NF_LOG_SYSLOG=m
 CONFIG_NF_CONNTRACK_FTP=m
 CONFIG_NF_CONNTRACK_TFTP=m
 CONFIG_NETFILTER_XT_MARK=m
@@ -75,8 +76,6 @@ CONFIG_IP_VS_PROTO_TCP=y
 CONFIG_IP_VS_PROTO_UDP=y
 CONFIG_IP_VS_RR=m
 CONFIG_IP_VS_NFCT=y
-CONFIG_NF_LOG_ARP=m
-CONFIG_NF_LOG_IPV4=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_FILTER=m
 CONFIG_IP_NF_TARGET_REJECT=m
@@ -84,7 +83,6 @@ CONFIG_IP_NF_NAT=m
 CONFIG_IP_NF_TARGET_MASQUERADE=m
 CONFIG_IP_NF_TARGET_REDIRECT=m
 CONFIG_IP_NF_MANGLE=m
-CONFIG_NF_LOG_IPV6=m
 CONFIG_IP6_NF_IPTABLES=m
 CONFIG_IP6_NF_MATCH_IPV6HEADER=m
 CONFIG_IP6_NF_FILTER=m
-- 
2.52.0


