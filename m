Return-Path: <netdev+bounces-168650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22756A4001D
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 20:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA09319E1350
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 19:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFA4253B43;
	Fri, 21 Feb 2025 19:56:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7F6253F35
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 19:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740167781; cv=none; b=AYIZNmQ3/PPdLk8boVesur7lgMsW53vkh0qUuAlGKmgaGFbMspQGjbIzQOBqZhpKBsOK1TLrBv1ELVo7qEaLQFAycpX22Yls/3aWioGfEZf112V7+9M7pRDu33ZH+slU/kre0x4SK4Fr3StzhTYJSdcegcJAZpbqqXkqww4Lc5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740167781; c=relaxed/simple;
	bh=BYyQ4Or5SPWQ4XHDszO3E8l63WKEL0GHs67EpNVfXtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6z3th/YA29iagO0v//sIqq/6uI1zgKlZlo61ISSMTev2yrIQPYoLWNrXFBNfAeHrdKP6jRIJCubvewbeWIu/ET3J7UCLEte8yy2HqxMhIMNk8jIyRrlAvynNN4umuGRxkhNNk5wdBSZgL1cEYS0hbYDc/Pw/UMkV+qugYHu7Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-220c2a87378so44688965ad.1
        for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 11:56:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740167778; x=1740772578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4NOp35sSOYqm+YHVCOvaTH4M4VfB98cdG0m5h35A4k=;
        b=uGuXsU8fAkhvC1wqRx+hWBpsWf3iMGZ4ZHPjY6RgffhZe1Q4TRvwSWdB5P724wa4bu
         11kusLOZUmpMQXhAnDXOHJ24vOtT3vhJ5I4WPNU1IaBBu3P499vTXEF1kpoDYUYWgEYy
         FA0SPIukUJi6beQ38u0+u3AWwYw9nWhYtY8IEQm9Nk5w01NonlZWTvcVqbecpPLcojQj
         ErmJIPnff52bfXBK5q0w9E5PRitse4GnPwjGMhbYNzYT/sdcg0PyKhepd4BxScE8VP2s
         2BvcQcT+zHMvBIChMDDlnK0VyJR9Bghbemo/lMtonwzVhVuslTnBJdxBDbK3UBQfKLfi
         8zcQ==
X-Gm-Message-State: AOJu0YwdQqkKXQIwDzBHesdVvhmY53ssnwGgtSUPA8cyO1rmt1lkAviC
	l4+dqIbLufG2L0H9gchF7TvoD4fdF9YR16mnf0pJ2C/PCUrC4/fkFAVr
X-Gm-Gg: ASbGncvsWHrfPoWMRuDqyoygwCJZ96eHzP8jBb+xDaFPIxzOhobFgJdV9T9IXET8Odq
	JSn8+GZJvTe6yrLI7li3iJlUY+27N1UrXe0kB0rELdFc80yPC89Jg3tmt3z6RruSjqlxY44ADzX
	7px/kJy8Tpzl2vnYBjoaC5s+gk3DHNsMfaSEDFfOfvXM8Hf+FhswCkiT7Mckc4uhWzw6h94mQtd
	UeHOzrehgzKbhiyBGQfum4N2lR5sWm1YntGGbkX0rAWi3Qb7hrTpx7f8+QptcdhgXoQtAIMO4p7
	W/OdzYkHmnzb0GEqdTNFmi74TQ==
X-Google-Smtp-Source: AGHT+IEvedsMjTyC/SZc+8rdDq15cAx/33jzqebOmPTnUSOnGpPvi2kAvQj27n7RRqEvwEyOKSt6lQ==
X-Received: by 2002:a05:6a00:2192:b0:730:75b1:721b with SMTP id d2e1a72fcca58-73426d7273bmr6504611b3a.18.1740167778116;
        Fri, 21 Feb 2025 11:56:18 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73242761538sm16573757b3a.139.2025.02.21.11.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 11:56:17 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Saeed Mahameed <saeed@kernel.org>
Subject: [PATCH net-next v6 10/12] net: add option to request netdev instance lock
Date: Fri, 21 Feb 2025 11:56:02 -0800
Message-ID: <20250221195604.2103132-11-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221195604.2103132-1-sdf@fomichev.me>
References: <20250221195604.2103132-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently only the drivers that implement shaper or queue APIs
are grabbing instance lock. Add an explicit opt-in for the
drivers that want to grab the lock without implementing the above
APIs.

There is a 3-byte hole after @up, use it:

        /* --- cacheline 47 boundary (3008 bytes) --- */
        u32                        napi_defer_hard_irqs; /*  3008     4 */
        bool                       up;                   /*  3012     1 */

        /* XXX 3 bytes hole, try to pack */

        struct mutex               lock;                 /*  3016   144 */

        /* XXX last struct has 1 hole */

Cc: Saeed Mahameed <saeed@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/linux/netdevice.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 57dff4cc5cee..b13d5da97f8c 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2456,6 +2456,12 @@ struct net_device {
 	 */
 	bool			up;
 
+	/**
+	 * @request_ops_lock: request the core to run all @netdev_ops and
+	 * @ethtool_ops under the @lock.
+	 */
+	bool			request_ops_lock;
+
 	/**
 	 * @lock: netdev-scope lock, protects a small selection of fields.
 	 * Should always be taken using netdev_lock() / netdev_unlock() helpers.
@@ -2743,7 +2749,7 @@ static inline void netdev_assert_locked_or_invisible(struct net_device *dev)
 
 static inline bool netdev_need_ops_lock(struct net_device *dev)
 {
-	bool ret = !!dev->queue_mgmt_ops;
+	bool ret = dev->request_ops_lock || !!dev->queue_mgmt_ops;
 
 #if IS_ENABLED(CONFIG_NET_SHAPER)
 	ret |= !!dev->netdev_ops->net_shaper_ops;
-- 
2.48.1


