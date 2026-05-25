Return-Path: <netdev+bounces-291219-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vesVHTWVE2oqDwcAu9opvQ
	(envelope-from <netdev+bounces-291219-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 02:17:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E60A05C4FF3
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 02:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2BE9330022FD
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 00:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E9E2BB1D;
	Mon, 25 May 2026 00:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y3yGhh+d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279A3184
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 00:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779668273; cv=none; b=M1RS8qZbL5VXDo6XazPepFvoQ7Whv413uS3rrbAmOMXBJ/OLdZoFLRH3HoRvOJ6bjPtuwuvRMBM0+F0oNatUy5LwelCELdNEM+CqdYX51FgoPeVTQgMBfmM66Q6Tsd7Fv4iRRYgmp96ZnSjtfJcfJA3Tf1Lqm47PZJm+NIkeQSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779668273; c=relaxed/simple;
	bh=/L70Ybn2SmSachCHFEqYTsakGvxxw50wSW1fL9EwBBw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JKdSKVxdXbCapBk6IlOVnDiY8afBRvkHSuxE7Gp/ag4ZwRle1W1VbfF0SIpOOSkDHkPLqyxKmpE6sNm3iX/AV4svCr6PkdCYbHl5TZe9J0u9aXxZpH6KSe2WVbhKbRT0sLN1w5cG0as9Wy9mODtg0QoI0rVT+vSrXKBeRTB+MxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y3yGhh+d; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f756ebd0dso5174849b3a.1
        for <netdev@vger.kernel.org>; Sun, 24 May 2026 17:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779668271; x=1780273071; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uO6x3jQczhKaKZMJTHLJ3cqPb6A4ElEPLEjtvAYwxhE=;
        b=Y3yGhh+diWsktotrNCWqfleJQWtxO4uphf6VcDfW3ggcR21mjxI/h9g2fdo6hnjUcm
         kBJ88S6qrIEvHX5Nd6Ier2h2fKUQKDA3GD0kTw/kw2XaH7CsLBbfsc/R9EZRxodc4sdN
         xmrKEFLY79ni4LMirQH+yfPtMRzrlLeg2lkAbYhYCP6vg3KYqzDw+UNnwX8P0tJ/JYuO
         QoJeSWDqIGdIZPL6mc/Hb5iWvD9XASa94yTsAa/Ptk0Q1M6NbZYuqv/zcOLO83rHVam9
         uxjRXdsVGdepzFq1L0N0v2mTjfktaVktAVJ3Ui2dfKzl9ok5dxqla6/TjsOnOYvBbZvS
         vblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779668271; x=1780273071;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uO6x3jQczhKaKZMJTHLJ3cqPb6A4ElEPLEjtvAYwxhE=;
        b=o/WY77+00VB5dSbt7W82ClUJmZytG4I+a0q4xGvHvsiheV1NeRkOEkSTNO+MiP25No
         judevc6+rhEBLgR4I4+0P04xjHYDL7y+n0+rHS/rZqLzbYst9Ra+TRLAPTM2qI/V/iIb
         Tgo6+SfH54SSpIM/2A0KYO72Cixkb4cA4p+5uhTJhQ1n1Ssu2HjuEarVzlMSD6QEXAug
         ZoWCGU9gCwbN1A+78GSpttmQwwJVdWUOQPZ7E22DVPQz0wz8oB3Q18Rfi7q9CeL9s3ck
         HMZttDTIO++Hy1XMHsN+J9S6sptAFwSTiKRDzJMCCJRP5xx0H4w8jH9CfQEmCXFUPq7U
         8DeA==
X-Forwarded-Encrypted: i=1; AFNElJ+iaOsDDrGsiuFSUdj48GWM6WSkkuU/kTi1XHoJTNRE+L3SIDOgtgAcYYXBl+yAxW1RXUwYLtM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfANTEyWiS/cqr2wK3cvwaqjeFR9D2Zm3CSU0ubDvadkLPDK0m
	Sp/MW5HEvuFbVcNkMJgfFzR50fPPONBz+uY9YJDOGHhnz7E7nh21bw9s2PoPnkLx6EUBnrXrwOe
	ql7Hpyw==
X-Received: from pfdr21.prod.google.com ([2002:aa7:8b95:0:b0:838:1469:2431])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:17a4:b0:82f:5726:be23
 with SMTP id d2e1a72fcca58-8415f3f68ccmr12227600b3a.49.1779668271222; Sun, 24
 May 2026 17:17:51 -0700 (PDT)
Date: Mon, 25 May 2026 00:17:18 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260525001745.1251640-1-kuniyu@google.com>
Subject: [PATCH v2 net-next 0/5] geneve: Allow binding UDP socket to a
 specific address.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Stephen Hemminger <stephen@networkplumber.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291219-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.970];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E60A05C4FF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

By default, a GENEVE device bind()s its underlying UDP socket(s) to
the IPv4 or IPv6 wildcard address because there is no way to specify
a specific local IP address to bind() to.

This prevents deploying multiple GENEVE devices on a multi-homed host
where each device should be isolated and bound to a different local IP
address on the same UDP port.

This series introduces two options to specify local IPv4 or IPv6
addresses for a GENEVE device.

The corresponding iproute2 patch is here:
https://lore.kernel.org/netdev/20260523061102.2762452-1-kuniyu@google.com/


Changes:
  v2:
    * Patch 1 : Move addr_type to if-block for CONFIG_IPV6=n
    * Patch 4 : Don't set cfg->dualstack for IFLA_GENEVE_REMOTE6?
    * Patch 5 : Validate saddr in geneve_xmit_skb() and geneve6_xmit_skb().

  v1: https://lore.kernel.org/netdev/20260523061654.2767060-1-kuniyu@google.com/


Kuniyuki Iwashima (5):
  geneve: Reuse ipv6_addr_type() result in geneve_nl2info().
  geneve: Pass struct geneve_dev to geneve_create_sock().
  geneve: Pass struct geneve_dev to geneve_find_sock().
  geneve: Add dualstack flag to struct geneve_config.
  geneve: Introduce IFLA_GENEVE_LOCAL and IFLA_GENEVE_LOCAL6.

 drivers/net/geneve.c         | 238 ++++++++++++++++++++++++++++-------
 include/uapi/linux/if_link.h |   2 +
 2 files changed, 196 insertions(+), 44 deletions(-)

-- 
2.54.0.746.g67dd491aae-goog


