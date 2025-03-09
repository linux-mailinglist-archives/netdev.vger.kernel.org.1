Return-Path: <netdev+bounces-173276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CB5A5843D
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 14:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1AD16ACAE
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 13:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF2E1D9587;
	Sun,  9 Mar 2025 13:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="M8119lH0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B798F1C4A10
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 13:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741526981; cv=none; b=gQityQ18IDU9oo/89qCbJ4y0RF9yO57TLUFnhSsP9+84r/xmNLzCuDv+IcP1UPOB/IBo9U6k/59pC9si7sxjwNvEmJfVf36N8r4Bmv1H/WTJWm8WQajSeo269wLcB1aZK/ZJsVvu9WqLmaz7z1PME5xndblJP8tbRyy+ynx9zV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741526981; c=relaxed/simple;
	bh=BFBez99hJQWF8yQf0dUSZg1LTudTSAcMT/T2RWUc2CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i9ffX2FLBX80j3/NtckjxBTTJFg/dsGjkmdWBiJXiip4yLhfK3yfGZcRK84pG+erSX+WmjmWyB1gJ9nLInDqf93VdanfhJeH1P6HIPX2IFMaA+J8ECHdHqJ84+cFjCva7cBD8YQWzpFqgX0CwwqWra4+xpbkJSUMzdQJ2X36M8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=M8119lH0; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 758FB3F849
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 13:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741526975;
	bh=mqFbLsvDYgZMcATbnfiiqW+yfZu2sdh4iXGZzYCmKWw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=M8119lH0pfHCJbNhXIm2r/DHRXG4z7vOaLDab29P3gn6o9KHsx9F7dyE0U47u0Qaw
	 M+qaOskcoGWuYp3cQ0WqSr8NnK/zq1Nm2+FuTwf6DVdabsubrnjox0FmvQ4fSKjFbI
	 u5495eUJ5ufQWHO1PxS1D2VXeyN4XuZb/+m2n+xCcqXt4CNbWakfkP5w7DJ4kgkINz
	 1WDTsX1I+VnXcFaUIEigkcxekCRQBuEfj5LIEwMAaaFy8tlUiNAarWrpy37ntw4sEc
	 nn5dNaJVzjctqkv8IFCh7DDZHZgc6Xsiw2uQpCpN4EkD3gB1KG71OrAuVOM5MxcXMx
	 8kQZQmWKauJNA==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac27ea62032so63498966b.1
        for <netdev@vger.kernel.org>; Sun, 09 Mar 2025 06:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741526975; x=1742131775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mqFbLsvDYgZMcATbnfiiqW+yfZu2sdh4iXGZzYCmKWw=;
        b=JtQnYY+3Krb4nxwSruauW6NYa1mA2mGXVpYptWjTWcixivCX0q4visJ3f8agRfqWWO
         /99f60ap1UNvaHSK/7nAUtaOu/oeMne692FLf33QSmELdoyDHZl2MMZ4vtGcmdCK6P2J
         WPBEfZRB8omsnNrwN9nXGCkrfde79BUsfxQKzS4QEPgFRcHRmPhU4p4qJQbZ4F+EBS+L
         R5dSiUFB4vzGYGCa6bCxgtPvAZlf6PZMAc5JyZnrB+yKm+TH9pR4Q1lZWl+KyB/QDQbW
         kFr73JvtCNukbn4Kz0TYk8Mfnrq5nZITQtB/5ZzbWkI9lypOwv8IqcOI3aV3PwSaFQjn
         JvAw==
X-Forwarded-Encrypted: i=1; AJvYcCVKDCtKJc0NXT2hlCJgOpZhhLxXTDmcuOwZGrqtSXkoOXYXn2uS7mhbBG1oTqkbzrCkXNS3M9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiRN8Zm+tgo4ArEGXlf90fvSmXmN6pNeS/0ss0Plt9yXviZVbb
	LwhG6YUWa9sVe8lBExV0w/Obz82WiYJCVEEWN1ppckGqsaZRbrTwE51Vh7PNrztWCs+bwvUzoKW
	FbT45jrSLDO4MowFkpBVpNdfYSDUnOpIatGRoqyVRLTiHlB2HabKTfJT1l6GE+XgCWZby6g==
