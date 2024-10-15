Return-Path: <netdev+bounces-135493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4F799E217
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F40CB283DFD
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 09:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89631DAC99;
	Tue, 15 Oct 2024 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLG5LHGY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D8B1DAC81;
	Tue, 15 Oct 2024 09:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982981; cv=none; b=MskqMHh9u4l9FUcqdQbOJdFCBJVvtjUgnqTBUvG3ID3SBIrIDBUrQzsVwPa+fOoITtfDp/paoX27xPgsVTnqRi2XFulekJYLy6AcXKsuH16HW3OjaquM2pe3epJjmFrTH5cQnMdN+vnysHuw0yzHjBMpfi6Ii6VDbm5A2fnZA4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982981; c=relaxed/simple;
	bh=nDX+lpEBz/d6rct1V9vrgEkXK/jOMKqnRBp3deU5cHU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TSPI1QBSwBRijmt0HCXQzPs8kzfnmm5hQNeT3aivAH3z5aL0T8Tx4kRPJQU2mB07GqFlRaI1XukAE2gyAK+yXGlGVexZVJY81St9YbR+5cwMDCxooVuYBJNxCGXFcNaG+bvR3wfuGFjXakWOkFe71SyEYYiCN72woqtX4q3rNQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLG5LHGY; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-2e2cc47f1d7so3440139a91.0;
        Tue, 15 Oct 2024 02:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728982979; x=1729587779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PCBMt66PB2xv45t5KGFKbfvsEe/gEH6D+fe8Jj6bZu0=;
        b=BLG5LHGYGIk6cRb9xRGiSA9+8rgVJL1dekT9reWn7cxqTX3gCu/JsUGyJfcQOxda5e
         I4GyV3fMjO0mYcPGNK5dg45rkkoKVsrTBKCEkN1nph2IK4lC0rdGsoXeSoKj0BkFGcuS
         beDvyFgAJhwG8/WN/wDN7qpetBdeITyh3wSAtg4XZDMRFZiXbFY/j+dQEoKTdRkB2UY5
         ZZZBaJQXpgKS0YMTzCDjkzipMN0CWAjRrYcl21JSG54GlJFWBAQFRtNRP21sVIR7wv0K
         1YNwmRHAY5xYGuTo9/jDThTNYUI6LEAOht51rlgxmiCO8Uj+Le2HiRnh7gFVtiI+uH/1
         D1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728982979; x=1729587779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PCBMt66PB2xv45t5KGFKbfvsEe/gEH6D+fe8Jj6bZu0=;
        b=hIkp2zG6djMzOgJ/SUSea8vWFBHMeh1lkWWMz2G+t/7vs0KVEXRqbvIhSwkBXs5JO4
         /QiXMAZuLVxCPqnGc5v9E0GFnc9itS6dh7sTlQMgQVoZFMfLDAxe6W2luBgQolxJA/Vj
         F9TQUsFNAQ1Dh68IJL3vZxpozmKHDrvTpW4pY9aHhHAneQjLy/C8zMkvf6bmQNRXN189
         OLL3w6VaT2lbwrHgTgMmyjDRRjKdQu8qDQBTpzqR0ztTmo6VX5PSbLOqGdPtgf7WX85b
         Tnyh1vsLUOa65aU07QAm/nUUTM6AaVsHhHeEPgvMcON6uRKuKLyy0xIw8Y/1lOyUw4Ln
         cdlA==
X-Forwarded-Encrypted: i=1; AJvYcCVGh/olHpBPqfLPX73xB5ERJDMaJqPG5qTx2yekPGvX0vI3clcEDe9nMoq2GTtQVxEXHAe0YD5IwmEGSRs=@vger.kernel.org, AJvYcCVtgu9EKK5YN7CAUzhxbVNFL/FesHodeEow1YSVdmLraI5XB/RSrgoygS1pohnJj0PMBIQ5eA2E@vger.kernel.org
X-Gm-Message-State: AOJu0YwaCuJo7h1VfPtxO/i2HSzl2zHKD5K3V9UDtuqWbapHAPD27ldj
	Ql2DJsuWbBsK6GuT6zXzCJP6oh76Ck01Wd4R37uuzxrfoxAGKjFP
X-Google-Smtp-Source: AGHT+IGZJm9v/GTX6rSlEvoRhlQOfUgBM2YAF0HxODX5dVlXsGFuSvBbYakcrE6VPAxn+HayoFfDng==
X-Received: by 2002:a17:90b:11d2:b0:2e2:878a:fc6 with SMTP id 98e67ed59e1d1-2e2c81d36a4mr29250599a91.18.1728982979498;
        Tue, 15 Oct 2024 02:02:59 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c715f3fsm852705a12.91.2024.10.15.02.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 02:02:59 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dongml2@chinatelecom.cn,
	gnault@redhat.com,
	aleksander.lobakin@intel.com,
	b.galvani@gmail.com,
	alce@lafranque.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: vxlan: update the document for vxlan_snoop()
Date: Tue, 15 Oct 2024 17:02:44 +0800
Message-Id: <20241015090244.36697-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function vxlan_snoop() returns drop reasons now, so update the
document of it too.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 drivers/net/vxlan/vxlan_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index d507155e62ce..fd21a063db4e 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1435,7 +1435,6 @@ static int vxlan_fdb_get(struct sk_buff *skb,
 
 /* Watch incoming packets to learn mapping between Ethernet address
  * and Tunnel endpoint.
- * Return true if packet is bogus and should be dropped.
  */
 static enum skb_drop_reason vxlan_snoop(struct net_device *dev,
 					union vxlan_addr *src_ip,
-- 
2.39.5


