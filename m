Return-Path: <netdev+bounces-258768-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGMEEHelkWmWlAEAu9opvQ
	(envelope-from <netdev+bounces-258768-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 11:52:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9B813E83B
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 11:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47F463011BE5
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 10:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BEB2D8DD9;
	Sun, 15 Feb 2026 10:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RStWDGb2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538C929D275
	for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 10:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771152753; cv=none; b=W8JzQ2+mcY3ijj1rb6tBQIuKSUiRLqTo+mdBuVOIJesmZU3ddncjuG6T8Cxh25FdIuxWJeidXuIaVbQJFK1nXkJDLJ5PP1brGVRL/6cUF/6ClxKn1EwXsi/dFtRf6WnZvAjAg9fbQc9AdeOjbbkNtGoaXHiPnwGK3xl9Pbofmns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771152753; c=relaxed/simple;
	bh=wQuYZonEityn8PlExbzzBrW46hHoaJy6JwsTaQiJkyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kog3XAQb7pRKiFQbmJzE49APs61b/zV0mqeq/YJDDmTzXwlPdGmp13OA/ni8LdoBvGsK5YsHsNodx8L3vH7MnKcpNTPsIKthHduhBTI7n4nY2JSJtqhbBHDGz/3Nly+MzP1BIeqRzkT4xdQ7SLmABmhQXNbcxwKDMpu5rvgezY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RStWDGb2; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4377174e1ebso1621761f8f.3
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 02:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771152750; x=1771757550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZI0LjX6XMnvD2HmZqsxyHHzFAJmwROlDjLzHkLvEUk=;
        b=RStWDGb2oYBRKhQ7WYujNb5AIMA7kPvyYVKAKJZx1Ps061Afat+a6qC0whPI0Npctt
         pQWLfReKYMhHbNx21dpmgqmwDhs/LYJR68MK7c3OqIzubG17gdqr2Jh85WbYhKyQZaqb
         HMdBql8EwvM/fw2M3hobFrc14Ynryov2WDtRtb7LEd9ft1XbL/HkFGVIKKMe4VVa7Yo1
         lvmq8tFzEtm7EuqeSr1UhShzbwXGbkQ+HhAYA8WaPP4NkPY5Nx2qFaamjZWX8Jyjugeu
         6TVmgQAX4jUdoWRJky2XRWkgP8dwEDPaBXW2cXkwbXb1ZqdiVDouRctL2AeVK4/Syqlq
         fEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771152751; x=1771757551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZI0LjX6XMnvD2HmZqsxyHHzFAJmwROlDjLzHkLvEUk=;
        b=D8+lGt6VuZHvGrpYu9MSNAdRMYDJhUSl//sflqc9dVRbSfiu8VjpCDsm342Sns1kT4
         S0Zx0nqMsdsx+55rzTqx2dHMqbUpsm4ts3DwlG6HUg4hCjDY2cmAX5a8cCzNB4uqCa9F
         IL6Hmo68so8NjavqzZzSiXmvwp/dWXrccWhajdt3r71IPH4o3JAmav59cOlLDg50lB39
         e+D4qaazYMeZDgnYNx3gwMmtTzj78J9nq6vtKMTdoqb+wHn6JASBuu876KX8Dx8tKoD0
         tGkwb2YOj9d5jx+Efhe6fOWNYkDR+9j2EiV39+kuzaEnqNnrG+JN7KmGZnI9M33DOFKc
         I4Fw==
X-Forwarded-Encrypted: i=1; AJvYcCUF1Dxn8+y9iWVDJKKPvqd4YPmKJTBu0MOGZc7Azim+QENuNovz86YhqptxG7GGVcnWbXmYHOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQr4NL+iea5wzinHR9AOVihqR87zoVk2mmPNEQW3h3UxGPCqUr
	/7ExvzMoaM+PTDRssZAUwCLD/5hH2tUJyuKg3xLASWlKCiPqMSUBYlH0
X-Gm-Gg: AZuq6aKVBX7BI1b3KIH1FgJwnK/xwzQdqqWDSqzN26d/USpe8KLGKgKgO86q/W2YXUX
	aCZNWTNbCKAcnn5H+dlXLT+VxbpmXtWnIHjnarrx+Rs+ODZiSET9IP09MLGDJNAyhaXZu0BuXOq
	OWr6IEr7tAYT7YTPT0bn2IQwlBm5QXc8alGoyEXFzzWQ89cUMkp4RR8JVwZOC12WOkDNQe949Ic
	gJH9tSqwPaX1/wof31g3dNGiXF6149Gm+cRr4DWw7oWogJS5YSRDCHxbhkD+Fis0OaGnXsNA2sp
	hRUbGAK2TNuppDCtTlwY2Rhhk7k2INBMEE9/W0tDTTLKslAD4p3TRLYwlX/A8rOEyGHrGyGz9EF
	gSZOmMV0Uy39LmLjrco6csU8qkj9aeTIQbgxRmSQcJvqtvDYDJW6H6+Pn7F+VtQTbgjBpS3eL7+
	bZYXfdPTwfZiRTuEvfe8rT7+1xBqnrLqLu8I5ZqLaTuXueSvDM4GXd1z3j4cI=
X-Received: by 2002:a05:6000:1447:b0:436:42cc:25ef with SMTP id ffacd0b85a97d-437978c19a0mr12316116f8f.13.1771152750163;
        Sun, 15 Feb 2026 02:52:30 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a5ac7csm16733231f8f.7.2026.02.15.02.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 02:52:29 -0800 (PST)
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
Subject: [PATCH v5 0/9] landlock: UNIX connect() control by pathname and scope
Date: Sun, 15 Feb 2026 11:51:48 +0100
Message-ID: <20260215105158.28132-1-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,maowtm.org,oracle.com,buffet.re,huawei-partners.com,huawei.com,alyssa.is,google.com,kernel.org,zeniv.linux.org.uk];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258768-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gnoack3000@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8F9B813E83B
X-Rspamd-Action: no action

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

