Return-Path: <netdev+bounces-199814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D29AE1E8F
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 17:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2495F6A301C
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162DC2E9EB0;
	Fri, 20 Jun 2025 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feLXvdLh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21EE2E9757;
	Fri, 20 Jun 2025 15:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750433022; cv=none; b=u4y9T1GC+nojC5XPMMcNQevljtwVGiN71Glycb6uPt/ooB7Mk9dPHC/Yn4CXYJFLD+LozzvV1fnvAVcoeYT61Kss9i9fYlAeIvEdp94X+B847y6ezyGLOFp1fRRqH+eKCwfT5LkQJ0sFVhXfwWXV1ZFqwMPM1QxLZNlMXmogEog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750433022; c=relaxed/simple;
	bh=f3r5MbCT/30gnOvcMmKLC7WpxctD7ruo9tQpgEPXK2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u0AlQ/LLZx305cTwhQd7OprWS0Op2fa2MLSjTvMy9MD74Df7IbddBTzfsho1yRR/vpEthJxqATiXfFjaq6rr+34X2xPQ5+/0coDFMwvyS3gVVAY88JO/YNoj7mdhzn3OznguK384chB5uwvGHZh7cp+rYD10yIYVmzy6pL88xXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feLXvdLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB88C4CEF0;
	Fri, 20 Jun 2025 15:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750433021;
	bh=f3r5MbCT/30gnOvcMmKLC7WpxctD7ruo9tQpgEPXK2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=feLXvdLhX9uApMu/guZIrApeAeKX7aSmn1jUjZ/tc9/dHFdP/ahFnNp2bOAiomoHj
	 6Xko+cB3X8DkuD5SXft7sd1Dg9TtHtPDQE2wxOXQD0AbQgtCW+2PuS7teT8/27Jw3l
	 sf+kPPhAveRm+00kwQy62VuZDqF13sx6sMR6HLQQjY6mlGxxbV0F4Pdt1N/VvEEBtf
	 QP71HpN4uhHMhJD5AI2IwCVXwgWabOKPVMeP0//gXbYWsR2o2g56jSDufJKL0bgSQI
	 LCDBzypCuwc+nisePUJMF1uvukXSSGDLsaXTvgoweQD26oHO1djgOj2v2fXLZfMlvK
	 RKCM8T4RKbAJg==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Simon Horman <horms@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Waiman Long <longman@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH 10/27] net: Keep ignoring isolated cpuset change
Date: Fri, 20 Jun 2025 17:22:51 +0200
Message-ID: <20250620152308.27492-11-frederic@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250620152308.27492-1-frederic@kernel.org>
References: <20250620152308.27492-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RPS cpumask can be overriden through sysfs/syctl. The boot defined
isolated CPUs are then excluded from that cpumask.

However HK_TYPE_DOMAIN will soon integrate cpuset isolated
CPUs updates and the RPS infrastructure needs more thoughts to be able
to propagate such changes and synchronize against them.

Keep handling only what was passed through "isolcpus=" for now.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 net/core/net-sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 1ace0cd01adc..abff68ac34ec 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1012,7 +1012,7 @@ static int netdev_rx_queue_set_rps_mask(struct netdev_rx_queue *queue,
 int rps_cpumask_housekeeping(struct cpumask *mask)
 {
 	if (!cpumask_empty(mask)) {
-		cpumask_and(mask, mask, housekeeping_cpumask(HK_TYPE_DOMAIN));
+		cpumask_and(mask, mask, housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT));
 		cpumask_and(mask, mask, housekeeping_cpumask(HK_TYPE_WQ));
 		if (cpumask_empty(mask))
 			return -EINVAL;
-- 
2.48.1


