Return-Path: <netdev+bounces-51762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 125627FBEF4
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 17:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91304B2139F
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DE858AC1;
	Tue, 28 Nov 2023 16:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="c8PbyFSu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA0DDA
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 08:07:04 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cc9b626a96so43085375ad.2
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 08:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701187623; x=1701792423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FK/VzK7W81OA+pk8VXhpBSRA3B9QewhHJnuQBEzuyas=;
        b=c8PbyFSumS4NzjTjZDRtLMIDiLhC7kS/7LmnaSM7YwRCpqKLEU27dGrMnz9piUNzcP
         echJEAPJQNmaazRhPBxfnJKyOmrv46Tf8FcihhcTe4GzVEg+3iQ+40fn200w533tkwJT
         F3Jbog/hIQms9VeD7kYKSJd2zyvcSDZnSkqLmCTAjnTKBwFIAwEt56bsEmh2Fj7aPGS8
         rJ62/rpTftFiRFKD/5KJjfRmg5GH/hjgHeTcDEVcv2Yts5qu5i5JxHT7omVZgEwnhs1K
         mWRKgd2JwuYIn/LlX5Mnh/qAoF9A6TYbOqtvNDZV5Tu3Q8zIOx9Uio8wNOONQ4Jj+dsb
         SVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701187623; x=1701792423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FK/VzK7W81OA+pk8VXhpBSRA3B9QewhHJnuQBEzuyas=;
        b=SJeACvP7cvu/2pyLEnp6zzLUSr6HPGsNKmSbCJKE/4ZCguNNwygouqhXe9FVv8zEzb
         jWk46TXAzUxJVdXQUwBpUTtiLrPwS+CxKn1lGIPlstqMeZXt5+1LoOJF8cq6dH9a8SVm
         9yCa6YbnJm349qtFs60DMzO+ybT7zPXAVVVchqJKxvhi07TFHLVxHF6DLB+2FjdWlD6W
         fYjPTyCNeCZhf516L483XQrn8OVIc6iBH2VKizXq6zEpZ4OWWwjyMS/+8zMHtQjfhvnT
         oqythRfYh/r/XnUXzeCVgFBMYtqAjFyP9uaq6zorQBRqVkZCk/Feu5/ALYqaxxQ5/4J2
         HZxA==
X-Gm-Message-State: AOJu0Yw/PNHKVJA0kP4TD48ipleOMApl6F4n5hKfbtU5DSW0zbQ3+bOR
	tr95H86xifCjr3Frfh7fsWbiq5p3ZIP/HdjkkVo=
X-Google-Smtp-Source: AGHT+IFHkWQDl7ypo+M84XS22yPeoT3u8yyYE8IqoskblXFwRgn4aG1ktTsGOVZJENMduAVYPZsRlQ==
X-Received: by 2002:a17:902:ee82:b0:1cf:96a0:e4eb with SMTP id a2-20020a170902ee8200b001cf96a0e4ebmr15225081pld.37.1701187623610;
        Tue, 28 Nov 2023 08:07:03 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id i4-20020a170902c94400b001bf52834696sm8510504pla.207.2023.11.28.08.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 08:07:03 -0800 (PST)
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
Subject: [PATCH RFC net-next 4/4] net/sched: act_api: stop loop over actions array on NULL in tcf_idr_insert_many
Date: Tue, 28 Nov 2023 13:06:31 -0300
Message-Id: <20231128160631.663351-5-pctammela@mojatatu.com>
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

The actions array is contiguous, so stop processing whenever a NULL
is found. This is already the assumption for tcf_action_destroy[1],
which is called from tcf_actions_init.

[1] https://elixir.bootlin.com/linux/v6.7-rc3/source/net/sched/act_api.c#L1115

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/act_api.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 8517bfbd69a6..980dd3b51dd0 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1290,12 +1290,10 @@ void tcf_idr_insert_many(struct tc_action *actions[], int init_res[])
 {
 	int i;
 
-	for (i = 0; i < TCA_ACT_MAX_PRIO; i++) {
+	for (i = 0; i < TCA_ACT_MAX_PRIO && actions[i]; i++) {
 		struct tc_action *a = actions[i];
 		struct tcf_idrinfo *idrinfo;
 
-		if (!a)
-			continue;
 		if (init_res[i] == 0) /* Bound */
 			continue;
 
-- 
2.40.1


