Return-Path: <netdev+bounces-148138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 708EF9E06E6
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 16:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3782E281E36
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517EE20B7F0;
	Mon,  2 Dec 2024 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCobbnR1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB5420B7E0
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 15:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152903; cv=none; b=gzVz4Icvypw1lPYWr9EOm+0zTzogFWy5tfJxxE9iapcGRt2gzMnqizkYrl8dYuRg4/lypdH5a8kTZDWxajzFXbj1QKBF0U1f4/sjkeMmpi4LVivHwZ5/lb547v/B7TT6yrfmpbiRuh4tkp8G69QKUkZGi8yZ5UYr/HC8uPvMF08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152903; c=relaxed/simple;
	bh=8g73Nwwl2kczAP/WH2/hx4EaZ5z7xZ/LUOZIJmAeQD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MwNnKM9mLnEnNEqdQ8Y/t8ZULmgeuT0CzosCMUnRValg235f2w3kbkVSKls52/5gNBoyg3zhjfHwtgG/q0vBTUWjgG8GImI+Vbx9xSvdwkYj9G1yBPhreNcjh4HH1Paxhqyk497zIljTAkTyn30wpNJAKdhmDXlxLZZ/prRbqd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCobbnR1; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b673aacf13so464116585a.0
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 07:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733152900; x=1733757700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h4C/z7Ht8LNohyUydKvzhk3FnEvHRt+HolGkLY0PF/U=;
        b=iCobbnR1gfHxrsWF8l5awyCuUpLaFjYXxWUuopZwxiU/za7pANFw5XbBTRL0EjbfIm
         aoAJ82BKArRbbQ4nf+Dh09JVjJlqGF/jCFfw6E8HrMLUTMwPpvIdffQQRJrTXvf+LQZ5
         f2hjla49DdVCzU53gZa7yTvoaUGl6WHGjjVOm77pRbtsSyt/l1kDkzeEAAUUqDVPIEU9
         PFthzT4HjSBPCEkoOcyRoEGGkVD1LY9gMA10OwKOE5L4pALJmN7DGJ8gpaXwGGAznXNM
         psEoH+ANvPuPHO+7DY1x+wKZDdpU0P8Gtv2V6WDP7a0tx9ldutsIMzahgyvPuypIragi
         M44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733152900; x=1733757700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h4C/z7Ht8LNohyUydKvzhk3FnEvHRt+HolGkLY0PF/U=;
        b=aiHm5ZeTWTuqCyRTFE+9/sP8sdAzlg8eI3Q8Y0zVxHyttqOFdqwNJRUZfBC/6NqBez
         JicyyEhNPTeewYIgtuxrvuRNey4XUyOfGdfKYv4EqI5/ly84pxokJYBFdto9KKSh6BQ5
         Lz/rSG7y8IAr/HVgnAuyvo08aL3yiyTudcxJbsPjXsLjjAFdKmBozUqLeJm0QGngHnKP
         upBq4R2+PBX10PURZ/p5cv6mbkQvV8Tj9tbzIkdqziHhj3WVNm6xge4i0dcmtDuGgRFy
         bgoYRs+tgE7a1woFAt6qzpjwUCRk+HUzfIba/jNvDYNn+iyUf9xnPfouZ2m0p/efW6/P
         OQrQ==
X-Gm-Message-State: AOJu0Yw2gu0dFteXTFZ/42mQvsuUl/zqQyXhga08IM2vPmLLRUT87u8N
	2NZ8LqZUCZ4k11eKIJGTydN0M/wnvGxz3MAzPQPdp5cNXQV409VR848WMQ==
