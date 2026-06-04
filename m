Return-Path: <netdev+bounces-295375-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8osqOoa6IWrNMgEAu9opvQ
	(envelope-from <netdev+bounces-295375-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 19:48:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8D2642642
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 19:48:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hhQDRTeB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295375-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295375-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 21731301AA5E
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 17:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC7E4CA276;
	Thu,  4 Jun 2026 17:48:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE91A35B650;
	Thu,  4 Jun 2026 17:48:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780595322; cv=none; b=GHWa5ee9lEOtet9pDvvhl7EbPZQGsYzmRvKTPFUJnk72rBFe3ejZ8efZis9TJexn+gqHBW/ZMFByMIrg3Kzk+2nsxBu0UCplohKmNwE5j7o28QGmk1cp11aaeAaQ1wDJ6BnxTjcHbD0QYul62RT83Hzpsnih4j3bJUNBSjpJNU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780595322; c=relaxed/simple;
	bh=VXT/p5gwqEh8hm9n/NOS3Cv+n3pR3UsotOyh/mQ3u8w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JGw0DR2lHvlNI3wITCpZ71gV2WsqDQnvf8Nsed+mQooL4eVHvwXw0rbE6RWyOPc2be9aMRM/tQ0p2hkf2jjLRGhc89De7LkxtwN30WdPhoYWsK/hpYEEbzWOiiQv05nBoZ8JDVJ5cYhklZrnVqvgpuVRZu3jcSNIBPtvGeVd7Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhQDRTeB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175621F00893;
	Thu,  4 Jun 2026 17:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780595320;
	bh=jqNqmB8Vze/oRK0XQ4iGEwQ2KUXxneapSE3/zn6cz9I=;
	h=From:Subject:Date:To:Cc;
	b=hhQDRTeBe4UCe3PptOXYxF/pzIt4Cx9Uz7PBfFobUN6gWYVQjRERRo4sVYXyj68e5
	 Cig89hwiIS3zivMXdanZONF5DEDHOdR1mB9fm5nTqJ1G0aM7FHZP/18FwBuc5qyFhR
	 Um9MAYJ1TwvWvdJEwZl97ZiXH4r1oyJ6SdkLtNIrNA7yGL+O7zFOUsxdpQHkYFxiSd
	 bSKW5X1xuTqyav3yUQkKLMcaWlIxxqetbe60JVzDk7JdkBHMEQ+iA6CB/quFWV7oCh
	 MKPl73H239uGsoFFZt6DHqB5dRB9pQIrhSr7dgJX/z6aq0n3zEsdUjpiwMZRsD23wK
	 PXOJEA8E3z8QQ==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH net-next v12 0/6] tls: receive-path fixes and clean-ups
Date: Thu, 04 Jun 2026 13:48:23 -0400
Message-Id: <20260604-tls-read-sock-v12-0-b114efa6e3e2@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XQzU4DIRDA8VdpOIvOUD49+R7GAwuD3djuGthsa
 pq+u3QT03XRI5Dff8hcWKHcU2HPuwvLNPelH4d6QPGwY+Hgh3fifawXTIDQsEfDp2PhmXzkZQw
 f3AMIEVxMQitWzWem1J+X4CsbaOIDnSf2Vl86X4h32Q/hcOv9vD2dfD/c5KEv05i/lp/McvH/z
 JwlB+47BKspaID0MmYfjvQYxtMyalYrLuSWq8qVBNtRImWMbLhec73luvIUrTWdI5NAN9ysud1
 yUzkqbaxEFVPAhts7ly23lVuVnA6mLl2Ghrs1d1vuKt/Xf6P3xuIfq0O4e4W49Qg1IIxLQQGqB
 NQGcBVot1eTNSBlIoxB+i7+Clyv129T6GIbkwIAAA==
