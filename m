Return-Path: <netdev+bounces-160734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C447A1B035
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 07:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072C6188DF19
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 06:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056E01D9A6E;
	Fri, 24 Jan 2025 06:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVKaELpI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF571D9A5D
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 06:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737698877; cv=none; b=nzNXXl1t4apyVFf64tbuoAPB6OH+Sh4+mXi0Bgg6rqNVwCk4WzBV+RVZXaOkTDxV6qfM8ikApN9Y337O2/Julkxdmlf16LF3HjzCzxZeEhLugRGpf6Id6szMhwA7f/buh2Apsv874Y4QcXr22kpk7UFLN3g2EhsQF2R1ckgOkII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737698877; c=relaxed/simple;
	bh=dKBbo/zOKaY/725VVR3ZaE2PLTItUmhVxhmz9H33944=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fVpLKr5OdNvGkIbup254B973OiV9JXjbvgoZYMI8W7JU8iZ9QtdRf2fuUH4bEULFMR8pxByXjNntEk4AABzIlFKNC6NrbxI2CE26y3NruHQZ05bjj0UO5gezaWQwYARUeKPyDvPy1DAYVnS4u0fBIhv53HshkQl5MxmCJDWCqMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVKaELpI; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2163dc5155fso31000985ad.0
        for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 22:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737698875; x=1738303675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lFN3IzbSH6trKyBzTVcJyUt+VsO7adS97MfPgoyp6s=;
        b=bVKaELpIiPj8yNbkfH4UjAgqDHPk5j0ThbD5sihOBdlfRX+YLwFV1ALKrMdLE7kbKW
         BqvKtcukST5bi14Ekvo6/YI/PWdFXHyRxHONFP+1Dgjp4uLgqUQ5DThKP2ggSkGKuN8B
         SV7lGfn2dfsXcGpfkvWbUKAhe0t5U8GTjzIW6D2i8znEKqpD6ijCaNmybjSycwvVAxpS
         NtZx+yFF+BkwU9QTj2AVaqb6UhdAPE429458MQwVv32KzBAV3b4wV42O4nmPuE9cMSs+
         wW6wPhEZuBIOnCwVhJkcTRSy8kT7+likJCLVdfDDeFn8nEUT3YVXyMp236ioeQiYOgqf
         bXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737698875; x=1738303675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lFN3IzbSH6trKyBzTVcJyUt+VsO7adS97MfPgoyp6s=;
        b=E1t4+roD7tMVnFEKpLEsDhYv47q53SB+AS9wsju7gZRJ8nkhtUPpQ6WbJ86a1Nmszs
         3z6wDvi/wSMzClmITO7uCGBYtsJ9p1y37iKk+y8N3rYMiyP8bWKhvS1rUUxCE/pxPZN7
         JhKenSGTk740QHaidwxdvzS0u0KwYCulrQ6jWnOS+00OOAyahZ8p1A3sO+jz//3qMOW7
         GKXugyFVoja4K1ywweivsGiiTeFwjHHjKVZ2SeD1u41Gh9lnIVI+H9skNsEatqlM/YeI
         pEe9vV53iQpsweKEj6+YCeeDKdymfvzCZmS9boi4qb8vgnLYZJA1NWgRrmUWj5f0/7AC
         Hb3g==
X-Gm-Message-State: AOJu0Yw2CU4+UaZKnlFioR80Ukxecq5Xy9fd2D3ZQ7tKjBtymzX/FLD1
	X3cps4hHyXvf1mKz8DWI6L8YPcn+lkZbO7d262F5FmWzKZk1Z65GI+TiSw==
X-Gm-Gg: ASbGncvdsb5A883JQ4FiQZeY+DAf8TFIpnmq4PBmjilcPrsIKtKy1bXu4/Mzoe0C3UA
	06+xE4lx4OTAAL4+zXtJOoirfKrcFq3AFCUFkzjh3l+KFWxh+LqMznxOLiLNjwR7trCbrBBz2RU
	tY6Eg5bTOhxBxTX7ApwCbJir1VdOHadapzHapB2FaPmg2lB/P30ka76FnrToqgAqrLeT7JvVuNp
	kcfEcZVP4p7HcFxkog+Nv5J9dJWFCFP2mpW9K7sUN7ydB0Yn50azTe1hfq7e6RoUaFRHOcXj27Z
	o+nnPKydd8R+GkEHkG7/RknC03n3fG/C
X-Google-Smtp-Source: AGHT+IHWXVLE7PZM0QOqy0Y9hdORHlMhNKyqwnGqNIx8V6mjOTutnv8JdyJZEldQZ/n8097Bd6ot7A==
X-Received: by 2002:a17:902:f70a:b0:215:a7e4:8475 with SMTP id d9443c01a7336-21c35557a0bmr504337475ad.24.1737698875140;
        Thu, 23 Jan 2025 22:07:55 -0800 (PST)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:2d85:604b:726:74b9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3ea55dasm8696095ad.101.2025.01.23.22.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 22:07:54 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	quanglex97@gmail.com,
	mincho@theori.io,
	Cong Wang <cong.wang@bytedance.com>,
	Martin Ottens <martin.ottens@fau.de>
Subject: [Patch net 3/4] netem: update sch->q.qlen before qdisc_tree_reduce_backlog()
Date: Thu, 23 Jan 2025 22:07:39 -0800
Message-Id: <20250124060740.356527-4-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124060740.356527-1-xiyou.wangcong@gmail.com>
References: <20250124060740.356527-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

qdisc_tree_reduce_backlog() notifies parent qdisc only if child
qdisc becomes empty, therefore we need to reduce the backlog of the
child qdisc before calling it. Otherwise it would become a nop and
result in UAF in DRR case (which is integrated in the following patch).

Fixes: f8d4bc455047 ("net/sched: netem: account for backlog updates from child qdisc")
Cc: Martin Ottens <martin.ottens@fau.de>
Reported-by: Mingi Cho <mincho@theori.io>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 net/sched/sch_netem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 71ec9986ed37..fdd79d3ccd8c 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -749,9 +749,9 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sch)
 				if (err != NET_XMIT_SUCCESS) {
 					if (net_xmit_drop_count(err))
 						qdisc_qstats_drop(sch);
-					qdisc_tree_reduce_backlog(sch, 1, pkt_len);
 					sch->qstats.backlog -= pkt_len;
 					sch->q.qlen--;
+					qdisc_tree_reduce_backlog(sch, 1, pkt_len);
 				}
 				goto tfifo_dequeue;
 			}
-- 
2.34.1


