Return-Path: <netdev+bounces-272775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLRzNATxx2lMfQUAu9opvQ
	(envelope-from <netdev+bounces-272775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 16:17:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B1034ED4D
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 16:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDF233012269
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 15:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600CA330D24;
	Sat, 28 Mar 2026 15:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KASsw119"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C99B30F7EA;
	Sat, 28 Mar 2026 15:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774711042; cv=none; b=e6da2xyFjZyFPokdRe8N2+BhyxITiw0/GNw5+lNCvmylTpyyhdSo7ojaBTdSi3cYXhiSsqwbsM5PoPEG1QV0s2Zz30y8siNgmpHH7WBwRUNzqTLw/Uo5XRUx7scW5aKwk2xIM3vjz/HO64WQpHKgiuG2z1MM5W4wrAOr3lp+jGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774711042; c=relaxed/simple;
	bh=mhH9Jco47DM0H8Pc5XEV7r4W5cLh9/ievD4PR1QSfLY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HBNQUKcf3j9Aiu77yaWva+ZchFCB9Gj0IDVncOf7vrAvB12zNiZQMBYiFrPOMd9ksewLTcTJOLrcE3iKbAy8gMBQXGOww85gtlnKDx7QknNQQsQwlKd/XYdRhZq/oplNTrwcSvYXRe/cWaBwvQEtZbcxXn2qD8lQ2g+BdlcEKIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KASsw119; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0621BC4CEF7;
	Sat, 28 Mar 2026 15:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774711041;
	bh=mhH9Jco47DM0H8Pc5XEV7r4W5cLh9/ievD4PR1QSfLY=;
	h=From:Subject:Date:To:Cc:From;
	b=KASsw119G5f1w0SBwyI+eK3PV+RnYFujvcXsFQAWXeTr02UDAKuFQsrKUwFVBcyN1
	 s4lQo/rTTGoWqyaRdmPUifQY7i+KlJY672HlGyI0lRaG30U5WbG0U3H6xsBXA+8CJ+
	 bI3gaokQBKXrtIYLrwqhCtSrsqUUvnk4QZTN6+LHvd3F+EMIlIxvxM3/hnV5VTbVSC
	 ohx0x+NtYIAW0iCnF9w9qFsEGvbwrtRKDsRwSuw0Nd64/e+Pvcqb8zkCFyIJBOVUuX
	 7citCJZ6N2Zfi7+f7j1nVbmwwBGDPbbcJbtqlbW654/3710Mhgf7ckz8GK0S0DD726
	 Np8W2z1+KQGew==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH net-next v7 0/5] TLS read_sock performance scalability
Date: Sat, 28 Mar 2026 11:17:07 -0400
Message-Id: <20260328-tls-read-sock-v7-0-15678415dfc1@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPPwx2kC/3XOTW7CMBAF4KsgrzvtYPwTWHEP1IXtjBurwUZ2i
 FKh3B3jFaXqcvT0vTc3VigHKuywubFMcyghxXrotw1zg4lfBKGvN+PIFe62GqaxQCbTQ0nuGww
 i527fe64kq+aSyYel9Z1YpAkiLRP7rIk1hcBmE93w6BtDvC4t/TibEB92CGVK+ae9MovW8M/qL
 ADB2C12ipxC9MeUjRvp3aVzG5vlE+filcvKpcDOkieptfjD1TNXr1xV7vuu03ZP2qP6xdd1vQP
 EGYIVVQEAAA==
X-Change-ID: 20260317-tls-read-sock-a0022c9df265
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
 Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>, 
 Alistair Francis <alistair.francis@wdc.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2634;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=mhH9Jco47DM0H8Pc5XEV7r4W5cLh9/ievD4PR1QSfLY=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpx/D4VQLmE4ZPXdoM8ulWKBWyoskDtjg4iF8yI
 gz8ZQG2QJ2JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacfw+AAKCRAzarMzb2Z/
 l1VdD/9A9ur+3Wx5dDG47IPCqmRo0Bs5N+ql7dC26pJdnCbxAk/yrRdsXBItknI9mFGEI3bA2P5
 5NF3U7xYZpvuUhVwTkK2NMGL1VMky/vJMwBl5N/st7HgsaPnb8S5F3MO5UQ/tukka8X9w7KETBD
 VbXBXX99thlUbi5XM2Qi7e8Ps5YTLJr8AIsjClT30fzpxtdcyRCJ0EL1pjiH53HWkB+SYc5rlFq
 R6d6oNegwnkiA8Dcz5FhhEPKbDrNzVz6bHFI8gSxBp+Rtne17xRFwPmy2V0Eb8EdD+7iEKXc6nd
 uN/a75Y+Edxy+SiIVYxy3LLjJokKhfy0O3mQtaoKvLWSLn4QjSZJuo6zgzuf/9LHF76oGQVUZCS
 zi5OhwRmxqQwVEO+DNdUxdZGzzIVLq1+I9k7UD543PUinqPYK8wDOcXethuTIUS9jAJTMJRVu9N
 jpQKzDMm3Kmz/JXs+zzS80orGi0yhv2hIfzqAq/B16c+Gt+INZGJuGdSVI1W/7Gl6Yb0VWAXfS3
 CZCLCi1dAl+9gDMtlOY76vTu9KOTqkFL0uN5FN94mDKD2yf7zXcd4MIXVC+AaNYHZuXb0tkFjlB
 2PiAaimwv35NB5wBQ+jacBcIsKfXfXuGCNOECf9nqMPZtlMJO+A4AJl8T+mEhvxtOelqWdWOCmE
 YkHfHWTM4RTTNCQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272775-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 42B1034ED4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'd like to encourage in-kernel kTLS consumers (i.e., NFS and
NVMe/TCP) to coalesce on the use of read_sock. When I suggested
this to Hannes, he reported a number of nagging performance
scalability issues with read_sock. This series is an attempt to
run these issues down and get them fixed before we convert the
above sock_recvmsg consumers over to read_sock.

Batch async decryption and its submit/deliver scaffolding were
dropped from this series because async_capable is always false
for TLS 1.3, which NFS and NVMe/TCP both require. Async crypto
support for TLS 1.3 is a prerequisite for revisiting that work.

---
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
Chuck Lever (5):
      tls: Abort the connection on decrypt failure
      tls: Fix dangling skb pointer in tls_sw_read_sock()
      tls: Factor tls_strp_msg_release() from tls_strp_msg_done()
      tls: Suppress spurious saved_data_ready on all receive paths
      tls: Flush backlog before waiting for a new record

 net/tls/tls.h      |  4 ++--
 net/tls/tls_main.c |  2 +-
 net/tls/tls_strp.c | 42 +++++++++++++++++++++++++++++++-----------
 net/tls/tls_sw.c   | 50 ++++++++++++++++++++++++++++++--------------------
 4 files changed, 64 insertions(+), 34 deletions(-)
---
base-commit: ced629dc8e5c51ff2b5d847adeeb1035cd655d58
change-id: 20260317-tls-read-sock-a0022c9df265

Best regards,
--  
Chuck Lever


