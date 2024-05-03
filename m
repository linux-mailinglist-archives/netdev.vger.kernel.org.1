Return-Path: <netdev+bounces-93345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4BB8BB3D6
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 21:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9A58B21576
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 19:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCEF158A10;
	Fri,  3 May 2024 19:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pa382NlX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE20158863
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 19:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764069; cv=none; b=U7btY7GQKj2XBa5zWIWVCmmwWOTGePd243P2LYIr4L7gYofVO4lrzh28CZqF0k6BG+kSgewmhpTurOKqgff+lBGEemQgo3ybNvcttqjvXYQir5wiNN/x/8eFr4qoYicoRX9EFxd7Y5kdQUg4EgOZxGLYPaWSqW3zc2prPQlJcrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764069; c=relaxed/simple;
	bh=CSV+1s7gEyCgzGjbySij0XcBjebpUYezWFKRWKUJ1Io=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mIEXXFhf8zgVTYF6JV1spawOw7NqQpwmIHkUi/hl5zXl3qX11KWfVIY6PEkmROhls5zKWCgBpLZnpKMBHaSCNid383BtmdvS5xWj40vOVOe3msSNtBEAc6iVAN7zYS3T/0bH36R5PpyiW1ZefyegYK8k1H5N4bNIN3eMybQTVpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pa382NlX; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61bb09d8fecso140414677b3.0
        for <netdev@vger.kernel.org>; Fri, 03 May 2024 12:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714764067; x=1715368867; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mxgCTefd4q94lTE6o3lgiJsd3Dd3lGIeXXmmQWG1Kds=;
        b=Pa382NlX54jQLo+nSn0FfBVepQc43shPirDeXw7g6ZrMu85MjEpw2o3GUCqg4w/FZq
         TG16lgmYQHwU3RQXN8qskRKPdzmMpDOOcHcnodITX77ngYC/m6x06sYfd6LdqCpHf0s1
         umUmzb90dkTwxKuFr0yrPdAvYrqvPnnge2rCbG6Sa+qrFMAovc47vMOuE9KN62cwQZ4L
         FA+ODLgiWQgTnXJZCLwM+zfdidUwYQfis/I+N2OZ8/ILRTQi/13RcIh4dpbaIrWKqaLh
         HxntwRlpZYDbpCbdDZtc37IuqDr2iywFjFLBSE09p69grJUnBwx7uceT68lQzI33fFBz
         N3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714764067; x=1715368867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mxgCTefd4q94lTE6o3lgiJsd3Dd3lGIeXXmmQWG1Kds=;
        b=ha+jrueexFgtc6Jn4mM3IlDzXpzouJ6kCs6mif15dfoRMdSYXH0uPjTKSm2tmebL4H
         y8fVNod1b/nzr6etSX4OZ+TCi5BGpOF8OxJ74EEVlbS4gwKnFqlzK1k+33KDu3ZnuMRW
         nIibdgNwzf/Ziv6cMzyLaMpci5UdzLC2MX19q4ptJxMKKuZdPqet/nLIzBzKFJJUVAfc
         yRQ7Nr52f1ND5gSfXA9YA3OSJoKvGk/Kr+NvHCoqtHOQWMWWBAsiBUbhAxIqP+nrI+pZ
         NYUs82t3n85tHmY0eCzzApLZiBYhbtMGDKZpHGosgiW9zbdVa1fUwdB4EBkZsqnK5NkB
         vUUw==
X-Gm-Message-State: AOJu0YyoSoxSQW1Stus017onyeNufMau4/NLDtQ4c2Cj32m6Fv3kWi8T
	d4KOfrN7LYzkmI8BG3OeiL0Rb4+0/Acv60YyswEMVcnw2Ds4b4G2UB7QYXr7J/SembNHGZ82nOT
	bduGBAwXyiQ==
X-Google-Smtp-Source: AGHT+IH8U9Z2bgS7j1fbzjxM106lT6qfu8GqWkcPon83ppMtCbgv2pGG4gBX1qpbnkMXs16C+UKbWZBy4JjhqA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:18ca:b0:dc6:b813:5813 with SMTP
 id ck10-20020a05690218ca00b00dc6b8135813mr468377ybb.9.1714764067203; Fri, 03
 May 2024 12:21:07 -0700 (PDT)
