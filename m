Return-Path: <netdev+bounces-174788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F105A60685
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 01:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5595B19C1789
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 00:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8864F2E3382;
	Fri, 14 Mar 2025 00:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMyqp61X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A50C2E3374
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 00:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741912464; cv=none; b=PB9yJ/v3jtU2XjB/K/z00w4NBh0PaiDKz2plQPVnNvHVbuHBgWTEu/ET8obG9UiqGFHGiKMcn3XHbomBLwrq/y9AnMEkEfyDg+mSszTzW71Q3h5tdk4zxpOG3VkkiLLs11zpfElmQKu50qDGzeplL2BQ44zLyiwPn4xhROV7NCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741912464; c=relaxed/simple;
	bh=klpEKL+OqDes8474/vt0yRjff7tlt/F8VuNiGd8E0U4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oQFQsUZZtOfEJH1Jl3yIjKzrGuTH7sDiFhVKsJB8dDkqAJM24mqYNV4yTKYmFvteyge0jUhsrkHjoyCLJcGrNKC+TG9ZSHzrmEwH+2Hb9xqwq84KjWpHwrduRZiefMr8YxMXMhlmdu01xNtLtOW2PmK65rFCxK9ek0KAxsQzsvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMyqp61X; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-225a28a511eso29007895ad.1
        for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 17:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741912462; x=1742517262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TkcuhWatAldG1Qv+tNq4BoOqwdWMQKTsmlTHhPTPreM=;
        b=KMyqp61XNQp5PRZ2hPDUDIfuApouKJn26VE6W1pn58XRtXJm6TJbYRWo3KuWFg24f4
         c3kA8NWxGVz8AOiwROzKtWI3G2tOLd9UuLXmmQZGK241WLPcCfXKb4GPI9YAXYhe3v0c
         RvavvnYHYGlgILyu5l0jofnfjZVATFiPJWLxSfxtVqnardFk0ZiiG0qQNu96DHnZsTCe
         hwjATv9plE2AKJ9I2Iiku3WaMCDL7QbnM/MsfMTEgtw8aJ8Xkn/4Jj+yJAmZ05ap2n6V
         m52xDjj2+LDoeyqIwx1+swRW+SXj/BJ9PAMa8A3H5gtPJRqGyw2bNHzX8nvh530gLZuU
         ojhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741912462; x=1742517262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TkcuhWatAldG1Qv+tNq4BoOqwdWMQKTsmlTHhPTPreM=;
        b=qI82clzZ2L2MvU+syoypDywe801heZhbmjqW3gU8jcDDJimL4mDZRZpe+QBgRRr92b
         blAqLc06YTZ8mh4WP3HHZamV3YljDzcrx8QUSmUjY2DzaikTXvux1HxPzEV1QYJINJlB
         bI18pbX2gJU9wswIaUYMahwjohXk6ZsKd9kmVPixbxWxeh2CiQHw0naKG8i6LYrAUWoj
         ac2YfYjMxWNhWllkOYZylYnX/OErycJ+yQs1WpVFmgKYdK2A9MuQIbkM+6Us2aY9dNo4
         pmxdkQHLy153LhyM8N76vWQTYI3BH1QOMCIMOuyZDzueQl2QxzmegrFXy9mlm0ABIWCL
         jyNg==
X-Forwarded-Encrypted: i=1; AJvYcCWknCmu7wX+q3QbndHmOCGeiHQE5LcxGOoXD3YV2bdLYXlq+WqVn/I3q3yNRV8CNx+STiUCBGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo5z+XHqNc9CKBn6K6MRYMkAc8ZBFo5B1BG+jnYrnLR/1LulK0
	B3VV2lPuX/m3NcD+SDQyZdnA2D9/YjSe0E3hKqDgE/qe+mWp5MGwZYEl1kVcaVg=
X-Gm-Gg: ASbGnct75qb35isy7GYD3XyKknobwlnl1dv52shnLzAIUjy4REVwshAjyTApbt9O7Kh
	dBVZyWRDC078Im+ob7HDGpiSLWZDa5D8NeNqeP4CySC0O4et+ZIOobHxkx7acu/MmIhv7kGy7Pm
	sHM37yUmjEI4wKhHd6O8MFtHLA3jkP3PHTrCojQ+42An4Nr+7KveuTtyBG4/pawckIh9zr+kKYZ
	0zEXTAPZBRfUpdz/rH5Uo6letJPHhiafJVhwd86ha2LouE60dwf1a4aGT/LHcRRXAIJwTpn3kkx
	csY5fScCThV2EKOgk2O6GDKBTxilibRhuSIcfKDJvOA23ITBvAf1OK48/cAfXovxq0T4uKb2Zbk
	z
X-Google-Smtp-Source: AGHT+IFuQx2H3cMlNyDbzGTiTJRUZ35N/zhrEok+vqYo80fSXfFibunwfroZkHWKOZAAGxWZwp2T1w==
X-Received: by 2002:a17:902:e5d2:b0:21f:ba77:c45e with SMTP id d9443c01a7336-225e0b194c2mr7494715ad.45.1741912462129;
        Thu, 13 Mar 2025 17:34:22 -0700 (PDT)
Received: from localhost.localdomain ([117.110.97.150])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a403fsm19827275ad.61.2025.03.13.17.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 17:34:21 -0700 (PDT)
From: pwn9uin@gmail.com
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Minjoong Kim <alswnd4123@outlook.kr>
Subject: [PATCH net] atm: null pointer dereference when both entry and holding_time are  NULL.
Date: Fri, 14 Mar 2025 00:34:04 +0000
Message-Id: <20250314003404.16408-1-pwn9uin@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Minjoong Kim <alswnd4123@outlook.kr>

When MPOA_cache_impos_rcvd() receives the msg, it can trigger
Null Pointer Dereference Vulnerability if both entry and
holding_time are NULL. Because there is only for the situation
where entry is NULL and holding_time exists, it can be passed
when both entry and holding_time are NULL. If these are NULL,
the entry will be passd to eg_cache_put() as parameter and
it is referenced by entry->use code in it.

Signed-off-by: Minjoong Kim <alswnd4123@outlook.kr>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
---
 net/atm/mpc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/atm/mpc.c b/net/atm/mpc.c
index 324e3ab96bb3..7fb854ea47dc 100644
--- a/net/atm/mpc.c
+++ b/net/atm/mpc.c
@@ -1314,6 +1314,9 @@ static void MPOA_cache_impos_rcvd(struct k_message *msg,
 	holding_time = msg->content.eg_info.holding_time;
 	dprintk("(%s) entry = %p, holding_time = %u\n",
 		mpc->dev->name, entry, holding_time);
+	if (entry == NULL && !holding_time) {
+		return;
+	}
 	if (entry == NULL && holding_time) {
 		entry = mpc->eg_ops->add_entry(msg, mpc);
 		mpc->eg_ops->put(entry);
-- 
2.34.1


