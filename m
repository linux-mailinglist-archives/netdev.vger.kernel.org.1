Return-Path: <netdev+bounces-178201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B49A75787
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 19:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22BE53AA951
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 18:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53EF1DE3DC;
	Sat, 29 Mar 2025 18:57:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DB01EA73
	for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 18:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743274634; cv=none; b=DAFaPehWL5+gMNZtG8vEBdSYxQQ5Urz7cJNYCs4K1YmgFX+XAoUbKp1rWW3mTEi7gXIVt4qALlJ942gAiglnpo2fMuFukTNVmAp15ZtVsxYuhHGttJo5Mk7q3QtU93sgEV4yxr3W30hGLOC7cjHHvcctq6aMjYdVbviAdMZKU2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743274634; c=relaxed/simple;
	bh=eNFrVMso47nrlptvov1JsM27k2P05I4jI8+P3NDvlcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uO/DRlE9CSKQfjVrCS6hQ5aAsvXcikt9/xkblN3m2RnCmsvWkPH6fti5mtyzzSTMtNNgF20+hXbVt/gIlMcgjG6ZTlaTOwREMCxWjgPKvw3C+BksqpXHHvdsmO+ITIwDEQFI/9eISaFvVEmALH6xQxAAzcKXzm2whf8WMQGO00I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-223a7065ff8so35899155ad.0
        for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 11:57:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743274632; x=1743879432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPCijyayYYncgRUFHK4PxErg6SbhrLYGSHYZMfQcqzA=;
        b=rePUXIc7r8FMgrbiXloPXrnU4rBrkOyBL1FxX9Z71PzC2okLOlbREanW/i+dPPw+f9
         MFw9E/ZWJBjURo0QP76zAG9xBXzq+hesRz+cKS+27mbYlpOolAm4keLIzCNct9AlKzi0
         bkLwTKJiLEknuMFoNXlbKtg6HlzeyDP8jimlSNJujlDP/7EvjbWoXmIsGPOZ+uWAoelQ
         ss5zHXfYzVCtGDC8Yj3FwBTAyzmfsA1RprNafoCuYxKQO1Y8V6BKU48sdsqvD97qybWM
         RikOiG+1WoHsl/dO+hQnXNiMws4d/DA//VhhQ0KUB6H+yVO3jS9MT6s+tjPL2VCL34tA
         p0OA==
X-Gm-Message-State: AOJu0Yz+FDg2MD7pT4yO90H+S8DXB/FRf0S21IS7HJeMC24CkE7ggtdp
	yVraBUFuqbMFLGvJe8LbIHxn8uUySvwfa/j0BmNjcERR7yCm3vNN9NNeny0=
X-Gm-Gg: ASbGncsoVPDpKNBE7AYsZ0846l2jsi2MHjDtXWqH9UclfixDuMfHmopMlaunq7+FIcg
	SMQv/u4ZFcShFvtMu9cDnuwjTk3a6I1N9sTvfT/Ui40LcB86IFVbclEm3524F1FgHyJfIZ3640e
	LLZeaxMsW+kRRfGelKhE+HChN5cuokPX46Vffno3/YkcMDPdZotoLfURuaGjf76IUc7CZb6BjOg
	hT/hHuE84qUBFtmrxZYv86QplVWFCw8V9Xe5WCQWETC+PWcL7/5UUpi+7+jLLjPI5kvcdVSxVle
	w4wDLibAtlcqi5zbuCN3f7lk7v3oZNz2SWWQxxzfn7pm
X-Google-Smtp-Source: AGHT+IFEZK1fj8HKougtb0K62UZyHT07ffX9PVu5nwTrBYgnb4vzVufJApNSgMGeL7S02bJ7/RBl5w==
X-Received: by 2002:a17:902:c408:b0:220:cb6c:2e30 with SMTP id d9443c01a7336-2292fa010cemr64008515ad.49.1743274632169;
        Sat, 29 Mar 2025 11:57:12 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73970deed76sm4046687b3a.11.2025.03.29.11.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 11:57:11 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v3 04/11] net: rename rtnl_net_debug to lock_debug
Date: Sat, 29 Mar 2025 11:56:57 -0700
Message-ID: <20250329185704.676589-5-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250329185704.676589-1-sdf@fomichev.me>
References: <20250329185704.676589-1-sdf@fomichev.me>
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
2.48.1


