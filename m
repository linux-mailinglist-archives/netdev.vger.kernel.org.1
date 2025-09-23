Return-Path: <netdev+bounces-225574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A083B959C0
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D61A817E24E
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 11:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5E23218C9;
	Tue, 23 Sep 2025 11:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D37FU1jK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3518189
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 11:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626360; cv=none; b=TrddVs3hT/8OQOrd3bWLXWO1THg5FBZBBLYUYEE5hlB8oow5g0anWboOY2mlnh0/9ey+lZ1R/RJi0AcJgvtkx9xuKP8BDeOMYvLUPzQ78SYc9dRcIfYKNfe0sHPniYHmoe2Cu6KE5yourtTaKhNDmb5qDhmVfkrb4B8ju/MUonk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626360; c=relaxed/simple;
	bh=FhrQh8wlJhkiGsJ13lu3sPHpZl+KsdORpiUvpf3eogg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=c6uO3SxgMw0P/bIQm9F/bBMbauWX2EH0+IAg85Y/kUSpVGj7lzO63R67d/rLrRg9ECF9/2w9yCHMxah+Qwi+eA7djS2193n4JYMHqZNCBZ9NXuL/CgfcuYseM/faPSPjAUasysqXF9UmwHypvG9GTGx0BwAaWRi8894eDSqzEtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D37FU1jK; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45df0cde41bso37169055e9.3
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 04:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758626356; x=1759231156; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9vLuVuYkRxMOaPm/QX7PGxaAYbQhLbxbW+ekIalkme8=;
        b=D37FU1jKSGczue9Dgn4zjh9Q/9VOAh+Yxhv0mQl+5nKSGCDiXZGY3pGN4lWAI7UK+K
         Sr3m8eynRP4a1FkciFF9zEdU7/0a/CSr/F/zJXyewRCuD+KRCdsshMRGIbppC1JiklEU
         i7gokirPy7078/H9d1e8jgklpRF3/NWc2xfPDSMUAT3kQzMpnQAiMPR59f1BS11i2EFW
         L2xv5ldWrCMIdDNTg6lFyBIc/HcTjXomjswdeA0ENkpgQmwCyF6nNq2RUDaxXa/Z7ntJ
         i7qeX4ioCj5dFUh6oPzktQjEn+3HFg+DoAdoqewsIrGAuCWKqUMb0lSkZIfQV92btOo3
         h+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758626356; x=1759231156;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9vLuVuYkRxMOaPm/QX7PGxaAYbQhLbxbW+ekIalkme8=;
        b=TM62H4Bv6YNmeAtZV73AxJuz1+nuitzIXBGkYK44f/348uZ/9guxlw4+M0wlcfndf+
         8V55G1VVgVJ0eategCN1/4bA8LWjb7+MOW6HS39YX9+PUbsFo+tNa/cPCTf8pFvN601n
         gVbcOeK2s5ClkoA8K9aZ/qseTftNzkukhZl3heNAlgUzEIg0Xh/0UVQPu0SXv+mkPOHn
         N7Y9wgzv5q3FuV1NZ9n7WJapaiHe17hwNRfq8xhg5wRCVMKtru3DXdtWpRQvY9e6smN5
         qSlflM38kRqcFdny2wTwzDf5MXMBjJQSaaqkCWT7twAMxcRqkoKpE0b1wNK2SjajmcUW
         wsyg==
X-Forwarded-Encrypted: i=1; AJvYcCW/JtXwGmhhyWtntacXStfngawE1eTA6eMb5T/stXECd+zajjVPmyBt99+0WDEZcK4FAQBz6lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaYT366W9FCwEQ8groFsx30sFcwm19WyAxlwS04FjpZxgwoVU+
	7DQHhIbwQ0gr5FNQqRn6wZbkFT40ER9tYQV/00mBXYMQZbLfDul9RXeDPI5tD8cE9F0=
X-Gm-Gg: ASbGncve6493HKvQLlaINT/3+n8T4l7Q9dTrtBwKd/btibCqTFL6kkKzenm3fjjNMtr
	NG9OIg/Q3X6BJ5cYKMGeVuKjfylj1Pg9ehtLL3/+Num8NAXSvJ/Ev9jhWKmDmcwFhIAVFekf63f
	ZKm8AKIkRaU3PoEATaR94nMVYfCQhGZdw/y5DCU9iiWFC4/exNv37XAnfdJGm+LZJgH7GSBpgJs
	P/V4Q58NOZx2g3jyEeS9sGZkhi5Ss15ewYr+Gt0wEdCoCsixnjE5nXP6qWcoosrvYfToKSsomkd
	niDs3ydv7gF8nSy7Vdj3tHMAG1qJip333hbQ6VP1osTw0jm47GDHOY4tz53fsCKDYw58NOebDgj
	2EqP9gN+UfzaRMSAoywDyppBiK4AW
X-Google-Smtp-Source: AGHT+IESbMFQk6ILiLYUPMLicqqy9m7l+w2rx4L3CO/8J2ovvY0DfEOMfixD2agK3xBqmlyogy/9iQ==
X-Received: by 2002:a05:6000:25c1:b0:3ee:15b4:846c with SMTP id ffacd0b85a97d-405c5ccd2bdmr1761131f8f.28.1758626355940;
        Tue, 23 Sep 2025 04:19:15 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ee073f53c4sm24050430f8f.3.2025.09.23.04.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 04:19:15 -0700 (PDT)
Date: Tue, 23 Sep 2025 14:19:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net] octeontx2-pf: Fix potential use after free in
 otx2_tc_add_flow()
Message-ID: <aNKCL1jKwK8GRJHh@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code calls kfree_rcu(new_node, rcu) and then dereferences "new_node"
and then dereferences it on the next line.  Two lines later, we take
a mutex so I don't think this is an RCU safe region.  Re-order it to do
the dereferences before queuing up the free.

Fixes: 68fbff68dbea ("octeontx2-pf: Add police action for TC flower")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 5f80b23c5335..26a08d2cfbb1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -1326,7 +1326,6 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
 
 free_leaf:
 	otx2_tc_del_from_flow_list(flow_cfg, new_node);
-	kfree_rcu(new_node, rcu);
 	if (new_node->is_act_police) {
 		mutex_lock(&nic->mbox.lock);
 
@@ -1346,6 +1345,7 @@ static int otx2_tc_add_flow(struct otx2_nic *nic,
 
 		mutex_unlock(&nic->mbox.lock);
 	}
+	kfree_rcu(new_node, rcu);
 
 	return rc;
 }
-- 
2.51.0


