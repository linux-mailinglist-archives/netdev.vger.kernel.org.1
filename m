Return-Path: <netdev+bounces-236503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC326C3D4C7
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 20:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E383B2412
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 19:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3441345CBD;
	Thu,  6 Nov 2025 19:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LydIh4cr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ECB34FF54
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 19:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762459032; cv=none; b=i0fVptWf4S5MK8i8dRHdrYZvC9mjETiThBauxJaVD9cs6vwlVyjkaEKo1+kFiTH1rNeaw8UNOcmmAfElRb08piVrXc73bgJBDKXSD2T6p4gtPO7Bc6XaiUqltIlYQisP16VGnz2YsbWC5J+fdIV7h/itiQ53wXSGypp+bc92QSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762459032; c=relaxed/simple;
	bh=33RiZ+lmUOo9IF1bLc7UKXkQtQSvXLWe1ihfkm5czFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oHUhS2rTGVv7v/WJVUZkpd5aFXj8yVQTcAXckuj8e5p7lrNvYpUjMtAgqvdCmRjwnGBkRB4ubVO7KmjInIl8mKUTJKQjikIv+KAxzRlMqnG6qE1Gb6HqQkvWI5tLD6DA7un+7boNqzWTzjEbxqI9Z/RUV3A65xwCkjVqTUlOkLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LydIh4cr; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-340ad724ea4so7190a91.0
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 11:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762459030; x=1763063830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IxjclUpBPZIElGyruonSprItbngxm4TepkxAI566f8=;
        b=LydIh4crzOeBPpBCo/xDVMiBEjydXYF1khMrR0BbNhxJ1T2ZCDtNaT8rhIHjiIpL+m
         ekYxtB2bT8ye65Q2rCmPkQ0X4w5SK/Br1gfRNWrDvBymraLqQBlCvXoMAVoNu6YSiRMW
         9v3kjo/4py0CIDKxY2SpF5MCycANFyiL5IW5qLIa67ifVOb/eBBYjcvEd0YvsPQd/W1E
         l+izrBX4UBodYv33gHRmNqV7YHI65qPxUfxda3IRutmKSSZKwjOthFMtW28gTwGHG3mf
         DULPW6Z7MivEdFpzcIElFUsqDSHljRYsSM7d4VtHJFTt50Q7Sm8ekFmD7NK02jQadzRr
         ErDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762459030; x=1763063830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7IxjclUpBPZIElGyruonSprItbngxm4TepkxAI566f8=;
        b=VBJju9tNGyHuK/zl09M4Gp9BRqW/XvEd/gkjZ5Y+ABdit93IA68vQUvkhQfOCnYnwa
         d8gnyfhkBI2hTLc7dZUCuUpOeBzCPyjfqGnRvBo5UxK61fF8L/rM08M9xEiY/zQDX7Pv
         MFtzKPLSOOLu8hu2oLqsIKC6wTdtHR1TVV2oNdrUc30A/fm8rvptmzY6WXeSGORBHVXD
         I6Gb4BmACcUV6s1pF2znNgrHE9JJ6DNWAY+ZgZ5JdO4HxtqmIHiwidErtvu2qKmAaq7s
         tXYm126e6XNkDPNY8UA7oMGmakufzeku7DCMxX5ckdB8Jbk4rj+2VXXMwwLw4efcYI3v
         WbFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT0SNsB7lV7kbq9b2gQ4EmAJ/zHVJaK6w+eFN5CyEbCKPw3uxQnG5cXG7MZ6B2OQ9JFeWpC3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAyuHxmJDI5gJ2n81xBdw9Wu1Fp8J3/zWJLJzOOXtzLhjEACov
	/TFbNoyoQ1co2+NSQnWu6Hwn7ltMR8x53GvMrTMfzJydU76Up36gtLOq
