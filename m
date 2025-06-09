Return-Path: <netdev+bounces-195751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E58FAD227F
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 17:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0985D1888701
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 15:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A6B42AA6;
	Mon,  9 Jun 2025 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brm+jFUh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5581619992D
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483182; cv=none; b=uJUhPycCP6T8cXbgVuzSpUcHhSh0kgYaX1IbwxcRRu71qpgCkaRkFC+C3P4044A+N8WgmvRXycPWxhCOexJEPy4cnNOBoPH0Z/fa1/noM7u2jGLFJ9K4IJwra3d/TD58cHhk+gIxA5NnZUMULpocw/E/6u8fg6/xxSEu8CAa+z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483182; c=relaxed/simple;
	bh=IvCYo4WUfTdCGvrzzlTNx3vtDnL0R8hCugQXRRv3law=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LZEEOK+nOCMfW+yxQcf2zJrXNTjyRLHIhdH9Epr+4qmR7GjZA4jhxqpvcSdFvHq1AJDn3PuL2rJTa7Sx749v4l6uSdYliatfNAoWPLuCQA/lniI+poKZT+XhhpCvEKulmqy4G0pBDMzchh1XP/pd36v7zCG3c9i9735AQkosKBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brm+jFUh; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-70a57a8ffc3so42858137b3.0
        for <netdev@vger.kernel.org>; Mon, 09 Jun 2025 08:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749483180; x=1750087980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IuKQJgNWs9iKMlDLAROBf01xXyNk3WkCc0S9K3f1IGA=;
        b=brm+jFUhgnns2Dc5TTOk+9Ts57Ta8+ci0WLlkub9sfSxACeyOXBJTXiXEr//5fYAv2
         7RTitZ8p9pVNMnhsFut0yeil0rG1a69rIwxh+oNk+kCAC1B1rLBsMj2RkJTRWa9WbrSL
         +A9spjac1uRBGM39ZQ9lWB7mXd3kly+abu84rLUlIZDtKNGckGmNfNxF0QQweWj+vNDg
         dq8ru3mEmhA/46YBd/Bw4RT6mcAqWdToplyK4vjKgeRN4o7Wrvkt2RJyMFDbUn4pBmtl
         tF67QGRzonAlZhc8skCt61Cmr/0Ofu6JUx4fySrpzxi0WH8/doopWWcpSPGj8NDK5kGW
         gKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749483180; x=1750087980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IuKQJgNWs9iKMlDLAROBf01xXyNk3WkCc0S9K3f1IGA=;
        b=Wqf/vDClTeUt2hFxsMua7VzWFh4BHXBr24Hqx7VAhHsZPgWpMR5sWq50v24eOgfoKk
         AlubmDwPP8gPRJF4eyRllRxSNZeW85Fy73TzVt8Z9wuL+WJIuzD1WrxsxZ2v4o3drUOQ
         0KenM3n/ApysCcyZ7qLG7Knf/t0wwwwxFB4FFnj7/jfue2m7213ebHLj6ebJ/gm86pI7
         WV0drkVVb8pkU23w+GUJCcwEv8FF6OSkVM5oAKrJhyqO3fZeeyZ46LJEVxeod8uCg76w
         RwBU5v7Qcq46CjcFfwc1o45MUDh6do5EXJVu/4aqfZBVm2BnM7qZJA7O4BaTQ9wo5nDR
         Zh2w==
X-Gm-Message-State: AOJu0Ywq+yPDLymUK49HOvF65YP0+IRi08/nAr6iE0au87sFDzTHVREv
	9SFi3/5tYB/3qWcPfnePD/t5gt3SE923w5IRKMTFpYUXqZ8rJTvUdRtNA8BY6w==
X-Gm-Gg: ASbGncvQ5OkQTOdLcgC7rBPcLvrc2nJTz0bza11BvSmdROVSbGDp9K6TJleG1J+2Asj
	YiS2BogpWn0mN27mR6fT3he43xqHqjZNZURKnEz685CQgPPyH6a2V6g8vg6oSNryGGx3nb3B8U/
	GC+ahO9AYfNzElOxKb8pNcyc/QmEvC8grOQQgVCAuHMrfHPdE/ugCAt1crCpwjHEVJHup3t6iUl
	IgzgHXM5mRhO58kqNvP2uvCVLgI9lknDIqK7D1zPQO15Ol8wRiVnvA+sFOJnU87O5mBOmOTa9Ie
	/hMP0ONZhU5duxhg7sJg9Z3r3nDs1pM5mP4kqjZBxyweUiNT3+8qgRYR+PoI77XHXKAxZ+m9rFq
	XXMedvkZPgCVlljpF/MavG2TErTb2KhR4kF/56PloWCo+Vw2W7koYqQ==
X-Google-Smtp-Source: AGHT+IGnd0F8hka5gDDiA2ACB6VqOKctuknp7pCoNyds3Y72kCpK/fEr6zbP/NctKBKH9Hy5Q9cbMg==
X-Received: by 2002:a05:690c:4902:b0:70f:6ebb:b29a with SMTP id 00721157ae682-710f771066cmr182077987b3.29.1749483180184;
        Mon, 09 Jun 2025 08:33:00 -0700 (PDT)
Received: from willemb.c.googlers.com.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e81a40217a2sm2345216276.13.2025.06.09.08.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 08:32:59 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	kernelxing@tencent.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next] net: remove unused sock_enable_timestamps
Date: Mon,  9 Jun 2025 11:32:35 -0400
Message-ID: <20250609153254.3504909-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

This function was introduced in commit 783da70e8396 ("net: add
sock_enable_timestamps"), with one caller in rxrpc.

That only caller was removed in commit 7903d4438b3f ("rxrpc: Don't use
received skbuff timestamps").

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 include/net/sock.h | 1 -
 net/core/sock.c    | 8 --------
 2 files changed, 9 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 92e7c1aae3cc..85e17da5c9db 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2982,7 +2982,6 @@ void sock_set_timestamp(struct sock *sk, int optname, bool valbool);
 int sock_set_timestamping(struct sock *sk, int optname,
 			  struct so_timestamping timestamping);
 
-void sock_enable_timestamps(struct sock *sk);
 #if defined(CONFIG_CGROUP_BPF)
 void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int op);
 #else
diff --git a/net/core/sock.c b/net/core/sock.c
index 3b409bc8ef6d..502042a0d3b5 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -837,14 +837,6 @@ static void __sock_set_timestamps(struct sock *sk, bool val, bool new, bool ns)
 	}
 }
 
-void sock_enable_timestamps(struct sock *sk)
-{
-	lock_sock(sk);
-	__sock_set_timestamps(sk, true, false, true);
-	release_sock(sk);
-}
-EXPORT_SYMBOL(sock_enable_timestamps);
-
 void sock_set_timestamp(struct sock *sk, int optname, bool valbool)
 {
 	switch (optname) {
-- 
2.50.0.rc0.604.gd4ff7b7c86-goog


