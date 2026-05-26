Return-Path: <netdev+bounces-291715-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AI2vE3+sFWrgXgcAu9opvQ
	(envelope-from <netdev+bounces-291715-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:21:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8C45D75F0
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F38F3005581
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 14:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D506D3FD139;
	Tue, 26 May 2026 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7c2NITU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803053E92AB;
	Tue, 26 May 2026 14:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805307; cv=none; b=J9TRMbkzIbICY8dmqDEvv5ypsiAa9J5TCFyr5AjDgbbgqN0kBnvfyuollZB59K72dDRy8xDp4MoEyOM4YhgIX7AQplIW4X1zxneh+locxYFOoeeirVZAMUA8nnRYT6MWzL41QHKLf1X2CepzoJyHh1hofP5hx7HODpQ/gqjgZgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805307; c=relaxed/simple;
	bh=wOCsjv7zB/GSTdJ+8DcT8oe94QAYcvURVKGBFbOJiu0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Men5fiWlD1i6mPySz1f8gOSKO3QC2NmJy5kc6OtMBZEZ3aidNVrvfJP+NuIpX7IEm2hEA2gtz3Wqlx3F21VD1Q29n/A0UpOnh5VtuccRLzwq5f2I/C854YVjTg4AVKziAe3SwvNSoTjyE3PBfPuNXO2EB2/0GyWZTYe1hbbiU2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7c2NITU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6437A1F000E9;
	Tue, 26 May 2026 14:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779805306;
	bh=Nifp7Bt9N8SjAGtvS/Yc4zW9+M575ttZuBKZAZL5o9Q=;
	h=From:Subject:Date:To:Cc;
	b=K7c2NITUxtqUVD/EN5O1w/wm+SOSdoDJ+mZRYTpWRqjS7RbjRNh76nYz8ez3A73ZU
	 YykmRI7jxP6YhMTQ0QHm74NRCGgnkgnGZCXJGDZ7chYLeIfh3Mr/lxFtkr6xrkSB7c
	 ZPdGtFK00g/w88VXI4DrueOmkcklfbRVJzbd26mSFM4urEUrkicXA7TXVg9DPXKkg4
	 3jPa3vr0741n6yh7pT3rfT14fEx3G5muyVgI6c4M1oxK60N6x+DHp5XdeMn+k6Sm0p
	 GVw+9iIy3N6pq2kI+ukCGaQ7ggIPqY/bB5Twfe4Wqn2N24fbNeZ/gn2fTOPr7MJVJ5
	 R36YIuzAsAK9g==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH net-next v11 0/6] tls: receive-path fixes and clean-ups
Date: Tue, 26 May 2026 10:21:30 -0400
Message-Id: <20260526-tls-read-sock-v11-0-244fe1dc4abd@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XQzU7DMAwH8FeZciZgZ/nkxHsgDmnq0IitRUlVD
 U19d7JKaKWFo239/rZ8ZYVyosKeD1eWaUolDX0tEB8OLHS+fyee2tpgAoSGIxo+ngrP5FtehvD
 BPYAQwbVRaMWq+cwU02UJfGU9jbyny8je6qTxhXiTfR+6W97P7OnsU3+TXSrjkL+WSya5+H92T
 pID9w2C1RQ0QHwZsg8negzDeVk1qRUXcstV5UqCbSiSMkbuuF5zveW68thaaxpHJoLecbPmdst
 N5ai0sRJVGwPuuL1zuee2cqui08HUp8uw427N3Za7yo/1bvTeWPzjdQh3rxC3HqEGCONiUIAqA
 v0KmOf5G0S9YutSAgAA
X-Change-ID: 20260317-tls-read-sock-a0022c9df265
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>, 
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, 
 Alistair Francis <alistair.francis@wdc.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=5102;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=wOCsjv7zB/GSTdJ+8DcT8oe94QAYcvURVKGBFbOJiu0=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqFaxwGl2QIxDrVgO8f1r8erQoBnfTnmPUOBofS
 je+2D8brh+JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahWscAAKCRAzarMzb2Z/
 l645EAC8JiikzBB1BNYZ26Od7alWCqZfqwNlSsHL8knp/v8zFQfFF0EV26Rb4EzMyYZcr54NpGN
 +Ze0fGdnvqUtHdKG+dGUT0fVyHBGpqw8NlTdUV8oLVgXZGuw5leEKw2GAc+8zdVC4z8r1U0UpiC
 G1a7EpXhwQYm/cGmWHZl2T1YU0nh5WWFG09TleXN89Hm3wBbcQRysB2biif61lr4XnHJiKT/6a4
 uPYXRXO9ElnVM7ZK5Som/UAy5/gEmO+ipVoj59Y626wUD1vTG8C+nh4Jc1+3JFoxXZbbg55pqA4
 WQQXlpEiUzwMPTmytDPNNrIJsSXPsFJUtM7Fvo2uxojWxcOHga1xiS7m/lOJSykIthXDgl/NXUm
 hR6LVo1iJYwTAWlodRMYNYxsAqYPzFSFF70Tc5tdibB6VDmuooYcjBNqhR/AxTUq6+HpuOZz63d
 cVRMp6+ypgOFvm+EQGm8rGGAdGgCWMdrHczeqIxtft7lMLBcQQLqKBt+LQXbXUEv62DrgkHaT3p
 W0+hKVvWH/4RQbGegVMawBq1oCkBPSjxOKR3zVZO1VMuPjSq5GjClSFE7mqmGaG/q0IpMHA4FOB
 4w+YP08iZiNyS56zYUePWuvBSyKmKTttB+u7wWXaa4ykZ/8dycZQwYaFS4d4hhYpgmKytvtNhPm
 Kte141IiyQTtORQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291715-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,msgid.link:url,oracle.com:mid,oracle.com:email]