When LANDLOCK_ACCESS_FS_RESOLVE_UNIX is handled within a Landlock
domain, this domain will only allow connect(2) and sendmsg(2) to
server sockets that were created within the same domain.  Or, to
phrase it the other way around: Unless it is allow-listed with a
LANDLOCK_PATH_BENEATH rule, the newly created domain denies connect(2)
and sendmsg(2) actions that are directed *outwards* of that domain.
In that regard, LANDLOCK_ACCESS_FS_RESOLVE_UNIX has the same semantics
as one of the "scoped" access rights.

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

In a the discussion of the V2 review, started by Christian Brauner
[10], we have further explored the approach of reusing the existing
LSM hooks but still ended up leaning on the side of introducing a new
hook, with Paul Moore and me (gnoack) arguing for that option.

Further insights about the LSM hook were shared in the V3 review by
Tingmao Wang [12], who spotted additional requirements due to the two
approaches being merged into one patch set.  The summary of that
discussion is in [13].

=== Related work: Scope Control for Pathname Unix Sockets

The motivation for this patch is the same as in Tingmao Wang's patch
set for "scoped" control for pathname Unix sockets [2], originally
proposed in the Github feature request [5].

In [14], we have settled on the decision to merge the two patch sets
into this one, whose primary way of controlling connect(2) is
LANDLOCK_ACCESS_FS_RESOLVE_UNIX, but where this flag additionally has
the semantics of only restricting this unix(7) IPC *outwards* of the
created Landlock domain, in line with the logic that exists for the
existing "scoped" flags already.

By having LANDLOCK_ACCESS_FS_RESOLVE_UNIX implement "scoping"
semantics, we can avoid introducing two separate interacting flags for
now, but we retain the option of introducing
LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET at a later point in time, should
such a flag be needed to express additional rules.

== Credits

The feature was originally suggested by Jann Horn in [7].

Tingmao Wang and Demi Marie Obenour have taken the initiative to
revive this discussion again in [1], [4] and [5].

Tingmao Wang has sent the patch set for the scoped access control for
pathname Unix sockets [2] and has contributed substantial insights
during the code review, shaping the form of the LSM hook and agreeing
to merge the pathname and scoped-flag patch sets.

Justin Suess has sent the patch for the LSM hook in [8] and
subsequently through this patch set.

Christian Brauner and Paul Moore have contributed to the design of the
new LSM hook, discussing the tradeoffs in [10].

Ryan Sullivan has started on an initial implementation and has brought
up relevant discussion points on the Github issue at [4].

