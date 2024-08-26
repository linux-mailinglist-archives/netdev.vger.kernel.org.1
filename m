Return-Path: <netdev+bounces-121870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EC995F11B
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 14:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522EF1F2137C
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 12:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B391862B8;
	Mon, 26 Aug 2024 12:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rEdkIKp+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zr5gUy0i"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA261714BE
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 12:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724674486; cv=none; b=trHZtrcdBeeSwKC9Bwe2W+NK4NMxja0lXHhE4a89JwqzHV1WHj6NoFlkrqh4+poZUMC9PDny6rPf11EnAZKhEDBpAyZweef3y33myCHX0bzki+bh36bIFS2OmiUmX/Ps18daUZtiWGAMZ2or/g5kTXl88xNf+6LPDkJpmtogUBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724674486; c=relaxed/simple;
	bh=bRXXpZE+8LDh7kltK/toG4IJRdmEW0q8FQnfZ+VnkZA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QelGSAweqQb7a/XBpIIVHPXLbDwPwh8ZGt5lG4ADWnlFjgjPXDehnVQE7T1pDT2v+MKsMKf1tb0b986rvxtyBoI3pwNsftsTm7AkJtUwKsAKB8yGmmmQmzPhDKq+O1Q4FL6DePXxhnzb/dMgX8wkMe9WbId26cZpb6LJo/JFA9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rEdkIKp+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zr5gUy0i; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Alexander Kanavin <alex@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724674483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R5APvNPEkdlguIL3EcdIZpgINErqZ2rXtKDlPh0qFg0=;
	b=rEdkIKp+KO3qH1XD6yDFLxqa8kvaDE695hyNC2816heEOSJTcZXei1VRN8Fr7pg8HuGw0F
	GSvOst59KI8bNAFYl5be7B/hEB5bF2zv1kt/KQ4Rx53Kkh4Zk3iPqlAxaGazos2eQ7asOy
	QBAVVJHeNKWm/ZWhZSIOhyH69q9m3BqW2kUHcpz8KO7Y3Ke8etqBHc6Bq+ACsMx64ixkfO
	lukQ4Mb2/qgyZQ2m4d+HCcul3mKS7sofB5j5kskd9fv9fT3L0KgCqydVeldDoufwUYFtWl
	9ataQ9Pq+uosZN1r9Q/hPhhmd+u0EQ6wRpeNhOmtg9uGAAxTGZu0g3DirHuznA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724674483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R5APvNPEkdlguIL3EcdIZpgINErqZ2rXtKDlPh0qFg0=;
	b=zr5gUy0ib6KXw3Nje3WtchA/BTrJnPoUzwFzdAd72tpJDygUGcwOfQa8to/ghmlP0U05rB
	rQ5Lp6uii+mjADDA==
To: stephen@networkplumber.org,
	netdev@vger.kernel.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [iproute2][PATCH] include/libnetlink.h: add missing include for htobe64 definitions
Date: Mon, 26 Aug 2024 14:14:41 +0200
Message-Id: <20240826121441.3547444-1-alex@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 include/libnetlink.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/libnetlink.h b/include/libnetlink.h
index 30f0c2d2..77e81815 100644
--- a/include/libnetlink.h
+++ b/include/libnetlink.h
@@ -12,6 +12,7 @@
 #include <linux/neighbour.h>
 #include <linux/netconf.h>
 #include <arpa/inet.h>
+#include <endian.h>
 
 struct rtnl_handle {
 	int			fd;
-- 
2.39.2


