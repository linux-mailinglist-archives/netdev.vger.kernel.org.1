Return-Path: <netdev+bounces-245247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B33CC9887
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 21:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D8D1830069B7
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 20:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207C628DB56;
	Wed, 17 Dec 2025 20:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRwB2itY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657AA1A9F96
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 20:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766005087; cv=none; b=IDJTosFulNeKrOj2Amymq5yLyLWHzA9VGSrXlJLiZS/9llCI6ZH9Q7Ls1unSbY4nFdqBAwVYF4X+9ErpdOypTXdSW5t7q1irac5KFRAEdeJTJRcx1s9SRybPd+7Z6z/z57J8ECpPQvnYcmwWT6uy7Ud15ccQsyxZ0qdnzDGO+pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766005087; c=relaxed/simple;
	bh=d+zlEPk0bwlVMAv9eOfllTgFc/mp+VNTAuVYhe4tO5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gLJK+nG9VTiyfANwWH2D/U2yb+dvq8pImnebvkdAqBSm3Aeiv2PHLkEUwE9NtOmg8GOsTYRCiuclbMddARNlNUbyyrKVQtWSG4HdPfrL4kqNYeDPejDu59Gw7KcGvKTJtHlgR9QNlM4hIaBSyP+lesBc8bcgSKQVovvwp/jMTn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRwB2itY; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477b91680f8so60844565e9.0
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 12:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766005084; x=1766609884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e9An7Spk1ahHsNbHCce3nw5X83+9lif1DQ15nH/hZo4=;
        b=eRwB2itYQ6kh/0sayloKDj47lPtGXt/oBUALhS4S9gr39GIhKQkfNaXGaybIqwIAsr
         9SMwJ2Ntuzsi1mdMhebDkKYSDnH0ijTgKrdNu68nqwvbVYls2ymsY7qejQdGDtp5u3d3
         /NuerMSY7Kq5EN7ef6g8HLEEbhxYZOjiW6uHdLmkjBtucXz1BpXYF6Z9gosURkKzm4lu
         q7tp3tOZYYNPmZWgKuFNUwj6lSMUoHesp3utiQAtKV1pP5rxNTBzb5BDJUymbOppePx3
         X0wqq2Vqsl9Veh+KXCJBY8lK+LBol3hBEGVB4S955fdWHlUJwvFMRwxRISYtf+phPHBk
         YYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766005084; x=1766609884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9An7Spk1ahHsNbHCce3nw5X83+9lif1DQ15nH/hZo4=;
        b=dicwQ1Vmm+bUXuLNSSfx76o67x9BhT/OSA8/IUIlGYySSJTTRs7x1bzYuORpBsD+wU
         BkDKaYxDII3Js8Glc7F7fgUw98jld4/yu91FRO0YylC/gcrlk9BmJfC9bHPlKIpaRRoh
         63/qly8bQF9pX+ATOejWnaufNbj+tFgPPmEB534iV9DPhFNI1O76Jf3Li4VTdQJFSDyD
         CTIe856ltBnWtQOYiGTg+Kq6Kqng8CQx6ehVrAps832FPfbC1HFuPGX5/Y4bAIXW/Itr
         N0H3C+L5Esmp1jtlEDpntcW/+uf+9yhLGV9slJOHB8UlDbtcrbq11832o2/0j4/m6xnW
         JPew==
X-Forwarded-Encrypted: i=1; AJvYcCWeQgrWuU8ByP8cxBe7iAdnILC3bizmQPnpTJTOQQScYULVKRsI8UE+/xsV2ssicEmgfthHjP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0bBrDaB3UZqIyu9/WToyb//7jwFZId+aGvSgXm7jJmId/6z/O
	vi3iozf+FR1D/16OfFn7UmJHv4xEmKKPBiYvGI0g+8LrmJjMJgTqYqDI
X-Gm-Gg: AY/fxX4M7d6CPech6hJ611Wo43mMi3lQl2Ahdw2sP1hiRUCB34TPxf+wblp3mYNnrHb
	hcZb4LkDTjyPs32Q57ruQrtLI90HXstCHeO25rXRghpd05Bc3C3yCy6SesxiiKPh8htE+OL7vie
	AQf992oM2d+JFIIPLTr9nm10yNk+o+y+4cG4vXFvE5Zx4wE4oTyBVwmObW56Z5kPYZb1SH+SUZh
	09HwyJAfGGyvmPhLFeB20Vxr578y5PSZuL03adU3Kh/Azlr4e+0QqFlX1h24cF8zVBUYTM5F3SM
	Wy/cWrMpfge5+UtCP3lWnhBRMUdm0cq8mtcYvfYgwN12dWv9LPuX/Y6hnwUCXWRhTjF8f7TjWhk
	eFTcZ7fVlk8s8wf2OMv4n9Te8ehAnQxuqeBMZTbfCwg2WuotHZFv3mGbRsiv0x7z6BokChEIr1s
	imRxUqawgTCM0tUBPxFJXZGMVvazpSYpdaZm+y+NYJfrafzIW7pIqpVl2Q+6qQT3P3zRk=
X-Google-Smtp-Source: AGHT+IEAa28T/wJQCGQxP3zh6ddik5Wk5Jn191LMQzoQJ/+WNEiMdywV1ooqtp6fqOYv9biK97NXfQ==
X-Received: by 2002:a05:600c:46c4:b0:46e:59bd:f7d3 with SMTP id 5b1f17b1804b1-47a8f9046fcmr213910735e9.20.1766005083486;
        Wed, 17 Dec 2025 12:58:03 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be273f147sm10461455e9.7.2025.12.17.12.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 12:58:02 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dsa: b53: skip multicast entries for fdb_dump()
Date: Wed, 17 Dec 2025 21:57:56 +0100
Message-ID: <20251217205756.172123-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

port_fdb_dump() is supposed to only add fdb entries, but we iterate over
the full ARL table, which also inludes multicast entries.

So check if the entry is a multicast entry before passing it on to the
callback().

Additionally, the port of those entries is a bitmask, not a port number,
so any included entries would have even be for the wrong port.

Fixes: 1da6df85c6fb ("net: dsa: b53: Implement ARL add/del/dump operations")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index a1a177713d99..2c4131ed7e30 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2169,6 +2169,9 @@ static int b53_fdb_copy(int port, const struct b53_arl_entry *ent,
 	if (!ent->is_valid)
 		return 0;
 
+	if (is_multicast_ether_addr(ent->mac))
+		return 0;
+
 	if (port != ent->port)
 		return 0;
 
-- 
2.43.0


