Return-Path: <netdev+bounces-251299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B5DD3B87B
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 21:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B574F3009691
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 20:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C302DA768;
	Mon, 19 Jan 2026 20:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gc4gcfLJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B706B2F12D6
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 20:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768854922; cv=none; b=s25wL1b3FBsTPjtzd12PCGBjNpQ2rzWkPLAoPRP5fPpPOTi+HTGM8mEauN+UiDlQNt7rw9EdeAlVRYU9LVDEJXNV/e3pFB3PFGf+6s8va7U7MMJIV5CwnvjrQbGbG/WhMtYYKdZeSbUcN8f9a3byRUNx69n352850K+GZSrQp0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768854922; c=relaxed/simple;
	bh=2GAhNwahmBkVEDo11by/eGfLMIxLmw+YzD8Ph6Xujyk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lytWKtXEPwwrJAJ77RyUkfKpkPWcoxiuefSWnFnNniO6poxFfFndR+b0N3oaZGUlTdorIXCg6adKzV7vjyuXPLb+aMvM6zEQtwluItL50u2p7jHVwAM5dhPvYT4fphTflRjW5tVjX0T0SzmFZe9hLFpBRHxQJTHrVlBNonUrcbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gc4gcfLJ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6505d141d02so8068022a12.3
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 12:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768854918; x=1769459718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mzIJGZN4ZQbZMlVh2ia8X5lmsWPHg4qhIHUWgiA2akw=;
        b=gc4gcfLJ5/mKNAK/Mdp5xlHJLxZgf9hg8AhhOTllvKZEukX9koatHkcAGQKWjsvkN1
         zNA+6GqSOmBrgbfZ1OQIiQ+SoRjjnFSeWfrz7T5ahfOOxQI3j1WL+EgrM/HI1IH/Smcm
         O77O8JatcPunHUGJGiLNJtoLdJQvknX61ygVsQ621grsC98lUwRSZ/4BbyX6B2lECdb8
         EEdDZKE+nNKKa92FF7V3nyEfLRjsNWSCujY8oW7030OvfkxVY7b/3gM2VQ5XfUUypgdK
         jhf9fqcT/8UlQj19tDB97s8FHxA2tfIaloPRyt2Zjv4dqpZpzMSea2WZvFh6u7kvkSFc
         7V6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768854918; x=1769459718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzIJGZN4ZQbZMlVh2ia8X5lmsWPHg4qhIHUWgiA2akw=;
        b=FylYoL9kpQeg4Ui9dx5N37B5P+fir/lfHVKHNowC/50dhWSwPD5/wOKj2KDNmmMwMU
         VsFkCyZ7sRjZe8MNTSLcxm5MwN9ACNZ6cl1KLCSwuMrjaFdjf08MIZ+dGkhERHrU1duN
         M5gYty9gfvRCUQ/RjVOVlvFTgAhLziadTvwGkAvVDkJY4kwW3cCMeusoW6c6lutktRsZ
         1iDdetnpzAjYXEhlsPa6OElE6m40sRebH0U0BJo3GyXS5/YOOkpL4HmZpU0cfXVj6uc+
         odrVkfDaRfVXfbP4kaoOIxnreYjILsdqoKzCpfhTDSJ5BpYBSke4Tye9/pi1/GQqrZQL
         Z03Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5YqaU93DrXSvepvobZm80GsTAtBuw/6HK9RWuyN9AVWUcO/tSznFoYqAv0hkbbnwDqPY2rFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOkcgw83LOLV0uoBsAORGP20G6/KVp+bBRdf8FknGFtc+8et6F
	8WTy0z9UXZIPyCYsUxsYyCNYEQL1YoXzkjSXSyK/AqmphG9v3HzMC3kf
X-Gm-Gg: AZuq6aIZ/G01Bjudu9y8Iv2Lfuu1buA3clN+oPor5Or855OUfSaTQ49mT/pNDednY00
	RQstMPFcwWcCwfSkbsV0sC8RyRWj5kCPYZysuuQpQp4HgPYxNBtnMIhiXPnhpPgeVYN/7RVlJWM
	+IMqLiszCpTIQ0YqAG3+dSyUlBN6D33G4CsLMoGSfowWtdI7V8HIQ3cnc4BzNsKatgW5TWHJZVY
	zXnk+xx9jdcLg3iiWebKEtoqKXrBJeAWqGY7spgv/8HNzwJuhoKi2Ak6PfX8qoEcG8ed5vMhLFx
	2FelM/oh6mewZTLpnzi9E0iNxaeuSGTVcm5/TXrtGE6k+CHg6YmqBYoyFk0v8MYch4X/HeEve4G
	kgKsitf2379i9lteakL1uAGq72pBCIi0DqhDY8EI+K3u+F+mNNSw26zzQL0huc0V7kTAAINV0xW
	F6KQGB9I2IioGyV2tjAb3bXXqJ35CWM+aWWmU/
X-Received: by 2002:a05:6402:5243:b0:63c:3c63:75ed with SMTP id 4fb4d7f45d1cf-65452acb11dmr9486736a12.22.1768854917759;
        Mon, 19 Jan 2026 12:35:17 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65452bce411sm11134388a12.7.2026.01.19.12.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 12:35:17 -0800 (PST)
From: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"John Johansen" <john.johansen@canonical.com>,
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
Subject: [PATCH v3 0/5] landlock: Pathname-based UNIX connect() control
Date: Mon, 19 Jan 2026 21:34:52 +0100
Message-ID: <20260119203457.97676-2-gnoack3000@gmail.com>
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
with sendmsg(2)).  It introduces the filesystem access right
LANDLOCK_ACCESS_FS_RESOLVE_UNIX.

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

