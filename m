Return-Path: <netdev+bounces-282525-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEIgBG+G8mkcsQEAu9opvQ
	(envelope-from <netdev+bounces-282525-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 00:30:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B97249B069
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 00:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 680083019CA5
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 22:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1099E3AE19C;
	Wed, 29 Apr 2026 22:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezbBlo6b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E148639EF2C;
	Wed, 29 Apr 2026 22:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777501803; cv=none; b=UvH7pHGhba260WeWV3EJnkaUCZXNjUYnniJGMsL4ZvHUmKh2ix0DGC4uzGxTJhGvi0KQNPmIZkA/V1aWMKpmJj8FKYyjCPJXnGDIQrJjzwtoZCYP8Gi2L9/GZ04d4sh1B3xva7tCoiep0/VXLFInOsv9kDsTqqGB9FhzPglDpgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777501803; c=relaxed/simple;
	bh=3DcQIt3OyWfZwNDlD3KnBgTDz3Y2yFzJGzIKKpu3KJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SxqOwJP8Wox75AlMX9l2M6Rz8CnkVPFWuG1/RGh9FdMk6uKFADUYhb8TxcSQrNR+K8X5bATzzlZWX7e9Tky8XVcelNoIuwCDHs+UHSLk+LCx0+oDJE+H9c8nDu1mwbeGaoQ04LeooAQhUTuzhztprq2qWpNBYuCB4fiUKwYtvmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezbBlo6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F79C2BCB4;
	Wed, 29 Apr 2026 22:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777501802;
	bh=3DcQIt3OyWfZwNDlD3KnBgTDz3Y2yFzJGzIKKpu3KJE=;
	h=From:To:Cc:Subject:Date:From;
	b=ezbBlo6bgBKEEKdAHzTGXWDdwYzD5N6UUyoP1u93bdUv0+YudqOgkJnif7BF5L0O7
	 MtynkNmY5uSnSuBPrL1eZc/z1IdTM+lrYqFuvVMNB2k1D1YbwUfId0L8hFrKyJXJnx
	 NxjCnv5DIR0gatVqUsx0bvC378J9Ru/FNMiGKXcwis2LOkT6CnbkZIqI3oospHcehR
	 9QGEkp7yrg4XLz6bWrtwrea+RqEdYPr6Q7RsVSZAVNOHpwCjTaws94/loKvFN18Kbb
	 vsQ7Y66n1XXjopQIGQGuhK+rb/fcN3GR1vnczzgT8iGqifJvItagtSatmZOF+3lDVp
	 qXgTLddaMfG+A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	bpf@vger.kernel.org,
	john.fastabend@gmail.com,
	sd@queasysnail.net,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 0/7] net: tls: fix a few random bugs
Date: Wed, 29 Apr 2026 15:29:37 -0700
Message-ID: <20260429222944.2139041-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7B97249B069
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-282525-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Fix a few random bugs, from external reports and my local scan
with various AI tools. Mostly corner cases in code which I don't
think TLS maintainers would consider "battle tested".

Jakub Kicinski (7):
  net: tls: fix silent data drop under pipe back-pressure
  selftests: tls: add test for data loss on small pipe
  net: tls: fix page pin leak on sendpage_ok() failure
  net: tls: fix off-by-one in sg_chain entry count for wrapped sk_msg
    ring
  selftests: bpf: cover wrapped sk_msg ring chaining in ktls TX path
  net: tls: fix use-after-free in tls_sw_sendmsg_locked after bpf
    verdict
  selftests: bpf: cover tls_sw_sendmsg UAF after bpf_exec_tx_verdict
    split

 net/tls/tls_device.c                          |   2 +
 net/tls/tls_sw.c                              |  17 ++-
 .../selftests/bpf/prog_tests/sockmap_ktls.c   | 139 ++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_ktls.c   |  10 ++
 tools/testing/selftests/net/tls.c             |  43 ++++++
 5 files changed, 207 insertions(+), 4 deletions(-)

-- 
2.54.0


