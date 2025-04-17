Return-Path: <netdev+bounces-183751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD45A91D63
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0529418939A1
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 13:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554D8246335;
	Thu, 17 Apr 2025 13:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvQDlgYU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ACD2459EF;
	Thu, 17 Apr 2025 13:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744895481; cv=none; b=ejRJSNGgbFpIBHMXBK8NNSQoIml0W89tbY/S86JTxveon3GgQRxdSE6bX+8chZa097LFBkMe8x/kJ3csK8PyjFrjla88Q5K0d5zCVnUhVBRD9dhFZiM1Znrx4jV3j/5tNO3Eda4xzprnW97185lfgSXeUE20k1UW9afuKxrFhag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744895481; c=relaxed/simple;
	bh=OUxNWwrgg8j3G4t3OFx/R6btyXfDE8RJw7HclDZsGhs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Yrw8dMzI7jniYfWtMTky7BCXmb642uYTu5m841+AudfEANukWXkAHGZPWGcBIDVkVOqIN+Kj/fw8pnH9o0xs7cIKxvoC+MDXo2dJVinppQ+lT4aAdvD3U5KgKyvJG1SVdOVEj+NsyVux9piZ7ZYgBlf1ohlJbtlu73C4s4iAE6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvQDlgYU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B1BC4CEEB;
	Thu, 17 Apr 2025 13:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744895480;
	bh=OUxNWwrgg8j3G4t3OFx/R6btyXfDE8RJw7HclDZsGhs=;
	h=From:Subject:Date:To:Cc:From;
	b=DvQDlgYUDPe1mX2ENKDI9+XTvQn/iPj1bO2WpAmSsAslei0e4jfLmPCAHc5zimuie
	 wDGHWgQUOXhRYwviuU2nLgRJ8+e6LzgxEuE4zBTjJwuQYa0P9cK194JIM6581XBhpL
	 H347j5nuabDiMOE0fOOCzRhUd6MxTbeKoF2o3PE/MZ+0R4Y0DSR9SgSTVHUKqi9Q7J
	 DvC3GHNqlgtCMiY13tPHKHiNTv/GFNlLgRfMtTSTB46PAqxTjXFZ5FX2QKPQW/FOr4
	 5xByBWEZHGAdPIG6McNJZcPK6Xqg9OInVAOy5cPDpyuoHeR0HRldhH+atAEB4hq773
	 p6LtODri6XWAQ==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v3 0/8] ref_tracker: add ability to register a debugfs file
 for a ref_tracker_dir
Date: Thu, 17 Apr 2025 09:11:03 -0400
Message-Id: <20250417-reftrack-dbgfs-v3-0-c3159428c8fb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOf9AGgC/2WMywqDMBBFf6XMuinJjKnSVf+jdJHoRINFSyKhR
 fz3RqHQx/LcyzkzRA6eI5x2MwROPvpxyED7HdSdGVoWvskMKFHLQpEI7KZg6l40tnVRUHksLUl
 idAaydM+/f2zByzVz5+M0hufWT2pd36niN5WUkMJJ0pWuCFHSuecw8O0whhbWVsJPX//5mH2rq
 rowtlGI7stfluUFZxaX1+0AAAA=
X-Change-ID: 20250413-reftrack-dbgfs-3767b303e2fa
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2122; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=OUxNWwrgg8j3G4t3OFx/R6btyXfDE8RJw7HclDZsGhs=;
 b=kA0DAAgBAA5oQRlWghUByyZiAGgA/e7IMar3vmCgsyCLDC7IMa65WUNtIC07DtMKSrKE0INin
 okCMwQAAQgAHRYhBEvA17JEcbKhhOr10wAOaEEZVoIVBQJoAP3uAAoJEAAOaEEZVoIVMf0P/A/A
 c3HgXO1eZujzv4qdBLZoYLTDgQnOlO9R/Hv5E/0pBxBrvTVOxEc0PlQiI6vofGOJYBrTy0fdE2u
 83eoJpc8i4KUp1P2IG7g5kUJT1KzOpAL8OyOCb4hAYFS4BalfeSG4AZ460bF8jEqwMqJXnD5FKn
 LsaaixCy2TBDcBZ1n905lYwOq9dS9cYKnb3ndJ976l5kjaX1QN79qXRaaknSK0+o0n7+91CsW+g
 f09/GHlZ2MuweKQ+DWIuQeymUTY5nf1Zb7GL7swnCl+j1yL3QxP6xvK1E9hR/rbjobCiofAd2Za
 qN3W1dcmmTz3BDpqWpcfOsHUgilPgBX9kSA0yMvK3LhI9JfQdhYR+h4pkfuNYZyuR7TqSizpYNh
 qbnuo6ljdKdK4zEj3Yc7UV64kzS4+xr/ellk8AdIHVJ4UZA0t8+sKfqD7YrNgUoeI9u+Fddf02s
 Y7IOPn3Rbb65kKuHm+oGsGUP0mJCmtbuW4kEz4kbk8rV+7BvzJCoF179MivZIDRYjIGAdtJpjtz
 2Vmm9zVylv2hNV+lxITUdVH+mAcRX+Z4112tMirzXgIQljgcuQO1/dtsoEL59AF6IHkLC/uzPTk
 Jmpqba9WP1X6z22meI3rGr6fthoILMzuEyJzbPvIX/EsnifhVS8t+mE/eNP8nTu95gSS47U+0k0
 jRcib
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

I had previously sent some patches to add debugfs files for the net
namespace refcount trackers, but Andrew convinced me to make this more
generic and better-integrated into the ref_tracker infrastructure.

This adds a new ref_tracker_dir_debugfs() call that subsystems can call
to finalize the name of their dir and register a debugfs file for it.
The last two patches add these calls for the netns and netdev
ref_trackers.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v3:
- don't overwrite dir->name in ref_tracker_dir_debugfs
- define REF_TRACKER_NAMESZ and use it when setting name
- Link to v2: https://lore.kernel.org/r/20250415-reftrack-dbgfs-v2-0-b18c4abd122f@kernel.org

Changes in v2:
- Add patch to do %pK -> %p conversion in ref_tracker.c
- Pass in output function to pr_ostream() instead of if statement
- Widen ref_tracker_dir.name to 64 bytes to accomodate unique names
- Eliminate error handling with debugfs manipulation
- Incorporate pointer value into netdev name
- Link to v1: https://lore.kernel.org/r/20250414-reftrack-dbgfs-v1-0-f03585832203@kernel.org

---
Jeff Layton (8):
      ref_tracker: don't use %pK in pr_ostream() output
      ref_tracker: add a top level debugfs directory for ref_tracker
      ref_tracker: have callers pass output function to pr_ostream()
      ref_tracker: allow pr_ostream() to print directly to a seq_file
      ref_tracker: add ability to register a file in debugfs for a ref_tracker_dir
      ref_tracker: widen the ref_tracker_dir.name field
      net: add ref_tracker_dir_debugfs() calls for netns refcount tracking
      net: register debugfs file for net_device refcnt tracker

 include/linux/ref_tracker.h |  17 ++++-
 lib/ref_tracker.c           | 151 +++++++++++++++++++++++++++++++++++++++-----
 net/core/dev.c              |   6 +-
 net/core/net_namespace.c    |  34 +++++++++-
 4 files changed, 190 insertions(+), 18 deletions(-)
---
base-commit: 695caca9345a160ecd9645abab8e70cfe849e9ff
change-id: 20250413-reftrack-dbgfs-3767b303e2fa

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


