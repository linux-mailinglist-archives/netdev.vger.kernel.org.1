Return-Path: <netdev+bounces-264507-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0I8eE/3IqWkAFAEAu9opvQ
	(envelope-from <netdev+bounces-264507-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 19:18:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A74F5216E8D
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 19:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8882300F506
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 18:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377753C2788;
	Thu,  5 Mar 2026 18:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="GuKPenbN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C066328F935
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 18:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772734703; cv=none; b=aZnnRBLBKs1vxsAdHQoxx7IT4j3kBX0fex4H1Kl7IPd6AZWfMEXZ2ML/OvsGBA9NMliad+6Po4qdTrRkuRgawOGBEcMDpAvsACOO5UcV2tIwAJP/6R+5MgEP5uHIFX9P4hBwGSezFiaYoFGT7iIfFiu+9KUY0G9Remg/wL3Gmbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772734703; c=relaxed/simple;
	bh=tiSUEN56ZvCqaWfDPQE8Uf3DZlIsQKn93I57zHQ10tY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l3j2i95IkacUlm2gdyBBKKkUtF2dBJ9Se+HUZMkTkOoW8CydcG6P5mHANxqtCT87MG7dBWW6vG++p0ySyycqXNLzJSQGUek0SGqY+l0FdgRfZWR7u1QBCtFo/QcZyTUne/h9nym/ALPNht7u1gopONWpuNY3X295zqR1A/DLHrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=GuKPenbN; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-677bb1c3a9dso2891944eaf.3
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 10:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1772734700; x=1773339500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MAfWvGGG+tk1cSsVslj4ktbXNKZITiqUazA+p2ZSRTk=;
        b=GuKPenbNbFsJqoGHI1pMu2icy9NFesKSxbT97lCpbku028TG6nCIzX4BKbBihIS0pZ
         aSqHd2xwnxgv0IAlpS1W8lHf1gSMsXGbcy7cRfYuHXkjVdjhZnggZ6Wb8JkINRZDsdE2
         Do807v6tR7S5MmC/xK0CkiH0Y7F0cGHAj2Yt3oaSPBW5hVBj1qR9kjX+OfpuGyHstGPG
         ZegfG5ITgX9s4zgWPHgJqdbJGYuNLXnKENoeugHU1FqzxSgPU/WLrIVVNmD+WHwzQ0mp
         gP5QASovqPpF42H8ObX+75J5/NUE0xOCk0VOCQi5WE9xsmXyRfTCpTqQFM03yEb5L4l9
         70aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772734700; x=1773339500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAfWvGGG+tk1cSsVslj4ktbXNKZITiqUazA+p2ZSRTk=;
        b=k2L/9P9ubgoj1+qat1pK3nW/Bbw73jNVXhmMxOFHommF2iLiEUX1GgJ2m/8MRIQ4QR
         ki+VaGbiA3BUaz5qvpSoRkM3k5XyYJLg5TAUkIDMMTl/OpegGVc6/YpBcDk8WOmX/qMa
         AwwhClUxF1LuAZ4Z8QzrajI/VSs9kfQLayuVuWXZ/KTckJkn6gnB+Yxkrq4ZfNhjVoMO
         OT8XZ/NQMQbrikNDmjb/9kJwBWb+nfPh1mCMKuUO3WSBHaNxPYayn4IVgtp2wvVfRIHO
         4YbIxnj0U6Rs/FqzB/eIXn1ZUsKZRG1EZTdMTcPgsmTWUQuSpaIVDcgkSLCMsnSi/HlH
         8Sdw==
X-Gm-Message-State: AOJu0YyuT6UG+RONt/0qbkYfVR6DdRoeafYBoFZl9QiBZc4bsE1/b4Lj
	yskbjV0i5F7cmZ918S5wxUPn+6Nw2OBKp9umxGzRDsXIt3pKWEfHOi3m2fpJ0lcPE053ynFGSpQ
	OLTPf
X-Gm-Gg: ATEYQzyNrvVbXBtz76347lhK0eliOoXqZNT2+M0Sk5m+Wxc60qYKlbi276HDqV57iqm
	tP6eONAr8gieXJkZYhJXCYq//JvyYWmpG4H1wMwKq3EKQjgt0PIvozosuOAmZIXxbBtsnhYFKJ5
	WDA+xDFzzl3ESV/LOjaMm5aya0eA6n52oa2Mev+peLl5WqignJQkpiFHq7qIz97QI2HbOBCXm1g
	MqtOSfYWKw4nGyyfSZSHXUGHy0EM7puJtrqZSr4+CU7+2oDaPknn+2PdTcZBEH+LxYx/cNUYVlS
	dAwV+YpTkFxYKmgvg4W554EwEHltDasSIWTPxaVTfSJ5QBkE5Hv3qurx3Xdn4DRBQnKb1Ni72YU
	4rHiBp1Aj6Sp6DiYOREA1ViMEIhWzr3ofAT+1Rh6LOnsWq25pJZqeLk0X0wiouDn3M8F2/IaNtQ
	V7EqZhN+9tnldeBr1AA4fHJ/9AUQlM2TY+u8PLZM1D5g==
X-Received: by 2002:a05:6820:228c:b0:662:6b87:f95f with SMTP id 006d021491bc7-67b1e92ed19mr3727581eaf.74.1772734700233;
        Thu, 05 Mar 2026 10:18:20 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:53::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2d9b7bfsm15627457eaf.12.2026.03.05.10.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 10:18:18 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Joe Damato <joe@dama.to>,
	Wei Wang <weibunny@meta.com>,
	Bobby Eshleman <bobbyeshleman@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next v3 0/4] selftests/net: add netkit container env and test
