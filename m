Return-Path: <netdev+bounces-268640-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJs1O25vuWm8EgIAu9opvQ
	(envelope-from <netdev+bounces-268640-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:12:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6B12ACBEC
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C0C93191A55
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBA53EAC82;
	Tue, 17 Mar 2026 15:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vi2Im5Ua"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285703E3C5D;
	Tue, 17 Mar 2026 15:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773759884; cv=none; b=fnB2hE4AGab3SItBlIgRKttPotn+Quzrge0oFzRFYv4FPSj38nmBOPTbrBFK5h4+8hc7GEtmfQuMbfkXhZoiVTWFLOX8QGwMtKM4D0r3YLvOS5iBjMQvE2H8ucuQ7f5iTtUrf5H6Rpu2hqtsbbWQkS29Nih+gRUEO4gopNp+JE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773759884; c=relaxed/simple;
	bh=59aNDcVffn0B1D24YZlUlxl13CZVqaSlItdM/v/NdM4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uBTEGNXlzl/2tRkkMf+FmMtvXKfnaJ5wkMGaiY+NsMa+ihl+FGzMq2GP8HAtjrykDqerqJT8FI1f/HveAf/zrnrcQGOthWDJyKioKLJ6jkfcTV9ymjgn+OZUy4mz5P+LQhIaoKEPgtUkP5uiRyECmIfuEJp98GLlq4pRTvtlLBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vi2Im5Ua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBA5C4CEF7;
	Tue, 17 Mar 2026 15:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773759883;
	bh=59aNDcVffn0B1D24YZlUlxl13CZVqaSlItdM/v/NdM4=;
	h=From:Subject:Date:To:Cc:From;
	b=Vi2Im5UaWgwtqrg7SNpGPNn2BfmwigKdeEUdFuFvHE1lNwdj1L5rm8XUkAj+uHv8N
	 fJg4fCEA89CPTt1TiJ8QpazuPMsePJksOXvHNZdn4RHwWByXKhllWRtNc9d55PYhC6
	 y4jnw+yz8aVh46TdIfE2sK93BfhmjNnFBqKJ+I4TZhUc1ZhYIoJmKX9+BPTxJ79QyI
	 2JTy/B5MJjoahhYutpleOufD9NIQunXdOJnqTcQr+10lkSnl4ODVOGvuIwQKqTcygo
	 5qhPkC+3OONlmTN4cJOSxdOXl6h6OwjThinxp2o47RgQVboLUUSTlieswwhkV/ArY5
	 EX7wIFHNAlv2A==
From: Chuck Lever <cel@kernel.org>
Subject: [PATCH net-next v4 0/8] TLS read_sock performance scalability
Date: Tue, 17 Mar 2026 11:04:13 -0400
Message-Id: <20260317-tls-read-sock-v4-0-ab1086ec600f@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAG1tuWkC/x2MsQrCMBBAf6Xc7GGMWtFNXBwd3MThmlztYb1KE
 iVQ+u/Gjo/HeyNEDsIRDtUIgb8SZdACm0UFriN9MIovDNbY2qxXO0x9xMDkMQ7uiWSMtW7vW1t
 voTTvwK3k+XeDy/F6OlfKCZVzgnvxDUXGJpC67n/tRT95tssXicI0/QDf1ycSkQAAAA==
X-Change-ID: 20260317-tls-read-sock-a0022c9df265
To: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net
Cc: netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev, 
 Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>, 
 Alistair Francis <alistair.francis@wdc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1980;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=59aNDcVffn0B1D24YZlUlxl13CZVqaSlItdM/v/NdM4=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpuW2Ay6f7dbQbUiraS8ubFDGldODM4STD0trWj
 Q8Gvf5SPj+JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCabltgAAKCRAzarMzb2Z/
 l7TyD/0ZuNiG5ZrbqzzlObJNnbbuypdkyasjzziW/7td/6YW5f0ruNOy8ju3P17bBa0iD4JaoaG
 T0I32i/9TNlR2JG27KZgIr9dU0u+6EdbZOsELeLXyTYRmdBQmhzBdO5OxSFojEy2okiGTuW7Cxx
 4RKyeFz0OWzHxqoSawp9LmuOYXn3kOtAirMhMnGK/AGTrTdlIrNJubbp368PCfFhFYl0nQi0JxN
 J2dU1cxlX6/vO1VxF1gY8e32i/nlY7B/IgLu/LFnPbuimiylcmxiJHXYdmZHtyKkoVzWeKo0ZJp
 4EITcUFCISbck46gnnoKzk1yevOQCS36nvkj9vN5T1ucjiw+TY7kVZsQ/7cqKJJnhI9GbHbVwhM
 M06CL7xnhr/F4j2uy4YFgih4OqB7wm6Vxzo/pbwTco+UTWy8eoRF5Q8+PmRsBCTOgL7mxdz7uEp
 AcZ5Ws83Lgr+aOqBa9j21DlgnbiTnosYeXuAgXmGCXOPZ2+YwkVDjN8A73bFLyNLupKKy86a0ap
 gDqY+fM+u48MkJrrj+ybprIZsL1rcJPys8EqtAzZ28lY9JJygMp2qQIckGFL/Jf+Avnno+YpijS
 suGYPzhsnqRYp1UtTcT+C9cW91p3SQunKTrX0+mzwNABoMuj9+DEyjMyg5KZvkbuNc1mpVxHmkT
 KaoAF/uzmhywD5A==
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
	TAGGED_FROM(0.00)[bounces-268640-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:email,oracle.com:mid,linux.dev:email]
X-Rspamd-Queue-Id: 6A6B12ACBEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I'd like to encourage in-kernel kTLS consumers (i.e., NFS and
NVMe/TCP) to coalesce on the use of read_sock. When I suggested
this to Hannes, he reported a number of nagging performance
scalability issues with read_sock. This series is an attempt to run
these issues down and get them fixed before we convert the above
sock_recvmsg consumers over to read_sock.

While I assemble performance data, let's nail down the preferred
code structure.

To: john.fastabend@gmail.com
To: kuba@kernel.org
To: sd@queasysnail.net
Cc: netdev@vger.kernel.org
Cc: kernel-tls-handshake@lists.linux.dev

Base commit: 05e059510edf ("Merge branch 'eth-fbnic-add-fbnic-self-tests'")

---
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
Chuck Lever (8):
      tls: Factor tls_decrypt_async_drain() from recvmsg
      tls: Abort the connection on decrypt failure
      tls: Fix dangling skb pointer in tls_sw_read_sock()
      tls: Factor tls_strp_msg_release() from tls_strp_msg_done()
      tls: Suppress spurious saved_data_ready on all receive paths
      tls: Flush backlog before waiting for a new record
      tls: Restructure tls_sw_read_sock() into submit/deliver phases
      tls: Enable batch async decryption in read_sock

 net/tls/tls.h      |   3 +-
 net/tls/tls_strp.c |  34 +++++++--
 net/tls/tls_sw.c   | 198 +++++++++++++++++++++++++++++++++++++----------------
 3 files changed, 169 insertions(+), 66 deletions(-)
---
base-commit: 5446b8691eb8278f10deca92048fad84ffd1e4d5
change-id: 20260317-tls-read-sock-a0022c9df265

Best regards,
-- 
Chuck Lever


