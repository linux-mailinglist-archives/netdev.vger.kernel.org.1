Return-Path: <netdev+bounces-150807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CED49EB9E0
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 20:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 565A0188238C
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 19:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944E121421D;
	Tue, 10 Dec 2024 19:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j00fF4sz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911ED1BDAA2
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 19:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733858022; cv=none; b=Qg4jWXPkj8A9Mh5BB5cZzewpjSZF5D5Q9xMPFKztHsZyEz7uaFcKl/StcxmQBYPP+OgdhTPBZpMM4VDFCP2CkvVFJBB6q6oQcTzp7aVt6XITq0ITw5dvAIGo4bB4ZZPlfTRsLxZWdqPeB6GQ1pjBa+/FL7ZFLxZlHaK3RbgJ9vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733858022; c=relaxed/simple;
	bh=OoVstYQu6T/zlFaQfWwEFzATEqz/K/PXmqBuACGvh9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KRdI5mhz5/3ypg8PTH4hvmSav6DIl+9RUUPyoa65e+nu8T4MB+PEyrkSIAXXO0eBNNeSx6OTLOOPyjl00rTbJfF2JpkU7pfCdfXa4C51soLq74KWtsVj+ySrIn5eM0chQRwo8gB8yz3E8ZzKz5Xbe7dD3T+HPE3oWNnMOhxo7O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j00fF4sz; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434e9716feaso21575025e9.3
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 11:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733858019; x=1734462819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X3dgyedRD1hxfTsP+DaxUndh7xI0JWroSb1zyCKwxS4=;
        b=j00fF4szwt6RDNMoE6+zfeoJMIUqEuf/9vlYPvBjAqoZvBzX0SQF5UAks46IzLCN3E
         CevIxle+stAHDJG958qSrqXVciY06hEjKChemRxPgV/UrrANRjSsIKkUhtgHxTOqGKiQ
         0DerO476rE+5/t+4IWC7/NEvSj+Jj9Xp4r36EoxNoz9GaZGMfxw70XIb7mI9nQfTkUUG
         Dc+Z/pyn0HIcROTgkum5jXScGMSlD93CuR0NTCvHEZWtO+bGhRzF+3S8TcrXFqjdxou2
         WKLOM1djzpWb8p9yNdSh50KTkQWf+820PDltfqWjkEUjWvJ1PRod8+QDG6+wutm8ZeE4
         Citw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733858019; x=1734462819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X3dgyedRD1hxfTsP+DaxUndh7xI0JWroSb1zyCKwxS4=;
        b=aA61ThsPIWT1bB9voYUOxPRugk9swxc021lvLt9PLEYxBnG8djAb5C3U/zvyzu0pN/
         XTzonEfqTgpT0Er4B8vZIxs+Zvgw2GYJX618OJAVee0IwEQmpSUqNL/OxRdPgitFzHCS
         UM1E3lVjL4fiIV+NZZc7x691ToGybmdNPmiTd9A9nZmGbzutStSCAPhxbCzZ5jPsTa5w
         tpzZ0DXwV1mwvOx/mS6B6LMpWr7RQmh66hF22Tfih9eC9goLEQx7lTgx93M2mGorYs1x
         aflMX92XuNYNdudc5RGy7Q9oOHJdqMKDWcmYFLCly+DZiKpyTQV+icWcHdSG3w78Xrxv
         Bt7Q==
X-Gm-Message-State: AOJu0YxF24ny/g5s6z7a3oOoE7HZ7uJIN5TwRIqZggSXUc9MCD9HLboQ
	z0skY/DjaZSDri9OCfYNWlW9p2zgkpDeV7vtkFzq33R/E7OMuR778hC9KCTU2xI=
X-Gm-Gg: ASbGncsE8fJ/+kgNKayL7wDM0igKxLY5gxVT757MGI0Ha6cVP6hdCLflxJk5nHqoaMU
	TFQ8c+tgqrLygvvYvbY20odqQa2fLJfG24QfGIW2LNjCrcvPHewLtK1YeVOLzOOx1f2DxiK2acw
	i68eLBilbq0/1uBtBhB8N8UdkUR8rnGzWXjr9tCfOmbPf/Zq5EJnH8WwtNBm/KNFkDORq1jiUUa
	IueUwg3418O+GYoD+Cs+KcF3gajtg1xgBPgvLwyaNoOavEQMN6wDB9twTd9ICHGh5/+msi7k6n0
	C/OGG+qDR4FUoEFNCmlTgH5R9B8chrD2MkmPWDvFKMLS08OzS0E64wYgqEeLzg==
