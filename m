Return-Path: <netdev+bounces-165957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89431A33CB3
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 11:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E09F3A56D6
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 10:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2657D21128A;
	Thu, 13 Feb 2025 10:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="nMTfaWoQ"
X-Original-To: netdev@vger.kernel.org
Received: from forward202a.mail.yandex.net (forward202a.mail.yandex.net [178.154.239.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD6C211A2B
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739442309; cv=none; b=YqNNI0M/a82suAFN3QQBRNHZDxVUpl6F1zSmXxo7Bd6stTrfKJcR0rYrSm4nv+ic7VUGHyujteQALevjcpe2QF/JV971bW5vrz/gb+j/2x/Gnh79L+hDD4vxLejFw6dyFoO6muZwljlO8ZZzNJlHTt1wJY7HbXO2vVXH8k88tRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739442309; c=relaxed/simple;
	bh=sLmXcgWQPjdZ8YiDrrkRYYh/14fsaciQH9W4NMZijBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f8u/ct8D/4B+HiNzocY0TyBe+liv1dTnLbUXg/KrV+J23W9BV74znFr56mzzPjAVerJ6piC1QGFsoH6xyxlFGwJmoHHvAODfZ1BSXq3nR24X9u/90uDCyxmaUy/IQIdUG5wyiCmnPukQd9Hw95nOdp7wqnExJRORnatVuDnmNuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=nMTfaWoQ; arc=none smtp.client-ip=178.154.239.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
	by forward202a.mail.yandex.net (Yandex) with ESMTPS id 1970F68E15
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 13:17:40 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0d:9:0:640:2d51:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTPS id 7F0EC60C80;
	Thu, 13 Feb 2025 13:17:32 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id UHN94v0OpKo0-SiMejDLf;
	Thu, 13 Feb 2025 13:17:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1739441852; bh=okt5lvHNOAV/TQNY6M7BsY4Wv3YTcQzaa2a50WvPPnk=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=nMTfaWoQq7a0IKXyePlc3ORr9I3LFGBpMt5iMqC0MRSIsLGi5pqQwAZ62Ft0KtvHr
	 hXdMztsOB0Ki4AQbBXiAMXNved9N3OR9soyy1QF0GdovDCr4a7YOUeOonQPv1roR9/
	 WlTOqX0HwP8PVJgfaGSfcFNAob2zFOoEOII7Zc60=
Authentication-Results: mail-nwsmtp-smtp-production-main-52.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH net-next] net: skb: do not assume that ktime_t is equal to s64
Date: Thu, 13 Feb 2025 13:16:58 +0300
Message-ID: <20250213101658.1349753-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'skb_get_timestamp()', do not assume that 'tstamp' of 'struct
sk_buff' (which is 'ktime_t') may be implicitly converted to 's64'
(which is expected by 'ns_to_kernel_old_timeval()') but use
the convenient 'ktime_to_ns()' instead. Compile tested only.

Fixes: 13c6ee2a9216 ("socket: Use old_timeval types for socket timestamps")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 include/linux/skbuff.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index bb2b751d274a..200b1dc48b27 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4307,7 +4307,7 @@ static inline ktime_t skb_get_ktime(const struct sk_buff *skb)
 static inline void skb_get_timestamp(const struct sk_buff *skb,
 				     struct __kernel_old_timeval *stamp)
 {
-	*stamp = ns_to_kernel_old_timeval(skb->tstamp);
+	*stamp = ns_to_kernel_old_timeval(ktime_to_ns(skb->tstamp));
 }
 
 static inline void skb_get_new_timestamp(const struct sk_buff *skb,
-- 
2.48.1


