Return-Path: <netdev+bounces-236860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BC2C40DE1
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 17:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D67E44F210C
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 16:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBED32741BC;
	Fri,  7 Nov 2025 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbESZ4Mw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA67262FC7
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532587; cv=none; b=p5VHP3cclxXrxaXwrd/2ZvyFY+fdDtGDoRxBKMD/8aN3qG8H0SEKsbcXl0T+8tU2jfbb9//2zvPn7Z+3ScG56PjP1UBtR7GVV0KKRxIAszrzcGnonVqyRS9TuJ/2W4lTYYGDtApjzamM//1XQLS0EeYsEJLzjRr8ndetMO4an0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532587; c=relaxed/simple;
	bh=a+fusMcYnvrbElL2TqX2zeIUejEVr8tsf43Ey+mV3n4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oIy+LwPFOGu/yWwhqUX6d0qX+lDEDk3ytpLQUu/A3g3G/ibVFtijd7jd7IOez+vlV6ATP+UrjZ27//3Sp+qqg6MTkpSdywKFKx+uP8QlAa0+vmnGP+aFQaCH0hoxeS4wpxNDWBl5+mM2M7OihHWQAUtyUCDHXsLc81jFCf+UvfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbESZ4Mw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6E8C19424;
	Fri,  7 Nov 2025 16:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762532587;
	bh=a+fusMcYnvrbElL2TqX2zeIUejEVr8tsf43Ey+mV3n4=;
	h=From:To:Cc:Subject:Date:From;
	b=BbESZ4Mw2z6X+G2/uP/4hwYpZ9qauhdIE76kw0op0ecgLUc0gXSpAG0UVdRhP8nQ6
	 Lvx3uPOoARbE68zuPWUvu/M0hPZEqiYgmzvTuADEo/l3ySRDte9F6s/pSCKkLnm9UV
	 2T2AkPuJjYrw7tzFk2FPnHwe/CNt4GeAnUe5+9nmvgE3+ZLCI6JezT5p2FmnJjAk5u
	 zPZID81iKCbnHoBl7udQHpbQ61FOqO17yM2woTm82QrNNY83xwHA/jW+RUpvCkvA9o
	 itvuNtKxomWvaHib2uKScS9pvsaIZlKXm6WnUsjL/oOEL2VOn0i9rexpe5O8Ku7TqB
	 qeizZFDkoB+Ag==
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
Subject: [PATCH net-next v2 0/4] tools: ynl: turn the page-pool sample into a real tool
Date: Fri,  7 Nov 2025 08:22:23 -0800
Message-ID: <20251107162227.980672-1-kuba@kernel.org>
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

v2:
 - patch 1 was applied already
 - [patch 1 (was 2)] use kernel version
 - [patch 2 (was 3)] Makefile cleanup
v1: https://lore.kernel.org/20251104232348.1954349-1-kuba@kernel.org

Jakub Kicinski (4):
  tools: ynltool: create skeleton for the C command
  tools: ynltool: add page-pool stats
  tools: ynltool: add qstats support
  tools: ynltool: add traffic distribution balance

 tools/net/ynl/Makefile              |   3 +-
 tools/net/ynl/ynltool/Makefile      |  55 +++
 tools/net/ynl/ynltool/json_writer.h |  75 ++++
 tools/net/ynl/ynltool/main.h        |  66 +++
 tools/net/ynl/samples/page-pool.c   | 149 -------
 tools/net/ynl/ynltool/json_writer.c | 288 +++++++++++++
 tools/net/ynl/ynltool/main.c        | 242 +++++++++++
 tools/net/ynl/ynltool/page-pool.c   | 461 +++++++++++++++++++++
 tools/net/ynl/ynltool/qstats.c      | 621 ++++++++++++++++++++++++++++
 tools/net/ynl/ynltool/.gitignore    |   1 +
 10 files changed, 1811 insertions(+), 150 deletions(-)
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


