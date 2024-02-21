Return-Path: <netdev+bounces-73624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B46685D643
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 12:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64A741C2267E
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 11:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C4E40C0C;
	Wed, 21 Feb 2024 10:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ex8+Ah9V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464C23FB1B
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513174; cv=none; b=hZMSg/7NRXtukzZOTi+ygZvpQi3jcVX/r8DeN4qyABiN6zuUvG3sDsO0jedPrxLKHVBRQeJlaGyTzZhtilmECjfpBzSno7Zvv6x4/XimW4LhgGgKm9zafgixtw/a+nfKdp+0FSNVWPF4fY/G8IG0IcSTcCdeJcnrmsLHo7GjpiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513174; c=relaxed/simple;
	bh=Wh0Ss9Q6izKzkMS6Jf9NyGKKA9bpJJMgvhWGX9eC/KE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qdXLk+hbzONNSkk7LnXaNfK6GvtR2eJIrpcXSLZ2gnxfhlytS1bd9AXgftEJqrZ4hpa4pNVWOhd95SeLgdKmjBdQ5ft4wpRrioqAjCmOxdkf8swGW4w8dOFwidsrKBjm14iCxoApm1GvQteK1pNrR1IIugiPX2FC9EHM/zlFmwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ex8+Ah9V; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcd703b721dso8021156276.1
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 02:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708513172; x=1709117972; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c9tatTb29I/1rv9aD7PAsdV6WNhIBBLoW4idTSH8noI=;
        b=Ex8+Ah9VyqnAJVyesXqs2uLm8U1173OIksALhsWD1cnAbB8OnK2oAul9SaKk4Fixjs
         blyoxuzGCwtf8t8okctnZSYujo6psawKI4hgw1giuizmDZGfpyGFRHdu1aly4+5+oJYa
         sY0l8j9E/FXy6oMdeCAmsvWGDJCk8Qt1AvW5/omidxTWN3u70higC/Poqe+KeQwSbYpc
         GoZptNNYjt8pW2ivUedqKdCfO0+g/pcVVJZiybVya3KBzxOjHNSdxuPhNsmNQzzTESIK
         uTT8zmbt1otkFtoiSEZTx/8ij/WMX407yIkJOwm69MAHV7tGTZW2e3N5jGAWfyEWCWT+
         XXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708513172; x=1709117972;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9tatTb29I/1rv9aD7PAsdV6WNhIBBLoW4idTSH8noI=;
        b=DxkLBfCmil9Xe0WFG4UkIkJ6nCTQ4oRMdWDx9azwt9tbGJX8qk6GQe+pOhJ4JY0FWO
         mZGaYOacS6/MxcOagVGVkhBCiyhGTAs69RDMQPR57OtQnfXfW4hJL3LzrdUpU/ZR229x
         mmSd1tCdRTYMc0em94wYla3KFUcBFcxpr5MEkdoPdl/i8g3eKIuHgMNE5UCq+wLbtAR3
         tnPOpZcG/MUfnOgSVy9vpW751FAWyKDOzbS0JGYODvIOo41M1sLP/YDJzE6HZs4X3D51
         nSkcZif/PcoPYV/zuk1N7s8jvhYYTEFBXnfzx0zCipA6agtwQf87rMVy28NLNT3VA8pw
         wvPw==
X-Gm-Message-State: AOJu0YxFUcEpAh10zkSq1UShA6ZFRm1/i8qTKEH7zN2SqWTc8BJo7+nH
	IgTi7R7BQtuEsKRMCad1Vc9a28A8EKAz/lzeC3G7lS1hol416/5XFFWK/OZCvh4f10J6ECsmHj0
	3S1RzoF51Qw==
X-Google-Smtp-Source: AGHT+IGSAMIHI4Ep8ho5l8SKJqXkmJhR+ABkcgdLh8Qyx9+SgZTDoy96tggCxBmuHSm5rVamg9yY9LhvHcB4NA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:154f:b0:dc6:d890:1a97 with SMTP
 id r15-20020a056902154f00b00dc6d8901a97mr1025542ybu.9.1708513172188; Wed, 21
 Feb 2024 02:59:32 -0800 (PST)
Date: Wed, 21 Feb 2024 10:59:11 +0000
In-Reply-To: <20240221105915.829140-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221105915.829140-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221105915.829140-10-edumazet@google.com>
Subject: [PATCH net-next 09/13] ipv6: switch inet6_dump_ifinfo() to RCU protection
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

No longer hold RTNL while calling inet6_dump_ifinfo()

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/addrconf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 8994ddc6c859e6bc68303e6e61663baf330aee00..244b670a44b92f10b8f18c444d72a2467f8ed90a 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -7447,7 +7447,7 @@ int __init addrconf_init(void)
 	rtnl_af_register(&inet6_ops);
 
 	err = rtnl_register_module(THIS_MODULE, PF_INET6, RTM_GETLINK,
-				   NULL, inet6_dump_ifinfo, 0);
+				   NULL, inet6_dump_ifinfo, RTNL_FLAG_DUMP_UNLOCKED);
 	if (err < 0)
 		goto errout;
 
-- 
2.44.0.rc0.258.g7320e95886-goog


