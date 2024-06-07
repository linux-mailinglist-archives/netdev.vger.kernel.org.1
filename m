Return-Path: <netdev+bounces-101920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EF39009A4
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 17:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285E2286E22
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 15:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBD4199234;
	Fri,  7 Jun 2024 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mCoQcNn1"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ECA194A68
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717775639; cv=none; b=VgeYtAD0e++0V5MEoqbz8WlQCQYRUa3pm1iFFDt6QzYdkZ3Eaw0XLabixNPYk/PaTCz3rAbPfU8jkkwfym5LU2LiKisoCGP8yiB4K5nBkKnFnl3kuHS1iPQZqUUTHS6BpURvF7pjGxvqFvz1wExvamOjGaX31Gl/KVV7c8xDdPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717775639; c=relaxed/simple;
	bh=Afd4b8hAp1w4uSm1PBjrDLeLSfwdeWEm4E62ig6MsSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5cXtYR9DSKfAWunBAuGNZcfbyK5DpCVXXMygBKpfI4t4t2BFqtn9DGwT+d9cMwrWVXaI/mSHdSbfmMwyORY7FC/A/ksRPvvPVsZRtxZ/gG/F8X2JXgQSy0stI88cBysVoFL5QlQKZMphwaqqm0Rz3vVN9+Ch1ngo8hqIVav9zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mCoQcNn1; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ju3YEJCesKFi48xBS5ZCiOenmUKAaBkVZXHd0aw5Lno=;
	t=1717775635; x=1718985235; b=mCoQcNn120LstD+z0ym8YumA5nzOOvb9Res4D//WoM4uVmf
	EzpuaoZqYuUn2LQm3gwtRZJqMhNowslI6N5s8WbGVhKEn5UfJ0pgBS5WfJZEYQq0AHyxy2KtoAo0z
	JhQXv6bOEDCYk+8xBlGmiVvFJVa3sh0ZL2L00XjKT8WK9RVNH3cFPFsqHPM8OcK4eB/izYBh6vgp4
	4kZTlHw4LEbwKK4O3pKc7U+gbWU7E3/4c1A+kJMM9MZYlQNwzH+PIv7EMKKegfacDzXWgAnIDYoK8
	WA89K0td0QMHU44WWP1OQbAWBcm5sToCZx9b/s3dto6i4Dzp7nKhbdKPlDpbb98w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sFbuZ-00000001IHx-2qJD;
	Fri, 07 Jun 2024 17:53:51 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] net/sched: initialize noop_qdisc owner
Date: Fri,  7 Jun 2024 17:53:32 +0200
Message-ID: <20240607175340.786bfb938803.I493bf8422e36be4454c08880a8d3703cea8e421a@changeid>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <CANn89iLyXx8iRScGr5zzBVJ+-BnN==3JJ7DivQE_VUpaQVO4iQ@mail.gmail.com>
References: <CANn89iLyXx8iRScGr5zzBVJ+-BnN==3JJ7DivQE_VUpaQVO4iQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When the noop_qdisc owner isn't initialized, then it will be 0,
so packets will erroneously be regarded as having been subject
to recursion as long as only CPU 0 queues them. For non-SMP,
that's all packets, of course. This causes a change in what's
reported to userspace, normally noop_qdisc would drop packets
silently, but with this change the syscall returns -ENOBUFS if
RECVERR is also set on the socket.

Fix this by initializing the owner field to -1, just like it
would be for dynamically allocated qdiscs by qdisc_alloc().

Fixes: 0f022d32c3ec ("net/sched: Fix mirred deadlock on device recursion")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/sched/sch_generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index d3f6006b563c..fb32984d7a16 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -673,6 +673,7 @@ struct Qdisc noop_qdisc = {
 		.qlen = 0,
 		.lock = __SPIN_LOCK_UNLOCKED(noop_qdisc.skb_bad_txq.lock),
 	},
+	.owner = -1,
 };
 EXPORT_SYMBOL(noop_qdisc);
 
-- 
2.45.2


