Return-Path: <netdev+bounces-274693-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMtPKELZzmmGqgYAu9opvQ
	(envelope-from <netdev+bounces-274693-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 23:01:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBA738E326
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 23:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 559CE302DA38
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 21:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D99A374187;
	Thu,  2 Apr 2026 21:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3B+e/gR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3F036B06A;
	Thu,  2 Apr 2026 21:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775163610; cv=none; b=hi7wHnI/z60ygnsSYTBEbKcDyC+7LfbeMtEkihfvwFvj6SACalhb+sZNtDh0qYmEs2EhmMvDl4bqI/ztjYdlrz/16QvGHv2JCRq8xiz8S4FQUz67ucS4pCwyXWu/shN1AIH3Dl3Vavdo0rJglDxNfMvWejDid3CUi4WNEski9rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775163610; c=relaxed/simple;
	bh=4+dBFp/2dX0/nE7otbzSqUV5ZMYkw2T1ilmR4ihgXQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T0nl+nXwV1lZwL6XVVN+JJ8lVLVfgFtPFvzOhCTZRjNlogbyWwolrNah+sV3LRmHY5NNMROYWqBSJMVthspzSka0wh2sxCeFKtRuBNTSFg8dXHZlQh/OZrOp7KT6d+sih8kOuqeBchVsByGW6TfxjirSQfJL+4Z+iC/H9OnoiIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3B+e/gR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF22CC116C6;
	Thu,  2 Apr 2026 21:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775163609;
	bh=4+dBFp/2dX0/nE7otbzSqUV5ZMYkw2T1ilmR4ihgXQM=;
	h=From:To:Cc:Subject:Date:From;
	b=b3B+e/gRHZFuKdxtBKdbatqhc1XsCkNlht4nsqJjb+eAqZxHzP8SfdMSg98KkJ0qh
	 oYUvZaqG9Avbr6n2+zHiNUb7wlWQ/RjpsXssTgVSxZvQeuiMtL6dNEMjz7FNbFkGYO
	 SnlwbFD9OroC1+Zu2SrrFKdBn3GCk75EpmFcqrMa/Fc6ZSkObKJ1bQGLhEdoqOXWvw
	 zkZfrEQIKJzBZtYf/m/8T6o5G6rt6NV+/XWX4g5VXBXzqVaOs8cC1+aOc8jEO2hbVi
	 Lo+ATSza7bPGG6leQ+x10+julL6GwxD+g4LCd4wITJf2nBvfFrqe75P0LKjj120ZQ7
	 LNFYQZm4ZBpwA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	willemb@google.com,
	petrm@nvidia.com,
	anubhavsinggh@google.com,
	richardbgobert@gmail.com,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/8] selftests: drv-net: gro: more test cases
Date: Thu,  2 Apr 2026 13:59:52 -0700
Message-ID: <20260402210000.1512696-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,nvidia.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-274693-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EDBA738E326
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a few more test cases for GRO.

First 4 patches are unchanged from v1.

Patches 5 and 6 are new. Willem pointed out that the defines are
duplicated and all these imprecise defines have been annoying me
for a while so I decided to clean them up.

With the defines cleaned up and now more precise patch 7 (was 5)
no longer has to play any games with the MTU for ip6ip6.

The last patch now sends 3 segments as requested.

v1: https://lore.kernel.org/20260401182625.372605-1-kuba@kernel.org

Jakub Kicinski (8):
  selftests: drv-net: gro: add data burst test case
  selftests: drv-net: gro: add 1 byte payload test
  selftests: drv-net: gro: always wait for FIN in the capacity test
  selftests: drv-net: gro: prepare for ip6ip6 support
  selftests: drv-net: gro: remove TOTAL_HDR_LEN
  selftests: drv-net: gro: make large packet math more precise
  selftests: drv-net: gro: test ip6ip6
  selftests: drv-net: gro: add a test for bad IPv4 csum

 tools/testing/selftests/net/lib/gro.c      | 207 +++++++++++++++------
 tools/testing/selftests/drivers/net/gro.py |   7 +-
 2 files changed, 157 insertions(+), 57 deletions(-)

-- 
2.53.0


