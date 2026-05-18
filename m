Return-Path: <netdev+bounces-289144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UA5QEG5aC2oCGAUAu9opvQ
	(envelope-from <netdev+bounces-289144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 20:29:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF39557241E
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 20:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C9B9303ACDF
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 18:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D84382383;
	Mon, 18 May 2026 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vH7rhVM+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1F1625;
	Mon, 18 May 2026 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779128694; cv=none; b=idL8553o4SeRx/Llvjj+HX5ZfT1v0dyqdE2aPia8UuZWNDH2JTrGEilWrdEomjwH4GaxDkenpZ0oREqvQj5mO/pMXtPnBwrQtOpthTS3tgdlIsj222bPlxWHNv/dzp5p/HxwUX+3Pq4DkC1RXLEuUUCKtIbVvwpUX8DOnjGW5II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779128694; c=relaxed/simple;
	bh=ICq74QYSGfn+DbiH3jetJoVA4QqCjQcEg51Lvf7bhyU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QQ5ZB5KW8VguujErj0jNiCCDfhCQwQ2MD35YU4MlCgKi9bbeBdXkZrbw5cUGxrGVEiEtJKqkT+N6HZ8vRuGTN3lzzVe26w2+Zvgd87dOWXKqjUSG+YL77XD8ErRN8Id7ytLefuLcV//bCf9RPjptsE4SkElAulsBVEuu9zEz59Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vH7rhVM+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A22C2BCB7;
	Mon, 18 May 2026 18:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779128694;
	bh=ICq74QYSGfn+DbiH3jetJoVA4QqCjQcEg51Lvf7bhyU=;
	h=From:Subject:Date:To:Cc:From;
	b=vH7rhVM+5k4PPeXUnaPQ0XdMbzFvEcDU8zaKAM4cNYJVUIc46N6zKHCXql5CYZ6mx
	 7/oiK8zdpqHPBHG+VazNJsJl1WKGYrUuSjvt2I6kCeEG5KC4b6iSaTLvfcLxqRnbbF
	 GgIWEdNxdh3PsHfRaq8NHiXnQB8aSAPFP/BsHFrvmBCXTR+iYuBgjwkrqh9vmEuR+y
	 +yXVlT8YPAR2KswIEaO7SAJb3jmpC2mcbC2hkrSPL/4H1+e0B+AoKpFZvjPRBp3/ma
	 jPjt2Ygz6JKvsmhR92jrDlFFy3ImgN0iBlzmBr9ZRv+3aDjRfrgLVBgVH/aCEMsmrz
	 p3DD5xKO831wA==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH net 0/7] net/handshake: anchor request lifetime to a pinned
 file reference
Date: Mon, 18 May 2026 14:24:27 -0400
Message-Id: <20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMywrCMBBFf6XM2mAepKC/Ii6SdGLGx1gyVYTSf
 zfR5Tmce1cQrIQCx2GFim8SenIDsxsglcAXVDQ1BqvtqL0ZVZOTlHBDlemOaiZW1riDzj47bxy
 04Vwx0+d3egLGBc5/Ka94xbT0u57FIKhiDZxKVy3cPwIxbNsXXPE4i5YAAAA=
X-Change-ID: 20260516-handshake-file-pin-21390f5f3513
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>, 
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org, 
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=3571;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=ICq74QYSGfn+DbiH3jetJoVA4QqCjQcEg51Lvf7bhyU=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqC1lssaawL1jX/ZeYbto+ndmc5xzOZnkE+97P/
 GBB0re55JuJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagtZbAAKCRAzarMzb2Z/
 l61kD/oCelse4nGqq4sw249opZri7bPOzwkmp87vrC1+Ua+0aN3EQykm1gWsY7vh1ou9IEGO3oO
 Tkf6VPg5/noh0gSWAjZzNDHVKo7n591L1n4kTsC632jBXIjsjNH6Yr9Bl21WZ+oFij6PbV/DRUR
 6tYXZTlFpi9DU7TLuPqRY2Oih4eS0GaOZfKEsSahd2C6mxm2GHnnQQf9LG81uaTKpTEBCd9W2Iv
 nhIWsjT2MY2WsK/0RqT4eZsBSgKXLYU0J+6/fYNhdk/JLNbiE5NV+dlPuw+esXoFWxbunDkPiAd
 d56SkY8Vv230IkBUWqmArrcOx8uiPUlvz5bcM43kLHKhygfEuihZGiztVafAMlcwpyh+GIwDIK0
 xgaJtD41N9lvhaSAlUPqpq9WCNr+oOGsFwyy+ZoMPrvVXtbIrz4Si9I0q9+XOc0KztKm7SUJazV
 r+bJtm95G4PFqpS873nqQ+JXYpbVbAxvz0oOWQrdZrRFQ0tto9lYXdG4qVHeFuYfSYojF75pXFF
 CNY9ufLLtmS5SyFOPVRrjdY/m2BFok3ykNzgEQVmH23pPvMTWtwRuPTjiR4hkMpWKVREKlXGzPK
 K/3JcLbaMUqnFR23zFh05ABORhj5MZLuIrRM/JkCpnOpQF4LjZ0qGvAxg5dlwUqnIJzfWt3Uc4Q
 cRYS8JLCha7Owwg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-289144-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Queue-Id: AF39557241E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

