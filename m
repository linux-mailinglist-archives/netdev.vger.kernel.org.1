Return-Path: <netdev+bounces-272621-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGmqCcO2xmnoNwUAu9opvQ
	(envelope-from <netdev+bounces-272621-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 17:56:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D5F347EBB
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 17:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44AA73175ADE
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A95C35AC0B;
	Fri, 27 Mar 2026 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKufKl3O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E15A34D938
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630143; cv=none; b=C0iOTzHrgPAOvYIvP1CorxCaR9ZquqSvIc2Fn0jxpffgfMVs7QX7bv6aUutsz2AX5ySfkXR+IXelwka/bakXCxC0+CNAX038M/dKbVNIfVkFYJxV13TmJ25U1NuNcRiz3SZbljBCeTDm4GjVfF5q2kj7AEqs8+hK/Asu837wqsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630143; c=relaxed/simple;
	bh=YaSX+RzmmaqM+qVqu8ToYgfPUW+GRQqyWLAelKOMydg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=spHeJYsNbFmk8IjilolZC4mj8vgPcMm399cw0gp4tccbbAPDlLnLtXxj5BWbdtM/5QGk/iKMKhGpOfecG2lnQEkATPlzsJe1UakjUShA1O2hx4HnsANMvQhanHLY/+CuUz+5i9KKf9sAOFfZ7LYtbDoFstaHILlEG6t/p9rWX00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKufKl3O; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-486fda2a389so18952545e9.1
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 09:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774630140; x=1775234940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZK7G/MupynwThgdHbmrgNfsIWF1f7aREa7lvLQoAHo=;
        b=KKufKl3O/SkWQi1l/vEfLoArwNP2/YFy8xymW6+zSE4UHAB3AsFGCCNqIBEC7LwWGo
         IdqCvN5aHl8IvJ0fq2IxPSPNLHbEhCOl4do0dsQ+R0Ue92/hS6BsMNJ58yCdNwgdif3t
         HPanyo/n3vtYodvW6XFdnBAGAr/vXMnArKeKEGZz3f00PE4TvC8M+hjYGu9b5D7HzbXg
         hmBs5B7RE4CprW9ApWXX9DFJMJC7xGmqc8cUJPYnRnnh3TGgrI897VhNOL7sf7qLAz7p
         XPJ8e3VcbHZYsjMXWAeKxmR1PZxzUaY3Hcrju07SV76jhcjrrN14qAYqMV7G6Vzf/yjF
         1CIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774630140; x=1775234940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZK7G/MupynwThgdHbmrgNfsIWF1f7aREa7lvLQoAHo=;
        b=p3XTZGh4YzotxridvEoJS6xKhn2pLPobHXYT+vJHEcBfIfWQ2bN2sfYukDzyiEO5dw
         H5hdWGjMQUEme+09qVYb/3yZgEpYF5c0GpqpKo9crHmI65ufGUP9YMa3y8U9VbXrSU5s
         QWbR5RKJ32Dl5jiCEyWWCMN/BB5oQ0R+cAf6kykbVNIccrFpD6L/lcmgvQJNlf1m0KUz
         CcCY4NRa9RropKh0trNgmV7flFXgH4NS5hjqfpBR4rzFXfaU78LQhbL/W32YaEYB7Brc
         9N0fZb+T28XdWVXMBIhIlITecSedUMSucyTDDps5ZjvEUvdlpMu9HggJtLUjv0ewNfRa
         aJkw==
X-Forwarded-Encrypted: i=1; AJvYcCVTO3Wej24jOfqjjd4nc5l48r7nUJAHTgDpLGYziqZElH70OXovjGXLk970BhNhFgYnym0F0ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjpvtveANDopSVnCJawoL6aug1S/sgNV1ZiN9eTfazeHtvxD4t
	Meupja4zRGA+wgtubrttglUrEvmQWd0lyzkQZHt5/1GKXaCDAZc5kLmf
X-Gm-Gg: ATEYQzxrQy+k0XpZ76WZfUG9Pv9OuWacFyFcfIj4xkLboUFYZBCd98WLoN8yp4AXEoF
	7wwRPFu5rtOAgbFpum7CUQgEwCmJumd28G/otTge+SUGBdrRFZR+PIsEP1sjYo+udobpER9q4y/
	4jVkEalP+48fXbneGcSxTXQpspZVpalVnBtw2MSAd+gOd8DA9dPiJGlrfi1y2wRDKAshgyiaPPv
	+5wr0892/Bd+wItPJOWNmDq/PJh+OMmEWzICGUYqG5wDg4NOA9rrCrfKjzAFinKjgPOKS8vTFXL
	LoVENjGmISbHrtFHlflL8arYBtqZeKfAyk1zaDCFMkV9c4XNNRGjBtAlm6p1t/KIcmKtIOD/ZG0
	/0NRcBoF+pqM0+6HRGNAqgfd/jCe2TGzIJS1u0vKBBSf2Gy+zEC2PlCyK/ESA2xxPTFT9teZuY6
	4kZnMRiSmMoKa+LjAAclfGTca+YZgnLCfhV/O8rZCBQ1GvwyIK
X-Received: by 2002:a05:600c:c086:b0:485:3fd1:9936 with SMTP id 5b1f17b1804b1-48727d6aec6mr46362305e9.5.1774630139440;
        Fri, 27 Mar 2026 09:48:59 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722cb10fcsm98147065e9.14.2026.03.27.09.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 09:48:58 -0700 (PDT)
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Kuniyuki Iwashima" <kuniyu@google.com>,
	"Georgia Garcia" <georgia.garcia@canonical.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v8 00/12] landlock: UNIX connect() control by pathname and scope
