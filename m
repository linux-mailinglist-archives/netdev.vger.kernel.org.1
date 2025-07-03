Return-Path: <netdev+bounces-203937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8234CAF8347
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 00:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E87FC540C7F
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 22:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039EE29A310;
	Thu,  3 Jul 2025 22:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="v6CIpGzU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D3B29C351
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 22:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751581413; cv=none; b=cruGi76pIeVI5ahv5v4Fd8KFGIATWppLRIOcNThQyp4RJ4IwSh0dJWy0h3xc0Ev0qG1hrDMWMq9iH9uj9eW5m/t3hTZ8dVLDM6Q2RbsEljIrMET5WsaVsb6xHmFf4OWGyByW4kSXHVQ0tmBwOGufRpoNFLDcyhgSwd2iTntmk6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751581413; c=relaxed/simple;
	bh=D/PppK0hDftWiCKNXNsgHrcA+jFHhAFOCWiRLOQNwOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uff6CgW8nKI1gWY8DB8cTvsLCrReUNu0l6ksh7d8EDGSlg/v5JIwcpc7rXLIhzDzX9Y8+ltjP8T/1b96PZCz4yGlYWbga6O8J8Ohh18CBLjPKTez9sdPV6PkeBZP1kuDC982wiN2ZUCGr0xwNgn0tp/zX5O5YbMhpRw6WLFoDzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=v6CIpGzU; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 35B713F84A
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 22:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751581409;
	bh=47Hy/CVM+m+STHABdIjCLud+sfTnWYA0RBiwXCk0B4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=v6CIpGzUHTbAispGxm49zZwlBtxRSzH7NbSVv3dJY7OzK6v4Xc3aM5T/7QPTk9Fef
	 z8ez2bFq4Yvd3YM+yimmZFOLyvTYRPhVoP5/oGHF5Pj2yFI6CqY0cn3L2jxcaaIrvT
	 BQci4ceQv7GDzA0T9ObmBcPXrv6xT7u8AFoMb7qcTnXE6/t+9XVuY6TDYa5InSUQ4L
	 HQIyFAxxWrI39h8ZoIhJ7XoYGBKSuQl+x4a69f03MiLGRUPcmjsdQxK8wJrLoxpOq8
	 sfGmwwQ0Nmg633Mdlv+mv9jgEp+njps0eY4FXOyQaRP5pRkW//4IeRb0EbuVxBnJSy
	 PLA0BqjJABd2w==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-acb66d17be4so22368166b.2
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 15:23:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751581406; x=1752186206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=47Hy/CVM+m+STHABdIjCLud+sfTnWYA0RBiwXCk0B4w=;
        b=XJUHltvZT3kypRYM6+u1c3WDUSnMGPkq6n7jcA9n0jUEzruLC1lVfv4UJtMVtj/O4J
         bvXN1R4YyjnKcRBV9a1l0VcokwA6KTcG8dzzj7RHuPA4JBsYWx3/vyExSsLjR22cmr/u
         p5Se4cd3qdXcrKjFc14DY+/L1N0rBo1g27wnyLXhY8/SHcPdiKkNnxh6MZMgy+aKZ7Xj
         Z2o+TFqnO0ftDhn15jAZIN1ARHybM8TB7hajJFRk0Ff9PYTxBCgXGMEaqeoMEUr4Gz0n
         m4Xuo2J+N05Y4oF2GEAvMl0znmB66w7UuX2Mw+d53m1q1adT+q2LZWpKDbKbfcodoXGX
         3KBw==
X-Forwarded-Encrypted: i=1; AJvYcCWm8GPUiXSfmhnIAFdKZSr1DbzSPLbBTmi/j4Q4TMz2MSm5OUbhhhkJqtK6LqPmsMdip5kK0zE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPIU6BgQFy6QzVYJVrZE5iYXdCcKVl8Gf409lvNXJFXtvMB4Hi
	9sdlsym4zErg+OGlHzfT/aOiGMpCDnges3ZFfZ5bFaI5kUsgUFVTEcTeKaUjaCeKyDqIGd6QBWo
	BtaK+EipPdoDHrZZOj8Y9WYp4IViY9vVWMfQBmCBJd8gDzUOikfb4VCE88daWTkH+Ts9NRwl7nX
	8eHmD4YRfb
X-Gm-Gg: ASbGnctS/pxPkJypdUZlEz1ZtPXtvc+cNdUmYFEMkmO0+41lv9KqwHf5Aln17iJVS6F
	EeMu7hZJc18QXjTufXw2ueYzZNoT/5x3wPtSZtJKMWeBX5DIXjbLLSakiqG2VciYN1JT9z1xnAP
	Gc6iUCdecmJlsmqVYsVKUHzT/nPfCXUbmhX7SwFcUFTYqPv5SvkfA37uXoAdjY515NyQI4A9PU4
	J+nwjEz2bwTxl0mujDlul42B/sC8dV5DoqlfhdXdMlWFDIX1piAQAHqNnDggipyoeYvH08BoAJZ
	YQZDJTRV7ksY7sVZU7Lxelbb3qKkU+YQacOIaXW8smb/VX/AJQ==
