Return-Path: <netdev+bounces-180600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB3EA81C45
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 07:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 583A819E6DB4
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 05:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619111DE2C6;
	Wed,  9 Apr 2025 05:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhLT9PEe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03541D90C8;
	Wed,  9 Apr 2025 05:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744177424; cv=none; b=mfEBb3bvLmqJbIViRqRYs22uK7Tbqu8V57l0b3AIKyqLjv/Ng19U5aGuDCUIvYcQ2VBiHEUp8q7zrQo+g1a7SL/OnpLr9MO3xGXqwCPW7gEvDXgc2rgnjwnxu7YyCJ2ddHcevL7a3cuyRa07OAnkusdh7OEtDo2HvjoL908Z+ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744177424; c=relaxed/simple;
	bh=QsoIXU3R68W1HSWv2/JVUojsjXdbneDZX/yJ/K2kuwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RsG5/y8eDOdzsWFZcgoZwZeBYJ9nSs/GVGgjAag/z42O2QZsnhOUcx7vVfEBsjBSIKX/1CyBaOVt97rgCWKA/dOsih0KlZy+nMpkCA2vaYD4tq5ePEskSv4v+uzOhp5ChzKz0ymrZYm07gWD8i+V1v3ckclTtQV73sMMI96OCKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhLT9PEe; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-af9925bbeb7so4797091a12.3;
        Tue, 08 Apr 2025 22:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744177422; x=1744782222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h0+8QrxIEMZCQLvXkMsmq3iISJHFTsUHU35F1UKNl04=;
        b=hhLT9PEeU2q/oI9zI+bedzLllKwoUz24pLU+SrNUkzJ5PUe5Z8T1+XJcowY1B7a4e1
         HARXf8rGxhFQubajX0qOWtLKMfT4o65/+D/aPCvk0BmXEmbCfiSog4co5QAI1adtZ36w
         64QHuscj5QVRTcdMzzabZkYrOJ8kKsuPyEZi85fJEM1ySw+j08jebCKS+KhR418nbaLO
         QUbMTu14FLkzVYhh9cOjM2WK7c4M3qb5JsTex7hDHDrT/mQPPWT/dy5kUkjyoZVqZg5w
         W4dveLBqzjiGC11x9dPEubFztVIhdBWO8/m6sPzHz8wEiXvma3NvLo0OS2bwRLMwTjeD
         UHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744177422; x=1744782222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h0+8QrxIEMZCQLvXkMsmq3iISJHFTsUHU35F1UKNl04=;
        b=jNgs9dDYshhcDMXgALBnS2dQyxDjoBH11S9wjHfUCXRckMEGMI7tycYbXRExxC4Wkp
         rgtFMD5yy5lzRhDv4n4oH2qmS93coGfoxeEV6Srqcat9sF7duG7vYTZe4VX0fo1URYs8
         ulc92BgFHfsp3+I1pdVth8EYgk4UKpNF9TWg8nWFNuOL/Vr3tm0X3qDld3DN2t4llrLU
         ZxPx6Ayl63WoXGHWdMrqaTEVBJrqKAZEEVW3JCG3jFKKaHU8h+8EOm3q69tpClkcuJp7
         8Qg/akY+59HEbBpezYouiAijvzHgxjHvGQMiv/8vJFQUAhf6/fJxMqYu/6xdOi9DA6q8
         qR+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUGYPTPIfIJutwYt5d3+TH4z6OOhygFglXxI5vRI5QnsXNd9Wf/STdS4J0qPheH0zAFXYhoMECLKconRA0=@vger.kernel.org, AJvYcCWInofD7BycCrP2MuNHu7VKxm9Q7eYknXbgRex9iSAHSZBMec8zXaHzqGrJ85UXUV1L9k/JMPrK@vger.kernel.org
X-Gm-Message-State: AOJu0YxpZcFe75hJ3LpKUH6PDxl8VpWPa9rwHfgInkQF3Je+0QTo3m0j
	mATiglEk6LJBDzIzZLJcrgWcdzK0K1uREQsodrKMPEz4MS3glcgt
X-Gm-Gg: ASbGnctSt61k0bnmJv622bUjL/+8BA4sdEd2q4TG2slBAxuG2BleoLVo3OcAkd9V8cT
	tHVmCdagbqmPfM9jCr97KwO5nTkKGSLhcfNJN39ikA01/sek5D9hnOuaHU+KeNSn2LBgTbYOXak
	Vm/kURnDfU9hnfzq9iR+J0Mjg8Vj5sW6Soxc+nZpKUuafjTox3yXRINtJHgkh6ybSGM+ojFFwoq
	aPl5fIZJqX6JOyqiKoLDiiUz7EKbj17CQ4tfaibFzTNefziwmWZhWMq48OksKYzWmMUKLmkTGO1
	mMCV9YwEoTkdW4bBMpWDF7M/5KyR2/OtP7VfygUZDb467frA+zML
X-Google-Smtp-Source: AGHT+IGKx3TUSZM6JYyNC5zESYyJS1sGFIz3I8qCoEYJ2ix9eYBl4TE/4p/f/SuiBZHe3Jm+/aDkMQ==
X-Received: by 2002:a05:6a21:9104:b0:1f5:5807:13c7 with SMTP id adf61e73a8af0-2015aea8f13mr1902804637.17.1744177421971;
        Tue, 08 Apr 2025 22:43:41 -0700 (PDT)
Received: from nsys.iitm.ac.in ([103.158.43.24])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-73bb1d68cb1sm395591b3a.75.2025.04.08.22.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 22:43:41 -0700 (PDT)
From: Abdun Nihaal <abdun.nihaal@gmail.com>
To: bharat@chelsio.com
Cc: Abdun Nihaal <abdun.nihaal@gmail.com>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vishal@chelsio.com,
	rahul.lakkireddy@chelsio.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] cxgb4: fix memory leak in cxgb4_init_ethtool_filters() error path
Date: Wed,  9 Apr 2025 11:13:21 +0530
Message-ID: <20250409054323.48557-1-abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the for loop used to allocate the loc_array and bmap for each port, a
memory leak is possible when the allocation for loc_array succeeds,
but the allocation for bmap fails. This is because when the control flow
goes to the label free_eth_finfo, only the allocations starting from
(i-1)th iteration are freed.

Fix that by freeing the loc_array in the bmap allocation error path.

Fixes: d915c299f1da ("cxgb4: add skeleton for ethtool n-tuple filters")
Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
index 7f3f5afa864f..1546c3db08f0 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_ethtool.c
@@ -2270,6 +2270,7 @@ int cxgb4_init_ethtool_filters(struct adapter *adap)
 		eth_filter->port[i].bmap = bitmap_zalloc(nentries, GFP_KERNEL);
 		if (!eth_filter->port[i].bmap) {
 			ret = -ENOMEM;
+			kvfree(eth_filter->port[i].loc_array);
 			goto free_eth_finfo;
 		}
 	}
-- 
2.47.2


