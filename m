Return-Path: <netdev+bounces-136855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 614659A3431
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 07:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178B51F2462E
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 05:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D2817279E;
	Fri, 18 Oct 2024 05:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0gyRDEUX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E6F20E30D
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 05:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729228996; cv=none; b=HZJvHXRlYrMfsTHWvMQ/RTqYnADmE/nVeTne338G9FUXECdE1WG3n6ALLMMTFMC51s/ZN2HClWq1oEo79VRW5+R2CZoarD5YVYFjdhTNFVNanHV/CezfSH0GbWItbwj/XcjuvIrO8ehpcCV/AJlPuRx+wFLG9VSDaBOICxm3BPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729228996; c=relaxed/simple;
	bh=5Z0fpYosQpDIgVSx6Tn1NacK0QkzRgp4LS96LTiFp/g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=l66x0aKfKA43x9ab4Iw4H1fWjxZo4SYCLcZdkI45zgv+uBt2Z7tCGo6DKRSCka4JHBxkjMSMIpHiPhTQ9h3TpUZ3dRdncLaW3t1RfPPQw4rgnvrXng8S2pBWGUkPmt8lc43q7sr70Wf8V6N1q2GReY6lrj4UO/V9WKY/+XAW6Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0gyRDEUX; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3d6713619so32306097b3.2
        for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 22:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729228994; x=1729833794; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=afscFukNlKoZsqHEdG35fKXHbYNW9PwkOErpOv0CumI=;
        b=0gyRDEUXX6+AZSd2iNdn5jADhU2oi10/OdyqgI7KbdoOepBX+FKhnKanSe3bobonoS
         veZHExnwYe2gjyJjsTLAvg9en5xQmG4upJ4qpXAbIyU6ZTYkjYrytNk3lmD4KiffYlKW
         RKT9bg4omchayOO00hsb6JiYH+CV84nLq0AB3Aw8U/SdoUvQSPnwoEpDVQ6Ed2upXj58
         yGJV5gNoRhCFIhfP2JFx+KUgvYNwXA7//gxpWjtUU6xRbhtV9jX3R4CYQLOBnrYVGqLN
         3/CjrLb4J2Zh6QbHUS24s9No/4zAk1uVTZBE3wU2RyOzjsBopGrzv+wgg+vbs4aoDaH5
         84Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729228994; x=1729833794;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=afscFukNlKoZsqHEdG35fKXHbYNW9PwkOErpOv0CumI=;
        b=h2ByZNfwdBBoYOpfexLJmXzrEsBtj9vL8KFDx88Im7IxxIFCUUeB5ResfsPdNCIxJ+
         YIu+A9uO944zapn1StiSiyX1BylOAIdtS9Xm4AfqtkCOJoffuOi2VRiBFlRerTjlj8vh
         Il2hFGYbG6OedIIzKK6zEKrqsskDplbFVeQsLykPAuClCDZB3wo5El2lVPsx21iByVFb
         YQGKKeFGt2K8jDjM+ZwHIXJysMlPHkmO3hWOez9VzOz0ldP9uZoaOdqUogAnlOd1R3uM
         V9R/y41dFbnkUZ+HwldaI4kNeNrdtCaFZMM8E8w/SH+5DQv2RJgoOk/rTU+ZBL3syYoQ
         jinQ==
X-Gm-Message-State: AOJu0Yy9f+KnpWoru9OUw3FSR8VJ4wLlZBKLc8h+zc560FomSakeKcfg
	eV2alM5O/hTrWaCTbwNwYnzyxu+a0zlItrRQ5IeMFviXwZx1hsOjloZzsnpzGOy5bt2Enk77DXL
	Dwf81x6TMLQ==
X-Google-Smtp-Source: AGHT+IF3sBRtUZUboQJ1x6fLIU0TkD9005+Ncaci94ZTO/wqrTBLSkeaQcLCVMGZ8pdr9+XWPunSyvLOMn2nzg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a05:690c:4292:b0:6e3:3407:8575 with SMTP
 id 00721157ae682-6e5bfd8ec7cmr40157b3.8.1729228993919; Thu, 17 Oct 2024
 22:23:13 -0700 (PDT)
Date: Fri, 18 Oct 2024 05:23:10 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241018052310.2612084-1-edumazet@google.com>
Subject: [PATCH net-next] net: netdev_tx_sent_queue() small optimization
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Change smp_mb() imediately following a set_bit()
with smp_mb__after_atomic().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 86a0b7eb9461433822996d3f6374cca8ec5a85b9..bbd30f3c5d290f323394d9f6f9b668f4d87ae042 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3517,7 +3517,7 @@ static inline void netdev_tx_sent_queue(struct netdev_queue *dev_queue,
 	 * because in netdev_tx_completed_queue we update the dql_completed
 	 * before checking the XOFF flag.
 	 */
-	smp_mb();
+	smp_mb__after_atomic();
 
 	/* check again in case another CPU has just made room avail */
 	if (unlikely(dql_avail(&dev_queue->dql) >= 0))
-- 
2.47.0.rc1.288.g06298d1525-goog


