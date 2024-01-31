Return-Path: <netdev+bounces-67439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1751D8436EE
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 07:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7915285C21
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 06:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EAD5027C;
	Wed, 31 Jan 2024 06:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoHO5YDQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8E93E496
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 06:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706683253; cv=none; b=N4vMTlTu4kFfnOir/nsm+K1AYtWf7ZUaODJFk/PGE1+emRfDk/Djvk+AXcq3o2OzOFnKnHItU55vbroiBtX3QMFKktPDcN7fM4nzd3m9njZl4iuna4mxL0kaYAdRFsvvNw5B3Dejpbd7S6ThIUjuLPbTwaf+jz2D5UWZGSbQdsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706683253; c=relaxed/simple;
	bh=HRqkCqxtBKrUms3XCHQMXqP+vqbRKLRoHOHl89isBsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fuy0NudmAlR65Zo/NGpz38k7pxjOyvpTCt6NXhtrbUJmKEyZXLH0lLJQavfboBbA6dbvglW4j8HzwctZCho9AZMjyWhzcNqsDjP7FwBrPT7j1p/mO93loMDWPOKgfM1x5gxRNeYpNA72fn81p7kj1+CzZxL/PG8wTMCKsIeprlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoHO5YDQ; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc6782e92c2so2472614276.3
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 22:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706683250; x=1707288050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5h17ojUPSOJID+Qge95Q9ZnvyDNG+2fV6vU1bRnAO9Q=;
        b=IoHO5YDQFkdN2z0uoR4o81+6ATDnc28f+qVUG5WYm1fJVsVxiztWVazF3z26ZaLAhm
         XDqHA7atH9U9XA+K2VOdV2IQRTml/ZJur1qeKcQ/rKorWtuRAOOWgXmURo1rUb0vNXsP
         thc7ydvEh7U6xCCFZdK189rirY1CnZRL1bR1Skps9peeOS4o5WIPvu3uXDenwjegIBJJ
         VjbZQoGarmPImj+J6Hgz0zqCztILFLzr71NLiazvbQCBU0hRvdmPrsY3O62jPUGk45RX
         EE9zUnDLY+jtmtLbBVi3QJrS0uwiqWownYoI2/Ai2lQnQBL4ORK96yzX+eO1N5gunH8Q
         imqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706683250; x=1707288050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5h17ojUPSOJID+Qge95Q9ZnvyDNG+2fV6vU1bRnAO9Q=;
        b=H4Q9BzVvVEwjkqN1PYyfH8g9Bu/nHQk3BkVJ5hh1q+NpGzh3aNJw1YAmSi3gdEKYAM
         h0ZFxQD7wWR79X79gpT1EWH9jxbYGx2EkfB1+TttdBTYtOpTrspzn6UYH6tM92vxSPMC
         KMWExKXx/DhDMOmHiT92/OTcX8zNsUGAS5UyXXsphqHy86kENbVXRWJsOgmIg3kutn1a
         I4ZEIENZ6oQvajjqQuZFBHp5IFC6dq0goYyAYIrARg0YHsfryLXiWwdJAUlC4AzylitL
         7x86NLrHyjTs24mZr0XssD0EZUCkyaYnx649ysUwggcf1gjwPcEAbk0rEoeeqBrLvc8b
         4ijQ==
X-Gm-Message-State: AOJu0Yw8iUtgSA3OVszhSEof3rtKajWzzrBdTLd/diWrzkH7jKb/thK8
	wz41T9tl52A11B5UVuoWmwdFgX9LhI2ixC9kNpGB8j2OzYww5V/Yfc2poS06rcE=
X-Google-Smtp-Source: AGHT+IEWlold55DZ4Ci3uoWB/dFaNf17WDA5928PGY/Zg3xPpzFFDUHQbdCWH6z71HyqNAP+Bah0QQ==
X-Received: by 2002:a25:aacb:0:b0:dc2:4e83:e6be with SMTP id t69-20020a25aacb000000b00dc24e83e6bemr747922ybi.46.1706683250155;
        Tue, 30 Jan 2024 22:40:50 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:7a8:850:239d:3ddc])
        by smtp.gmail.com with ESMTPSA id y9-20020a2586c9000000b00dc228b22cd5sm3345683ybm.41.2024.01.30.22.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 22:40:49 -0800 (PST)
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
Subject: [PATCH net-next 4/5] net/ipv6: set expires in modify_prefix_route() if RTF_EXPIRES is set.
Date: Tue, 30 Jan 2024 22:40:40 -0800
Message-Id: <20240131064041.3445212-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131064041.3445212-1-thinker.li@gmail.com>
References: <20240131064041.3445212-1-thinker.li@gmail.com>
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


