Return-Path: <netdev+bounces-145879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB85A9D13C4
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 15:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82808B23A51
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 14:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77A11A9B26;
	Mon, 18 Nov 2024 14:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ft2fTQVV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB191A3A8A
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731941545; cv=none; b=F0W38kCiSW4e8AaXm7eo2BZp3RgoO8xP1hdEGVqsG1y6hz0ZGmgyPl4CKyimKZvBHrF/RkUe/xaS5kWjHgtyooMb6/ORhEktzbC8l1eHpl28vsMxb7NffF4zkxygABeu5uNLIx0/Vx8SRbjy1gEZzH5eOewnPaLT2axPFaf58k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731941545; c=relaxed/simple;
	bh=V+cOxus+m4mto/XLwZ55NH/beRYUYG6PFXLvlgv9o7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LQ7+CPJ2BiXasiElflxEMwONmlyGb8H0PYClDqrKCSJKTXlo8DBI9gcgkO+QKFjxMmWi7paF36L9sUvgfg47jzAbyMFEjt+BXAjL6mf4aaUoq4mlMXc9/iubFJkNKZdGkjBbjsG0WcDFMXFJVS1t4bhoqGgnbzkPBqb4SXScc3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ft2fTQVV; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-382442b7d9aso973255f8f.1
        for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 06:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731941542; x=1732546342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rs5GnrU4nV8Cb5CVopjjXpHrH0KmJoeas3gG+FzG+Bs=;
        b=ft2fTQVVn6amdRpuqjNzTWeNLyGkDn5WPR9x/ygBWngj6WAU/k44CNSPkTJ/e6+/Tk
         a6d9cRz8qOtOUajPkArSkadBpya6ykjkP1Io8uxgogDqycb3Toxq7NGpUCwf5YgbYJ/j
         +ShdQOIzv2LmzEz3tSbaI4O5U8vLKVKvxG2XwskaIEZnJC7Dl3nhmVkPVQQYv8Z7UaA6
         ErTcoivnoLaD3fHE3WC0tnh6ZTpoyIz1cnw2vMhahoDkNY4TcY6LJgSbyB4TTYkj7RkO
         O8pXgC3g7IJUy8yxlmgoEgZWLhxgDfe1voKTCv5EkssdderCXSCBQSIAP6XMrJUSbsc2
         QNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731941542; x=1732546342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rs5GnrU4nV8Cb5CVopjjXpHrH0KmJoeas3gG+FzG+Bs=;
        b=siZKz6YIbj5tIlRw3IfgmcOvdOu4xo+FZwzhUhX3p7aSsrMAJL8C9xlJQ5184xhjiD
         b5DYielCAoze8DvzMfqnO+u7rhqnKDP2ZbPKZBHzWe6+lup5uF1xpyIBWHC5z0Gl0I5A
         Mxw5gF9VZnsbNC/5aBtft7ebiR37J96RNIoUOZdz+m4lqmbpM2vFnD5e8BBcqsCSW3eW
         4tn2bfKovyxsO0xtQ4Uf/8rfAfuCxo6SJyv6Y2Xdr0F+AZHn76RVkwXQzw2k7wpcp6ah
         yQCzsS/57xVQvUmyafgskcBDJ9+esyS74ifZDY0KdtQgzWEmdvxGiwB/6+aCPDNN9SB4
         3pVA==
X-Gm-Message-State: AOJu0Yz36shRHOBbl/ki3G1+1Uq5babVlt6ViMB8qhyI9MCVgzGfpUbR
	zPJ3ENngtcsKuhfRTKR6/QRvNA4Tsxsi5TZS3OWskgR3ZzlelinC6ixZuUpL2kY=
X-Google-Smtp-Source: AGHT+IEBA4nheQMLIHm+Fdcf8KX32ILarbbj5DpZ/AhPmb5FWpkmfWutZ0Hma6kxcNCPjwlh81TKUw==
X-Received: by 2002:a05:6000:1866:b0:382:51f:6371 with SMTP id ffacd0b85a97d-3822590480dmr9631367f8f.15.1731941541909;
        Mon, 18 Nov 2024 06:52:21 -0800 (PST)
