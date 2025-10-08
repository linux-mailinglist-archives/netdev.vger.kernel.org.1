Return-Path: <netdev+bounces-228193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7A6BC46BD
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 12:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D668D3513E8
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 10:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3CC2EB5A4;
	Wed,  8 Oct 2025 10:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0YMLsGvG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B042571DA
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 10:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759920378; cv=none; b=I5VA2DW8lgQnH5fJDIkYebL61KhUlPqGdH7SAOs+C8tW/hOGV0SlPSmojVNKMdlPgfEoTVH7A9p3Eqj8beGMMJy1242oe2veB1cH01C0hjCXhQwmCmXSQtIKR4G3uTUlmxmWIyt5YcOaSFaLVqckgICjIzZ9+bVbPhmimiApT64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759920378; c=relaxed/simple;
	bh=LsuepPiesmwLeDcQ8Y6Sx5enFUDqVBeHJWfFbigSCc0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gb70dzX4uFkIBPf88kT9/dWNDO+kOpZiUTvGAxFuzWK+PPNw3WAXNwheq36Q9dcjM6UN73CvgGH6qx9d3xZveY2MS73lJouvm1PWP9hgSFSSaLij/tGI/d5OWzBVLMoEyko2CXVrJA9KcMqZ3ivsmzSQoknSBVde7blIpWrNhGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0YMLsGvG; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-829080582b4so1723210685a.0
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 03:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759920375; x=1760525175; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ut+HPFeaSURFyrm9eZWalwGWcuTdSn4NlIPvr6P0xmo=;
        b=0YMLsGvGQ5geobRYBevBF6yyjj0f5dBNuV6zKX1v8MJfVL3u815Or3bIqpnZmVkcbS
         Zw59yMxwW43VvGttqTBKlpkJQ5wWdW1lb+RlKYMVi+aUC9MgkXLN1wAshaztnBEZ0/tU
         gHsfbcKSr+t7J8s6ikHrd5lc+LxEZ8AlYKbwYHtSoNYUjUe+aSxI7wwu6/5NcRiXcMeF
         wIWDJ5jRBzHwIsDvtORyuM6zYahHau/lCMI4hqg4DJksp6Y3Q8CKlV0geqa/yVhdSdGd
         OqSnXFUnq0t6Zp4+huMfnpp7WZQDx9nUZF8KG9ifIDYzvsaojeKppVU2h2Hzd/a/muB7
         PhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759920375; x=1760525175;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ut+HPFeaSURFyrm9eZWalwGWcuTdSn4NlIPvr6P0xmo=;
        b=KC/H4MUEuv8HYzVW19JHNVfj2cfH0fuAmbsZS+/hBZGApC5Wto6tsoVcyv5QnuwxoT
         dv4Tq8mn5KgVfS5H59TLuS/7He8l6vnmMttpyJ7/l/1CWzTf88KB6mp781uKE/VjgvCI
         eY46tgyUwdhS+C/7+G2ZCF5Jy7wKuH7XAfoJca8noEjACNzyiZNS4ppOa3AdGIMPlmkl
         SSQ38gasAFcE89ycDzivxo6WgGPtUcmG4dlMSakra+XcdCBl+q9EkuPMsLZlD758GBQo
         KpAmftaOkNX/1hvSRCeYeDtz8NtQzTZcqBUHdD/8rH5oYvZygigll3pDtoxm+gOMnHRt
         MJkw==
X-Forwarded-Encrypted: i=1; AJvYcCUSDGCXHOTZAm87axj+CSgmeAREE8Vv/JtHO50VcDiS3OqLSCDkfeIe5SwZJna0yY8NrVb8tsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw25FJwVEjgx/HkNyr5ErHr1DXXg0yeaMuBZ2P9qGXBpmS/j5Qx
	VjXzaXcc9d0XCyHunsXZ6oTvCwzFu/F7sqgsLStOPW3+NQPB2/UAIDsOiNsiNdmx4t+mSaJCNEx
	qBjB7Hj0+Sfgspw==
X-Google-Smtp-Source: AGHT+IHI6pn8RGdEEEGKEqgmz/3yMgQi9OtDtFFixwx4fiVKGZy38pFr3z/52N3n+q5wt3ODHwrlGZW2EJUxnA==
X-Received: from qkay16.prod.google.com ([2002:a05:620a:a090:b0:7fe:9767:1b7f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4456:b0:870:39aa:75df with SMTP id af79cd13be357-883502b6d13mr363745085a.15.1759920375322;
 Wed, 08 Oct 2025 03:46:15 -0700 (PDT)
Date: Wed,  8 Oct 2025 10:46:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.710.ga91ca5db03-goog
Message-ID: <20251008104612.1824200-1-edumazet@google.com>
Subject: [PATCH RFC net-next 0/4] net: deal with strange attractors tx queues
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Back 2010, Tom Herbert added skb->ooo_okay to TCP flows.

Extend the feature to connected flows for other protocols like UDP.

skb->ooo_okay might never be set for bulk flows that always
have at least one skb in a qdisc queue of NIC queue,
especially if TX completion is delayed because of a stressed cpu.

The so-called "strange attractors" has caused many performance
issues, we need to do better now that TCP deals better with
potential reorders.

Add new net.core.txq_reselection_ms sysctl to let
flows follow XPS and select a more efficient queue.

After this series, we no longer have to make sure threads
are pinned to cpus, they now can be migrated without
adding too much spinlock/qdisc/TX completion pressure anymore.

Eric Dumazet (4):
  net: add SK_WMEM_ALLOC_BIAS constant
  net: control skb->ooo_okay from skb_set_owner_w()
  net: add /proc/sys/net/core/txq_reselection_ms control
  net: allow busy connected flows to switch tx queues

 Documentation/admin-guide/sysctl/net.rst | 15 +++++++++
 include/net/netns/core.h                 |  1 +
 include/net/sock.h                       | 43 ++++++++++++------------
 net/atm/common.c                         |  2 +-
 net/core/dev.c                           | 27 +++++++++++++--
 net/core/net_namespace.c                 |  1 +
 net/core/sock.c                          | 17 +++++++---
 net/core/sysctl_net_core.c               |  7 ++++
 8 files changed, 84 insertions(+), 29 deletions(-)

-- 
2.51.0.710.ga91ca5db03-goog


