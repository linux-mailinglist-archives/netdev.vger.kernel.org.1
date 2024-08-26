Return-Path: <netdev+bounces-121869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C4495F115
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 14:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75D8B1C22419
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 12:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CC515B108;
	Mon, 26 Aug 2024 12:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LXdqI5Aw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iCPxiqLg"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D5617C989
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 12:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724674419; cv=none; b=tg3i0fEJ+vTYPNhvd8zjB/bhH8Kh3b9QmLZ0rZ6ykG3DdFD7phMfa1AbLrzyNslBAdJO1B1Kv3BHH3HZ+vFbbetCV9jKhQ8x84cY3+U+/taMa06+uHRsypRPGUGG6oQUq+iVVmyIyUyqd6Tk4HTbD/PlVe2XXZUrtLzTnPsXOkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724674419; c=relaxed/simple;
	bh=bRXXpZE+8LDh7kltK/toG4IJRdmEW0q8FQnfZ+VnkZA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VVnCFd4yKbS8ueNIqKBRDd+BUncvORsfst4MjicACRP5zyF/9Y6R1Ttn99x7esv6TiNHBKSb882ktFYwgVN62EUC2j/0THqg+shhWGOu9t+Ien2ZGsQ8WHIWieoGumPkjHsKxrI2Cp/cumnuzMGYlGSoomU/Nph23xWXrPlm+Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LXdqI5Aw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iCPxiqLg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Alexander Kanavin <alex@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724674416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R5APvNPEkdlguIL3EcdIZpgINErqZ2rXtKDlPh0qFg0=;
	b=LXdqI5AwQWEJc0JDAKfMayx1/CIQG7raC8NkUkiWR8uX9jdpZgOPLkt2cchdD/Kel8TuzB
	Z8fLQ2x2zYvImK3CJy4zYy5v5OyZGmGsN2ueQWnFzq8E/vI1IQsB1jeqVVf3cAwwItzzcz
	3lCFB6kuU+SxgHw0ZUjm5dRFFBYCg5K384q0/w7wYsfudVKv5yRaIYdhRRGk/LfLgyALPC
	10JnsJMLgSgyOEKOplS6Za9aQSHR/CJs4c7g4CSNz1zC12ur6cSt4IUWvtycWoXMda9uLy
	dFLL2aTog9fRAwvf7WcT+VSNZaUdLOrDHqiQbnh1iitLcJMWpV0WJg+ZbNScNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724674416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R5APvNPEkdlguIL3EcdIZpgINErqZ2rXtKDlPh0qFg0=;
	b=iCPxiqLgBORa5agijd/In5urA8wxVFoY/9oT9gHT5NeC5/6qHtcL5lVs7i/att6zpNobpv
	itq0HLf4NolTDiDQ==
To: stephen@networkplumber.org,
	netdev@vger.kernel.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] include/libnetlink.h: add missing include for htobe64 definitions
Date: Mon, 26 Aug 2024 14:13:30 +0200
Message-Id: <20240826121330.3547395-1-alex@linutronix.de>
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