X-Gm-Gg: ASbGnctxcdVFppBUP8eZAF305aiQlDgm6G7EYJB4p8SE946TSF6oZbzavv89bv79Qcf
	lP0T62+TmDDLhFj2Mb2iHAn1cAtk6ZemhQgYOEjLY3kKmrriydyY0SmG6a4zFW4xtLevAMLcg15
	UouYjkuk1VcNKRcJhuc6VdZI605/7B8FN/RzUIH1s5Nq5cvjGsmbCn4+xpoQ8oWCBQ5TmdPYB/+
	dP7G8/CZdjWGtiE1Z1jM6GdaCNhCTcXZoig3kQiCTUz1FxhfBIB1PX0jtnPmFWyiuj2Ldl3Eu2y
	9lN9vL8QhlpQX9gRYp/ZYJlCq4zSGA9YApAY0D4i7yiaPG/FeOPYnGmlSPobMVrsnX7/ylo2nAL
	7vRqeBfTNS0ig53kK5IF+vCzfv3ou9tUoJDVkfPPtIjF5TtjALvWoXscXCJ1snkCMJL3/lyCrdY
	ur28BkjYT+ulr+jQ1Rn8q+Td7WX/rB1n4o7D8I0wBHGg==
X-Google-Smtp-Source: AGHT+IH50ovknSWqiPRMYuC2sbKL36wJsRKwQ0PebemgICqOSP/IYHVcYCWSomzoCb/ABZrTRan3Jg==
X-Received: by 2002:a17:90b:4f44:b0:340:b8f2:24f6 with SMTP id 98e67ed59e1d1-3434c4e6028mr258409a91.2.1762459030543;
        Thu, 06 Nov 2025 11:57:10 -0800 (PST)
Received: from ranganath.. ([2406:7400:10c:53a0:e5b3:bd3b:a747:7dbb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c953cf79sm391246b3a.3.2025.11.06.11.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 11:57:10 -0800 (PST)
From: Ranganath V N <vnranganath.20@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	kuba@kernel.org,
	pabeni@redhat.com,
	xiyou.wangcong@gmail.com
Cc: vnranganath.20@gmail.com,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	skhan@linuxfoundation.org,
	syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
Subject: [PATCH v3 2/2] net: sched: act_ife: initialize struct tc_ife to fix KMSAN kernel-infoleak
Date: Fri,  7 Nov 2025 01:26:34 +0530
Message-ID: <20251106195635.2438-3-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106195635.2438-1-vnranganath.20@gmail.com>
References: <20251106195635.2438-1-vnranganath.20@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a KMSAN kernel-infoleak detected  by the syzbot .

[net?] KMSAN: kernel-infoleak in __skb_datagram_iter

In tcf_ife_dump(), the variable 'opt' was partially initialized using a
designatied initializer. While the padding bytes are reamined
uninitialized. nla_put() copies the entire structure into a
netlink message, these uninitialized bytes leaked to userspace.

Initialize the structure with memset before assigning its fields
to ensure all members and padding are cleared prior to beign copied.

This change silences the KMSAN report and prevents potential information
leaks from the kernel memory.

This fix has been tested and validated by syzbot. This patch closes the
bug reported at the following syzkaller link and ensures no infoleak.

Reported-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0c85cae3350b7d486aee
Tested-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
Fixes: ef6980b6becb ("introduce IFE action")
Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---
 net/sched/act_ife.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
index 107c6d83dc5c..ff1d9d6dcc0a 100644
--- a/net/sched/act_ife.c
+++ b/net/sched/act_ife.c
@@ -644,13 +644,15 @@ static int tcf_ife_dump(struct sk_buff *skb, struct tc_action *a, int bind,
 	unsigned char *b = skb_tail_pointer(skb);
 	struct tcf_ife_info *ife = to_ife(a);
 	struct tcf_ife_params *p;
-	struct tc_ife opt = {
-		.index = ife->tcf_index,
-		.refcnt = refcount_read(&ife->tcf_refcnt) - ref,
-		.bindcnt = atomic_read(&ife->tcf_bindcnt) - bind,
-	};
+	struct tc_ife opt;
 	struct tcf_t t;
 
+	memset(&opt, 0, sizeof(opt));
+
+	index = ife->tcf_index;
+	refcnt = refcount_read(&ife->tcf_refcnt) - ref;
+	bindcnt = atomic_read(&ife->tcf_bindcnt) - bind;
+
 	spin_lock_bh(&ife->tcf_lock);
 	opt.action = ife->tcf_action;
 	p = rcu_dereference_protected(ife->params,
-- 
2.43.0


