Return-Path: <netdev+bounces-178340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3DCA76AA9
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 17:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B579162FDB
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 15:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A406E21C9E8;
	Mon, 31 Mar 2025 15:06:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF1721C16D
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743433573; cv=none; b=OZ1TSm/aTPqjVtkBMod7mdJuMVJGT/dwlC3eAs6bdNYEg03N4Q7Cw49nuhP9dXyV/1Blt0a9+mQEoiZWvP2RKoNDZx8jRMVFBcU6KyYFBmG0MSiUj4MJY34xVZN1H8zwQDQxwRmjDVBVMueas4b2EdwqZ6D3h77DMtxoJco/M+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743433573; c=relaxed/simple;
	bh=eNFrVMso47nrlptvov1JsM27k2P05I4jI8+P3NDvlcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKKJCkHlbkB2hNF9Ii1CAlgSXfQYLcCJ14RJcQkNxj1rYeU1k4VfCVlUfmTXcqzGI8NWT2SmwF2PdtujmvKRRZUOUbZK/9GCI/lV7OzKC+2D/pVnoFQN9mY+L17oAXaFwDwNGF4YExmtawu6xbELWpPtCoT6XW10VQkopXYi7yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22622ddcc35so7226225ad.2
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 08:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743433571; x=1744038371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPCijyayYYncgRUFHK4PxErg6SbhrLYGSHYZMfQcqzA=;
        b=CPf0wQj7WOB3/xT4V42he6kqrQrTma6U194AtXxCk8kO67PaHbcgE1FFGFz33al/QR
         rqcVE0yluHbIYj/ptHqBCXfX9ZK/KCv4hCbBHxf1BVGwViUHloNG36TfX8DHVKbBxpQO
         EK4U7I+6q/vcDlweaGnBwbXSBiBnYxZSYqNRJ9AbJGtgyjU//8A0in1784+3tOn5DhA9
         CU9rFWDZ/u8vzM7QzJcbhyy7kl1vj408KYPgnmZ/akV20U2xUfPg3LojWHsWr2qN0tYZ
         yngvIkIiHt1zDNpR+Gqs2UDJSkT22LEKRGcNbmcGxYUqCOxBNm9IycuZFOKPuGpoh7WP
         g83A==
X-Gm-Message-State: AOJu0Ywp98MM7l8kyr5z4EjJQBg9JFPPXpbYPUm3mjlO5apdW+E7gGuq
	9nPsLdVGXwdp5ANFxpb+a22nReVls20B7zncc8DnvtqE/OBEz9TAznd8
X-Gm-Gg: ASbGncssc5gH5Wtm3YFoZkipTazKEoArz6zztJDW8lSuBs/98e0N6RA02RN6i2ZV+Xj
	RsLn3LrQWVhLM8z1E8iIun6VyWBy14ILWe3dAomwyX66TnHSUXWMojGl917m1PIMFxRvHglkfVD
	/7RPv22YYryIE/Mtc7lOQj9z44SW9wU865HcpzbtYQVMs9pprDyvc4brq1K/WeE0TjfIFxlD6+M
	T/yi+LPikU35auu23nV5OUhOR945Ajl5ehuEMU5o/bxWLBGOJIINF2cZL3ZENwlhLotJvz5oAdd
	ddtJbu/rWNt76jIneqrpqKcmHpdGDvRFcJTUH6rqLMyLaF6vxbKLXg0=
X-Google-Smtp-Source: AGHT+IG4kprbBmnR3LN7fEXpy5tuf3kiKpYY/TvlUBXnjrVnJ8tUYIBRzt7QDavibfRZUoUWbsJqBA==
X-Received: by 2002:a17:903:120c:b0:220:cd9a:a167 with SMTP id d9443c01a7336-2292f942c16mr155629985ad.4.1743433571058;
        Mon, 31 Mar 2025 08:06:11 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291f1faffasm70204595ad.244.2025.03.31.08.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 08:06:10 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v4 04/11] net: rename rtnl_net_debug to lock_debug
Date: Mon, 31 Mar 2025 08:05:56 -0700
Message-ID: <20250331150603.1906635-5-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331150603.1906635-1-sdf@fomichev.me>
References: <20250331150603.1906635-1-sdf@fomichev.me>
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


