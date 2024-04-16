Return-Path: <netdev+bounces-88211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B268A6552
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 09:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9279B219E3
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 07:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502F784FCC;
	Tue, 16 Apr 2024 07:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUkM43Ql"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E52386
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 07:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713253383; cv=none; b=oSfmRJpRWjORg4+7xsoCpOGPcnlBmsGFYtz6MK+arc7MnWQJ9l36hmRGoAZxkjn/Ac4gmrzKnDRmdoyrnN1DOoEg9wwosts7qZb0r8cEvYv9hEQVVQbuCzBB2zVKgi0VJG16thWONzwNZW1kgWfe//JGOA5MP4O24SVQXWKV6/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713253383; c=relaxed/simple;
	bh=0e5hJ9hCqm6AtEKne5xfb+mesbFdHF+EcWpdCqeyrCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sVR5DFRaZimR1ViHEyFepqmZPnmQGRVTeqLxFBytbTGXHsDTMv0Mc6c/9M1Q536bj4xC8C2j3ha9aMNma7rQP0kv2KLOXqSmBHqYXRPCp7D2lt3HfoGNKBdDGnTQGfd8iaHGLXouVZiNOzXhUyOTFX9QFBw8Kue2F4Wy5PMrAio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUkM43Ql; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ed2170d89fso3103115b3a.1
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 00:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713253381; x=1713858181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H898G6JJEBxHp64rfVnRZZcHj9mNb3/HV1umOFcpYBI=;
        b=GUkM43QlcqhXVoCcv4VYD5oGLWiKy3tBFVv6xDM+6mvSuCCy6P2cXmHU5jSxpwk3eQ
         1p+0HDDw6COAE+RdcDPLJ4YCKIQtL5QMRrAMyw0NxjCu+N01clsco8w1K+R1DMdw8R15
         paNpdb1RD7CfXTEtnA1Zx8taCL3Osk40YWgVK6ijbD90oZrsl9bz8tg79d/apRxyr3Pq
         0RKZKYS3VKTOgt9mNh6BL79f9lMnmNi0rGR+VPxTZkP4p7M+cbi8FOlx0pXRpAYzCzZv
         1hQJE0GOcn9LxzPb4E/IxQtIjEER5YCn/Ff8iVlsYeyrlnlTeHtr6Crj8kGXWyDH5YV1
         OUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713253381; x=1713858181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H898G6JJEBxHp64rfVnRZZcHj9mNb3/HV1umOFcpYBI=;
        b=nyN995o4Wh1YdCJtbGZAKQcIKc0GSE6NakzateS8ZK5z7ZKxzIyqWaKIlcebefk6ST
         kkH6TA5DMDHWH+8T+7ts4nMnTuV5nM0cBL6qpdbPzdx+9qoxesKDkoU3EmiNf7muNQPh
         a+e33+evrzSY7bLvLxAGUssPSXcDkrOLTyCvj7F7yaMxPDatiP1oa42Ssnb7/uOwVEfO
         0OQXSgzpbcyjnOt/99sS+DgjvplWkp/O10odECEme/uag6Q3DTzbJ8/CVcWxsNEqAozp
         AFCBUoFnLR+ANxVw4FZIKGV9KfodFjwoK9wfmO0DxmS/4YCpRocdRFpcgtsl64m478aT
         dMnQ==
X-Gm-Message-State: AOJu0Yz/Pqa4ZEOJd7OCIam0DpVTjyW+XwNW/9zKexZY/N6KZoAy8nqv
	/H6p+aduHLUKDPEfMk/W/d9uacjHwKLe20HRl3MzYib4xIZAzoym
X-Google-Smtp-Source: AGHT+IFvgE78j//QP7QgSz1Lv608YTitPdrKKVc45b+udBFIqKqaRlOU6t1+e9V7QnEOGtClJA8ADQ==
X-Received: by 2002:a17:902:d485:b0:1e3:c327:35e4 with SMTP id c5-20020a170902d48500b001e3c32735e4mr3288173plg.5.1713253381307;
        Tue, 16 Apr 2024 00:43:01 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d16-20020a170903231000b001e4881fbec8sm9126947plh.36.2024.04.16.00.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 00:43:00 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 2/3] net: rps: protect filter locklessly
Date: Tue, 16 Apr 2024 15:42:31 +0800
Message-Id: <20240416074232.23525-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240416074232.23525-1-kerneljasonxing@gmail.com>
References: <20240416074232.23525-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

As we can see, rflow->filter can be written/read concurrently, so
lockless access is needed.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
I'm not very sure if the READ_ONCE in set_rps_cpu() is useful. I
scaned/checked the codes and found no lock can prevent multiple
threads from calling set_rps_cpu() and handling the same flow
simultaneously. The same question still exists in patch [3/3].
---
 net/core/dev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index cd97eeae8218..6892682f9cbf 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4524,8 +4524,8 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 			goto out;
 		old_rflow = rflow;
 		rflow = &flow_table->flows[flow_id];
-		rflow->filter = rc;
-		if (old_rflow->filter == rflow->filter)
+		WRITE_ONCE(rflow->filter, rc);
+		if (old_rflow->filter == READ_ONCE(rflow->filter))
 			old_rflow->filter = RPS_NO_FILTER;
 	out:
 #endif
@@ -4666,7 +4666,7 @@ bool rps_may_expire_flow(struct net_device *dev, u16 rxq_index,
 	if (flow_table && flow_id <= flow_table->mask) {
 		rflow = &flow_table->flows[flow_id];
 		cpu = READ_ONCE(rflow->cpu);
-		if (rflow->filter == filter_id && cpu < nr_cpu_ids &&
+		if (READ_ONCE(rflow->filter) == filter_id && cpu < nr_cpu_ids &&
 		    ((int)(READ_ONCE(per_cpu(softnet_data, cpu).input_queue_head) -
 			   READ_ONCE(rflow->last_qtail)) <
 		     (int)(10 * flow_table->mask)))
-- 
2.37.3