X-Gm-Gg: ASbGnctenRhTuKYEFX6gS5nkOHeJmWxAr8AeTLfA4BBSkPPkDCzO1R8na8yxUhcTnwF
	44P9pfPGLriN2PD56pTnRiY9Xi3Fb17z/rMaevhgpqZURpt1+oSRjSh1iivj1bZTJxxHDlSS0g0
	wSs+9T+RvBTayE0PdAPqV/ic8PYNY/PLruKMOKwww56pry6MTPjzsosAgJCgbvujIRVRuHcuLak
	CwvCheMnGh6F7MEiK60slHwFz3RdE4s+j5r21Ju7OLr1GFSt6r9xFlhjqzg9eAB6gYH6/kE7DBB
	QSSvKhzYuScFWVRS8jOQrfAXjJEwlY6WuixiXqJ6c7Fo4GUgLmL0oD3PLrOQcPQhqtYZW+fKuFx
	Xi2iIZn9BVdU5Vy1BIw==
X-Received: by 2002:a17:906:c514:b0:abf:4e8b:73e with SMTP id a640c23a62f3a-ac252e9cd5bmr962216366b.39.1741526974744;
        Sun, 09 Mar 2025 06:29:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWUIep2IRy9s5FbXJl+MjjuqqYaufw0PZ6Ppq51ixYq/v5+9VpIwIXq+cg1UIFg1fYCs++7g==
X-Received: by 2002:a17:906:c514:b0:abf:4e8b:73e with SMTP id a640c23a62f3a-ac252e9cd5bmr962212766b.39.1741526974364;
        Sun, 09 Mar 2025 06:29:34 -0700 (PDT)
Received: from localhost.localdomain (ipbcc0714d.dynamic.kabel-deutschland.de. [188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac25943f55csm435897366b.137.2025.03.09.06.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:29:33 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kuniyu@amazon.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	cgroups@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Luca Boccassi <bluca@debian.org>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net-next 0/4] Add getsockopt(SO_PEERCGROUPID) and fdinfo API to retreive socket's peer cgroup id
Date: Sun,  9 Mar 2025 14:28:11 +0100
Message-ID: <20250309132821.103046-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

1. Add socket cgroup id and socket's peer cgroup id in socket's fdinfo
2. Add SO_PEERCGROUPID which allows to retrieve socket's peer cgroup id
3. Add SO_PEERCGROUPID kselftest

Generally speaking, this API allows race-free resolution of socket's peer cgroup id.
Currently, to do that SCM_CREDENTIALS/SCM_PIDFD -> pid -> /proc/<pid>/cgroup sequence
is used which is racy.

As we don't add any new state to the socket itself there is no potential locking issues
or performance problems. We use already existing sk->sk_cgrp_data.

We already have analogical interfaces to retrieve this
information:
- inet_diag: INET_DIAG_CGROUP_ID
- eBPF: bpf_sk_cgroup_id

Having getsockopt() interface makes sense for many applications, because using eBPF is
not always an option, while inet_diag has obvious complexety and performance drawbacks
if we only want to get this specific info for one specific socket.

Idea comes from UAPI kernel group:
https://uapi-group.org/kernel-features/

Huge thanks to Christian Brauner, Lennart Poettering and Luca Boccassi for proposing
and exchanging ideas about this.

Git tree:
https://github.com/mihalicyn/linux/tree/so_peercgroupid

Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Luca Boccassi <bluca@debian.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: "Michal Koutný" <mkoutny@suse.com>
Cc: Shuah Khan <shuah@kernel.org>

Alexander Mikhalitsyn (4):
  net: unix: print cgroup_id and peer_cgroup_id in fdinfo
  net: core: add getsockopt SO_PEERCGROUPID
  tools/testing/selftests/cgroup/cgroup_util: add cg_get_id helper
  tools/testing/selftests/cgroup: add test for SO_PEERCGROUPID

 arch/alpha/include/uapi/asm/socket.h          |   2 +
 arch/mips/include/uapi/asm/socket.h           |   2 +
 arch/parisc/include/uapi/asm/socket.h         |   2 +
 arch/sparc/include/uapi/asm/socket.h          |   2 +
 include/uapi/asm-generic/socket.h             |   2 +
 net/core/sock.c                               |  17 +
 net/unix/af_unix.c                            |  84 +++++
 tools/include/uapi/asm-generic/socket.h       |   2 +
 tools/testing/selftests/cgroup/Makefile       |   2 +
 tools/testing/selftests/cgroup/cgroup_util.c  |  15 +
 tools/testing/selftests/cgroup/cgroup_util.h  |   2 +
 .../selftests/cgroup/test_so_peercgroupid.c   | 308 ++++++++++++++++++
 12 files changed, 440 insertions(+)
 create mode 100644 tools/testing/selftests/cgroup/test_so_peercgroupid.c

-- 
2.43.0


