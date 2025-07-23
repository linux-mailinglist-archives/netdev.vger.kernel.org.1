Return-Path: <netdev+bounces-209334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 760D7B0F3CD
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 15:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A5C51C26310
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 13:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727EA2E92C5;
	Wed, 23 Jul 2025 13:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gztozed.com header.i=@gztozed.com header.b="AYXMEE22"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m15593.qiye.163.com (mail-m15593.qiye.163.com [101.71.155.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB112E7BCA;
	Wed, 23 Jul 2025 13:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753276508; cv=none; b=VDuF6YsRimf1iNM30i5WWTJXZM6pNIza23diWEESt1D1xOU/Zr0cNA/MPHw3kmv0bMhYS2GDhGSBXgxHqySHsGxXsRgaJYDWOVoztkI/oARq5h+9W6Vo/voslMLvegO9qpCFehkvkmojYMkfSyr7I23n0XixN+yd6sMeelBTHwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753276508; c=relaxed/simple;
	bh=KpTG27xj119EH8QPiH6w84Q+rjHasCFnEYYnEixwibU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rRLuMBq7mqetYbSao9zZ3rUGohzfdJNcH2Gb8Nx/4+CYBS7LJLrA2ZKIEs1yqtxa7WLGExom2euReYG8sVmHVqw101+L4RdldsOVjq6cYq96lkyerz3dHe8/CCN/ttBK/I1oNQ4l4edYnrwSTtRKKnRR3qMZJIMHGTn61QVqvAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gztozed.com; spf=pass smtp.mailfrom=gztozed.com; dkim=pass (1024-bit key) header.d=gztozed.com header.i=@gztozed.com header.b=AYXMEE22; arc=none smtp.client-ip=101.71.155.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gztozed.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gztozed.com
Received: from localhost.localdomain (unknown [IPV6:240e:6b0:200:4::42])
	by smtp.qiye.163.com (Hmail) with ESMTP id d845d995;
	Wed, 23 Jul 2025 16:38:55 +0800 (GMT+08:00)
From: wangyongyong@gztozed.com
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wangyongyong <wangyongyong@gztozed.com>
Subject: [PATCH] net: clear offline CPU backlog.state in dev_cpu_dead()
Date: Wed, 23 Jul 2025 16:38:08 +0800
Message-Id: <20250723083808.1220363-1-wangyongyong@gztozed.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQhoYVklCHklMS0tNSB9NS1YVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJT0seQU0ZS0FJS0tBT0FBT0lZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
X-HM-Tid: 0a98366f86a30230kunmbbad5f211f61de
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NQg6NAw5CTdILT1WHEs2LEIS
	MyoaFAhVSlVKTE5ISU5CQkhNQ09JVTMWGhIXVQwaFRwCFBUcAhQVHDscAQ8UAR4fVRgUFkVZV1kS
	C1lBWUlPSx5BTRlLQUlLS0FPQUFPSVlXWQgBWUFKQ0NDNwY+
DKIM-Signature:a=rsa-sha256;
	b=AYXMEE22DZ9ZBdaZAEiAM1TbkVL0cu0sG/qV2u2lK5AETvhLAS6AgcFscu6APxea5fQ8rOQpi3rmxj3DHHJkSAdzjUbyDkGUVGg/bbOglRruv9E1uYIXPAwYG/mKR9qNL4Q0fL5AnZRVuQbhXTfEzs2K2kObwJiOdFMC5uehEFI=; s=default; c=relaxed/relaxed; d=gztozed.com; v=1;
	bh=0afn1/VAo7T4OfiA7X9buT9b9SNPrb22VYySrI//Ito=;
	h=date:mime-version:subject:message-id:from;

From: wangyongyong <wangyongyong@gztozed.com>

When a packet is enqueued to a remote CPU's backlog queue via enqueue_to_backlog(),
the following race condition can occur with CPU hotplug:

1. Source CPU sets NAPI_STATE_SCHED on target CPU's softnet_data->backlog.state
2. Source CPU raises NET_RX_SOFTIRQ to schedule NAPI polling
3. Target CPU is taken offline before the IPI arrives
4. dev_cpu_dead() fails to clear NAPI_STATE_SCHED because backlog isn't in poll_list

This results in:
- Stale NAPI_STATE_SCHED flag on offline CPU's backlog.state
- When the target CPU comes back online, the persistent NAPI_STATE_SCHED flag
  prevents the backlog from being properly added to poll_list, causing packet
  processing stalls
Signed-off-by: wangyongyong <wangyongyong@gztozed.com>
---
 net/core/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index be97c440ecd5..fd92ab79c02a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12385,6 +12385,7 @@ static int dev_cpu_dead(unsigned int oldcpu)
 		else
 			____napi_schedule(sd, napi);
 	}
+	oldsd->backlog.state &= NAPIF_STATE_THREADED;
 
 	raise_softirq_irqoff(NET_TX_SOFTIRQ);
 	local_irq_enable();
-- 
2.25.1