Date: Thu,  5 Mar 2026 10:17:59 -0800
Message-ID: <20260305181803.2912736-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A74F5216E8D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[davidwei-uk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264507-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,dama.to,meta.com,gmail.com,fomichev.me,blackwall.org];
	DMARC_NA(0.00)[davidwei.uk];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dw@davidwei.uk,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[davidwei-uk.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Add a new Python selftest env NetDrvContEnv that sets up a pair of
netkit netdevs, with one inside of a netns, and a bpf prog that forwards
skbs from NETIF to the netkit inside the netns.

  NETIF           = "eth0"
  LOCAL_V6        = "2001:db8:1::1"
  REMOTE_V6       = "2001:db8:1::2"
  LOCAL_PREFIX_V6 = "2001:db8:2::0/64"

          +-----------------------------+        +------------------------------+
  dst     | INIT NS                     |        | TEST NS                      |
  2001:   | +---------------+           |        |                              |
  db8:2::2| | NETIF         |           |  bpf   |                              |
      +---|>| 2001:db8:1::1 |           |redirect| +-------------------------+  |
      |   | |               |-----------|--------|>| Netkit                  |  |
      |   | +---------------+           | _peer  | | nk_guest                |  |
      |   | +-------------+ Netkit pair |        | | fe80::2/64              |  |
      |   | | Netkit      |.............|........|>| 2001:db8:2::2/64        |  |
      |   | | nk_host     |             |        | +-------------------------+  |
      |   | | fe80::1/64  |             |        |                              |
      |   | +-------------+             |        | route:                       |
      |   |                             |        |   default                    |
      |   | route:                      |        |     via fe80::1 dev nk_guest |
      |   |   2001:db8:2::2/128         |        +------------------------------+
      |   |     via fe80::2 dev nk_host |
      |   +-----------------------------+
      |
      |   +---------------+
      |   | REMOTE        |
      +---| 2001:db8:1::2 |
          +---------------+

I will use this series for queue leasing selftests. Include a basic ping
test in this series as demonstration.

v3:
 - add __all__ in ynl.py to declare its API
 - update diagram to only use documentation addresses
 - don't try to parse invalid prefix addrs w/o prefix len
 - make pylint happier

v2:
 - remove LOCAL_PREFIX_V4 in docs
 - mention in docs that LOCAL_PREFIX_V6 must not match LOCAL_V6
 - skip test if LOCAL_PREFIX_V6 matches LOCAL_V6
 - move NetDrvContEnv class vars above parent ctor
 - improve ASCII diagram to show remote, route, example addrs
 - use Python ipaddress instead of str manipulations
 - set forwarding/accept_ra

David Wei (4):
  selftests/net: Add bpf skb forwarding program
  selftests/net: Export Netlink class via lib.py
  selftests/net: Add env for container based tests
  selftests/net: Add netkit container ping test

 .../testing/selftests/drivers/net/README.rst  |  38 ++++
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 tools/testing/selftests/drivers/net/hw/config |   3 +
 .../drivers/net/hw/lib/py/__init__.py         |   7 +-
 .../selftests/drivers/net/hw/nk_forward.bpf.c |  49 +++++
 .../selftests/drivers/net/hw/nk_netns.py      |  23 ++
 .../selftests/drivers/net/lib/py/__init__.py  |  11 +-
 .../selftests/drivers/net/lib/py/env.py       | 207 ++++++++++++++++++
 .../testing/selftests/net/lib/py/__init__.py  |   4 +-
 tools/testing/selftests/net/lib/py/ynl.py     |  10 +-
 10 files changed, 341 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/nk_forward.bpf.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/nk_netns.py

-- 
2.47.3


