Return-Path: <netdev+bounces-307606-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m1GOInu4Vmo0AgEAu9opvQ
	(envelope-from <netdev+bounces-307606-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 00:30:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 211D37593CC
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 00:30:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=purestorage.com header.s=google2022 header.b=LNAVcTtI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307606-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-307606-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=purestorage.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 875E1301747E
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 22:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4197B3ED3BB;
	Tue, 14 Jul 2026 22:30:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1729F2AD37
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 22:30:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784068216; cv=none; b=iot+f6WHPJE5vxvO+QuhHdE9bBzNJJz6hBqhFTxbPmWePUy25t4fIk7Cr/xWUEtPP7CYzY5jEjzSUmqPXKKWbvwAv0dUiVJWZSvYrS2/SLGFW/iOZMFz5gHCBIuZO8r1kZRqfq4VdpmUFGciEau7z9PERXse42VPzW9wBGj2IsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784068216; c=relaxed/simple;
	bh=DEm9NUtHEjbHS6xPMwIBaPugOtrLEYOMfZ9ictWp0X0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j3QuzzjF489Sp5sJ4GOv06K27Ctyg0d7XqGt/T5Y7o/Kyw+a/d3XwBYxG2IH9jT6Vcgwt6RyZ7V4OxPDFQSAp5oKZP+w2uWFeWlmmjY96GBmMK0+zWCTd3QtfVKcpN5/ovXcG82gS8LDQ5AtddRUy6hEcN5ddLk8/YBpsvJKkPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LNAVcTtI; arc=none smtp.client-ip=209.85.128.52
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493c19bad03so43126185e9.2
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 15:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1784068208; x=1784673008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m7QorHOqJsKl7dLCabdPRyIk352hG19llomrerTBPDE=;
        b=LNAVcTtIBatOFYy3lT13u5RjrlheutoqHfeAsuDKZYzglM8Z5+dwfUQVDJuAHvvVes
         bYRNsA/rsPiTGlGU/9r+W1Moyl+hn8fIzTDEKxF3dTIowWL3y0/meX6vWW+FG7eAYY+C
         teUDrHgkewcg6AXIQjlXhWWPixcXNCsICllJWEwFlOzlHqZX2h+sRxxgs6U588uCl2Tn
         j7Znr9c5Woe9DelCZj80qmP4z7ENL0fYA+p0QoKWe3v5IKtmpsWBJVz35o3DzMK9uxxX
         5YBe7qgtFxb1YGNRZyHnjMQgiJeqEcndnuU1Y7JsT+6x923TNpCqtg0LCLjXWVSZtu1z
         Qdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784068208; x=1784673008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m7QorHOqJsKl7dLCabdPRyIk352hG19llomrerTBPDE=;
        b=Pr/ZQG4kgTiMMPboxiJlaYQSileA9dNnWm+khMJy9IAp0NB6t99C+v0u9ns90ISP6f
         d+46JlcTuJEdzqXaVm5OUUZiCpxE6HUZrUqlAczrAYUBbwwDEV4SHkT7zdnAyYuyaq+m
         mNBNsUxN0M4h9ShtXnVhHdMrVVh9QUd4D+9aKtGqnyMAv+u4r7vqdHGfX5HPpC5HoyWA
         Va1whXL/gEzDCxwRamnJkLKxEreogTBa+sYhrV0uVNBwzn73ehByz+lHb4xVGwRahECH
         pMdAZba1Xjqd8o439kR+adwO2t4Fn25Z86KyveQBUQwq8nGlHK7bvXh5aB0scgcLnPkW
         6x8g==
X-Gm-Message-State: AOJu0Yy+qUU5iSBmAxd/AedgksqKHmZOuR5PwcBcI3sdapzH2DSthxLw
	eX4YL/h/q8I4mTC9gLfZa4vi6ynvMXPkRJxndqlwEC96TtOxuPP1zxVcEOXAM7hzaX2+1wEtqRo
	95KKKMD+fxC9Pq1ONGNLC5fSomMojQ8pQZsGx5UnhcRJqnvNSYbLTHIrxiYqsyUBbw3pvWLzGsc
	HTkV6OO1X/PD3O+HHDj4fUOlb8Mb9HIlFJWdUjGcjtMt7douM=
X-Gm-Gg: AfdE7cko21MP7U9HKxkCWx0VugU/USpT1Szar7PvDsgcX+KcJ6rQPml3VEYCdcZwo9w
	9hInlYpSRCTL3XU9evw1IulxR1qNBZ1/mToA4ndzDD9G9kkIBE9oUwCqvVP2ahJHGBLT/kfz/dH
	CsA9cGGWvLDcbhTBbWV/1MMOXCokEgk9/0MIc7MQyop/a4lSAI7VhwAA9ujuVseFiAEyhoK7tUF
	YbJ4qNSAxRg8Q9ept466rYY6hUh82AnwAcSEg/dDTo5SYZVvnL4InbUxLclpRvzyQIeeZXEEqB6
	122gwsJYtXm0zuaf+M4V3i5iFUMUemIM2ftSByLneO0/+aIny1/GfjNEH5AslyPiVwh+gbzBZcv
	AYtIhT/doSEMY5LudD0bnTYFJZ100CF66USTjAUtndsSASX+cdb3NMJzXS4hjYo2setD1ZNDxX6
	JOqcjjTtcEiXv6C5u6CAWXuRyAUdMP1EE5UsdUoGhW1hq0hpvzno6cjUBQML6VlyivUfAo7JiNx
	eEmgVu4KM+TLVD1OBtBFJ9tuHgo3yWATIkZ/szAz/GQUB4YKu1XOKnPHrJCbaPmn4b5nvnhBTAy
	lCsWSxyxdngZZOA/JtYEwtBdXLIv22oyWQ0=
X-Received: by 2002:a05:600c:8115:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-4953c14f78dmr5319275e9.2.1784068208049;
        Tue, 14 Jul 2026 15:30:08 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-495087366c0sm196536915e9.7.2026.07.14.15.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 15:30:07 -0700 (PDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org,
	nils.juenemann@gmail.com,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH net 0/2] net/mlx5e: fix NULL derefs when RX queue mapping outlives channel reconfig
Date: Tue, 14 Jul 2026 16:29:13 -0600
Message-Id: <20260714222915.2334949-1-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307606-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:sd@queasysnail.net,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:leon@kernel.org,m:nils.juenemann@gmail.com,m:rjethwani@purestorage.com,m:johnfastabend@gmail.com,m:nilsjuenemann@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[purestorage.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 211D37593CC

Hi all,

This series fixes two related NULL derefs in mlx5e's kTLS RX offload that
surface when a channel-count reduction (e.g. ethtool -L combined N) leaves
sockets carrying a queue index that is no longer valid

Patch 1: reject stale RX queue mapping on RX offload setup
Patch 2: guard RX resync against stale channel index

Not addressed in this series:

- Torn reads of `priv->channels` during the struct-copy publish in
  `mlx5e_switch_priv_channels()`. A reader on another CPU can still
  briefly observe `{new c, old num}`, so bounds-checking against a
  stale `num` can pass while dereferencing the new smaller array.
  Closing that window likely needs proper synchronization,
  such as RCU pointer, which is a larger change and better handled
  in a separate series.
    
- Re-homing existing offloaded sockets across a channel shrink so
  `priv_rx->rxq` remains valid. Patch 2 makes this failure mode graceful
  by preventing the dereference, but the offload remains functionally
  broken until the socket is torn down and re-added. That looks like a
  broader design question for the mlx5 maintainers.

Rishikesh Jethwani (2):
  net/mlx5e: kTLS: reject stale RX queue mapping on RX offload setup
  net/mlx5e: kTLS: guard RX resync against stale channel index

 .../mellanox/mlx5/core/en_accel/ktls_rx.c     | 24 ++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

-- 
2.25.1


