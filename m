Return-Path: <netdev+bounces-209551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9022FB0FD3C
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 01:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71B351C86AA1
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 23:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0856122F16E;
	Wed, 23 Jul 2025 23:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zo8DaV4x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85B7A95C
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 23:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753312769; cv=none; b=ih/jozqfhsnteC54jW8MH31CJcYosHdbhTQCFElkA8b2PBQPI3jGbGmXPAvSqY6AGBarAoOacX1ubULRxkCmN5A2Z4GZopVL3C32zlFAzCEQCDOWjaEHIpCekL/0eiiG3QHSrfYeM19tXbwP6hoAObSqGPLUz0DfZmlGmVFrqLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753312769; c=relaxed/simple;
	bh=J3nOpgLdwswyRj4Ig/hSV5Xm2PjZFqZISJ9JUEnm30c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m/ekvijncQnIDSzRecmLoEk81GXGh7tMbsg4rXxoeBFDvy3Q/pHaQUNlqgwutUqyfp3eS1zxnU7dcIMgcVGVK6llOpRzK0KYaLf7vsayyhM16Jb+foqnG9Rkt2DuqbpXDD9Kjv+yDjuyjcxvdyNSyJ0x5u/4YwByEg2wEmztSCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zo8DaV4x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC48C4CEEF;
	Wed, 23 Jul 2025 23:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753312769;
	bh=J3nOpgLdwswyRj4Ig/hSV5Xm2PjZFqZISJ9JUEnm30c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zo8DaV4xpI5B56porthD38Fl8h2Z6ALn2+jC17nNYwAYlEe5xIFu8vWGpv1dIXG+a
	 iuX61LnazXXBqMavCoS49XMm3Ja9C9LOL6qVVkhA6yEzpnl9Hm+SOP4BT+ABstK7Z2
	 FVIDfGUP/bbUbshdohtxgZuvQsmdNIvK+L6aRyrtzmQ4uGQ7h8HC4o2o//FeRaakBD
	 1v4fYpBgw1CKuXTmG67JSD6A2YBRmUnKZhe8YTDVCWYdCgweDYDHDr24Va5TylOar1
	 uGGmIef8BDGzy6t0kV/Yv+18or27e3HIwuxujguj4iKlRFIgIrsDcW39eE1EBdMj3R
	 3xSriZJpWqoqQ==
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	James Chapman <jchapman@katalix.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH 2/6 net-next] net/l2tp: Add missing sa_family validation in pppol2tp_sockaddr_get_info
Date: Wed, 23 Jul 2025 16:19:09 -0700
Message-Id: <20250723231921.2293685-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723230354.work.571-kees@kernel.org>
References: <20250723230354.work.571-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1539; i=kees@kernel.org; h=from:subject; bh=J3nOpgLdwswyRj4Ig/hSV5Xm2PjZFqZISJ9JUEnm30c=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmNue//VzO2rntsGCa45nay2Jllq47MF1rEk3ryqmGYG Ndd7Q1tHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABNZKMjwPzL+uhyr7AaN+sX6 T129V9qv+Rq40mHHzJvzG9/c+BbcG8zIcMzva1RVtoa4qIBArDdfY+LPggl+XcEt+qwZKftvrpR jAwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

While reviewing the struct proto_ops connect() and bind() callback
implementations, I noticed that there doesn't appear to be any
validation that AF_PPPOX sockaddr structures actually have sa_family set
to AF_PPPOX. The pppol2tp_sockaddr_get_info() checks only look at the
sizes.

I don't see any way that this might actually cause problems as specific
info fields are being populated, for which the existing size checks are
correct, but it stood out as a missing address family check.

Add the check and return -EAFNOSUPPORT on mismatch.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: James Chapman <jchapman@katalix.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: <netdev@vger.kernel.org>
---
 net/l2tp/l2tp_ppp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index fc5c2fd8f34c..767b393cbb78 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -545,6 +545,13 @@ struct l2tp_connect_info {
 static int pppol2tp_sockaddr_get_info(const void *sa, int sa_len,
 				      struct l2tp_connect_info *info)
 {
+	const struct sockaddr_unspec *sockaddr = sa;
+
+	if (sa_len < offsetofend(struct sockaddr, sa_family))
+		return -EINVAL;
+	if (sockaddr->sa_family != AF_PPPOX)
+		return -EAFNOSUPPORT;
+
 	switch (sa_len) {
 	case sizeof(struct sockaddr_pppol2tp):
 	{
-- 
2.34.1