X-Received: by 2002:a17:907:9494:b0:ae0:c976:cc84 with SMTP id a640c23a62f3a-ae3fbca004dmr20075966b.24.1751581405830;
        Thu, 03 Jul 2025 15:23:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFikEpOsYGxSn0v73olb5O1tkvWNghVZKaq0AyowZz/zD/9S5S+ZxPRb0YNqMVPRMsgi4zVAA==
X-Received: by 2002:a17:907:9494:b0:ae0:c976:cc84 with SMTP id a640c23a62f3a-ae3fbca004dmr20072866b.24.1751581405289;
        Thu, 03 Jul 2025 15:23:25 -0700 (PDT)
Received: from amikhalitsyn.lan ([178.24.219.243])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fcb1fb083sm355164a12.62.2025.07.03.15.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 15:23:24 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kuniyu@google.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
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
	David Rheinsberg <david@readahead.eu>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v3 0/7] allow reaped pidfds receive in SCM_PIDFD
Date: Fri,  4 Jul 2025 00:23:04 +0200
Message-ID: <20250703222314.309967-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a logical continuation of a story from [1], where Christian
extented SO_PEERPIDFD to allow getting pidfds for a reaped tasks.

Git tree (based on vfs/vfs-6.17.pidfs):
v3: https://github.com/mihalicyn/linux/commits/scm_pidfd_stale.v3
current: https://github.com/mihalicyn/linux/commits/scm_pidfd_stale

Changelog for version 3:
 - rename __scm_replace_pid() to scm_replace_pid() [ as Kuniyuki suggested ]
 - ("af_unix/scm: fix whitespace errors") commit introduced [ as Kuniyuki suggested ]
 - don't stash pidfs dentry for netlink case [ as Kuniyuki suggested ]
 - splited whitespace changes [ as Kuniyuki suggested ]
 - removed unix_set_pid_to_skb() to simplify changes [ as Kuniyuki suggested ]

Changelog for version 2:
 - renamed __skb_set_pid() -> unix_set_pid_to_skb() [ as Kuniyuki suggested ]
 - get rid of extra helper (__scm_set_cred()) I've introduced before [ as Kuniyuki suggested ]
 - s/__inline__/inline/ for functions I touched [ as Kuniyuki suggested ]
 - get rid of chunk in unix_destruct_scm() with NULLifying UNIXCB(skb).pid [ as Kuniyuki suggested ]
 - added proper error handling in scm_send() for scm_set_cred() return value [ found by me during rework ]
 - don't do get_pid() in __scm_replace_pid() [ as Kuniyuki suggested ]
 - move __scm_replace_pid() from scm.h to scm.c [ as Kuniyuki suggested ]
 - fixed kdoc for unix_maybe_add_creds() [ thanks to Kuniyuki's review ]
 - added RWB tags from Christian and Kuniyuki

Links to previous versions:
v2: https://lore.kernel.org/netdev/20250701083922.97928-1-aleksandr.mikhalitsyn@canonical.com
tree: https://github.com/mihalicyn/linux/commits/scm_pidfd_stale.v2
v1: https://lore.kernel.org/netdev/20250629214449.14462-1-aleksandr.mikhalitsyn@canonical.com
tree: https://github.com/mihalicyn/linux/commits/scm_pidfd_stale.v1

/!\ Notice
Series based on https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs-6.17.pidfs
It does not use pidfs_get_pid()/pidfs_put_pid() API as these were removed in a scope of [2].
I've checked that net-next branch currently (still) has these obsolete functions, but it
will eventually include changes from [2], so it's not a big problem.

Link: https://lore.kernel.org/all/20250425-work-pidfs-net-v2-0-450a19461e75@kernel.org/ [1]
Link: https://lore.kernel.org/all/20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org/ [2]

Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Luca Boccassi <bluca@debian.org>
Cc: David Rheinsberg <david@readahead.eu>

Alexander Mikhalitsyn (7):
  af_unix: rework unix_maybe_add_creds() to allow sleep
  af_unix: introduce unix_skb_to_scm helper
  af_unix: introduce and use scm_replace_pid() helper
  af_unix/scm: fix whitespace errors
  af_unix: stash pidfs dentry when needed
  af_unix: enable handing out pidfds for reaped tasks in SCM_PIDFD
  selftests: net: extend SCM_PIDFD test to cover stale pidfds

 include/net/scm.h                             |   4 +-
 net/core/scm.c                                |  32 ++-
 net/unix/af_unix.c                            |  57 +++--
 .../testing/selftests/net/af_unix/scm_pidfd.c | 217 ++++++++++++++----
 4 files changed, 247 insertions(+), 63 deletions(-)

-- 
2.43.0


