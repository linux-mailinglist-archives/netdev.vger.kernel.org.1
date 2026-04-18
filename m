Return-Path: <netdev+bounces-279459-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFxqDNkF42kUBgEAu9opvQ
	(envelope-from <netdev+bounces-279459-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 06:17:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 258B341FE7B
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 06:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 488B8300D777
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 04:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73284283FD4;
	Sat, 18 Apr 2026 04:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhLFWnEy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3882236EE
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 04:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776485842; cv=none; b=p1f+IyUWMLMqqKEuUAs9UpvZrT7kXWGicAZZglZW9S/KKKA84LqR85I5ixOyfks1CbG1/+Ro0hvWVxdSJD6+FNBLw/PoJDBztQYHKPNpq645LtK70WeI4kAu4c3dgiAnckqyQRqQlYkxp7APdaJjGuo3DQ9f+0SDe32S8zrBcyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776485842; c=relaxed/simple;
	bh=lWu4lifEBC+paMWkBtn1n5QMc+5bw0cgiGP7ZcJVeJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P5xgLi8AKbnf5mHG+OEYefY+Qjx7Q9Ekh7rnHM6Q2yw5vReGvMx5K9o8h4auSQRa4F9jKJ0jhfcUsrpfnAW8YLrvqGhy+P/nwKbJSbl/qNkcQT5udDcLrXvpxfetBReaz3heyFFMJBRf55hiFLWLwZGlD5gPBBJ1L/9mIu+IF/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhLFWnEy; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82f1f6103afso628031b3a.1
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 21:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776485840; x=1777090640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3YeiL1Jj/muMdy1IqA7Xewdi0uB6Hzewvx0oWM/aKg=;
        b=QhLFWnEysR5NKXZ5QlgmR6qCCj6tDpUooqPy87McO5vei51N36ti6XdrFD7CzQvOmU
         U+gJgqQA8XgjDE6RvjRqd2WCOUO26j8Qc/QC3Wh3vUvoqa4S5n1b4b388/iMF2SEgVhI
         wX3E6WiUYYVUefzM1/9+FZk7ucqGx2dMd2HirSNoVi/2SeeUNOOlgHQwFPfCdsSTAICb
         8N56S26Dmkog26z+alV54yFWxNgySn29lJS4H8oU7GZk8FS4y0urprk5N7vdz3m0GWYD
         M6JEus+SV8VtYeF15eySECDbry0GyTrBCrDONOGa4FnYMZMVK4WgIR55pBPDIS9e/Zib
         ZDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776485840; x=1777090640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3YeiL1Jj/muMdy1IqA7Xewdi0uB6Hzewvx0oWM/aKg=;
        b=OAM7h0cUbwf8dtTk2WOskuT2aOKvko9g4dqMBsqYNfEDJHmBuUchgHhqwMKucgDMOZ
         ox09kSi/C6g92/+A5VTMrlmZwSGIJQIAVxCRaKRZwEGBGphRbiingIumGWC+TyF4abCf
         PGMV2ZCXgzlK/BRa0cBubScmNv6RMOL1YexVcDuurFR8XvaUHoI9QEaayTurk+Wub7y+
         bBGCiE0OwAFfIhkg+wz4qN/nfeP/EfBZeNq3lLe6+hRcwsibIph83EAMngGTb9gokDTo
         Tm0YZ1u8UVvaeUXE+mnE/sMz4lJOJ6s41ubPdQek0qQUBQQnsF/35AAusQ04Nzj64ITH
         b37w==
X-Gm-Message-State: AOJu0YyJqT0i7MILZeFwZE38jVIZzr81C49vN3GTd7ZofL41RMxn/DM2
	VfRIWt4p9nRqLy1JXHpe3Cxe0NGazIBxDoo73mOo15NK4qxuiRO66uatOjM+/jxj8MO353BC
X-Gm-Gg: AeBDiesQSzX93PgsMCJl9IVkZw9v7N817Vc6HYQBDkpUDbiSuVydBub+M7gx6JE2c33
	Sn+NwShWpnz9hL4xkkK25wbYS8sI/GxQ29PE2Mla2BViVz3rtUIXpaK+kDJlvK7Kxa5lmwI+5zu
	VExbdXya2c3dIefoPEOho7dvQZxZjeSMVaVPy4JPFuhd7TJ3CyAWULpwCKKt9nerwG1ccYSQ0l9
	hsiZQ7e4xblOsv8p+5qF3ScDy58VpLPHmF5norVNeTonCQWcPVMiDk8sp2ksFn6+NqPWWU6YnL3
	g4Bf/R0TOMNZAZX2Lib9Uqv85tu3RJBho5MKM6FTcapogSjX3HSMwguORqc4jiD4+Za5rzI/sJ9
	Zf1pbiHXUxhKhktESnXpCw1eMjbRQxvhu2BclfICVQv0Ob2NOs7Uem0TqIw+qH01NxruD6P40Lk
	4hVWxWRFe0c5Jlt1cp2FRdWJZupZsvk2G022mL7I9byvgSlc1tzeMwrCi/nQ7MNg==
X-Received: by 2002:a05:6a00:2307:b0:82a:6b97:34a7 with SMTP id d2e1a72fcca58-82f8c941403mr6183189b3a.39.1776485839874;
        Fri, 17 Apr 2026 21:17:19 -0700 (PDT)
Received: from DESKTOP-MUHC17F.tail07b66e.ts.net ([188.253.121.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981992sm4356787b3a.7.2026.04.17.21.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 21:17:19 -0700 (PDT)
From: Zhenzhong Wu <jt26wzz@gmail.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	tamird@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Zhenzhong Wu <jt26wzz@gmail.com>
Subject: [PATCH net 0/2] tcp: fix listener wakeup after reuseport migration
Date: Sat, 18 Apr 2026 12:16:31 +0800
Message-ID: <20260418041633.691435-1-jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-279459-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jt26wzz@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 258B341FE7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

this small series fixes a missing wakeup after listener migration in
the SO_REUSEPORT close path and adds regression selftests.

The issue shows up when a fully established child has already been
queued on listener A, userspace has not accepted it yet, and
listener A is then closed. The kernel migrates that child to
listener B in the same SO_REUSEPORT group via
inet_csk_reqsk_queue_add(), but the target listener's waiters are
not notified.

As a result, a nonblocking accept() still succeeds because it checks
the accept queue directly, but waiters that sleep for listener
readiness can remain asleep until another connection generates a
wakeup. This affects poll()/epoll_wait()-based waiters, and can also
leave a blocking accept() asleep after migration even though the
child is already in the target listener's accept queue.

The fix is to notify the target listener after a successful
inet_csk_reqsk_queue_add() in inet_csk_listen_stop().

I also checked the half-open migration path in
reqsk_timer_handler(). That path does not need an extra wakeup here
because the listener becomes readable only after the final ACK
completes the handshake, and tcp_child_process() already wakes the
parent listener at that point.

The series adds selftests under tools/testing/selftests/net/ that
reproduce the regression for both IPv4 and IPv6. They cover both
epoll-based waiters and a blocking accept() waiter.

Patch 1 contains only the runtime fix so it can stand on its own and
be considered for stable backporting. Patch 2 adds the selftest
coverage.

Testing:

On an unpatched host kernel:

  unshare -Ur sh -c \
    './tools/testing/selftests/net/reuseport_migrate_epoll'
  unshare -Ur sh -c \
    './tools/testing/selftests/net/reuseport_migrate_accept'

The epoll selftest fails for both IPv4 and IPv6 with:

  accept queue was populated, but epoll_wait() timed out

The blocking accept selftest fails for both IPv4 and IPv6, for example
with:

  blocking accept() completed only in cleanup

On a patched kernel booted under QEMU with a minimal initramfs, both
selftests pass:

  ok 1 ipv4 epoll wake after reuseport migration
  ok 2 ipv6 epoll wake after reuseport migration
  reuseport_migrate_epoll_RC=0

  ok 1 ipv4 blocking accept wake after reuseport migration
  ok 2 ipv6 blocking accept wake after reuseport migration
  reuseport_migrate_accept_RC=0

Zhenzhong Wu (2):
  tcp: call sk_data_ready() after listener migration
  selftests: net: add reuseport migration wakeup regression tests

 net/ipv4/inet_connection_sock.c               |   1 +
 tools/testing/selftests/net/Makefile          |   3 +
 .../selftests/net/reuseport_migrate_accept.c  | 533 ++++++++++++++++++
 .../selftests/net/reuseport_migrate_epoll.c   | 353 ++++++++++++
 4 files changed, 890 insertions(+)
 create mode 100644 tools/testing/selftests/net/reuseport_migrate_accept.c
 create mode 100644 tools/testing/selftests/net/reuseport_migrate_epoll.c


base-commit: 52bcb57a4e8a0865a76c587c2451906342ae1b2d
-- 
2.43.0

