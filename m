Return-Path: <netdev+bounces-242654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6F1C9374E
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 04:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BAD53A7027
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 03:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EF41EA7CE;
	Sat, 29 Nov 2025 03:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CfxNUmzL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130963B2A0
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 03:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764387763; cv=none; b=QbAcdoGeUffCLPpCaXxtqlFUZ3cFEHbqNgdVO6xKEyMId5RJtovoCk7SjkHMDBVWCsD/BEkCeql+07xWAoVnsjLEaEpDLogqbyDWCgzDyOQ/rYrk/KkoTRzbHcDgUQPeeAAFE6vyC0Cpcvf1otSS/JUgZq4oDpT31n6UVPI5zKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764387763; c=relaxed/simple;
	bh=coXSfP5iPGP0DKvWU7gjkly+OWEx2e0tPwXLluGYykA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dXMPgY52h0Kl37l8S/AMsoeqQAGHfspCw/II2Xf3c6smC1vonqFNjpL7wRjJ8dyavN2pbu9ojgIyECDG0ZXlIFgNejFXHn95O4ImUGQL7pqzULhofZvOrFuRWgY6ekx1r0snuu0VnWcIeSB0k3beQE+BC9VQMHIcieDvbQl6Cp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CfxNUmzL; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7baf61be569so2885653b3a.3
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 19:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764387761; x=1764992561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zwwuqAjXyQwlWsKtZ5Jk1RCQQpe+aHMmcqGyV/n+5zo=;
        b=CfxNUmzL0tmVsNPtt6aRisBb10procnF/W7iN5DmEka66Dm4ncd0/bHeMLXIAbJ/Vn
         /7NUNKS1RcWs8N6Gs3+eJvpEqPWv7SqlEtY72tGSskFHoONAUEko6cOFJcLhp4UP6CR9
         RQQtK92+g+J6HWXHVjIAqZg5d6ztyn5piUjhJoHgbyqzrEXCUMci5FdRTzClCEJnrxCz
         MBt/m0p0XDQntxMisVPA8ZXVhaMJrvEWB9A+9OUG+YLQlEsy77Yhxuspq6PCf6aWDE3D
         XbJkoumU2cfbE5LKfmkTITkVEXsh/xswX4Zistqhy+1fy+xz8aU2bIXGO1cBaI+HVi+3
         OW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764387761; x=1764992561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwwuqAjXyQwlWsKtZ5Jk1RCQQpe+aHMmcqGyV/n+5zo=;
        b=U+PoBlGsSBxEDdXKv47fzM3R0JkKCuIX07BlzaPM4aXNXs0w5m0oeXAno+PEYcK/4t
         OuA1knMs5ee28lUoOkk5ItudUH9t5CN2LNZSsYnMBtVWf+Ho9YnvoXGUz6xeKULpmNvu
         3sdaAxpkl3yzPd9ghgX9mpapHz4CB5o8V3rKbvQjh+gPpvEQOdhoO8aA3rCIonVm39iK
         VokUip4Bpzg0WT5ygGqqHMGBERWO1oAMXEDzYGkct2EGrunVNq4Xbpc70q+K8PGUSrWF
         8rcis0ETWG8xvXtd0eNLD/7uZ/hr/I1I69/SfvHcc73d+e68Go1OxVz6pEt7fBkeunNP
         gk7g==
X-Forwarded-Encrypted: i=1; AJvYcCXT7+s25qy21INQWtaSgVNY91RKBvBjyO81NMoBL5jRH1OgOLhXKK/ZHm7jH1n/zCn2MaDd8Ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvCTeFHJk+kiuKBM/t4ziBS578SMYwN6Vr+sG8h3seutJsrXDC
	e6WFQaqUIYb0HCcelfLG53mZQ8FgeBrE98+RzhOzA7biFHaXH7yMCG/LvwhtSWTz
X-Gm-Gg: ASbGnctJPcMd9YLuoEh01iiYTPvK8AeppkLxG8cv0IsjNzVHGek7P0NZPFSaqPUWiZb
	BNE80h/MkVrtEojN6qHPp7XFWyNyfJznwkua37yKM/QpDRw7MpC/Q5bwf+E345E6Il60CO4V05t
	RO4ZfzQlWP+drJr4EeXSbSsmN9A2N9OspQtevdVy3WUkrhrGrEGTm45Jges8ehLaez9fo04JNC7
	JghurvD1QKvp294+CQ6ud2568utc7YOLHuakrEv6BA6I1DiB+uIrVWkNxshau0BDcWlsD/qhiYP
	GZNOm4QNnzgHwhctwIKZ7vl72wfPwEiXjpc66Zm/nPMJvAuGluowyN57HqnQ8DwOmz07OpAdIjT
	eqrQYhwlJzd6qWNYbK96vaxp5cCs9/X+7Xdr8gjnaisxox77GFNKg75bppk/FXuaAZE4+Jbrtar
	GNKELa/GOgW4hiwgDl0k4MK5bBcGx+hQnwQfE=
X-Google-Smtp-Source: AGHT+IEiQ6DpI97phaBc+ZBVNX65hiovuUDQNBEt3GfuthdkTrdaGVhbOIUr5+950kDrLtgYPzqSvw==
X-Received: by 2002:a05:6a00:1803:b0:7b8:8185:c23b with SMTP id d2e1a72fcca58-7c58c7a631cmr30441891b3a.10.1764387761388;
        Fri, 28 Nov 2025 19:42:41 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:9cfe:b2cf:9d3f:f1f1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15fcfd0cfsm6413100b3a.65.2025.11.28.19.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 19:42:40 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-hams@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+d7abc36bbbb6d7d40b58@syzkaller.appspotmail.com
Subject: [PATCH] net: netrom: fix memory leak in nr_output()
Date: Sat, 29 Nov 2025 09:12:32 +0530
Message-ID: <20251129034232.405203-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When nr_output() fragments a large packet, it calls sock_alloc_send_skb()
in a loop to allocate skbs for each fragment. If this allocation fails,
the function returns without freeing the original skb that was passed in,
causing a memory leak.

Add the missing kfree_skb() call before returning on allocation failure.

Reported-by: syzbot+d7abc36bbbb6d7d40b58@syzkaller.appspotmail.com
Tested-by: syzbot+d7abc36bbbb6d7d40b58@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d7abc36bbbb6d7d40b58
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 net/netrom/nr_out.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netrom/nr_out.c b/net/netrom/nr_out.c
index 5e531394a724..2b3cbceb0b52 100644
--- a/net/netrom/nr_out.c
+++ b/net/netrom/nr_out.c
@@ -43,8 +42,11 @@ void nr_output(struct sock *sk, struct sk_buff *skb)
 		frontlen = skb_headroom(skb);
 
 		while (skb->len > 0) {
-			if ((skbn = sock_alloc_send_skb(sk, frontlen + NR_MAX_PACKET_SIZE, 0, &err)) == NULL)
			skbn = sock_alloc_send_skb(sk, frontlen + NR_MAX_PACKET_SIZE, 0, &err);
			if (skbn == NULL) {
+				kfree_skb(skb);
 				return;
+			}
 
 			skb_reserve(skbn, frontlen);
 
-- 
2.43.0


