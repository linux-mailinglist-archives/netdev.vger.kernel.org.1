Return-Path: <netdev+bounces-167914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFA0A3CCBF
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 23:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702223B7EE6
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 22:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5D926138D;
	Wed, 19 Feb 2025 22:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SF13xRRF"
X-Original-To: netdev@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B3D25B674;
	Wed, 19 Feb 2025 22:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740005493; cv=none; b=G2+M/vBiB9k6jwOpRmg58qGclq0gqWPs9GTJopargfpfkjEYqk44OsoKKgwQkLUeaWa3NLm/KJUWCofFwO/RACkw29jsMPvw6KA/l8mIGw9wqK6hVUxqemE6/VXPj2/uNo7ybsx7Xe/RnvFYw8ymqR/ts1lDIlz1IO6ec3HT6zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740005493; c=relaxed/simple;
	bh=kVIF8THjMUn5VVKQI5GfRlpOup0bprbVYvJKg4Gv5tU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oqFVEDwt3foy/+0Cirt7XEFAymmDF3IEY447gjCJh+eHZBv/ofH1GGUsiqFm19sjxtYOUieQJekMNq2l4XKvTbrgj2Pm0rZDzlz47xuI5/VwEAEthpaTjRzWbtd1/u9avSsFkfLjHR8YCTON5ashd3GB52lr98Lhv4WqbEluOEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SF13xRRF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id F40002043DEF;
	Wed, 19 Feb 2025 14:51:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F40002043DEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740005491;
	bh=2DsnK7hNItSeSllFiYAP/M6VSa6q+8lcbw+HDHEsdqY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SF13xRRFRtH7qnTvrO5A0O3X3Pj6uRAsloPgfZb8ngTSWG29i19O95q7viFi/qPpT
	 p9DhmJKbSRnDt70ZSbf9EChE6OIXU3rQPanGR+S+C8iKHbRmiumgfG/KjF7RbHtv+Z
	 djBAZgbA0vps9Y3zUZnp8SRaHQi17lxLr8ea5BuA=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Wed, 19 Feb 2025 22:51:31 +0000
Subject: [PATCH 3/4] Bluetooth: SMP: convert timeouts to secs_to_jiffies()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-bluetooth-converge-secs-to-jiffies-v1-3-6ab896f5fdd4@linux.microsoft.com>
References: <20250219-bluetooth-converge-secs-to-jiffies-v1-0-6ab896f5fdd4@linux.microsoft.com>
In-Reply-To: <20250219-bluetooth-converge-secs-to-jiffies-v1-0-6ab896f5fdd4@linux.microsoft.com>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Johan Hedberg <johan.hedberg@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Easwar Hariharan <eahariha@linux.microsoft.com>
X-Mailer: b4 0.14.2

Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
secs_to_jiffies().  As the value here is a multiple of 1000, use
secs_to_jiffies() instead of msecs_to_jiffies() for readability.

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 net/bluetooth/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 8b9724fd752a1a713d55630fb19fc7ffc2ac0079..a31c6acf1df2bbdc512d1406663ad06069c1f184 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -55,7 +55,7 @@
 /* Keys which are not distributed with Secure Connections */
 #define SMP_SC_NO_DIST (SMP_DIST_ENC_KEY | SMP_DIST_LINK_KEY)
 
-#define SMP_TIMEOUT	msecs_to_jiffies(30000)
+#define SMP_TIMEOUT	secs_to_jiffies(30)
 
 #define ID_ADDR_TIMEOUT	msecs_to_jiffies(200)
 

-- 
2.43.0


