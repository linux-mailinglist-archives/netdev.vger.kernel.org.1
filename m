Return-Path: <netdev+bounces-51761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38347FBEF3
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 17:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A4DCB21410
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95744D127;
	Tue, 28 Nov 2023 16:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="MN3vjqNa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9259BDA
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 08:07:00 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cfcc9b3b5cso21237085ad.0
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 08:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701187620; x=1701792420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9fU8LS0NXal051e/f+ednnLG9vP7ieRto8Kul0MqzI=;
        b=MN3vjqNa6LJva++FOqiqEjGOIeJiM4RnVej6tETInoSzCLBpwo6Wf6OdZG3gfvNQTf
         M3gioSmUG0o6HArEjr8rknmOD8eroXNv6cGXorkXoxRduJeQmPVpQGYZgTv8xBfyQGu3
         G2SjUSaZqajs96UKE9Y6jLWPRVJ2173mBCTrEkWddrhdYcO6G5GZm/8QIa2bJLa7pVs/
         M+GBacrPsJUq11Wdbyd+9SGcY9mKGYAC90FJJN2BwbYVom/UUMlVUessoEr8371iLatX
         5IoQtusq/tGpggKzSUh9N7bk5SEvI5h9BTaf1vW17J8MpP6b8oMzuWXCm5uOmqGlnyE0
         +R/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701187620; x=1701792420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9fU8LS0NXal051e/f+ednnLG9vP7ieRto8Kul0MqzI=;
        b=ll9ch3CyiKnoL72Ccvfdx7fKa7ZGNIY1NA4Xiwc1z4n6nmcioN2tJY4+0ACVtcA5Gw
         QTIqbhct8woj4ztviN6AhvIT77D/azTV44bQHTl12QhPbJhA090uflJzBJU5QA+lHUkQ
         J0IvvxDHZ9U0i0pDPNWXd72c25w+MqHnnUO64MyYP9bmpuwV6u20hnz3EnjW1jpzp/ZC
         80SLJMwgtWlV35TgHzGVDT5zAqrDNNYCZEGiafGpjdID7at6jofmzHNO/R2hXWtXvZ3O
         vLeBgDDFFMy5vQlhpS5s2fZ6VB/zyKpOMPqyZQ1kigIavGhIZCzTjZRgQQAM/xBNIrqb
         FY3Q==
X-Gm-Message-State: AOJu0YzOX15gZXHOIBmpQMNKaq4/lqUyr/iQtDwQ9B5pupKyUS4xd6XC
	2vDG5PdBKKhaWA7PDFXv7ugHaNZbS+0nZqwbsl4=
X-Google-Smtp-Source: AGHT+IEiPa0BlWGrxmCvE7QZ482cVqrQIvdb5t2rwMkrjaLeNILrPsTWgS60CMeF97qR7zTfadbOzw==
X-Received: by 2002:a17:902:d4d2:b0:1cf:b57a:5055 with SMTP id o18-20020a170902d4d200b001cfb57a5055mr14806836plg.0.1701187619771;
        Tue, 28 Nov 2023 08:06:59 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id i4-20020a170902c94400b001bf52834696sm8510504pla.207.2023.11.28.08.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 08:06:59 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	vladbu@nvidia.com,
	mleitner@redhat.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH RFC net-next 3/4] net/sched: act_api: stop loop over ops array on NULL in tcf_action_init
Date: Tue, 28 Nov 2023 13:06:30 -0300
Message-Id: <20231128160631.663351-4-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231128160631.663351-1-pctammela@mojatatu.com>
References: <20231128160631.663351-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ops array is contiguous, so stop processing whenever a NULL is found

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/act_api.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index bf6f9ca15a30..8517bfbd69a6 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1510,10 +1510,8 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
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