== Motivation

Currently, landlocked processes can connect to named UNIX sockets
through the BSD socket API described in unix(7), by invoking socket(2)
followed by connect(2) with a suitable struct sockname_un holding the
socket's filename.  This is a surprising gap in Landlock's sandboxing
capabilities for users (e.g. in [1]) and it can be used to escape a
sandbox when a Unix service offers command execution (various such
scenarios were listed by Tingmao Wang in [2]).

The original feature request is at [4].

== Alternatives and Related Work

=== Alternative: Use existing LSM hooks

We have carefully and seriously considered the use of existing LSM
hooks, but still came to the conclusion that a new LSM hook is better
suited in this case:

The existing hooks security_unix_stream_connect(),
security_unix_may_send() and security_socket_connect() do not give
access to the resolved filesystem path.

* Resolving the filesystem path in the struct sockaddr_un again within
  a Landlock would produce a TOCTOU race, so this is not an option.
* We would therefore need to wire through the resolved struct path
  from unix_find_bsd() to one of the existing LSM hooks which get
  called later.  This would be a more substantial change to af_unix.c.

The struct path that is available in the listening-side struct sock is
can be read through the existing hooks, but it is not an option to use
this information: As the listening socket may have been bound from
within a different namespace, the path that was used for that can is
in the general case not meaningful for a sandboxed process.  In
particular, it is not possible to use this path (or prefixes thereof)
when constructing a sandbox policy in the client-side process.

Paul Moore also chimed in in support of adding a new hook, with the
rationale that the simplest change to the LSM hook interface has
traditionally proven to be the most robust. [11]

More details are on the Github issue at [6] and on the LKML at [9].

The most comprehensive discussion happened in a discussion started in
the V2 review by Christian Brauner [10], where we have further
explored the approach of reusing the existing LSM hooks but still
ended up leaning on the side of introducing a new hook, with Paul
Moore and me (gnoack) arguing for that option.

=== Related work: Scope Control for Pathname Unix Sockets

The motivation for this patch is the same as in Tingmao Wang's patch
set for "scoped" control for pathname Unix sockets [2], originally
proposed in the Github feature request [5].

In my reply to this patch set [3], I have discussed the differences
between these two approaches.  On the related discussions on Github
[4] and [5], there was consensus that the scope-based control is
complimentary to the filesystem based control, but does not replace
it.  Mickael's opening remark on [5] says:

> This scoping would be complementary to #36 which would mainly be
> about allowing a sandboxed process to connect to a more privileged
> service (identified with a path).

== Credits

The feature was originally suggested by Jann Horn in [7].

Tingmao Wang and Demi Marie Obenour have taken the initiative to
revive this discussion again in [1], [4] and [5] and Tingmao Wang has
sent the patch set for the scoped access control for pathname Unix
sockets [2].

Justin Suess has sent the patch for the LSM hook in [8] and
subsequently through this patch set.

Ryan Sullivan has started on an initial implementation and has brought
up relevant discussion points on the Github issue at [4] that lead to
the current approach.

Christian Brauner and Paul Moore have contributed to the design of the
new LSM hook, discussing the tradeoffs in [10].

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
[10] https://lore.kernel.org/all/20260113-kerngesund-etage-86de4a21da24@brauner/
[11] https://lore.kernel.org/all/CAHC9VhQHZCe0LMx4xzSo-h1SWY489U4frKYnxu4YVrcJN3x7nA@mail.gmail.com/
---

== Older versions of this patch set

V1: https://lore.kernel.org/all/20260101134102.25938-1-gnoack3000@gmail.com/
V2: https://lore.kernel.org/all/20260110143300.71048-2-gnoack3000@gmail.com/

Changes in V3:
 * LSM hook: rename it to security_unix_find() (Justin Suess)
   (resolving the previously open question about the LSM hook name)
   Related discussions:
   https://lore.kernel.org/all/20260112.Wufar9coosoo@digikod.net/
   https://lore.kernel.org/all/CAHC9VhSRiHwLEWfFkQdPEwgB4AXKbXzw_+3u=9hPpvUTnu02Bg@mail.gmail.com/
 * Reunite the three UNIX resolving access rights back into one
   (resolving the previously open question about the access right
   structuring) Related discussion:
   https://lore.kernel.org/all/20260112.Wufar9coosoo@digikod.net/)
 * Sample tool: Add new UNIX lookup access rights to ACCESS_FILE

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
  landlock: Document FS access right for pathname UNIX sockets

Justin Suess (1):
  lsm: Add hook security_unix_find

 Documentation/userspace-api/landlock.rst     |  14 +-
 include/linux/lsm_hook_defs.h                |   4 +
 include/linux/security.h                     |  11 +
 include/uapi/linux/landlock.h                |   5 +
 net/unix/af_unix.c                           |   9 +
 samples/landlock/sandboxer.c                 |  13 +-
 security/landlock/access.h                   |   2 +-
 security/landlock/audit.c                    |   1 +
 security/landlock/fs.c                       |  18 +-
 security/landlock/limits.h                   |   2 +-
 security/landlock/syscalls.c                 |   2 +-
 security/security.c                          |  20 ++
 tools/testing/selftests/landlock/base_test.c |   2 +-
 tools/testing/selftests/landlock/fs_test.c   | 223 +++++++++++++++++--
 14 files changed, 299 insertions(+), 27 deletions(-)

-- 
2.52.0


