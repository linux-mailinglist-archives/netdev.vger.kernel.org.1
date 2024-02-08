Return-Path: <netdev+bounces-70270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B80C84E363
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 15:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C71212826EF
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 14:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EE77B3DA;
	Thu,  8 Feb 2024 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kH5rtjyn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0DB7B3C1
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 14:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707403413; cv=none; b=aKYYs0HrGZ7iztwGNRlAkXejdVasSq6oSHaEGGQl5Lti/gIkA2/4kDXJvN1JXsQ2xYw4GR/+8G/cXz2WIXouytnmxLaKtpwcS+z1ZHgfgp1esFO6tjShaOq+zS1ES+j44ZBEkHLb1GybcdIkY3iPCOBKdz1SUd5JkKpb0WuQrYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707403413; c=relaxed/simple;
	bh=wrNRMHPMJ707slzF8xy6hM954RnvDIRVqaqg2KgO94M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g3P+5fnf+SuFa6Ip3qpbm8wpMMezxM5s7XFhG8frjmQC7TeKs5FBfKG8DvwPYjJG8Ote+V82NGo+xMRhZ3j8wzE1YqxNP3JVyNdWgWA2y9wNXRz3R3M073Fi9imaAP27+AzJn3uf7u4Ubb6fgDxSy6ck2tR0fidaxHMaBs/e+pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kH5rtjyn; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc693399655so3097939276.1
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 06:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707403410; x=1708008210; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1USIfrqAQcZZWPqpBIx/L91kD8lxH26Fisj7vCBXiEE=;
        b=kH5rtjynvlqpvjn3MR6UZQQOD8u/o+x2IBiUk3wYvFMVCXQcIHSqcib6/6Lb/mtKJP
         CGEJtpUrC8EeF/mu8L64o7vyhFBjQlbEuqMYw4kULChsNpH4qBO9iDvJxhfEQWcIdTji
         pmhr/0gSUAJFSIpZwhI1+ophyfXEYiTUmumZBNIYAMWJvpmstMbB920CsHQkzhsgh9Ep
         bHLatSjGTBCUx3kXmDaZl2iIiU29Hl2Zc545Iu0q9x2UmFCl77ebKCAxu2lSThox1xY1
         CKj61bPQ6nNgtQkWM4K6Hhsw61JH9oHfpPJI+gB/aFFGcp2l8+VeZR+z5yFXV+bSYLTg
         RKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707403410; x=1708008210;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1USIfrqAQcZZWPqpBIx/L91kD8lxH26Fisj7vCBXiEE=;
        b=OrSubcjF3y+WeheXhxwIKB3XdIUre7WxAk3Su7Fp+qvTjgEVV51YJZR+fGSmMbjC2F
         yNTqJW1QxyfU7z9ngRb3OmIeR+2jMzzN4e2c1zSoDG6z7tZLwY3hp4semcRQbFhMLaE7
         BJThnkJ9bN/XFDPhZ2YBhyFI/P1T3/3v0qfjMTUObODPgIWJFvXiOxIJN1sqzvbqXwVV
         ZvQRETeh3FOatvf1eTuEos2hiXGBv5eSxSh9n9PIxPP2dDVSXieNXmpB8/zzRfRpbuVu
         ssBQs0F4id8fXx313HS5H+os0yg7zR6gHr9AnRVdCkjTG3Kydw8Fi3Ts83zGF9+Y5xDX
         zxHg==
X-Gm-Message-State: AOJu0YwS95lpc+dnH8bqxmfuCuJisFM23R3XiteQvhFXCCRnCA77Y3jE
	POL0gOF9HXnW6R3Cho/jgYhJJpvKXBeBS37kX7F0goipWm3Om491ugF0yXsPJEdENuqwSB/CFYo
	7YmoV0Cl4vA==
X-Google-Smtp-Source: AGHT+IFJJCO2r9PHUdL1a+ab3PoM2Np8CNJHn94cTjZr+eHrk9tSQBCOY9MtSU6L3IxBOkI5hQeF/SRuqi/KuA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1025:b0:dc7:3a6f:e0f0 with SMTP
 id x5-20020a056902102500b00dc73a6fe0f0mr929676ybt.11.1707403410792; Thu, 08
 Feb 2024 06:43:30 -0800 (PST)
