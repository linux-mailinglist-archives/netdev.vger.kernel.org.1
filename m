Return-Path: <netdev+bounces-83360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB63E8920AD
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 16:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 956A72855E7
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 15:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C5D2233E;
	Fri, 29 Mar 2024 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V/57zyWG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE4A1C0DCC
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 15:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711726953; cv=none; b=P4R1yb9FW375TdnAKsX+D70PQLZvMx0JY7Mt61SmwU0Gud9EcLv0z37IjIxgzw4Gly8Z3FEqUOeFYNdiDsfYk+txr+iTB/ByU/vZ97t77QpofBWczfuqbAGLPnslE1fxEFn/BDxm6617J7ez6tBBYF7Rl9JxZ7vmPbaeXwKPHV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711726953; c=relaxed/simple;
	bh=u6CKHjdRZ3Q3jFE+0JJbKpQLd3hkwh+kwA+sSojO8Vs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ftl32I3ZnNUUA9ajdg1KIMwwSK98yahXEjBU/mGPctB4BprjQ5lqqQ3fvLH0OQvxMjDBA1u9R6LUyKuX7QSg77pc0r2AhYHoxaPfUqGGrPmFd+9B9ZxOFu22NAjgZjtSV0bL0I1KeQBj2+e+NwQeq4UzCcUNHddvBRasU61rpiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V/57zyWG; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60f9d800a29so33195237b3.0
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 08:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711726950; x=1712331750; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zkkkR4bJVGdAmtjki7FbOrCs0xkI3kc/cNsgAoiErHk=;
        b=V/57zyWGmdJ74af3iBhnmc4mMLqMuJYJK8OesnfvTDj8w4vTidEhc+vbWCtGgOftAJ
         wup/RkfbVrU4JphGUdgT73UiYq8MP5hbC3FHfG/berG4ML0mBLCZpRlrErxNcMqt17UI
         lcYjXzHXrlu/tSM04QVJb9Pv6UwgcYioUi1IwvDbgRAjIEwaDNrY2JtYUpFO+RZLRLiK
         Dj7c0K55lZRO6SAlthj940A/g9eGLfOfJDKWjmrpA6b4J+uz9Ulu6WrhT+9/ywbd8tO6
         t7VsJlT14CpgvQLnvN+Zukjlbme5kkp7MGYqCGgz01Uk5zbZs9FhsOltGD4vkNtM/BO6
         YV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711726950; x=1712331750;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zkkkR4bJVGdAmtjki7FbOrCs0xkI3kc/cNsgAoiErHk=;
        b=YLSxrKVhHdymK2owZR57dKb6c8xkPsG0Km5wlUoSXBr3zuXxH7Cc8lAzeVCkkAiuiY
         2QlACttmTJVFscC/3IwJsqW8upLixhzjwMISAX7r/Fsc+pp1P9n689qe8ruri7JyV0Il
         Yng2s03n+eigwxgJFl3uXi+7w/MdKBCePWNWV3aC1fTENBzHa/bmjagPfjgrJclZB+VV
         O4tBUcyWOk+lhugktFWIH/ghv0tocgzGYlq48G1EaOYcHV1a3915T7OYNSDzPWtEahQG
         x40ccmyP9hg0dZ0LP8T+mBRcUfnnqMZdyGkJ/rYaEDxUVZxT3eNB/w+v+14XXT/AD85y
         Ervw==
X-Gm-Message-State: AOJu0YwgvAEkT69IrjHfL07ZSzZ+6asiK7hL/dvQMmKXDpz0hWgjKLSd
	xBg5S8k8SX8lD246uKqfwxUitBUIgWOBFYKJLyDEILgEgwZkNTUu41ZRf8TraLVG0pLvJCWOtTE
	B/VG3CNbv9A==
X-Google-Smtp-Source: AGHT+IGjll7A2Nr2rtwocEmp671U6FBxfcSmDJeqrqPHRiHBVwV0W1kC+FFRW9y50kbv6OE4FdVlcTqvoMDSyw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:4e10:0:b0:611:5ca6:59c3 with SMTP id
 c16-20020a814e10000000b006115ca659c3mr553411ywb.6.1711726950558; Fri, 29 Mar
 2024 08:42:30 -0700 (PDT)
Date: Fri, 29 Mar 2024 15:42:19 +0000
In-Reply-To: <20240329154225.349288-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329154225.349288-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329154225.349288-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/8] net: move dev_xmit_recursion() helpers to net/core/dev.h
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Move dev_xmit_recursion() and friends to net/core/dev.h

They are only used from net/core/dev.c and net/core/filter.c.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice.h | 17 -----------------
 net/core/dev.h            | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index cb37817d6382c29117afd8ce54db6dba94f8c930..70775021cc269e0983f538619115237b0067d408 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3270,23 +3270,6 @@ static inline int dev_recursion_level(void)
 	return this_cpu_read(softnet_data.xmit.recursion);
 }
 
-#define XMIT_RECURSION_LIMIT	8
-static inline bool dev_xmit_recursion(void)
-{
-	return unlikely(__this_cpu_read(softnet_data.xmit.recursion) >
-			XMIT_RECURSION_LIMIT);
-}
-
-static inline void dev_xmit_recursion_inc(void)
-{
-	__this_cpu_inc(softnet_data.xmit.recursion);
-}
-
-static inline void dev_xmit_recursion_dec(void)
-{
-	__this_cpu_dec(softnet_data.xmit.recursion);
-}
-
 void __netif_schedule(struct Qdisc *q);
 void netif_schedule_queue(struct netdev_queue *txq);
 
diff --git a/net/core/dev.h b/net/core/dev.h
index 9d0f8b4587f81f4c12487f1783d8ba5cc49fc1d6..8572d2c8dc4adce75c98868c888363e6a32e0f52 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -150,4 +150,21 @@ static inline void xdp_do_check_flushed(struct napi_struct *napi) { }
 struct napi_struct *napi_by_id(unsigned int napi_id);
 void kick_defer_list_purge(struct softnet_data *sd, unsigned int cpu);
 
+#define XMIT_RECURSION_LIMIT	8
+static inline bool dev_xmit_recursion(void)
+{
+	return unlikely(__this_cpu_read(softnet_data.xmit.recursion) >
+			XMIT_RECURSION_LIMIT);
+}
+
+static inline void dev_xmit_recursion_inc(void)
+{
+	__this_cpu_inc(softnet_data.xmit.recursion);
+}
+
+static inline void dev_xmit_recursion_dec(void)
+{
+	__this_cpu_dec(softnet_data.xmit.recursion);
+}
+
 #endif
-- 
2.44.0.478.gd926399ef9-goog


