Return-Path: <netdev+bounces-120275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EC8958C1C
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 18:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 951AFB214FD
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 16:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4712192B6D;
	Tue, 20 Aug 2024 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B+szDC62"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF52194129
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724170856; cv=none; b=Dtsr0rPF/qFAWii5p+y1K2i9ap92PSndHtJsUBAyn0W23WuBy09wo1YlofhUyOKsFURayItoFgZgWLDGW8aPx3KAe2qiUfVs+L751YIJOKV96cn5LSl8baH0ylVmJy5q/V/VL8MyS5OlCxKxRQ2hgMEfcUGjcmtO3eFtSgP9B9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724170856; c=relaxed/simple;
	bh=g+Oex4pd1Icqj9QOHqQw9n9pkRqn5H1TNxm78j2s6H0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=V8kNi2yatqrC+RqlCo4vw1KfT+o+r6W6MyrE5uSFs7pGw3sBeoiEMMIVMWMxuNFzLDaCWejpJkVLYMGZvqY+o8s3X/sdGdH8sTym6GneCqmlXfwGydWrE14Uf4afiPkOhcBsPW8ZtgehQ4Nzz6agAml6jXt8bENnQsHfx85wH34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B+szDC62; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-44fe92025d8so58830451cf.1
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 09:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724170854; x=1724775654; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NgWaD5vuBxHs1u//npjMxEZF+LqKB+aCfIJG59t27PM=;
        b=B+szDC62illkq8kfqtY55h94uUnKL8Ja7iwLnZ5qKXy5T9BGbuN+oaECPEHJ7F7Nav
         mGUvC1x+wJqZG+p9x2kkL9WGBXWxrd4PLKuYniAosAHCeodyDSf+pJA0Z1k7U0bnBC9z
         xDEhIgxOojQEn1m7qrSxHOligeSp41VWPj3SaFxabYyTyjej7BvJnQKV2KfxoDpobVuY
         RKsS4iZNMop99kkNBpUq1+1swH/Eo4D0AZKQ9Vs9sKdkAiwZ1bP0bbHgRFQt4JpVRQwK
         9Wp/5grlSoMiM27IJIRLxjTgBF9oQuNEukIizYaHsehQpWfu6XiSRRCvJ/N263sg0BG/
         DmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724170854; x=1724775654;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NgWaD5vuBxHs1u//npjMxEZF+LqKB+aCfIJG59t27PM=;
        b=Hc4tSifH1iHCe8AXyy4rS6gO5/Y8IEVvgpswFSY+o4Frs4vckBFz9LWgpyaUnMTI2N
         LrpaKHmmzXConboxLnRwM3LYg73jS/fK5VsHbKHG88WXQDizzev6HEbx0Sy5Oh2uPrMd
         /2dm5WknsqDA94eN4gQ83a7TFGgS10zYgd+CE4LOmh1Q7SxdwI9Gf5dzPhDDm4fTMxj+
         33OVyAkVQSwxis3m4JPc9nr9NGsv9cWX/UR1B14l/Z6U7GqSnD5GM7vGiZZ8ioy1DHwZ
         pk+Cgyw00hKS+NCXFYf191GcSnklIl2IHMXljNRE7nuTIUu2W9AAs2u/Zof7ucl8LIwu
         bs/w==
X-Gm-Message-State: AOJu0YzISArPqCuIpWgxeWczK+cbKFSm5lopk3pTGmWGIja5OrcfV2jQ
	0TO/Ch+bF4Wcp+MRK3Jl3EkeG9hwyCmF4h2p6BdkcY/U8M6KDtxLGElPW5lTR1Ns9i/MoPvjz4T
	1BFhjLCFkfA==
X-Google-Smtp-Source: AGHT+IFU/xjKd3K7q+KSVujCTElkKVtfrfgE/DrvMNOMaw9IqCXpc9Rjz/BlvY8eKph58+UGxF9hxIv07dgAuQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:ac8:74d7:0:b0:454:b24c:da2a with SMTP id
 d75a77b69052e-454b24d0739mr455151cf.2.1724170854125; Tue, 20 Aug 2024
 09:20:54 -0700 (PDT)
Date: Tue, 20 Aug 2024 16:20:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240820162053.3870927-1-edumazet@google.com>
Subject: [PATCH net] netpoll: do not export netpoll_poll_[disable|enable]()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

netpoll_poll_disable() and netpoll_poll_enable() are only used
from core networking code, there is no need to export them.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/netpoll.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index a58ea724790ce772004f4053afab0f7da458aff1..cff1f89719b6d6ba66b4687db03596d8362b6571 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -228,7 +228,6 @@ void netpoll_poll_disable(struct net_device *dev)
 		down(&ni->dev_lock);
 	srcu_read_unlock(&netpoll_srcu, idx);
 }
-EXPORT_SYMBOL(netpoll_poll_disable);
 
 void netpoll_poll_enable(struct net_device *dev)
 {
@@ -239,7 +238,6 @@ void netpoll_poll_enable(struct net_device *dev)
 		up(&ni->dev_lock);
 	rcu_read_unlock();
 }
-EXPORT_SYMBOL(netpoll_poll_enable);
 
 static void refill_skbs(void)
 {
-- 
2.46.0.184.g6999bdac58-goog


