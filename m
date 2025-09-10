Return-Path: <netdev+bounces-221497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A00B50A51
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 03:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3D221780A1
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 01:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25A621254A;
	Wed, 10 Sep 2025 01:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RnOR26Ye"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF5D20FAB2
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 01:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757468217; cv=none; b=j7w3eiF/q4OGYhrpkXudFyhdsorDoh+ddeBKOl3205m0KR5z9nhdpqi1sqz9NH3VaIARS93Iff9mO+BHFXtfk/tE+G17QHdmBtz8VtViJH1/ZI5nYk2p8aMu4dr1UOSXZ0bBNXlWtO5H6KGLW8/nT5GSxslrzPKaqhtomwIE4VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757468217; c=relaxed/simple;
	bh=fyuKbOHNbb9KE1kUJuhYtHQ3Xpm4wZ4FKITqGimJYyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1yg0JQEofuTrJ5cx7yXrQbQkopVxVJiSBbHTu5LbxjbIn3GoffPbCrlzEf0S8cZrrmtWdhTCLcVsgF8od1rnSGuWpGQUQyOY4zZ1GZRMewwqSjM9jGfxWmIlQV/7V0zqGVBNw8+AtfcLcaSmg1WS5DJ2kdhq0c0a/pxJ6MhJN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=RnOR26Ye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB94C4CEF4;
	Wed, 10 Sep 2025 01:36:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RnOR26Ye"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1757468215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wZUNmmUtFAIR/vXrGE3iA8Kz0ql/y2C76iErngZge/U=;
	b=RnOR26Yec6Hpm6QjTt8C+rJNwFcNIPTV6xowhIP9Be3gZ5Ds1Knx2uwi8KkjOPs0n7lERY
	fUwCc/v+qB7JkBULlly24Xx2xbUJhwHb9+Po55d3HXssQXeNxi2u9m0/Q/pdRLQzfwVo3C
	LhoFnOumbi4JPbGAeYW3si6X5oJAnZg=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2c56fd78 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 10 Sep 2025 01:36:55 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net 2/4] wireguard: queueing: always return valid online CPU in wg_cpumask_choose_online()
Date: Wed, 10 Sep 2025 03:36:42 +0200
Message-ID: <20250910013644.4153708-3-Jason@zx2c4.com>
In-Reply-To: <20250910013644.4153708-1-Jason@zx2c4.com>
References: <20250910013644.4153708-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>

The function gets number of online CPUS, and uses it to search for
Nth cpu in cpu_online_mask.

If id == num_online_cpus() - 1, and one CPU gets offlined between
calling num_online_cpus() -> cpumask_nth(), there's a chance for
cpumask_nth() to find nothing and return >= nr_cpu_ids.

The caller code in __queue_work() tries to avoid that by checking the
returned CPU against WORK_CPU_UNBOUND, which is NR_CPUS. It's not the
same as '>= nr_cpu_ids'. On a typical Ubuntu desktop, NR_CPUS is 8192,
while nr_cpu_ids is the actual number of possible CPUs, say 8.

The non-existing cpu may later be passed to rcu_dereference() and
corrupt the logic. Fix it by switching from 'if' to 'while'.

Suggested-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/net/wireguard/queueing.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireguard/queueing.h b/drivers/net/wireguard/queueing.h
index 56314f98b6ba..79b6d70de236 100644
--- a/drivers/net/wireguard/queueing.h
+++ b/drivers/net/wireguard/queueing.h
@@ -106,7 +106,7 @@ static inline int wg_cpumask_choose_online(int *stored_cpu, unsigned int id)
 {
 	unsigned int cpu = *stored_cpu;
 
-	if (unlikely(cpu >= nr_cpu_ids || !cpu_online(cpu)))
+	while (unlikely(cpu >= nr_cpu_ids || !cpu_online(cpu)))
 		cpu = *stored_cpu = cpumask_nth(id % num_online_cpus(), cpu_online_mask);
 
 	return cpu;
-- 
2.51.0


