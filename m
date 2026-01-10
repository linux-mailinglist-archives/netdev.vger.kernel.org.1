Return-Path: <netdev+bounces-248702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 618A5D0D77E
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 15:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B31E73002841
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 14:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB4D30F94B;
	Sat, 10 Jan 2026 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFU1h9qe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F75345722
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 14:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768055656; cv=none; b=X/EESC5b9WWBwQnVBhdT1my0hxAj2A4SCnrSHoyKEsr3ZNB8WsszBB8R54HnVjXCKBLO2ZznZcIWGCcpkhLT7/xCmdqARhJunEFDtqLAStV2wkv8b7MJBoJaIr3SXLp9zRZL9Hbpm5PdsOIK2Xki6qCSBE0U+Z/QW2s21Yl/sFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768055656; c=relaxed/simple;
	bh=CsyF4FB38pVyEBnCDklwP7O8BfvnyqizAoK/kl0VTvw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lCrA7QFmAQPZxN5tOQqLikKhXpmcFHAGYRoUx0V2/RDjazv127kkqY5FKIwLXb7EgV18iJ/PRZ0TBAsPwRyaPdh2HBya/HBpicbaldLQFqjh20BDCq9+jfTq3/hs8pfCLopsFlg1ip4XAuo477XqQ6hKir70N2gd0hqwx/bliR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFU1h9qe; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b86ef1e864cso58383366b.1
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 06:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768055652; x=1768660452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RZUjgiOqEigL5MXUthwgLhJPvwHjvJ0v2nHO9M0M09g=;
        b=kFU1h9qes0yDfOqDV8jUt00z6+9rO2U5gwYwVuHm2JLl5CuNEuYLv/Eve7TSPrvGvy
         V+l7yuMhUpB+RqdADL063gGDvxEXMaP1nA5MsUkshK//zPFEkIsFwEZJfcN1h9ksG4Fd
         OZeC48BqHKQ/r5kpgZWMHpeTrIwVkwjmwbwA2GX5kC/80WdLOBUF+BBnbDMFuO45v1Wq
         8DTqMxxdjNiYG/t+JtIlFqKM94hTCi3815Cazs5UU8KBpAfI8QQUORsnMdLY8sETYVAj
         9//Ky5GEu7ZPWGcF9F7yqGT7qH2lErT/vRCvLVL4K8Qj7afngMd3p20qENH43bpMwv4k
         LX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768055652; x=1768660452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZUjgiOqEigL5MXUthwgLhJPvwHjvJ0v2nHO9M0M09g=;
        b=QkndWErAkikvHc9rQvICJpetoEqn/YvZXENLcZYoPOWrIOorCH4LnmQg+KyXFZrPqU
         /jzuT1O1DoAUwGMIBgAWFzjp9qWe/YOC39Tfus6qxf484SYA6Ijx/PhLHtffaqzZru+6
         TJa8aCQJkato35mEEN8eecXhWeFiW19NGJxDmN6/W0n2PYww7QAjmpfgjYnO9Wi3wvUk
         vncKZDvwcF6DRt+bsfZMV6unj5HtAcmQ6Fi08PT7t+Abjgck3CvauG4huS/e2GJofIyh
         j4E46D82wS5gk/Ev60BVdH5jlq6Xx8m+VHsjW4ixK0jXG6WPcgI5jd6B3mndDegkKV39
         SyoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNa9itraSVWnh4hjYw3ZY543dFSemwEr9eD9tGVh3TK4bjTX424WZrB0Vfq3VZftDzraVj9OM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6ItRjpehgu116GQlJEjtBZO+4usAN1iRw005ISykM3X1hiTTk
	zwiCFO0TTz+FMZLdhWZMpKnv86BTg0vg6PIlffr5gqLQeB8VOE1uNAco
