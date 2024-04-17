Return-Path: <netdev+bounces-88580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0448A7C4B
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 08:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1FD1C21D79
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 06:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6545C57870;
	Wed, 17 Apr 2024 06:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwQmjS61"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F0D5A784
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 06:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713335261; cv=none; b=D2PjM6mLpSdtjKcbZQsOpSfcEA+/ByX74bZKAiKbsdeeVHwG2e1649hcgQQe93KWT3PkyqmARuyqiHs14/PsvZLVegfafZ1uhBsAiqtovKdworsnGmvoUPdl7lyDqjOVquQl7W/jZzmAvXq368OUjo9GVJ0VTpbfnLHj1HXn9RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713335261; c=relaxed/simple;
	bh=lG1VqfYPVS5aljnryZS192B21YJzSt3bL0wKDML71Dk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CGWRlvr2SezQRGupT3eWtz/sSQmcuRYRqlcFlAFYlyKIAAs77DxlZUuQ+JJNfy6weBLM+Oj33VO7j+x++jGtReSQM6CD+8B7krAqnatedqizMilPYxgsbFoC3KRejiEIDaZVU8bwf8xZBPPgHHCp7qkbIBoyA3SJLX0QGKpCCv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwQmjS61; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6eb812370a5so1601831a34.0
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 23:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713335259; x=1713940059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MWNLBsgAvWpxcDaMrRSKJ3+W1whAYT8zWw7ExmTZfk=;
        b=QwQmjS61xJNGqTqXKmsodHIZ7hSbNlv8kmN81n0ZIwY3q8xgLFioddfVAhyJixhpiY
         r7AggenJItr4NYYrOjNIb7T3u76EOdTg0ZMoYl7bXm/3hTLUlR2VW+39DA4qul5ZA9kU
         OzqXgNqxobIoY31LdX2voCcHtuaz9zPsumMcTt8/HZaMU4S0VozRfe9XtVXZnSpOChIG
         1qbBFCEuQVFcVAvM9aZH+Zo6CsD6SGUGwZBV4HfeUdWDliS9ox8GXG0o1U6t9Tw1Aijo
         0MpnSV1+oGVuojyc6UNZoshXUFnpn9dvoPKdXhz/ANFet4uGC6RqlzlX5/vyJzlM6V6m
         +fjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713335259; x=1713940059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MWNLBsgAvWpxcDaMrRSKJ3+W1whAYT8zWw7ExmTZfk=;
        b=LK5p1l5UI8Mo69euk5TN1bdwB0+ZWO3L/t4eoFj+edUlydDFsGCCTMJaEgsAWj7qE7
         4OU8WYlqmSJWSRefSidRefNwooZ3EvfALz2Orvnv9Iv2CYMsfbOsakGGnDeFMO9HuBsg
         g/85RkVIUYViS8imI+VsYvSEpG90CxTLy9ItqFViwyVqctEsIONvqxGe9grzYql8vFMd
         qnFDbAORcXU4ZaDlQoXG1dmzJdHmd98Tw1e7ZLwMPdoz4XBbUeNV2kSZU6rPZJ0Kbz48
         s28R7cgECnNTVxMRj13+tNU0d/UCGUV0E9E1pAgzkWvuUsAY0AK1BwyPnLDkCpzdldr4
         ZJMw==
X-Gm-Message-State: AOJu0Yw4DAungqdnSzIOh6eJGysKrDzzOZp6w7qsBo9tpMyqYPmf1Niq
	CaW4LwJK1Xzf85TfPZT+mdcIEdd/M5tAkE0fFopS8+dXfEvs0exJ
X-Google-Smtp-Source: AGHT+IEI6Peo3RP0ZxOU6CcegaA6NGdJ7zZU3BCVAQi8tTemSGFF4BUMEww+E3NyhIJBvnUPlqnv0g==
X-Received: by 2002:a05:6830:2051:b0:6eb:7d1c:bfdf with SMTP id f17-20020a056830205100b006eb7d1cbfdfmr10544868otp.25.1713335259090;
        Tue, 16 Apr 2024 23:27:39 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id a193-20020a6390ca000000b005dc120fa3b2sm9821006pge.18.2024.04.16.23.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 23:27:38 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 3/3] net: rps: locklessly access rflow->cpu
Date: Wed, 17 Apr 2024 14:27:21 +0800
Message-Id: <20240417062721.45652-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240417062721.45652-1-kerneljasonxing@gmail.com>
References: <20240417062721.45652-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This is the last member in struct rps_dev_flow which should be
protected locklessly. So finish it.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/core/dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 40a535158e45..aeb45025e2bc 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4533,7 +4533,7 @@ set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		rps_input_queue_tail_save(&rflow->last_qtail, head);
 	}
 
-	rflow->cpu = next_cpu;
+	WRITE_ONCE(rflow->cpu, next_cpu);
 	return rflow;
 }
 
@@ -4597,7 +4597,7 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 		 * we can look at the local (per receive queue) flow table
 		 */
 		rflow = &flow_table->flows[hash & flow_table->mask];
-		tcpu = rflow->cpu;
+		tcpu = READ_ONCE(rflow->cpu);
 
 		/*
 		 * If the desired CPU (where last recvmsg was done) is
-- 
2.37.3