X-Google-Smtp-Source: AGHT+IHOkSiF1CR8asnl3lKUjD9+4i6COjCjOo1URqj9o8XWgwpNY5ZD638zrdqu0sv73RqKqilo0A==
X-Received: by 2002:a5d:5984:0:b0:385:edd1:2245 with SMTP id ffacd0b85a97d-3864cea45bbmr205368f8f.30.1733858018513;
        Tue, 10 Dec 2024 11:13:38 -0800 (PST)
Received: from localhost.localdomain (20014C4E37C0C7006406573B5E53AD5C.dsl.pool.telekom.hu. [2001:4c4e:37c0:c700:6406:573b:5e53:ad5c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862d3f57a0sm13310345f8f.108.2024.12.10.11.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 11:13:37 -0800 (PST)
From: Anna Emese Nyiri <annaemesenyiri@gmail.com>
To: netdev@vger.kernel.org
Cc: fejes@inf.elte.hu,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	idosch@idosch.org,
	Anna Emese Nyiri <annaemesenyiri@gmail.com>
Subject: [PATCH net-next v6 0/4] Add support for SO_PRIORITY cmsg
Date: Tue, 10 Dec 2024 20:13:05 +0100
Message-ID: <20241210191309.8681-1-annaemesenyiri@gmail.com>
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

Patch 1/4: Introduce 'sk_set_prio_allowed' helper function.
Patch 2/4: Add support for setting SO_PRIORITY via control messages
Patch 3/4: Add test for SO_PRIORITY setting via control messages
Patch 4/4: Add new socket option, SO_RCVPRIORITY

v6:

- Carry Eric's and Willem's "Reviewed-by" tags from v3 to
  patch 1/4 since that is resubmitted without changes.
- Carry Willem's "Reviewed-by" tag from v4 in patch 2/4,
  as it is resubmitted without changes.
- Carry Willem's "Reviewed-by" tag from v5 in patch 4/4,
  as it is resubmitted without changes.
- Use KSFT_SKIP in jq installation test and
  add 'nodad' flag for IPv6 address in cmsg_so_priority.sh (patch 3/4).
- Rebased on net-next.

v5:

https://lore.kernel.org/netdev/20241205133112.17903-1-annaemesenyiri@gmail.com/

- Carry Eric's and Willem's "Reviewed-by" tags from v3 to
  patch 1/4 since that is resubmitted without changes.
- Carry Willem's "Reviewed-by" tag from v4 in patch 2/4,
  as it is resubmitted without changes.
- Eliminate variable duplication, fix indentation, simplify cleanup,
  verify dependencies, separate setsockopt and control message 
  priority testing, and modify namespace setup 
  in patch 3/4 cmsg_so_priority.sh.
- Add cmsg_so_priority.sh to tools/testing/selftests/net/Makefile.
- Remove the unused variable, rename priority_cmsg to priority,
  and document the -P option in cmsg_sender.c in patch 3/4.
- New in v5: add new socket option, SO_RCVPRIORITY in patch 4/4.
- Rebased on net-next.

v4:

https://lore.kernel.org/netdev/20241118145147.56236-1-annaemesenyiri@gmail.com/
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

Anna Emese Nyiri (4):
  Introduce sk_set_prio_allowed helper function
  support SO_PRIORITY cmsg
  test SO_PRIORITY ancillary data with cmsg_sender
  introduce SO_RCVPRIORITY socket option

 arch/alpha/include/uapi/asm/socket.h          |   2 +
 arch/mips/include/uapi/asm/socket.h           |   2 +
 arch/parisc/include/uapi/asm/socket.h         |   2 +
 arch/sparc/include/uapi/asm/socket.h          |   2 +
 include/net/inet_sock.h                       |   2 +-
 include/net/ip.h                              |   2 +-
 include/net/sock.h                            |   8 +-
 include/uapi/asm-generic/socket.h             |   2 +
 net/can/raw.c                                 |   2 +-
 net/core/sock.c                               |  26 ++-
 net/ipv4/ip_output.c                          |   4 +-
 net/ipv4/ip_sockglue.c                        |   2 +-
 net/ipv4/raw.c                                |   2 +-
 net/ipv6/ip6_output.c                         |   3 +-
 net/ipv6/ping.c                               |   1 +
 net/ipv6/raw.c                                |   3 +-
 net/ipv6/udp.c                                |   1 +
 net/packet/af_packet.c                        |   2 +-
 net/socket.c                                  |  11 ++
 tools/include/uapi/asm-generic/socket.h       |   2 +
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/cmsg_sender.c     |  11 +-
 .../testing/selftests/net/cmsg_so_priority.sh | 153 ++++++++++++++++++
 23 files changed, 230 insertions(+), 16 deletions(-)
 create mode 100755 tools/testing/selftests/net/cmsg_so_priority.sh

-- 
2.43.0