handshake_nl_accept_doit() has accumulated four follow-on fixes
since 3b3009ea8abb ("net/handshake: Create a NETLINK service for
handling handshake requests"): 7ea9c1ec66bc, 7798b59409c3,
fe67b063f687, and dabac51b8102.  Each was a local refcount or
NULL-check correction; none moved where the file reference is
owned, and the same code keeps producing the same class of bug.
Reworking the ownership is what breaks the pattern.

For the duration of a request, sock->file has no single owner.
Submit publishes the request without taking a file reference;
accept_doit acquires one inside the handler, after the request
has already left the pending list.  The consumer can drop its
own reference at any time, including the moment between
handshake_req_next() popping the request and accept_doit
reaching get_file().  The submit-side sock_hold() pins only
struct sock; struct socket and sock->file remain under the
consumer's control via the file descriptor.

This series places the file reference under unambiguous
ownership.  handshake_req_submit() pins it on the request and
completion or cancel drops it (patches 4-5); the submit-side
sock_hold() then becomes redundant, and dropping it also closes
a publish-before-pin race the late sock_hold itself opened
(patch 6).  Patch 3 normalizes the errno sign convention across
the handshake_complete() API and its consumers, and patch 2 is
the matching correction in nvme-tcp.  Patch 1 fixes an unrelated
netns-exit leak.  Patch 7 adds KUnit file-count assertions to
verify the new refcount contract.

Three things in this restructuring want a careful look.  In
handshake_complete(), the fput() of the request's file
reference has to come after hp_done() and after the sock_put()
that may free sk -- fput() can transitively run
handshake_sk_destruct() and free the request, so the patch
stashes hr_file in a local first.  handshake_sk_destruct()
itself is kept on purpose: it owns rhashtable removal and
kfree, and remains the backstop if a consumer path bypasses
handshake_complete() entirely.  Third, handshake_req_next() now
returns its request with an extra get_file() held under
hn_lock; accept_doit must consume that reference (FD_PREPARE on
success, explicit fput on the fdf.err path), and any future
caller has to honor the same contract.

Patches 1, 3, 5, and 6 carry Fixes: 3b3009ea8abb and should
travel to stable together.  Patch 2 carries Fixes: be8e82caa685.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

---
Chuck Lever (7):
      net/handshake: Drain pending requests at net namespace exit
      nvme-tcp: store negative errno in queue->tls_err
      net/handshake: Pass negative errno through handshake_complete()
      net/handshake: Take a long-lived file reference at submit
      net/handshake: hand off the pinned file reference to accept_doit
      net/handshake: Close the submit-side sock_hold race
      net/handshake: Verify file-reference balance in submit paths

 drivers/nvme/host/tcp.c        |  2 +-
 net/handshake/handshake-test.c | 38 +++++++++++++++++++++++++++++++-
 net/handshake/handshake.h      |  6 +++--
 net/handshake/netlink.c        | 26 ++++++++++------------
 net/handshake/request.c        | 50 ++++++++++++++++++++++++++++++++++--------
 net/handshake/tlshd.c          |  4 ++--
 6 files changed, 96 insertions(+), 30 deletions(-)
---
base-commit: f5b2772d14884f4be9e718644f1203d4d0e6f0d6
change-id: 20260516-handshake-file-pin-21390f5f3513

Best regards,
--  
Chuck Lever <chuck.lever@oracle.com>


