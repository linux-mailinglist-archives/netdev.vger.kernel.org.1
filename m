Return-Path: <netdev+bounces-51659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE697FB9BA
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 12:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EF571C213CF
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 11:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E55B4F8AA;
	Tue, 28 Nov 2023 11:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="R6E/oGoc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518ADD60
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 03:53:02 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9fffa4c4f43so731880266b.3
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 03:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701172381; x=1701777181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTqLOoB/X20UDRbJ/vv+HE4al8Wf7NOyuxIi0HLABdM=;
        b=R6E/oGoc7HQGCITT/2/TBOPsCsy4tNBUzqeM7agojDFkdqQGb7mPKsgLpD9TX9jRiL
         uWtSvMl9o9bd8RTQyBHy+0XivPVQ+LOBKcj0EdMtVGu6kkA9rmkurmsL0QRv3ATLBaKo
         YwdKfoCXUfhDD3/sGdnlOf7lftLgU9jzIcKOECAma5oxfSj9sylz+sGPEi+uewGBJUR4
         NbCgyYDzkBuvnnDGjq4pnAZmDnTakfEfGkt51dxUU7f6fEEGsKuPv1Prs7EXmirVn9ob
         0YQqyJKX730iw0b6g1tmXgwBxBHtvRW4iiBPT5lvhuCg7Mrys8i9KrcgJ9KuWBazeQFo
         GB9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701172381; x=1701777181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTqLOoB/X20UDRbJ/vv+HE4al8Wf7NOyuxIi0HLABdM=;
        b=fdIaLVlCFEz9nW80xlKVOuxMQXnZe3Cw2aJqouLCE3LpwNXDWtVSa7BHKPUAhxd9pn
         mSL7kiYje3i1PRoZFSWhJ220QkPt5jiJy9bXGnyXKiMzODkWiFxSJxshZ0gDvMdiihXC
         VPRp12xWIVa2Rb7V1PDbhuWu8IrkuYd+uCoa/afmXE1w8F6pX6tnDMNruOItSemvnH0f
         1yQf0C4b1sBMIE6Ta6mpIun3dBrViPnUWX5ACf68KSSMosK60AOOGmF9BJRyMMTatO9e
         k+Vxm4KXPL10qJ+14Ln4xiQxRtSuFb3JfYs1cCcyWWAdkEmttYIrY10aeyfxQz7L6iwW
         WlHw==
X-Gm-Message-State: AOJu0YyWAZz4tjjv7Hwe5IddIszimDwhEAqx2iaB7Hl9tvoMseVus2Mr
	/+XtU3Ay41BixaVSRkWOLyQvGlpYVzKeSyvRv9fCVg==
X-Google-Smtp-Source: AGHT+IHdjij2YYNGFBnf+yUh3ieZAYufEwmpUl2a0id1QZ/ZNciUjvuvuwlBdIA8LS45lRPexuj84g==
X-Received: by 2002:a17:906:73dc:b0:a0e:d2d:2f1c with SMTP id n28-20020a17090673dc00b00a0e0d2d2f1cmr4983905ejl.2.1701172380802;
        Tue, 28 Nov 2023 03:53:00 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id jt13-20020a170906ca0d00b0099c53c4407dsm6682949ejb.78.2023.11.28.03.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 03:53:00 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	corbet@lwn.net,
	sachin.bahadur@intel.com,
	przemyslaw.kitszel@intel.com
Subject: [patch net-next 2/2] devlink: warn about existing entities during reload-reinit
Date: Tue, 28 Nov 2023 12:52:55 +0100
Message-ID: <20231128115255.773377-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231128115255.773377-1-jiri@resnulli.us>
References: <20231128115255.773377-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

During reload-reinit, all entities except for params, resources, regions
and health reporter should be removed and re-added. Add a warning to
be triggered in case the driver behaves differently.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 net/devlink/dev.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index ea6a92f2e6a2..918a0395b03e 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -425,6 +425,18 @@ static void devlink_reload_netns_change(struct devlink *devlink,
 	devlink_rel_nested_in_notify(devlink);
 }
 
+static void devlink_reload_reinit_sanity_check(struct devlink *devlink)
+{
+	WARN_ON(!list_empty(&devlink->trap_policer_list));
+	WARN_ON(!list_empty(&devlink->trap_group_list));
+	WARN_ON(!list_empty(&devlink->trap_list));
+	WARN_ON(!list_empty(&devlink->dpipe_table_list));
+	WARN_ON(!list_empty(&devlink->sb_list));
+	WARN_ON(!list_empty(&devlink->rate_list));
+	WARN_ON(!list_empty(&devlink->linecard_list));
+	WARN_ON(!xa_empty(&devlink->ports));
+}
+
 int devlink_reload(struct devlink *devlink, struct net *dest_net,
 		   enum devlink_reload_action action,
 		   enum devlink_reload_limit limit,
@@ -452,8 +464,10 @@ int devlink_reload(struct devlink *devlink, struct net *dest_net,
 	if (dest_net && !net_eq(dest_net, curr_net))
 		devlink_reload_netns_change(devlink, curr_net, dest_net);
 
-	if (action == DEVLINK_RELOAD_ACTION_DRIVER_REINIT)
+	if (action == DEVLINK_RELOAD_ACTION_DRIVER_REINIT) {
 		devlink_params_driverinit_load_new(devlink);
+		devlink_reload_reinit_sanity_check(devlink);
+	}
 
 	err = devlink->ops->reload_up(devlink, action, limit, actions_performed, extack);
 	devlink_reload_failed_set(devlink, !!err);
-- 
2.41.0


