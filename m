Return-Path: <netdev+bounces-53022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA01801212
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE9428142B
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 17:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFCD4EB30;
	Fri,  1 Dec 2023 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="RVChvPV2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06073AC
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 09:50:43 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1d05e4a94c3so5324545ad.1
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 09:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701453042; x=1702057842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Negl3oSbs7nvJG91Jt9lug4Hwh/K36CKFflQqJcvQVs=;
        b=RVChvPV2tSy05naG4Ga5RQOX1Bdou4SICEjTvccg/Rf2YeFsfvl1q4bQ00DtgSunms
         +xT0QE0cGH7rxK0T6HWhWebHeU1axQ6gKmHKRViUhtBX5lC+Mvu9rd6owmWpGeYeHX4S
         YuvaRvxqpgwNACgi+F0h0UXASSqclWCazwdbNPsoPgAs3FbOPgrQ8tu1H4JskWsn+t+W
         XR6YhKKJ3AH6FUYalDB8H4NYlfNZxqi1Fo/srBtewKSO+Ov0nkEifJb+10tkLNkCQgtu
         MhkWkpvWZxBtj5jBxkx+tg6ucD/nrITmEkH8M2I/Hi55aw9L0cD6IaKIo7t6TPMYioYu
         0oJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701453042; x=1702057842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Negl3oSbs7nvJG91Jt9lug4Hwh/K36CKFflQqJcvQVs=;
        b=B5+9+YqknLquYBhVN7AWnXaH5Ulze9NDo/BZbdRv2pEh9B1m9s/TvsGs4ige4EvU07
         oNa9Tyqj1zJyrzBZgqLTU4O7cpdYONoL0tq0X0i9CPdovNjBghEQQpidkI+JaSeHWblv
         1C37a/sJn5fMK7UYrHV5boFAhAEyW5x3CfENQ9qXfP8HsVyXmhXrnPkcB/FIWGNa1FjB
         BYYvdvVV5xLAp9IYiZuIjauSoBQc5Wb0rRoI/s3L+Ty8YvnHwybl+RsLdOW91Gj+r5MS
         eiZIiT5NqNB5tFhtaGCnWwZbmefiMKbWWGyRDXnrj1P00t0Cbmpmi1vFi5mspgYx2V3h
         qAAA==
X-Gm-Message-State: AOJu0Yx0C5Gjz9PNEp2ddlE4jzMHuxy3mveqgqu97LWHi/UcXUP0ilbN
	4qTPXjBpGJV/IY6oHIVV5d+Kvd2knHUqdpqo7cE=
X-Google-Smtp-Source: AGHT+IHQn2qalnNKOu0vLLOeMBUUknb2wH8NV9NwL5akyqqxNaZEWjyrj1cNKHE/9ihvlY0WX7RHBg==
X-Received: by 2002:a17:902:efc2:b0:1d0:4b44:8590 with SMTP id ja2-20020a170902efc200b001d04b448590mr3101282plb.54.1701453042348;
        Fri, 01 Dec 2023 09:50:42 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id v11-20020a1709028d8b00b001cca8a01e68sm3619729plo.278.2023.12.01.09.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 09:50:42 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	mleitner@redhat.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v2 3/4] net/sched: act_api: stop loop over ops array on NULL in tcf_action_init
Date: Fri,  1 Dec 2023 14:50:14 -0300
Message-Id: <20231201175015.214214-4-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231201175015.214214-1-pctammela@mojatatu.com>
References: <20231201175015.214214-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ops array is contiguous, so stop processing whenever a NULL is found

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/act_api.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 2e948e5992b6..d3cb9f5b25da 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1506,10 +1506,8 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
 err:
 	tcf_action_destroy(actions, flags & TCA_ACT_FLAGS_BIND);
 err_mod:
-	for (i = 0; i < TCA_ACT_MAX_PRIO; i++) {
-		if (ops[i])
-			module_put(ops[i]->owner);
-	}
+	for (i = 0; i < TCA_ACT_MAX_PRIO && ops[i]; i++)
+		module_put(ops[i]->owner);
 	return err;
 }
 
-- 
2.40.1