X-Gm-Gg: AY/fxX67gL2q3dNIz+XNuoTH6FwnBC9KXSp9u5VBx/0MJHaKfOqxEbDbhl00NMcnKGH
	BBPjqbileXxGJPjVlBETzX4eJQl/N9vBz62Wr45k/V9Hc9rx+Uk+uHkQCE3XI6ydben4rlbHPDB
	smB25Hq2wNklBUGHz2XcNQblhcR9EkkqMoTfxbYM1TjC9JK0TbpfDXHVthqpqsuI8RUZlumkB3X
	891Tn4keDBZ+R9XWzZcuYm8wh8YkCax9x69/qWA0IMKZGLshiJF9B8wl4u2ZIu4FN1AofvaEWoW
	rDpOxwmqNo+k97Oioz5boqFdS88ohlU4syN5vK3JJxUyDJk+w6J8L7LQu2im1BGNZelmcvUJ6IJ
	jby+hHpFDYqTA+xT3Ltpq7SrgEhSaHBBgihZZMzFcMpPUYBIre2vnoUTTSPqu2FU2E1LDiDqo6g
	CS/ucb/zCMr1hiLfkWo1YsPvBzVKHfgMLEish5
X-Google-Smtp-Source: AGHT+IHgewxH0hd7d8rLHVR5PvtoMIDhT0rjrEm67OfRIalqqVb8d8eP3GeR+itug81YJmpY3YeEZQ==
X-Received: by 2002:a17:907:25c4:b0:b73:78f3:15c1 with SMTP id a640c23a62f3a-b8445414ff6mr1173667566b.52.1768055651912;
        Sat, 10 Jan 2026 06:34:11 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a56c547sm1418621766b.69.2026.01.10.06.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 06:34:11 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"Paul Moore" <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	linux-security-module@vger.kernel.org,
	"Tingmao Wang" <m@maowtm.org>,
	"Justin Suess" <utilityemal77@gmail.com>,
	"Samasth Norway Ananda" <samasth.norway.ananda@oracle.com>,
	"Matthieu Buffet" <matthieu@buffet.re>,
	"Mikhail Ivanov" <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	"Demi Marie Obenour" <demiobenour@gmail.com>,
	"Alyssa Ross" <hi@alyssa.is>,
	"Jann Horn" <jannh@google.com>,
	"Tahera Fahimi" <fahimitahera@gmail.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 0/5] landlock: Pathname-based UNIX connect() control
Date: Sat, 10 Jan 2026 15:32:55 +0100
Message-ID: <20260110143300.71048-2-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello!

This patch set introduces a filesystem-based Landlock restriction
mechanism for connecting to UNIX domain sockets (or addressing them
with sendmsg(2)).  It introduces a file system access right for each
type of UNIX domain socket:

 * LANDLOCK_ACCESS_FS_RESOLVE_UNIX_STREAM
 * LANDLOCK_ACCESS_FS_RESOLVE_UNIX_DGRAM
 * LANDLOCK_ACCESS_FS_RESOLVE_UNIX_SEQPACKET

For the connection-oriented SOCK_STREAM and SOCK_SEQPACKET type
sockets, the access right makes the connect(2) operation fail with
EACCES, if denied.

SOCK_DGRAM-type UNIX sockets can be used both with connect(2), or by
passing an explicit recipient address with every sendmsg(2)
invocation.  In the latter case, the Landlock check is done when an
explicit recipient address is passed to sendmsg(2) and can make
sendmsg(2) return EACCES.  When UNIX datagram sockets are connected
with connect(2), a fixed recipient address is associated with the
socket and the check happens during connect(2) and may return EACCES.

## Motivation

Currently, landlocked processes can connect() to named UNIX sockets
through the BSD socket API described in unix(7), by invoking socket(2)
followed by connect(2) with a suitable struct sockname_un holding the
socket's filename.  This can come as a surprise for users (e.g. in
[1]) and it can be used to escape a sandbox when a Unix service offers
command execution (some scenarios were listed by Tingmao Wang in [2]).

The original feature request is at [4].

## Alternatives and Related Work

### Alternative: Use existing LSM hooks

The existing hooks security_unix_stream_connect(),
security_unix_may_send() and security_socket_connect() do not give
access to the resolved file system path.

Resolving the file system path again within Landlock would in my
understanding produce a TOCTOU race, so making the decision based on
the struct sockaddr_un contents is not an option.

It is tempting to use the struct path that the listening socket is
bound to, which can be acquired through the existing hooks.
Unfortunately, the listening socket may have been bound from within a
different namespace, and it is therefore a path that can not actually
be referenced by the sandboxed program at the time of constructing the
Landlock policy.  (More details are on the Github issue at [6] and on
the LKML at [9]).

### Related work: Scope Control for Pathname Unix Sockets

The motivation for this patch is the same as in Tingmao Wang's patch
set for "scoped" control for pathname Unix sockets [2], originally
proposed in the Github feature request [5].

