Return-Path: <netdev+bounces-249005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62491D12A1F
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 13:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DFA53059AB2
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 12:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72950358D07;
	Mon, 12 Jan 2026 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CEzeXbIi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LqSqNFh5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F753587CE
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 12:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768222497; cv=none; b=u94KqptbYVipNIcmu/Spo+6e/2EASfFDX/INxW2LsYiwHXtRQ9uQ77qsR2YHBCYMc9aVkAyd8Jlc2w2Q1ShaTlqXrCLj/AMIAzfrSKq7giL7sLzpgwvKLz+1cYah/F41Faj2fRkm0NZZZGbz+QE+ZEaqcPSQye8AYFmDqS0Pvr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768222497; c=relaxed/simple;
	bh=XU1R8eEmf+8OcV6QhVEoFS8ffVTmlKxgnjEPke2eHaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QwwuG3d8KlJaNy/Fc1tVemoohz5TVHgNh90MsxUSfNnOiTybohUzjZbU5VzTu5j48kAiq39kcuQmU+5ArKeNbarzJ78qmD1Nki/+cIhNXIe7M1uY6XGFGTeWb7iQTdQtKTAlm2KIbIjcd0vfr7XVJb6VA3I2c2zl08M3mmBAru8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CEzeXbIi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LqSqNFh5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768222491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2pTWpsZNjWgj8wv5f92UAOMouEbb8hc3HuMURULyk40=;
	b=CEzeXbIiwM/J4K3PnlT5Y3fP2V/l+GqD1X1TpGhvRUcgecMqzY61DaOBGS/83uEk/6qI+l
	2RGNRa9fADcXZxu0PZ9LbUr6Gk25DOiSP5jC7S7ZmYFLwicAno5Evci2oAytNOp0bYXeAl
	0AhHlSq5+D1Cqo0sSyAAR4lBzMRhRbg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-m-1nZwzrOHO2mQ6E_T_R-g-1; Mon, 12 Jan 2026 07:54:50 -0500
X-MC-Unique: m-1nZwzrOHO2mQ6E_T_R-g-1
X-Mimecast-MFC-AGG-ID: m-1nZwzrOHO2mQ6E_T_R-g_1768222489
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b7fe37056e1so623601966b.2
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 04:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768222489; x=1768827289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pTWpsZNjWgj8wv5f92UAOMouEbb8hc3HuMURULyk40=;
        b=LqSqNFh52oCCy4tw8QgSvS8ufBhTEEWVhgKds6lYaSxVk1WvSTIIEACeYiUzsVQpPM
         IjyuipVH2D8+7BOhL8h1P3wvZIhCCwu9POsdpoifZ8r/o9RkJtG1QEMlz5Ww3LHc7NsT
         PCAZ01DDVwLMNqGuRjD3sLZGnaTQYfyNtoG/H8iQJpXYp+vlU107WBn52H86etbyw6pb
         92l4B4JQnuhwAFrO2eAtIgK58nj3X2GbICLw2L9XNuEjR1BvBQzCw9BQyEc232Fy3izr
         lXEkITsELO+NXFrfTHcuhW/wH1PKXtDUivtDxdxPfcMG+Tk2WPWRmcHAwQ37rht0prEQ
         lfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768222489; x=1768827289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2pTWpsZNjWgj8wv5f92UAOMouEbb8hc3HuMURULyk40=;
        b=rY0ZZNR4gdyK4NGyVhX2vXvus014MK9CufrkJKrnL/jJMZhSLj/hXQwzcfTfa5+UaH
         KM54Atdejotelvg1glKkMTih6a6G6W1iX+ZSM02f2hvsS1JIA1+RJYS2OgmSVijaNcdK
         bcMyiH0uiYpGSUEdEj0S+S9HJqlqmeQ1wtHFNNWc8dp9twVUASfvzleUAMTt4Anr7kWc
         bu66yxP1B6+fe5MlN7nfbkwX4pPkdnkUtgoEXMveWD+60MOsgDTCBBvGv/ahjsSKMMO7
         /cpeU6Uw9kQVLra1ITnhuPVWkjtENAzpFwWU2tQE25j1Vm+DFP6UspvQk9u5JJIXbO7y
         Q3tQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhQdptVSuqzyhE8uUXux3mlmfRdtXJ7Icdc8vDcMVNTVlXECxeXlkTdm3X4TWxl5ZpWGgtWW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkKmBNwuZDqF3s0mkGBFCgN4YXea+LzZNTeBKjgv3lxR86o6Dg
	glPoZwX8iCDMYycYMqBc6Uur//s03KojHHl7U4sOdWVh80rr029dz9O5IkiqFUSC1JObtm+xCCR
	DMgmUFlsNkWhmpIvcifIMwLzH80pd6ul2zfWxbYLJKVAqStP6YIO0UStf2lrQBg4RDQ==
