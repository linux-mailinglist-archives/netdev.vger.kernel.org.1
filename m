Return-Path: <netdev+bounces-178655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F2CA7808D
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 18:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 296AB7A43E0
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 16:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B2520E6ED;
	Tue,  1 Apr 2025 16:35:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0F520D4F7
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743525305; cv=none; b=r3dYB0fOYqMFH22DBjqzp5z0b4gq6H8QGOlzNzQpFDT6W1S9jW0vK5ctwyXBLc6aLiuKPoftBCfwOpfTLFirPCQ9pBs5EnOelCRd+qRDRuuGUKaf/Ysp8nqKHZBIu84ad/FPdhfvxhmsdFKFuSw6BZMWFcYBHwATOepIGShNrnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743525305; c=relaxed/simple;
	bh=vZn7yO2iCnAMEvEz7u+7h64+lzs6SGdVKJy6rnV3No4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2FlwWdkYn33xT1cwzBJPCP/+hybAb5H5JAu7C1m0XA7lMJtKs1gQOjFVehKRXKG2kNdqjO5O/P4MsJu/W95qp2x+uxfvbPwX+iOU0HCFRe3HDyoWeIobyxYlbDCoYgZ3h5QtoJ4oJC9c3gR1bE7ae+wloLPD0NW6qxRsELG/3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2260c91576aso92327915ad.3
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 09:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743525303; x=1744130103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mkASRlWWPss/UGLbr7z0MSMnXM0Kc2QVcSHO644ngfQ=;
        b=LfDnErgMQPo++M/7cTSu4hQrPSxA4fwsnC+qQvQJg9pVqBalR6ZsdtgM82NNKRSwRY
         tgRUIY3Xci0/irC6RO3QzALEcNWnmMcq4Qj9BHf+3WI9R/i/qWqB8L4088hsgB6yW22J
         Amwvm7KQ84fKZCYscPzHmAkl5icrXyHUGqvUJJIvkGVDJBavw4qwAzKS0vNZKFsZ3lbL
         qPJmrtzIe6fUxu1YJvZLsbAcCIJnqpuysHOsiFtllzGxMJUKNEqTVNT7fdsnRPwZquiq
         YeuBCgiL9XQQlL2Cyodx/6YgLv+BquQJoNEhf3+gEvy5U5YhrnTjsgfZ4wwe4+FkeFuB
         GyMQ==
X-Gm-Message-State: AOJu0Yxk8RwzsO0Fm/qgQRGsPbObc+xIIaHtsbhhzZ52Uj8CbIflTVdC
	j3cZxqBcENH8+o1wC+oaq6h92jGpvst7RP2e1KHL9XqkoD/IU3pSJ1FyamK9Qw==
X-Gm-Gg: ASbGncuhSlv7pPOVWtFeF+MzXeDmFx6Ad8OS+NNit085r07J5p+9YdkwFVG+HUHHWHP
	GX57awZ+OtaC3CknugnlBKb4HkzHeiXK+jie403dfdWPrHipjWJXEVkDjr5zNPVoF64f+Pn6z+W
	m0u5pSiQ1p2Y1XJaelSORYZ0zoBtN2lU18BxHqne2SH8L4POJ3obrisgFBARnh4y611lv7aABT8
	BeZzYe+aBx9xaaSOvimmBfuU97HcFUAeiR/XpwA5JP6x2lD5rL/MolylwKUJLvQX9B+kpleujBa
	9/XwhxtAmD7G60bGoRgAM7+hkY4o9i03ikFIm+5gp0Bt
X-Google-Smtp-Source: AGHT+IH7J7wiRIEToxRj4jgL8qJPqEQjqFLcG+qPId7lOhSKlEHcA255N4J3SPQv+ZIjTMabv+mxnA==
X-Received: by 2002:a05:6a00:3288:b0:736:57cb:f2b6 with SMTP id d2e1a72fcca58-739803aa740mr23163487b3a.12.1743525302598;
        Tue, 01 Apr 2025 09:35:02 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73970e2aed9sm9130010b3a.72.2025.04.01.09.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 09:35:02 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v5 06/11] net: dummy: request ops lock
Date: Tue,  1 Apr 2025 09:34:47 -0700
Message-ID: <20250401163452.622454-7-sdf@fomichev.me>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250401163452.622454-1-sdf@fomichev.me>
References: <20250401163452.622454-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even though dummy device doesn't really need an instance lock,
a lot of selftests use dummy so it's useful to have extra
expose to the instance lock on NIPA. Request the instance/ops
locking.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/dummy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
index a4938c6a5ebb..d6bdad4baadd 100644
--- a/drivers/net/dummy.c
+++ b/drivers/net/dummy.c
@@ -105,6 +105,7 @@ static void dummy_setup(struct net_device *dev)
 	dev->netdev_ops = &dummy_netdev_ops;
 	dev->ethtool_ops = &dummy_ethtool_ops;
 	dev->needs_free_netdev = true;
+	dev->request_ops_lock = true;
 
 	/* Fill in device structure with ethernet-generic values. */
 	dev->flags |= IFF_NOARP;
-- 
2.49.0


