Return-Path: <netdev+bounces-53643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4A4804031
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 21:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8E91C20B36
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 20:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E892E64F;
	Mon,  4 Dec 2023 20:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="KlNZO61W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7EB6A65
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 12:39:40 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d0b0334ffcso9459055ad.1
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 12:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701722380; x=1702327180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8DGOijOKJdOqvHyhZyvR9Q5yxUXm8+4SFnahsPvs8Go=;
        b=KlNZO61WYXVMjRwek0dln31VZ/510Z3o1YWc5xMgjbm7o1nDuMdz/MH1rht4psdy/x
         6zgDI8XCMsdBhSXHq8b797c+XvdMe8Ee+x9BJPfTrZWCg7ZEjTdYM4804FPd7NPf/5DS
         khXrTlB1VZpOkMNP08kG9PqGtCzcFOoiZJtgBj/0KENjU1jbSmwPrOtCu0BQC9uNARAg
         DH7f7m2yeV/SoGjDGmzNJnswcV3Bu/aGt1AGpLGjMcx/bxeNBOs5SW7MInLuWbFEM+Sg
         69ojLciwWDOXRAY7HNSwllQUVvYq5vm5kl6/0D0sJVOqXCTy/w8r0tCPX9WYe9rn7M5o
         spIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701722380; x=1702327180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8DGOijOKJdOqvHyhZyvR9Q5yxUXm8+4SFnahsPvs8Go=;
        b=bG+ldR11SrMWmZ7Dkkl1MXJl9tb0w3IxqB0FAOSPJ89wdA3kQM1Tg0ESX6ArDSBuZ7
         jI2An3/tL+BSqkF2siw3puw0pFyh486ZSSI9xfpHdGsAJqoJaHr8bxCPNCzvIUheZ8Dn
         PIrsimf1AjMEEfvkfeCT9CAvCLOm3t06DCh21UoyTptNA5VzJfHqEDxIGQ+fM5ugwfYo
         5TDG5JqmyJfKSG34vW4zKKQw3IXh9eiPZjdvBdsxmJUrHPB6x9Wym+oOKVrhZ3Z9KiMs
         m8lzrgi3+V9B3PyY782r+ilTJENNba5Sl68BSoc6B+g40emkDfx9O9jzuVQLHwnKKHAn
         EFWQ==
X-Gm-Message-State: AOJu0YyozERK4aWKaqqkAACPx5Io4qM8SsYMT3pjqxD1Ob2C37RuLbEu
	LsyUd3C2/eCZIxIkQi/h3hPCvzz/MY0u0rSpHjo=
X-Google-Smtp-Source: AGHT+IEAqhQ+3guO1Q3e85xUsE/+b3DQb0U07qxoCfwQ0ILo8r3+akmTW4A4X1aFdOt4woFlZp3qyQ==
X-Received: by 2002:a17:902:d48b:b0:1d0:7232:474c with SMTP id c11-20020a170902d48b00b001d07232474cmr4924947plg.25.1701722379729;
        Mon, 04 Dec 2023 12:39:39 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902ce8700b001cf83962743sm2669584plg.250.2023.12.04.12.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 12:39:39 -0800 (PST)
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
	Victor Nogueira <victor@mojatatu.com>,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next v2 1/5] rtnl: add helper to check if rtnl group has listeners
Date: Mon,  4 Dec 2023 17:39:03 -0300
Message-Id: <20231204203907.413435-2-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231204203907.413435-1-pctammela@mojatatu.com>
References: <20231204203907.413435-1-pctammela@mojatatu.com>
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