X-Change-ID: 20260317-tls-read-sock-a0022c9df265
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>, 
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>, 
 Hannes Reinecke <hare@suse.de>, Alistair Francis <alistair.francis@wdc.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=5123;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=VXT/p5gwqEh8hm9n/NOS3Cv+n3pR3UsotOyh/mQ3u8w=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqIbptFnLPsQ1v5jGNCOezIfq3Atz1ZOaF7mm29
 Wak+IUbM6OJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaiG6bQAKCRAzarMzb2Z/
 l/5xD/4xusTaz6LW0QnI1sMO8TWXGVI3BarG0Qk5VzshZxq27/zbyE8my3iscBrptCkWLUA6Fr7
 qDyKBufkwfxXipsBXTbjdU9FbTj+IJ9KfuXRSCjG/Hu/DQgwwp42tuHRFMCWrhxWsfbsZDF7uG9
 xcqQ9JBvVua5NHf6zPVGK1v+sdqZfjAA8Mt59XUrnHGf05oFjQfs6ycA79EPhbh9dPFypaDkeYi
 lNdyH1o6es0rZ/HfFd/zak8hjXfklPvEI/NxYEDlqrVYUA2LdTWfXAcKJW6mOV8fQwYbCV1LGIO
 a78Uc6P5Ngi2b1VWGW77C1qzPAyN8bRaAvFUtcAKfaSsGlsX5jHHhN8qzHcxS3Aqk5aIW9c9aoZ
 a5CyogOrpYwI22K05pWypWxOJ5KIkkKahnoZDEMkRg5r9iVF4N5/Wek4FduQG2wT5OIeZHSbTKs
 hFiqoJZaoSoTLRN3Ek7KnzAVoU8hyfFdYPMsBIv8vIUcJwkklpMMXrgTejJYrt6q5bvzb2x6PJa
 nlimbkDlaIIlXN9U1I3enuyV0A+XeIvDlAbmBVr+Ma0r9W8YUGVwpdNvZYmcr+IOKo2sG4CYY/w
 T+Z71nCO5h4Pzk1E/rhwfSYkzLSh+1Tmcc+AQEpV4InNAaP2sCpwVyeCFhFLxgZbdAdQ0+oAG5p
 goFcAsrKBAHlorg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:john.fastabend@gmail.com,m:kuba@kernel.org,m:sd@queasysnail.net,m:edumazet@google.com,m:horms@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:kernel-tls-handshake@lists.linux.dev,m:chuck.lever@oracle.com,m:sagi@grimberg.me,m:hare@kernel.org,m:hare@suse.de,m:alistair.francis@wdc.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-295375-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A8D2642642

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
- Rebased on net-next main (Thu Jun 4 09:33:24 2026 -0700)
- Patch 6: Apply the has_copied handling from f508262ae9f2 to the
  post-flush sk_err recheck, so an abort observed with no bytes
  copied is consumed via sock_error() and reported exactly once
- Picked up Reviewed-by tags from Hannes and Sabrina

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
Chuck Lever (6):
      tls: Avoid evaluating freed skb in tls_sw_read_sock() loop
      tls: Re-present partially-consumed records in tls_sw_read_sock()
      tls: Move decrypt-failure abort into tls_rx_one_record()
      tls: Factor tls_strp_msg_consume() from tls_strp_msg_done()
      tls: Suppress spurious saved_data_ready on all receive paths
      tls: Flush backlog before waiting for a new record

 include/net/tls.h  |  5 ++++
 net/tls/tls.h      |  6 ++---
 net/tls/tls_main.c |  2 +-
 net/tls/tls_strp.c | 26 ++++++++++++++-------
 net/tls/tls_sw.c   | 67 ++++++++++++++++++++++++++++++++++++++----------------
 5 files changed, 75 insertions(+), 31 deletions(-)
---
base-commit: 93790c374b9d77f3db15786d7d432872d92751cf
change-id: 20260317-tls-read-sock-a0022c9df265

Best regards,
--  
Chuck Lever <chuck.lever@oracle.com>


