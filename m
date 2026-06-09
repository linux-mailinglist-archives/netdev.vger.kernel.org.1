Return-Path: <netdev+bounces-297223-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /1UiGnJYKGoTCgMAu9opvQ
	(envelope-from <netdev+bounces-297223-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 20:16:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6426633C2
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 20:16:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=P0NevGd7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297223-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297223-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6441D3010C0E
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 18:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447AC34B662;
	Tue,  9 Jun 2026 18:08:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5673EB0EA
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 18:08:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781028486; cv=none; b=nj11SL7CjJINy6V7k1mKOHuHs9DfhlUJnvdAZyXNQzE0BRLCtpm6N9hnoCW2i9o8+LIWGWuXWivo4yR1k+guvqKJvQo+8HwvQXWiDlTQm/A8Ci9iVhgxnmK0AtzsAhsqE0KMtyGOOBUq/88hibX2wzcngtm2h2pGxhUCyi4j0+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781028486; c=relaxed/simple;
	bh=sCb924zWPlMTFentBJ82H8+6T5PSV8K3+Y9F+MMAT7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=txab4cTtdya4QOnGza2Qc/Fv93Dnmn1ZsXl4vGm/5ILKlguXYd6DkDIXLE5IvxGHbvxSAVox+cm6qutuiN4dN7hIep2dMycwwt/q/cxyvetVvkmxg+1Uahl+csBhw5IML887kX1dJDUzJLPA7Tgl3e4te9dXamDtAVDpJYebMkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0NevGd7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990F41F00893;
	Tue,  9 Jun 2026 18:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781028485;
	bh=cY9zGB+uzL/xb+TKavBdWPlZRck7sZ0PGpuuFM3DMng=;
	h=From:To:Cc:Subject:Date;
	b=P0NevGd7FL6O2L6BSAeVQLi3QMFzxCKFRAi5f6sjEH5sJXcVcIFYfa4j4ZRJt6on8
	 vSOR7Tp+et6oF3/eopd6PYqY/uxNs5Q/RI3BL74X0+P3UG5JKclKBfgq7SCZ5fgeG0
	 e7914k26lESdDulkt9HRIsKkgMQKlAoT0cW0/UyfUVnx3PCZ9mmu5cHybZN8XSvbnA
	 tEkDkuF0AAhcp2LWK+RTm0AddIEWd4oS2p0aKUWebTPxPF/t7cxu3Yuoo2eB5SmOxt
	 TpbXGCWIRfkN/d2h9l6GrYa2WuOcPeqF3khJsflV97TcWTXdrBEGnLeePOkzdxWnP2
	 NskOm5erV9WDg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/2] selftests: drv-net: so_txtime: trivial fixes
Date: Tue,  9 Jun 2026 11:08:01 -0700
Message-ID: <20260609180803.1093428-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297223-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuba@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DD6426633C2

I noticed that so_txtime is only passing on NIPA setups which are
looped within a single host. The cross-machine cases just flat out
fail. The initial bug is obvious - the test does not deploy the binary.
But even with that I think more work would be needed to sync the
time / adjust the expectations for a dual-machine test.

Willem promised to follow up on the fundamental issues with 2-host
setups :)

v2:
 - rebase & add cfg.require_ipver(ipver) to the new case
v1: https://lore.kernel.org/20260608173305.372987-1-kuba@kernel.org

Jakub Kicinski (2):
  selftests: drv-net: so_txtime: remember to deploy the binaries
  selftests: drv-net: so_txtime: check IP versions

 tools/testing/selftests/drivers/net/so_txtime.py | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

-- 
2.54.0


