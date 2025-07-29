Return-Path: <netdev+bounces-210833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB70B1504D
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 17:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924C918A4876
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 15:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9877293C7F;
	Tue, 29 Jul 2025 15:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXkHXCZX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47615293C6C;
	Tue, 29 Jul 2025 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753803580; cv=none; b=LUX7OrcWkgZD9Ce7y40RQFdc2h1w6QJM/hb3yg32VbqV2Ok1k7/dZ19y9pUQ/HJkk4CBcbIraD5wnjtT2utIb+jXpLySDBYwm6DH7PprR3OLMxiiCBRwJmdYkPMWFMUbxWEpVJtqr64vfnOwI6d9BML1ra+BZ1RWC+CtKLhQCnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753803580; c=relaxed/simple;
	bh=mqhvjUwqNOMDT2jOETSF8s/jn8E14XCTSSCmTyrkZpA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qRkI5qOcwMSHvx1EsHhOhvBM3i6rXxGg0279Ii851j4JbLmsp79EW/A1RSDFqpKqyy3zetz3lhBReILyrSHSCZIdLPcZBrpXA5zJqUVe24ajTHlI+ggUeugjyXQLYEqO4yNTsJidMNXQTU1gCj8wj+pyqm7OrMHWE/v0yDpO4qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXkHXCZX; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-31f1da6d294so1403777a91.2;
        Tue, 29 Jul 2025 08:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753803578; x=1754408378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j5eeZNFACborqHyowupPEX9r5hX4b4Tlg2rOsEO7qiw=;
        b=PXkHXCZXUlDGAgQjqs1xj8flM5WGeJtIiT0pez7eXmZ44KaCrcZAdeqOw9fiY8lL1h
         3pqFpucqPg84Kmx6jCt94EfoMWq048z7nUBcGyrIJRJNDmqBStdV7bQc2lLn9y36km8w
         XNf0KoDx5p33pVBLUb1sylylIURNml2ITHoi9hBjThlS0Tc3sA2k4OlDJiG8p2IDdjbb
         wbEdVXD9qagGmNc4JXKy0CtW9oWfEvldaWDDbDTbpKg0vS1OPknnrWf5UZjTYZ61KiKz
         yHSZ6ijc9f4bqU/HankH2m1cFvEf18quB06ZrSAu0E9um74qUrPZXf+TN0mxNkSPL3hQ
         xCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753803578; x=1754408378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5eeZNFACborqHyowupPEX9r5hX4b4Tlg2rOsEO7qiw=;
        b=ZWX+0uT8hvp4PELVJ7Zl6yLm8/sxxxlZAZcJy9S3wN8BcToUY6BSvzJeasYtEicAkA
         XyHMoiAeYnw5e88U2zdDhcmmDusrEmkDbHcY/G1VVVRGcn0JXG5muAOPjvqb9/HJWOXQ
         bcrK8dQVuh1mMjn54Q6pakK0Db2h27PbHC0kFJ5ugo0YNeyjgIWU0moBaDszV4nDbKoi
         At1Jp0Ydvam8lzwF3pOFEM5Bhd7lp7g3VOzpmnGdSZeo/RPWF6MrACxh3Ig+B8S7Zhb6
         1vnASVqtanrwu/89waI6/VNkoTKZZ/PP3a7AgiXYh/RIZuYax/dHSE+PmSqQJPNr3dfx
         0Mww==
X-Gm-Message-State: AOJu0Yyy7leFKYR1oUl4XXC3O8IIuCtvwB45kgwEAflMTWbDp3IuFpjt
	JUq498+4Myv3YqwZy2ww+Y4VMSsnb9v0c0BAL96VCKjfLj4TgesKNER7fs3meAPZMCdWa9Aw+Mw
	gw/XsGzMq2ofL1ecI1R7LW7f9rc2HmRLxCsBeWrM=
X-Gm-Gg: ASbGncuaQMDTy4O8tyGF6GYtEbjKNBbEjIGfrJ1MwKzNaB2o3G+sygDGc1J8ca71JzS
	mXtx4TJEIFhpezQiiVa+wfn3BDaaQo0/2es0Z55+jw5gbkaBU60ytmPMVokBxz539GcSlghVRgw
	LbYvZ6zICKo6e80HllgPQh1IxV+P1/qs1KUToPtKPdzlK9/+EMFqYdJix4dNQau6UNu2cVBNHUp
	ZEsIOY=
X-Google-Smtp-Source: AGHT+IE7/AI7o3RdODRZQ6YpuhiMjF4CHrng+aafRNDAsZGiUQFlWhP5P6fIGaxfpf4xLV+F2ySrz4fVbOyiFqyxbhY=
X-Received: by 2002:a17:90b:1f82:b0:313:d346:f347 with SMTP id
 98e67ed59e1d1-31e77a4595fmr21659973a91.35.1753803577963; Tue, 29 Jul 2025
 08:39:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: maher azz <maherazz04@gmail.com>
Date: Tue, 29 Jul 2025 16:39:26 +0100
X-Gm-Features: Ac12FXyKWr8ljBOwNnkzqOEbwJ8JoCibDhAzDz1ZWRT-wzBlIr10NTiA7ekACSo
Message-ID: <CAFQ-Uc-5ucm+Dyt2s4vV5AyJKjamF=7E_wCWFROYubR5E1PMUg@mail.gmail.com>
Subject: [PATCH v2 net] net/sched: mqprio: fix stack out-of-bounds write in tc
 entry parsing
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, jiri@resnulli.us, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, kuba@kernel.org, pabeni@redhat.com, 
	Simon Horman <horms@kernel.org>, Ferenc Fejes <fejes@inf.elte.hu>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, MaherAzzouzi <maherazz04@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Maher Azzouzi <maherazz04@gmail.com>

TCA_MQPRIO_TC_ENTRY_INDEX is validated using
NLA_POLICY_MAX(NLA_U32, TC_QOPT_MAX_QUEUE), which allows the value
TC_QOPT_MAX_QUEUE (16). This leads to a 4-byte out-of-bounds stack write in
the fp[] array, which only has room for 16 elements (0=E2=80=9315).

Fix this by changing the policy to allow only up to TC_QOPT_MAX_QUEUE - 1.

Fixes: f62af20bed2d ("net/sched: mqprio: allow per-TC user input of FP
adminStatus")

Signed-off-by: Maher Azzouzi <maherazz04@gmail.com>
---
 net/sched/sch_mqprio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index 51d4013b6121..f3e5ef9a9592 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -152,7 +152,7 @@ static int mqprio_parse_opt(struct net_device
*dev, struct tc_mqprio_qopt *qopt,
 static const struct
 nla_policy mqprio_tc_entry_policy[TCA_MQPRIO_TC_ENTRY_MAX + 1] =3D {
        [TCA_MQPRIO_TC_ENTRY_INDEX]     =3D NLA_POLICY_MAX(NLA_U32,
-                                                        TC_QOPT_MAX_QUEUE)=
,
+                                                        TC_QOPT_MAX_QUEUE =
- 1),
        [TCA_MQPRIO_TC_ENTRY_FP]        =3D NLA_POLICY_RANGE(NLA_U32,
                                                           TC_FP_EXPRESS,
                                                           TC_FP_PREEMPTIBL=
E),
--
2.34.1

