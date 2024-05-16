Return-Path: <netdev+bounces-96743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0F48C78C3
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 16:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D267284CAD
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 14:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F077614B978;
	Thu, 16 May 2024 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="k7/DFcGf"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0895714B969
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715871370; cv=none; b=YdY1mXKjBRWvo7olI70Y1B8sATRSS91477FhDStM+xov8i64GEkzNtidIDj8S+NknSLlorHoRFI11YZpQsTRtHSll0dBhtVbdTPpWMVt1Ojl5H/Lg6MqRRPjT80jYSWuimn0Pbf5ge9AMaPcKz5cIoxRa9XMNfbeaACUsCS9ZjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715871370; c=relaxed/simple;
	bh=pLvfs2wkuPdWUKvnQbF+as0kuqbXNTuPzoK72qeAdQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVnFH+4FLfznEbI/mKuDd+qFG/j7pxjrJ0XVsKrNu/Lr6Ks6BElzPvxVeEa6ZsclxuvFN1NHeeYbz2r3gVtfc35O7yaYCpGS26WwneeoC6QSyery1odIaVJoFkojwB80HjMZOcdrPIMDTaIWh9SYKGe71BnVpXdG2His1cwuQcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=k7/DFcGf; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1s7cWU-002r3X-QC; Thu, 16 May 2024 16:55:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From;
	bh=GktP9RrtK0vi05fOjnT9zi0SQ8iuCCBEsFoEskXI23U=; b=k7/DFcGfjlwO/QYjfWsf62NZqT
	XKMCNeUndCzV0Jg2EwsG/tFlKOAYpxzIm7A0oXDi86E9IppJO8d0a8XoBMNtih1SajL/MjeIUmROq
	QHG8wprx7sFVA9BjRL6e39zMJRkz/N7XQJyJAEzorL1BnhCD9niTGY4BIsdFZN7xor9Lb3lg0qS0v
	aAcktpFEjn4kO8inOW+xmP2wzdRV2kvPuyboAFhXetuybkJ7+cTrExnoZZB2afWjj8UIBzsfRqEhl
	Oo1AX55sCM0iR3hny76MWgviYzQsoz83MF/Vud83yjf/AzFyqQf/1DxuKL1d90DONslIGGNKo54Zh
	uLAMWw9w==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1s7cWU-0008C2-Ei; Thu, 16 May 2024 16:55:58 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1s7cWP-000xkA-Rz; Thu, 16 May 2024 16:55:53 +0200
From: Michal Luczaj <mhal@rbox.co>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kuniyu@amazon.com,
	shuah@kernel.org
Subject: [PATCH net v2 2/2] selftest: af_unix: Make SCM_RIGHTS into OOB data.
Date: Thu, 16 May 2024 16:50:10 +0200
Message-ID: <20240516145457.1206847-3-mhal@rbox.co>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516145457.1206847-1-mhal@rbox.co>
References: <20240516145457.1206847-1-mhal@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@amazon.com>

scm_rights.c covers various test cases for inflight file descriptors
and garbage collector for AF_UNIX sockets.

Currently, SCM_RIGHTS messages are sent with 3-bytes string, and it's
not good for MSG_OOB cases, as SCM_RIGTS cmsg goes with the first 2-bytes,
which is non-OOB data.

Let's send SCM_RIGHTS messages with 1-byte character to pack SCM_RIGHTS
into OOB data.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 tools/testing/selftests/net/af_unix/scm_rights.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/af_unix/scm_rights.c b/tools/testing/selftests/net/af_unix/scm_rights.c
index bab606c9f1eb..2bfed46e0b19 100644
--- a/tools/testing/selftests/net/af_unix/scm_rights.c
+++ b/tools/testing/selftests/net/af_unix/scm_rights.c
@@ -197,8 +197,8 @@ void __send_fd(struct __test_metadata *_metadata,
 	       const FIXTURE_VARIANT(scm_rights) *variant,
 	       int inflight, int receiver)
 {
-#define MSG "nop"
-#define MSGLEN 3
+#define MSG "x"
+#define MSGLEN 1
 	struct {
 		struct cmsghdr cmsghdr;
 		int fd[2];
-- 
2.45.0


