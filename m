Return-Path: <netdev+bounces-78679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE598761E3
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 11:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3AB281B18
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 10:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42364535D7;
	Fri,  8 Mar 2024 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dyL07EFi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB03F4F5F9
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 10:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709893355; cv=none; b=Ub6EQWwIabrbRoqiYulNgQ5gDXUA/5XBJ+cj0oOgYKfFwD9UeSl37UDHuUjpsw1r3FD3d7FluH9+NH2T74m8qgepLna5jEPJJJCJEJ3SAjLsD1PjQLEqmymyN/1b2N9WzrlJT879Y3DeJ2KzA3SNItzxbzMb5KcU1zc5GQLO/gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709893355; c=relaxed/simple;
	bh=hqRCndTJshMwKmnBkhQsuGBrQJTLjMp3ghow7klXUDo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SI9PvvFehagVZS555Vwd3b8ubNqSmHAMCIFqLu6MDU94y1CXteAaeHla7RQwIfKh5G6YaSNF3exfXvSCxR+2y6BADWc0nwYfm0U4MQhdX0c79lZI4uJo1tjhwGYdczh+6RzxyU54nCz8JpZaBFIuswn5NHrXLNyVn9fxZKdCrrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dyL07EFi; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ee22efe5eeso12965117b3.3
        for <netdev@vger.kernel.org>; Fri, 08 Mar 2024 02:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709893352; x=1710498152; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JIIeDD/VkX0wMWJj/wWdMmELFvQxh9RTDyWn419wb1M=;
        b=dyL07EFikkXnCt4GxmDApKn/34KjLR0HHXxfhhwlL+OD22tDi36Xf4SMcw5n6S4Hre
         E32x2eN/nXWbPEFXFer1W5523aYs0fblE1obJDAYeq8KLpjc6P+mhO7+FWz67DGBJ3uA
         Brrq5muqpJBRaDHNrXhJHTjmYW+NimkIOMdU4eam3ohfZ0m3RY3wFT6MckMrY5Tp6324
         2xAGrzv6nAVINCAApWdvTUeVyT7/4VYFNT2JJ8W7cTICuwBcPVE5YgdreIr0hFC7Xs/a
         HVmpaBlKVTZxoph9R2x1U5gXsVBK6IiFVuHNszHh135fs+qWRvyLot4QwOH1sbr2pDdr
         Py+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709893352; x=1710498152;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JIIeDD/VkX0wMWJj/wWdMmELFvQxh9RTDyWn419wb1M=;
        b=kKJVQRsvKx4L6MA5TedEyod4D6DCdRQzOZ7AxbY13Uguft4Nm4TWseG3Dllqx86Pdg
         cqs33ez7aFUI9krZKts2pp+14dwZSDvowABHuz+33vEEeyxdSJDRUFr5iOCBHCI2vW2x
         wp5asWtHchmOc3+eqxv7SAt2B41xRTMmdFKpiLRSiINK0aGRQJro6rngr9FYNXbegi+U
         fbRGZBMEN7BJP+Eu5HqcN+HpULO20r5/3Gm+hEN8W3MRVayIeEHpcnikhzjvRVFxPlSw
         YZc1B+oDfP0vGgdlSYB4xJr6JSS41/B+Ig1RBY9zPSgZdcgirhI3+g8wq7VhB/TPL0Q2
         0U4g==
X-Gm-Message-State: AOJu0YyxAOYwvH90NuS2uquw1cLX2OWPiqmewkY14oOiJzTVGTsdqU52
	6jibvSjpDFtiZsCujBmDRs+KNFGvlYc8lzp46KujSD5XdTOACnAFlNad146fJAo7L8FASjcIqWb
	F+nYuV6z+fg==
X-Google-Smtp-Source: AGHT+IGWk3dSuGZ7sL/F44BYayqWzOeX3D2z5pY7t/SkDjbYIBDjUM6e69+67dIR06abSlMVjQYZEsELtvPcRQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:fc3:b0:608:ced0:eb2e with SMTP
 id dg3-20020a05690c0fc300b00608ced0eb2emr4295470ywb.0.1709893352675; Fri, 08
 Mar 2024 02:22:32 -0800 (PST)
Date: Fri,  8 Mar 2024 10:22:30 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240308102230.296224-1-edumazet@google.com>
Subject: [PATCH net-next] net: gro: move two declarations to include/net/gro.h
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Move gro_find_receive_by_type() and gro_find_complete_by_type()
to include/net/gro.h where they belong.

Also use _NET_GRO_H instead of _NET_IPV6_GRO_H to protect
include/net/gro.h from multiple inclusions.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice.h | 2 --
 include/net/gro.h         | 9 ++++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 4230c7f3b95961f18dfaca03ef396c886feefbf2..c6f6ac779b34ef1a8f98853c84a7a2e0192e0e8f 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3901,8 +3901,6 @@ void napi_gro_flush(struct napi_struct *napi, bool flush_old);
 struct sk_buff *napi_get_frags(struct napi_struct *napi);
 void napi_get_frags_check(struct napi_struct *napi);
 gro_result_t napi_gro_frags(struct napi_struct *napi);
-struct packet_offload *gro_find_receive_by_type(__be16 type);
-struct packet_offload *gro_find_complete_by_type(__be16 type);
 
 static inline void napi_free_frags(struct napi_struct *napi)
 {
diff --git a/include/net/gro.h b/include/net/gro.h
index d6fc8fbd37302338fc09ab01fead899002c5833f..50f1e403dbbb3805277d74ff80b504677e9a7aa0 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 
-#ifndef _NET_IPV6_GRO_H
-#define _NET_IPV6_GRO_H
+#ifndef _NET_GRO_H
+#define _NET_GRO_H
 
 #include <linux/indirect_call_wrapper.h>
 #include <linux/ip.h>
@@ -494,4 +494,7 @@ static inline void inet6_get_iif_sdif(const struct sk_buff *skb, int *iif, int *
 #endif
 }
 
-#endif /* _NET_IPV6_GRO_H */
+struct packet_offload *gro_find_receive_by_type(__be16 type);
+struct packet_offload *gro_find_complete_by_type(__be16 type);
+
+#endif /* _NET_GRO_H */
-- 
2.44.0.278.ge034bb2e1d-goog


