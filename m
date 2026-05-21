Return-Path: <netdev+bounces-290506-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFPAJLMrD2q3HQYAu9opvQ
	(envelope-from <netdev+bounces-290506-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:58:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EA45A8CB6
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A1853110923
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C5036F8FF;
	Thu, 21 May 2026 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZRSHdU9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76881370D5E;
	Thu, 21 May 2026 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374842; cv=none; b=K1A/6vWsBDL65GuyhyDGNIKX3rjqdpMyF+BHeLIG0dH6JJ6tK/Vh+MlCf9icMkN2oLSC+KQwLQSmZZwgSnJiniKw+ZLxVkFXHQXfO5/qZ8xUasyCc6HvPVOUTGEFJNKUEQzWJ+N7SHxXQBn6TzQvNE7ApZuM9kmMedDgNfGsThg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374842; c=relaxed/simple;
	bh=4tDM0iQVz/CyzfICFtw2BvtzDMiZSvmMCgLfoFd3Qho=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HUQLPb+EZsifZyZeDXNt1kzLCbnmtv7Qyl4y4yH3y8pjzhGIgJiNvjeTT2dMrUfT8FSVqlI/EKkL/a1ihv2b4LacxOAtXKTKvzsCxeNlVO2UKSNcOIt0nVTi9E+KdnPnVrADU9GkoALvBZ1T89SWae5wcV1l8qYS4GA9FkN2Tvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZRSHdU9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281331F000E9;
	Thu, 21 May 2026 14:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374841;
	bh=fH2SpemoXvJlgvEPFyN/jTDszhD95Yl9eAEB5XMDBJ4=;
	h=From:Subject:Date:To:Cc;
	b=bZRSHdU9XRb/JgMsQmWUMaMjTs9VSzOwvmHXd3oJl4taX46TJjZIY+A+8RanP30Dn
	 zTxg4Nicy+w4b37HUp7rS6iC0BMul3GGKbI1ust2WrerX36VY9fMIN9TRZYmz2AraJ
	 d7coIwOjRzqjmvDaJxSeh62yNm6UNdm87oEmjf1N8Aq+qTvs3kaJ3nY/dVFmjUpNAP
	 2tPgMPonRHmLhabGmKXePDmeoip1OhViwmSlbYNJ2x/qEhqGBUnyR4EZAVC+jNeo32
	 aZ0CQQjHudxJ2U2XIZbIbfjZq0Sq9GMlNKNu9gkdj2Pko2qm7qp+lRXp1zY4O7oy3y
	 xBbR2ZevVekqA==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH net v2 0/7] net/handshake: anchor request lifetime to a
 pinned file reference
Date: Thu, 21 May 2026 10:47:06 -0400
Message-Id: <20260521-handshake-file-pin-v2-0-b9dadc472840@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Oyw6CMBBFf4XM2iotgo+V/2FYtGVqR6ElLRIN4
 d8t6NLlvXPn5EwQMRBGOGcTBBwpkncpiE0G2kp3Q0ZNyiByUeUlr1gqm2jlA5mhFllPjglenHJ
 TmqLkBaTHPqCh1wq9gsMB6m8Zn+qOelhwy0zJiEwF6bRdqjTcdZLccrIUBx/eq9XIV85P4PhPY
 OQsZ3ultDpgJUwjLz5I3eJW+w7qeZ4/nQ1CQOcAAAA=
