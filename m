Return-Path: <netdev+bounces-287538-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPwRGIVZBGqjHAIAu9opvQ
	(envelope-from <netdev+bounces-287538-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:59:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A22531C58
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1F812305D0DD
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 10:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BC13F9F5F;
	Wed, 13 May 2026 10:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="r/JD0yV0"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55A838E12D;
	Wed, 13 May 2026 10:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778669915; cv=none; b=Nw2KIGvIr0UE7VsRHxTvzMWnc7pw22j8J16UTrtAG45htoXM3cfENGUyS+UV71csO/J+YAQWaV+GwuD8M/BFxEzse1VKvJE2nY7SUddGg+GJiE3snO3Ksr0u05DUhMy7/7koF5AO58KikwQPT0Tb1pm3oZrn/WgvVf7kJuYKd+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778669915; c=relaxed/simple;
	bh=QIA/aaUl+Tf7JJyWRrgCs8eHCQk13Eufaox2+xCY8+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mIg8gKOftNgl2Gs33U8kc4E7zFe8rc9gL6M4OtZI+Jlc/3jnqB9wCepKYSkNk2sUIaG4qelc6GSL5RXayOoDbGdMdy2jt1sJehwsZlV3Jzx9/BLfcLNSR79nxk/alwfmRCPWlZtvsZNEqMYdpmae+AYC6M/ZwHB18b9iqjITRkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=r/JD0yV0; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=b2vQAn4oTfcls0aM2yCHBuL5+9umU8OJL3yCGEj5204=; b=r/JD0yV07yKn/rGJzW6sVNAKbN
	huAov3LYBDl2q5atVn5g94IkPk4SDZKg9fPdqFaslx3PUAuV/ZCRvndG4380AVJIR+Puq9Sem9E2c
	DAZdWLsaFboqsWxDXGDVwHQosWydSb0Y/hPfYUoliIiesZA6TAf3kqMpY08Y++C7VmIXVWaGXKvtJ
	rdyR/Aibg2JYdDDpN1QtW7CJZvKosopdDy8Dtt3lp4BT5QUPzOLsVoSUs1LAFk0WeDbuOfBGH2/Qv
	zOPPaJyt3JpqbHHmR4B2tc6PfALmzuXtF63L3qkB6ZC1s8v4MYJmcuT7MfLlorzAO3ji4r7TJkxnI
	49n/lFqA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wN7I2-00371Y-0r;
	Wed, 13 May 2026 10:58:10 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 13 May 2026 03:57:54 -0700
Subject: [PATCH net] nfc: llcp: avoid userspace overflow on invalid optlen
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-fix_llc-v1-1-33c76f931ff6@debian.org>
X-B4-Tracking: v=1; b=H4sIADFZBGoC/yXMQQqDMBAF0KsMf23AJI2VXKWI2Dhpp0haEhVBv
 Htp3b7F21E4Cxd42pF5lSLvBE+6IoTnkB6sZIQnmNo0tdNWRdn6aQrKXOOlta5ptXWoCJ/MUbb
 /dEPiGd2JZbm/OMy/A8fxBVwhGBJwAAAA
X-Change-ID: 20260513-fix_llc-27f483568135
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, David Heidelberg <david+nfc@ixit.cz>, 
 Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, oe-linux-nfc@lists.linux.dev, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=2108; i=leitao@debian.org;
 h=from:subject:message-id; bh=QIA/aaUl+Tf7JJyWRrgCs8eHCQk13Eufaox2+xCY8+8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqBFk+AoW4oPCP5GFeTXU6bONFB9NA6e78wUQak
 f0UWuFGWvKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagRZPgAKCRA1o5Of/Hh3
 baIuD/9WV2i+Km1+S+9RNoOXRoOcjrz64ezSvMmj2PgL0WQuf6waZw4SN45WRtGigcorcNp7H+i
 HB2nakWATkqD2AS5WOMLLzTZzZFA3Lh1VIx0iuAiEssLRLRStUW9YNbrKIkAwbTYb3Fs8zT++pW
 adx+kddYkyH+m2kFXzIGVz6lfloNE8gqKfZ5JeqtdCFSNNKFs4BV7ho7XlBurPQ9SU/LYRu1mGS
 MpgBc5c1l45gyVXToVfpKyAR+zasYeombAWk1rLDgppNJq0pkOJ28Z8tceMPv8Au5mFox3pcSSi
 oeq+zBUaraEpZYIUU6ksy2CWFAnSI1LCKMwQ0RFc5vadtHKUzjOAnz0CNWTcgfo78O8stjtR9LY
 saL5gVcEO8zpqpTephhAoZdvLnVwsAjuz7imUvZUTl+V9sREx0NJ2YvGEe6ZHViI04Q6HQnhF6h
 +AMPqQGOuPCPIFOkdTLIflLqjzRn5xGgAtBKcqwJ6o06LevBh9QDcYHnFsoPPyDQygaf5xxb1CH
 QC29DpPKp8mTy4cpAWaIxFMC3tgn0SCVNOxBneqZ0ApyG0zG86LxKbNOlT1kO7ZeYpnVeaxXViP
 9rEJWb76EhgjpWmq85KkTcM0JGftSqzrL2KQn+D3snErdOtxpcSsWyVEsqPww+FJFSfoOScrroC
 EyUEuel0yP+FE2Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: F3A22531C58
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287538-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,nfc];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

nfc_llcp_getsockopt() returns each of its option values via:

	put_user(value, (u32 __user *) optval);

The (u32 __user *) cast tells put_user() to store sizeof(u32) = 4
bytes, regardless of what optlen the caller supplied. The earlier
clamp

	len = min_t(u32, len, sizeof(u32));

only affects the optlen value that is later reported back to user
space; it does not constrain the put_user() store itself.

If a caller invokes getsockopt(NFC_LLCP_RW/MIUX/REMOTE_*) with
optlen < 4 (for example optlen = 1 against a single-byte buffer),
the kernel still writes 4 bytes into optval, scribbling up to 3
bytes of the caller's adjacent memory.

That violates the getsockopt(2) contract that the kernel must not write
more than *optlen bytes into the user buffer.

All five supported optnames (NFC_LLCP_RW, NFC_LLCP_MIUX,
NFC_LLCP_REMOTE_MIU, NFC_LLCP_REMOTE_LTO, NFC_LLCP_REMOTE_RW)
are affected because they share the same put_user() pattern.

Reject any call with optlen < sizeof(u32) up front so the
put_user() stores always have enough room. This formalises the
implicit u32 ABI these options have always returned.o

Maybe it is possible to change nfc_llcp_getsockopt() to accept optlen
< 4, but this might be a riskier operation than just keep the current
approach and guarantee that users are doing the right thing.

Fixes: 26fd76cab2e6 ("NFC: llcp: Implement socket options")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/nfc/llcp_sock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index f1be1e84f6653..dc74e725ddd05 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -319,6 +319,9 @@ static int nfc_llcp_getsockopt(struct socket *sock, int level, int optname,
 	if (get_user(len, optlen))
 		return -EFAULT;
 
+	if (len < sizeof(u32))
+		return -EINVAL;
+
 	local = llcp_sock->local;
 	if (!local)
 		return -ENODEV;

---
base-commit: 1d5dcaa3bd65f2e8c9baa14a393d3a2dc5db7524
change-id: 20260513-fix_llc-27f483568135

Best regards,
--  
Breno Leitao <leitao@debian.org>


