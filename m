Return-Path: <netdev+bounces-267204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMasKhAgs2mpSQAAu9opvQ
	(envelope-from <netdev+bounces-267204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 21:20:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F43278D04
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 21:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEB01303351E
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 20:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909FC2BCF7F;
	Thu, 12 Mar 2026 20:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xoDGzXHM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451201F9F70
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 20:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346709; cv=none; b=qKQqIleUwdePJpnsWXPNllLJ3iK/aG+6hlIvKzFIzf6aBDM5ZJ9J3g6ewMHrcfQyG1LVXk+yejVbUG3X7vQbNZLkpJRBa4krQBWYjsGlEBbLOyLjou6sa5HXBXAE46sM6OpXRc89TafIbWZLY8xTXqv9d0Xff0/sAslRihtYq3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346709; c=relaxed/simple;
	bh=9+wQXAot9G0XCDYa7pO4TsiOnsLWk5JMaelZk34mQFE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JL/NVf6l3aJwahLqQbzVZev2RAvyZx+2Bc1KgX+G7vDdpE+tbpQk7a/LZ0hezZJ0blAIIt2hP6xADMn+WMuz6Ac9h6x034LGikWZ2wt3rMWEYdFPxMN8mLb3tLCzcbZVprV0zRFN3b39U5vZtdperfUSeUVDnxzvNSIL/uVoFtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xoDGzXHM; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-5091782ab06so200122391cf.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 13:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773346707; x=1773951507; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W2DsTKzMrYWJMpbL0qV7RyfzB6mSXvv1HkCz7eNNjec=;
        b=xoDGzXHM11deYAkRkU0y5DNf5VhBLIFwaWbNviCEe2vTbP216h6y3s2UNNPaYNEcxL
         P3n5y3kWThZsyUDx8Qakylx2cmkro8sovoQfUSYd1aFp2e+ZIntrvGic/ylw8nj+OksH
         6nqqCkbkf2aT5E4NM+jusv5LbYpclVuIBDApzk2b5PwKP+DRLUxwvoLqPYIyDQNL/HrJ
         yn+n3TibPUCIKzwY0UY07WShURN2MmWUXLgtPx7c+vHUjgNdrXHqGevbpfjSDXaExDmN
         nI9dmlxmbpzmJ5vIJqXKpq4JKiTurWzVpzV9Vaby7Xjf1e5nihWsVNmUxSUBBqvIjw3Z
         dxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773346707; x=1773951507;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W2DsTKzMrYWJMpbL0qV7RyfzB6mSXvv1HkCz7eNNjec=;
        b=SQG1cn0wEbxx0TeWgmgqs+siu34Vm3DKq5rXSWoUXMkfyS8Eztu938r2Jhzdl//yfR
         hq4CgLuHJqwXED6AthZt1+26aZTiYcVQv7h+2W4GHrssb6eFtFyNmyEu73TSBNGWilVU
         LI+7QJ8QOa5kzml+417lki5zfolL8CpXru6bAOGoGlTvgetDAxWt8+azE7cDXmXrpxGN
         UiVWGVw3/41H/5+f7aJRC8kE/nuuQodkcBxoAE7V0N74iwX2TSjp7RHvRw1E3cCru9B+
         3M32vZl5siC7uHWksppvhe3FM7Q99DtFtK2KQ4VE7e3dBro20hkTcB8H2hYWUd9ZKYGI
         bZtw==
X-Forwarded-Encrypted: i=1; AJvYcCWBxP3B9nr9B/QWiEy+mViL1FAVOKglZVeW/D81qqoy14iCQjZ4ARK0C0xMGNbxOwkyKPvp7VQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiwflJkZKTFHshLE9ft2kc/ewShNbGh/dYLu7XHu1lDKc2m8Jn
	b/Py4E1eRIKq+UmJ3KWXGlCs69Zo+Ij4etBztz/94TIPFkjgsIMQHcdxTD46OzzUJuFNMl8gVyq
	JKdOyiOv41328DQ==
X-Received: from qtec8.prod.google.com ([2002:ac8:7dc8:0:b0:509:1c6b:aa1e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1ba0:b0:509:4198:546a with SMTP id d75a77b69052e-50957b78d40mr11272761cf.1.1773346707030;
 Thu, 12 Mar 2026 13:18:27 -0700 (PDT)
Date: Thu, 12 Mar 2026 20:18:22 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.880.g73c4285caa-goog
Message-ID: <20260312201824.203093-1-edumazet@google.com>
Subject: [PATCH net-next 0/2] net: add SKB_DROP_REASON_RECURSION_LIMIT
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267204-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 49F43278D04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a new drop reason : SKB_DROP_REASON_RECURSION_LIMIT

Used for packets dropped in a too deep virtual device chain,
from tunnels and __dev_queue_xmit()

__dev_queue_xmit() can also return SKB_DROP_REASON_DEV_READY

Eric Dumazet (2):
  net: dropreason: add SKB_DROP_REASON_RECURSION_LIMIT
  net: plumb drop reasons to __dev_queue_xmit()

 include/net/dropreason-core.h |  3 ++
 include/net/ip6_tunnel.h      |  2 +-
 net/core/dev.c                | 83 ++++++++++++++++++-----------------
 net/ipv4/ip_tunnel_core.c     |  2 +-
 4 files changed, 48 insertions(+), 42 deletions(-)

-- 
2.53.0.880.g73c4285caa-goog


