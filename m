Return-Path: <netdev+bounces-55413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD15780AD00
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 20:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AE74281A7B
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 19:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A9D4CB58;
	Fri,  8 Dec 2023 19:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="MshjRT8A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14C91706
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 11:29:10 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-5906e03a7a4so1132805eaf.1
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 11:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702063750; x=1702668550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mu2C9stAvSzwn5q9XEHwvSeI2bjAbMFJRXH67Gr9vKk=;
        b=MshjRT8A1nzfw+tj1WD5fQNeJZWKqt95yI3WiXIirVTqIxr9PxMOgKsLazuifYgzGt
         BYMa5x/agvpDuxWQ3ph8AEt9pW4PY3CTS99BPSBby7bBgTReXxVGnkMFJ3gwPK7xx4r4
         O1Ecbe/r3zlRrnAjG35/GWoDkQYh7sfdwahrnum/7gE4zPs/cLtLagD9J7Dv0VhplSLE
         HdwTEGGPmfTMqwaa9L1au/RpxrjHVatd5GAgszrFNBr8lpUQYrwEYKI6OoKxA/B2ZOYn
         f7t8biQRjdJQoopUPN4KBd+1u3nIoGQ4F00CS4OxkVn4VTnI7MmDhE0hcd0m/WHyPbsj
         UjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702063750; x=1702668550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mu2C9stAvSzwn5q9XEHwvSeI2bjAbMFJRXH67Gr9vKk=;
        b=WopxR1yQ15UZ31NTwKqiLxpN5acxRxpiJVU/BRzgfsa6CYZwCfidCx1D+d08BfSdBS
         j8UscqTb6nNejMgEKB4EvG7VPU6Mrtj6BFlRRBj/snR18vANCb+4b65+u5ymXgV/YjyD
         Zewq/rjTZNyJsVRWlL5ejuIX3NWLQ6uZcikvNruaXTVJ5+W7ErRjfbJhHuplZdfXNkP0
         GOV0w3+LWoOlVlGncsPMuoG9nrz7YgC/0wRykevpFwBAIFAtzvQurXF6x6gLsn02nzAT
         bnIMRbJ779wcMc43SqYCg40P5pb5HMRVhpc0iU8vz5qw7I0bnOXeYrD1tqKVcQ9D+Bp0
         Deyw==
X-Gm-Message-State: AOJu0Yws3JVa16PDGJSaxiRkkShgH8uP5dDvz+XlQW723VTv+7UIAtiy
	zTGQ2XXl7o0JVCmUFepVYWeb2BJxfMVVN78V5QE=
X-Google-Smtp-Source: AGHT+IGKrkTDbUWaxyrNxJsftZgO42L8S4Dnax+v7gpet3RPuJe27T1Nvoo7KeW3jKJzPcR8qQqDqQ==
X-Received: by 2002:a05:6358:339e:b0:16e:29bd:37be with SMTP id i30-20020a056358339e00b0016e29bd37bemr429178rwd.28.1702063749956;
        Fri, 08 Dec 2023 11:29:09 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id p4-20020a634204000000b005b856fab5e9sm1916787pga.18.2023.12.08.11.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 11:29:09 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	marcelo.leitner@gmail.com,
	vladbu@nvidia.com,
	horms@kernel.org,
	Jiri Pirko <jiri@nvidia.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v4 1/7] rtnl: add helper to check if rtnl group has listeners
Date: Fri,  8 Dec 2023 16:28:41 -0300
Message-Id: <20231208192847.714940-2-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231208192847.714940-1-pctammela@mojatatu.com>
References: <20231208192847.714940-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jamal Hadi Salim <jhs@mojatatu.com>

As of today, rtnl code creates a new skb and unconditionally fills and
broadcasts it to the relevant group. For most operations this is okay
and doesn't waste resources in general.

When operations are done without the rtnl_lock, as in tc-flower, such
skb allocation, message fill and no-op broadcasting can happen in all
cores of the system, which contributes to system pressure and wastes
precious cpu cycles when no one will receive the built message.

Introduce this helper so rtnetlink operations can simply check if someone
is listening and then proceed if necessary.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 include/linux/rtnetlink.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index 3d6cf306cd55..a7d757e96c55 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -130,4 +130,11 @@ extern int ndo_dflt_bridge_getlink(struct sk_buff *skb, u32 pid, u32 seq,
 
 extern void rtnl_offload_xstats_notify(struct net_device *dev);
 
+static inline int rtnl_has_listeners(const struct net *net, u32 group)
+{
+	struct sock *rtnl = net->rtnl;
+
+	return netlink_has_listeners(rtnl, group);
+}
+
 #endif	/* __LINUX_RTNETLINK_H */
-- 
2.40.1


