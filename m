Return-Path: <netdev+bounces-177961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FD5A733AF
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 14:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B9917BF13
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 13:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00591217737;
	Thu, 27 Mar 2025 13:57:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C4C217668
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 13:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743083832; cv=none; b=RxuBIjZqMMdrEpt/D0kjyopUSrdbsvnrEFAYi7IuOf2KKmwRemGVGNNm1REu0dxG2DLFEow/af20H10FJy+hgk2t23iaijf1ZHcCCNu1OgnlLmfz330buz+Wi0QY1ync/1XuGKSdtgkkXLeJbJTsv/UkYQEkFQaWHKFC+BCzqUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743083832; c=relaxed/simple;
	bh=No/0VfPK7pHniKtbbaQJ0cyWQL9HoLVC3b3WbWBLe4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bKIyR54dPiXKqXkGPTMI7vszbQs6c7y09Nzxta1acqHx4xGzUBrkawVyvabKlKo/6TtMRUMHEF2Rct3GK2dV9Bho6rhqbgwdM7r+HdnaEVK2Jbh0eyhUK0q2e+NMjnTkO00MnVdE4nJ3JmwM5+bnd9oZQODMOsLbzyEtyKypG5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2240b4de12bso28235395ad.2
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 06:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743083830; x=1743688630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOUxfu91P1ktbOKHx7UEPpGlhg2bkdrt6E9z1Gl/UMk=;
        b=SDd9j1gP6KQe/oR4HDrqJOWNHthAbmpo2iAF6qyHStgIthNzhlzl5plVYd6Bnl9Az7
         8QEpfXYWGgjNiMOKMowOfunbzL6vbmPUEF+gR7yNgUt6N/Sk0PpT780r8Y/K4ayHqHqv
         eobVgC35d5Jr53DvGiBAdd4hx/TOMwdsEJAgj+ctfy1wPe/J+UCtOni0+uDn+PI7IgaS
         Xqwjegdw9QU6dBtnMf/Ll8b93wHACACaQSuryPWbl1JleYF3F/B/loIoXXW2IpFATNe3
         U651ob6AiLj9eWYZb3rXCNIpq+O630s3XnLDdowQBE93g2sowyctQT5MfQVYFunyykMx
         /OLg==
X-Gm-Message-State: AOJu0YxiF69bKFMqFdQGolHRMM5zhxYtqTRu+I5XqQaszDuyxpRdB7ex
	N5qAfq+WA8gH8s4pPl4x2Pf4ZRgQc/wFB6tdtgwW5hKyIRM3yfY0AlnbbuPvpA==
X-Gm-Gg: ASbGncvIGos5YcR7amPPlUgx5Stfpv6jTv8y8Fk42GNlFvcLVu0DxO6CurWt8WRLylj
	2BQPBJ8xtolZz5piDnJ/0Wy6QkMstNiI4S2zjbYfxt5K54ijxAxwVGUr2iCmdYeFmvPVvEKIe+1
	YWHAJbTDj+GBZydN29Lm5QqTvejVfMDGFFGOtNAE7cVtonTA7MNtvv7eBLnQ+ayMEYu1O2MN8wr
	zp4bPiQoAw04/knabid98vMbKDs4Log4GigofFtNG0NTK8M5X8fvVB/oxJYSME3MRY9A9Msc7wK
	YSZrcIQAgPIRhWeAVgorFjAVWRIq3XGXLz6JbrEIcpC1
X-Google-Smtp-Source: AGHT+IFhaZ5omOvrymxczUb2jY7DRa8o2W1EmyQ75/nAyCPU9ZXj47wTKGPIpOgHFSbI+3eC+d3DAg==
X-Received: by 2002:a17:903:2acb:b0:216:2bd7:1c4a with SMTP id d9443c01a7336-22804877939mr58510925ad.26.1743083830392;
        Thu, 27 Mar 2025 06:57:10 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-227811dcd47sm128490395ad.178.2025.03.27.06.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 06:57:10 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v2 07/11] net: dummy: request ops lock
Date: Thu, 27 Mar 2025 06:56:55 -0700
Message-ID: <20250327135659.2057487-8-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250327135659.2057487-1-sdf@fomichev.me>
References: <20250327135659.2057487-1-sdf@fomichev.me>
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
2.48.1


