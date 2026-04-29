Return-Path: <netdev+bounces-282508-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uN0kCa988ml2rwEAu9opvQ
	(envelope-from <netdev+bounces-282508-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:48:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 305BE49AB3B
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58F6130074DA
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 21:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823251F5437;
	Wed, 29 Apr 2026 21:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MA0gQvzN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEFF199385;
	Wed, 29 Apr 2026 21:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777499304; cv=none; b=ljLFnxt0pfyre/1wZGZM6yrc9ktxu0/+gsE6j5zvhHG/KNocQeUCpM/fDpgDyer4TU/nGllo0lAWjEK+vVSIkcSg8MRxXBXZtbbNxxlJTMZIGFANtuhjgz25FSGo3MSN4+FBhAz8RGkTpnt/UcB5LUsN2DlZOrYWOU6Ubjuu0vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777499304; c=relaxed/simple;
	bh=voeHaowYz2pxyMUh8jyhIMaW8L+v6/oCL2aL6We98yA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rJKhXy/JooUrxKX8c0IDoEY+vwWmvP1m1ghk7oCyCwaobcjvZvzNvueAwX1q80L/wgIvYWwiG+H2jX8FG4U4pQkokqFpP6KE4zl8h052MnRiFYR8CzrZRIEkB+I9WXOts1pn3b3CMJLL5vUYCu7z1IuvcvZU/OUdb1ZUQSdmYr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MA0gQvzN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1957C19425;
	Wed, 29 Apr 2026 21:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777499303;
	bh=voeHaowYz2pxyMUh8jyhIMaW8L+v6/oCL2aL6We98yA=;
	h=From:Subject:Date:To:Cc:From;
	b=MA0gQvzNxnSYm4eBt+92WVkNpuvRPVgK7pHgN/wf/MSb0QatlJ15zn3789VqCuNvS
	 Hw8k/7IW98UdXmuRUly/Z5X5dFIUbqkM1ncyb+u5EfTdEoON30Vjms9+zOwMJTMAKe
	 Jambue4sz9Z79XLVEPEQEfLzLiTBxKOConn71+3yc8Fvx0hZ8dLPtpiWaBntq9Eyg2
	 QgADiJmRwrW4/HUx72XNZJRrdGW+JjmhV6v4hVH5e460+jtVLbVKR8m+SSljMHIK2F
	 GLmLQRaCm9Wa57JffHHOcFi+noViGV3Fj/YVX3EpysVmITTVN5pyNas1wYvtzKFYZN
	 zQtG+crPo5Peg==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH net-next v9 0/5] TLS read_sock performance scalability
Date: Wed, 29 Apr 2026 17:48:07 -0400
Message-Id: <20260429-tls-read-sock-v9-0-39e71aa7810f@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJd88mkC/3XQTWrDMBAF4KsErat2pOrPXfUeoQtJHtWiiRQkY
 xKC717FUOradPl4fDPD3EnFErGSt8OdFJxijTm10D0diB9s+kQa+5YJB67glWk6niotaHtas/+
 iFoBz3/WBK0mauRQM8brMO5KEI014HclHa5ytSF2xyQ+PeT/dy9nG9JBDrGMut+WQSSz+n52To
 ECtY2AUegUQ3nOx/oTPPp+XVZNccS62XDYuBRiHAaXWYsfVmqstV42H3hjtOtQB1I7rNTdbrht
 nUmkjmOyDZztufrnYc9O4kaFTXrenC/+Hz/P8DdkRCujRAQAA
X-Change-ID: 20260317-tls-read-sock-a0022c9df265
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>, 
 Hannes Reinecke <hare@suse.de>, Alistair Francis <alistair.francis@wdc.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3294;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=voeHaowYz2pxyMUh8jyhIMaW8L+v6/oCL2aL6We98yA=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp8nycVllwTOmLsl5nMX/mh/2XHhc5gxs+8i9Bq
 6qBL5CKgVOJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafJ8nAAKCRAzarMzb2Z/
 l3DeD/wOVOPYiMLg32C2dwA/KJ/mRqWkr35Rx332x29/bV5ptH70cODTfK/+n9gEqWQL/1KTKMY
 jP64vZaCtRM11wxdYLeomGPsFIvd6l0QBOEfN0ejde+7Nv5V3FCghUXCS1iWj6MqXLvlqJ0PJX8
 f1le31+2eo2ALCYxqp/Tbu+og74J+ygaTNi6rEZjzXLjCg/3elGWsMCdvc1fV2Byx0Zlt1+zr06
 d6aUXnI/ERkJ03u7K9TJo5LiFRpClZUiR1MfZOVJuxwXAGGqrEGX3XO6nhWoyBm/DWbaaRN5wF7
 DIn/YN6vEPjUaS3iX38twZRVOw0dqbVyqNfZYyQXvr9sTTsizNCyyKEBsNrEOwXicja/DvE/2zH
 0pctrQXDGnmUSIm6Ewr6xrzDREkfuXLtts1ETXZij1Wj4G/YjGRkRBFyGtFmyMGfLcGRBWVpeen
 FKrPoy/Z0vQItMV0Ez2/FyYslPUsrK7HhrJMIuIsuPcvAO+4aeWj1iodykwl2WMsmAV2mF7I0YO
 ZZe1WJVZssJiSmGr05rb5Oq0maxS51ddweggzlQnUjQIJL0zvOTZXKU9u66gZ5ZQBY9ySNjyq3l
 YEHgRSPFBosoeWWdSql5/hbr+9BI0ACmuXYwyOXTept7yIVhE1NC9AD104/vrFxO/NgzCMkpJVP
 IceF38Gd6wAXcQQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 305BE49AB3B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282508-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

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
Chuck Lever (5):
      tls: Abort the connection on decrypt failure
      tls: Fix dangling skb pointer in tls_sw_read_sock()
      tls: Factor tls_strp_msg_release() from tls_strp_msg_done()
      tls: Suppress spurious saved_data_ready on all receive paths
      tls: Flush backlog before waiting for a new record

 include/net/tls.h  |  4 +++
 net/tls/tls.h      |  4 +--
 net/tls/tls_main.c |  2 +-
 net/tls/tls_strp.c | 36 ++++++++++++++++++++------
 net/tls/tls_sw.c   | 76 ++++++++++++++++++++++++++++++++++++------------------
 5 files changed, 86 insertions(+), 36 deletions(-)
---
base-commit: 09942ddedcb960f9e78fd817ec33f501d1040c5b
change-id: 20260317-tls-read-sock-a0022c9df265

Best regards,
--  
Chuck Lever


