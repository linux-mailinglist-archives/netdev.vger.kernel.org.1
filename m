Return-Path: <netdev+bounces-73940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D33BF85F61A
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 11:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52042B25604
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 10:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE564653A;
	Thu, 22 Feb 2024 10:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4lCr1cWU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CC846435
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 10:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599039; cv=none; b=F1sEtscLmljoxQ+Q5sEanyMdeEUN32HS3PSl/JTTfvmQRG/QxRLrFTZw43VEMgJvEiAFgSXcYu3QQc6cr0nHanMXzcP15fS3W29KB94/4rKK5SyRCByh6F+5R4y6G3PmDgScHFXZClEdRDzE+82i3V7eurn1yBlImOITtLKbYLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599039; c=relaxed/simple;
	bh=HtY3HQFZWPLuiTttsHrjKcZx/qON+wabPiyRjjsp4H8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n+H/uPCYLtjY7DabfUTSCBm+PVRTdBParv7vFNNkE/f0EREYwqpQpnVyQsX59TRZ6oTTsY6Qme5vGp6pUw024hSzCAq6/nZYnuBNg9/xzSmLugA5EYy1BrfJWPK7gfbBfx4WH+GK9+6OoI3l+5GqWPrz/C+kyZRAbDX77uMnRQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4lCr1cWU; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26ce0bbso16155998276.1
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 02:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708599037; x=1709203837; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kiiYpUBe05Kbj4u9cPMfozplI67YN/aU2iLYzbo4hx4=;
        b=4lCr1cWUlx7NgD7KdSjS9iHVTSReJVTdeJkTJy5c5K6Bk2al9Zufn3KZr5IitZBwkF
         +eVDvpVoYfoQtJONYULWxitJm4gWHPC+7PDF6JECBvdTpeNVZHcvGar1LvJkunkA2gvV
         tQ2Kupi780at0kzlKsfPc0bfZflXbFprtj+g8ypV0rRuTwpttHrWvziOHkpaVYVER+GA
         dyJJADuHvlz4jVnhm6B5ZolUzdBmLKlZ+4Abgt6Tx0oE87Z3c6q+kVHX0ttUZItWwT+g
         P6c0y/3U79fp6qn1N2SHDLUW8F19pszL/EXTH+n808sLqYJD+/RqVoMtRA0m+9uSfugi
         rOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708599037; x=1709203837;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kiiYpUBe05Kbj4u9cPMfozplI67YN/aU2iLYzbo4hx4=;
        b=lcZUKg+SB918ZAJ7kEtDoNz8kNk0ywD4b++cyrkGcMDNOk1LeHuA5kaPE85+edNNCW
         YiTuran/BHrnhOxvLkoW228ir7Wet2jvEVG6j/uQBNvpCVDrWiiv22A9YDMFL1oC9nuY
         yZ1tRp791/O2ophGajHBhkFQTyq4qQyEEeuqd+H8WvRlIW4KOJkbsBKcUGyNESweAS9I
         lRRzkYpuePj/MGT/qF5kNayw6Mn/XkgRtXtXF7mz1S5zviDktctU2qOJmJFYwHiKoP4q
         lhDSoqhh/BjpHbPOcKvSjKsMqCzrnV7/QOHv6cAoYMu6dNNtdVZ41e5gJ368aThqWTFn
         ZlVA==
X-Gm-Message-State: AOJu0YyiPo6V3NFj90PxTR+1TZtgEt9oHgsUrO+lsXY4Df7EMj4HQMNN
	KVtkIgrZZZaz2B9xE/kZ3f+AaXnj58p0v3Vs3rcui3DZAUNSH/Tuyyacuc4LI0KILil9eFkWqsW
	NgKHeCnmZhQ==
X-Google-Smtp-Source: AGHT+IF+/kUgWQA7n0588yD7zUbaGgHgYZ39zr2XQKOtEwjmv8B5At9T84jOELchJPemMmwDe3d2slyz+6mvKg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1101:b0:dc6:ff2b:7e1b with SMTP
 id o1-20020a056902110100b00dc6ff2b7e1bmr546791ybu.4.1708599037002; Thu, 22
 Feb 2024 02:50:37 -0800 (PST)
Date: Thu, 22 Feb 2024 10:50:16 +0000
In-Reply-To: <20240222105021.1943116-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240222105021.1943116-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240222105021.1943116-10-edumazet@google.com>
Subject: [PATCH v2 net-next 09/14] ipv6: switch inet6_dump_ifinfo() to RCU protection
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

No longer hold RTNL while calling inet6_dump_ifinfo()

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/addrconf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 8994ddc6c859e6bc68303e6e61663baf330aee00..244b670a44b92f10b8f18c444d72a2467f8ed90a 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -7447,7 +7447,7 @@ int __init addrconf_init(void)
 	rtnl_af_register(&inet6_ops);
 
 	err = rtnl_register_module(THIS_MODULE, PF_INET6, RTM_GETLINK,
-				   NULL, inet6_dump_ifinfo, 0);
+				   NULL, inet6_dump_ifinfo, RTNL_FLAG_DUMP_UNLOCKED);
 	if (err < 0)
 		goto errout;
 
-- 
2.44.0.rc1.240.g4c46232300-goog