X-Gm-Gg: ASbGncvi2ZvCWfbSzryhCOefDp7G1BZy6ErnN7BsP1eDG4gp78pQljtSr8JM6Wtby5W
	AN74p4ELXEipnhgI4JVwhG/uxf+JVZU59p4Fvhy0wP3j5qAOIiDYxh77GfSVW1ewcIhm4TNhVU1
	C9HMYTbxifYaocR4XBOCu1QWJqktBKxAIJUGjQ3BhQw9grKtWZD/qvruCO7nTh1yAr4+bV40jd5
	T+sCFhXHlcBfwB5ZZcdAzxzt+nIha9efoO8kE4Gd4gZeZPoJ4dUgitDgQ80DybNI2Lwe16HtENR
	Os9/9YAA3w==
X-Google-Smtp-Source: AGHT+IHiJY1OXGE5KkIxblpdnfu3Biqj64DRplL/L9379kqijy2SGrMIoZ/hr/VK7kmHpcL3okj3Yw==
X-Received: by 2002:a05:620a:1928:b0:7b3:5c6d:9625 with SMTP id af79cd13be357-7b683a2da31mr3301055985a.16.1733152899998;
        Mon, 02 Dec 2024 07:21:39 -0800 (PST)
Received: from wsfd-netdev15.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b68492cb81sm410473085a.34.2024.12.02.07.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:21:39 -0800 (PST)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Davide Caratti <dcaratti@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuang Li <shuali@redhat.com>
Subject: [PATCHv2 net] net: sched: fix erspan_opt settings in cls_flower
Date: Mon,  2 Dec 2024 10:21:38 -0500
Message-ID: <981381d3d1aaa4f81619145180e06338af487a42.1733152898.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When matching erspan_opt in cls_flower, only the (version, dir, hwid)
fields are relevant. However, in fl_set_erspan_opt() it initializes
all bits of erspan_opt and its mask to 1. This inadvertently requires
packets to match not only the (version, dir, hwid) fields but also the
other fields that are unexpectedly set to 1.

This patch resolves the issue by ensuring that only the (version, dir,
hwid) fields are configured in fl_set_erspan_opt(), leaving the other
fields to 0 in erspan_opt.

Fixes: 79b1011cb33d ("net: sched: allow flower to match erspan options")
Reported-by: Shuang Li <shuali@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
v1 -> v2:
 - Initialize the hwid by invoking set_hwid() with 0xff instead of 0x3f,
   as suggested by Cong.
---
 net/sched/cls_flower.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index e280c27cb9f9..1008ec8a464c 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -1369,7 +1369,6 @@ static int fl_set_erspan_opt(const struct nlattr *nla, struct fl_flow_key *key,
 	int err;
 
 	md = (struct erspan_metadata *)&key->enc_opts.data[key->enc_opts.len];
-	memset(md, 0xff, sizeof(*md));
 	md->version = 1;
 
 	if (!depth)
@@ -1398,9 +1397,9 @@ static int fl_set_erspan_opt(const struct nlattr *nla, struct fl_flow_key *key,
 			NL_SET_ERR_MSG(extack, "Missing tunnel key erspan option index");
 			return -EINVAL;
 		}
+		memset(&md->u.index, 0xff, sizeof(md->u.index));
 		if (tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_INDEX]) {
 			nla = tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_INDEX];
-			memset(&md->u, 0x00, sizeof(md->u));
 			md->u.index = nla_get_be32(nla);
 		}
 	} else if (md->version == 2) {
@@ -1409,10 +1408,12 @@ static int fl_set_erspan_opt(const struct nlattr *nla, struct fl_flow_key *key,
 			NL_SET_ERR_MSG(extack, "Missing tunnel key erspan option dir or hwid");
 			return -EINVAL;
 		}
+		md->u.md2.dir = 1;
 		if (tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_DIR]) {
 			nla = tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_DIR];
 			md->u.md2.dir = nla_get_u8(nla);
 		}
+		set_hwid(&md->u.md2, 0xff);
 		if (tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_HWID]) {
 			nla = tb[TCA_FLOWER_KEY_ENC_OPT_ERSPAN_HWID];
 			set_hwid(&md->u.md2, nla_get_u8(nla));
-- 
2.43.0


