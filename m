Return-Path: <netdev+bounces-156371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 732B6A062BE
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 17:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5883F164EE4
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23A51FF5EF;
	Wed,  8 Jan 2025 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6501MXm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3E91FDE3B
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736355448; cv=none; b=l1FbX+HMcWxj+JWNScPSY7rNxNyeoDl2jq/dAGc12PqNLREou0kNuJ+1nvpJDDQlpZnFRtr+CerpGrd3UJsycj0HXJXDykyBtes3eo7LmlvLytC2TuyALHdlRu/uORtAxD47H3mCf/I0DdcSaDB6ai8wNL+griFQpVgXap1uS9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736355448; c=relaxed/simple;
	bh=BkxSaWss6TrGccpvNoro6RKPJS0V3vDSgdqmWPsVxO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fpp+NTUioJcCYQEhEXBj+TNzgWl/3+/RvzS9/BmsUAkjWoPrFvJDLjYPg2mD0yp7eRMpzrI26Hk1RtMP9rD1wwOjiTLXyKE4sXbbvKD84hDm3XW3jl8KwGHlMEJyL4x+OsnDDw345W20nf5WtQMWeEjsy6ijiuNqiz6wQ/It73Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6501MXm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07CDC4CED3;
	Wed,  8 Jan 2025 16:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736355448;
	bh=BkxSaWss6TrGccpvNoro6RKPJS0V3vDSgdqmWPsVxO8=;
	h=From:To:Cc:Subject:Date:From;
	b=h6501MXm8vspDDxxAr7k2Yj82s6iG/INdl2cY3smnoWXYljt2mn3Fawh+sQVYdJsz
	 TtfIL3GND9aczb7VTnhXH7zulQ5+FwLyhqH4k5yHuMPErcpj0PtVsVERtg53Zaq1rg
	 xGRDSwsH/LeCBVzYR3APPY1cpp8d/tA6vxp0di8okLnVQ5JEIDU0Zr3emH6rhDTHWv
	 yFiGiFiEaLIRJBQ3SHI9dGiN+Gu9Xy1d+e8SL3r2SoyExxyGdiPp3sIRJdoWDoUaCR
	 JfABnjItOdsDr9KNYAtMrUiAFoSVy54FWm5BH6J3SJw0FYDvHoZOprwmn4VlDS75S9
	 IKeZFeW/HwDUQ==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>,
	netdev@vger.kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>,
	Menglong Dong <menglong8.dong@gmail.com>
Subject: [PATCH net] ipv4: route: fix drop reason being overridden in ip_route_input_slow
Date: Wed,  8 Jan 2025 17:57:15 +0100
Message-ID: <20250108165725.404564-1-atenart@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When jumping to 'martian_destination' a drop reason is always set but
that label falls-through the 'e_nobufs' one, overriding the value.

The behavior was introduced by the mentioned commit. The logic went
from,

	goto martian_destination;
	...
  martian_destination:
	...
  e_inval:
	err = -EINVAL;
	goto out;
  e_nobufs:
	err = -ENOBUFS;
	goto out;

to,

	reason = ...;
	goto martian_destination;
	...
  martian_destination:
	...
  e_nobufs:
	reason = SKB_DROP_REASON_NOMEM;
	goto out;

A 'goto out' is clearly missing now after 'martian_destination' to avoid
overriding the drop reason.

Fixes: 5b92112acd8e ("net: ip: make ip_route_input_slow() return drop reasons")
Reported-by: Sabrina Dubroca <sd@queasysnail.net>
Cc: Menglong Dong <menglong8.dong@gmail.com>
Signed-off-by: Antoine Tenart <atenart@kernel.org>
---
 net/ipv4/route.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 0fbec3509618..e1564b95fab0 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -2445,6 +2445,7 @@ ip_route_input_slow(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 		net_warn_ratelimited("martian destination %pI4 from %pI4, dev %s\n",
 				     &daddr, &saddr, dev->name);
 #endif
+	goto out;
 
 e_nobufs:
 	reason = SKB_DROP_REASON_NOMEM;
-- 
2.47.1


