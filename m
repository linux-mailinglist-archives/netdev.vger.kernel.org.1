Return-Path: <netdev+bounces-218333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0339B3BFD2
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 17:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9037158257C
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 15:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE1233470D;
	Fri, 29 Aug 2025 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hp0OYd+2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5330322DAB;
	Fri, 29 Aug 2025 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482526; cv=none; b=QgC+kip4zBzw598q8JeffhUx14jEp5Cceue9O5Px/8+hejs76KWkAHZRwxUaVbf6TRpGpfesSqcilX//R7bvOMqpIOFdguZjEmA1H8sT0WCMko8eI8YIQIz+EASivisjJWZUORuq2IlsHaeHaenemRixtBNghZZK6tD7uFgnSqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482526; c=relaxed/simple;
	bh=U7eyQBqVG5JlKE7cyq1KJwK1IWz3fkCZph3lla7l9vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L1pL7Qt9MhZt4FdLZ4B5pE1os7i/7qOBove6TUFHLH64oiUotjKlq4peQoXK9wR3k9952fDkCaFGtpE3aLuLH71u8/0pIo2R1GWxqqlVSP6tD6lZSgv4SP7X87VDRaEtog0xfs7cRO82jUmoBtVK8C+j/36WJNLfhI2icZS+KZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hp0OYd+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E329C4CEF5;
	Fri, 29 Aug 2025 15:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756482526;
	bh=U7eyQBqVG5JlKE7cyq1KJwK1IWz3fkCZph3lla7l9vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hp0OYd+2n5wRqQ6ZKiUimFOUYgcVS8QRf9udh1+NKUfkIjnZskUmuCzBKJ0DaVeNH
	 9Y7ltHZWPFHAuztmnULe0zLBsabJh5T4s/irezDhU3OUtke1q//NqJ6egIaelEg99w
	 /P5OGicva6Gy+D2NTRU1G4N7AS3QhzkLiN2cxez+7VfrYo6poRd5MRVWbivp1N57or
	 DTMAMHWpSuJ9EW/otuIQa3dGuVJEbRw5MQrGsQNiBz82SH61iriKFVtChdlD+GKehK
	 8P+h8iNnQmT+KcM5kkAo5Oo82OdVJuATqfXVVmCZ/pKoHjlQlil8BlD3luhMzxkRLW
	 Evp3Xrf8z1ztg==
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
Subject: [PATCH 09/33] net: Keep ignoring isolated cpuset change
Date: Fri, 29 Aug 2025 17:47:50 +0200
Message-ID: <20250829154814.47015-10-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829154814.47015-1-frederic@kernel.org>
References: <20250829154814.47015-1-frederic@kernel.org>
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
index c28cd6665444..9b0081e444d6 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1022,7 +1022,7 @@ static int netdev_rx_queue_set_rps_mask(struct netdev_rx_queue *queue,
 int rps_cpumask_housekeeping(struct cpumask *mask)
 {
 	if (!cpumask_empty(mask)) {
-		cpumask_and(mask, mask, housekeeping_cpumask(HK_TYPE_DOMAIN));
+		cpumask_and(mask, mask, housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT));
 		cpumask_and(mask, mask, housekeeping_cpumask(HK_TYPE_WQ));
 		if (cpumask_empty(mask))
 			return -EINVAL;
-- 
2.51.0


