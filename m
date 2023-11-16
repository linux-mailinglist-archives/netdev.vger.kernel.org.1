Return-Path: <netdev+bounces-48441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5887EE579
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 17:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D993528109E
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 16:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17113DB9E;
	Thu, 16 Nov 2023 16:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="kQf3w4nW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C31D6A
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 08:48:33 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53de0d1dc46so1501411a12.3
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 08:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700153311; x=1700758111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Loj6eye+Xg8SMV+GCvDdSe8coR7xpViOIIZYOTm3lQ=;
        b=kQf3w4nWVfMp5TbTTYQTxtzVnMTBaggXEE0utZUZGj8rjNyeTF8p6YpMvxfYXoesmP
         Wqx+uCIU9x/V4kjKIZQYJuZ/xUOTUp6ivJhZCThQtd6YWUh/l6gHaYOiLQjLG8gnVzTU
         oPXxveHnFD68ZbygHB0pcrH06HulkpIg1sIhBuYdO7sSnfdsB2Vole2DeqGsLtmcATVW
         rDc6wvtVQNZjU8belhJSHo5Iz4iFQPD0azVTD/ltEYrKfjF6cSedxQaHkk+mMoIQVEhQ
         wRDkgV/xZHV41BJuFPb/2NEhi+FG45At0l6VKGywCSRIlzYWwqOWmk03OAhDtmODmBmy
         +G6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700153311; x=1700758111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Loj6eye+Xg8SMV+GCvDdSe8coR7xpViOIIZYOTm3lQ=;
        b=ipCxWWdjsC0F5I61SB5f9ddKKoRKfSoN2h+xsKl0nNkxWsGhmneNmyhtnDbY1w+eSB
         FwRlSBfz7U6n+CL4lZCs6reqsNlvgw7QhpVoCwzdJwnHCgMumDr23RUr4tSszphXiWry
         zc8bd2IPQoID0M4DMw1xf0yR63lwOGS1gLubgPJFHAsAh2t3Z7Hw6t04OjHVTs93snWA
         dgESXKQfweXahqWb4u5DvU6giTvZ6cdyrg7tFPZkZhULfCMetKtWiAq46grd8kzUM5mX
         70n/KULl/hl8DzJYcZiFNlhPfQrL7TcRpaMQt5vpT9OD18bbHeOaBR+L/STuCZy9fDmP
         Ueqw==
X-Gm-Message-State: AOJu0Yyt+yAKuPIgYMORyB8bJN3G/w22QlItKZbItJqUugaJBcGQ36ac
	AOX4/Uo1HwTTtKxnmIPLJ5DzRdPfxssdKSfxpfA=
X-Google-Smtp-Source: AGHT+IFi6kV1QSkIDWgAPFTy2pGE081ZhqHi7BoBMGdxtjO57zlgwA7pCxjc2LlDLqPi10J4S//Fpg==
X-Received: by 2002:a17:906:480b:b0:9e7:2d0b:8c46 with SMTP id w11-20020a170906480b00b009e72d0b8c46mr15128898ejq.50.1700153311481;
        Thu, 16 Nov 2023 08:48:31 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id k3-20020a1709065fc300b009b2c9476726sm8620010ejv.21.2023.11.16.08.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 08:48:31 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	jhs@mojatatu.com,
	johannes@sipsolutions.net,
	andriy.shevchenko@linux.intel.com,
	amritha.nambiar@intel.com,
	sdf@google.com
Subject: [patch net-next v2 5/9] genetlink: implement release callback and free sk_user_data there
Date: Thu, 16 Nov 2023 17:48:17 +0100
Message-ID: <20231116164822.427485-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231116164822.427485-1-jiri@resnulli.us>
References: <20231116164822.427485-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

If any generic netlink family would like to allocate data store the
pointer to sk_user_data, there is no way to do cleanup in the family
code.

Assume that kfree() is good for now, as the only user introduced by the
follow-up patch (devlink) will use kzalloc() for the allocation of
the memory pointed by a pointer stored in sk_user_data. If later on
this needs to be implemented per-family, a callback is going
to be needed. Until then (if ever), do this in a simple way.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/netlink/genetlink.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 92ef5ed2e7b0..905c5a167f53 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1699,12 +1699,18 @@ static int genl_bind(struct net *net, int group)
 	return ret;
 }
 
+static void genl_release(struct sock *sk, unsigned long *groups)
+{
+	kfree(sk->sk_user_data);
+}
+
 static int __net_init genl_pernet_init(struct net *net)
 {
 	struct netlink_kernel_cfg cfg = {
 		.input		= genl_rcv,
 		.flags		= NL_CFG_F_NONROOT_RECV,
 		.bind		= genl_bind,
+		.release	= genl_release,
 	};
 
 	/* we'll bump the group number right afterwards */
-- 
2.41.0


