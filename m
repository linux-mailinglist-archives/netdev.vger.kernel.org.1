Return-Path: <netdev+bounces-270620-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGYpJKV2wWkQTQQAu9opvQ
	(envelope-from <netdev+bounces-270620-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:21:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEB72F9C84
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE1F13019C93
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 16:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205593C3443;
	Mon, 23 Mar 2026 16:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SE1tKiow"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26363C0612
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285093; cv=none; b=kW67k5UAluwgGzT9OKhqVGd5E3HPoAofiHH3ZpW1sdY37gZG/ZdJEUGRGyTcyyzPmW7IR3tnlqIv3zay9XYwGkrNktfS/416uQI3P74H4vPz/KYJpoD1IvEi+4XLiu0pXlrgAr6MxinLcORa+HUoLzjeavimsXCNoKl8Sn7gH/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285093; c=relaxed/simple;
	bh=H3r0oqonbF+JvuldcLLdRHu03VSWiqg4sxfy1wt8ds8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jtcUv68jq1EFu1SPRBThG68vJ0MosesAtJOAHjC4BZUGPQW8kOMjgcaLTfGecDrDPDbOD0jR8E5lf1h/TMvLqY/VG5oPGIzSgfMSSI1M0fVn+MJvAGOiJ60mZR+fTKFrUc9K6fVYyvao7bL2cPGvb8kHAc8HMftPza/Z3agoKoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SE1tKiow; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486507134e4so4468855e9.0
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 09:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774285087; x=1774889887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z4ffkOY+6p/NlYHV+sbGxNygvHF+TY1FOGbqtfFowt8=;
        b=SE1tKiowQWOBTISOehOITIRk4R2GA6lnstboOr9nXIpa14fiVgSbQUjYDstOq/1ukn
         n4o6L41iItiX3FD5xHcaFzRwVk7cd3n1aQj+8KWiHfwPw4iN5gldLEU3eE7sNyR6xiIF
         MnlZT5JupZlgbVFVIwe+wm9jua8IGYA4Allvu8qL3+GitaDqQpt8cp37KO4nzMDc/GLZ
         8ywcqDs/fTRYvlCf4NZW4fOe3bGfuJJRus2kO6MlABqzC8EPBpnd31jhoGMSuwo+jzAP
         ZqpkIBIl2GvuZjBhop0bS7AKom0oLakAd4H9XR/NzijjwoCUaLeHbyqTf0mhju71mJO/
         mUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774285087; x=1774889887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4ffkOY+6p/NlYHV+sbGxNygvHF+TY1FOGbqtfFowt8=;
        b=mG1KjZLxI0yxMHgDLSjV4tJW73cpYzIDoB0xll7eNFA0QjKIFxW2SoYBMbQEewCfRV
         yjJ3V0Z2QRVe3GhfwlGex21qehI1e9HbwNmitutg1eS3AcwdqJBQHWubOWQcXnWfGZC/
         8tlp1HeU39luWdcXk4b+rWLwfe6MLflhGzZwtbmjzTFtaN+E8lwZA1NQnT6VNUWKmi5h
         SGmijR5pujj3IHobV7JW0GF3CgOlVG+U7SYGFAiTbJ6ULWUYLLx9qYHNmuXyQeCuGpUP
         wuVx2XhfplU3K/iysqAVV6d/36evaevKvQNoFrN6/MStqYzp+ffRRZSa6U+4U30SOMKr
         H/ig==
X-Forwarded-Encrypted: i=1; AJvYcCVoGH2lZ6xBeIVnVvTAKWKmN7oSWbeDLg8kAnOQuLHvLyVRofUVNDYYrTmdB5Shyvmzup9z1uE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnCrHwRMVqGrhNGHkA189yEniRcnW99DUo1fFDq+27/Y4hL++A
	JqXk8ahSnaw/k2jf8uw7vK6XOXRZkjqgY94kFFqcBIp7KWQ7unR30eK9
X-Gm-Gg: ATEYQzwvscEZacWRO6hWX18Q6PeVzL7wKCAM2WlWRkacf38C11zF6yPFba8dTsqqKNq
	kaw8SnIh0M2TTEpjeYeB5+n/5lgENMyZi6yWqZLB6ZLZsp4BpW5mtdPofIlskce/0T+ksO8v1RQ
	qXNvAx1Ju6QNz8Z6wUG1fY4Sb4zO8RQlBau99UysA/s6v1vgdcgMgnFjBmSVet+cg3AKm38BXGX
	zKW5xsmhw/lvJYkM+/C+XRakS5lZbawVpAwMhyB5Q7EItiASFsU+1oNQ4T5ZPt99sWd5oituAcF
	h6dehtOOycScPpmMlW37FoZ7zcyBeVB4KAFc3QPO7kkRYPn1mj63DP/VX3P711dDv/3yrs5xGWc
	oLsNf62CSY1KHYCd1bUPYko6vsM6ozL8cSyPATckEXi0LLPj5oombWJXEPqPvL7DKjzB3qG9GlD
	HUpoyd3w9bJYPNd7tdLRY9g5vWlTEef9J/zsl2aQrjvhkYPtuT
X-Received: by 2002:a05:600c:5288:b0:485:3bb5:92cf with SMTP id 5b1f17b1804b1-486fedc9a5fmr195515635e9.12.1774285086474;
        Mon, 23 Mar 2026 09:58:06 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8b949e1sm601409055e9.9.2026.03.23.09.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:58:06 -0700 (PDT)
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
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v7 00/11] landlock: UNIX connect() control by pathname and scope
Date: Mon, 23 Mar 2026 17:56:42 +0100
Message-ID: <20260323165654.193957-1-gnoack3000@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270620-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,maowtm.org,oracle.com,buffet.re,huawei-partners.com,huawei.com,alyssa.is,google.com,linutronix.de,kernel.org,zeniv.linux.org.uk];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gnoack3000@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2CEB72F9C84
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


