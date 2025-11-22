Return-Path: <netdev+bounces-240945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A47C7C7CB
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 06:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE7493A458C
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 05:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C2D293C42;
	Sat, 22 Nov 2025 05:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJudIYq9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2163D1E32B7
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 05:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763788291; cv=none; b=tt5VPl0tfuD0fP4k1S25+bjdfs9VT72Xmf3RxNPdOJom079CQGtl0yNAVJd85IexkE6jvP3N4YhCOICUIhJbjBXb0u6twRN7s7/FkhusHQjFEHU3dMtL+QaK61GByhGure/+eFaJB0mBDx6MjoKrYxnK+LExpKHt1BKC3Kq74a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763788291; c=relaxed/simple;
	bh=4WGmKEIxbtDHlLD/Nd+bS+imm5eMK6cpxlzp+VYfRxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lu9vEKqa5nqPP759TEDD1XaVUmmbretBqmM+h6BEIivWYqZiM9J8bebn/CDq9ZJ8Gk7Z5QASGvG08sJOe0Gm+EzNNIWJQhd6TWhISPbY+a8K4viX7hRatnb9ss1EcypWlE2VZXg3E2vsmGmw7rnyqNufsv2z+JnFK/biSMJqnvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJudIYq9; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7aab7623f42so2763268b3a.2
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 21:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763788289; x=1764393089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XD35sfMmXX/8uwN3Reakd+1vNNEvDnIPQgNPtrlxRTo=;
        b=CJudIYq91L9SUbmbYNEUrYAnZKfMf1m9yxl61zSrKA0AAFExIJZ2rNPUr8ibZbEKK6
         u3LR5vCMcQSQDUfeWUSWNh66puJMcXdF6FO3tPzmjS71J2et1j7lEthF4nOPj2z15L+Z
         HsQA27a0fq16R53A8mrtLeuGG3wI0JQZ7gf0ACoF3sGKH7kX4ruPy+9wwTOfLL9W7iHh
         Frs9wCk3rhZLGgyh4g8szDywqgKHbRMECowM4fkBHvCbrj6XTr3Lv148sD4aJZd8MdYp
         DNAhSHra0iQpqoCgJ3r0jy6pzOACcdF3dr2wpFeC66giEhVJeIJmHwxNIFNIV2dRghlm
         rJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763788289; x=1764393089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XD35sfMmXX/8uwN3Reakd+1vNNEvDnIPQgNPtrlxRTo=;
        b=C0PFVnzmUBEdsVKXlWooq80GQ5D9PBjBIXvTOpT8qQh89Ml1le/NNKX3VciIn1cNdn
         s1Z935b1pMoZKpA1RSGRzoSdbnFWKKFKMm0c3sgYis1/gb49EyUw69qqcVQQ67NLRwM4
         Obmi0B3aY60qXt3NDBHqp8uiO6eWpQIP0jVpLzSqn2jMho5TNwQpwwvNPp0tb7bbXDpb
         7ltjrMqMQ3cTZ7Qw9R3YkBYOxcODjq8CRwkXWpe6N2PTrUFCED0P6kRExF77FukZ/sNb
         aB7Gp6iN3RmYXDfe6I2L4NHdRzcjr3MV52JN03qzd6j1zeRSm0lxuqE9fYZdnRG6k/bg
         JdqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkzx4nmof4rkOjfuOv54xlMLLSgLTdgG6UvFZW2F0Df5pVHoXCeChxWwvwKO2AOGbpogrfG1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3kcjbshJZwLOmvCdZPKecfLJWz7N4ZuPWgJVC89PCrDdfyG4o
	MNg7QmxnwHXgouSq038is/i4gdSNdavxBIHEXn3aSiBIb3qO4t115f5V
X-Gm-Gg: ASbGncupOTtX4Nl+nkgUKaNPRasIVm8CpYpF8LsDsLKDo78/jrOEqIKEEqMz305GBW0
	UBjVaAMrxAMNY1YDIlsoaZ5JjcpG+312yFWtLKAlUwK8vSIihM2GMytsv3q6TV3IwWCh1YgMWTJ
	EBG+CwlKho+v6bmv94FxkaLa0pohJ8yG5/ADJ5peK4dx2yiwBycNmeT12iitToJNFQIERD7trAx
	dcweUT757kQ7/nibE+pZUH8ZKz4HlaQaa99rGCH9J5SleWXaQVExVqiqFR8E54PAlonc+UyswHL
	QV5QLgHGxUd4HFjuptKaHXgeMMpa3mbKdrGxvh8BcEADnbeHx84lokabqwQMs6bxVjZs/yr5Gvk
	fO0jJy5bUs+UPI7VNSnSbrPyMPf3jqo5LvnZybFWMMabr1RkJ39Cvy88fvHD+HDXpTzxV5wRtO8
	wIVXnqr+rZATMmBl3UqrOnhZfm+L1WEMk5/b5CpkZ2Zk40K6Orurpohhr4
X-Google-Smtp-Source: AGHT+IG9Q03bPNHSm20d14MPGr3lTLdYYAHYo0XRJMJ+EIwHE6+VCt4DBVJByvBpi4KUwi3LGgHy8w==
X-Received: by 2002:a05:6a00:b91:b0:7ab:5d1b:2d18 with SMTP id d2e1a72fcca58-7c58e6047eamr5756614b3a.26.1763788289323;
        Fri, 21 Nov 2025 21:11:29 -0800 (PST)
Received: from DESKTOP-EBUR9LD.localdomain (vsc10.ee.nsysu.edu.tw. [140.117.167.143])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c418e4f989sm7474745b3a.11.2025.11.21.21.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 21:11:29 -0800 (PST)
From: Chia-Liang Wang <wjliang627@gmail.com>
X-Google-Original-From: Chia-Liang Wang <a0979625527@icloud.com>
To: edumazet@google.com,
	kuniyu@google.com,
	pabeni@redhat.com,
	willemb@google.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chia-Liang Wang <a0979625527@icloud.com>
Subject: [PATCH] net: socket: add missing declaration for update_socket_protocol
Date: Sat, 22 Nov 2025 13:10:21 +0800
Message-ID: <20251122051021.19709-1-a0979625527@icloud.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When building with C=1, sparse reports the following warning:

net/socket.c:1735:21: warning: symbol 'update_socket_protocol' was not declared. Should it be static?

The function update_socket_protocol() is defined as __weak, intended
to be overwritten by architecture-specific implementations. Therefore,
it cannot be static.

Add a declaration in include/net/sock.h to fix this sparse warning.

Signed-off-by: Chia-Liang Wang <a0979625527@icloud.com>
---
 include/net/sock.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 60bcb13f045c..2081b6599edc 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -3103,4 +3103,6 @@ static inline bool sk_is_readable(struct sock *sk)
 
 	return false;
 }
+
+int update_socket_protocol(int family, int type, int protocol);
 #endif	/* _SOCK_H */
-- 
2.43.0


