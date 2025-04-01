Return-Path: <netdev+bounces-178653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E6FA78094
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 18:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EFC418887E8
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 16:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC2A20C476;
	Tue,  1 Apr 2025 16:35:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B64820D4F7
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743525302; cv=none; b=LHG7AZNugxpkchbBwJxYfohCW3hJdd8DQhll/+KCDmTr5v8eRDrXaLlJ7U1QwwJGABMykZTXU8PPHX9io4ICRZ87GzGGTvRkz6kiYtda5E9YOwfQ11WJnBW2WgtLr1ycBnjwE12ejB6tfrmtkNI+ddspbibewMKI0fafgJQwkc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743525302; c=relaxed/simple;
	bh=V52ogIerz3pWrsOVtz2HNfeJC3T1ZLd6RIDKy5JCA10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCWvP0TIS7ihjvHfLAhFhPb8H/oVZgBuvQAbiyHEVVzQjGCeQb5Vnx4rd63bYP9ZOwuzxRj1hQXxpNzpCr7uM1+yWgbjPaSBU4sIA9NpVXR8iGwdZkOrwRBPuCfE5vlI1ZzgavCal5UrBm+Y0TQ2qToYdi67l/HQBqe97GkUybQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22435603572so108880745ad.1
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 09:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743525300; x=1744130100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqW4GjRTu/v0EzDHaXQV7WFvqxG263JPBR8ADF6KpwE=;
        b=O8FRzwqw9F6IMs6qN7nLQ2J+p5+ELs/DdNBXPpePbhC2NCVqOufULIzd+Irj1APbIr
         nytZCXaiLh/SrV9gr82oRskreoLmyDlKIMQDQVLHrQcyVrA3l2W20CPSXH2u3Y553bZz
         V2Wu5r1iLjw0jKjWbiZ2N3zNiVXXa6EUSEBx+OhuQr3DTZi2QTxtfZ+eJ+I6ess4CPbw
         44WXE2lXkBGeAd6Xx41f8OpyIjP0OzXdESOEB2NWlzFHP7R9Xyg5IM24PM2zBus7ekqF
         rfPxhTvLZGYQR8nsl/1bzvsSNKZ1fOpXqTmPasSPPVw8ATlnkkEHONc6VXE1H+6VOh5l
         bcsQ==
X-Gm-Message-State: AOJu0Yww+JYH3Foq0b7Zbximxv9+YESUyMrwR3jS2KdQJ0C9Bvc4/RmI
	EROs6t+Vh5F5hyC2mgQL634cieiqNDvTqNCmhry7hKnNUya3/Uz+Az9YRueXOw==
X-Gm-Gg: ASbGnctJIB3A5NryV59zZT4HwuP3ru1j2it65qqbnBnu8/0h/WylEB4jN3PAgo9LCmZ
	A+pqCDGWi0VV7DLia519bRvSe8AsHzl4GJczBRqK3Ka+VMV7HZMfSBvMNnpmE2DjZaD1Hs4FIL7
	OiTDvWRFs95nUieZVulXijPddAQline7hq26hvqm/+dWcZxtADHDG19OOmV2DVM1yQ/Ea/Afxxs
	vtidtXG2WDJ5TFGczBxMLRB1y5V484ZaA/kv9CGrLvGguIZ5Ms2iUOPzP53OfjHxE955Q0uztr1
	z6Vm9ShM890QsiLLifgfRA5C4rJ4W/2+uiYjyszHle3H
X-Google-Smtp-Source: AGHT+IF4T6jmB2z2n9PHadBfxpjeLuK3A1AU8GVUIt9fw/PANgQSkHTea+AbaGmRTKn59laZq5DbGA==
X-Received: by 2002:a17:902:cece:b0:220:cb1a:da5 with SMTP id d9443c01a7336-2292f9f2ee6mr230756585ad.40.1743525299840;
        Tue, 01 Apr 2025 09:34:59 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291f1cde7bsm91060475ad.149.2025.04.01.09.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 09:34:59 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v5 04/11] net: rename rtnl_net_debug to lock_debug
Date: Tue,  1 Apr 2025 09:34:45 -0700
Message-ID: <20250401163452.622454-5-sdf@fomichev.me>
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

And make it selected by CONFIG_DEBUG_NET. Don't rename any of
the structs/functions. Next patch will use rtnl_net_debug_event in
netdevsim.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/core/Makefile                           | 2 +-
 net/core/{rtnl_net_debug.c => lock_debug.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename net/core/{rtnl_net_debug.c => lock_debug.c} (100%)

diff --git a/net/core/Makefile b/net/core/Makefile
index a10c3bd96798..b2a76ce33932 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -45,5 +45,5 @@ obj-$(CONFIG_BPF_SYSCALL) += bpf_sk_storage.o
 obj-$(CONFIG_OF)	+= of_net.o
 obj-$(CONFIG_NET_TEST) += net_test.o
 obj-$(CONFIG_NET_DEVMEM) += devmem.o
-obj-$(CONFIG_DEBUG_NET_SMALL_RTNL) += rtnl_net_debug.o
+obj-$(CONFIG_DEBUG_NET) += lock_debug.o
 obj-$(CONFIG_FAIL_SKB_REALLOC) += skb_fault_injection.o
diff --git a/net/core/rtnl_net_debug.c b/net/core/lock_debug.c
similarity index 100%
rename from net/core/rtnl_net_debug.c
rename to net/core/lock_debug.c
-- 
2.49.0


