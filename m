Return-Path: <netdev+bounces-249878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E270D2015D
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 17:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09BCF305CB11
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 16:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275843A1E64;
	Wed, 14 Jan 2026 16:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="bpUlTnOq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD533A0B39
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 16:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406586; cv=none; b=KYys+A0AwnRKZLBAQR7ocqNydRvwRmnpsnPD7CIDThOctfL7tt16WeXTR6Sh+b0gQWMAmboHzClgvMTkJjcw7+dnXbqd/4qCLFEySETaMX47aflLSfoRy1uyrP0C9SOlAf2Zj/coGQJHNfk023eeYXIf8zuVU1Uw50FqidPQq04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406586; c=relaxed/simple;
	bh=nji573/NFAbXUmdloJjYIK2BAyIK4fuK3wUnTDeN3ts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KSiA+C9zGy67xsrmuXDwDcAiVfdOJoryAkdXTfBxpnfyKzNS9MkBbWZXNdF0n/svjYuNe33JuUgLBMg5/WcqB7vpEZHwtIeGMsyDuwjHsHRZdRpW2cR7TahE9cLZDIk+F+IAXCuT4K6oHWzZJIb0yY8A4HmhTMMTqlNhrs9NuxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=bpUlTnOq; arc=none smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-501502318b1so3013701cf.3
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 08:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1768406583; x=1769011383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBf+P5J9cevQUas6omvag3t48hRJz7ddBNuzW4xSHVo=;
        b=bpUlTnOqIYoWCCFmSZad8tzxrXspxl6HFgt5jrSjRujh0TsnIZEXjq9tbpjMv3Ogkg
         a9mZ2vKNuNTJ4UebgD5uEGpd35GxwWFdw6vo42UUfYJBiJQ9Endun3Rku+UFn8+kUHHw
         Y0BY+uOueD/SB8YW7C2jtTICVNTDraMQvZEhWF11p2Mt2TZzbJqgdJvLMy12anQ5gSi/
         MgFWYieWeqalw+62FKNhvpKRHs6FKzOL8MrsoQ7Tny5CrgrEJlbHovS8Bs8YLqaN/5ig
         Bspt1ecj0SkP8zpyzPSkpOELMagAtTQKECfuxPTBZWnFiDhRv8mJioZ6hDKhD0Dm54Pe
         jK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768406583; x=1769011383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FBf+P5J9cevQUas6omvag3t48hRJz7ddBNuzW4xSHVo=;
        b=EHptw6gah+kfSicH5ODL0HSgxlIhL6my/2opGEZ9gBltga77gwUBFC0+gjrJcPg8a3
         bUP3XfEY+JEFQnCc4SCPqgTrcQ1UlCEx8W7yl9yGyMjV7Cqu0Wda+yvmOqlbv5Ae7ajd
         djHxThAQRL4LwRs9ddmhI8PNjBbYTkyyC4KhV62l+bRYkJ761dZIQNNN5ubTRZonHdyI
         qgYkTq50BL1bTRdohV9aMk0AL8RlCxPOH2AAfbUAKj152+Kebt+9Filw7FVk34CxiyK5
         y5EgSMk9KmjdFDnX0ofBnMtX+GS0qAbvFRuHqVMHnbcXG1MqdRzhOsxHyi0/5t8gm6rF
         z1NQ==
X-Gm-Message-State: AOJu0YzRxLwKQ0oQwVn2vtNTUfQVMgoqkkLNyXdl6VaxK/VSUQGirIwt
	YhHQYZvXMMhPVCQG7N0C/GIwjM+3tlZvn81+blPZSJx7DjpcNxubsDO3PZ0m0Y4ySA==
X-Gm-Gg: AY/fxX7vXKehrkpl17mwlMHBGnS24RrU7t1kK5SPzmAzkD2HTsecMdaEqRE5gleR8gW
	u5xp/U+i4ibRybOhwtdOhgNWcQDQ+LQN0wAYiBZ8Sv4Henotfe3E3YmVCFUhcNIiNrcB/RgoVSg
	TeoKKid58T34zEpqNiRj5+LUnw3FdNv2HxZEizkc20qVl0y5uUqwpW5v0z+zMZj/nTesx3KN6Bn
	BRyqoLiI2u7i75X2fGk7vDlQ+cLStaqXIa2/SyMHwmMDrdhxu9YaTmX24YiuqYubuABGcuZxfOC
	xLZGv7oXTl9bUSNZTsfdTuZ/8DS0Zw2i6L4Tz1UPW+9M4K5E2FX8luegq2QIg22wEIrw82LIk75
	gjBrUr95ud4ci0zVX97doUNwGexoCLg9RMCoVBvMhh8PzUD3fXQiOp9zb++R2rm9b2oBtZz1VbT
	CbLFq6AuSnCD4=
X-Received: by 2002:ac8:6f1a:0:b0:4ee:61f8:68d6 with SMTP id d75a77b69052e-501481e3cddmr46980681cf.6.1768406582720;
        Wed, 14 Jan 2026 08:03:02 -0800 (PST)
Received: from majuu.waya ([70.50.89.69])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50148ecc0e4sm15543451cf.23.2026.01.14.08.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 08:03:01 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	km.kim1503@gmail.com,
	security@kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 2/3] net/sched: qfq: Use cl_is_active to determine whether class is active in qfq_rm_from_ag
Date: Wed, 14 Jan 2026 11:02:42 -0500
Message-Id: <20260114160243.913069-3-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114160243.913069-1-jhs@mojatatu.com>
References: <20260114160243.913069-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is more of a preventive patch to make the code more consistent and
to prevent possible exploits that employ child qlen manipulations on qfq.
use cl_is_active instead of relying on the child qdisc's qlen to determine
class activation.

Fixes: 462dbc9101acd ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_qfq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index f4013b547438..24ea023e4990 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -373,7 +373,7 @@ static void qfq_rm_from_agg(struct qfq_sched *q, struct qfq_class *cl)
 /* Deschedule class and remove it from its parent aggregate. */
 static void qfq_deact_rm_from_agg(struct qfq_sched *q, struct qfq_class *cl)
 {
-	if (cl->qdisc->q.qlen > 0) /* class is active */
+	if (cl_is_active(cl)) /* class is active */
 		qfq_deactivate_class(q, cl);
 
 	qfq_rm_from_agg(q, cl);
-- 
2.34.1


