Return-Path: <netdev+bounces-123558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 095C3965504
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 04:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2C051F2109C
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 02:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C80150989;
	Fri, 30 Aug 2024 02:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXCCBmSh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f68.google.com (mail-oo1-f68.google.com [209.85.161.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BA91531CB;
	Fri, 30 Aug 2024 02:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724983385; cv=none; b=M3iaNuTTJek6TMtxvs8YaxenJJGHfRoqOXtTtfj6VqdS6CbV8leI5NPsACN6/gG+YYYcebo+uQ285cEFv0mltBTIXOuvhf8fJKp+Kr1GlNTrNlxOnOe+EjhixLxYVwUt+9zDN8rg0DgXS3lr7Fb73Q1Ll8vGZyRu9X7Fle7rp8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724983385; c=relaxed/simple;
	bh=9P1mqG6VPSpkSc+cDNoawndgukB8gmMirUrypXaavhs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lDUub7q5Z1pYCPEtEy+HnFyI8/l8paTeGcOed96jtvFPJwIc5OzhblwUleS9TF1i7PrNuzGTuQb0EkGz5ZtPi9Ss+Aa7U232MXW31wLX6tqJjN4GoSD4jS1m6PySE+DHhztxcthtpgWREMsR/06deTCOlWyfHIY96LDeYLzrHzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXCCBmSh; arc=none smtp.client-ip=209.85.161.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f68.google.com with SMTP id 006d021491bc7-5d5eec95a74so790266eaf.1;
        Thu, 29 Aug 2024 19:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724983383; x=1725588183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/BYr9nbVa7vl+8GW2u0kvBaL1oxUPHU99B66m+wyqc=;
        b=OXCCBmShYrKACqV5/xJh65X97ON+3MncTVQK0gYKhCFqFIPKbYST1oV3HunbFk/Ayj
         m1GR8bebNNYv0HjFooBnZsrAR4loglaIbPZ98cyrEjEwWVzCYy37jn5sH8zhLqzvG1ok
         PvhGOy2Mf20A+kWwGTOK59Be1EfwYhXwZEGbrP0gpNPT5LKs2enO3eLkKn0L5ZGPqmv/
         cgBrEhDsxaPCTTKN8eeSom/SlnVL3fSM9MLu/JzUX8otEgp4QU5bmbmYjgbcY7++ACl/
         nbmL/+23OqhxHmznlw2HiOEuGACslq+hBeSdefvwb1AJC+F+GsjritN0/BgZwvhxdCip
         kVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724983383; x=1725588183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/BYr9nbVa7vl+8GW2u0kvBaL1oxUPHU99B66m+wyqc=;
        b=cYNVF36bEMvsAwckau5TPXLzO5WKNbWh6IGk3+M1F6kOoWJQTkcDw9G1p75noj7bj5
         MPvoZT3l+Z9+qgQhc2GR3uhDFKDDJ5ckLGHpn5vaAtdna1Pvu2Ep1ysElOTBKOebaaBl
         Q5HawenMs/Et2Mja661P9pnslIf+f59f9p1EsYjfCad3tavQCf2Q0FRJ0ps3kq3JBoT4
         64WIgaCfNZCwvHaEt9HRBTU05P5droCD9MjvvomegDAi4DGvxnnbzbXdb+Jy6J0ofbLt
         6jiT67rUNfaxtJ6qzhKxR2pDPpLtT4K2FMEwat+VYDMK2gBJZIX308wMZQnI0AbEVub8
         2QuA==
X-Forwarded-Encrypted: i=1; AJvYcCWIKTCt3tSbj/oDVJgtDBf/bGViEUYxg4JNA8V1k1AhyPlej+PfGgx7FlZcCe0PjdgBNxH+1mlLHTM3B8c=@vger.kernel.org, AJvYcCX47XDEuW5BwYTMFb5jJNeR8u64sWQIm7X/x7L/4ICqiMGIMMb5TOaotH16FMOalg8g300Jc9eC@vger.kernel.org
X-Gm-Message-State: AOJu0YyAjpIGMhFxKYo32CWgBfAp6JSAF+xipUiPvkvaKhgG84lIpO/O
	hh57z3twhQhA0MOYJiD3uVucUQ4ZCCTo+W42jAP1VAPWTVdZ2DRH
X-Google-Smtp-Source: AGHT+IFvq8fnAVyWcQ8UcYbVlwyoMwhB3N0J2npYlLizXXydKttTUGsZdh4CrpG7rsmq1M4e1s49Rg==
X-Received: by 2002:a05:6358:52c7:b0:1b5:ff76:e076 with SMTP id e5c5f4694b2df-1b7e39333a8mr90531155d.17.1724983383159;
        Thu, 29 Aug 2024 19:03:03 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a6b60sm1764221b3a.87.2024.08.29.19.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 19:03:02 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: idosch@nvidia.com,
	kuba@kernel.org
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
Subject: [PATCH net-next v2 10/12] net: vxlan: use kfree_skb_reason in vxlan_mdb_xmit
Date: Fri, 30 Aug 2024 09:59:59 +0800
Message-Id: <20240830020001.79377-11-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240830020001.79377-1-dongml2@chinatelecom.cn>
References: <20240830020001.79377-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace kfree_skb() with kfree_skb_reason() in vxlan_mdb_xmit. No drop
reaons are introduced in this commit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 drivers/net/vxlan/vxlan_mdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/vxlan/vxlan_mdb.c b/drivers/net/vxlan/vxlan_mdb.c
index 60eb95a06d55..eae3a05588d9 100644
--- a/drivers/net/vxlan/vxlan_mdb.c
+++ b/drivers/net/vxlan/vxlan_mdb.c
@@ -1712,7 +1712,7 @@ netdev_tx_t vxlan_mdb_xmit(struct vxlan_dev *vxlan,
 		vxlan_xmit_one(skb, vxlan->dev, src_vni,
 			       rcu_dereference(fremote->rd), false);
 	else
-		kfree_skb(skb);
+		vxlan_kfree_skb(skb, VXLAN_DROP_NO_REMOTE);
 
 	return NETDEV_TX_OK;
 }
-- 
2.39.2