Günther Noack (10):
  landlock: Use mem_is_zero() in is_layer_masks_allowed()
  landlock: Control pathname UNIX domain socket resolution by path
  samples/landlock: Add support for named UNIX domain socket
    restrictions
  landlock: Clarify BUILD_BUG_ON check in scoping logic
  selftests/landlock: Replace access_fs_16 with ACCESS_ALL in fs_test
  selftests/landlock: Test LANDLOCK_ACCESS_FS_RESOLVE_UNIX
  selftests/landlock: Audit test for LANDLOCK_ACCESS_FS_RESOLVE_UNIX
  selftests/landlock: Check that coredump sockets stay unrestricted
  selftests/landlock: fs_test: Simplify ruleset creation and enforcement
  landlock: Document FS access right for pathname UNIX sockets

Justin Suess (1):
  lsm: Add LSM hook security_unix_find

 Documentation/security/landlock.rst          |   40 +
 Documentation/userspace-api/landlock.rst     |   14 +-
 include/linux/lsm_hook_defs.h                |    5 +
 include/linux/security.h                     |   11 +
 include/uapi/linux/landlock.h                |   21 +
 net/unix/af_unix.c                           |   10 +-
 samples/landlock/sandboxer.c                 |   12 +-
 security/landlock/access.h                   |    2 +-
 security/landlock/audit.c                    |    1 +
 security/landlock/fs.c                       |  135 +-
 security/landlock/limits.h                   |    2 +-
 security/landlock/syscalls.c                 |    2 +-
 security/landlock/task.c                     |    9 +-
 security/security.c                          |   20 +
 tools/testing/selftests/landlock/base_test.c |    2 +-
 tools/testing/selftests/landlock/fs_test.c   | 1345 ++++++++++--------
 16 files changed, 1003 insertions(+), 628 deletions(-)

