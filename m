Return-Path: <netdev+bounces-236502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E4BC3D4BE
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 20:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B213AF558
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 19:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B350351FC7;
	Thu,  6 Nov 2025 19:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvCMQq9P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7F0350D52
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 19:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762459026; cv=none; b=mcaRI3Hty/TQQm9prlbNBYrbiCCsIUXxTV1hIM3UXDx43aBt7fOkIxlM06wNLRUsr4nUEJV3lvqzUof0OnjuNngKoxjStoxgQqSn195auBb8o9+tEP4nbYGvA1QDx4R5BuaFHVevR9qGN9b4jkBmd0FWS9i1zhDcFWefUkC25w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762459026; c=relaxed/simple;
	bh=hsCI2B35eg3VdUKU7IHlxYdYmWmKF/gxitpVILRLqSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FYdjvyoNXGXrGQkWoAks9/WMZS14Fh+jqdktNG7bhNT6At7bhsDbsxbmpEAuQfCSJfXj2XmKb75sUu8wJTVIUah3ivWfRHYSFxXCMzfk7spo6HiOeS9oS/GoAVCVgNEyxicFj9SB8vOmDpyXNk1e9OcrDUr22/67D6+WdnGg+sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvCMQq9P; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b87171370b5so1236a12.1
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 11:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762459023; x=1763063823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKQZJes3dV7Wm13cikS86S+AarGtDoSVY0Ws8VEcad4=;
        b=MvCMQq9P+fdaBItBLpttqAkkMAGUxHZyWjehNhvKdS7QhLmlzt2IwJThfABM7PHhps
         DQu4OVTTN1V558Dkb5A1AQwM/ZcPWauatHr3A92cP83VQHrCjyp0K5GDFmUbWRp2nXMb
         GptZCT5NM5CI+ow8yIffV3WxStdl3CvL+8+e2gGUmUMlzhJb60zOy6W/r8yyM8E2aMb7
         GHJi1FipqNfIWg02mNP2s7v6BIWj95YSoKtodt8DHXH8TLcnsSUDyAgJRLPqDDYcKc9e
         vf6S5bzLrSmTQJgm2qhoKlqunDRO7wo3NBCAfClPhbxbWhq8gnBg+UuHsyZ7v2F4Toho
         exBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762459023; x=1763063823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KKQZJes3dV7Wm13cikS86S+AarGtDoSVY0Ws8VEcad4=;
        b=JTKaEZ/k5v3x2MsCbT9NzJle2z+Pf8FxhivRRUTVNgd0glO6AS/Y8kWzWxl81v3LxQ
         vprPltWj6YfpaypntB5xJDdCpaKft86tTbkp5UGQlxLe0myZ6nJ9F8+GSfyoPpI2l8gp
         mG4mBQaXOzdmMwg2edGkfskJ6bg1jXOu65NhM/qmgncwhBcePsHTc7Fmr5lCcImuGeXX
         owKR7WcMt+kyrC1RwnalxSiuy/TMOGgTv08xYiYMHSqOkO3/plNqwkP4FyIhj+bkubxm
         axoymb3d8YUGkmZ8DOUgwmAt3X1/ah0NbZzzlizbvdmiMLzgfhymTyPNnYX/4pC0mtgG
         LHDw==
X-Forwarded-Encrypted: i=1; AJvYcCUMI+GcPSJdQM8drm2somxc8NXNyA4OSVisz6KqLHbhT5o9QWpAJe4vgaR90B7y4uwIjZHOB7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4moYwKwrn7pK4y+eYxXPC14yv/Gnqwbu35/nG6U/OcWLfP3QU
	e+IdsFUTVHS5X+rMGenZuMoamqEEpht2lBHmg5Tq+LsxS+q33PGlz3WL
X-Gm-Gg: ASbGncs/rV17//OZ/KPaIEWe2Y9pc8yoHcL7WZWbW/EX3ukIMepMHH2VcfFOzuBrgXH
	7xGpHlCokzGStUUWt/CvPqSJFLjAXwdZY44Akn3O1zeSmqifNKEwoxN2UovDGytbM5UVpAX/1zH
	+paWUSKQftJ/9VtpOY44sqWgisZqUKr7FADGNvysvGIvFQKRPt/mOZYwbMtE5RSRAUJINgO4kID
	0UXLsD8aqy0QxyRqquFJ41DJxIXi57XiBZyCZpnDfz9/B4B1y4xjoFciVZKCM5uILx4UJ9+aFVi
	2NpqxRcDQdDVYTHcaXg6ZtFJaHPlB18mBcxINotgz7vyIvTMUbSGvWmou5z1RH/23Unyzf5jGme
	cRFj+5wunDGgyrObb9gAuDPkOZtGA6t0OKwyg2iflFtmUfUhgKUGSGHbclBZl+GS+lrVRO7usbK
	4ko3y5MswES2+lbzmvX4M6xDauQrzssQbBH/0X4q8lvg==
X-Google-Smtp-Source: AGHT+IH6zEmUN6vmiW4J1BiS6HaiwG/z1An2ceST2X7NQPzM5nnSYeV6WQ7jOJGjNnz59T3lA3K0MQ==
X-Received: by 2002:aa7:88c2:0:b0:77f:1a6a:e72b with SMTP id d2e1a72fcca58-7b0bdb86450mr470949b3a.5.1762459022802;
        Thu, 06 Nov 2025 11:57:02 -0800 (PST)
Received: from ranganath.. ([2406:7400:10c:53a0:e5b3:bd3b:a747:7dbb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c953cf79sm391246b3a.3.2025.11.06.11.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 11:57:02 -0800 (PST)
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
Subject: [PATCH v3 1/2] net: sched: act_connmark: initialize struct tc_ife to fix kernel leak
Date: Fri,  7 Nov 2025 01:26:33 +0530
Message-ID: <20251106195635.2438-2-vnranganath.20@gmail.com>
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

In tcf_connmark_dump(), the variable 'opt' was partially initialized using a
designatied initializer. While the padding bytes are reamined
uninitialized. nla_put() copies the entire structure into a
netlink message, these uninitialized bytes leaked to userspace.

Initialize the structure with memset before assigning its fields
to ensure all members and padding are cleared prior to beign copied.

Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---
 net/sched/act_connmark.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/sched/act_connmark.c b/net/sched/act_connmark.c
index 3e89927d7116..2aaaaee9b6bb 100644
--- a/net/sched/act_connmark.c
+++ b/net/sched/act_connmark.c
@@ -195,13 +195,15 @@ static inline int tcf_connmark_dump(struct sk_buff *skb, struct tc_action *a,
 	const struct tcf_connmark_info *ci = to_connmark(a);
 	unsigned char *b = skb_tail_pointer(skb);
 	const struct tcf_connmark_parms *parms;
-	struct tc_connmark opt = {
-		.index   = ci->tcf_index,
-		.refcnt  = refcount_read(&ci->tcf_refcnt) - ref,
-		.bindcnt = atomic_read(&ci->tcf_bindcnt) - bind,
-	};
+	struct tc_connmark opt;
 	struct tcf_t t;
 
+	memset(&opt, 0, sizeof(opt));
+
+	index   = ci->tcf_index;
+	refcnt  = refcount_read(&ci->tcf_refcnt) - ref;
+	bindcnt = atomic_read(&ci->tcf_bindcnt) - bind;
+
 	rcu_read_lock();
 	parms = rcu_dereference(ci->parms);
 
-- 
2.43.0


