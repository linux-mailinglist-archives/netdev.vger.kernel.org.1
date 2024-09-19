Return-Path: <netdev+bounces-128974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E430097CAE8
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 16:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53B30B231C4
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 14:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89FD19E7E2;
	Thu, 19 Sep 2024 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdJsdLqL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEF419E83E;
	Thu, 19 Sep 2024 14:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726755777; cv=none; b=KVI/ymmmasqydAOqQM2h3i2JPjV9oWtu27LklAv+K3K8YlHA7VM8QvN7OPA0V04a+U1jDmPIAuT0sAE0VUyJPEbJSV2e8Y2IlFt+0PF0rEJ6qP8EMWSoKCvp2UaqQmbaDwbV3er8BGhx+Z/nJEMLaT4dcBmr2JW8MrcziagxbSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726755777; c=relaxed/simple;
	bh=1qEUXToOlEMPlWTxyafhAWZzs5byWw1rjWUSwvJMJ7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CnoywV1m7CZ0aSKALNW7X3RaGImxU04hzvQQ+GL2eUoSkhoJbPtoY851pjpFRT2p75yKe74Av5L9SzbnQW/xL8uvX+b5lDnINeY5IyglZRZHt+vYO+Yz6+D7V/3gZU035PuNbvg/wFSZr2FCLIksORxSgmCfQKfVICvWGf+XEwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdJsdLqL; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20573eb852aso13801635ad.1;
        Thu, 19 Sep 2024 07:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726755775; x=1727360575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WyB2UEn6mFhEk7w1MJXgZ0FKzV3A1wAqVCGm/9lpJoM=;
        b=SdJsdLqLkRKiZ8unUeKzfXwv1Px+FhtG5UJ8lyTGvYkApuWXlXvdhIIz/sjtY7xVFA
         sckaDv1JQ3z0KwgcKXy1V2YI1yVKQQd/rQghJMg+UEVFksSUGMD70NEeTmkrjgzGQexY
         KcNbTK7q24hGlWMj/zqCWzSP9pWEvnOInNcmjfBT3Z8/3eQeSeJZQYJ0mQztGzWGmtHD
         cpJKlF+SrTekgqHKDv8onBoibZWSD+O6RnGg7lJB6V6fVwKeMmKZeo9fnXmgiWzzKkm2
         wYGRMAmzfpRlb1KIfmDsURcy7NEmaZtBx4VIhDuBmjnM7O2FAmHM8XBjPaQeloLw7Zwf
         6JQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726755775; x=1727360575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WyB2UEn6mFhEk7w1MJXgZ0FKzV3A1wAqVCGm/9lpJoM=;
        b=OwAycCI/h0umu2tUjShXykgrjnr475Vbj65+5qWT3J27hylJTcGFYoXBkOaz0rvW3n
         PzMQ+G0t0gCf4iBh//R6DNQtTh3GQz6IKTiKf7eod58JkLZM2VD1rtzWgMTwmc8gohZ4
         caGdifSnUr8IHI1noM8CWSxBSohLeX2xJU0gtO88bAgojFM0dQ8BZtorGIHm7yaF+2/2
         uMy/SFI9l94mV4rfIYZmIDiA83t8htFVk9fUZkONZd2Wir+aNwQC7tUFsQg40vcnhB74
         j1lwRHz+XNzPGJOTAdQ6jLbjIs3pcrnO1ty8YkhUdbC8jeJOepoLoeycRgix6Pqs+CY7
         L+YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpYCjZJ2uFEXbdWDlxQhzMthZzD6kU7j4gwab1b/fOvOWtTCNuO3Jcuw2XakV1wkbw2RgAYVR1m8veXq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtIeEOMjrabWbuiFbokVmxhZQZOw6bRNB0xlQKpGQTAW1FHyBw
	Oidx67jguXkOi6SOuZ3zj0lTTi5dSMh7ZbSVjLWnv0Zuq4CZXrQE
X-Google-Smtp-Source: AGHT+IERziNT+qkzkTLbTq37VNvWjLGIjwiVMvTLigr4YS8nv+wNmMeLS49leoBHRrXvuKWhA9nLzw==
X-Received: by 2002:a17:903:230e:b0:207:60f4:a3bf with SMTP id d9443c01a7336-208cb8a340emr47863715ad.2.1726755775459;
        Thu, 19 Sep 2024 07:22:55 -0700 (PDT)
Received: from localhost.localdomain ([218.150.196.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946f7ab7sm80535865ad.189.2024.09.19.07.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 07:22:55 -0700 (PDT)
From: Moon Yeounsu <yyyynoom@gmail.com>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Moon Yeounsu <yyyynoom@gmail.com>
Subject: [PATCH net] net: add inline annotation to fix the build warning
Date: Thu, 19 Sep 2024 23:21:49 +0900
Message-ID: <20240919142149.282175-1-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes two sparse warnings (`make C=1`):
net/ipv6/icmp.c:103:20: warning: context imbalance in 'icmpv6_xmit_lock' - wrong count at exit
net/ipv6/icmp.c:119:13: warning: context imbalance in 'icmpv6_xmit_unlock' - unexpected unlock

Since `icmp6_xmit_lock()` and `icmp6_xmit_unlock()` are designed as they
are named, entering/returning the function without lock/unlock doesn't
matter.

Signed-off-by: Moon Yeounsu <yyyynoom@gmail.com>
---
 net/ipv6/icmp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 071b0bc1179d..d8cc3d63c942 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -101,6 +101,7 @@ static const struct inet6_protocol icmpv6_protocol = {
 
 /* Called with BH disabled */
 static struct sock *icmpv6_xmit_lock(struct net *net)
+	__acquires(&sk->sk_lock.slock)
 {
 	struct sock *sk;
 
@@ -117,6 +118,7 @@ static struct sock *icmpv6_xmit_lock(struct net *net)
 }
 
 static void icmpv6_xmit_unlock(struct sock *sk)
+	__releases(&sk->sk_lock.slock)
 {
 	sock_net_set(sk, &init_net);
 	spin_unlock(&sk->sk_lock.slock);
-- 
2.46.1


