Return-Path: <netdev+bounces-121001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 494D495B63F
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 15:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D161F26C90
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 13:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16C51C9448;
	Thu, 22 Aug 2024 13:17:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A269181B8F
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 13:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332645; cv=none; b=RHFvMsIkH2xiThllgSWqnA/CN1gxn3eBX4tS/ZVQ9AcZEbQRbUUR5Qd7Qg4wq9m3XQAD3ZM2mYPNIvGHkGI4Ztujw2D8tvnVyVHx5k+gd9Rpl+B7vsUwlLgdNoTdGT9ReOcJmnYHtIV8sLpX12mzGeXSKU5bJkOJH7vWmGvRkWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332645; c=relaxed/simple;
	bh=W1wYso9dYjxzrjoIYl/2pqb2t6JgrNhfsEw84MHKN1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q97H9XbX8v1aUoO64LHgTQtpXr8DT2KK+rXj+Ti7KYAJ6zl4T8426Iw4XUaBzGdgmryjnJKBBApZkw5J3SmeBejQLjFr13jntVBgPblXvVHoTRFG42x6FyvrDj6AZ6kgcFIOCpKiyWTIztmJb8suD4Qdz0tNMrixInxxAi9N4sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1sh7gk-0006oe-60; Thu, 22 Aug 2024 15:17:18 +0200
From: Florian Westphal <fw@strlen.de>
To: netdev@vger.kernel.org
Cc: herbert@gondor.apana.org.au,
	steffen.klassert@secunet.com,
	noel@familie-kuntze.de,
	tobias@strongswan.org,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH ipsec-next 0/4] xfrm: speed up policy insertions
Date: Thu, 22 Aug 2024 15:04:28 +0200
Message-ID: <20240822130643.5808-1-fw@strlen.de>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Policy insertions do not scale well, due to both a lienar list walk
to find the insertion spot and another list walk to set the 'pos' value
(a tie-breaker to detect which policy is older when there is ambiguity
 as to which one should be matched).

First patch gets rid of the second list walk on insert.
Rest of the patches get rid of the insertion walk.

This list walk was only needed because when I moved the policy db
implementation to rbtree I retained the old insertion method for the
sake of XFRM_MIGRATE.

Switching that to tree-based lookup avoids the need for the full
list search.

After this, insertion of a policy is largely independent of the number
of pre-existing policies as long as they do not share the same source/
destination networks.

Note that this is compile tested only as I did not find any
tests for XFRM_MIGRATE.

Florian Westphal (4):
  selftests: add xfrm policy insertion speed test script
  xfrm: policy: don't iterate inexact policies twice at insert time
  xfrm: switch migrate to xfrm_policy_lookup_bytype
  xfrm: policy: remove remaining use of inexact list

 include/net/xfrm.h                            |   1 -
 net/xfrm/xfrm_policy.c                        | 201 ++++++++----------
 tools/testing/selftests/net/Makefile          |   2 +-
 .../selftests/net/xfrm_policy_add_speed.sh    |  83 ++++++++
 4 files changed, 175 insertions(+), 112 deletions(-)
 create mode 100755 tools/testing/selftests/net/xfrm_policy_add_speed.sh

-- 
2.44.2


