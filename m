Return-Path: <netdev+bounces-281880-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAhnKEvB8GloYQEAu9opvQ
	(envelope-from <netdev+bounces-281880-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:16:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E742486C0A
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 164033161078
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C7D4611FF;
	Tue, 28 Apr 2026 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRNbSt0I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF47543D4ED;
	Tue, 28 Apr 2026 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383068; cv=none; b=tJBtx23QQrsbvRKgc1FPKLs4pr/2oU/zRwrj85+2fmVydOcQ/9JjeEAjOW1ctFB0doVnuueWEZ+fOd8/alSNumiVia9+Qid15GWx0NGehATyeyP24s4mMPmunjd5XwYl9mS9vO4VYYJkANeTJnjB7TUJcoZREqyqeVqzUzunCGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383068; c=relaxed/simple;
	bh=+/eP8wcxj5WLuoqHYGV2SUTxMluDA/OclbVDbH9w6zg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bYxtBubVrAUIUFHTt+2Y0ZIG4LkkXak+s2fTwUYa8HMuZU0QjFM225+SvaNOMx+3bHJUsiuWWTQkMomCtWUpKAUn8qmPeluTJ/tMOooV4a6ZJIs9JbXtOLicogF0UeaEWzYCgUFw1fMKj+2jgG//5RHD9621XJ5Ca07jTcXalww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRNbSt0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9736C2BCAF;
	Tue, 28 Apr 2026 13:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777383068;
	bh=+/eP8wcxj5WLuoqHYGV2SUTxMluDA/OclbVDbH9w6zg=;
	h=From:Subject:Date:To:Cc:From;
	b=lRNbSt0I5UR9cdk+7/UHoA3pOwIeNz+nMb3JyUTxv77FD9mhVFiei97aLq8CAe3Wk
	 TE5p3UUTw4zZ3QGLkKv4LDi6INn36MqqCR3Ok7GzOsNKFh5lirCTsjE8pS4MEREAn6
	 o/87YztwbEhJD6EhbwIqHx8eCa70/JgvQyPtsjbugzRY1mqgIPL+iASuX4uGtg1SS3
	 +kQS4w1x+Cl/IrW+T86a0UjBMH1H3Hk7IR+fOoYaHMWrZluSdTVQ622QbZbTev+3Yq
	 KarDE6Ve0GGE2fS5w0kY8dsNzdm2SF5tkUhC8X9pfgYo4RoVgRxJ5O6O8bgY0vGXYZ
	 jmqJgM5kTuM8g==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH net-next v8 0/5] TLS read_sock performance scalability
Date: Tue, 28 Apr 2026 09:30:45 -0400
Message-Id: <20260428-tls-read-sock-v8-0-85f96c7df24c@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIW28GkC/3XOy2rDMBAF0F8JWlfpSNErXfU/Shd6jGrRRCqSM
 SnB/x7FEHAduhwu5965koY1YSNvuyupOKWWSu6HedkRP9j8hTSFfhMOXMGBaTqeGq1oA23Ff1M
 LwLk/hsiVJN38VIzpsvR9kIwjzXgZyWdPnG1IXbXZD/e+R/Z6tinf5ZDaWOrv8sgkFv/P5iQoU
 OsYGIVeAcT3Uq0/4d6X8zI1yRXnYstl51KAcRhRai2euFpzteWq8xiM0e6IOoJ64nrNzZbrzpl
 U2ggmQ/TsD5/n+QbYnjF3kgEAAA==
X-Change-ID: 20260317-tls-read-sock-a0022c9df265
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
 Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>, 
 Alistair Francis <alistair.francis@wdc.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2682;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=+/eP8wcxj5WLuoqHYGV2SUTxMluDA/OclbVDbH9w6zg=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp8LaUNWuAHK+1F5pgDrBut6oY83/BHVe/e9rTZ
 5Jqyul130OJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafC2lAAKCRAzarMzb2Z/
 l+G7D/9HwDP9tZZjQ9kOsTMUxM9G6DwPotvsGVgRVEcQ/TA4cy2Xm/R7Xbc4fId/pTUxYtC+fdQ
 VktLenSVFZd/XivC39W5UVKBh9qfhesHjOHxyXDhinxc/NaClSEwj5WgU3rUUnsYNWJQUqD3X+S
 wBPwpJ34R2nSwZJfclXag9SywLkIWx8kBFPUxuWfCCR/GMwom0z0IpNu5QvlMe06qukIXcy2VLU
 rV+7gzw0ey6wee0Uyl+qiifrtz9qSHP+4oWFebV36g2XRgqN30F+7pkzC1f7OkismzLsGVgeMV3
 cLH4u9Z/rKBVIrq2A0WLKC6nrUMrGulJSQCHgmZ5VB426PF5g7sPYxerPdNbBRrbyPXqyGHFtE3
 KcqH82MoGTUwDh5NbWW5PbEbSCW5ATtYHRc77oBZCYR8Ez6YgRq+pQoUg8hv5zl2Xh6suOkkun2
 ne/mL3AxCTYHXM33vQRj3KJdXT1Nb4U6tnFp1sBg2VPLcAtq85K0wwO0e/d9gDAFCxWXvrC/V7d
 +DZZn3yc6x4cFnnkS24zyGADNSsWqKClz/6pOw6w4r7Npv/NALXZx3YAhvZaGi0gSB4/QkL6opV
 JlYlIFj3PAMIqC8d34uXAnEH2yGQb3ModSwWC4P2E7fXyFAFgGthErVtY3j6Ku/BCONiCWKbmdN
 Og4VmUcsKhwnL9g==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 1E742486C0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281880-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:mid]

I'd like to encourage in-kernel kTLS consumers (i.e., NFS and
NVMe/TCP) to coalesce on the use of read_sock. When I suggested
this to Hannes, he reported a few performance scalability issues
with read_sock. However, batch async decryption and its
submit/deliver scaffolding were dropped from this series because
async_capable is always false for TLS 1.3, the TLS version that
NFS and NVMe/TCP both require. Async crypto support for TLS 1.3
is a prerequisite for revisiting that work.

This series is now only a set of clean-ups. Support for async
has been deferred until after TLS KeyUpdate has been merged.

---
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
base-commit: 790ead9394860e7d70c5e0e50a35b243e909a618
change-id: 20260317-tls-read-sock-a0022c9df265

Best regards,
--  
Chuck Lever


