Return-Path: <netdev+bounces-67874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3102F845296
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 09:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C28001F26D8F
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 08:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB2515A49C;
	Thu,  1 Feb 2024 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPEUrYcP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3D915A48D
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 08:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706775635; cv=none; b=YEai3kVrMPx0WFHq66SwiQES3bHb8JNUsyYAcIv1cnDnadHADIgOiliNFp53PMkaa3fxzr61reK1rFc5LVB3XJyHc2k7k6d0cQ0zKHth7bR6xTXcp7kJGD6fm+auJgYrvR2Q8zetXMMaWha/e21dE0BsAt8voUpTRZj3iBf6bAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706775635; c=relaxed/simple;
	bh=HRqkCqxtBKrUms3XCHQMXqP+vqbRKLRoHOHl89isBsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gMR59Y1fVPmgJCfTpri+Q+v4jOpqjg4F54Kdy77qfOXrryq87sAsZfSRwR8YxI863Jq5LfF9nzDoZWY/LK6ma0ItrF6KyLpwLOEzuFQ9y/C9vwyIJNy/Ybw7N1L3LDwpP9w42CoRJp0CXLn7G04EH1Q0OVxLFgRKviocJvD75Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPEUrYcP; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60406dba03cso7739997b3.0
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 00:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706775632; x=1707380432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5h17ojUPSOJID+Qge95Q9ZnvyDNG+2fV6vU1bRnAO9Q=;
        b=dPEUrYcPgr2EFc4qMT//Z4iW7dG+286m6mSVztwnmF7J19M77gVLchAp/FiCqC62gY
         ipnkgrBFOrUV4qNwEVn2LM4cw0qmtoc/U3RqVJgi0pP0dydUNoOl2aJNFwkTqDl6raRj
         Uqkd2pBO/wITXhD75dOh2ZqtdjLoe8x4iYn45l2Oh3TtW7CAx7AmA9+2iKBuBBEd6Ou5
         7Qjb2nVp9vKccacAMFtY1ySpCIAKnFYcQeOGZvnu5LaBRoUlTLDv/ro3BCI97X9wQsEV
         4eJVH2ro21zkbzf8VXEtS1jqqsWrdavfrF5tHF84fEqKUuG7No3bxQgtweYA63P8Sk3e
         O+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706775632; x=1707380432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5h17ojUPSOJID+Qge95Q9ZnvyDNG+2fV6vU1bRnAO9Q=;
        b=qGPdZsduxld5SAzZ5raMm9Bq750yu17fpBK67lVm4fmV90nfjwLzFwRxbW12tW/jrc
         CHWFZ9X3meEadmQJZtcIdYpAGMBZCDztcG5wt1RTfpC0v+Ji+zXw95P9LXMyJA3GK5L1
         MDsY+Df3N1T9WoH7x/aaMrUlrLwRpZnd1sU6WWKROShwtSaixrZcxCqWILXwo9VkGnYx
         ExVz4Gdz6dnjERrX4lANDJQY8aW4MH+QhBUt+TF33WQPgCY0ukdDLDGJynph5bz3UrKC
         eDNKfqVfdRGNErq3mXHScP+ZAMrCiRpHsfeK0BFRiapA/95H8prKKXq+CNmrOKUrR5pf
         7Mvw==
X-Gm-Message-State: AOJu0Yzrr/JIuIcOkJExpdta9xdhnO2Es0yx6aGP4td0hHgFKBxMDeOy
	xS1AQy7mIuCkuSLgI6a4e4BT90KGD8itRJ8rpFyBLwymJgJ5IMcCkbJo6fXarCs=
X-Google-Smtp-Source: AGHT+IE9YnN4udsJRE7wQHvp0I+sdxDGGtiE1jhrK23rnqqeXfrSediHN3iuE87RTA1ACCaZnQ+Mrw==
X-Received: by 2002:a0d:d903:0:b0:604:a75:4274 with SMTP id b3-20020a0dd903000000b006040a754274mr1410440ywe.51.1706775632489;
        Thu, 01 Feb 2024 00:20:32 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b616:d09e:9171:5ef4])
        by smtp.gmail.com with ESMTPSA id w186-20020a0dd4c3000000b006041ca620f4sm209090ywd.81.2024.02.01.00.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 00:20:32 -0800 (PST)
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
Subject: [PATCH net-next v2 4/5] net/ipv6: set expires in modify_prefix_route() if RTF_EXPIRES is set.
Date: Thu,  1 Feb 2024 00:20:23 -0800
Message-Id: <20240201082024.1018011-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201082024.1018011-1-thinker.li@gmail.com>
References: <20240201082024.1018011-1-thinker.li@gmail.com>
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

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 net/ipv6/addrconf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 36bfa987c314..2f6cf6314646 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -4788,7 +4788,7 @@ static int modify_prefix_route(struct inet6_ifaddr *ifp,
 	} else {
 		table = f6i->fib6_table;
 		spin_lock_bh(&table->tb6_lock);
-		if (!expires) {
+		if (!(flags & RTF_EXPIRES)) {
 			fib6_clean_expires(f6i);
 			fib6_remove_gc_list(f6i);
 		} else {
-- 
2.34.1


