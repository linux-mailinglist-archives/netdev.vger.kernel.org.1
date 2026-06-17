Return-Path: <netdev+bounces-300008-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mthGNFwMMmotuAUAu9opvQ
	(envelope-from <netdev+bounces-300008-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 04:54:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3247F69631A
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 04:54:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Otjo4cfO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300008-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300008-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F5E3307DFA1
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 02:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778F72F90C9;
	Wed, 17 Jun 2026 02:53:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FA12E7368
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 02:53:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781664839; cv=none; b=Ql01kn/lDMVtlyWEUJFv9muLmgEK/Pn0Vl1gB6AhFi7iGqE1pwSOrbTvwQ5+zRmjyB1YZhnaZ4+GPmcWzBo5zC7zgYcEJrajrZ4lnGfQDzfpoWL/xGofHuKXxqJ4Czl/FTZ7YKnO3UKZzM0n/255ccH8UZpN6sAZG6GO8nZN3FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781664839; c=relaxed/simple;
	bh=GPrKib3WcWgvn11Fksl4A4N2zudvAQPrD7ofP+s8RMw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oQwLYLofYQ7Ylr1DSG25iIchmOwu4FRv73XA7IB0zVGI4WIfhlaW46/s9q0HzwiqC8ILnIjB68WEbyCil6GdJM/G2P5uh+pjSVrE0i4Kbv1B/XDtI3bzj1aNEwhztV7vU/E+a5xOrl9I2wCbjTwz0yR5s9EwPsy27q/BywCvcbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Otjo4cfO; arc=none smtp.client-ip=209.85.216.46
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-37c8e7c8185so373570a91.3
        for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 19:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781664837; x=1782269637; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ynVgrV1BKxZf8bSSqKXL4ymJEj5mSIOpHynliU6D9pI=;
        b=Otjo4cfODCql7Nc6Nk1jzXa6vzyhf/i3mNRqR2V1P1w0DJnxtPjuzgM5KLlmE2eL6w
         hVsTu9s6tSJ+LJYKuKzJoKIbNUz3a0X12tXVO3VEYWufEt/QAUTycqh35c+An9E1XW+h
         Vd5amQSgAsNpYKuxF2jWY22XUMk9yOLyjJ5TCm2Krv9Gq7h4xKjcxSpHYACYDbD1zX/J
         yDcle+s0JJNhuohdQLGjTCOufnkWNBlZcK5kQdK/DCsRVqwC8YtPm+c4aJ/zPHNkGfcU
         COqg9aKl9kuoJ0Ob+r0VKf9IPqSi5DpNhPYLhImECCpfHSlE4n0ZfxZ0aIsduYFaULfF
         jqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781664837; x=1782269637;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ynVgrV1BKxZf8bSSqKXL4ymJEj5mSIOpHynliU6D9pI=;
        b=o9O5CYr6tL5s2ttIiKOYFLQ8g3ho0z0VfHsdQmTcdv+CZvrADunDETvhuRW2XSFMOu
         1ekNt0e7czi7ymWwPpjwxqHz+AgkMC36Zx+4seU0Z+kJ5SdQsud+MiDfLPKYo+TTGLPd
         9PhAd4TX29DTpjWlaN76pktDoD7Wk6C24Q8lkLds9VO90tbjMlJnrXUlz2pEhP8Trzop
         +SmSKDgI2AKDkUahUQ+4ezZUyCPN3hezqR/xhd0qbVb9O6DXnLsLbrnyoTUTjwTuOi3t
         /xijIPRJv1MAukbwh1oGoSygQy3tBGJHQ5UaDRveT73Dq457ciTpVZCur1urgHA5OwKa
         AEhA==
X-Gm-Message-State: AOJu0YxdW6GhCQIvhr7JtDOz4xFJHhd8GcylLkIpwMzemxDNu7UelZKq
	MZIePMsF/CrnH9Osc4Oq2fVnqqYGTyiqI/dC5kEVxwPD+zWbfmYz8SDCl1RGK+SedR52Pw==
X-Gm-Gg: AfdE7cl8dfuDBFqJr867oLecuaEzHO6QeY6RdppcUx/a6rXzceUH8QTDWiNJbDfzEpn
	RUoQ7YkJE/Wp9gBt88pa03TvRS3n6+F/KHoWBEubzBeGD3cFMH2qAD2VxVq2C9OZZ6MP4gdqCTP
	FX2l8g7lICLh0hkKyhqjo/6Mh45TOEQv3eAnO1y1QIhXU0ZokLUSy57loyuMmGhAyX+cYvlsZ6k
	mZ0oWkNA0ZVMa6HUKgjkkTfqUP5UJfF0isP/ZMM/eWjK3qtbpWk0ypO9PQ+/ZjCcpCMPe1WCgo+
	vGFAGTB89mwWJANG/HuXTRuOW+bK8FMF48OvZQqAfgLzspwB0SPc0WTOarYlWqEMRmHIOSO9Cv8
	lHD3QTJFraL9HrudMBc/0IJUDqeS012KFlSgbxs2d9D5RTDIk+TyqTUY0BjjuJUcbQKFSMRxOnH
	4I9DoHHQ==
X-Received: by 2002:a17:90b:224d:b0:36d:d8fd:4578 with SMTP id 98e67ed59e1d1-37c93437f61mr2004429a91.11.1781664837535;
        Tue, 16 Jun 2026 19:53:57 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c521ae039sm4334909a91.1.2026.06.16.19.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 19:53:57 -0700 (PDT)
From: Wayen Yan <win847@gmail.com>
To: netdev@vger.kernel.org
Cc: lorenzo@kernel.org, horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: [PATCH] net: airoha: Fix off-by-one error in HTB rate-limit channel removal
Date: Wed, 17 Jun 2026 10:51:40 +0800
Message-ID: <178166483303.2209640.10761097847073356089@gmail.com>
Content-Type: text/plain; charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300008-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,lunn.ch,collabora.com,gmail.com,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:lorenzo@kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:angelogioacchino.delregno@collabora.com,m:matthias.bgg@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[win847@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3247F69631A

In airoha_tc_remove_htb_queue(), the rate-limit was being cleared
using (queue + 1) instead of queue, causing:
- The original channel rate-limit configuration to remain active
- The next channel to be incorrectly disabled
- Potential out-of-bounds access when queue == 3 (channel 4)

The alloc path (airoha_tc_htb_alloc_leaf_queue) correctly uses
channel (0..3), but the remove path incorrectly added 1.

Fix by using queue directly to match the alloc and rollback paths.

Fixes: ef1ca9271313 ("net: airoha: Add sched HTB offload support")
Signed-off-by: Wayen Yan <win847@gmail.com>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 31cdb11cd7..02807b3967 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2805,7 +2805,7 @@ static void airoha_tc_remove_htb_queue(struct net_device *dev, int queue)
 	struct airoha_gdm_port *port = netdev_priv(dev);
 
 	netif_set_real_num_tx_queues(dev, dev->real_num_tx_queues - 1);
-	airoha_qdma_set_tx_rate_limit(dev, queue + 1, 0, 0);
+	airoha_qdma_set_tx_rate_limit(dev, queue, 0, 0);
 	clear_bit(queue, port->qos_sq_bmap);
 }
 
-- 
2.51.0



