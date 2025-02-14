Return-Path: <netdev+bounces-166609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B994A3692E
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 00:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A1A170942
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 23:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CFD1DEFE8;
	Fri, 14 Feb 2025 23:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahHpkJUQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30A11DDA00
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 23:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739576794; cv=none; b=EWubOA1+Lffx3nePDzvn83JhSjLA9yQ0hlSBhkZlxUejqV17iDT+8dcVzXjsry4XmLu6booY1gDW0oEJaW9inhgGXxsWbmEFIyI1Y2+BNaCOQC/HNUEChVh0fGh3B5Zk2ghy0/A8eGTlKgZzmJ9OYCrCsoRQXOfQwdA/AIOBYCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739576794; c=relaxed/simple;
	bh=/RHPPvP1EPMU/oeVar62Wk4+SB16KHAI42Nh+Ibc25c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dh4qTAMN3mdhLO+bgxMo74xzUb0hqem9/O2Q8c3lnqt3LlRJ2Q/tq6KeOinmrm2T/UFPhYHwkGQee0QzunGKk0gc7xeoLe0qXIyyxQyzTPEs9cpXYTjJ1twhle6U3NqcODBtLmWbtVWyd+bEpsAyPFdxYYzlmwh/MI1rrI/Vf34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahHpkJUQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C07C4CED1;
	Fri, 14 Feb 2025 23:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739576794;
	bh=/RHPPvP1EPMU/oeVar62Wk4+SB16KHAI42Nh+Ibc25c=;
	h=From:To:Cc:Subject:Date:From;
	b=ahHpkJUQoE7TWaxAob5PUkQ8fGHkNslPtzNaSlR/6QASTc2im0eVZLCOP4JoDKWzi
	 4Xdb2sDyj0VQIy8CEoeBf1iMbLIlSD3YgCkGtXSSewn4B/wCX0SFP2OE0TZ1R3c7j0
	 0GIvpgSM19iwhqdWJZjEQk5lWUV3lFVQcxI1wLlqSsD/DbEr7gYY+Ewk5nqed8+098
	 7GGABCVRauwZvb9QqDnEQv8FpLTo4obw5/3RPLEo0bWCEmGXXpwNu5P0EA16IUycOe
	 uC3kN8BN9GAVrKxx7ZUZg761y3bM6HdNmfnHLHe5rULlU5cVOjx+zj2gAD3icb6iGR
	 VBhywba2Id5SQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	petrm@nvidia.com,
	stfomichev@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/3] selftests: drv-net: add a simple TSO test
Date: Fri, 14 Feb 2025 15:46:28 -0800
Message-ID: <20250214234631.2308900-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple test for exercising TSO over tunnels.

v2:
 - [patch 1] check for IP being on multiple ifcs
 - [patch 3] lower max noise
 - [patch 3] mention header overhead in the comment
 - [patch 3] fix the basic v4 TSO feature name
 - [patch 3] also run a stream with just GSO partial for tunnels
v1: https://lore.kernel.org/20250213003454.1333711-1-kuba@kernel.org

Jakub Kicinski (3):
  selftests: drv-net: resolve remote interface name
  selftests: drv-net: get detailed interface info
  selftests: drv-net: add a simple TSO test

 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 tools/testing/selftests/drivers/net/hw/tso.py | 234 ++++++++++++++++++
 .../selftests/drivers/net/lib/py/env.py       |  19 +-
 3 files changed, 252 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/tso.py

-- 
2.48.1


