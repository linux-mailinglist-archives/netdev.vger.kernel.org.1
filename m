Return-Path: <netdev+bounces-196926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C58AD6EC7
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 13:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FAB3189EF43
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 11:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C13621B9C8;
	Thu, 12 Jun 2025 11:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DiQmbqY9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECB522DF85
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 11:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749727022; cv=none; b=e5DPs+KQfHGDt6XHZswjbrmSPRAyGUnS5YrkLKqkIeIgKf7f1w+rpF9LklF4/R/MvO/13DsEFjChNc7PJN9EOAc+cFkX2+ZSKXQtNsm/fHtf2r4sLfqXU8um8yEsAbl8gQiMLm6hG4pa9s/Q2MMhY4tRPxH6NnZWMrGvMPoIAwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749727022; c=relaxed/simple;
	bh=dVpl0jDUmyYnHP8hUy3gBeNCoj2d3mdi2SVFuxLRdMo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UF/stlMnfno66kORo3ioKT4csWh3DPB0MIClCrjfohu0mvWxWJhC76W2T2sTiKkwIQAYyFGgYl0Wf7hAe6oX18ZOKOCmaWkO4JnZlI+h93RG2fnVbS5kP8T0oGpqKYgD/u8Ibr0afSZyIsXeCx4tF/k+R3QAzf+MJ7E6xFhqgXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DiQmbqY9; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7426c44e014so730342b3a.3
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 04:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749727021; x=1750331821; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qiOKyckiaYxg9gJ8MXYPnGdcc3n/MsDmaS3VscPda4c=;
        b=DiQmbqY9S2TYjZGNE6fMeIYbG2z4mg3XZ0YZqf6ylziJiDErUjE8IfvzdX8U+sIGHV
         ujxfzML7+aptnNy7v4280GoPRiA892RoXxxmLiDeW1NHbKL2oKCZNfiMgh00nCzJjGyl
         Tq+y7Dhu5uGLp6G1GLsurooU8b+M+eCqoUkhUpwc7UNeyiB0bch1NjQ7OpD3kDKvPqPI
         aso6FDSJoUgcwDxDY4pugkBkK88ByjVE/ljJVLOaFje7ZYdwAZ/SsuKT5PBBDHCjFg0a
         /YyjIxjxnrDFZ1vB0nlDmd9DD8UuSpBTLhnlkR3B9MtFQHqf95FA3pGAZTkCNpBO+bxz
         J9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749727021; x=1750331821;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qiOKyckiaYxg9gJ8MXYPnGdcc3n/MsDmaS3VscPda4c=;
        b=nXy/xGEHay2io/DOSDhnMewMYDy7/tl6sDCSyAQkoz0/i5Q+wRr98X+xRmIfwGjCgR
         0wWpssxB8bUJtz91rv7UUFDRn3khj1A9JA01BuJjcCjD83NNs9BxgvBpfYYRlEteWGJF
         MUBHJIcGxI1ReuqEhQcOj1g9nkOhkGpszyHi4oQSUSZDHtuTNYhPf4Iv95FJJVrxM5rU
         UpjkuWp3fzmy/vUPFggbj7lP7k/k1qeP1MgwfW6Z44aZVUTQ1fGgFwWmuKmT/aokQlOp
         Zu+ci77KuRjP8fEfkayeLmG8Ec79t+bvk1gxD6yqNWOkxW9i2hRG1T1NH36Tyel0gMeD
         A+MA==
X-Gm-Message-State: AOJu0YzVmwgzMk34PDkoy8Ng0qmEEakB/VcyiHrBwVwctZv/gKNPggA/
	9cA+bD0TIOSH8OoXfvEdKFZxZQa7NhTOQ9l4giI3Qfti6ohyQD4epZKetK2JiuZK
X-Gm-Gg: ASbGncsscd7Elfp0CIrZYwULaHXrHKaQg3I3DoJ+BXDN6xE0p+5Kuo+e33gLwf36bEC
	qvpE+wbGggLyRzXmJxPjYGVhVPb3PT94xC+ROHHIQbVV3n+OhtgcsR97PX92zwjKjMYewxTIAGJ
	afnBHHLYpcO3xsUSALFD7YsTRsh1W4iZx/MTXzoNp7qZ1CAF2XDzRPal7CvbRfbOmg6fRuH22/f
	m+EjD22QNNFY7WOtr1y4n9mP1+muEtZJKWEXvt47BP9hf4SmqBtYKafd94OJV4fXy1FsM1cFTCr
	JNs9v61SqvFRitcKRTXzX930agOz6xJ1mpVJjBHtDfr1jP3CrSs7D/ok2m9DEJoblQbi3HTGxRC
	Veg==
X-Google-Smtp-Source: AGHT+IHxyNAZcMVZLOECLSXCvSXr8xQ+p9OJH7tYcTXw+E7+RCKK0hvLvNw9SRQSREbrd8FeAwj/tg==
X-Received: by 2002:a05:6a00:815:b0:746:2ae9:fc42 with SMTP id d2e1a72fcca58-7486cde3144mr10212355b3a.19.1749727020759;
        Thu, 12 Jun 2025 04:17:00 -0700 (PDT)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748809eb0easm1178737b3a.113.2025.06.12.04.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 04:17:00 -0700 (PDT)
Date: Thu, 12 Jun 2025 07:16:55 -0400
From: Hyunwoo Kim <imv4bel@gmail.com>
To: vinicius.gomes@intel.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	vladimir.oltean@nxp.com
Cc: netdev@vger.kernel.org, imv4bel@gmail.com, v4bel@theori.io
Subject: [PATCH v2] net/sched: fix use-after-free in taprio_dev_notifier
Message-ID: <aEq3J4ODxH7x+neT@v4bel-B760M-AORUS-ELITE-AX>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Since taprio’s taprio_dev_notifier() isn’t protected by an
RCU read-side critical section, a race with advance_sched()
can lead to a use-after-free.

Adding rcu_read_lock() inside taprio_dev_notifier() prevents this.

Fixes: fed87cc6718a ("net/sched: taprio: automatically calculate queueMaxSDU based on TC gate durations")
Cc: stable@vger.kernel.org
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
Changes in v2:
- Add the appropriate tags.
- v1: https://lore.kernel.org/all/aElUZyKy7x66X3SD@v4bel-B760M-AORUS-ELITE-AX/
---
 net/sched/sch_taprio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 14021b812329..bd2b02d1dc63 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1320,6 +1320,7 @@ static int taprio_dev_notifier(struct notifier_block *nb, unsigned long event,
 	if (event != NETDEV_UP && event != NETDEV_CHANGE)
 		return NOTIFY_DONE;
 
+	rcu_read_lock();
 	list_for_each_entry(q, &taprio_list, taprio_list) {
 		if (dev != qdisc_dev(q->root))
 			continue;
@@ -1328,16 +1329,17 @@ static int taprio_dev_notifier(struct notifier_block *nb, unsigned long event,
 
 		stab = rtnl_dereference(q->root->stab);
 
-		oper = rtnl_dereference(q->oper_sched);
+		oper = rcu_dereference(q->oper_sched);
 		if (oper)
 			taprio_update_queue_max_sdu(q, oper, stab);
 
-		admin = rtnl_dereference(q->admin_sched);
+		admin = rcu_dereference(q->admin_sched);
 		if (admin)
 			taprio_update_queue_max_sdu(q, admin, stab);
 
 		break;
 	}
+	rcu_read_unlock();
 
 	return NOTIFY_DONE;
 }
-- 
2.34.1