X-Rspamd-Queue-Id: 0E8C45D75F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'd like to encourage in-kernel kTLS consumers (NFSD, NVMe/TCP) to
coalesce on the use of read_sock. While auditing read_sock for that
purpose, Hannes and Sabrina flagged a few rough edges in the receive
paths.

This series is a set of clean-ups, not a performance series. Async
batch decryption and its submit/deliver scaffolding were dropped
during previous review: async_capable is always false for TLS 1.3,
the version NFSD and NVMe/TCP both require, so async-related
improvements were unreachable for the in-kernel consumers this
work targets.

A subsequent series will introduce infrastructure to support
KeyUpdate for in-kernel kTLS consumers, which need to handle TLS
Alert messages that trigger a tlshd upcall.

---
Changes since v11:
- 1/7 has been merged into net/main
- Rebased on net-next main (Fri May 22 18:40:51 2026 -0700)

Changes since v10:
- Move fixes to front of series
- Simplify loop termination in tls_sw_read_sock() (Sabrina)

Changes since v9:
- Recast cover letter: this is a clean-up series, not a
  performance series (Jakub, Sabrina)
- Rephrase subject to describe the refactor (Jakub)
- Split 2/5 into two patches separating the do/while
  loop-structure cleanup from the partial-consume fix (Sabrina)
- Continue the loop after a partial consume to match
  __tcp_read_sock() semantics, instead of exiting (Jakub)
- Drop kdoc on the internal function and rename
  tls_strp_msg_release() to tls_strp_msg_consume() (Jakub)
- Drop kdoc on tls_strp_check_rcv() and un-wrap the "Defer
  notification" comment (Jakub)
- Rename tls_strp_check_rcv() parameter wake to announce, and
  tls_rx_msg_ready() to tls_rx_msg_maybe_announce() (Jakub)
- Drop tls_rx_handoff(); fold the per-record path back into
  tls_rx_rec_done() and fire the deferred announce from
  tls_rx_reader_release() (Jakub)
- New patch: Preserve sk_err across recvmsg() when data has
  been copied, so a connection abort during sk_flush_backlog()
  surfaces on the next read instead of vanishing when the
  caller returns the bytes already accumulated

Changes since v8:
- Address review comments from sashiko
  - Patch 2: Requeue partially consumed skb to prevent leak
  - Patch 5: Re-check sk_err so RST during flush surfaces as
    -ECONNRESET instead of EOF
- Address review comments from gpt-5.5
  - Patch 4: Restore msg_ready early-return in tls_strp_check_rcv()
    so the queued strp_work doesn't double-wake the consumer
  - Patch 4: Add tls_strparser msg_announced bit so the recvmsg
    exit-point handoff doesn't re-fire saved_data_ready() for a
    record BH or the worker already announced (rx_list-only drain
    path)

Changes since v7:
- Rebased on net-next (v7.1-rc1)

Changes since v6:
- Rebased on net-next, v5's 1/6 was merged upstream

Changes since v5:
- Patch 6: Set released = true when sk_flush_backlog() returns
  true, so tls_strp_msg_load() knows the socket lock was
  released (Sabrina)
- Patch 6: Drop Fixes tag; submit bug fix separately via net
  if warranted (Sabrina)
- Patch 6: Note redundant flush on cold path in commit message
  (Sabrina)

Changes since v4:
- Drop batch async decryption and submit/deliver restructure:
  async_capable is always false for TLS 1.3, so the new code
  was unreachable for NFS and NVMe/TCP
- Purge async_hold directly in tls_decrypt_async_wait() and drop
  the tls_decrypt_async_drain() wrapper
- Merge tls_strp_check_rcv_quiet() into tls_strp_check_rcv() with
  a bool wake parameter; fix lost wakeup on the recvmsg exit path

Changes since v3:
- Clarify why tls_decrypt_async_drain() is separate from _wait()
- Fold tls_err_abort() into tls_rx_one_record(), drop tls_rx_decrypt_record()
- Move backlog flush into tls_rx_rec_wait() so all RX paths benefit

Changes since v2:
- Fix short read self tests

Changes since v1:
- Add C11 reference
- Extend data_ready reduction to recvmsg and splice
- Restructure read_sock and recvmsg using shared helpers

---
Changes in v11:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v10: https://patch.msgid.link/20260511-tls-read-sock-v10-0-279fc5015f0e@oracle.com

---
Chuck Lever (6):
      tls: Avoid evaluating freed skb in tls_sw_read_sock() loop
      tls: Re-present partially-consumed records in tls_sw_read_sock()
      tls: Move decrypt-failure abort into tls_rx_one_record()
      tls: Factor tls_strp_msg_consume() from tls_strp_msg_done()
      tls: Suppress spurious saved_data_ready on all receive paths
      tls: Flush backlog before waiting for a new record

 include/net/tls.h  |  5 +++++
 net/tls/tls.h      |  6 ++---
 net/tls/tls_main.c |  2 +-
 net/tls/tls_strp.c | 26 +++++++++++++++-------
 net/tls/tls_sw.c   | 64 ++++++++++++++++++++++++++++++++++++++----------------
 5 files changed, 72 insertions(+), 31 deletions(-)
---
base-commit: c0aa5f13826dcb035bec3d6b252e6b2020fa5f88
change-id: 20260317-tls-read-sock-a0022c9df265

Best regards,
--  
Chuck Lever <chuck.lever@oracle.com>