Date: Fri, 27 Mar 2026 17:48:25 +0100
Message-ID: <20260327164838.38231-1-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,maowtm.org,oracle.com,buffet.re,huawei-partners.com,huawei.com,alyssa.is,google.com,linutronix.de,canonical.com,kernel.org,zeniv.linux.org.uk];
	TAGGED_FROM(0.00)[bounces-272621-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gnoack3000@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B2D5F347EBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Sebastian Andrzej Siewior and Kuniyuki Iwashima have helped with
locking questions in the networking subsystem. [15] [16]

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
[15] https://lore.kernel.org/all/20260310151907.VYySCtJp@linutronix.de/
[16] https://lore.kernel.org/all/CAAVpQUC95mSjX1vRK===pubHofcYqbkNE7goYKiu6vha5GYAFw@mail.gmail.com/

---

== Patch set history

V1: https://lore.kernel.org/all/20260101134102.25938-1-gnoack3000@gmail.com/
V2: https://lore.kernel.org/all/20260110143300.71048-2-gnoack3000@gmail.com/
V3: https://lore.kernel.org/all/20260119203457.97676-2-gnoack3000@gmail.com/
V4: https://lore.kernel.org/all/20260208231017.114343-1-gnoack3000@gmail.com/
V5: https://lore.kernel.org/all/20260215105158.28132-1-gnoack3000@gmail.com/
V6: https://lore.kernel.org/all/20260315222150.121952-1-gnoack3000@gmail.com/
V7: https://lore.kernel.org/all/20260323165654.193957-1-gnoack3000@gmail.com/

Changes in V8:

* Added a fix for the m68k GCC 15 compiler failure
* Reorder BUILD_BUG_ON commit to be directly after the implementation commit
* Documentation: Use the current month (March 2026) in uapi doc comment

Changes in V7:

* Implementation:
  * LSM hook: Small header file layout restructurings, typos (Justin)
  * Hold unix_state_lock across the usage of the other Landlock domain
    This prevents a UAF; spotted by Mickaël and Sebastian in code review 🏆
  * Ignore the return value from landlock_init_layer_masks() -
    it is not needed in this specific case
  * Add a BUILD_BUG_ON to unmask_scoped_access() like in
    domain_is_scoped().  Revise the BUILD_BUG_ON logic and bring both
    implementations in line.
* Documentation and commentary:
  * Mention access_mask_t change from u16 to u32 in commit message
  * Improve documentation for unmask_scoped_access()
  * Various typos and smaller documentation fixes, caught in code review
  * Add ABI version remark to landlock.h
  * Add comment to explain why returning 0 on SOCK_DEAD is correct -
    This is not obvious in the code and requires understanding the callers
  * In kernel docs, use "case 6 ... 8" in a place

Changes in V6:

* Implementation:
  * Move the LSM hook call after the check that checks for the other
    end's matching socket type.  (Justin Suess)
  * Lock with unix_state_lock() and check SOCK_DEAD.
  * Remove unnecessary layer_access_masks_empty() call (and its
    implementation).
* Documentation:
  * Squash docs with design rationale into main implementation commit,
    and cross-referece it from the header docs.
  * Clarify that denials result in EACCES and that this is consistent
    with other filesystem access rights.
* Minor:
  * Use mem_is_zero() in is_layer_masks_allowed() (minor cleanup)
  * Omit unnecessary __attribute__((fallthrough)) usages
  * Remove comment at the end of a line in a place.
* Selftests:
  * sun_path population fixes
  * coredump test: Set EUID to 0 (needed for UML-based selftests)
    Link[1]: https://lore.kernel.org/all/20260218.ohth8theu8Yi@digikod.net/

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


Günther Noack (11):
  landlock: Use mem_is_zero() in is_layer_masks_allowed()
  landlock: Replace union access_masks_all with helper functions
  landlock: Control pathname UNIX domain socket resolution by path
  landlock: Clarify BUILD_BUG_ON check in scoping logic
  samples/landlock: Add support for named UNIX domain socket
    restrictions
  selftests/landlock: Replace access_fs_16 with ACCESS_ALL in fs_test
  selftests/landlock: Test LANDLOCK_ACCESS_FS_RESOLVE_UNIX
  selftests/landlock: Audit test for LANDLOCK_ACCESS_FS_RESOLVE_UNIX
  selftests/landlock: Check that coredump sockets stay unrestricted
  selftests/landlock: fs_test: Simplify ruleset creation and enforcement
  landlock: Document FS access right for pathname UNIX sockets

Justin Suess (1):
  lsm: Add LSM hook security_unix_find

 Documentation/security/landlock.rst          |   42 +-
 Documentation/userspace-api/landlock.rst     |   16 +-
 include/linux/lsm_hook_defs.h                |    5 +
 include/linux/security.h                     |   11 +
 include/uapi/linux/landlock.h                |   21 +
 net/unix/af_unix.c                           |   10 +-
 samples/landlock/sandboxer.c                 |   12 +-
 security/landlock/access.h                   |   23 +-
 security/landlock/audit.c                    |    1 +
 security/landlock/cred.h                     |   10 +-
 security/landlock/fs.c                       |  135 +-
 security/landlock/limits.h                   |    2 +-
 security/landlock/ruleset.h                  |   13 +-
 security/landlock/syscalls.c                 |    2 +-
 security/landlock/task.c                     |    9 +-
 security/security.c                          |   20 +
 tools/testing/selftests/landlock/base_test.c |    2 +-
 tools/testing/selftests/landlock/fs_test.c   | 1345 ++++++++++--------
 18 files changed, 1025 insertions(+), 654 deletions(-)

Range-diff against v7:
 -:  ------------ >  1:  dec515e7d7bf lsm: Add LSM hook security_unix_find
 -:  ------------ >  2:  aaa334660a52 landlock: Use mem_is_zero() in is_layer_masks_allowed()
 -:  ------------ >  3:  79dd5036482d landlock: Replace union access_masks_all with helper functions
 1:  4d455134c5d9 !  4:  b39e336967de landlock: Control pathname UNIX domain socket resolution by path
    @@ Commit message
         Signed-off-by: Günther Noack <gnoack3000@gmail.com>
     
      ## Documentation/security/landlock.rst ##
    +@@ Documentation/security/landlock.rst: Landlock LSM: kernel documentation
    + ==================================
    + 
    + :Author: Mickaël Salaün
    +-:Date: September 2025
    ++:Date: March 2026
    + 
    + Landlock's goal is to create scoped access-control (i.e. sandboxing).  To
    + harden a whole system, this feature should be available to any process,
     @@ Documentation/security/landlock.rst: this is required to keep access controls consistent over the whole system, and
      this avoids unattended bypasses through file descriptor passing (i.e. confused
      deputy attack).
    @@ Documentation/security/landlock.rst: this is required to keep access controls co
      =====
      
     
    + ## Documentation/userspace-api/landlock.rst ##
    +@@ Documentation/userspace-api/landlock.rst: Landlock: unprivileged access control
    + =====================================
    + 
    + :Author: Mickaël Salaün
    +-:Date: January 2026
    ++:Date: March 2026
    + 
    + The goal of Landlock is to enable restriction of ambient rights (e.g. global
    + filesystem or network access) for a set of processes.  Because Landlock
    +
      ## include/uapi/linux/landlock.h ##
     @@ include/uapi/linux/landlock.h: struct landlock_net_port_attr {
       *
 3:  00c90045f470 =  5:  3c8678a4a482 landlock: Clarify BUILD_BUG_ON check in scoping logic
 2:  70354dfcefcb =  6:  d0c8731fb751 samples/landlock: Add support for named UNIX domain socket restrictions
 4:  b8e6477b2f9a =  7:  49fa86251f1b selftests/landlock: Replace access_fs_16 with ACCESS_ALL in fs_test
 5:  66554c5b5b9c =  8:  69b368c23083 selftests/landlock: Test LANDLOCK_ACCESS_FS_RESOLVE_UNIX
 6:  fab3d3d71215 =  9:  7306a1da2947 selftests/landlock: Audit test for LANDLOCK_ACCESS_FS_RESOLVE_UNIX
 7:  4e8a07344278 = 10:  e63e98c44e58 selftests/landlock: Check that coredump sockets stay unrestricted
 8:  fcaef2882dbd = 11:  497bcce69260 selftests/landlock: fs_test: Simplify ruleset creation and enforcement
 9:  362a0e8f84a0 = 12:  c4716fc8e131 landlock: Document FS access right for pathname UNIX sockets
-- 
2.53.0


