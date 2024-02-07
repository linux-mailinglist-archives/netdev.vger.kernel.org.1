Return-Path: <netdev+bounces-69966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A657484D23F
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 20:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EE031F2625A
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 19:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBD38613D;
	Wed,  7 Feb 2024 19:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhCJ5MZ2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F9285C42
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 19:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707334189; cv=none; b=Fl56051kPXCfdqvno6+HaJVhNPN1Lgctlkl40lGFWcSzoNiDEV6yEMjvgdKGIdRyiIAOQohi3SAreqCZjgreQ9up6GRCfCu9NeEq6zVCmWaF86pc8/c2NTNMmvu1znMzDnvqUw5+0EN2mfKleSl0nd3xsyEnavSbL67947D8ZbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707334189; c=relaxed/simple;
	bh=iJ2gp3cWSbvHtaHeG7008WxTUZNgYdZaxfLImM+PHDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AJVmTwcxBjKroeIWm5moe7z7P11n9vKBGmng0LaWW6LOZEkCmbjTFkfuvQ61Oo9X/Xa2UMwpaqPrgP74yHXk2o6L66kETNDkOM0J9EFJtiLybwzpnV599nkUmp4rfigXR3sScLqWmrhbtqZAL4KcXsYdYyqqLsXIKf7A/DquAOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhCJ5MZ2; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-60495209415so9002287b3.3
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 11:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707334186; x=1707938986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lRjgwKvhAvYDvsHrHhtQ/wCCCH8o6LGs4SUcgFa/0M=;
        b=jhCJ5MZ2eYlqbELP6wsktWZlDL+L6HFznQOwWRjFco/uFJUQLIJVaPcYqf72/Ggmic
         KZt3bDrYnIXYRktyYFkV0CA0EKtb6m6mnoH5rjCrRhtil69tA24aFjZlXkRPjSRudtu9
         tImFF3UMHLJiteMz+ZhQiMbLeoEjCmHfM+gvJ8sf49oDgTbcQGtFEMh7I7RuSPznaiCn
         6ajmXQdE0JvbPHJ9wegMJ6qPQRuK8IOcjTXtl6W5u+4sneroqec0acKeN1WOf2sEPhrt
         UnbyUrCw2kfgkNjih7aujBnonceirhtUNmt2jem7MDd6aJuJUdVOavW6yDz0p3qBquc5
         MlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707334186; x=1707938986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lRjgwKvhAvYDvsHrHhtQ/wCCCH8o6LGs4SUcgFa/0M=;
        b=BQwg0Q3bo7hjeiLGByHa7CViwCZpk/Nnr99t9xqBa0BrhIoRmSmFEmsN+b1w5S/ZQi
         QFjAOevJbk9eDWPyyTpwn57Q63wk0+1QJAOeSM2+frBF1ETzTwVvGbPWcDO+NxcX93jk
         7mc/QKm6zMvUk1O5XjRvrfP7/P8X6ovYtVk4bigA4kANOnxBm4UmR3L1gpHkl0liYlYC
         gDUcY877ZrZw1omWRPgLQ5QUeXvsivsD8cT1GigJPE9UafN8jRlOICzOfFRzrcUT/nuQ
         N8IlTFwBUOQqCDJbmc5Cnylq+3oyDfvQSCcPj8CINwIJTgkOicbCWkwIsJdDLmpEdELl
         QCLA==
X-Gm-Message-State: AOJu0YxDVO1FRzvT7YSMuOF6ebex5CXjjVbs9vP/N7/74kekCwWpbYFU
	o523iTc4/auksJApgR46kgaGf3f+hDCl/aHrW1YoJ56wrsoGT25eUB28QqCN
X-Google-Smtp-Source: AGHT+IGI+TYWanHusvzMpxvxMZjXd/MGvDI73K3smPmtiFF5K+Scfs1pbpsnFvmaV3rsI/JzTPslZg==
X-Received: by 2002:a81:c508:0:b0:5ff:bb43:2a69 with SMTP id k8-20020a81c508000000b005ffbb432a69mr4957672ywi.40.1707334186352;
        Wed, 07 Feb 2024 11:29:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUQ0AqgqhzWwp+Ehu+awOjLWeVg/vrsmsiDey78hUOlCt5qUOuVZF110NLuWZoGC6YTNx5VsMD6BECNkC/i6sGVGuRbgMeT/6TxfUbDFtUt3QO8Idc60lCWGpuh/fi6RpkH2S4p1k8/wYdMH37wOAIogK6veV9F9rIwL6RlqTLM2sfebCFivEOa2D27paTty/j9Tq45Ctk3XE6r+mYFkdM7u7UQs8MNeCuAqSvme7PEfNmHLk35MSzBV+BVB/CRJ36n+9Z55MHd1qciGOrsMAgAzOhfDOQulmCww2mizRm2PxDNWI7ehgNedXrE4XeXJJgwOnavCchHZei8U33AA6SSpf6cWfVoTL5fiA==
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:50ba:b8f8:e3dd:4d24])
        by smtp.gmail.com with ESMTPSA id cn33-20020a05690c0d2100b006040cbbe952sm380088ywb.89.2024.02.07.11.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 11:29:46 -0800 (PST)
From: thinker.li@gmail.com
To: netdev@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	liuhangbin@gmail.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH net-next v5 4/5] net/ipv6: set expires in modify_prefix_route() if RTF_EXPIRES is set.
Date: Wed,  7 Feb 2024 11:29:32 -0800
Message-Id: <20240207192933.441744-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240207192933.441744-1-thinker.li@gmail.com>
References: <20240207192933.441744-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Make the decision to set or clean the expires of a route based on the
RTF_EXPIRES flag, rather than the value of the "expires" argument.

This patch doesn't make difference logically, but make inet6_addr_modify()
and modify_prefix_route() consistent.

The function inet6_addr_modify() is the only caller of
modify_prefix_route(), and it passes the RTF_EXPIRES flag and an expiration
value. The RTF_EXPIRES flag is turned on or off based on the value of
valid_lft. The RTF_EXPIRES flag is turned on if valid_lft is a finite value
(not infinite, not 0xffffffff). Even if valid_lft is 0, the RTF_EXPIRES
flag remains on. The expiration value being passed is equal to the
valid_lft value if the flag is on. However, if the valid_lft value is
infinite, the expiration value becomes 0 and the RTF_EXPIRES flag is turned
off. Despite this, modify_prefix_route() decides to set the expiration
value if the received expiration value is not zero. This mixing of infinite
and zero cases creates an inconsistency.

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 net/ipv6/addrconf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 0ea44563454f..ca1b719323c0 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -4783,7 +4783,7 @@ static int modify_prefix_route(struct inet6_ifaddr *ifp,
 		table = f6i->fib6_table;
 		spin_lock_bh(&table->tb6_lock);
 
-		if (!expires) {
+		if (!(flags & RTF_EXPIRES)) {
 			fib6_clean_expires(f6i);
 			fib6_remove_gc_list(f6i);
 		} else {
-- 
2.34.1


