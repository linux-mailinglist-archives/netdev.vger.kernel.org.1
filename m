Return-Path: <netdev+bounces-36258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D4C7AEAE9
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 12:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id BB2ED281A9E
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 10:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C8526295;
	Tue, 26 Sep 2023 10:57:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3FF107B9
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 10:57:54 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725A2101;
	Tue, 26 Sep 2023 03:57:53 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c5c91bec75so58687725ad.3;
        Tue, 26 Sep 2023 03:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695725873; x=1696330673; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PjoNcHNpSndbmROelnkAs9z2pMPBqViv/3mMpfzHcDI=;
        b=HhA/AH+HKx5baG3aDbhCPF8xm6+w77wf9fbNvj4m0MRV9mi+66Z0tvFR42HbgCPKH3
         /L6JvLfHz0uw+fgK44OZtTYpglKx5+Nbt8MytEn1ohDoGoaKHtoKo6QABbOWkuzqvZvL
         USqR17uSvn9rkTf2pprXF1Kr73izDP0E+JdC9dgcJo5WeYjx29M4ff5paoJsMdWUJ4IZ
         3gHY4ubtyBLdNrGkH/S/sQVhHgLgo1fD27F4y8YWv7zegjtjeqecQOdektgKzNfy+cK+
         ljFjtOPu6pQqC3tPy429zGv/e0jeMrbcg/92/htZvHk6mB270+2AstzClRangqQWwCau
         YQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695725873; x=1696330673;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PjoNcHNpSndbmROelnkAs9z2pMPBqViv/3mMpfzHcDI=;
        b=QAbXtoqmqO9HPNaWy3pwNTuq+pN7O6w7LVyGG96fhuu3AwLF0dFsQ0D6OLpP9K8BUc
         0T2Rb9ST1603Azeb7+iUm/m53bApDoCa8oarlNxfJfi0Qglhr7TjKtyyCOjhcMFhrKVe
         RWJGNzr6QRo1xG5j6gkD30I+f1LeePz5fSHPedxqxjKm7s6p3ca1qZBN07OQwWRQhmIN
         PeWpuaRQ1ONw3yfEA2hOgFVn/BR+Rh+I23W3m0P5aoW8fZccy7/PVsoU4l9g/SZKrOTP
         EvV45SVCeBGNYgS/p6sqafLMxGuke2wpiP2pHtjUrYeuP8g2weyDr2mVZOzAW2biKhXl
         LLcQ==
X-Gm-Message-State: AOJu0YwQ79tGCQDzusutk+BCKUzmZpxk3Vu5FOkVlvsfI83Stky0NJRC
	uWp9p6ASq75it/Mg4jEl6AA=
X-Google-Smtp-Source: AGHT+IEQFAiqu0pWO1taS10G4nOQB5oW4bLmRUqPIg4USAiB+tdqjNA4RCW1DUHvYMBE7csBQ9L3NQ==
X-Received: by 2002:a17:902:c3d1:b0:1c3:8464:cabd with SMTP id j17-20020a170902c3d100b001c38464cabdmr6900788plj.12.1695725872792;
        Tue, 26 Sep 2023 03:57:52 -0700 (PDT)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id 19-20020a170902c11300b001b5247cac3dsm10648393pli.110.2023.09.26.03.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 03:57:52 -0700 (PDT)
From: Chengfeng Ye <dg573847474@gmail.com>
To: jreuter@yaina.de,
	ralf@linux-mips.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-hams@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH] ax25: Fix potential deadlock on &ax25_list_lock
Date: Tue, 26 Sep 2023 10:57:32 +0000
Message-Id: <20230926105732.10864-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Timer interrupt ax25_ds_timeout() could introduce double locks on
&ax25_list_lock.

ax25_ioctl()
--> ax25_ctl_ioctl()
--> ax25_dama_off()
--> ax25_dev_dama_off()
--> ax25_check_dama_slave()
--> spin_lock(&ax25_list_lock)
<timer interrupt>
   --> ax25_ds_timeout()
   --> spin_lock(&ax25_list_lock)

This flaw was found by an experimental static analysis tool I am
developing for irq-related deadlock.

To prevent the potential deadlock, the patch use spin_lock_bh()
on &ax25_list_lock inside ax25_check_dama_slave().

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 net/ax25/ax25_ds_subr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ax25/ax25_ds_subr.c b/net/ax25/ax25_ds_subr.c
index f00e27df3c76..010b11303d32 100644
--- a/net/ax25/ax25_ds_subr.c
+++ b/net/ax25/ax25_ds_subr.c
@@ -156,13 +156,13 @@ static int ax25_check_dama_slave(ax25_dev *ax25_dev)
 	ax25_cb *ax25;
 	int res = 0;
 
-	spin_lock(&ax25_list_lock);
+	spin_lock_bh(&ax25_list_lock);
 	ax25_for_each(ax25, &ax25_list)
 		if (ax25->ax25_dev == ax25_dev && (ax25->condition & AX25_COND_DAMA_MODE) && ax25->state > AX25_STATE_1) {
 			res = 1;
 			break;
 		}
-	spin_unlock(&ax25_list_lock);
+	spin_unlock_bh(&ax25_list_lock);
 
 	return res;
 }
-- 
2.17.1