Date: Fri,  3 May 2024 19:20:55 +0000
In-Reply-To: <20240503192059.3884225-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240503192059.3884225-1-edumazet@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240503192059.3884225-5-edumazet@google.com>
Subject: [PATCH net-next 4/8] net: write once on dev->allmulti and dev->promiscuity
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

In the following patch we want to read dev->allmulti
and dev->promiscuity locklessly from rtnl_fill_ifinfo()

In this patch I change __dev_set_promiscuity() and
__dev_set_allmulti() to write these fields (and dev->flags)
only if they succeed, with WRITE_ONCE() annotations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 9c8c2ab2d76c3587d9114bc86a395341e1fd4d2b..35ce603ffc57fa209dc9a57e60981a2bca5e6a29 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8544,27 +8544,29 @@ static void dev_change_rx_flags(struct net_device *dev, int flags)
 static int __dev_set_promiscuity(struct net_device *dev, int inc, bool notify)
 {
 	unsigned int old_flags = dev->flags;
+	unsigned int promiscuity, flags;
 	kuid_t uid;
 	kgid_t gid;
 
 	ASSERT_RTNL();
 
-	dev->flags |= IFF_PROMISC;
-	dev->promiscuity += inc;
-	if (dev->promiscuity == 0) {
+	promiscuity = dev->promiscuity + inc;
+	if (promiscuity == 0) {
 		/*
 		 * Avoid overflow.
 		 * If inc causes overflow, untouch promisc and return error.
 		 */
-		if (inc < 0)
-			dev->flags &= ~IFF_PROMISC;
-		else {
-			dev->promiscuity -= inc;
+		if (unlikely(inc > 0)) {
 			netdev_warn(dev, "promiscuity touches roof, set promiscuity failed. promiscuity feature of device might be broken.\n");
 			return -EOVERFLOW;
 		}
+		flags = old_flags & ~IFF_PROMISC;
+	} else {
+		flags = old_flags | IFF_PROMISC;
 	}
-	if (dev->flags != old_flags) {
+	WRITE_ONCE(dev->promiscuity, promiscuity);
+	if (flags != old_flags) {
+		WRITE_ONCE(dev->flags, flags);
 		netdev_info(dev, "%s promiscuous mode\n",
 			    dev->flags & IFF_PROMISC ? "entered" : "left");
 		if (audit_enabled) {
@@ -8615,25 +8617,27 @@ EXPORT_SYMBOL(dev_set_promiscuity);
 static int __dev_set_allmulti(struct net_device *dev, int inc, bool notify)
 {
 	unsigned int old_flags = dev->flags, old_gflags = dev->gflags;
+	unsigned int allmulti, flags;
 
 	ASSERT_RTNL();
 
-	dev->flags |= IFF_ALLMULTI;
-	dev->allmulti += inc;
-	if (dev->allmulti == 0) {
+	allmulti = dev->allmulti + inc;
+	if (allmulti == 0) {
 		/*
 		 * Avoid overflow.
 		 * If inc causes overflow, untouch allmulti and return error.
 		 */
-		if (inc < 0)
-			dev->flags &= ~IFF_ALLMULTI;
-		else {
-			dev->allmulti -= inc;
+		if (unlikely(inc > 0)) {
 			netdev_warn(dev, "allmulti touches roof, set allmulti failed. allmulti feature of device might be broken.\n");
 			return -EOVERFLOW;
 		}
+		flags = old_flags & ~IFF_ALLMULTI;
+	} else {
+		flags = old_flags | IFF_ALLMULTI;
 	}
-	if (dev->flags ^ old_flags) {
+	WRITE_ONCE(dev->allmulti, allmulti);
+	if (flags != old_flags) {
+		WRITE_ONCE(dev->flags, flags);
 		netdev_info(dev, "%s allmulticast mode\n",
 			    dev->flags & IFF_ALLMULTI ? "entered" : "left");
 		dev_change_rx_flags(dev, IFF_ALLMULTI);
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


