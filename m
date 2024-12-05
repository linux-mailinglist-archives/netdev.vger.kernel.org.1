Return-Path: <netdev+bounces-149398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B719E5750
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 14:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A82F16DCF6
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 13:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C882A219A7F;
	Thu,  5 Dec 2024 13:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfKfV5Ay"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D4F219A92
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 13:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733405514; cv=none; b=m0b5hmq8cLvFKQEtiMqa2yFnGrEkzXbiPyWKDz15pMgWJEd6egL/WFvmVLEo7XdpzHMxCEXpc9KZvrxD3xsAlUMNOUsyNemVmfDwDtdR0D0ileGYiDw+Gz+qrPWYrqiIT8LaoLUc+uTGgtVaWawW4bm4U138GpNOkJ2qZli5AK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733405514; c=relaxed/simple;
	bh=gKn7UHxwu0wKzo/07b4XweHLmFnQ5nqS5I7/wcnzWWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K98fHRSMYTQryPq/t+j+4mUjSDNRvzVJx1ekYXAL1WuTWPlIdJ5rwBv7yCf5hBrQ1XoqUEeegfchr2CAM6sZ3MtEcVBqkf8TtM1SFLhwaTrGg8/Orvnfv3Z+90y894IZMqDk8nAOV7hsQx1JbyLwE10XIWVPf1srxkeJIoYOOjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfKfV5Ay; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43494a20379so9362525e9.0
        for <netdev@vger.kernel.org>; Thu, 05 Dec 2024 05:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733405511; x=1734010311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rnKvPcOWZoFyrQPQeOmV+Cv2wq6OsvZaO2ABK8vQgTU=;
        b=kfKfV5Ay40J5S6d1+8EJfkB94CjhbLZFMumljdq4O6TewVfSUQWR1N5cmq/dHPpJTJ
         EYifo2+aGVnMg2kEVaZoq4gqf5Mpj9K4sk6v9BOrAWZXq7WIzQJ2nJ2pJHH6sf5pJ15a
         Pquu9ZLPuMAoZvzs+IoqPcmYRjOXyVPfw0TO1l78rr+jdJKns/kUwyJstf+ezeCK1/4L
         fWZnZTJi0kcEYtEmqjHOt/L5KSKIUySM8CNIHgsaj0owzmNMh+iS7idGxdqhvNG3Enut
         3j8d+dApXd0RcyFXu+qCP9g6q4UkwpsqmNw3+AGBN1zqPAqQB5+Qw59TInXGwNp0ocVa
         wsbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733405511; x=1734010311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rnKvPcOWZoFyrQPQeOmV+Cv2wq6OsvZaO2ABK8vQgTU=;
        b=fZUlDTuqVcszq6AEb3G/sAjBKgd7uDJrXIij+iXpHX35kpvv+P68R3qepGWz3VQXD6
         alcQQxczXSTho3RXtxuzSUbAljkzNgZr8XaIJWon005/SfGdBJgcXVXDh+Dg8Qskk1Eu
         x2JW77YzqWWIK8yYp0FNullRhVXeQ0LUfKaFIZuJC5Pa2HVzXYtE/Au3B6WLScX3y4By
         ZCwzH/hfqJGUq5/h5yshy1daA2gWKZmtnz5hrR2VXwXBZyUsQwqKXtdVUdw28klZr9CB
         Dojrd42lnSGnuZUTq+DgZD2kSwtjfvvuJURIbfxbR+zeA+wqP18rX425GS5M+vpTcRqD
         eK2A==
X-Gm-Message-State: AOJu0YxHqisFBNaGJHwHzETVUKqcT5BtzUQtMUAtW31lA/l/docNJ48x
	BwUytrZ+EiwuTlda2Q1AgM3gLTwdq/RXBUVqXIzRbMB4v0sEkyGsYp6h3cGd0II=
X-Gm-Gg: ASbGncv7j5i4FCSldoUOplNwkHcKBQj1HU1sI+KKtwl8VkbQhwAPToYyYtdtcMfp7kG
	aeDJUyAQLpv8w4Q4DULuoDZy+w2hZMiNulPNVgjsOsABPtHh4g9M/bDw3+5r7riDb02cklt2N1t
	pNxNt5FeX8UENfSc1fi3ct92iLgsn4PTwOgnf/MjJQRvYgtcYA/y0TdMw4NXz+DQ9dZBegPe1sS
	E0+Obr8FbHcg5BQarx31zujlfHqyaDEOhvyhq/PC2SI2troM7msvlwAjmoyXhEWR51oc054unK3
	1UXuszV5xQZeZDtt6oph13PBQ8UM376OXyOTzEWQsBfaupCTMOig7uQjqw==
X-Google-Smtp-Source: AGHT+IHhZr2FdyLpfvXJLKTmo4AuHdGFFeEIDd5riVI+1GmAUIE6rzhz3w7U/zDUwR9kLqrq5dNY7Q==
X-Received: by 2002:a05:600c:3591:b0:434:a39b:5e46 with SMTP id 5b1f17b1804b1-434d09a8916mr86873145e9.7.1733405510634;
        Thu, 05 Dec 2024 05:31:50 -0800 (PST)
Received: from localhost.localdomain (20014C4E37C0C700ABF575982C3B3E76.dsl.pool.telekom.hu. [2001:4c4e:37c0:c700:abf5:7598:2c3b:3e76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5280fc4sm60852465e9.24.2024.12.05.05.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 05:31:50 -0800 (PST)
From: Anna Emese Nyiri <annaemesenyiri@gmail.com>
To: netdev@vger.kernel.org
Cc: fejes@inf.elte.hu,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	idosch@idosch.org,
	Anna Emese Nyiri <annaemesenyiri@gmail.com>
Subject: [PATCH net-next v5 0/4] Add support for SO_PRIORITY cmsg
Date: Thu,  5 Dec 2024 14:31:08 +0100
Message-ID: <20241205133112.17903-1-annaemesenyiri@gmail.com>
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

v5:

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
  Support SO_PRIORITY cmsg
  Test SO_PRIORITY ancillary data with cmsg_sender
  Introduce SO_RCVPRIORITY socket option

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
 .../testing/selftests/net/cmsg_so_priority.sh | 155 ++++++++++++++++++
 23 files changed, 232 insertions(+), 16 deletions(-)
 create mode 100755 tools/testing/selftests/net/cmsg_so_priority.sh

-- 
2.43.0


