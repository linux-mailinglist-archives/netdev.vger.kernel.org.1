Return-Path: <netdev+bounces-121129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D2895BE37
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 20:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A076C1C21833
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 18:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19791CFEC1;
	Thu, 22 Aug 2024 18:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbmkLIqm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6642AE77
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 18:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724351227; cv=none; b=u1PLBUwk13kNB7FVCudv9BS0CyA7eZG5ALsgK00j1U2O43DZ+Bc4F+GJpy2k+ZFHCCfpOzK4+xH6UWWb9Fl53VqxG0jUj4H/vtFKzajEy/fEoRwA8RAMFjHBwz3GG3T4Z6fjKUjFNWR0tboNofTfmWmS3BslClqRt9+nVLLpSqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724351227; c=relaxed/simple;
	bh=wSEt6aoqsiHLCmJDqStNLqDoFQ8sZrq+QBvcCjT9iXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h3omtstRAsnPaHca9znfVdu4IhnbDuJjMkEN6fejGmkqdEbs+ETqekqEd6qZaOvczZazeiekJYG2H7oPRtIuBqRO2PJFfPspbcOiwLHqLD+5dK3DekEfQsmB8Gtqqydug34+vf7gvqZdSHNcOZaceNhv31liyJIBGMLCAprj5O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbmkLIqm; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7cd8d2731d1so802101a12.3
        for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 11:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724351225; x=1724956025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8fbAa2ZY+SgjHZnEhb/DyXvRt8ctJacA+3fJKY5T4nw=;
        b=NbmkLIqmXxG2zclcj7RUd2bv9nN3JmCpvVwW00l8JPsK5hjrE3juGF2Yqh/7VcwCnl
         QBxICPXHrPZvhDS92i8p/6MMuPkaOM06DHW4A7WKoo/Ic3xt8umpWu6qtjRBI7mZMqpa
         3y3TR/2iikhozrnC7MHlSxEjzNjtEHb1JXFoR8Yj4Gk//Ax8A+hVA4i1dfrxo/NnHw0R
         esJdfSfeqcD2vV6uDb14nxluBmrXdFE4f2dnUNQVg9XG+F+mCpinDHch+I9MgYgb//La
         qLypJba3hlHjHcWeMwadqy4k1IIqKyibdBx0M6LsANKAMhKIQVenUiSVeRs1Ww6Rl5Or
         zw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724351225; x=1724956025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8fbAa2ZY+SgjHZnEhb/DyXvRt8ctJacA+3fJKY5T4nw=;
        b=CSGPlH92oRHGMXXaiS3VEh9YV1l2WcXzGTTrbNktloD4sHMLX8e6MIWmkBg913WCDE
         x2jYVgab+tuVeJ22FmP4/WwdBa0GN/FfkQa6mYwMA8yGGPeEKDaUZWDt2SY4r5BiTQ3w
         gJ9YGO79lgeTd3I8MnI7RVLnH1QX6Hp14s7iHGVBpRDZPflep1nqMkNgRRtPS1Bzx9hZ
         v0txydaNj/doAy7aMp1/55x85ynOkwDKhveISgBUlsHd+2KWwYOlBLfVjpThBaZoeHSD
         n/U5jEY7lMXqnQG31Sr6A1gKMQFPEsJrYEBdmrYD/aMbV7WIhonFWDcPGszlkrMlJxi2
         GKCw==
X-Gm-Message-State: AOJu0Ywni3PX64FYiPpv6Bv1oFef3TfN6V+lCzNWDvOPE2RUAwOfUIIS
	5GSIDrfTkdpsmB1gaOgcOGbdKGxq/TC2xoaN5tJdPVzc8TjfwkOa5UtPCA==
X-Google-Smtp-Source: AGHT+IFOM+HMkcWgurvjSbA+z02pf9pgcRTrwjIPK+X4xr2uZ3qvG6akosoVqVRIlhB/T1krZb65kQ==
X-Received: by 2002:a05:6a21:710a:b0:1c0:eba5:e192 with SMTP id adf61e73a8af0-1caeb2364fdmr3313283637.27.1724351225455;
        Thu, 22 Aug 2024 11:27:05 -0700 (PDT)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:f613:5225:65c2:5d89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714343060e1sm1741697b3a.149.2024.08.22.11.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 11:27:04 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <cong.wang@bytedance.com>,
	syzbot+8dbe3133b840c470da0e@syzkaller.appspotmail.com,
	James Chapman <jchapman@katalix.com>,
	Tom Parkin <tparkin@katalix.com>
Subject: [Patch net-next] l2tp: avoid overriding sk->sk_user_data
Date: Thu, 22 Aug 2024 11:25:44 -0700
Message-Id: <20240822182544.378169-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

Although commit 4a4cd70369f1 ("l2tp: don't set sk_user_data in tunnel socket")
removed sk->sk_user_data usage, setup_udp_tunnel_sock() still touches
sk->sk_user_data, this conflicts with sockmap which also leverages
sk->sk_user_data to save psock.

Restore this sk->sk_user_data check to avoid such conflicts.

Fixes: 4a4cd70369f1 ("l2tp: don't set sk_user_data in tunnel socket")
Reported-by: syzbot+8dbe3133b840c470da0e@syzkaller.appspotmail.com
Cc: James Chapman <jchapman@katalix.com>
Cc: Tom Parkin <tparkin@katalix.com>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 net/l2tp/l2tp_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index af87c781d6a6..df73c35363cb 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1620,6 +1620,9 @@ static int l2tp_validate_socket(const struct sock *sk, const struct net *net,
 	    (encap == L2TP_ENCAPTYPE_IP && sk->sk_protocol != IPPROTO_L2TP))
 		return -EPROTONOSUPPORT;
 
+	if (encap == L2TP_ENCAPTYPE_UDP && sk->sk_user_data)
+		return -EBUSY;
+
 	tunnel = l2tp_sk_to_tunnel(sk);
 	if (tunnel) {
 		l2tp_tunnel_put(tunnel);
-- 
2.34.1


