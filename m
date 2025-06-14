Return-Path: <netdev+bounces-197688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AA9AD9947
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 02:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B76B33BAE97
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 00:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4781BDCF;
	Sat, 14 Jun 2025 00:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1nccaGK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C891802B
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 00:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749862504; cv=none; b=Do5+wgmhHLvGSIXnP64fQdsL2bvtVpcMTsHGMDe2vp39+qDAzBje/p86N7wePXSkB9RXL8CTHXMBsF44IwXS/64pEi7c4waGCnMOyZh/qgHfGVvAbmL+Tkn/Sewj8F+0WYajTKR8Zh+FvW2AKxtr24ftekNjglfoUWAxD4EyEc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749862504; c=relaxed/simple;
	bh=IHIYVt3SdFe25Z5SJM01ORY7JXbXbJfd1W4heaSxW7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UJ7s4p2yZNpsj9q8F9iRMatPDhSGVPp25nOZ18g5UqBKULEeL+z8QjOKJ9ignwabiCz7jBWzGjvG624DD0PFDcKriDVvnjWFJn6HTn4dZsaTV/cALdOrkLHIopl/ydrIAC0PUQZDHecwfFXZBxwt07ZuufCp2N27EYzT47j4UjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1nccaGK; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2349f096605so34697405ad.3
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 17:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749862503; x=1750467303; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtYg4qbAJu89VpXr6zSgqVyBPtecdeEarqsdyRO8VO8=;
        b=k1nccaGKpBl646wBOkg+UKqgpnZoO1J7Qt8fgcOiR40ZYptmUKu2mbRzDWAxRfqF6N
         aLqScvO9fqRMLUxxOfo6V7QH4cTKgyb7IJfOlflDRs0gQ1yxY0xAYD4vVbyZyv79jbYK
         PZkboeDU74iwqV9p/UnGjWiDzTnn0kTYjVVf0UUoHfNhI3bSROgiK1PQGup/I2TliHIh
         TSYiahqXMK3yQsbjmkGKpTVDpqHLrpOa8LW6Jc6GzNzkJMKLqUHrvYv4Ptf2P+CKhP2N
         Nx0ApR3vLCndcGejo57Anj/QcIu3m/pDiwawD+Kht0U6GkL/ufYopqs3epUp1KOIKJDf
         GYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749862503; x=1750467303;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtYg4qbAJu89VpXr6zSgqVyBPtecdeEarqsdyRO8VO8=;
        b=cGvADOxHY4ImyxqyFcGSlauz4uf/5fMEb3s4XWXQTC98eW7qMRa6Gs+hHDa+aEAFWt
         BgjlbK85qjDmp/4XE7sZg1L7n3uEn+qNHNt5oRmJatxR8s90r07XPzaookMH2DMnzKDb
         xBYKmFZVHeHCh7MZCVULt2Usl7Julvm67Y5hVIFb4OJLvPVsCjpdfee6SFdBvIkQPhrU
         Lx2CbEDgcDLzB55454OeYodfjiTsMtFhtYt1X1fFXGOKkir3CwSMwn8oflpdDo/1Y688
         eXBuULbFN/o11I8tJtj5UsEDzc87WIHgu5rGnYZwPpfsz+f+Kyn0CJF1Aw9X198LEAVO
         75IA==
X-Gm-Message-State: AOJu0YzEWjlmdrQzRfhKH3ZHfGMpSVIJ0hKz61OR30CvC+xJ7uiFciVz
	kn6odk8cFu8l9AMEPogWKgzifVyFYJzU5Uie45zq1VG41TPHezpr7jBd
X-Gm-Gg: ASbGncvN2IAivsvXpdagghN3G7e4W9mHOeXYIGj3V4GXLpJ8PIScJSfXhggdSpFe+4z
	TH9S2adT4TDotL3IXUrZxQUfiiXfYmzyEZd+6jhg+1XHAQIOxsy6b4vrtsAmNsEwHKOphNKt5Da
	K/bKmLPwwG1AbaQHW50D/WE8FtStRpbzZFQ3ZHw3m95MiQM/9eknfirkw8A2/GU+uO0rVmGg0Cx
	VB2/C+snO811QfjCcSpExawu6LxNuVAihN4jSHdqv/EBSdcjeUDYvnn66TEVytjBjKBNhrpXkjV
	kE9Y8AVaOU+URwztJGhEsxNWjxxDmIH0qnikDQqqibzVIr3I68mZXWVlwVnXPqDaFI4TlYohvTx
	W7h9JG28fRhXC
X-Google-Smtp-Source: AGHT+IEF5gH02VcepOcPjvO5CgfdtPFNrL0cv4ah88Y5zHC6QgZIiMOYXhUyAxcG619aHX/0mfqU0w==
X-Received: by 2002:a17:902:cecb:b0:234:b44c:d3c8 with SMTP id d9443c01a7336-2366b3c38e6mr19331665ad.37.1749862502604;
        Fri, 13 Jun 2025 17:55:02 -0700 (PDT)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de782c8sm20869965ad.94.2025.06.13.17.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 17:55:02 -0700 (PDT)
Date: Fri, 13 Jun 2025 20:54:57 -0400
From: Hyunwoo Kim <imv4bel@gmail.com>
To: vinicius.gomes@intel.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	vladimir.oltean@nxp.com
Cc: netdev@vger.kernel.org, imv4bel@gmail.com, v4bel@theori.io
Subject: [PATCH v3] net/sched: fix use-after-free in taprio_dev_notifier
Message-ID: <aEzIYYxt0is9upYG@v4bel-B760M-AORUS-ELITE-AX>
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
Changes in v3:
- Change so that taprio_set_picos_per_byte() is not included in the lock.
- v2: https://lore.kernel.org/all/aEq3J4ODxH7x+neT@v4bel-B760M-AORUS-ELITE-AX/

Changes in v2:
- Add the appropriate tags.
- v1: https://lore.kernel.org/all/aElUZyKy7x66X3SD@v4bel-B760M-AORUS-ELITE-AX/
---
 net/sched/sch_taprio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 14021b812329..2b14c81a87e5 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1328,13 +1328,15 @@ static int taprio_dev_notifier(struct notifier_block *nb, unsigned long event,
 
 		stab = rtnl_dereference(q->root->stab);
 
-		oper = rtnl_dereference(q->oper_sched);
+		rcu_read_lock();
+		oper = rcu_dereference(q->oper_sched);
 		if (oper)
 			taprio_update_queue_max_sdu(q, oper, stab);
 
-		admin = rtnl_dereference(q->admin_sched);
+		admin = rcu_dereference(q->admin_sched);
 		if (admin)
 			taprio_update_queue_max_sdu(q, admin, stab);
+		rcu_read_unlock();
 
 		break;
 	}
-- 
2.34.1