X-Gm-Gg: AY/fxX5odeOdvrI7Vz0hy36BBo20gOOHykA/MWbAm9Bxuc+NcI3nvKiA4jkFugB1xjQ
	J2Wh8Fh29ASDfC1IpxzH8i25MRcShwnl1iN9Du1V8h6Mr1sw7qJwqrGnhe4nviXwEKfFy3+Bu6/
	FXZFWDec17nFW+UtrysjtUxQUsbmTn8Ooj4BPUdV1hhX4uS/ybszVnnD0Rv4NioCsGOi8Ltt6u1
	F8FGuKmWpL2C0cebBrwqFnmnfjKekR3NWumexLWhdFIjd5pLoGnqgkZSHiN6R4YnahDQVyFIZ3F
	AlyxGc2AqljttRJ8vXVFwU2YpduF5pJXqOQ7mrIVWIUpjrfqgGG2gpooYRXVFCY+A5QvduqbHP2
	KDN0neZH7uco25JtGMBdLjuXAstn73/nMsajuRWdPjitOzQySIB+6Vv6ZLg4=
X-Received: by 2002:a17:907:a0e:b0:b80:34e8:5eb with SMTP id a640c23a62f3a-b844542221cmr1612466666b.55.1768222489039;
        Mon, 12 Jan 2026 04:54:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7t8/HlV/5AlKScEccxcE3fk05AaGQ3PxxJdFkixgC3oQPqTZ4vVB050U3KXnraou/3iD9lw==
X-Received: by 2002:a17:907:a0e:b0:b80:34e8:5eb with SMTP id a640c23a62f3a-b844542221cmr1612464966b.55.1768222488577;
        Mon, 12 Jan 2026 04:54:48 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:ff56:9b88:c93b:ed43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8706c2604bsm497062466b.16.2026.01.12.04.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 04:54:48 -0800 (PST)
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
Subject: [RFC PATCH 2/5] selftests: net: replace deprecated NF_LOG configs by NF_LOG_SYSLOG
Date: Mon, 12 Jan 2026 13:54:28 +0100
Message-ID: <20260112125432.61218-3-lukas.bulwahn@redhat.com>
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
tree, update the selftests net kernel configuration to set NF_LOG_SYSLOG
and drop the deprecated config options.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 tools/testing/selftests/net/netfilter/config | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/netfilter/config b/tools/testing/selftests/net/netfilter/config
index 12ce61fa15a8..f7b1f1299ff0 100644
--- a/tools/testing/selftests/net/netfilter/config
+++ b/tools/testing/selftests/net/netfilter/config
@@ -64,8 +64,7 @@ CONFIG_NF_CT_NETLINK=m
 CONFIG_NF_CT_PROTO_SCTP=y
 CONFIG_NF_FLOW_TABLE=m
 CONFIG_NF_FLOW_TABLE_INET=m
-CONFIG_NF_LOG_IPV4=m
-CONFIG_NF_LOG_IPV6=m
+CONFIG_NF_LOG_SYSLOG=m
 CONFIG_NF_NAT=m
 CONFIG_NF_NAT_MASQUERADE=y
 CONFIG_NF_NAT_REDIRECT=y
-- 
2.52.0


