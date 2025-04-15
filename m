Return-Path: <netdev+bounces-182957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A91FAA8A72A
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 20:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 983303B5010
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4720A233715;
	Tue, 15 Apr 2025 18:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BI7MZsmW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDF923315F;
	Tue, 15 Apr 2025 18:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744743021; cv=none; b=cee5DpMtDXxVYQL+D9QGJqJztc10IPhuGJ1TQF/xjamX+k9z0CAQXtAL9L2xg+Raf0LlrXQ/UAGdMaRs+d2a3RgPowyoi/yHzcPHYfXDqTmLWbLknWLhNbU6903Cepngfez2TeyUXcXKzDyvBIZNend2AQxQo/zPkjknQWRlv+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744743021; c=relaxed/simple;
	bh=Wh9+r6C8QnFxVuYP0gI7fEkh16Fr4uto4HN5gD1lmc8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=a068dNKuNxayUNUoyqYf8HKfb3ZZPwvwtaypcxXs3HUV3xd+gULSWMlK0rFTJ3L8ogslBgFq2EDNN8b8AQph0RU9MXW+QkE9dHrmbYkM+6fU0ZEwF3WKpUlN0zCi8Bdek9WsYzW7+L8gX6Ff8x73mgM3rXXjFyXTtPZZ74vNEZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BI7MZsmW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A6AC4CEE7;
	Tue, 15 Apr 2025 18:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744743019;
	bh=Wh9+r6C8QnFxVuYP0gI7fEkh16Fr4uto4HN5gD1lmc8=;
	h=From:Subject:Date:To:Cc:From;
	b=BI7MZsmWrpStN+UFK57Vh+JYaiGy27sqvN9DyRh0TD3VVvAZG7/+W8ONOyhbBNPL7
	 r5agAYMUXNtsaU4F3qgfjATl+sQFxMa1K5b0foC6mvTp2rdeehWoCf1b+YVR9aTzbD
	 P3gM3+K7KljWg7ssH7OR38k8U3d4rV0iLd1CHbjsX35V+V9IcAyOEko8feTh4XsYjT
	 NRNlNumc3Zu2Hk3O8Rnt6fTS8x+VGdJJnX7BgmD6Wzv7qjLQA/xky4Zu4QUhTgmX5w
	 znDuosk8B0A/sWelciOSoRzCiIoFbiowIEShqIenTJLat9kMu8z1HNen8IwUYhIeJJ
	 gsf0HIqAk0wZw==
From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 0/8] ref_tracker: add ability to register a debugfs file
 for a ref_tracker_dir
Date: Tue, 15 Apr 2025 14:49:38 -0400
Message-Id: <20250415-reftrack-dbgfs-v2-0-b18c4abd122f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEKq/mcC/13MQQ6CMBCF4auQWVvTdqgQV97DsCgwLQ2mNVNCN
 IS7W0ncuPxn8r4NMnGgDNdqA6Y15JBiCX2qYJhs9CTCWBq01EbWCgWTW9gOsxh777LA5tL0KJG
 0s1BGz/IPrwO8d6WnkJfE78Nf1ff6o+p/alVCCifRtKZFrSXeZuJIj3NiD92+7x8pbae5rQAAA
 A==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1896; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Wh9+r6C8QnFxVuYP0gI7fEkh16Fr4uto4HN5gD1lmc8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn/qphBv0yiZyz25NAHCFtGVV8gUZ7l4UWmbc7B
 +j56syFNuuJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/6qYQAKCRAADmhBGVaC
 FfjaD/48Cd1Nn25CCF68ks0mWwqMtvSe77wgEdeZQlx75JAipkoc5V/CFnVddb326XiSs594Nqx
 ECjL0Z0ZKnIYbxSf91nZuAX7XErhEv0vKK1iwvMQ5gTFpIff7V+pftQdBxKKKfMffEks9cugesI
 vT/+KAv66lh0Q6aTx67jj4Z/hXKVA3DRtuWcHOcNG3WxpmLaFDRp5OcTOkRutpNP2JchDQlPXVm
 RBtAcTqB8Mfjk+sUfsPsXd4+rPlxkKTBpufgHDXkfL2qr5AjR1yaPh9a8Hyxsz3gpOFcUY2u5jA
 WbcVHOUYvU620P0DgDq6Q+y7H5Ljgun8cmuTJmR8zmBsU528wZN1PNF+43KTMon+wwlx1FYL1Am
 yN+6pk92KZMKPGG27aL29g00Aj0QAoU6HblcJlSWyM2OKx3/TWW3xxUahhphZ76qoaikuO+yUJi
 UmsTmUqZHaIEMIwKRLE8besrQHqnbE07oEg/L2A/uw1MGiSDYks7jX6z72+5T+8KOCIVhRS3cjh
 Hp98Hxh2R5QAHdbsmTKugmAF/IDVvRqs7RpMii3k+RcD/f3kXrGPolu62SCIBiWkfIpOXPmRM1P
 0CYyivox08stucvvJiwRhDQkiPFWI9nOM57mG/uZP1stpTGxPLXZzbtFRlEDsLM9D7BAIdhPNxq
 W4FqTQpXu7rYIpA==
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
      net: add ref_tracker_dir_debugfs() calls for netns refcount tracking
      ref_tracker: widen the ref_tracker_dir.name field
      net: register debugfs file for net_device refcnt tracker

 include/linux/ref_tracker.h |  15 ++++-
 lib/ref_tracker.c           | 153 +++++++++++++++++++++++++++++++++++++++-----
 net/core/dev.c              |   6 +-
 net/core/net_namespace.c    |  34 +++++++++-
 4 files changed, 190 insertions(+), 18 deletions(-)
---
base-commit: 695caca9345a160ecd9645abab8e70cfe849e9ff
change-id: 20250413-reftrack-dbgfs-3767b303e2fa

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