Range-diff against v6:
 1:  b2235eddb099 !  1:  dec515e7d7bf lsm: Add LSM hook security_unix_find
    @@ Metadata
      ## Commit message ##
         lsm: Add LSM hook security_unix_find
     
    -    Add a LSM hook security_unix_find.
    +    Add an LSM hook security_unix_find.
     
    -    This hook is called to check the path of a named unix socket before a
    +    This hook is called to check the path of a named UNIX socket before a
         connection is initiated. The peer socket may be inspected as well.
     
         Why existing hooks are unsuitable:
    @@ Commit message
         may be bound to a path in a different namespace than the caller,
         resulting in a path that cannot be referenced at policy creation time.
     
    +    Consumers of the hook wishing to reference @other are responsible
    +    for acquiring the unix_state_lock and checking for the SOCK_DEAD flag
    +    therein, ensuring the socket hasn't died since lookup.
    +
         Cc: Günther Noack <gnoack3000@gmail.com>
         Cc: Tingmao Wang <m@maowtm.org>
    +    Cc: Mickaël Salaün <mic@digikod.net>
    +    Cc: Paul Moore <paul@paul-moore.com>
         Signed-off-by: Justin Suess <utilityemal77@gmail.com>
    +    Signed-off-by: Günther Noack <gnoack3000@gmail.com>
     
      ## include/linux/lsm_hook_defs.h ##
     @@ include/linux/lsm_hook_defs.h: LSM_HOOK(int, 0, post_notification, const struct cred *w_cred,
    @@ net/unix/af_unix.c: static struct sock *unix_find_bsd(struct sockaddr_un *sunadd
     +	if (sk->sk_type != type)
      		goto sock_put;
      
    -+	/*
    -+	 * We call the hook because we know that the inode is a socket and we
    -+	 * hold a valid reference to it via the path.
    -+	 */
     +	err = security_unix_find(&path, sk, flags);
     +	if (err)
     +		goto sock_put;
    ++
     +	touch_atime(&path);
     +
      	path_put(&path);
    @@ security/security.c: int security_mptcp_add_subflow(struct sock *sk, struct sock
     + * @flags: flags associated with the socket
     + *
     + * This hook is called to check permissions before connecting to a named
    -+ * AF_UNIX socket.
    ++ * AF_UNIX socket. The caller does not hold any locks on @other.
     + *
     + * Return: Returns 0 if permission is granted.
     + */
 2:  0e25c15eea62 !  2:  aaa334660a52 landlock: use mem_is_zero() in is_layer_masks_allowed()
    @@ Metadata
     Author: Günther Noack <gnoack3000@gmail.com>
     
      ## Commit message ##
    -    landlock: use mem_is_zero() in is_layer_masks_allowed()
    +    landlock: Use mem_is_zero() in is_layer_masks_allowed()
     
         This is equivalent, but expresses the intent a bit clearer.
     
 3:  e50515788eba !  3:  4d455134c5d9 landlock: Control pathname UNIX domain socket resolution by path
    @@ Commit message
         landlock: Control pathname UNIX domain socket resolution by path
     
         * Add a new access right LANDLOCK_ACCESS_FS_RESOLVE_UNIX, which
    -      controls the look up operations for named UNIX domain sockets.  The
    +      controls the lookup operations for named UNIX domain sockets.  The
           resolution happens during connect() and sendmsg() (depending on
           socket type).
    +    * Change access_mask_t from u16 to u32 (see below)
         * Hook into the path lookup in unix_find_bsd() in af_unix.c, using a
           LSM hook.  Make policy decisions based on the new access rights
         * Increment the Landlock ABI version.
    -    * Minor test adaptions to keep the tests working.
    +    * Minor test adaptations to keep the tests working.
         * Document the design rationale for scoped access rights,
           and cross-reference it from the header documentation.
     
    @@ Commit message
     
         In case of a denial, connect() and sendmsg() return EACCES, which is
         the same error as it is returned if the user does not have the write
    -    bit in the traditional Unix file system permissions of that file.
    +    bit in the traditional UNIX file system permissions of that file.
    +
    +    The access_mask_t type grows from u16 to u32 to make space for the new
    +    access right.  This also doubles the size of struct layer_access_masks
    +    from 32 byte to 64 byte.
     
         Document the (possible future) interaction between scoped flags and
         other access rights in struct landlock_ruleset_attr, and summarize the
    @@ include/uapi/linux/landlock.h: struct landlock_net_port_attr {
     + *   were created outside of the newly created Landlock domain (e.g. from within
     + *   a parent domain or from an unrestricted process).  Newly created UNIX
     + *   servers within the same Landlock domain continue to be accessible.  In this
    -+ *   regard, %LANDLOCK_ACCESS_RESOLVE_UNIX has the same semantics as the
    ++ *   regard, %LANDLOCK_ACCESS_FS_RESOLVE_UNIX has the same semantics as the
     + *   ``LANDLOCK_SCOPE_*`` flags.
     + *
     + *   If a resolve attempt is denied, the operation returns an ``EACCES`` error,
     + *   in line with other filesystem access rights (but different to denials for
     + *   abstract UNIX domain sockets).
     + *
    ++ *   This access right is available since the ninth version of the Landlock ABI.
    ++ *
     + *   The rationale for this design is described in
     + *   :ref:`Documentation/security/landlock.rst <scoped-flags-interaction>`.
       *
    @@ security/landlock/fs.c: static int hook_path_truncate(const struct path *const p
     + * This does the same as domain_is_scoped(), but unmasks bits in @masks.
     + * It can not return early as domain_is_scoped() does.
     + *
    ++ * A scoped access for a given access right bit is allowed iff, for all layer
    ++ * depths where the access bit is set, the client and server domain are the
    ++ * same.  This function clears the access rights @access in @masks at all layer
    ++ * depths where the client and server domain are the same, so that, when they
    ++ * are all cleared, the access is allowed.
    ++ *
     + * @client: Client domain
     + * @server: Server domain
     + * @masks: Layer access masks to unmask
    -+ * @access: Access bit that controls scoping
    ++ * @access: Access bits that control scoping
     + */
     +static void unmask_scoped_access(const struct landlock_ruleset *const client,
     +				 const struct landlock_ruleset *const server,
    @@ security/landlock/fs.c: static int hook_path_truncate(const struct path *const p
     +	if (!server)
     +		return;
     +
    ++	/*
    ++	 * client_layer must be a signed integer with greater capacity
    ++	 * than client->num_layers to ensure the following loop stops.
    ++	 */
    ++	BUILD_BUG_ON(sizeof(client_layer) > sizeof(client->num_layers));
    ++
     +	client_layer = client->num_layers - 1;
     +	client_walker = client->hierarchy;
     +	server_layer = server->num_layers - 1;
    @@ security/landlock/fs.c: static int hook_path_truncate(const struct path *const p
     +	if (unlikely(flags & SOCK_COREDUMP))
     +		return 0;
     +
    -+	/* Access to the same (or a lower) domain is always allowed. */
     +	subject = landlock_get_applicable_subject(current_cred(),
     +						  fs_resolve_unix, NULL);
     +
     +	if (!subject)
     +		return 0;
     +
    -+	if (!landlock_init_layer_masks(subject->domain, fs_resolve_unix.fs,
    -+				       &layer_masks, LANDLOCK_KEY_INODE))
    -+		return 0;
    ++	/*
    ++	 * Ignoring return value: that the domains apply was already checked in
    ++	 * landlock_get_applicable_subject() above.
    ++	 */
    ++	landlock_init_layer_masks(subject->domain, fs_resolve_unix.fs,
    ++				  &layer_masks, LANDLOCK_KEY_INODE);
     +
     +	/* Checks the layers in which we are connecting within the same domain. */
     +	unix_state_lock(other);
     +	if (unlikely(sock_flag(other, SOCK_DEAD) || !other->sk_socket ||
     +		     !other->sk_socket->file)) {
     +		unix_state_unlock(other);
    ++		/*
    ++		 * We rely on the caller to catch the (non-reversible) SOCK_DEAD
    ++		 * condition and retry the lookup.  If we returned an error
    ++		 * here, the lookup would not get retried.
    ++		 */
     +		return 0;
     +	}
     +	dom_other = landlock_cred(other->sk_socket->file->f_cred)->domain;
    -+	unix_state_unlock(other);
     +
    ++	/* Access to the same (or a lower) domain is always allowed. */
     +	unmask_scoped_access(subject->domain, dom_other, &layer_masks,
     +			     fs_resolve_unix.fs);
    ++	unix_state_unlock(other);
     +
     +	/* Checks the connections to allow-listed paths. */
     +	if (is_access_to_paths_allowed(subject->domain, path,
 4:  8c1a813b9831 =  4:  70354dfcefcb samples/landlock: Add support for named UNIX domain socket restrictions
 -:  ------------ >  5:  00c90045f470 landlock: Clarify BUILD_BUG_ON check in scoping logic
 9:  43c93c9af805 !  6:  b8e6477b2f9a landlock: Document FS access right for pathname UNIX sockets
    @@ Metadata
     Author: Günther Noack <gnoack3000@gmail.com>
     
      ## Commit message ##
    -    landlock: Document FS access right for pathname UNIX sockets
    +    selftests/landlock: Replace access_fs_16 with ACCESS_ALL in fs_test
     
    -    Cc: Justin Suess <utilityemal77@gmail.com>
    -    Cc: Mickaël Salaün <mic@digikod.net>
    +    The access_fs_16 variable was originally intended to stay frozen at 16
    +    access rights so that audit tests would not need updating when new
    +    access rights are added.  Now that we have 17 access rights, the name
    +    is confusing.
    +
    +    Replace all uses of access_fs_16 with ACCESS_ALL and delete the
    +    variable.
    +
    +    Suggested-by: Mickaël Salaün <mic@digikod.net>
         Signed-off-by: Günther Noack <gnoack3000@gmail.com>
     
    - ## Documentation/userspace-api/landlock.rst ##
    -@@ Documentation/userspace-api/landlock.rst: to be explicit about the denied-by-default access rights.
    -             LANDLOCK_ACCESS_FS_MAKE_SYM |
    -             LANDLOCK_ACCESS_FS_REFER |
    -             LANDLOCK_ACCESS_FS_TRUNCATE |
    --            LANDLOCK_ACCESS_FS_IOCTL_DEV,
    -+            LANDLOCK_ACCESS_FS_IOCTL_DEV |
    -+            LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
    -         .handled_access_net =
    -             LANDLOCK_ACCESS_NET_BIND_TCP |
    -             LANDLOCK_ACCESS_NET_CONNECT_TCP,
    -@@ Documentation/userspace-api/landlock.rst: version, and only use the available subset of access rights:
    -         /* Removes LANDLOCK_SCOPE_* for ABI < 6 */
    -         ruleset_attr.scoped &= ~(LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET |
    -                                  LANDLOCK_SCOPE_SIGNAL);
    -+        __attribute__((fallthrough));
    -+    case 7:
    -+    case 8:
    -+        /* Removes LANDLOCK_ACCESS_FS_RESOLVE_UNIX for ABI < 9 */
    -+        ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_RESOLVE_UNIX;
    -     }
    + ## tools/testing/selftests/landlock/fs_test.c ##
    +@@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, execute_make)
    +  * only the blocked ones are logged.
    +  */
      
    - This enables the creation of an inclusive ruleset that will contain our rules.
    -@@ Documentation/userspace-api/landlock.rst: enforce Landlock rulesets across all threads of the calling process
    - using the ``LANDLOCK_RESTRICT_SELF_TSYNC`` flag passed to
    - sys_landlock_restrict_self().
    +-/* clang-format off */
    +-static const __u64 access_fs_16 =
    +-	LANDLOCK_ACCESS_FS_EXECUTE |
    +-	LANDLOCK_ACCESS_FS_WRITE_FILE |
    +-	LANDLOCK_ACCESS_FS_READ_FILE |
    +-	LANDLOCK_ACCESS_FS_READ_DIR |
    +-	LANDLOCK_ACCESS_FS_REMOVE_DIR |
    +-	LANDLOCK_ACCESS_FS_REMOVE_FILE |
    +-	LANDLOCK_ACCESS_FS_MAKE_CHAR |
    +-	LANDLOCK_ACCESS_FS_MAKE_DIR |
    +-	LANDLOCK_ACCESS_FS_MAKE_REG |
    +-	LANDLOCK_ACCESS_FS_MAKE_SOCK |
    +-	LANDLOCK_ACCESS_FS_MAKE_FIFO |
    +-	LANDLOCK_ACCESS_FS_MAKE_BLOCK |
    +-	LANDLOCK_ACCESS_FS_MAKE_SYM |
    +-	LANDLOCK_ACCESS_FS_REFER |
    +-	LANDLOCK_ACCESS_FS_TRUNCATE |
    +-	LANDLOCK_ACCESS_FS_IOCTL_DEV;
    +-/* clang-format on */
    +-
    + TEST_F(audit_layout1, execute_read)
    + {
    + 	struct audit_records records;
    +@@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, execute_read)
    + 	test_check_exec(_metadata, 0, file1_s1d1);
      
    -+Pathname UNIX sockets (ABI < 9)
    -+-------------------------------
    -+
    -+Starting with the Landlock ABI version 9, it is possible to restrict
    -+connections to pathname UNIX domain sockets (:manpage:`unix(7)`) using
    -+the new ``LANDLOCK_ACCESS_FS_RESOLVE_UNIX`` right.
    -+
    - .. _kernel_support:
    + 	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
    +-					      .handled_access_fs = access_fs_16,
    ++					      .handled_access_fs = ACCESS_ALL,
    + 				      });
    + 
    + 	/*
    +@@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, write_file)
    + 	struct audit_records records;
    + 
    + 	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
    +-					      .handled_access_fs = access_fs_16,
    ++					      .handled_access_fs = ACCESS_ALL,
    + 				      });
    + 
    + 	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
    +@@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, read_file)
    + 	struct audit_records records;
    + 
    + 	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
    +-					      .handled_access_fs = access_fs_16,
    ++					      .handled_access_fs = ACCESS_ALL,
    + 				      });
    + 
    + 	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
    +@@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, read_dir)
    + 	struct audit_records records;
    + 
    + 	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
    +-					      .handled_access_fs = access_fs_16,
    ++					      .handled_access_fs = ACCESS_ALL,
    + 				      });
    + 
    + 	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_DIRECTORY));
    +@@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, remove_dir)
    + 	EXPECT_EQ(0, unlink(file2_s1d3));
    + 
    + 	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
    +-					      .handled_access_fs = access_fs_16,
    ++					      .handled_access_fs = ACCESS_ALL,
    + 				      });
    + 
    + 	EXPECT_EQ(-1, rmdir(dir_s1d3));
    +@@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, remove_file)
    + 	struct audit_records records;
    + 
    + 	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
    +-					      .handled_access_fs = access_fs_16,
    ++					      .handled_access_fs = ACCESS_ALL,
    + 				      });
    + 
    + 	EXPECT_EQ(-1, unlink(file1_s1d3));
    +@@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, make_char)
    + 	EXPECT_EQ(0, unlink(file1_s1d3));
    + 
    + 	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
    +-					      .handled_access_fs = access_fs_16,
    ++					      .handled_access_fs = ACCESS_ALL,
    + 				      });
    + 
    + 	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFCHR | 0644, 0));
    +@@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, make_dir)
    + 	EXPECT_EQ(0, unlink(file1_s1d3));
    + 
    + 	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
    +-					      .handled_access_fs = access_fs_16,
    ++					      .handled_access_fs = ACCESS_ALL,
    + 				      });
    + 
    + 	EXPECT_EQ(-1, mkdir(file1_s1d3, 0755));
    +@@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, make_reg)
    + 	EXPECT_EQ(0, unlink(file1_s1d3));
    + 
    + 	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
    +-					      .handled_access_fs = access_fs_16,
    ++					      .handled_access_fs = ACCESS_ALL,
    + 				      });
    + 
    + 	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFREG | 0644, 0));
    +@@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, make_sock)
    + 	EXPECT_EQ(0, unlink(file1_s1d3));
    + 
    + 	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
    +-					      .handled_access_fs = access_fs_16,
    ++					      .handled_access_fs = ACCESS_ALL,
    + 				      });
    + 
    + 	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFSOCK | 0644, 0));
    +@@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, make_fifo)
    + 	EXPECT_EQ(0, unlink(file1_s1d3));
    + 
    + 	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
    +-					      .handled_access_fs = access_fs_16,
    ++					      .handled_access_fs = ACCESS_ALL,
    + 				      });
    + 
    + 	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFIFO | 0644, 0));
    +@@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, make_block)
    + 	EXPECT_EQ(0, unlink(file1_s1d3));
    + 
    + 	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
    +-					      .handled_access_fs = access_fs_16,
    ++					      .handled_access_fs = ACCESS_ALL,
    + 				      });
    + 
    + 	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFBLK | 0644, 0));
    +@@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, make_sym)
    + 	EXPECT_EQ(0, unlink(file1_s1d3));
    + 
    + 	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
    +-					      .handled_access_fs = access_fs_16,
    ++					      .handled_access_fs = ACCESS_ALL,
    + 				      });
    + 
    + 	EXPECT_EQ(-1, symlink("target", file1_s1d3));
    +@@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, refer_rename)
    + 	EXPECT_EQ(0, unlink(file1_s1d3));
    + 
    + 	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
    +-					      .handled_access_fs = access_fs_16,
    ++					      .handled_access_fs = ACCESS_ALL,
    + 				      });
    + 
    + 	EXPECT_EQ(EACCES, test_rename(file1_s1d2, file1_s2d3));
    +@@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, refer_exchange)
    + 	EXPECT_EQ(0, unlink(file1_s1d3));
    + 
    + 	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
    +-					      .handled_access_fs = access_fs_16,
    ++					      .handled_access_fs = ACCESS_ALL,
    + 				      });
    + 
    + 	/*
    +@@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, truncate)
    + 	struct audit_records records;
    + 
    + 	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
    +-					      .handled_access_fs = access_fs_16,
    ++					      .handled_access_fs = ACCESS_ALL,
    + 				      });
    + 
    + 	EXPECT_EQ(-1, truncate(file1_s1d3, 0));
    +@@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, ioctl_dev)
    + 	drop_access_rights(_metadata,
    + 			   &(struct landlock_ruleset_attr){
    + 				   .handled_access_fs =
    +-					   access_fs_16 &
    ++					   ACCESS_ALL &
    + 					   ~LANDLOCK_ACCESS_FS_READ_FILE,
    + 			   });
      
    - Kernel support
 5:  7c360d3c293f !  7:  66554c5b5b9c landlock/selftests: Test LANDLOCK_ACCESS_FS_RESOLVE_UNIX
    @@ Metadata
     Author: Günther Noack <gnoack3000@gmail.com>
     
      ## Commit message ##
    -    landlock/selftests: Test LANDLOCK_ACCESS_FS_RESOLVE_UNIX
    +    selftests/landlock: Test LANDLOCK_ACCESS_FS_RESOLVE_UNIX
     
         * Extract common helpers from an existing IOCTL test that
           also uses pathname unix(7) sockets.
    @@ tools/testing/selftests/landlock/fs_test.c: TEST_F_FORK(ioctl, handle_file_acces
     +		enforce_ruleset(_metadata, fd);
     +		EXPECT_EQ(0, close(fd));
     +	} else {
    -+		drop_access_rights(
    -+			_metadata,
    -+			&(struct landlock_ruleset_attr){
    -+				.handled_access_fs =
    -+					LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
    -+			});
    ++		struct landlock_ruleset_attr attr = {
    ++			.handled_access_fs = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
    ++		};
    ++		drop_access_rights(_metadata, &attr);
     +	}
     +}
     +
 6:  6ea15ea91990 !  8:  fab3d3d71215 landlock/selftests: Audit test for LANDLOCK_ACCESS_FS_RESOLVE_UNIX
    @@ Metadata
     Author: Günther Noack <gnoack3000@gmail.com>
     
      ## Commit message ##
    -    landlock/selftests: Audit test for LANDLOCK_ACCESS_FS_RESOLVE_UNIX
    +    selftests/landlock: Audit test for LANDLOCK_ACCESS_FS_RESOLVE_UNIX
     
         Add an audit test to check that Landlock denials from
         LANDLOCK_ACCESS_FS_RESOLVE_UNIX result in audit logs in the expected
    @@ Commit message
         Signed-off-by: Günther Noack <gnoack3000@gmail.com>
     
      ## tools/testing/selftests/landlock/fs_test.c ##
    -@@ tools/testing/selftests/landlock/fs_test.c: static const __u64 access_fs_16 =
    - 	LANDLOCK_ACCESS_FS_MAKE_SYM |
    - 	LANDLOCK_ACCESS_FS_REFER |
    - 	LANDLOCK_ACCESS_FS_TRUNCATE |
    --	LANDLOCK_ACCESS_FS_IOCTL_DEV;
    -+	LANDLOCK_ACCESS_FS_IOCTL_DEV |
    -+	LANDLOCK_ACCESS_FS_RESOLVE_UNIX;
    - /* clang-format on */
    - 
    - TEST_F(audit_layout1, execute_read)
     @@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, ioctl_dev)
      	EXPECT_EQ(1, records.domain);
      }
    @@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, ioctl_dev)
     +	if (!child_pid) {
     +		drop_access_rights(_metadata,
     +				   &(struct landlock_ruleset_attr){
    -+					   .handled_access_fs = access_fs_16,
    ++					   .handled_access_fs = ACCESS_ALL,
     +				   });
     +
     +		cli_fd = socket(AF_UNIX, SOCK_STREAM, 0);
 7:  0ada3dd8e1a1 !  9:  4e8a07344278 landlock/selftests: Check that coredump sockets stay unrestricted
    @@ Metadata
     Author: Günther Noack <gnoack3000@gmail.com>
     
      ## Commit message ##
    -    landlock/selftests: Check that coredump sockets stay unrestricted
    +    selftests/landlock: Check that coredump sockets stay unrestricted
     
         Even when a process is restricted with the new
    -    LANDLOCK_ACCESS_FS_RESOLVE_SOCKET right, the kernel can continue
    -    writing its coredump to the configured coredump socket.
    +    LANDLOCK_ACCESS_FS_RESOLVE_UNIX right, the kernel can continue writing
    +    its coredump to the configured coredump socket.
     
         In the test, we create a local server and rewire the system to write
         coredumps into it.  We then create a child process within a Landlock
    -    domain where LANDLOCK_ACCESS_FS_RESOLVE_SOCKET is restricted and make
    +    domain where LANDLOCK_ACCESS_FS_RESOLVE_UNIX is restricted and make
         the process crash.  The test uses SO_PEERCRED to check that the
         connecting client process is the expected one.
     
    @@ tools/testing/selftests/landlock/fs_test.c: TEST_F(scoped_domains, unix_seqpacke
     +	set_core_pattern(_metadata, core_pattern);
     +
     +	/* Restrict LANDLOCK_ACCESS_FS_RESOLVE_UNIX. */
    -+	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
    -+		.handled_access_fs = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
    -+	});
    ++	drop_access_rights(_metadata,
    ++			   &(struct landlock_ruleset_attr){
    ++				   .handled_access_fs =
    ++					   LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
    ++			   });
     +
     +	/* Fork a child that crashes. */
     +	child_pid = fork();
 8:  e9f591ec527f ! 10:  fcaef2882dbd landlock/selftests: fs_test: Simplify ruleset creation and enforcement
    @@ Metadata
     Author: Günther Noack <gnoack3000@gmail.com>
     
      ## Commit message ##
    -    landlock/selftests: fs_test: Simplify ruleset creation and enforcement
    +    selftests/landlock: fs_test: Simplify ruleset creation and enforcement
     
         * Add enforce_fs() for defining and enforcing a ruleset in one step
         * In some places, dropped "ASSERT_LE(0, fd)" checks after
    @@ tools/testing/selftests/landlock/fs_test.c: FIXTURE_TEARDOWN(scoped_domains)
     -		enforce_ruleset(_metadata, fd);
     -		EXPECT_EQ(0, close(fd));
     -	} else {
    --		drop_access_rights(
    --			_metadata,
    --			&(struct landlock_ruleset_attr){
    --				.handled_access_fs =
    --					LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
    --			});
    +-		struct landlock_ruleset_attr attr = {
    +-			.handled_access_fs = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
    +-		};
    +-		drop_access_rights(_metadata, &attr);
     -	}
     -}
     -
    @@ tools/testing/selftests/landlock/fs_test.c: TEST_F_FORK(coredump, socket_not_res
      	set_core_pattern(_metadata, core_pattern);
      
      	/* Restrict LANDLOCK_ACCESS_FS_RESOLVE_UNIX. */
    --	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
    --		.handled_access_fs = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
    --	});
    +-	drop_access_rights(_metadata,
    +-			   &(struct landlock_ruleset_attr){
    +-				   .handled_access_fs =
    +-					   LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
    +-			   });
     +	enforce_fs(_metadata, LANDLOCK_ACCESS_FS_RESOLVE_UNIX, NULL);
      
      	/* Fork a child that crashes. */
    @@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, execute_read)
      	test_check_exec(_metadata, 0, file1_s1d1);
      
     -	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
    --					      .handled_access_fs = access_fs_16,
    +-					      .handled_access_fs = ACCESS_ALL,
     -				      });
    -+	enforce_fs(_metadata, access_fs_16, NULL);
    ++	enforce_fs(_metadata, ACCESS_ALL, NULL);
      
      	/*
      	 * The only difference with the previous audit_layout1.execute_read test is
    @@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, write_file)
      	struct audit_records records;
      
     -	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
    --					      .handled_access_fs = access_fs_16,
    +-					      .handled_access_fs = ACCESS_ALL,
     -				      });
    -+	enforce_fs(_metadata, access_fs_16, NULL);
    ++	enforce_fs(_metadata, ACCESS_ALL, NULL);
      
      	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_WRONLY));
      	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
    @@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, read_file)
      	struct audit_records records;
      
     -	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
    --					      .handled_access_fs = access_fs_16,
    +-					      .handled_access_fs = ACCESS_ALL,
     -				      });
    -+	enforce_fs(_metadata, access_fs_16, NULL);
    ++	enforce_fs(_metadata, ACCESS_ALL, NULL);
      
      	EXPECT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
      	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.read_file",
    @@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, read_dir)
      	struct audit_records records;
      
     -	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
    --					      .handled_access_fs = access_fs_16,
    +-					      .handled_access_fs = ACCESS_ALL,
     -				      });
    -+	enforce_fs(_metadata, access_fs_16, NULL);
    ++	enforce_fs(_metadata, ACCESS_ALL, NULL);
      
      	EXPECT_EQ(EACCES, test_open(dir_s1d1, O_DIRECTORY));
      	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd, "fs\\.read_dir",
    @@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, remove_dir)
      	EXPECT_EQ(0, unlink(file2_s1d3));
      
     -	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
    --					      .handled_access_fs = access_fs_16,
    +-					      .handled_access_fs = ACCESS_ALL,
     -				      });
    -+	enforce_fs(_metadata, access_fs_16, NULL);
    ++	enforce_fs(_metadata, ACCESS_ALL, NULL);
      
      	EXPECT_EQ(-1, rmdir(dir_s1d3));
      	EXPECT_EQ(EACCES, errno);
    @@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, remove_file)
      	struct audit_records records;
      
     -	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
    --					      .handled_access_fs = access_fs_16,
    +-					      .handled_access_fs = ACCESS_ALL,
     -				      });
    -+	enforce_fs(_metadata, access_fs_16, NULL);
    ++	enforce_fs(_metadata, ACCESS_ALL, NULL);
      
      	EXPECT_EQ(-1, unlink(file1_s1d3));
      	EXPECT_EQ(EACCES, errno);
    @@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, make_char)
      	EXPECT_EQ(0, unlink(file1_s1d3));
      
     -	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
    --					      .handled_access_fs = access_fs_16,
    +-					      .handled_access_fs = ACCESS_ALL,
     -				      });
    -+	enforce_fs(_metadata, access_fs_16, NULL);
    ++	enforce_fs(_metadata, ACCESS_ALL, NULL);
      
      	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFCHR | 0644, 0));
      	EXPECT_EQ(EACCES, errno);
    @@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, make_dir)
      	EXPECT_EQ(0, unlink(file1_s1d3));
      
     -	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
    --					      .handled_access_fs = access_fs_16,
    +-					      .handled_access_fs = ACCESS_ALL,
     -				      });
    -+	enforce_fs(_metadata, access_fs_16, NULL);
    ++	enforce_fs(_metadata, ACCESS_ALL, NULL);
      
      	EXPECT_EQ(-1, mkdir(file1_s1d3, 0755));
      	EXPECT_EQ(EACCES, errno);
    @@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, make_reg)
      	EXPECT_EQ(0, unlink(file1_s1d3));
      
     -	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
    --					      .handled_access_fs = access_fs_16,
    +-					      .handled_access_fs = ACCESS_ALL,
     -				      });
    -+	enforce_fs(_metadata, access_fs_16, NULL);
    ++	enforce_fs(_metadata, ACCESS_ALL, NULL);
      
      	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFREG | 0644, 0));
      	EXPECT_EQ(EACCES, errno);
    @@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, make_sock)
      	EXPECT_EQ(0, unlink(file1_s1d3));
      
     -	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
    --					      .handled_access_fs = access_fs_16,
    +-					      .handled_access_fs = ACCESS_ALL,
     -				      });
    -+	enforce_fs(_metadata, access_fs_16, NULL);
    ++	enforce_fs(_metadata, ACCESS_ALL, NULL);
      
      	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFSOCK | 0644, 0));
      	EXPECT_EQ(EACCES, errno);
    @@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, make_fifo)
      	EXPECT_EQ(0, unlink(file1_s1d3));
      
     -	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
    --					      .handled_access_fs = access_fs_16,
    +-					      .handled_access_fs = ACCESS_ALL,
     -				      });
    -+	enforce_fs(_metadata, access_fs_16, NULL);
    ++	enforce_fs(_metadata, ACCESS_ALL, NULL);
      
      	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFIFO | 0644, 0));
      	EXPECT_EQ(EACCES, errno);
    @@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, make_block)
      	EXPECT_EQ(0, unlink(file1_s1d3));
      
     -	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
    --					      .handled_access_fs = access_fs_16,
    +-					      .handled_access_fs = ACCESS_ALL,
     -				      });
    -+	enforce_fs(_metadata, access_fs_16, NULL);
    ++	enforce_fs(_metadata, ACCESS_ALL, NULL);
      
      	EXPECT_EQ(-1, mknod(file1_s1d3, S_IFBLK | 0644, 0));
      	EXPECT_EQ(EACCES, errno);
    @@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, make_sym)
      	EXPECT_EQ(0, unlink(file1_s1d3));
      
     -	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
    --					      .handled_access_fs = access_fs_16,
    +-					      .handled_access_fs = ACCESS_ALL,
     -				      });
    -+	enforce_fs(_metadata, access_fs_16, NULL);
    ++	enforce_fs(_metadata, ACCESS_ALL, NULL);
      
      	EXPECT_EQ(-1, symlink("target", file1_s1d3));
      	EXPECT_EQ(EACCES, errno);
    @@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, refer_rename)
      	EXPECT_EQ(0, unlink(file1_s1d3));
      
     -	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
    --					      .handled_access_fs = access_fs_16,
    +-					      .handled_access_fs = ACCESS_ALL,
     -				      });
    -+	enforce_fs(_metadata, access_fs_16, NULL);
    ++	enforce_fs(_metadata, ACCESS_ALL, NULL);
      
      	EXPECT_EQ(EACCES, test_rename(file1_s1d2, file1_s2d3));
      	EXPECT_EQ(0, matches_log_fs(_metadata, self->audit_fd,
    @@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, refer_exchange
      	EXPECT_EQ(0, unlink(file1_s1d3));
      
     -	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
    --					      .handled_access_fs = access_fs_16,
    +-					      .handled_access_fs = ACCESS_ALL,
     -				      });
    -+	enforce_fs(_metadata, access_fs_16, NULL);
    ++	enforce_fs(_metadata, ACCESS_ALL, NULL);
      
      	/*
      	 * The only difference with the previous audit_layout1.refer_rename test is
    @@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, truncate)
      	struct audit_records records;
      
     -	drop_access_rights(_metadata, &(struct landlock_ruleset_attr){
    --					      .handled_access_fs = access_fs_16,
    +-					      .handled_access_fs = ACCESS_ALL,
     -				      });
    -+	enforce_fs(_metadata, access_fs_16, NULL);
    ++	enforce_fs(_metadata, ACCESS_ALL, NULL);
      
      	EXPECT_EQ(-1, truncate(file1_s1d3, 0));
      	EXPECT_EQ(EACCES, errno);
    @@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, ioctl_dev)
     -	drop_access_rights(_metadata,
     -			   &(struct landlock_ruleset_attr){
     -				   .handled_access_fs =
    --					   access_fs_16 &
    +-					   ACCESS_ALL &
     -					   ~LANDLOCK_ACCESS_FS_READ_FILE,
     -			   });
    -+	enforce_fs(_metadata, access_fs_16 & ~LANDLOCK_ACCESS_FS_READ_FILE,
    -+		   NULL);
    ++	enforce_fs(_metadata, ACCESS_ALL & ~LANDLOCK_ACCESS_FS_READ_FILE, NULL);
      
      	fd = open("/dev/null", O_RDONLY | O_CLOEXEC);
      	ASSERT_LE(0, fd);
    @@ tools/testing/selftests/landlock/fs_test.c: TEST_F(audit_layout1, resolve_unix)
      	if (!child_pid) {
     -		drop_access_rights(_metadata,
     -				   &(struct landlock_ruleset_attr){
    --					   .handled_access_fs = access_fs_16,
    +-					   .handled_access_fs = ACCESS_ALL,
     -				   });
    -+		enforce_fs(_metadata, access_fs_16, NULL);
    ++		enforce_fs(_metadata, ACCESS_ALL, NULL);
      
      		cli_fd = socket(AF_UNIX, SOCK_STREAM, 0);
      		ASSERT_LE(0, cli_fd);
 -:  ------------ > 11:  362a0e8f84a0 landlock: Document FS access right for pathname UNIX sockets
-- 
2.53.0


