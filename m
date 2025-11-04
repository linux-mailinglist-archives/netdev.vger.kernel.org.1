Return-Path: <netdev+bounces-235629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D1FC335EE
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 00:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73418189936F
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 23:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4192DC339;
	Tue,  4 Nov 2025 23:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1aZll3U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63EC2D9EC9
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 23:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762298635; cv=none; b=XkAhkBzyDZ+1gnsph/rjPRBJoa3AA178IuuHrWv2I3R7SFRHZgmNbCsnHTQyHF/JYHtv2t+B3hjGMX0Ee4DddAy+TcCXNz3Vy4bn4JHd7uLeKVk1yBO/3GHI3C/7zFBYany9AN6cEJvuE9KPAO2ebH1ppy4zUORuC4U5wN3fjnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762298635; c=relaxed/simple;
	bh=mPocchRMYbFyfwmElMdP4nk+czzqLCV3nr2nxfU6c9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aq2LbBmWc9wRVGl9c2WZvyYJq5tKSlgePkN6acqR1YcnkpfgQAxTUsY4dBnq0yzQJ4ZKUcAR0tR0kmPOJ02ORQO+qOXmyzUR/WBH3kj2xHDLBg3eNS8zYtLSUy6haBWkVoPNe8kkoh9Mb6Y8xWJ3+wiMhtE6ZurRIGRYARTdU8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1aZll3U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C822BC4CEF8;
	Tue,  4 Nov 2025 23:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762298635;
	bh=mPocchRMYbFyfwmElMdP4nk+czzqLCV3nr2nxfU6c9Y=;
	h=From:To:Cc:Subject:Date:From;
	b=R1aZll3Un+AiDvyiHls1FLdxPDXLvz3Cunn4XUfbt32EE3Xv58D5EvnsudCW4ZXtD
	 PprsdVsOPcy4R+v1jB3k/zLFJNJhFfc2/rtAjQW2GlimhqhYFMFtnki6OS/T5pleJv
	 hRf7uL4bsV7OIyuyda8cr31Sc9PKZqQhLkafz+IuWPcYeFuAkJHALN/srCYPe0vG/R
	 dORCKA6nflPgvw/bwGEKFS3bgR1p8JSihg2O74HFHZOUaURYVKFCsPMYTZvkHineYb
	 iV3CrVTBizYr03OkvIw/cs0So5oqrBCWTmXOMlBFGeZT4NCRtgdZ9LI1fFlU3OW/Ko
	 FDAONNnrFOtxw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net,
	donald.hunter@gmail.com
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	sdf@fomichev.me,
	joe@dama.to,
	jstancek@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/5] tools: ynl: turn the page-pool sample into a real tool
Date: Tue,  4 Nov 2025 15:23:43 -0800
Message-ID: <20251104232348.1954349-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The page-pool YNL sample is quite useful. It's helps calculate
recycling rate and memory consumption. Since we still haven't
figured out a way to integrate with iproute2 (not for the lack
of thinking how to solve it) - create a ynltool command in ynl.

Add page-pool and qstats support.

Most commands can use the Python YNL CLI directly but low level
stats often need aggregation or some math on top to be useful.
Specifically in this patch set:
 - page pool stats are aggregated and recycling rate computed
 - per-queue stats are used to compute traffic balance across queues

Jakub Kicinski (5):
  netlink: specs: netdev add missing stats to qstat-get
  tools: ynltool: create skeleton for the C command
  tools: ynltool: add page-pool stats
  tools: ynltool: add qstats support
  tools: ynltool: add traffic distribution balance

 Documentation/netlink/specs/netdev.yaml |  23 +
 tools/net/ynl/Makefile                  |   3 +-
 tools/net/ynl/ynltool/Makefile          |  49 ++
 tools/net/ynl/ynltool/json_writer.h     |  75 +++
 tools/net/ynl/ynltool/main.h            |  66 +++
 tools/net/ynl/samples/page-pool.c       | 149 ------
 tools/net/ynl/ynltool/json_writer.c     | 288 +++++++++++
 tools/net/ynl/ynltool/main.c            | 242 +++++++++
 tools/net/ynl/ynltool/page-pool.c       | 461 ++++++++++++++++++
 tools/net/ynl/ynltool/qstats.c          | 621 ++++++++++++++++++++++++
 tools/net/ynl/ynltool/.gitignore        |   1 +
 11 files changed, 1828 insertions(+), 150 deletions(-)
 create mode 100644 tools/net/ynl/ynltool/Makefile
 create mode 100644 tools/net/ynl/ynltool/json_writer.h
 create mode 100644 tools/net/ynl/ynltool/main.h
 delete mode 100644 tools/net/ynl/samples/page-pool.c
 create mode 100644 tools/net/ynl/ynltool/json_writer.c
 create mode 100644 tools/net/ynl/ynltool/main.c
 create mode 100644 tools/net/ynl/ynltool/page-pool.c
 create mode 100644 tools/net/ynl/ynltool/qstats.c
 create mode 100644 tools/net/ynl/ynltool/.gitignore

-- 
2.51.1