In my reply to this patch set [3], I have discussed the differences
between these two approaches.  On the related discussions on Github
[4] and [5], there was consensus that the scope-based control is
complimentary to the file system based control, but does not replace
it.  Mickael's opening remark on [5] says:

> This scoping would be complementary to #36 which would mainly be
> about allowing a sandboxed process to connect to a more privileged
> service (identified with a path).

## Open questions in V2

Seeking feedback on:

- Feedback on the LSM hook name would be appreciated. We realize that
  not all invocations of the LSM hook are related to connect(2) as the
  name suggests, but some also happen during sendmsg(2).
- Feedback on the structuring of the Landlock access rights, splitting
  them up by socket type.  (Also naming; they are now consistently
  called "RESOLVE", but could be named "CONNECT" in the stream and
  seqpacket cases?)

## Credits

The feature was originally suggested by Jann Horn in [7].

Tingmao Wang and Demi Marie Obenour have taken the initiative to
revive this discussion again in [1], [4] and [5] and Tingmao Wang has
sent the patch set for the scoped access control for pathname Unix
sockets [2].

Justin Suess has sent the patch for the LSM hook in [8].

Ryan Sullivan has started on an initial implementation and has brought
up relevant discussion points on the Github issue at [4] that lead to
the current approach.

[1] https://lore.kernel.org/landlock/515ff0f4-2ab3-46de-8d1e-5c66a93c6ede@gmail.com/
[2] Tingmao Wang's "Implemnet scope control for pathname Unix sockets"
    https://lore.kernel.org/all/cover.1767115163.git.m@maowtm.org/
[3] https://lore.kernel.org/all/20251230.bcae69888454@gnoack.org/
[4] Github issue for FS-based control for named Unix sockets:
    https://github.com/landlock-lsm/linux/issues/36
[5] Github issue for scope-based restriction of named Unix sockets:
    https://github.com/landlock-lsm/linux/issues/51
[6] https://github.com/landlock-lsm/linux/issues/36#issuecomment-2950632277
[7] https://lore.kernel.org/linux-security-module/CAG48ez3NvVnonOqKH4oRwRqbSOLO0p9djBqgvxVwn6gtGQBPcw@mail.gmail.com/
[8] Patch for the LSM hook:
    https://lore.kernel.org/all/20251231213314.2979118-1-utilityemal77@gmail.com/
[9] https://lore.kernel.org/all/20260108.64bd7391e1ae@gnoack.org/

---

## Older versions of this patch set

V1: https://lore.kernel.org/all/20260101134102.25938-1-gnoack3000@gmail.com/

Changes in V2:
 * Send Justin Suess's LSM hook patch together with the Landlock
   implementation
 * LSM hook: Pass type and flags parameters to the hook, to make the
   access right more generally usable across LSMs, per suggestion from
   Paul Moore (Implemented by Justin)
 * Split the access right into the three types of UNIX domain sockets:
   SOCK_STREAM, SOCK_DGRAM and SOCK_SEQPACKET.
 * selftests: More exhaustive tests.
 * Removed a minor commit from V1 which adds a missing close(fd) to a
   test (it is already in the mic-next branch)

Günther Noack (4):
  landlock: Control pathname UNIX domain socket resolution by path
  samples/landlock: Add support for named UNIX domain socket
    restrictions
  landlock/selftests: Test named UNIX domain socket restrictions
  landlock: Document FS access rights for pathname UNIX sockets

Justin Suess (1):
  lsm: Add hook unix_path_connect

 Documentation/userspace-api/landlock.rst     |  25 ++-
 include/linux/lsm_hook_defs.h                |   4 +
 include/linux/security.h                     |  11 +
 include/uapi/linux/landlock.h                |  10 +
 net/unix/af_unix.c                           |   9 +
 samples/landlock/sandboxer.c                 |  18 +-
 security/landlock/access.h                   |   2 +-
 security/landlock/audit.c                    |   6 +
 security/landlock/fs.c                       |  34 ++-
 security/landlock/limits.h                   |   2 +-
 security/landlock/syscalls.c                 |   2 +-
 security/security.c                          |  20 ++
 tools/testing/selftests/landlock/base_test.c |   2 +-
 tools/testing/selftests/landlock/fs_test.c   | 225 +++++++++++++++++--
 14 files changed, 344 insertions(+), 26 deletions(-)

-- 
2.52.0


