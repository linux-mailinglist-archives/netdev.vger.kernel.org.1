Return-Path: <netdev+bounces-133148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8599951A8
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520891C25524
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD191E2013;
	Tue,  8 Oct 2024 14:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHIpOFxQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33D81DFD80;
	Tue,  8 Oct 2024 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397517; cv=none; b=tqQO3eFz86H7f4cU59CQf7wZTk+DVDD0V6VpvoZzaVe3Mx0hBj7odPwpeKxvbi1oS3dI0+JI5NZHYhemfUxirQsgovX4zvCkNWzhoOHpHqoS9fScZLhP8u/GXkAzI7A2hMPpNu0gzvliKUQHebY0kwgSDINuWJl4DQ3V/ztNGRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397517; c=relaxed/simple;
	bh=R8vmG0u3lFl9fsXKHPJv8VqmdcKKDyrNnQXHw0Dmp2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RE1HdbT+PQHkd5bV+G0/oJiAbVzDaEbuKrymri2BQA/Mj8iiszTCvnlwFDFFEwRxuXtjmM2SMkhe4JeXaFwoOKQ/RmVKwJjxNd70XlPrjXoNCaAHzgnm/Jm3ovStQLUsYk8aTMr7IRtUp7A/zPwY7S2IUUTs6gL7tqUp66CyRW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHIpOFxQ; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-20b6c311f62so50406525ad.0;
        Tue, 08 Oct 2024 07:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728397515; x=1729002315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KyNsEi0JeRXi6J1a9d2wdU47n7lnZVibMGfNyAtDMsk=;
        b=EHIpOFxQ3aGXj+cPIGvdM6gx5kzLCHzB0pkML0gahVxKLi2b4PXNZFIj0YnfuUpXuw
         P7hoCManbsOYUmasE0rQ7FbZl6VCxV6/8fzBBvDQWN1oWVqtECyz0lq/L906leDxEDWb
         g3Qi9Lfoe1qUGJX9QKBPjQX3Xh256e2CxF//E/WKHStSlKHtYSW6q11pLmLM3uBszjWk
         dEIpSD1KiFHC0QuX3hhdTK2Ew9y4ECWLTEtw9yTLLY4zUWQM25m5Wp+VoGoz02LhwgNu
         xqwtFVGRhE4/qH6FHRpBNqOCvJEXfZvfrEHppwsrRPphC7S86nMKXtI3mbd0nfh0kQIr
         ldOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728397515; x=1729002315;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KyNsEi0JeRXi6J1a9d2wdU47n7lnZVibMGfNyAtDMsk=;
        b=qNikPJXBfQAfTFKl2RvsbHwLXo6fWLWbn9YH63/ROo7bG6YB7iBiqyN3sz9uKbV0wm
         M0umH+uduDB6uxzPCyU2f8OT3MB1S8ItEKMIeYPOHq8oZRyuObUl2cKpTEcHHpOE80nZ
         RTvSs1t9RA7wRynOkBGfbvJWLAfYtfi269DWwXGrd5JmtbMCs1EKpcnmqxaZY1w3l4xk
         3a5GXbPjQISAppdIT50Jtj7+swct6hy5bxNl/XyB5pPus1womkADVDB/8+THJntOJr8f
         VosOi1iouZ/KTrqhaLzYB8rXKz+SgnkVMjKLhHi8cuK/1YeZ5mnLvVa+MlqtDAFoAFBR
         tDUg==
X-Forwarded-Encrypted: i=1; AJvYcCWKRgFd3QxU76VEE9z3qVvxlbtXKgEQGORMlai0vc7C0FRMY806af9VLFPvvi3KVxoPDkebEUHyG8TzT+s=@vger.kernel.org, AJvYcCWd8Qkh7oWfsda47FioIvZYEQbM9aGXJ+1DOBJekMTqV4fHeXxIdzmTMVgr3NtqyXLL5tThy+D1@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4LUTVdRAqkY14WHYedf8AXe+xu9sjtAmE7Gh9pV8dKgw2/h8w
	M2idkBuLHL5lDabKIE2ZCKYy9sJxuVhk1uUAFf+W3ZNtGZgE5RC/
X-Google-Smtp-Source: AGHT+IESTTBBft0mh5cCnBDcux0lVuyKjXuLuoYYeQ7sEweGaRbw6DoOZADQbnff7G6AV4W3htpsMQ==
X-Received: by 2002:a17:902:cecc:b0:207:c38:9fd7 with SMTP id d9443c01a7336-20bfe290ebamr179165615ad.22.1728397515099;
        Tue, 08 Oct 2024 07:25:15 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20b0f68a8sm7675987a91.36.2024.10.08.07.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:25:14 -0700 (PDT)
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
	netdev@vger.kernel.org,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next v6 12/12] net: vxlan: use kfree_skb_reason() in encap_bypass_if_local()
Date: Tue,  8 Oct 2024 22:23:00 +0800
Message-Id: <20241008142300.236781-13-dongml2@chinatelecom.cn>
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

Replace kfree_skb() with kfree_skb_reason() in encap_bypass_if_local, and
no new skb drop reason is added in this commit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/net/vxlan/vxlan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index da4de19d0331..f7e94bb8e30e 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2341,7 +2341,7 @@ static int encap_bypass_if_local(struct sk_buff *skb, struct net_device *dev,
 			DEV_STATS_INC(dev, tx_errors);
 			vxlan_vnifilter_count(vxlan, vni, NULL,
 					      VXLAN_VNI_STATS_TX_ERRORS, 0);
-			kfree_skb(skb);
+			kfree_skb_reason(skb, SKB_DROP_REASON_VXLAN_INVALID_HDR);
 
 			return -ENOENT;
 		}
-- 
2.39.5


