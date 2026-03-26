Return-Path: <netdev+bounces-272076-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ED31HE47xWn/8AQAu9opvQ
	(envelope-from <netdev+bounces-272076-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:57:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CFA336667
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 14:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 240783077101
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498B32FFF8B;
	Thu, 26 Mar 2026 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3bVwfHD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261FF2F83A0;
	Thu, 26 Mar 2026 13:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774533067; cv=none; b=g+2Wao5jTqUCUdXLJzk+qU8w7RxF7wRQdMNZS5DomvuTW2SckqVmyjUdt8HpWvln8uRrvv/w8tTcTJarCObcEh+7hKQFhimTI5V6FPQ0jMzMTpjlKj+FAjSHMOUC9SWGVmbGw1pcEe1cTqqagghYvTHIJ77MnjbfdTCqvz/+peo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774533067; c=relaxed/simple;
	bh=RJHQYiozNsHE4jZdfR6HhSS9M3Imz1wcuvVvtjoeEMs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=isiysOLXdR+k3sdMyhbsM5WfwE9edT6cMgCj+UMc3cH1KPQG6Sp9Zd/FWGJWVD3sqxYZfMs2vfZEznCZ3jRvoSmP1qT/w5Geui5iipBSZuYtXw8d9o8t4RstzMmOjowwNZxX/ITWN27jVS3+dIgBDeDkvhjsSPM1wF/BbDDF0YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3bVwfHD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D97C116C6;
	Thu, 26 Mar 2026 13:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774533066;
	bh=RJHQYiozNsHE4jZdfR6HhSS9M3Imz1wcuvVvtjoeEMs=;
	h=From:Subject:Date:To:Cc:From;
	b=j3bVwfHDFzgtZZjjYJIYooAVLbkV4L1zI+Uwte/qUDDcUu91ZoF0yeNFhdCcDgIZw
	 nCDWrIgaxwwMfDfOxIwqTkGmOy+0nx/Ujma8tnp3cvHFfwuT56C+fJ+B4AeryuRwDD
	 5OMYLwFCzYj2Fn1V6WIKHYTAfq5UpvRIgciGoiIf+WyvAmUwA/Sew4tkBxLX53AlWZ
	 CFscLxyk2CX0K/EvhVBag2FNKgcZh2N8MLm/s7PrU0NlqXTr1sqdPQCkpPOjGfQSom
	 xH0AoccWru+lRgzTijQg9wgfE4wvnR/LCxDha+H0XPbg6khI30uQRMK7mQkUIQU0If
	 6TaQG92QruWMQ==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH net-next v6 0/6] TLS read_sock performance scalability
Date: Thu, 26 Mar 2026 09:50:45 -0400
Message-Id: <20260326-tls-read-sock-v6-0-fd887b9e7f06@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALU5xWkC/3WOQQ7CIBREr2JY+/WLQKsr72FcUPpriS0YqE2N6
 d2lrNTE5WTy3syLRQqWIjuuXizQaKP1LgW1XjHTanclsHXKjCNXuN8VMHQRAukaojc30Iicm0P
 dcCVZYu6BGjtl35k5GsDRNLBLaiodCaqgnWkXX2fdY8rtttfWLWxr4+DDM18ZRTb8WR0FIOhqh
 6UioxCbkw/adLQxvs9jo/zAufjFZcKlwLKihmRRiC98nuc31pk1CBYBAAA=
X-Change-ID: 20260317-tls-read-sock-a0022c9df265
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
 Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>, 
 Alistair Francis <alistair.francis@wdc.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2718;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=RJHQYiozNsHE4jZdfR6HhSS9M3Imz1wcuvVvtjoeEMs=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpxTnApkKonfoYFnz4BMafNfuxP+fnMI/UrKAJU
 A+ZKi3XsDuJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCacU5wAAKCRAzarMzb2Z/
 l4KOD/0R+c+MCNTjbFrmyr/d5oWkn1IRs3buMAQDrge9RNXJFx/smBuYxLIPdc9hTz/fKZH2rsK
 HG651QEdXv6Au0xaSo00yOHt28zpxCIZYTqQ2qkxid8Lf8GNh0YZG31A7vp55WCfFOVPgjqInI8
 j1sXyO/ug9y1GayMkwbxtIqXxmrblRIkLlu1qjdd+LJmLPT04P3qpmuRmB9fhDaNRWsyOLrdXzK
 PPBIVIowd/xjXBEkugEjC3cY0cvdobXjDJR5jDjOrojFG2nhtKdiBrkYKGMM4KdghZ6J4Obk5bT
 W7mBScztQpNlH7+EfdXkuXdj2B4s6ng0xXG5/PitWBU2Tx5chuNvLCBhXr/flXyExHQ07YpWrkR
 foqYns56TeaALE0YH+1q8EnLRshcXrOjIQXianTijhalc9Omc+REOIMOP4S/b2D294uPbK1wD+s
 MUS3CAMaw/jY88LXHjLJiY3UmgkozdH01Kxmo4pd82ybquTmnI4YYwoQbvPaliAk9Fc3585tnHF
 AWDpl05MtS4HVhCa3m7I195dExcshl8/OV9Flr7xsRYMAwLtCcjOLcyzxxVcVUX20HK3wR4wm5j
 VUNYh+u9nSCydGeH19l9vYjB4oYNnN1baBZuSLi9WxF/EJE58WK/ey7xx6cWSL83f1qcDkH3lyW
 MEdQilsMY5JRuyQ==
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
	TAGGED_FROM(0.00)[bounces-272076-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:mid,msgid.link:url]
X-Rspamd-Queue-Id: D1CFA336667
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
- Link to v5: https://patch.msgid.link/20260324-tls-read-sock-v5-0-5408befe5774@oracle.com

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
 net/tls/tls_sw.c   | 52 +++++++++++++++++++++++++++++++---------------------
 4 files changed, 65 insertions(+), 35 deletions(-)
---
base-commit: fb78a629b4f0eb399b413f6c093a3da177b3a4eb
change-id: 20260317-tls-read-sock-a0022c9df265

Best regards,
--  
Chuck Lever


