Return-Path: <netdev+bounces-306644-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5YYYOIQ0UWoGAwMAu9opvQ
	(envelope-from <netdev+bounces-306644-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 20:05:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D31D73D31E
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 20:05:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kH118nVE;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306644-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306644-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EF22301FD64
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 18:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5A937BE75;
	Fri, 10 Jul 2026 18:05:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7970437AA8A;
	Fri, 10 Jul 2026 18:05:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783706723; cv=none; b=NKZQbs1C/e3UxkcaIe2lg317EH6s7h79fkRZmdTz0iiQlnDZ3W5v7UDNNuwFylzk9sKFoAZb857kWVaJJpPVyHAKSzeu4lclAT69qByR10DoBT+osROk2qN9Hx29Q4QS9gy17k4Vy1wSuzSHW7LzvEwRJLDQGGzGt+fzIZbJ1rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783706723; c=relaxed/simple;
	bh=W91QGhdVSPDDOaAVdZn/joM5E0ApxnHnt0Xg1HSeL0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QVB/ZdgeL0aCyLGtUNGjJ4tlSbkDtrrcIgnYUl+GzsYuyMHJa1Ml4/sxKgHmIEyQ9xim/l85uzB9hSQLruW3P1LD57Ib0aR3/kSrZjiUnd4hmCGsR59Mj0cVFFzTrMEop0ELZF+YNVjAi+tGP3hkMzt3I1dfEE+YkOHKOnnq80w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kH118nVE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3E61F00A3A;
	Fri, 10 Jul 2026 18:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783706722;
	bh=znSNME19fzXGnnynL4ts4fz+FYf6pSCbFq0MxL5mqYE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kH118nVExfPF/rijJ64Ma+ikEdmOnC4VvulZkVtvBkhvw6ns2++VQI4nfRNpo1GtC
	 z4qilx0nvafSn0Lj1LVjcsm7q56t+aciBwla8Mn9bO3wd6IWTUsy3QMqtcshLZq1je
	 0vICBjghq0wW9Qdo3WJXmr4YkgLSMU5F4fBvlfVhEmEtj/rBdAFpuEpiwqqR/ifJMu
	 T1UOWNghtvTBw4wCbgkZyb5UjlLizEmPzhXPNIYF3U0gtYdyjDO3yVqDj16U0VtHb6
	 SbdJOs/ABtwXuyfAX53ucU64oufQmbmnFlCwiboBIzXUc92uhziUkV8GRkh2VCQY9G
	 KkPgO9GjqX1WA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 10 Jul 2026 20:04:41 +0200
Subject: [PATCH net 1/7] selftests: af_unix: add USER_NS config
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-net-sft-fix-containers-v1-1-a2915c294ef5@kernel.org>
References: <20260710-net-sft-fix-containers-v1-0-a2915c294ef5@kernel.org>
In-Reply-To: <20260710-net-sft-fix-containers-v1-0-a2915c294ef5@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1020; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=W91QGhdVSPDDOaAVdZn/joM5E0ApxnHnt0Xg1HSeL0w=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLICTUJOn7BgmTdne222h3PTmaxty4yXr+4007U1tlrn1
 ePkqb29o5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCIOWxj+17Bxy2xc8mX9Vidr
 U6EVChW3FPWy1TdVK6k9qzut9X2KLyPDhqt1prsndX/0r82/PuFaf9va3a8VPyqXpO3/cjq7zKq
 BEwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306644-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:matttbe@kernel.org,m:kuniyu@google.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D31D73D31E

This is required to use unshare(CLONE_NEWUSER).

This has not been seen on NIPA before, because the 'af_unix' tests are
executed with the 'net' ones, merging their config files. USER_NS is
present in tools/testing/selftests/net/config.

This issue is visible when only the af_unix config is used on top of the
default one. This is the recommended way to execute selftest targets.

Fixes: ac011361bd4f ("af_unix: Add test for sock_diag and UDIAG_SHOW_UID.")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Kuniyuki Iwashima <kuniyu@google.com>
---
 tools/testing/selftests/net/af_unix/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/af_unix/config b/tools/testing/selftests/net/af_unix/config
index b5429c15a53c..41dbb03c747e 100644
--- a/tools/testing/selftests/net/af_unix/config
+++ b/tools/testing/selftests/net/af_unix/config
@@ -1,3 +1,4 @@
 CONFIG_AF_UNIX_OOB=y
 CONFIG_UNIX=y
 CONFIG_UNIX_DIAG=m
+CONFIG_USER_NS=y

-- 
2.53.0


