Return-Path: <netdev+bounces-49129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C537F0E11
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733551C215E2
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 08:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD55107B9;
	Mon, 20 Nov 2023 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Yo2S7mxR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189891BC3
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:47:11 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-543456dbd7bso9896398a12.1
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 00:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700470029; x=1701074829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Loj6eye+Xg8SMV+GCvDdSe8coR7xpViOIIZYOTm3lQ=;
        b=Yo2S7mxRa04bpR+nGXnR+l22Ri1BxoTcMc8EGTTmHzIODGIbjf8udVLWUJGND6shz9
         vg+aqOLD1mkH12J0sG+ZPyVk+OeyTNBcfquI1xxyDQqyxF0XhBnYwa7EgQho+3gOHMG3
         D3hU0Hk91lU01xaXxJPLiz6jy4PIeCDRPty8vyqSBIHYWhrUE2/NW0qZVzU3cQ8rJgkA
         S21oIAClHFAGTbnerDfXjqEXZAglJcVMyEVmDoEA32waTYxrJstkrNTFYPEsaJtmcWHH
         0Zt7gG+1ZEwlJmrjufJ8Qs6u8tATFaGlDbjMWPHkhNgC9FFK/JZbU/EcnhJIfrOwqJN3
         U9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700470029; x=1701074829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Loj6eye+Xg8SMV+GCvDdSe8coR7xpViOIIZYOTm3lQ=;
        b=Q2P1brHDggVHQAQU4HNr3OzPYAomiafrICThinqveGdesk4TdbiKZN5ODPczlomKYW
         HEmpnsoCyZzzJrF8hfJFNkAGil+sKiKsk/3iiHbXC55IvUFcqi3+zqin2oFd8rp29eam
         Mq6v1kkZYEM3oSCdNzmGQbYvKPWpNEWDPco066BVSyw9VmEcJd89m996NCfFpYWvIfEO
         hai1Ctk7TCEvdIjI+tZxxKOQRlb6WK6K1biSiJbdG4t0ZaUx04YmQKtSKmu6MtFLi/Uy
         cDmDem7OQGu7uyGFFSY5Mi9ZNiY3QinFq90iB8bWVNRzr+0Ie86zKI8Q5sdjlcWr1L/6
         OLog==
X-Gm-Message-State: AOJu0YxrRApJPyf3sOeeB3bpMYTgEXkIF4EqNkNCcAKBkf6Y3KtNx+Fe
	pG24+rjcTXZPULHnIqqlAhogNxFnn11kLw/Ed2n9cw==
X-Google-Smtp-Source: AGHT+IErDyyPKBi0mRbhyTP3J6BOB8omO/JVDhSDRTEHZw5B+b0pgBzRMd8Am8JV2uHrXUDa4oduRw==
X-Received: by 2002:a17:906:25c9:b0:9b2:be5e:3674 with SMTP id n9-20020a17090625c900b009b2be5e3674mr1084435ejb.36.1700470029253;
        Mon, 20 Nov 2023 00:47:09 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id g15-20020a170906538f00b0099ce025f8ccsm3642005ejo.186.2023.11.20.00.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 00:47:08 -0800 (PST)
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
	sdf@google.com,
	horms@kernel.org
Subject: [patch net-next v3 5/9] genetlink: implement release callback and free sk_user_data there
Date: Mon, 20 Nov 2023 09:46:53 +0100
Message-ID: <20231120084657.458076-6-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120084657.458076-1-jiri@resnulli.us>
References: <20231120084657.458076-1-jiri@resnulli.us>
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


