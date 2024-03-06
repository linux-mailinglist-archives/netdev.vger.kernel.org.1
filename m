Return-Path: <netdev+bounces-77988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEF1873B30
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50AC01C21C30
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 15:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C61135418;
	Wed,  6 Mar 2024 15:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I7Oueypm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0914E135415
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740317; cv=none; b=Xh5UFN3Fx431CP32+T4mS65OcxjjTmofEdp9isAxYuX2QDrJN24tycshkz0XEvhNtSc0U8rvhBtzP5mvVfU6BCHMS/6VYEupQJrPSK3Kll1u0khc+pouCRELC03fMCkMoVE9xzzuKYwbSVsM0RExSLFGNElhk13wCzjeZOGr63c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740317; c=relaxed/simple;
	bh=FR0dKKQuF46zhdu8kuXkuJY++IVUQ4CHf0B59f9t5as=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s6+8v7nSfGJfYtrVa8rBHkE2tPxX+o0ngzKNlTbzMKndeFbVdx4Ax1dw9O+2U5jVzq5vvYE3D+GWrWU2T3nS6nBQhjjYFqXBXSLcX359FO47OU2t2JSvciuO7j6TXsf7PTno2B21zX7GJQ/KS4++qdhRcwvIZ2sNFUDKkr/n05U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I7Oueypm; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6092bf785d7so21133677b3.0
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 07:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709740315; x=1710345115; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vjzeD8eTJa/7w1oHCjeATVvNohpTtFWC2/sFOcAke9o=;
        b=I7OueypmLxfCiryUUNU0U7dOznVelFhYEevbvVGFEYzdn+17Uvs/3lOop4NQITlXrz
         axFW/Wuyv2iIVVE5hZL0I+Ry+0dCp/b3s3ir9p4tHVI/x6Rm3uHJX3WUz/pUO3V9bFk4
         Oy330L47SNBOrg/lERFH8asct29NAWfghIcVR0CTDT2Dd8ima7rLDns5XBualFGd4SxT
         LYJ36NAQVqPQXu0qQyrufXhWhNzcSRt1rqipArqHyaI1f9OYA9t+wq4N93d63vuHS+b7
         ppqFXQQXdOAzaehL4YtHWu3ww3w4NgRG1tRehqpvxuYjbmkF+nJAparEn/5cyn1ARv3z
         dWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709740315; x=1710345115;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vjzeD8eTJa/7w1oHCjeATVvNohpTtFWC2/sFOcAke9o=;
        b=GrHPZGTh1iNL95Myn1sbUp+Bo6gNoSpCZ7Vln4FpkIc3aHCVPhcoNc8csUtjW3MwlC
         uyTlX+W+VA9fsC9eZR0ieTA6byq1hPCSq3fG28573bD+aVHmaJ8K8a2jgK3y4uBx4RY+
         oYN/SJZY3aZHHfsqtZG4rWuc89GdkqncxoQSbWN6vIuAWyDaGo23tpshz345bQTJeDZd
         kxKFqhKyFq1VugFPJRr3ZsZ2AIJ2V0dbTvahldkUSnvj2+l+6smkVuqTEsCe/tw8X1Ew
         Eufg72CfgEbFbxDli2TFwbMGal8iX+3yVaya48F6hb9yF+EmhedRTX23tWc2iVEcIKQ0
         lp3A==
X-Forwarded-Encrypted: i=1; AJvYcCUhAYHF1RfHOf/aw7q14yyic93SRLk76/RBbQbdMhlSkeF/TzZLGbnrrfMLB9dmfI/C38wAJ36S0eA7P9WaLsxB4P+of8BB
X-Gm-Message-State: AOJu0Yx2tKYiCZloZbJqqvmxCeydbhrRAdvkoUk1oxmtoV419+/xa2sT
	4Zjj2Yf40IUY2XeinvYE4CxuW3e+JPMrmIoUOrszEuucGtYSYVdL37/5lS34KI+vJfG88MznuSL
	2Qxf925kU6g==
X-Google-Smtp-Source: AGHT+IFbbVeZBU9i2bvMdywE7dyIxh4QtpE24FcKCICPMQU9n4qxSyHZp7Objde1kxm3FtnITrKabZv+h53oCw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:705:b0:dcd:b431:7f5b with SMTP
 id k5-20020a056902070500b00dcdb4317f5bmr3828933ybt.0.1709740315110; Wed, 06
 Mar 2024 07:51:55 -0800 (PST)
Date: Wed,  6 Mar 2024 15:51:44 +0000
In-Reply-To: <20240306155144.870421-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306155144.870421-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306155144.870421-5-edumazet@google.com>
Subject: [PATCH net-next 4/4] ipv6: remove RTNL protection from inet6_dump_addr()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We can now remove RTNL acquisition while running
inet6_dump_addr(), inet6_dump_ifmcaddr()
and inet6_dump_ifacaddr().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/addrconf.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 82ba44a23bd7434e93e8a847f38cc72d8ce228a8..b72bdbb850a86a45b4ba7c83df2772f7214891e2 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -7459,15 +7459,18 @@ int __init addrconf_init(void)
 		goto errout;
 	err = rtnl_register_module(THIS_MODULE, PF_INET6, RTM_GETADDR,
 				   inet6_rtm_getaddr, inet6_dump_ifaddr,
-				   RTNL_FLAG_DOIT_UNLOCKED);
+				   RTNL_FLAG_DOIT_UNLOCKED |
+				   RTNL_FLAG_DUMP_UNLOCKED);
 	if (err < 0)
 		goto errout;
 	err = rtnl_register_module(THIS_MODULE, PF_INET6, RTM_GETMULTICAST,
-				   NULL, inet6_dump_ifmcaddr, 0);
+				   NULL, inet6_dump_ifmcaddr,
+				   RTNL_FLAG_DUMP_UNLOCKED);
 	if (err < 0)
 		goto errout;
 	err = rtnl_register_module(THIS_MODULE, PF_INET6, RTM_GETANYCAST,
-				   NULL, inet6_dump_ifacaddr, 0);
+				   NULL, inet6_dump_ifacaddr,
+				   RTNL_FLAG_DUMP_UNLOCKED);
 	if (err < 0)
 		goto errout;
 	err = rtnl_register_module(THIS_MODULE, PF_INET6, RTM_GETNETCONF,
-- 
2.44.0.278.ge034bb2e1d-goog