As maintainer of Landlock, Mickaël Salaün has done the main review so
far and particularly pointed out ways in which the UNIX connect()
patch sets interact with each other and what we need to look for with
regards to UAPI consistency as Landlock evolves.

[1] https://lore.kernel.org/landlock/515ff0f4-2ab3-46de-8d1e-5c66a93c6ede@gmail.com/
[2] Tingmao Wang's "Implement scope control for pathname Unix sockets"
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
[12] https://lore.kernel.org/all/e6b6b069-384c-4c45-a56b-fa54b26bc72a@maowtm.org/
[13] https://lore.kernel.org/all/aYMenaSmBkAsFowd@google.com/
[14] https://lore.kernel.org/all/20260205.Kiech3gupee1@digikod.net/

---

== Patch set history

V1: https://lore.kernel.org/all/20260101134102.25938-1-gnoack3000@gmail.com/
V2: https://lore.kernel.org/all/20260110143300.71048-2-gnoack3000@gmail.com/
V3: https://lore.kernel.org/all/20260119203457.97676-2-gnoack3000@gmail.com/
V4: https://lore.kernel.org/all/20260208231017.114343-1-gnoack3000@gmail.com/

Changes in V5:

This change primarily adds tests, changing the testing approach for
the main test to use the scoped_domains fixture as in Tingmao's patch
set [2], and adding tests for the audit and coredump cases.

* Selftests:
  * Replaced the main selftest with one based on scoped_domains
  * Added audit test
  * Added test for the coredump case
  * Added a follow-up commit that simplifies ruleset enforcement
* Kernel code:
  * Mark coredump check as unlikely (per Justin's review)
  * Drop check for socket type (per Mickaël's review)

Changes in V4:

Since this version, this patch set subsumes the scoping semantics from
Tingmao Wang's "Scope Control" patch set [2], per discussion with
Tingmao Wang and Mickaël Salaün in [14] and in the thread leading up
to it.

Now, LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET only restricts connect(2) and
sendmsg(2) *outwards* of the domain where it is restricted, *with the
same semantics as a "scoped" flag*.

 * Implement a layer-mask based version of domain_is_scoped():
   unmask_scoped_access().  Rationale: domain_is_scoped() returns
   early, which we can't do in the layer masks based variant.  The two
   variants are similar enough.
 * LSM hook: Replace 'type' argument with 'sk' argument,
   per discussion in [12] and [13].
 * Bump ABI version to 9 (pessimistically assuming that we won't make
   it for 7.0)
 * Documentation fixes in header file and in Documentation/
 * selftests: more test variants, now also parameterizing whether the
   server socket gets created within the Landlock domain or before that
 * selftests: use EXPECT_EQ() for test cleanup

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

Günther Noack (8):
  landlock: Control pathname UNIX domain socket resolution by path
  samples/landlock: Add support for named UNIX domain socket
    restrictions
  landlock/selftests: Test LANDLOCK_ACCESS_FS_RESOLVE_UNIX
  landlock/selftests: Audit test for LANDLOCK_ACCESS_FS_RESOLVE_UNIX
  landlock/selftests: Check that coredump sockets stay unrestricted
  landlock/selftests: fs_test: Simplify ruleset creation and enforcement
  landlock: Document FS access right for pathname UNIX sockets
  landlock: Document design rationale for scoped access rights

Justin Suess (1):
  lsm: Add LSM hook security_unix_find

 Documentation/security/landlock.rst          |   38 +
 Documentation/userspace-api/landlock.rst     |   16 +-
 include/linux/lsm_hook_defs.h                |    5 +
 include/linux/security.h                     |   11 +
 include/uapi/linux/landlock.h                |   10 +
 net/unix/af_unix.c                           |    8 +
 samples/landlock/sandboxer.c                 |   15 +-
 security/landlock/access.h                   |   11 +-
 security/landlock/audit.c                    |    1 +
 security/landlock/fs.c                       |  102 +-
 security/landlock/limits.h                   |    2 +-
 security/landlock/syscalls.c                 |    2 +-
 security/security.c                          |   20 +
 tools/testing/selftests/landlock/base_test.c |    2 +-
 tools/testing/selftests/landlock/fs_test.c   | 1301 ++++++++++--------
 15 files changed, 942 insertions(+), 602 deletions(-)

-- 
2.52.0


