Return-Path: <netdev+bounces-133146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED869951A3
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEB381F25F1B
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522831E1A33;
	Tue,  8 Oct 2024 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuNUyjhd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E278B1E1A2C;
	Tue,  8 Oct 2024 14:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397504; cv=none; b=pjdQFDmy2iFejYRJSPDwzhGzMijsfRqZuxGEHwycF9LI3Co/CMsSgumYifD2mZG1qRTHAHrsJKx/ndRmGpKoQuoj++li2RurKcrRZ22QPVMQrPgnW++2ByNJS6/+eWGYgBp7xc4e1pD7RIClnNZE0qDmOWqDkQAvTSKguHEzuhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397504; c=relaxed/simple;
	bh=YBE7Gm/eB2TlKhxoUuPSI1O81VwH7aGArvM+el/K8oQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EnVflzCJx85unjBTTU1TZApwxeB549FFdXSUbb56dgRDRYaXn76xTHiwfKRSmZNTkFPDizD3Znz3JI/ldohG/Rtsu2caC0OnlihPrzlpoWAFs9amVzYtAxDDpS6nQq9k2v79hLuu9uyzYff75zFkMeBTeb8zfubNVw2x5pb0S1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuNUyjhd; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-7d916b6a73aso3483949a12.1;
        Tue, 08 Oct 2024 07:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728397502; x=1729002302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUrRZI6iM2TdSh5ZMNy/fS83zTOTT53JwP3p/9CnIm0=;
        b=iuNUyjhd+uUWLQVYV2XWn6PIgvvJBFH3KF01+GtbzOkKh75J09MN3Dac6LaqXtLAn8
         7yEhLFvIDpgTAnIFeGo3ZkUAhHMPbbIFA9034aCr7Ua5IHAA/px19y/vE2gZRqbQnABx
         rSSq4SVlHJo01ONVYJqzOpn5dICk0KiIluur4kkLRb2Gyk1oLoeLE6xNZtuAWnCOU32u
         foHYCV59Zb4Ny1LeVw3AcHKQC1nQbMRzppPACsomSR+zN2RUvaQoM3xH0VzArxU9DN/p
         ATH3uhzz1LWLDVxsjH3jI07YzplPkekMwkjBDkiXFO4zKQpr2ytrKXEMlYXWQt96qAsl
         ALyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728397502; x=1729002302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUrRZI6iM2TdSh5ZMNy/fS83zTOTT53JwP3p/9CnIm0=;
        b=Kxlqw0vmk3BshLOP+HhBqaqUWJ5s3xjG42DmvnqJr4pLf3k3JbPS9XS06idNlwCF7v
         wKd8odOxc23Fvl5qGTXf4gGVG3gxOvniPM20cy63V1zsPsum6iZbHMQvp8GCcalz9DPn
         XgHC/EGGbxavuxvfBIcFGxYGt54jBWr3PzfpQmqt3Pc9YnECWBszqv+q+ICIPuY2uoYN
         J5CbMs50iEKCsC2LeLpb5Q7Bu3SscArUfLmHIhzmP5yZdKySscan1OfY1HpqeQC5M4qJ
         HUc4tFflJE9pSuO9Gn938uwF84Pm9MlPAO+N0DhmKBih4VJ5tixYtbYRCBIiOVZ4xVxM
         t4AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtwd4hed7VlhgbwOJcSNePCmzKCUkkScygIfD2wSR3hj+tM5U0pVkMDGSl//jqX6odo9DIVP6n@vger.kernel.org, AJvYcCXROLxu31AMgq+ue8E6pzyz83o4xNgadbRXBIKM2MJdIlmr/UTh5VmXkeBOSuaV7knEyG8VGUCcK2zKasY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQHU70o5TBN//lYRKJ9MXjZaIoLoAfDyLKK375DY2cXwRj4y2+
	vm7GOpHt6UKOTwV4NEVNcpuVdskrildrKnJS22x0yFPmxlqRbO5A
X-Google-Smtp-Source: AGHT+IF7NEh6HwPJYwURl4Q03W7pTHQxSa7wxGdDQbLq67dvWX4otHkw1OSCc05u5+zH0PxNx2ta5g==
X-Received: by 2002:a17:90a:de8c:b0:2cc:ff56:5be1 with SMTP id 98e67ed59e1d1-2e1e6211be0mr17855559a91.7.1728397502220;
        Tue, 08 Oct 2024 07:25:02 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20b0f68a8sm7675987a91.36.2024.10.08.07.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:25:01 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org,
	aleksander.lobakin@intel.com,
	horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	dongml2@chinatelecom.cn,
	amcohen@nvidia.com,
	gnault@redhat.com,
	bpoirier@nvidia.com,
	b.galvani@gmail.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v6 10/12] net: vxlan: use kfree_skb_reason() in vxlan_mdb_xmit()
Date: Tue,  8 Oct 2024 22:22:58 +0800
Message-Id: <20241008142300.236781-11-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241008142300.236781-1-dongml2@chinatelecom.cn>
References: <20241008142300.236781-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kfree_skb() with kfree_skb_reason() in vxlan_mdb_xmit. No drop
reasons are introduced in this commit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/vxlan/vxlan_mdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index 60eb95a06d55..e1173ae13428 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -1712,7 +1712,7 @@ netdev_tx_t vxlan_mdb_xmit(struct vxlan_dev *vxlan,
 		vxlan_xmit_one(skb, vxlan->dev, src_vni,
 			       rcu_dereference(fremote->rd), false);
 	else
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_VXLAN_NO_REMOTE);
 
 	return NETDEV_TX_OK;
 }
-- 
2.39.5


