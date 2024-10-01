Return-Path: <netdev+bounces-130757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 157BD98B668
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B13221F20C79
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 08:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50991BE866;
	Tue,  1 Oct 2024 08:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNC9EjOT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441301BE855;
	Tue,  1 Oct 2024 07:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727769600; cv=none; b=hWsKDInPAR7NqlkFsAgre0CMJKt7Q+L2TYJxvzGEQg6GmtvQasPbMJXVzB/ZPjBuWRYWO8r1BG8IOhb3tRglXZmL5O5w9BsUw1DLtoId2/TQnZYP9TIsETOzm0fXCKAXvHCs5xjKQB4LlHqN5h3oc5tnHcJQbZtqYeM0689Z9F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727769600; c=relaxed/simple;
	bh=gYCPab+U6eyY6yRmHds8teTPnyl0gnPRVM7qnWkVd+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RoUcYTdMqylwlo7qxJSdp3OC4h7QJeBTqQPBmhdnCRfw/I7qfkNGlXdSc9Hda3lDlAdBn3dI3e79i5zEp2RaWkvJxfNW8REMi1hHW5pG+2g/fTZg2ceJzyCS9F330wlutgSBgaqzSsqkDIZfxz1l3Dpg58DkECgDvLpvyXq0mVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNC9EjOT; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-2e077a4b8c0so3828753a91.1;
        Tue, 01 Oct 2024 00:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727769598; x=1728374398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IpxkflJnYCzbT+jMhhi+6g6gN0FMQjEufujru1UkXhw=;
        b=fNC9EjOTc+v1MllejG+XZSWggpGMbi5rHDsctcdeJQ0iuGqxte92zTEiLt7MbGrETH
         cHDZhtqXDLBtT6v9QRhO5RwdxwONDFkPGXUMooiisHATas/LKBdBg85OIYweTeZz+AnV
         fGxRqVo0Whd6vSNJvxTNXzGz7p8Iy81miMTs0R3fyuaKqlthsYupYyTetwmcJqYs6DlN
         hYJInxuGgJo6qVMNwwwwHu/VWdLa4pri+m9hM3+t6aog9HbD181eYycIqdAUqt+EmTOM
         /tf94knsnF/HefS4ayME2cjSyT7hzEklixixeZAJrO6Y4iJXu8IAho1Whcw/ILtAyooD
         R7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727769598; x=1728374398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IpxkflJnYCzbT+jMhhi+6g6gN0FMQjEufujru1UkXhw=;
        b=cT1/AGxoJLozTOTwSZqpK5BYtU8RjA7JjugSKGBpopnv6wicXbMy6FqKcri5bInSFy
         lgSGrvC2Da2CwsM6I0hYxNVUHsHLjUCwm2Z2vJMd1OW3Kjyd/cLohRqgcEr66okQNDQg
         /3ZcsyKggAPlAuniwSCIvs8fwIB8l3CAIrQIFcmE0yowdky6FZEg51lgfy145YY/e+JM
         GiwVaIdSdx45CkESSLHknBspAq4+stHV1RfoheLcEd+1DjB624FU24IbH9SuXK0a/pAE
         XoYIriaBPCJYxEIelCTYLgBDTE15r8fsrIjRdfue+M2Ue/QSb6Z3EopyYWbRwOFRYfK5
         9LxA==
X-Forwarded-Encrypted: i=1; AJvYcCU32y48pFYjhu3ZeWWB0gCO8OIYMDRtaW0jZwJbyzwpHucO9BTskCSYDzIvKW85wirB7GtRfUQKdkeEfNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeXT3PB90Lo0T+cNG3FioFuzTZmASSb+wV8GuRpoiA0q88rpnv
	j5eV5qPQuWzfqVJbERjRHqI1Y1e8gW9/WooMOm1aflu/9cKPZrD8
X-Google-Smtp-Source: AGHT+IFJ9foaS0kMGmUaZ3fPlXXoVou4TeZwiC2Mc9XXRJAck6Nm+vx1vfU25UCka/BYb3LslY1E1Q==
X-Received: by 2002:a17:90a:d3c1:b0:2e1:1d4a:962b with SMTP id 98e67ed59e1d1-2e15a252c57mr3560683a91.9.1727769598489;
        Tue, 01 Oct 2024 00:59:58 -0700 (PDT)
Received: from yunshenglin-MS-7549.. ([2409:8a55:301b:e120:88bd:a0fb:c6d6:c4a2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e16d6d2sm13168168a91.2.2024.10.01.00.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 00:59:58 -0700 (PDT)
From: Yunsheng Lin <yunshenglin0825@gmail.com>
X-Google-Original-From: Yunsheng Lin <linyunsheng@huawei.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH net-next v19 09/14] net: rename skb_copy_to_page_nocache() helper
Date: Tue,  1 Oct 2024 15:58:52 +0800
Message-Id: <20241001075858.48936-10-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001075858.48936-1-linyunsheng@huawei.com>
References: <20241001075858.48936-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename skb_copy_to_page_nocache() to skb_copy_to_va_nocache()
to avoid calling virt_to_page() as we are about to pass virtual
address directly.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/net/sock.h | 10 ++++------
 net/ipv4/tcp.c     |  7 +++----
 net/kcm/kcmsock.c  |  7 +++----
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index c58ca8dd561b..7d0b606d6251 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2185,15 +2185,13 @@ static inline int skb_add_data_nocache(struct sock *sk, struct sk_buff *skb,
 	return err;
 }
 
-static inline int skb_copy_to_page_nocache(struct sock *sk, struct iov_iter *from,
-					   struct sk_buff *skb,
-					   struct page *page,
-					   int off, int copy)
+static inline int skb_copy_to_va_nocache(struct sock *sk, struct iov_iter *from,
+					 struct sk_buff *skb, char *va,
+					 int copy)
 {
 	int err;
 
-	err = skb_do_copy_data_nocache(sk, skb, from, page_address(page) + off,
-				       copy, skb->len);
+	err = skb_do_copy_data_nocache(sk, skb, from, va, copy, skb->len);
 	if (err)
 		return err;
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 4f77bd862e95..8b03d8f48ac9 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1218,10 +1218,9 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 			if (!copy)
 				goto wait_for_space;
 
-			err = skb_copy_to_page_nocache(sk, &msg->msg_iter, skb,
-						       pfrag->page,
-						       pfrag->offset,
-						       copy);
+			err = skb_copy_to_va_nocache(sk, &msg->msg_iter, skb,
+						     page_address(pfrag->page) +
+						     pfrag->offset, copy);
 			if (err)
 				goto do_error;
 
diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index d4118c796290..f4462cf88ed5 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -856,10 +856,9 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 			if (!sk_wmem_schedule(sk, copy))
 				goto wait_for_memory;
 
-			err = skb_copy_to_page_nocache(sk, &msg->msg_iter, skb,
-						       pfrag->page,
-						       pfrag->offset,
-						       copy);
+			err = skb_copy_to_va_nocache(sk, &msg->msg_iter, skb,
+						     page_address(pfrag->page) +
+						     pfrag->offset, copy);
 			if (err)
 				goto out_error;
 
-- 
2.34.1