Received: from localhost.localdomain (20014C4E1E82D600957C45913C6586B5.dsl.pool.telekom.hu. [2001:4c4e:1e82:d600:957c:4591:3c65:86b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da27fbd2sm162639285e9.19.2024.11.18.06.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 06:52:21 -0800 (PST)
From: Anna Emese Nyiri <annaemesenyiri@gmail.com>
To: netdev@vger.kernel.org
Cc: fejes@inf.elte.hu,
	annaemesenyiri@gmail.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	idosch@idosch.org
Subject: [PATCH net-next v4 0/3] Add support for SO_PRIORITY cmsg
Date: Mon, 18 Nov 2024 15:51:44 +0100
Message-ID: <20241118145147.56236-1-annaemesenyiri@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new helper function, `sk_set_prio_allowed`,
to centralize the logic for validating priority settings.
Add support for the `SO_PRIORITY` control message,
enabling user-space applications to set socket priority
via control messages (cmsg).

Patch Overview:

Patch 1/3: Introduce `sk_set_prio_allowed` helper function.
Patch 2/3: Add support for setting `SO_PRIORITY` via control messages
Patch 3/3: Add test for SO_PRIORITY setting via control messages

v4:

- Carry Eric's and Willem's "Reviewed-by" tags from v3 to 
  patch 1/3 since that is resubmitted without changes.
- Updated description in patch 2/3.
- Missing ipc6.sockc.priority field added in ping_v6_sendmsg()
  in patch 2/3.
- Update cmsg_so_priority.sh to test SO_PRIORITY sockopt and cmsg
  setting with VLAN priority tagging in patch 3/3. (Ido Schimmel) 
- Rebased on net-next.

v3:

https://lore.kernel.org/netdev/20241107132231.9271-1-annaemesenyiri@gmail.com/
- Updated cover letter text.
- Removed priority field from ipcm_cookie.
- Removed cork->tos value check from ip_setup_cork, so
  cork->priority will now take its value from ipc->sockc.priority.
- Replaced ipc->priority with ipc->sockc.priority
  in ip_cmsg_send().
- Modified the error handling for the SO_PRIORITY
  case in __sock_cmsg_send().
- Added missing initialization for ipc6.sockc.priority.
- Introduced cmsg_so_priority.sh test script.
- Modified cmsg_sender.c to set priority via control message (cmsg).
- Rebased on net-next.

v2:

https://lore.kernel.org/netdev/20241102125136.5030-1-annaemesenyiri@gmail.com/
- Introduced sk_set_prio_allowed helper to check capability
  for setting priority.
- Removed new fields and changed sockcm_cookie::priority
  from char to u32 to align with sk_buff::priority.
- Moved the cork->tos value check for priority setting
  from __ip_make_skb() to ip_setup_cork().
- Rebased on net-next.

v1:

https://lore.kernel.org/all/20241029144142.31382-1-annaemesenyiri@gmail.com/

Anna Emese Nyiri (3):
  Introduce sk_set_prio_allowed helper function
  support SO_PRIORITY cmsg
  test SO_PRIORITY ancillary data with cmsg_sender

 include/net/inet_sock.h                       |   2 +-
 include/net/ip.h                              |   2 +-
 include/net/sock.h                            |   4 +-
 net/can/raw.c                                 |   2 +-
 net/core/sock.c                               |  18 ++-
 net/ipv4/ip_output.c                          |   4 +-
 net/ipv4/ip_sockglue.c                        |   2 +-
 net/ipv4/raw.c                                |   2 +-
 net/ipv6/ip6_output.c                         |   3 +-
 net/ipv6/ping.c                               |   1 +
 net/ipv6/raw.c                                |   3 +-
 net/ipv6/udp.c                                |   1 +
 net/packet/af_packet.c                        |   2 +-
 tools/testing/selftests/net/cmsg_sender.c     |  11 +-
 .../testing/selftests/net/cmsg_so_priority.sh | 147 ++++++++++++++++++
 15 files changed, 189 insertions(+), 15 deletions(-)
 create mode 100755 tools/testing/selftests/net/cmsg_so_priority.sh

-- 
2.43.0


