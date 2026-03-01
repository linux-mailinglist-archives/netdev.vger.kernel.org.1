Return-Path: <netdev+bounces-262435-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MgMITqCpGnOiwUAu9opvQ
	(envelope-from <netdev+bounces-262435-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 19:15:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC701D10E6
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 19:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09B66300C038
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 18:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E9E2E03F1;
	Sun,  1 Mar 2026 18:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eVFQCO3M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f73.google.com (mail-yx1-f73.google.com [74.125.224.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C32175A89
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 18:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772388901; cv=none; b=itm8vFDniPyRF+aMbrjJjuw0vo/zBep+9EXdYmA5nacfSJabdZI4jyVu6qeLg/wT1mmRhH/CYYtXG8+dM8CVeaa8DEnAmIOMQ6V3+c9CzJLAvZPdPBb+ACuOKdMTMFKpgi95AAzHoCiIuRCPV58vBy5UNzAyncTu5UX+Gyxyh5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772388901; c=relaxed/simple;
	bh=/XuXLsXPl4vQK2b1I4JNwooKKeJlVY0cRO/gozqtYq0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kn8mQrsTyPCAfQa0vb5BH2VUyLNsrvYYuyW9UOCQbA4MwemSx+RyBk7zoXFT6RaXvdW5XPBJiQCYuG3PXkaea0lbhJ8wN0s/ToCnynayWWuEK/cQiu45vfoquPYv2J4c2zd5aglaECTcY413MGO5Z/G5nl4Piisr0ypJKUVphcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eVFQCO3M; arc=none smtp.client-ip=74.125.224.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yx1-f73.google.com with SMTP id 956f58d0204a3-64ca9ec3eedso5531648d50.2
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 10:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772388899; x=1772993699; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QBbrX5oGVzhacIOLTUXGJwHGMGVkZTWSfg95Ue9DCVU=;
        b=eVFQCO3MYU39uSlBSK0UuhdrkfBoDS0rZTUOuEzfSGDKzWYxcOpe8Ry4ymafj4Dak8
         ogItzys0a5WAxG7k9R+kBS+zqzRCqjJ6RlR52ZfE7mz+RZ/06Qjr4VvM6SSlZ7C8dvZT
         a2H+bIFY9V/Pxk50MJMo7zZkI3VBMTUMlgkoY+JVd8rz4YurJ62ei1002n2VEmDgs1iD
         dpVqZ4eNhoujxVlJNjpY4kQjAd3c6cEOUMorG/a8nXakZ+xuDYwoa2d/ONAML0Hcnws4
         QhF/DCcjYospVg0NuiJlflwhcLGOzUskI7+Cu/JlQk6vXh4LZm2ayPYkxLs/Sp2w5d4W
         2t0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772388899; x=1772993699;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QBbrX5oGVzhacIOLTUXGJwHGMGVkZTWSfg95Ue9DCVU=;
        b=ntq9e/j12yX/gQfr15Ec0SkEq93WcEF041wQfNHAOZyp5j5OceFIHpRCd4Am3npPkn
         PO994Srv9sJ/LeLsH6FSAiptLzQ1uLTYng9f6radl3SN2IcZvCJGxT/E5W+sBv47wFKD
         +GGOaVDP/3TxlTo2rSsg8DPokapht03iWITp7I+fUJ/OisDeRhYTme7D/MH+JIwKEI1R
         TV0210Y5e4Sva+ZjkLsoNhulVx0a2CQEXRo65PycoWoRO8M8qRNIwD8tC2CZkNv19d4z
         2VtnmdJEau8CYx2fM9DuEyVFV7cWxyM2NfPq4gD7BwxlFAKyqgmkzh3K5Jl1RMF4Bjx+
         j54w==
X-Forwarded-Encrypted: i=1; AJvYcCVGUjYl4/Fftz4u46qJ/xtqGtv8wJq+kWX7ibm4pNXe7KuNaxbJvLOpr7XTKB8mQ3ItQ5Av8II=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXQ1KKjIUBofLgOM5k3sOMh+T3fOVdZIIHMVmHprbh3jx7nvMF
	UkL5fgZcemb5sKna3Z6tNGp0aLBNHPWwV60Ckxy7bKOm+etugaWZmwLydWB/WK48ssbkU+/KjF1
	UG2gWNgS+hUJMQQ==
X-Received: from yxbbn22.prod.google.com ([2002:a05:690e:4196:b0:64c:9aba:83e6])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a53:b4c6:0:b0:64a:f0cd:d4e with SMTP id 956f58d0204a3-64cc2210621mr6460562d50.56.1772388898753;
 Sun, 01 Mar 2026 10:14:58 -0800 (PST)
Date: Sun,  1 Mar 2026 18:14:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260301181457.3539105-1-edumazet@google.com>
Subject: [PATCH v2 net-next 0/7] rfs: use high-order allocations for hash tables
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
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
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262435-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EFC701D10E6
X-Rspamd-Action: no action

This series adds rps_tag_ptr which encodes both a pointer
and a size of a power-of-two hash table in a single long word.

RFS hash tables (global and per rx-queue) are converted to rps_tag_ptr.

This removes a cache line miss, and allows high-order allocations.

The global hash table can benefit from huge pages.

v2: address various kernel bots reports.

Eric Dumazet (7):
  net: add rps_tag_ptr type and helpers
  net-sysfs: remove rcu field from 'struct rps_sock_flow_table'
  net-sysfs: add rps_sock_flow_table_mask() helper
  net-sysfs: use rps_tag_ptr and remove metadata from
    rps_sock_flow_table
  net-sysfs: get rid of rps_dev_flow_lock
  net-sysfs: remove rcu field from 'struct rps_dev_flow_table'
  net-sysfs: use rps_tag_ptr and remove metadata from rps_dev_flow_table

 Documentation/networking/scaling.rst | 13 ++--
 include/net/hotdata.h                |  5 +-
 include/net/netdev_rx_queue.h        |  3 +-
 include/net/rps-types.h              | 24 +++++++
 include/net/rps.h                    | 49 ++++++---------
 net/core/dev.c                       | 61 +++++++++++-------
 net/core/net-sysfs.c                 | 66 +++++++++----------
 net/core/sysctl_net_core.c           | 94 +++++++++++++++-------------
 8 files changed, 176 insertions(+), 139 deletions(-)
 create mode 100644 include/net/rps-types.h

-- 
2.53.0.473.g4a7958ca14-goog


