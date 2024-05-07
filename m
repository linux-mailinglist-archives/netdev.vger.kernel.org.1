Return-Path: <netdev+bounces-93980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D367C8BDCF4
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 10:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E3B7B20A98
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 08:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BCD13C83A;
	Tue,  7 May 2024 08:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQ5Ayoem"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B9710E3
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 08:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715069468; cv=none; b=SiV3UyGbKRf2WwG4rLEMZk6zVbNueAJXhBRDBDff4QLsb29O4pFyqXI2A5Y/luRsIdJYm/LqgMyH7MUoiO5mkj8NpMX+TEBMcMb02NSjj4QgC8fRaHoGzTDbxGQF7xnR2fVO3nfHymLkZYDsBUVwdTJj0NSv7H/DXkGDFQlXfpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715069468; c=relaxed/simple;
	bh=C8hggTFT8GOAbEEvmE779yoYvYVHnfrhxr89UTJsHPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H0owWquQy7X9gG6HLBe4BUal6nJVI/BCMpEsBD+MoOeTVDi37iFed0VCq72Mkn/7mbHNN0N7sAscMMDhXxkSmxOYLX6fGAoKJkzrsiZFvKl16yvlQZKYO5CaiJwZxLTh+FxhYW1G0GpjqO8gACoby7MQdCzD1TdXmqPHaeJQ3TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQ5Ayoem; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1ee7963db64so2948455ad.1
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 01:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715069466; x=1715674266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+PVfZ088NlvYEhrzlXn66dekEPSs7YPtMFC02WdwyNU=;
        b=ZQ5AyoempysDC4d/0Sr0T0gftOrt5HQd5o8GQIOuvhDuf5ENqifAoTU0w+S1zkuvW1
         vNRkj5JsvEAofs+3zAUSF0ZQNSbc5bcYseHyBVMPRywgC0JZMRAu3Hl0alhZqGwuF8Sy
         /TvIUwlp80LxZL71o/aaJbMKanzX8ea0dyvpbd4AlMukBW41wLgOTrAoC9E6X8MfGiW2
         TnyfuTHIIxMbbJDfX0u+Q+6gwEh8Xd8jkwQq5mZgjAWcmMmy3CshUS8ik6MOXd7+5cPO
         dWATCKQXT602k2con7ez4VUfozUPJfd2Vuo+5Rw0/+foY3X+1tMTBjY5bN8RPYxZ0lEZ
         ljiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715069466; x=1715674266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+PVfZ088NlvYEhrzlXn66dekEPSs7YPtMFC02WdwyNU=;
        b=IU+Ty44cTI9q/1czyENa0LPZCTaKWkPauVc1WyeWdUYsGiSd3wyiBTgqG3MPR9N+k+
         e2+xnqCWMi5lTfYOhGY13yeqt/SlPKAbcQdmgdw+lk0sYXacgyei1+uzyb5zEFb31SQg
         dMzVm7tQ1g8VUFsn3yW121t9Qb3QNuBCLNPgieDbqqfOpKmtbgH3WRGr0PBXlL+7hRMY
         c6EZ21O16SGbmcChcM4GV+PauZqgjBpa9Fl100hZnLd1277IYyZcE/PFTCXj4NHMt1lD
         vd5wo97ENG7a0HZN7wmEllSDNfePTCO4cIsTEoPdeYifbRrZcty2UnmxbaFrcE00Mxuk
         YlaA==
X-Gm-Message-State: AOJu0Yy2qs6jiflYu5xDPwkhSKg9BDD/cG0OsQKttBRTr5MgF1qbQRGH
	dFdD/7QxiShSAYtDQDCOOFBPn1SD3tx00l9Y3SGUPBYxlw7kRg18LiMxEkw8sd0=
X-Google-Smtp-Source: AGHT+IEbO7DZMWvv2XesWb0speb6LOsPYDMpzbue15oa0MOC/s+SULV64HkXY5MUFK2iMxdVmD1+aw==
X-Received: by 2002:a17:902:f70b:b0:1ec:ad62:fe87 with SMTP id h11-20020a170902f70b00b001ecad62fe87mr14969597plo.56.1715069466350;
        Tue, 07 May 2024 01:11:06 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902e80a00b001e826e4d087sm9482261plg.142.2024.05.07.01.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 01:11:05 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Guillaume Nault <gnault@redhat.com>
Subject: [PATCH net] ipv6: sr: fix invalid unregister error path
Date: Tue,  7 May 2024 16:11:00 +0800
Message-ID: <20240507081100.363677-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error path of seg6_init() is wrong in case CONFIG_IPV6_SEG6_LWTUNNEL
is not defined. In that case if seg6_hmac_init() fails, the
genl_unregister_family() isn't called.

At the same time, add seg6_local_exit() and fix the genl unregister order
in seg6_exit().

Fixes: 5559cea2d5aa ("ipv6: sr: fix possible use-after-free and null-ptr-deref")
Reported-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 net/ipv6/seg6.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
index 35508abd76f4..3c5ccc52d0e1 100644
--- a/net/ipv6/seg6.c
+++ b/net/ipv6/seg6.c
@@ -549,10 +549,8 @@ int __init seg6_init(void)
 	seg6_iptunnel_exit();
 #endif
 #endif
-#ifdef CONFIG_IPV6_SEG6_LWTUNNEL
 out_unregister_genl:
 	genl_unregister_family(&seg6_genl_family);
-#endif
 out_unregister_pernet:
 	unregister_pernet_subsys(&ip6_segments_ops);
 	goto out;
@@ -564,8 +562,9 @@ void seg6_exit(void)
 	seg6_hmac_exit();
 #endif
 #ifdef CONFIG_IPV6_SEG6_LWTUNNEL
+	seg6_local_exit();
 	seg6_iptunnel_exit();
 #endif
-	unregister_pernet_subsys(&ip6_segments_ops);
 	genl_unregister_family(&seg6_genl_family);
+	unregister_pernet_subsys(&ip6_segments_ops);
 }
-- 
2.43.0


