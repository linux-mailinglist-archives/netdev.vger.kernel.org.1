Return-Path: <netdev+bounces-167913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B651BA3CCB5
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 23:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E53623B543A
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 22:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB5825E447;
	Wed, 19 Feb 2025 22:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Y2DN8i2U"
X-Original-To: netdev@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AD925B673;
	Wed, 19 Feb 2025 22:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740005492; cv=none; b=XIm2WHy0oklTaiIpDXjWcxZo31ijFJxAmw9F5yCY0fxk1pqzK315DpcetfzDHzz/+Y92y5waE06CT/B2Z9i0bM7S/OMiQa51EAWei8dczWCBJVDO10W+tlPFrYLcca2wOFv6N47RGhtFL0o1xQQ+CFjfTobDJayRziEr1cO59xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740005492; c=relaxed/simple;
	bh=PBRXF9armMwgta/H3/VUaDSYrb+lremo3eCzpe0UShA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G/pV9/vjqEJuDSTaryC3FoYbP6aqxDGDW8QQADORPRSC938wSOqHgGjfrIX6/d8HZPFwzoWe8D0C5pATQAIBWJU4ETrrZf4bz/B1+xEt+TGhJU3hqfC64BmqjfqPeQxh6QH2O0X5drDm3DIUke1OUHtPe3gOUEjNcHua6bRNEnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Y2DN8i2U; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1A3002043DF1;
	Wed, 19 Feb 2025 14:51:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1A3002043DF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740005491;
	bh=rjHqqoVAzbNhdmiRuBxyTe/4zXmj+hrF7l9thmBLfyY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y2DN8i2UgkKldcLp26BsQd2v12X64B14cuMRJbdsKXjM3PQX3kOpTVwmct/Ap6DI0
	 HnGdsLkEIBxW42PXorqUBLNQLfV86qruIWHwrr1NUVrhWQwYHpK3CqA+vKs97PC5OD
	 8hE5S+KDdg1W+9gWRQyTJ1o3HjM7CJZgR4mZNEuw=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Wed, 19 Feb 2025 22:51:32 +0000
Subject: [PATCH 4/4] Bluetooth: L2CAP: convert timeouts to
 secs_to_jiffies()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-bluetooth-converge-secs-to-jiffies-v1-4-6ab896f5fdd4@linux.microsoft.com>
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
 include/net/bluetooth/l2cap.h | 4 ++--
 net/bluetooth/l2cap_core.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 9189354c568f442ccd55efa37d639a613be470ce..0bf8cb17a6e864793f84a4bc8620414a7a396b2f 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -38,8 +38,8 @@
 #define L2CAP_DEFAULT_TX_WINDOW		63
 #define L2CAP_DEFAULT_EXT_WINDOW	0x3FFF
 #define L2CAP_DEFAULT_MAX_TX		3
-#define L2CAP_DEFAULT_RETRANS_TO	2000    /* 2 seconds */
-#define L2CAP_DEFAULT_MONITOR_TO	12000   /* 12 seconds */
+#define L2CAP_DEFAULT_RETRANS_TO	2    /* seconds */
+#define L2CAP_DEFAULT_MONITOR_TO	12   /* seconds */
 #define L2CAP_DEFAULT_MAX_PDU_SIZE	1492    /* Sized for AMP packet */
 #define L2CAP_DEFAULT_ACK_TO		200
 #define L2CAP_DEFAULT_MAX_SDU_SIZE	0xFFFF
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index fec11e576f310cda115c924245458368a663528a..bc820958cb9230545d99a942a73ba53eaccba14b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -282,7 +282,7 @@ static void __set_retrans_timer(struct l2cap_chan *chan)
 	if (!delayed_work_pending(&chan->monitor_timer) &&
 	    chan->retrans_timeout) {
 		l2cap_set_timer(chan, &chan->retrans_timer,
-				msecs_to_jiffies(chan->retrans_timeout));
+				secs_to_jiffies(chan->retrans_timeout));
 	}
 }
 
@@ -291,7 +291,7 @@ static void __set_monitor_timer(struct l2cap_chan *chan)
 	__clear_retrans_timer(chan);
 	if (chan->monitor_timeout) {
 		l2cap_set_timer(chan, &chan->monitor_timer,
-				msecs_to_jiffies(chan->monitor_timeout));
+				secs_to_jiffies(chan->monitor_timeout));
 	}
 }
 

-- 
2.43.0


