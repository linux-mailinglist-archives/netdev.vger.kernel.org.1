Return-Path: <netdev+bounces-202807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 163E1AEF165
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 10:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6037A1889D1C
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 08:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF4C26B768;
	Tue,  1 Jul 2025 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Ckt+g1s9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96BD26A0AB
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 08:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751359183; cv=none; b=XmRjPEGcJxzwzbN4Fqmy41y+2HkorW3PSuhT+E9ENZRdZ4wzMX1KgMuL4JABXy0L7rRrpC2HoEZOvSfx0lG1qXn5GHDsPChw9oRGkX7mbo/0xndyiHEkIgcL6F8WQIMasFpRik5K/keUHcgdryfZHmQewkYhJD154CjTwlSlY3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751359183; c=relaxed/simple;
	bh=dNFssYStWjlkvyhvt83/IFm0+gTNQR2fGINvxCNov/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KidHv+e+hDbbg935BV698jXpIgn+f1YUFTWgeFSgrsofvJsdRzSfyKShmIE4uFVzn2r1lo/JCVCdetsw6NJc7fwLl2/92fVpnLcg/g8qxJ+E/L0h/Mux8VAEaY57OZTYruzVfXOdPmUJLlZH8GzjcnWpfdGvvgkpcV0WSOZpr/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Ckt+g1s9; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B8E043F697
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 08:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751359178;
	bh=4yp1+vuew+zECrTXb7RcSP/djBI2o2M9gov6DQJnyao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=Ckt+g1s97M2NpPHPActBKVnDMPJJ6wsekaY+LmY14i6rx37PH/84lZh4WjYp47dof
	 V4S5WdnD0UqDI/QvJ2wFdlIroAgLljK59Bt6NX8jyauTvvr4lbggGEAYj5mruSj5Hf
	 dGi0KNH7j7vzyIDAtanUEVAdApgGlyNTDrCrlxLxB3Y5u5tYNC8O148yF0z9byI9Yt
	 quuyXjD+dS0g7k1/kI6txssaLfAEqmbanXIT95jUOOFlfDmxevV7f62jYs+U6O8Mdf
	 UX08cJ4aX300fWGimVELJgOrH6sn4thsEWonpXiYRuwC+rT+lxglWWnofMHHf3zu2T
	 BYFePOs0N1ZPw==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ae0b2bbd8bfso212090766b.2
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 01:39:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751359176; x=1751963976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4yp1+vuew+zECrTXb7RcSP/djBI2o2M9gov6DQJnyao=;
        b=CnK0dhuujKsKSPjTEhbtXtyfmtd2JfLUz6jfRvg6nd2nqS5G8NUHHEe80zAbW1tIJF
         3iEL0+Bcys7GHmqjKjshHfOErI2KCE8eT8sC6sdybrj/7oxRXGGC6mAZDUP/F464/WPE
         kI6vnxsmdCzYQfRIkYMf0gOYHM2OYXDfvhlL9Sp2/t0YJ5erhBEpemRt8O1vckDRv6QI
         zvuQZxeG7YZyaH2+6VcuPNhUpFA3ht+0Yk2w/EFFrpTUC1+VZ/AWNz6m7cFI1StCQ1yy
         shF6zrAQIqj4xZyWFrOjqD2y/BMGt49oOqgDVNXzZILTUuYHQVASLMwBkyqeEDXiHYSk
         Cy9w==
X-Forwarded-Encrypted: i=1; AJvYcCVJZfvoVlNpyGFKBJuOSa9eCgwfRzRbxzv4Gc5SUa/WO/JyVOyiGYizmkkXuA9VQ//V5A/I96Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPO+u8Qxz/tZwhZDaTwzW+kOYdW37DSyT38gmVrKXDqoGnc0Dk
	wfyOWrqtdBamqhWx6s+IFopgPSSve6W8Dlf8NZ3mKiWWC3bf8RynAP0LvKrd4Vu4Wpe8qJN+BCz
	k5NUoddRsTVAky1NCnY/e5xsKx0UFt4hGXBSnz/A8KL1/wBwb3T3EwloupcaD/esv32gS2OMPPA
	==
X-Gm-Gg: ASbGncv/XTR9XMqolL/8HURxroWo6fdW/TgN/QXsYu7CCOg21ysRmrzx3h6z3vJmcBf
	QmP5BYi5AkQPy3PKpyZXiMpZwQhOeLMy+k5R3o5SpMNJdYdiK5b7WgP34OEFhWceIErlUCQV5sR
	sDLa7e/vD5EInmH9q9lftakeCuo5a5iMM/IhsYMAr1SYoVNcQs8Jx8icxi7WozQgUZeFJOo7246
	2tDHK5Pv6FzwXIGevnveRegHyZFj1oDk+rrWLDwDXEV9JslCsipRdMRHOIqg/Bk1WTKEPWWiCVB
	s0mCwSF4feFCKYmkGM5h8zkH/TgYnFrWY0epR78/jKvLTBSsJA==
X-Received: by 2002:a17:907:1c1d:b0:ae0:c803:c96 with SMTP id a640c23a62f3a-ae34fddefb3mr1615648866b.24.1751359176484;
        Tue, 01 Jul 2025 01:39:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNYW89qpdmfY3sZqsrYphW2DREJSdqhOYO6cQ7meUyqCU15mTrlKFcHLmzEEQga566TkO9uw==
X-Received: by 2002:a17:907:1c1d:b0:ae0:c803:c96 with SMTP id a640c23a62f3a-ae34fddefb3mr1615645566b.24.1751359176025;
        Tue, 01 Jul 2025 01:39:36 -0700 (PDT)
Received: from amikhalitsyn.lan ([178.24.219.243])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363b416sm812427166b.28.2025.07.01.01.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 01:39:35 -0700 (PDT)
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
Subject: [PATCH net-next v2 0/6] allow reaped pidfds receive in SCM_PIDFD
Date: Tue,  1 Jul 2025 10:39:09 +0200
Message-ID: <20250701083922.97928-1-aleksandr.mikhalitsyn@canonical.com>
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
v2: https://github.com/mihalicyn/linux/commits/scm_pidfd_stale.v2
current: https://github.com/mihalicyn/linux/commits/scm_pidfd_stale

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

Alexander Mikhalitsyn (6):
  af_unix: rework unix_maybe_add_creds() to allow sleep
  af_unix: introduce unix_skb_to_scm helper
  af_unix: introduce and use __scm_replace_pid() helper
  af_unix: stash pidfs dentry when needed
  af_unix: enable handing out pidfds for reaped tasks in SCM_PIDFD
  selftests: net: extend SCM_PIDFD test to cover stale pidfds

 include/net/scm.h                             |  33 ++-
 net/core/scm.c                                |  30 ++-
 net/unix/af_unix.c                            |  75 ++++--
 .../testing/selftests/net/af_unix/scm_pidfd.c | 217 ++++++++++++++----
 4 files changed, 285 insertions(+), 70 deletions(-)

-- 
2.43.0


