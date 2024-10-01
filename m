Return-Path: <netdev+bounces-130737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E8898B5C0
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 09:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 929941F21F7B
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 07:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D5F1BE227;
	Tue,  1 Oct 2024 07:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqzHVEYG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16A91BDAAE;
	Tue,  1 Oct 2024 07:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727768138; cv=none; b=FzMQrD6HG8+BsxT4pwy5QJnLdpZUdeLL5Qhbs2zq4N8pXZTXj/mhCTrTvGsiwnjxbSrm3ywyUTsyhnvcwMjdschQcnl02Dbt6M9hOfiad7KPnQP1krs1uhZD+eLsbfDCNYzJYLoddo4u36KtGqXIKrLSaZMeDYiYf533qjVsGIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727768138; c=relaxed/simple;
	bh=djL+yaG8xaOFgmwIqBiZ4eq9LtHa+73OeWcdrLgR0tU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SqiDZu+KIdflS5wAhXrMJUDqXU1uyEtSOrh3minZzrpB+Q8d6FysDisVPUwBwOxE4V4FEYIYimyBH2Y4eN2bEccfIfsk3HeaYsxDwC41Cv3rsVJdj2ANkIR41R2wMAgJ2zhEVsqE46dwqaCMbjN6HTvhjW43FRxq6FMwk5/BOeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqzHVEYG; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-20b5fb2e89dso18358545ad.1;
        Tue, 01 Oct 2024 00:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727768136; x=1728372936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTE6FReM0lnwJXm9JKKvZJ6AqvoonbqtBXpWhb+TWWk=;
        b=mqzHVEYGwyqOqdppvoO+byTYgo6xVPMy/A21VThj9V1H7lazm1zSgFSVpCJlT2fF49
         sbaJ7QRJx0rd5+l5Zhfp7KsfAktUvaB8Ak/9vxhE8qoSOj/MP1PZDJIS4l4tU6KhpsMm
         mxprt681UmXlsHsnqE2rLaU213xabLji9928B5mELxLWyg+iO7VqodtGlmpmLTiV4zzF
         N8ABSweUn+VJcxee6Tv9zuM7pUjK9bImWSGVqSKyRw29XgB1MyIX7kVnqTA5aEAVNFNM
         3gCcNOPak3Bx6oYdP9XBrnTV5733TCrJEPtIDdONNJPMPBQVsHilpqZTVEXeA8WFYuN2
         7PfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727768136; x=1728372936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTE6FReM0lnwJXm9JKKvZJ6AqvoonbqtBXpWhb+TWWk=;
        b=qHCypkDajq6iOZUxLMmH2t+nprEEwKp2A60XSDrzINr+TfBnJG14B8+msL6bgYMePr
         xrf0odeF60M0BQx2nGSY0UI03QJrLScaNWF5TBO/Nbf0Bn/qAKABV1mZs62mVhImmBJh
         +dkReBL69b5wIq/ZOueTaFW1QI6lSpwM30L3hDANdOsmMTDA1JwIGo8eVug3W3FNwT4h
         Wec8yDd15CyKdtUQZVcv9oltHBJQRpo25gROnaNZyax9cEm8Fg9tfC8fsaMlZiAmvaG6
         OeygVawQg9CJ6IcnucIpdqUz4URGfcaM1Ky7H9qRy4f7GD9WqXjsirnYy/1lOh0ReZuW
         OalA==
X-Forwarded-Encrypted: i=1; AJvYcCVQzOYSkIkDKbX8O72+InYWChh5DFyi3p4JzoIvK6djKk6H2Y8SsQa7Nte/Eq60os/wfNz+GTCg@vger.kernel.org, AJvYcCX9MGAh8tOZI642YoXP4pqO9chdaQlWdGSFgGRu2GMp/4NaOe4Ee14PlpaHl3ITWz9RBQXupoOPuFKhDQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOWLCIwt4egr75h2khEZ8XZ7ML4acLVvCX3ddgaV2RxQAj4ehd
	BLMyCGmSw3mM76VcgzXTpajnZyr7qAia01AdQaaTUpE0totrJVBd
X-Google-Smtp-Source: AGHT+IHB3no/+rM7bSM0Yc0r6+XQLqqmJOI3kt1ekkttVL052rnvDDwxKAjJ6xAdcrPdjQY3SnnZ7g==
X-Received: by 2002:a17:902:d4cf:b0:206:a1ea:f4fe with SMTP id d9443c01a7336-20b367d032emr218297945ad.10.1727768135965;
        Tue, 01 Oct 2024 00:35:35 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37da2667sm64545575ad.102.2024.10.01.00.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 00:35:35 -0700 (PDT)
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
Subject: [PATCH net-next v4 10/12] net: vxlan: use kfree_skb_reason() in vxlan_mdb_xmit()
Date: Tue,  1 Oct 2024 15:32:23 +0800
Message-Id: <20241001073225.807419-11-dongml2@chinatelecom.cn>
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

Replace kfree_skb() with kfree_skb_reason() in vxlan_mdb_xmit. No drop
reasons are introduced in this commit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
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


