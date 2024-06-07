Return-Path: <netdev+bounces-101976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874C3900DA0
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 23:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B6FA1C214F6
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 21:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694C8155739;
	Fri,  7 Jun 2024 21:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Z9DKg3SF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9A8155341
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 21:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717796480; cv=none; b=ba8Aayhrh0YCtUOf6YHjG0EReIR1loHm81GLLA0as2YElQSKsJlUnEN66C8k1IYjRYugADH51O+oYGtTANAeVKdynmtwUUXchmQpXEtxq00BpUGdmSEwk3M7pfeg+DkEn0/yKdC9bmOtjR0V6GU+DHF4G056mIJJPvFYoIc03g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717796480; c=relaxed/simple;
	bh=+zDHm0gqEYnNElTfpQqNXDS5sE+4HW2XfxQCpQQCbSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pyQHtQf02d7HCLiK9d7994oV2xRtwK1dOu5UMmT4AwVERee3vBEfBKeAIUVWkY2NRQ142MbLwCQrYICtx8cslcmOkObl1mNrg+j33WYymt1Zv837JVwbUGnKP/fiBKyw2LmZ5QZ6lgMwDAhlXlvTL4HFWCXc2Mx0BFMUGsRAHU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Z9DKg3SF; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f480624d10so24411005ad.1
        for <netdev@vger.kernel.org>; Fri, 07 Jun 2024 14:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1717796478; x=1718401278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6hr5Pgg5LYV8IvTkAUUqijfPi8ple/giWX7dtweBwU=;
        b=Z9DKg3SFZv5D/L1UQYIGoZFTmyjArQ+DavEzSWG/A77KkhIYYrzIKCXeChJFXL3HrI
         q0ocBiSI0p7j7VheYjrOKzdy91QRGaZSsGsZF+6Pa05N38HKd1k0NA6l+2MyX5ehLhhh
         uxYxtc/y64gC8zpMQUhC7YDDSQhWokBTiKfsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717796478; x=1718401278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6hr5Pgg5LYV8IvTkAUUqijfPi8ple/giWX7dtweBwU=;
        b=cdfgQuooeo9lFB1rZjfEFhQFAR4fyebn+BKjf5EV9KD2qhkWhtLiv603NPI+O1q+/N
         QoRWjzeGtYczSu8yufrHUJvly/qDjwekIGF5jZdUCp6YhzU73lLqMMRUKZJRbrCAzWi4
         xXX9F0yhWC0d7K8tWcuWgcrzJ+T7PTPannQpFOIX/kQT8IolMQEjYEXbZaA5siPVlXQ4
         5qPdlhmryEhpPhISqdyI1XB15HN46D1Dl7GlOcf1l3dnUK6t4NI+Ae0OAg8c/9LxgXuG
         S5n+cdpsCiO4Myy3QjDIEoBFI0CmOVQb8NIOP6PCeNo46m/ZGkG+W6A3f4JG13nZF7Jz
         GfvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaw1YFf513CZwP4xZWgW2uO4Uah3tPiaMX+jGoK0d42hMTylphTKE1M0u3Zi/f/+uWPUPIdvVJi3Exprf5l34CEDN+wRA0
X-Gm-Message-State: AOJu0YxxL5RlKo/5Gn9cF6CURjWDwMSNOAhR9KumW2Qw1yEmbJu7HQnK
	+tEpQLnNqew/WAzETVcyItV7x7+chF5yz4DW6iQPVaJE4gbl+uB58kjb+XsPVA==
X-Google-Smtp-Source: AGHT+IGiZCcvwDTTBj7Ig57bQR4C0/0ASjRxvCbyRtjYCP4HgXPQ023nqZONfn0Hr6ef/ygn+LzbUg==
X-Received: by 2002:a17:902:c94f:b0:1f6:8a19:4562 with SMTP id d9443c01a7336-1f6dfc426d6mr27231345ad.24.1717796478156;
        Fri, 07 Jun 2024 14:41:18 -0700 (PDT)
Received: from ubuntu-vm.dhcp.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7e189fsm38946805ad.215.2024.06.07.14.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 14:41:17 -0700 (PDT)
From: Kuntal Nayak <kuntal.nayak@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	davem@davemloft.net,
	kuba@kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Ziyang Xuan <william.xuanziyang@huawei.com>,
	Kuntal Nayak <kuntal.nayak@broadcom.com>
Subject: [PATCH 2/2 v5.10] netfilter: nf_tables: Fix potential data-race in __nft_obj_type_get()
Date: Fri,  7 Jun 2024 14:37:35 -0700
Message-Id: <20240607213735.46127-2-kuntal.nayak@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240607213735.46127-1-kuntal.nayak@broadcom.com>
References: <20240607213735.46127-1-kuntal.nayak@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ziyang Xuan <william.xuanziyang@huawei.com>

[ upstream commit d78d867dcea69c328db30df665be5be7d0148484 ]

nft_unregister_obj() can concurrent with __nft_obj_type_get(),
and there is not any protection when iterate over nf_tables_objects
list in __nft_obj_type_get(). Therefore, there is potential data-race
of nf_tables_objects list entry.

Use list_for_each_entry_rcu() to iterate over nf_tables_objects
list in __nft_obj_type_get(), and use rcu_read_lock() in the caller
nft_obj_type_get() to protect the entire type query process.

Fixes: e50092404c1b ("netfilter: nf_tables: add stateful objects")
Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Kuntal Nayak <kuntal.nayak@broadcom.com>
---
 net/netfilter/nf_tables_api.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index de56f25dc..f3cb5c920 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6238,7 +6238,7 @@ static const struct nft_object_type *__nft_obj_type_get(u32 objtype, u8 family)
 {
 	const struct nft_object_type *type;
 
-	list_for_each_entry(type, &nf_tables_objects, list) {
+	list_for_each_entry_rcu(type, &nf_tables_objects, list) {
 		if (type->family != NFPROTO_UNSPEC &&
 		    type->family != family)
 			continue;
@@ -6254,9 +6254,13 @@ nft_obj_type_get(struct net *net, u32 objtype, u8 family)
 {
 	const struct nft_object_type *type;
 
+	rcu_read_lock();
 	type = __nft_obj_type_get(objtype, family);
-	if (type != NULL && try_module_get(type->owner))
+	if (type != NULL && try_module_get(type->owner)) {
+		rcu_read_unlock();
 		return type;
+	}
+	rcu_read_unlock();
 
 	lockdep_nfnl_nft_mutex_not_held();
 #ifdef CONFIG_MODULES
-- 
2.39.3


