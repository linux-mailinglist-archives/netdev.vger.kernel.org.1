Return-Path: <netdev+bounces-96924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6188C8399
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 11:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B55C1C214C0
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 09:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ACF5224D6;
	Fri, 17 May 2024 09:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="o/Rff7Tf"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD3C20B02
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715938330; cv=none; b=oJT6CGHpDj0AyTSR0IKDKMjevx5Vz2lV0yOub4pD1A3DdKxZurAXnwMFBsZ9jNgW6QWBJcpTJlOa7t/Tk6ixCf32xUQmAdsaVYGbUaciPmNNWhCiPGKamskdPGZ1lRThOzAu12hcVK2DkI5EDcHLZgREoEDJu0OpXZe5ntTOAcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715938330; c=relaxed/simple;
	bh=pLvfs2wkuPdWUKvnQbF+as0kuqbXNTuPzoK72qeAdQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mK5St/fLoM/3S0MfoINJulKt4PyiZy8rKaEAhUxQYQwKPmHZPJPPv5dD+/J/3SIJLd07thZHTf7ZIV9beirCC43egFhPyKBQtZZhtxPig83bMk8a9Viu5SjIu5Gk5eV7YTUOlRmjrAbvHf9S2ksd01TYk8VkHm+cp4LYHc1EuEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=o/Rff7Tf; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1s7twW-005L3q-9k; Fri, 17 May 2024 11:32:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From;
	bh=GktP9RrtK0vi05fOjnT9zi0SQ8iuCCBEsFoEskXI23U=; b=o/Rff7TfwisIau/2rbG4RQC+9u
	NFqMhK1GiYxLc3bfVwkF0bqX0tVDp0FjUF0JUb7hyxdA62+oVDtQ6bh68/RhR8pKTwuAaLRLHuSNt
	Qvyxmr09vO2NrWT0wCjUAWqnkhN+q/ZDmHBg315lKJuR2LJb25c2owtWK0Kk9qnF2PwfGxqRZ4s/g
	Q2Uh6eDew0cgeWBo0NDxigSBM5HIffYokIq5NcY74arqMYRHK1VXnJSr1E93jDhHN0wesK88pcKi/
	CZJh3etkt1KnbfXNHFosZx47n3Sf/Euf6oeFWPPxiFofhXIns4nriExChIVwQ14JUPGJH7dtkGRSn
	RyswGCIg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1s7twV-0002B1-IS; Fri, 17 May 2024 11:31:59 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1s7twQ-0042Jz-IF; Fri, 17 May 2024 11:31:54 +0200
From: Michal Luczaj <mhal@rbox.co>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kuniyu@amazon.com,
	shuah@kernel.org
Subject: [PATCH v3 net 2/2] selftest: af_unix: Make SCM_RIGHTS into OOB data.
Date: Fri, 17 May 2024 11:27:02 +0200
Message-ID: <20240517093138.1436323-3-mhal@rbox.co>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240517093138.1436323-1-mhal@rbox.co>
References: <20240517093138.1436323-1-mhal@rbox.co>
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


