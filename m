Return-Path: <netdev+bounces-130738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB0598B5C5
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 09:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD27F1F2228E
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 07:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3C01BE233;
	Tue,  1 Oct 2024 07:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmNfqGm+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAC41BE230;
	Tue,  1 Oct 2024 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727768144; cv=none; b=aMUPWP9ykX43bodC6zPCh1gAE6F/WRtNCX29QuV6I8ZLwWv/VcURjMUUikc2hcezYX711Ot+ltsqDRk3ojWLCLinL6qti+AOsA+v4RC44v3hmm1WbacPc1xvVTHoUfLz9xa8nQKIS8WByTLexk+KCn2IYDxIjfOgjIKv/qAYZHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727768144; c=relaxed/simple;
	bh=Xwv0xzTlUnUYvqiILZTP3WXhHoXK10waOf42+YdskI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=icjdK/uFd/tjXZdufgRrkNVMFPZvHtyMq18cCyIf3Cku/lD5YrBuPwDYOYW7OiM8mmosY8FNDuxruKu+CeOb4ODG201YShGe3MuE50zeMbmPcCRw2YTzaAF7ReYbWCjFARpyEF69WJqDgBpOFtzkkdBnxTzNu7+sVl7eggjz7sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmNfqGm+; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-20b6c311f62so21963655ad.0;
        Tue, 01 Oct 2024 00:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727768141; x=1728372941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BA2fUFMn2idXaRBnTEOav6pxPUiWEEV4wGmZD2xXtEE=;
        b=XmNfqGm+qZCFCAW003fl5pbVlfnB4nCYvunIsDccZZiDEQUYTrG2Q6+v/B5hnS1SGy
         1wMhHgnWvF+4699XgeXBBawzUd7Tu+pVPelmlndTqfb1kP6PdZNcWNyPviNtTMiVJPhF
         ZXvfikdm0fUcEjW7Syh1Rxbsa3Ot23Bwmp2xWJ9Tfr/GD69IUePYe6UcQxa5UUN94Oy1
         Rv/XQ6AsT8lHD3ED1xgo/xKsNeI1AucsCohICQSJZz7C/s6S8pLLcyksB+Eh8LpFRh2K
         qsCXP8s75FWSy1MNJdhN6A25/oNgYCduUE8rR5E5CyDvHmhfUBB/tZFkvRp197likne3
         Z6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727768141; x=1728372941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BA2fUFMn2idXaRBnTEOav6pxPUiWEEV4wGmZD2xXtEE=;
        b=uckh8Cie6djMhAGQZD4289NjUq7CaYQYNDHWR30vipGY9MDm3JlJbjuKg9T2v8DgsJ
         ZF/Nev52LVKZoWHCEuo4e7QTP/PwYBiAJwnK6CY2Aoh8h6s8AXSduF3S1HsM+Bk16IuQ
         xQokHGyjOWlY9lzK7epGGAz9jUcVPTDqJM/LOcg2Exx/Ms+DrFoq4L5jXCOo4LAXvSbd
         HBZtK+heeyWhhSlS1FIT3qno7+7N0GsFjG/Trr4gj/c8AKS8unFkhvm0eUD4XVc3AALR
         O0W+0cAQiyX29LVVJLzhoLXncAREM6zgN5Fhss0Ry9rny2BCeKEmi+sdJJ4Dq1YxvToL
         wtgg==
X-Forwarded-Encrypted: i=1; AJvYcCUsbG2Vm3P0JEImQYiB0eyly/Z684pOydD7cvItY/Wtth4FbcgLWAFMlQAhUR1rsDC7Nqu0ohkE@vger.kernel.org, AJvYcCUvpH6Nj7dnMlo+HT/83qzDJVvhlq/4kKQiaSRIkZWaeIW32t28QKW5uJHUnZSWqKK8a5qQuVYnz1o+VpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiQ+rRE4bGvb1jc6WoIU4zgc1p2Tt3pGEQoPfV4oTAxhznn3Tx
	DHHM56lbFFrV/d3+56OOOoBBm7o2G+kuVhWoNdatwvmVJVhmKwSw
X-Google-Smtp-Source: AGHT+IE8MYsUW2XHcXK15ojE0PGnLuOapVV6jHisnGTRUKUvTIREbWF6mCri2YjXMANowQyS0JmBRQ==
X-Received: by 2002:a17:902:f552:b0:206:ae0b:bfb6 with SMTP id d9443c01a7336-20b37b7c38cmr218743265ad.40.1727768141196;
        Tue, 01 Oct 2024 00:35:41 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37da2667sm64545575ad.102.2024.10.01.00.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 00:35:40 -0700 (PDT)
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
Subject: [PATCH net-next v4 11/12] net: vxlan: use kfree_skb_reason() in vxlan_encap_bypass()
Date: Tue,  1 Oct 2024 15:32:24 +0800
Message-Id: <20241001073225.807419-12-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241001073225.807419-1-dongml2@chinatelecom.cn>
References: <20241001073225.807419-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kfree_skb with kfree_skb_reason in vxlan_encap_bypass, and no new
skb drop reason is added in this commit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 drivers/net/vxlan/vxlan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 3da3ea27d3af..4610f3e194e0 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2290,7 +2290,7 @@ static void vxlan_encap_bypass(struct sk_buff *skb, struct vxlan_dev *src_vxlan,
 	rcu_read_lock();
 	dev = skb->dev;
 	if (unlikely(!(dev->flags & IFF_UP))) {
-		kfree_skb(skb);
+		kfree_skb_reason(skb, SKB_DROP_REASON_DEV_READY);
 		goto drop;
 	}
 
-- 
2.39.5


