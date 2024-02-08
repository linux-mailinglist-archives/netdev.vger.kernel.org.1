Return-Path: <netdev+bounces-70390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B527184EB37
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 23:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BCBCB27EEE
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 22:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114A84F8A0;
	Thu,  8 Feb 2024 22:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMJQ7iJb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5695025C
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 22:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430048; cv=none; b=cKJlpJ38EGopFFemG5YYJdd849wsN3zYARZZllLh9A341ytGWH+6HiZnLGZ6H+QPjruKX+2KLPE3wty25+p37+sz0+eCVhCt7swCKJ4WT+Qn9WHRZaO1CfJKiL3sKWdIqee9/cqEme63CptznaXQfJNCzkd8/gs45NyD5T6vWqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430048; c=relaxed/simple;
	bh=iJ2gp3cWSbvHtaHeG7008WxTUZNgYdZaxfLImM+PHDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WTMLZOlqtAlngEXuyfHiN5Qs9fXZWwxRpsl9JsFzfYHwwJPRQXdkQuz7vAmS2k8AXinK/Kza8aQmzDfDCAu1S7O/VA8tNaFFlduBzMAm1Voh4muBdLgMsAo7vtt1DEr9E3nkmypmlhL4EnOXECih5VegPUsTyyVESOxhkPnlizg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMJQ7iJb; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-604b94c0556so736377b3.3
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 14:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707430045; x=1708034845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lRjgwKvhAvYDvsHrHhtQ/wCCCH8o6LGs4SUcgFa/0M=;
        b=nMJQ7iJb2uXiJJPbz2RG0GYBAvMZ5f97cqxZB0/WegIjRAjadCvJcZ+7MS3aAsGdLr
         3XvvYEKMEbwGgeDQO85LL8hyn9qxJlsiAV7Tix+698lfKmWMt9k5sRO1Pu6T7wlyPQCB
         z34FU7CuDgLlrywYOwD/3HquPzsnKq0qZEiv6CDB4eNJCFdpu9JIOrgZcsTjxPvoYafE
         uHrCy2fO5S0sLYZWY5qxqSh6h2Fgk9/BX6K2ESPdnApDsfSaVxHyQdxZTct8NQ3bDsTA
         CF2b0+73D7MDmmqQ7o2DYrMummEVvA7iBTs1zVniagd7PZ98oLxVXYSFFOpx6T3c4+9D
         uMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707430045; x=1708034845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lRjgwKvhAvYDvsHrHhtQ/wCCCH8o6LGs4SUcgFa/0M=;
        b=I8Y+dSKmVCulXxIEMLXiWEJZITSCBJMhnxFhzHmUfAYgVhmM/lmoaRB4Hywd28bYwJ
         rW6ymgvHWc6nQyQ7LLQDC2XWZU1nMGwMz4MwVfXChzktCVSEs4DTQwGC0LkxIbkOxvx3
         X/acd7v5AsCJlztrzRwIyl9j7rEUZKk3khGmUYeaWMJG0r5VmKXNm8pLptNIy/WiAsrB
         qil0VIooZI4N8CFnborvzDtQDCk49hRCg0hWPDB5s9O8e+xc/Qai0/WwAEOexXbuWk8k
         ydQ8aX2unEjFBeBNgwRCcQqRVJjk9IMJzhx6rwd6DG7Zzh8BZriiXPnNOlwMZyeBSCWi
         IDYg==
X-Gm-Message-State: AOJu0YymlPrI19puv/C9bx2iO0EAuaqbxmjKTCsOGzjuK2lhghpZvUX1
	hyxliFpm4oap2A7/aBxPjFDDRD1JSKNrKnqA3b/lrr3BV9ZcQ3gFc09vRvH4P6M=
X-Google-Smtp-Source: AGHT+IHSz7efhIyXAgWrc+sNF439FnzpghL0R1sVgZOBRLs11r5Rhl2KqyjgFPxkNxXHvGfzHUHuNA==
X-Received: by 2002:a0d:e6d6:0:b0:604:b55:f078 with SMTP id p205-20020a0de6d6000000b006040b55f078mr707405ywe.7.1707430044171;
        Thu, 08 Feb 2024 14:07:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWmtnlkDhOJqwcr11XC93vEC3oCgrrmGJxKTcpEh1B8HjSdU+/R69FxRjnPgUTjleLC+Eu4NFp6tAffOY7eo21QCuOAV4h4Tylv8AVdd+Ul1V0I83mYq+UU/y+WlAzJmfw4cpwSUq4KQT8JhG6ftOMK8+gbAMz4UMwQkiUimW7EALxviHZFH/lXL2mZHqWU1Q44wg2apjopADxWfbocJe+g/+PtPHkshEp4AtwK/40XKp/KAiEAaRiqdUdeU2gzABhZEdee1Iq9Lpf65jUJMH5E1xPV7u4A4GMS94cbfwtnjDvLIBy3kWzf9weQ5IY/tn36p39NE/VKnr7tf3IxrL5VqevmZXBXbsxiyQ==
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1c58:82ab:ea0c:f407])
        by smtp.gmail.com with ESMTPSA id m128-20020a0de386000000b006049e3167fcsm61320ywe.99.2024.02.08.14.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 14:07:23 -0800 (PST)
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
Subject: [PATCH net-next v6 4/5] net/ipv6: set expires in modify_prefix_route() if RTF_EXPIRES is set.
Date: Thu,  8 Feb 2024 14:06:52 -0800
Message-Id: <20240208220653.374773-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208220653.374773-1-thinker.li@gmail.com>
References: <20240208220653.374773-1-thinker.li@gmail.com>
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


