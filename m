Return-Path: <netdev+bounces-68145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 527CC845E84
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06FE11F272F0
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9857E63CB6;
	Thu,  1 Feb 2024 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BI396mzi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104CD63CAF
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 17:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808636; cv=none; b=UgUho1YtYb/mkHCi0hgzLCvJhnLouKyK4EvK8k0FOB8kT8jxCyOaCdu6gZReWRjtSOPO5GCz2182R5AfOsGLpN43qfar5Zbh2Po//tiZ0z1Rt0xXSqqy7YRkpDd/VTgcReHUAUoVbE34lwqHN6Ahi23Lx7WyeDT4KWlIv/HhnrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808636; c=relaxed/simple;
	bh=IQH50vG6+2RWvS3aS63L89iiiVv2ize8007AGDBE8/I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=b5fa1TvxWEYDZ4Otu3tCI59Sc3GFCAz3NNGAyQxc48m9rgvKRxtnxbvu8y+vIv3awRwhsRTTkHTI9HVMuhZnoy73vviS/EV8HAR8ClQx1z7rGAddhLrXIwJrDiANeNhHhmhBqTpnMwBjhmbUYJB3Llw1k7000xAXJsoKmM9gRdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BI396mzi; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7842e5e4645so168072385a.0
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 09:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706808634; x=1707413434; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CBofQA81n5RQotweyysuqaUpZ/CiTS6jCYSMi0pY3vU=;
        b=BI396mzidAvHAEtZHcK1IRxy9gkpBuEddW+CJ9S0S61EDxLBoOSqzcJlzW5hJ5hdMO
         TW8GUTNBaZG1ShQHw0NVBpH8ufjAYHS8XW/IUe4Wknlwsxjv5jnJ8amKVj/vlo9upszm
         chgdI7+Iqa51M11B8bb82Klu1JQ5vc1SIWikGoO+LbkztDDDlsgRi3E86IlbmFoshUQ9
         LQ2GTkx5PvvZJwoafl/GMxZga8I4pS8iE0eFBaCxUcLW4F9uQzmAQjhe29WtyyRKrJv3
         91JMIYFs8Xumh1CsdT5X9+zTME2srvfFno7XhEOawoQybL+XJBHcJrQEN16iYVdiRUFT
         5PqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706808634; x=1707413434;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CBofQA81n5RQotweyysuqaUpZ/CiTS6jCYSMi0pY3vU=;
        b=HDMX8/n+aUxf98VLuCPGSG7WDAOOqa8sP3RD3C7IpyPPeIMQpd+rdlDDLxriZLWWte
         9MPOgoPDY9+mokPcI50CPq7pw6xeUOWjc9yh7HDro66zZDn0/oXNv6obLh9KO6KI82QW
         xwZFWG1TDsQNobrVoW2YGNgEIxYVQ0/aWZhCJaP0veEPTH6tUiHJXuIuJX+LDsNR6SMP
         ePfykwpDF7KJmlsoUIXIUYhY+iRmOxDmjLs0weH1fzHyV6im4dKDCb00sj6jPdIP3PfN
         7lE/h4J/GoYaGWt/DTVzrFj62LMI2ejRZncgmMEScrnQKwNhyrGqGPRtjDdbL6Yy96BF
         hvyA==
X-Gm-Message-State: AOJu0Yyp4ksuN0ADEOZx/mXodOISHTrM36sqfHNAxlntkiTUBTd1q6MW
	BZVoBSBJjIiBOJ5Jece109FyAR2RumgnBk5+vAiQMOxdCH65kgEgk9jV0nA9bpcMOLVQ9vX4+/i
	yCfNI0fhj6g==
X-Google-Smtp-Source: AGHT+IGbuNCFSP4NwGY+a+8/KSUIHQnayJ2AtIJKrWibPu2DTRwAR9+a30KEIfFnl+UkoheLG0Y6EsZqC/gpzQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:622a:1819:b0:42b:f84f:331c with SMTP
 id t25-20020a05622a181900b0042bf84f331cmr157238qtc.7.1706808633875; Thu, 01
 Feb 2024 09:30:33 -0800 (PST)
Date: Thu,  1 Feb 2024 17:30:31 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240201173031.3654257-1-edumazet@google.com>
Subject: [PATCH net-next] ipv6: make addrconf_wq single threaded
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Both addrconf_verify_work() and addrconf_dad_work() acquire rtnl,
there is no point trying to have one thread per cpu.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/addrconf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 733ace18806c61f487d83081dc6d39d079959f77..d63f5d063f073cb53f52e187efdbd09b8f78d622 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -7349,7 +7349,8 @@ int __init addrconf_init(void)
 	if (err < 0)
 		goto out_addrlabel;
 
-	addrconf_wq = create_workqueue("ipv6_addrconf");
+	/* All works using addrconf_wq need to lock rtnl. */
+	addrconf_wq = create_singlethread_workqueue("ipv6_addrconf");
 	if (!addrconf_wq) {
 		err = -ENOMEM;
 		goto out_nowq;
-- 
2.43.0.429.g432eaa2c6b-goog