X-Change-ID: 20260516-handshake-file-pin-21390f5f3513
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Chris Mason <clm@meta.com>, Christian Brauner <brauner@kernel.org>, 
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org, 
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, 
 Hannes Reinecke <hare@kernel.org>, 
 Alistair Francis <alistair.francis@wdc.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=3768;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=4tDM0iQVz/CyzfICFtw2BvtzDMiZSvmMCgLfoFd3Qho=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqDxru74wmZ1hPJSsB7z0UzzxM4pcWKdGRouxfQ
 4xf3xqQ0HKJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCag8a7gAKCRAzarMzb2Z/
 l5lrD/94B2E3+YLi84PAnO3Xy5EKOgN9uVEQS0np047cRFcMV/DHPjZCJl9BAnF/+0RqgFZVauD
 qa18arIp3nLIl350HhbzUmE9NfZgFHpDhueJGzHAJkrd8an+QmOMR6dzDN4G+C6wQ/PNzGoBZf4
 UbeBtJ2GPNpWLFNx7b9VuaELAdL3RtrcwHQxA0Nevpey4Pj2jeRFHf/fim7VuJi8nMBBoAJPsJs
 7L+gKp11eXXfiGycfNWFqF58NFnOdtlIymOEw9amBbF7LeCU6ECk+FCv1xVKxHvwf57/QTzT3dT
 u7XFgA1fMg2DzT5SALAfTw43ezo78pX0XDi3PEiGC1/T9kjE/26etr6TtB8RN0aVPcCggz3zyik
 8y3eOxCoFQG2yKuF2rmA/xhhJ+eFQ2nW4nPW/DNcgnG9mAYis8uQ3mXIY+Ae1rpFUNDz9+PIP7z
 0n/0Q5ZKUUaWxo4wZa5hdPfnlOkoJ//Qt0AzoYM2gKFulugzup6MtOLRTufMC40YoI35oJKc0Nw
 d9TD7Seapz3tXk9BKSZvS7Zcu8etLqKjT9tymxnz1WH90xh8ZLOQIy9gENAvZUycoHo99BpG9Eq
 pPbTyalIPsrkueJbyIB5ZgLnqP5b8p6/Ut5vk9WBqV8mzcy85GIKAFS6huGjgvP9jmCjQ0slUyc
 QqfRe0GIC32GvBQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290506-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: B5EA45A8CB6
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
(patch 6).  The handshake_complete() API and its consumers move
to a uniform negative-errno sign convention (patch 3), with the
matching sign correction in nvme-tcp (patch 2).  An unrelated
netns-exit leak gets its own fix (patch 1), and new KUnit
file-count assertions verify the refcount contract (patch 7).

Three things in this restructuring want a careful look.  In
handshake_complete(), the fput() of the request's file
reference has to come after hp_done() -- fput() can transitively
run handshake_sk_destruct() and free the request, so the patch
stashes hr_file in a local first.  handshake_sk_destruct()
itself is kept on purpose: it owns rhashtable removal and
kfree, and remains the backstop if a consumer path bypasses
handshake_complete() entirely.  Third, handshake_req_next() now
returns its request with an extra get_file() held under
hn_lock; accept_doit must consume that reference (FD_PREPARE on
success, explicit fput on the fdf.err path), and any future
caller has to honor the same contract.

---
Changes in v2:
- Patch 3: move HANDSHAKE_A_DONE_STATUS upper bound into netlink policy (Jakub)
- Link to v1: https://patch.msgid.link/20260518-handshake-file-pin-v1-0-4bbcb7e62fda@oracle.com

---
Chuck Lever (7):
      net/handshake: Drain pending requests at net namespace exit
      nvme-tcp: store negative errno in queue->tls_err
      net/handshake: Pass negative errno through handshake_complete()
      net/handshake: Take a long-lived file reference at submit
      net/handshake: hand off the pinned file reference to accept_doit
      net/handshake: Close the submit-side sock_hold race
      net/handshake: Verify file-reference balance in submit paths

 Documentation/netlink/specs/handshake.yaml |  8 +++++
 drivers/nvme/host/tcp.c                    |  2 +-
 net/handshake/genl.c                       |  3 +-
 net/handshake/genl.h                       |  1 +
 net/handshake/handshake-test.c             | 38 ++++++++++++++++++++++-
 net/handshake/handshake.h                  |  6 ++--
 net/handshake/netlink.c                    | 19 +++---------
 net/handshake/request.c                    | 50 ++++++++++++++++++++++++------
 net/handshake/tlshd.c                      |  4 +--
 9 files changed, 101 insertions(+), 30 deletions(-)
---
base-commit: 42734af6632ebebf90552f0e2dce4d8e72dbb9be
change-id: 20260516-handshake-file-pin-21390f5f3513

Best regards,
--  
Chuck Lever <chuck.lever@oracle.com>