Date: Thu,  8 Feb 2024 14:43:23 +0000
In-Reply-To: <20240208144323.1248887-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208144323.1248887-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240208144323.1248887-4-edumazet@google.com>
Subject: [PATCH net 3/3] net-device: move lstats in net_device_read_txrx
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Naman Gulati <namangulati@google.com>, 
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"

dev->lstats is notably used from loopback ndo_start_xmit()
and other virtual drivers.

Per cpu stats updates are dirtying per-cpu data,
but the pointer itself is read-only.

Fixes: 43a71cd66b9c ("net-device: reorganize net_device fast path variables")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Coco Li <lixiaoyan@google.com>
Cc: Simon Horman <horms@kernel.org>
---
 Documentation/networking/net_cachelines/net_device.rst |  4 ++--
 include/linux/netdevice.h                              | 10 +++++-----
 net/core/dev.c                                         |  3 ++-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/net_cachelines/net_device.rst b/Documentation/networking/net_cachelines/net_device.rst
index e75a53593bb9606f1c0595d8f7227881ec932b9c..dceb49d56a91158232543e920c7ed23bed74106e 100644
--- a/Documentation/networking/net_cachelines/net_device.rst
+++ b/Documentation/networking/net_cachelines/net_device.rst
@@ -136,8 +136,8 @@ struct_netpoll_info*                npinfo                  -
 possible_net_t                      nd_net                  -                   read_mostly         (dev_net)napi_busy_loop,tcp_v(4/6)_rcv,ip(v6)_rcv,ip(6)_input,ip(6)_input_finish
 void*                               ml_priv                                                         
 enum_netdev_ml_priv_type            ml_priv_type                                                    
-struct_pcpu_lstats__percpu*         lstats                                                          
-struct_pcpu_sw_netstats__percpu*    tstats                                                          
+struct_pcpu_lstats__percpu*         lstats                  read_mostly                             dev_lstats_add()
+struct_pcpu_sw_netstats__percpu*    tstats                  read_mostly                             dev_sw_netstats_tx_add()
 struct_pcpu_dstats__percpu*         dstats                                                          
 struct_garp_port*                   garp_port                                                       
 struct_mrp_port*                    mrp_port                                                        
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 118c40258d07b787adf518e576e75545e4bae846..ef7bfbb9849733fa7f1f097ba53a36a68cc3384b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2141,6 +2141,11 @@ struct net_device {
 
 	/* TXRX read-mostly hotpath */
 	__cacheline_group_begin(net_device_read_txrx);
+	union {
+		struct pcpu_lstats __percpu		*lstats;
+		struct pcpu_sw_netstats __percpu	*tstats;
+		struct pcpu_dstats __percpu		*dstats;
+	};
 	unsigned int		flags;
 	unsigned short		hard_header_len;
 	netdev_features_t	features;
@@ -2395,11 +2400,6 @@ struct net_device {
 	enum netdev_ml_priv_type	ml_priv_type;
 
 	enum netdev_stat_type		pcpu_stat_type:8;
-	union {
-		struct pcpu_lstats __percpu		*lstats;
-		struct pcpu_sw_netstats __percpu	*tstats;
-		struct pcpu_dstats __percpu		*dstats;
-	};
 
 #if IS_ENABLED(CONFIG_GARP)
 	struct garp_port __rcu	*garp_port;
diff --git a/net/core/dev.c b/net/core/dev.c
index cb2dab0feee0abe758479a7a001342bf6613df08..9bb792cecc16f07449a91e4ca96357600d7453f9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11652,11 +11652,12 @@ static void __init net_dev_struct_check(void)
 	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_tx, 160);
 
 	/* TXRX read-mostly hotpath */
+	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_txrx, lstats);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_txrx, flags);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_txrx, hard_header_len);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_txrx, features);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_txrx, ip6_ptr);
-	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_txrx, 30);
+	CACHELINE_ASSERT_GROUP_SIZE(struct net_device, net_device_read_txrx, 38);
 
 	/* RX read-mostly hotpath */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct net_device, net_device_read_rx, ptype_specific);
-- 
2.43.0.594.gd9cf4e227d-goog


