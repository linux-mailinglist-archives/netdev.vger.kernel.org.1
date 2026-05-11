Return-Path: <netdev+bounces-286853-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2C3XDpplAmqZsQEAu9opvQ
	(envelope-from <netdev+bounces-286853-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:26:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A964151742A
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 187EF301829C
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 23:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8776362128;
	Mon, 11 May 2026 23:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUfMD5mn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39FD356748;
	Mon, 11 May 2026 23:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778541971; cv=none; b=Ob0gHzW0ILEU2zJ2/MmuMfn+FzcFp8d1YYS7EqK5ECpGX9kKV1yDND+DHUiW2EpojMcdGZ2j7KeLIF9mH2hPAV05WdoOtT053zj15pglr2hRaomINMZM+Q5aRfTT1XMfhUa6kvRDakRdhWw2S2UTK/GP06geA3vcjUKMAOsdz8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778541971; c=relaxed/simple;
	bh=+cQ06wfLtp5MdpMNxWXmZ5hci/tiMAe6JpHcxibvJ94=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F2Uj7IpXw0DkMt+UNsRW7/Q3K+/wtGbjR1av/VjsPconOaiKY30qRPUahSMJkJ6HrgD/zFB2sxqkIIaVuTjv+bBa1Km81zMtGcNDmBHZK680sFEwAZD7scbuo7dlYGvS8u0VhXzwT90JwCw+sGeg8E/nZY0Ra1qPwbu/xAyNb4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUfMD5mn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 843A2C2BCB0;
	Mon, 11 May 2026 23:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778541971;
	bh=+cQ06wfLtp5MdpMNxWXmZ5hci/tiMAe6JpHcxibvJ94=;
	h=From:Subject:Date:To:Cc:From;
	b=PUfMD5mngaZKNkelWkYvIxMrcUbJN1pNS0NGbvHU9rtNMLNvTeyVoiBz9nBVqt/rl
	 gYCylpd11fzSbvtxRSlTWPkJQDH0cm6C1q93lRB+Pg98g8eaQXMbVoVmkdlMLhv1sz
	 DbOBvwIAs2Z/9qCvqW+CY1mls6DjmTMQyhAIYjtF5V0eGsKIiLhKGRWM+kvM1bd1dn
	 ySD0P/uPywWh6wXAG8vcsGrzkUxUd9P5DInnWtRPYRKAAYmmaUnpgo77kv9yYiQszs
	 vOnT0s3wQZf69+kKypJxWQcGgymrHQp67jOXL+W8s60mDsn9J/E2QmWvJj2Rp4NbMb
	 zyy1UwKobpUnw==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH net-next v10 0/7] tls: receive-path fixes and clean-ups
Date: Mon, 11 May 2026 19:25:51 -0400
Message-Id: <20260511-tls-read-sock-v10-0-279fc5015f0e@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XQzWrDMAwH8FcpPs+b7Ppzp73H2MFx5NWsdYodQ
 kfJu08NjIWEHSXxk8T/zhrWjI29Hu6s4pRbHgoVAp4OLJ5C+USee2owCdLAUVg+nhuvGHrehvj
 FA4CU0fdJGs3IXCumfFsWvrOCIy94G9kHTbrQkHc1lHh67PudvVxCLg95ym0c6vfyyaQW/8/NS
 XHgoRPgDEYDkN6GGuIZn+NwWU5NesWl2nJNXCtwHSbU1qodN2tuttwQT71ztvNoE5gdt2vuttw
 SF9pYp4TuUxQ77v642nNH3OnkTbQUuoo77tfcb7knfqS/RQjWiU108zz/AGk5Er8RAgAA
X-Change-ID: 20260317-tls-read-sock-a0022c9df265
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>, 
 Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Alistair Francis <alistair.francis@wdc.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=4691;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=+cQ06wfLtp5MdpMNxWXmZ5hci/tiMAe6JpHcxibvJ94=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqAmWFF70aB8VhaOmd8Ke0RDe7CTdHYdx6kzmab
 UuCjd0cEQyJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagJlhQAKCRAzarMzb2Z/
 l0kLD/9S832Nf8Fg+iu4jx7Bi0g+BDa3JoVM3ZAQxH2YqqndPjDvWkLFpHVvSXvAoTlzibvGiEv
 Bsntts16XSpPJf+8RSxgazgURLkZIpHDXTdgpbOaSZnePA7f+vp3X5IVQ4lDG/KX3nObHH300Rc
 7/5vlZ3fn4sFin89f56b9pXRao6lvAsBO/KS2DRcFQ4TjQw6uWV9MKo9UBXM5J8zzJu0mjSM4It
 bQWozgIZYnJXox2aU/JwperDVzOo1iW/NHN04V3UKCrB0w9CRHPheXR/DDlsXQaSccrbmWMYw0U
 KFNp/X4aU9EqK6/MTT0vtVnMhTssiXAHbEzlAjoPhh29Xs9GtTsx9is4ouwY4XJOYS/U1htL/+w
 7tvb8uYaE+YWpZwVJxsHjvhC6jTxSptsV1IjeixoqvSXThRNVvFFdYOeC3LfYbQ01OB4hVbsKll
 YfEXP25BfKBMYQO4r94icRLyDKzqVL8jJsFLqRHax+x/5t+dEOOhvehcIuNUOrnTTK4KnjCj9Nz
 HeH/H+yq51GXM+LhOxo2vkP6dLWuiciECso7s++2P4xYev6127+lgVtqb+bqlmle9E0CPjMvfhL
 qbf+JJ++uVSk+bkWXuswkn7GnWVkspFZ9bjYH/aBD4uPxZy2UIMCFu+xPnL7efFzRi4uFRsVfwp
 b/nBJSBNeVS9WxA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: A964151742A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286853-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email,oracle.com:mid]
X-Rspamd-Action: no action

I'd like to encourage in-kernel kTLS consumers (NFSD, NVMe/TCP) to
coalesce on the use of read_sock. While auditing read_sock for that
purpose, Hannes flagged a few rough edges in the receive paths.

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
Chuck Lever (7):
      tls: Move decrypt-failure abort into tls_rx_one_record()
      tls: Avoid evaluating freed skb in tls_sw_read_sock() loop
      tls: Re-present partially-consumed records in tls_sw_read_sock()
      tls: Factor tls_strp_msg_consume() from tls_strp_msg_done()
      tls: Suppress spurious saved_data_ready on all receive paths
      tls: Flush backlog before waiting for a new record
      tls: Preserve sk_err across recvmsg() when data has been copied

 include/net/tls.h  |   5 +++
 net/tls/tls.h      |   6 ++--
 net/tls/tls_main.c |   2 +-
 net/tls/tls_strp.c |  26 +++++++++-----
 net/tls/tls_sw.c   | 103 ++++++++++++++++++++++++++++++++++++++++-------------
 5 files changed, 105 insertions(+), 37 deletions(-)
---
base-commit: 63751099502d10f0aa6bb35273e56c5800cc4e3a
change-id: 20260317-tls-read-sock-a0022c9df265

Best regards,
--  
Chuck Lever <chuck.lever@oracle.com>


