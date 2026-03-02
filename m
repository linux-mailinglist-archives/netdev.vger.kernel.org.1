Return-Path: <netdev+bounces-262493-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KXNKHIhpWnd3wUAu9opvQ
	(envelope-from <netdev+bounces-262493-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 06:34:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 208C51D3201
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 06:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17E64300F7A3
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 05:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8122FFDD6;
	Mon,  2 Mar 2026 05:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="d+X3G3eh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D040C6FC3
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 05:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772429680; cv=none; b=oog3pvK7Pn1d6Q+PjtjEKQcr5rizEEqCrK7g/DWEw1cFRUdEY38NMESVJSWCEqsDkwWoRvEryWVarIMcs7xcsmBAyRGC6bn7iUzOZLhGLVJ2iNIE3GQFZMwP2I7asaUjkPMjrTdQDzK6j6rS6d01n4E+rvRXjiKuLDG/dX6c8GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772429680; c=relaxed/simple;
	bh=vRpgSM7ezKg1MhtecOl4gvjYqm8gL+ph6tiOuUdj6XU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X7XSNz+tU4gXrLAG7rHDAcZud9us4Dl4Tgv9bXh3cwmJFXWD22iafRroxbhH+kZxR6kGdcV2N33DlJ2LyPKZBhlZLegJAkPG2EM36Mx7tv1jk7Gn2OL/6CuKcKLAhMH0f3HAxJ52l5wJvf8gxy96A/xFeJjXy4pueB+oiIEBaoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=d+X3G3eh; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d1872504cbso1670094a34.0
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 21:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1772429678; x=1773034478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ysekcXrZTcsCEEoTsYB0krQ9pxBoMpSs8mmWL9uoAu0=;
        b=d+X3G3ehks2ghrEj8uB699zXzSWUN8yDQnVD5TIVgIzmZaLPsOxxlioZMETWQ4wToX
         yZd9PIk8ShUjM3RxySaDoeDoH2RVaiUG8tJpMxwpEzJ2IeSZzuB38IkxzMivsRRH4I1Y
         XfpQjW/emji/ZIWfVk6x6NgUKCOhdbd5oScFwA9MhzB3quZwPEYZNqv18yqFpjVlTMw+
         YYa00/bnOhN7puCJuL7aP1SQJnJlJoOkM2Tze0yFhltDU73aY50sQv0Te/Lr7qVhq2Qr
         HRwNM32oTMLq0xIB5iHhzdgwrW2jaIJpkFn0E05gYiamnxRig8w7lN3h3f8vvpkT+id/
         Hbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772429678; x=1773034478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysekcXrZTcsCEEoTsYB0krQ9pxBoMpSs8mmWL9uoAu0=;
        b=ePsF3pNmIrPvfaSAPg8POdckQYVe8WJMvR4ulY3M/6nK9aCoH7CM2r1+/nT0l0QCPm
         IXR7toq+sg8EUZ+38GEyjRQUK///cjP5vABCj3ff1fCntqdMVs0GV/tnr4BJEuH+ZztJ
         n3g1JIsfIn5uiZjs5DZy+gh+2UUuiSRVPdA58NrddH98sAMd49yzIUph5LC+YPSRt6xM
         ddlve0wI5r7VLNZzHRG+Vj5ULF34RqRxSC84aiLt0jfGxRduXaL8t7M1Ze3OnP5y5pGw
         0KrRjiZIN9ZK8J51RYE5EDT82EbK//ne+/qcUZWNZ2/pAn7l12adgM885xbauEIIt8ET
         OxGg==
X-Gm-Message-State: AOJu0YzKAVr6TWMcsx8jbZLK7+yiay3L5Kxkc0TcRP+xnQAxuwkgZOb6
	N62ljIHC6mHjmUr855yAucwaurDWvMPcXFZsOGRVw9XNwcy2Wu7IO7bSf4oWrc3isUw2YO74YiS
	l3TRh
X-Gm-Gg: ATEYQzyAUhZWmv6JxGaPX6IA1YtIb1bHTAv1vvs3Jykyknm/nRoqtIYw3hwX5qxoxkU
	2sBaA7TALrU1ckV5Wwe5i5dK+0zevqDuZf7T3XeZxXuc7FUctAumod2aoPoqUQJXQc8LXRMZpV8
	UTQ6U0n3PJpoamdwtPKBcFRB10LsaZnl757+G6P+RsJn7McIR7BCFSNdvpQ5b6GeU4ydYqHwtKl
	5b340ZGSYju8EYMD4UbR/p5F8O/KOGfxUx1J8eLVfhnIq9hBtZcrFX/MBuPIolngJT0pdNzyPRd
	TH8X+cQ8RMYHjsKc5uMBlWbz8tpuD/j4D2POEP/eGbU/XWqMsTMXvfSUmiw/vi9ne1cCgZ3clP/
	bD0Umn31xIL/pKau1bYZ97+u54WwGg6EbEWe5ldpjhC6sXG/iS5CzFoJxwJNo+KSmdDApJF+SAl
	+JUc+lIpigBda8yLLvBvY9twhQ6egWIt6q/QTIDR0vVg==
X-Received: by 2002:a05:6830:44a1:b0:7d1:9574:db9a with SMTP id 46e09a7af769-7d591eb98aamr7163234a34.12.1772429677742;
        Sun, 01 Mar 2026 21:34:37 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:74::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d58644dd3asm10143818a34.4.2026.03.01.21.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 21:34:37 -0800 (PST)
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
Subject: [PATCH net-next v2 0/4] selftests/net: add netkit container env and test
Date: Sun,  1 Mar 2026 21:33:11 -0800
Message-ID: <20260302053315.1919859-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[davidwei-uk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,dama.to,meta.com,gmail.com,fomichev.me,blackwall.org];
	TAGGED_FROM(0.00)[bounces-262493-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[davidwei.uk];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[davidwei-uk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dw@davidwei.uk,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,davidwei-uk.20230601.gappssmtp.com:dkim,davidwei.uk:mid]
X-Rspamd-Queue-Id: 208C51D3201
X-Rspamd-Action: no action

Add a new Python selftest env NetDrvContEnv that sets up a pair of
netkit netdevs, with one inside of a netns, and a bpf prog that forwards
skbs from NETIF to the netkit inside the netns.

  NETIF           = "eth0"
  LOCAL_V6        = "2001:db8::1"
  REMOTE_V6       = "2001:db8::2"
  LOCAL_PREFIX_V6 = "fd00:cafe::"

          +-----------------------------+        +------------------------------+
  dst     | INIT NS                     |        | TEST NS                      |
  fd00:   | +-------------+             |        |                              |
  cafe::  | | NETIF       |             |  bpf   |                              |
  2:2 +---|>| 2001:db8::1 |             |redirect| +-------------------------+  |
      |   | |             |-------------|--------|>| Netkit                  |  |
      |   | +-------------+             | _peer  | | nk_guest                |  |
      |   | +-------------+ Netkit pair |        | | fe80::2/64              |  |
      |   | | Netkit      |.............|........|>| fd00:cafe::2:2/64       |  |
      |   | | nk_host     |             |        | +-------------------------+  |
      |   | | fe80::1/64  |             |        |                              |
      |   | +-------------+             |        | route:                       |
      |   |                             |        |   default                    |
      |   | route:                      |        |     via fe80::1 dev nk_guest |
      |   |   fd00:cafe::2:2/128        |        +------------------------------+
      |   |     via fe80::2 dev nk_host |
      |   +-----------------------------+
      |
      |   +---------------+
      |   | REMOTE        |
      +---| 2001:db8::2   |
          +---------------+

I will use this series for queue leasing selftests. Include a basic ping
test in this series as demonstration.

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
 .../selftests/drivers/net/lib/py/env.py       | 208 ++++++++++++++++++
 .../testing/selftests/net/lib/py/__init__.py  |   4 +-
 tools/testing/selftests/net/lib/py/ynl.py     |   4 +-
 10 files changed, 336 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/net/hw/nk_forward.bpf.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/nk_netns.py

-- 
2.47.3


