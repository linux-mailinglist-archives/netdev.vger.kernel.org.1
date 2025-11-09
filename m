Return-Path: <netdev+bounces-237026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E44C43A85
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 10:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820881889B73
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 09:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BCB19F115;
	Sun,  9 Nov 2025 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LL04uAuz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C325D2D0610
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762679647; cv=none; b=dM5+0HO8+0m2DUrI8Sltw6tBVU+W/9j8eNycCB/DlNwwf09PiS2PcZa/HAlcjASa4Tu0EXXR/S5wtmFq+M+A0b2xhN2eYzoOQC4Km/tT0v7VH2uoMHY2kWRh2+IzstwHR+nCAdY87vve5zvlLw6C+ZKe6AXnuCvBqiIEbfxkGXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762679647; c=relaxed/simple;
	bh=HnQiRwzviFZfkE6loxr/BOANkRT7iJY6innAQLrusbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDenBs7/NBC5gBS3XuDTuLHKAx5UNggWNXR+mL3UVStatqckP7ONhoZdYNR+YEt5Q1QeJz+zWx02PY5YuxZAFVQSNpqnAaJGDMIm/dUnZ1VwvPE6mXR4/L3maqJ7dWv+oC6mEx1mN1vo+ya/ciFPdItvda/6wbgUqGNnjdv0nig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LL04uAuz; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-340c2dfc1daso290060a91.2
        for <netdev@vger.kernel.org>; Sun, 09 Nov 2025 01:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762679645; x=1763284445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PMsTc2iEamsoaNNgA4bvlleTLsvEej8IKKb+6/VtSo=;
        b=LL04uAuzG1+SIqqnm04+LCVDI8h2vl+FSxIHjHND88ZIXrn8ZRHm2YRP3xvDl8OD7T
         6QKZlK2Rf8HO2zNzeKIHv9nQV7mO5yVpMAE57mOV4hFDQozRe6q8hRv2ak5A4yQUEcKq
         7fDduXL9Q1ROM+gHbt8GuJ/CJa9eEPi+chw7YIpHCNuEK/PeJv26mfU8pkmUcDiQGPij
         YHtoPIh52FOhsc2qc+TjRbUwY6PT4Av9CczTWYKlj4USIgHEvkG9IfSY+2jAj0Mo+nln
         Nf+wdhdMwnVOQQEMoaSWr/exHwL+rJuJJ3XHDUMcCsHtm1x3lQnNP2hJ3j+66BlibkK0
         xRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762679645; x=1763284445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4PMsTc2iEamsoaNNgA4bvlleTLsvEej8IKKb+6/VtSo=;
        b=M/QAEZ3D2K5bem4VU/Pu7cj5iR99WAR1YHVXibD2B57aznWnxZcQ3kO27oVXjNDpVb
         VDIm14+hsv2+8c0uH1/ECVmMXlPD5ANRc7+L6JftUO3DILCq8AxXFQJFiEUd1gvOxPlA
         e0IwgBFurTuAP4IuvJYx8/+X94eihy/fmkUzT2TrWi87D1ad7BJRRoNMlpm+z45VGfrS
         ZU93xBZGcj3BMTf5tyEzzR7DHSoE+AQ+XiVRYQCp6yxrknKsjeIVg4zgANLI1qo/kQqs
         LMPqtxc45/Y8RvLSOwDZyGiraDW54LIfqhjXNf76JTpanD+P9vvcnOKb3gur9LcFc6Vw
         g9EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPvvDOFRXgKHygeipETbi77mnfwa360L+ZN43M39uReFhBDltw2eNX5L0hmOcd4thYIl+fpZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCiosqk8a4Y4cfrN82oVK6NG7Dzh5mw/yVG7BGczvK92h1xJXq
	RdC4ho/JMbHPI0e4Ctahkdtif9hSVYytyP0ylEwSdptKyYSze9uWN3VH
X-Gm-Gg: ASbGncsQUrfXAeiJKPDRXIz5lo5hOiF8RX3Lcjusiu1JGHpqOfz608yz4hrE1XGUDVN
	sM8lZDyrRp0aRGDIU4JYITsBT2FE8igVRZH0MhWltlp7asdVLc8YV3U444kttUcvzbphYzL9AcB
	ljKV5Af4xBfiCbMSuIxumuFvhc27Xborb91NyWYs3NJ7nB7OjI2wM370fm/NHqts9lWGf8F43th
	Hc4/DjQKxHpY5w9V6nnGMw0MNwkj60rcdqISM6SizLa28YDQzbFh07dXKKmcClC6CvRnVaRKI7X
	kjCgpNokEGfMSqVnOMzxIjloywVxJ2ZjHLtiqhUIZodV0VUNW7cMgYxalY416Qltghj9WgqpXVD
	H4djQn3ED3M1HpzyimEycU6RYldMb8vq2PbXjXDUXlT19+BbKs34DcHT5vsDir7S9flQXDhAmNw
	hu8Hin5Xy21ye3miRLZHMbWDuHoR+z3ISlsojZ6lsMJw==
X-Google-Smtp-Source: AGHT+IHjXNmhuS8efz6vClWXbs3pBS9HpVo6djl/mfWt5tPuH+GEG2YZZK7drOxtvdXymvEDjvlxIg==
X-Received: by 2002:a17:903:2343:b0:277:c230:bfca with SMTP id d9443c01a7336-297e565283dmr32156275ad.4.1762679645191;
        Sun, 09 Nov 2025 01:14:05 -0800 (PST)
Received: from ranganath.. ([2406:7400:10c:bc7a:cbdc:303c:21d1:e234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c7409esm108974225ad.64.2025.11.09.01.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 01:14:04 -0800 (PST)
From: Ranganath V N <vnranganath.20@gmail.com>
To: edumazet@google.com,
	davem@davemloft.net,
	david.hunter.linux@gmail.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	khalid@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	vnranganath.20@gmail.com,
	xiyou.wangcong@gmail.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	skhan@linuxfoundation.org,
	syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
Subject: [PATCH net v4 2/2] net: sched: act_ife: initialize struct tc_ife to fix KMSAN kernel-infoleak
Date: Sun,  9 Nov 2025 14:43:36 +0530
Message-ID: <20251109091336.9277-3-vnranganath.20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251109091336.9277-1-vnranganath.20@gmail.com>
References: <20251109091336.9277-1-vnranganath.20@gmail.com>
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
index 107c6d83dc5c..7c6975632fc2 100644
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
+	opt.index = ife->tcf_index,
+	opt.refcnt = refcount_read(&ife->tcf_refcnt) - ref,
+	opt.bindcnt = atomic_read(&ife->tcf_bindcnt) - bind,
+
 	spin_lock_bh(&ife->tcf_lock);
 	opt.action = ife->tcf_action;
 	p = rcu_dereference_protected(ife->params,
-- 
2.43.0


