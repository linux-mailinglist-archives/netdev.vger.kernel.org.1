Return-Path: <netdev+bounces-271055-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPtSDIyMwmlvewQAu9opvQ
	(envelope-from <netdev+bounces-271055-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:07:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C92D7308EBC
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 14:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 10706307581B
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 12:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA793DFC93;
	Tue, 24 Mar 2026 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYvzo04f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99BE3F99E1;
	Tue, 24 Mar 2026 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774356840; cv=none; b=WLHfOw0Mj0HZ2124sLs5dHX6V2vFQEO8+fgswCtoy68n73tfz/IhwyKgwxamox1r0KFiVGTsAd7bBiipEO7bo0lbM3j8BWSglZQize91y5NIomV4IZeFWGNOyby8d4KXGcbfkfZgPpefaURQG1FvGgiXHwOyg/U1BKr/EUSmlYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774356840; c=relaxed/simple;
	bh=YqKRlBVjcTx7ywtgWRS5NCcicF+FTeN0kSbahhHkLbs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Lsig9HXr7c63yA4hTT5cx8lpVIXbXQ08Ejk87OS1+f0ltZvqc3GJg/RD5H4ahuk4GE/iSJLChjb/Ei6+9Klx/1TbMTvWY1NJ3OpheawvlE1I729iUxETQcU7CGpQ6CF0Z1ZkZhOXzSEb9ATuPMTxj1/fqaIaD1VpCES771WWMdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYvzo04f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBA3C2BC87;
	Tue, 24 Mar 2026 12:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774356840;
	bh=YqKRlBVjcTx7ywtgWRS5NCcicF+FTeN0kSbahhHkLbs=;
	h=From:Subject:Date:To:Cc:From;
	b=TYvzo04f7cosnCXA09n3RvGGwGH8erNeIq/HAQ80W3RvmurRkvVgoaXfmEPuxtYSQ
	 iIotVw6ab+B+4Ta3iwDkyCnX75Ia789OqLnluemnYllbVisn9UdFxosVhc9VILa5+6
	 Fno/AnZNDuLVdYryjO+fq1nr4R3nUzgHh8IJH+sLv6CBzL0lLi9R6gWynGaVSXbGhw
	 1mk+XRblHhUyF03H68TzYGerjlZHFj48HKBevfgNBZX8x+KQKNHJW/0+A6HUFqp/p0
	 M/CtfcPFWK2X80J5fAxR8xcik3QYK646Y/E5qHhPLgkZSnAw+T9JLAMod68wccMEw1
	 nBNcWAKQClLWw==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH net-next v5 0/6] TLS read_sock performance scalability
Date: Tue, 24 Mar 2026 08:53:22 -0400
Message-Id: <20260324-tls-read-sock-v5-0-5408befe5774@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEKJwmkC/3WOzQ6CMBCEX8Xs2dVSof6cfA/DYSmLNEJr2kowh
 He39O5xMvm+mQUCe8MBbrsFPE8mGGdTqPY70D3ZJ6NpUwYppBKn4oxxCOiZWgxOv5CEkFJf206
 qChLz9tyZOfseYDmi5TlCnZqGAmPjyep+8w3GfubcHkcydmN7E6Lz33xlKrPhz+pUokBqCnFRr
 JUQ3d150gMftBuhXtf1Bwc/DxjXAAAA
X-Change-ID: 20260317-tls-read-sock-a0022c9df265
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
 Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>, 
 Alistair Francis <alistair.francis@wdc.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2288;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=YqKRlBVjcTx7ywtgWRS5NCcicF+FTeN0kSbahhHkLbs=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpwolccYTxEcwD9mFnF41GseNWtHN4AACacknHV
 rlQn/7tIdSJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacKJXAAKCRAzarMzb2Z/
 l/VTEACs7qC9bFR4AF9mikrBRh9HBx+ng8A9iDiccMkD974LMBFHM9O0hfJVQfF3+7SFEOiptOP
 vV56zi+3cM1X3KUuqCPcbvFGjv9NJhwwiVWY/xcCqSfxnuAdQAHIi90boOc5U1+OHrvx9b7fNNR
 0SnPB4XnaA/M4nqbVIaZxb7dc8kU1ildXHCpajvsKp7gKYw6YtjVP0N5gXEvsA3z8TvE7GaFGiZ
 D3YrBCG0/U7xct9DTtJoos/ODFb4VsE2kkfoEUT1F2RKUGgRT/vEyK+AQvz6hNEHOdyEnvTWJVc
 QV8GL8EC1dR7khUUDV5bzq5zJH3CduXcGH2tkAJZPWLsbbfTAEb52rt82uwYFRS5FFblI9f/O07
 onVAF//dj/JZxA2Wa3tzTQ2wXahiUS0pusb4xmA4zgwe7JdIOSROlzJk3xvuLy2h3UNAJA2ja2/
 qXVyEgYMaiEyTNIpTPtcfODdcKyMqmQ3EPV9gyPbdiPLfHr5nsN16/TxqlleIY6uuF59xTTlnkY
 VZ5J6SK1IACsWdiEE2xSjyG9unmYnmYuQEXhGL1MUKSSYFdCQamvrNefkn8Teb0apMTobH0HluS
 rrr78+jg4jFwVO1yQn1g8Vdo7eVYG6wusVYufGRVCVf+mA2+WhRXFLSXUzcjcSzv2+6otxpKSxl
 wslZ8nWvsNtWBGw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271055-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:mid]
X-Rspamd-Queue-Id: C92D7308EBC
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
      tls: Purge async_hold in tls_decrypt_async_wait()
      tls: Abort the connection on decrypt failure
      tls: Fix dangling skb pointer in tls_sw_read_sock()
      tls: Factor tls_strp_msg_release() from tls_strp_msg_done()
      tls: Suppress spurious saved_data_ready on all receive paths
      tls: Flush backlog before waiting for a new record

 net/tls/tls.h      |  4 ++--
 net/tls/tls_main.c |  2 +-
 net/tls/tls_strp.c | 42 +++++++++++++++++++++++++++++++-----------
 net/tls/tls_sw.c   | 51 ++++++++++++++++++++++++++++++---------------------
 4 files changed, 64 insertions(+), 35 deletions(-)
---
base-commit: fb78a629b4f0eb399b413f6c093a3da177b3a4eb
change-id: 20260317-tls-read-sock-a0022c9df265

Best regards,
--  
Chuck Lever


