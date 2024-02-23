Return-Path: <netdev+bounces-74368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55A28610BE
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 12:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B9B1C236E6
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 11:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8C27BAE3;
	Fri, 23 Feb 2024 11:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="OlH4nMjh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9067B3D4
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708688814; cv=none; b=DbnktcBpdvq4b7DIudLc2S0vUFeLe4FP6Y5+sggjZKPjMO+ZBduzEh9vAUz2HJbL+5e2ekUkFiDkbISip1fuOd3EjgT3uKEPd8VdpXmU4uj17msOlADmqXCZzI7AT3mwgNqOmkHmklXTidRMdS9BrNRfiWvSfbkj11dAG5upekQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708688814; c=relaxed/simple;
	bh=AL59q193AhGQ1MjN1i4e9LV1QO1+0Mpm+Q7EAlw3k8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fTiT06ZMpWLZfr834luk0qMcbmhGg+EvcrYk4A7ftHUurr4OZSzDEH0n1ge2nkSm6xGr8JAKcule7sa/3Jeg/zsEZYi0AGBOgOAfS0CKY3wfY/+3UE/I4NLhNMwHCefxyqGryjCqmhqfkiw/mRYgzTdi4SC3f3dVkYNk3n3sLls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=OlH4nMjh; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512b700c8ebso964978e87.0
        for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 03:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1708688811; x=1709293611; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mBRSSCMEADMA+/NeZM3v/YJ5K3VaAW012IQALFAOI+E=;
        b=OlH4nMjh0EloGzrJWFBsJpUG2iSmTL9g/7ig3moN4NpE/n/o9hdn+OGilrtJrGPAFW
         onB4t89dAUbt/GRgf0gjMVFm2H2WUFuQTXcyLL5bLj/GiWk+39Zm0Pi4OVGA4uIWA46M
         Sj3A9HxxvsbDSvcKy/yx4SHddG19JOtwefA+vHuzX+bTH2/VNVGmlv8uCNgVMUp/p1Kw
         7KJuqEOAkfQEgIIzrQDiKjBf6E+hyReXCjChB3oaDsCVzHEMVj4ERnnoLL9utq29NXqd
         jlTGSslHYJWyhhKUG7JnDBsTtTUum4mZncvvqqfl/VFWlsEkaZSyp8ZR3f8VBg42qKfM
         5ucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708688811; x=1709293611;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mBRSSCMEADMA+/NeZM3v/YJ5K3VaAW012IQALFAOI+E=;
        b=TEFa7KRPMd3Rya8RIJhbFKHu5/w267e0BXOWnCYjlEgga9S3M0ybnmE4WowZ88EplX
         +/Dg+xv2oxe3QS+2zROIceBNc6EO/jWkIPpXm4DJKoQie3zsLNTgJFKXpBos79DoA3Ih
         JDoLEJ/PoA7LWgLlw6ZUYbycGtHSy87eFcGrg9mpunvSPBPcHbz9EDUSdL/ya26vcKnQ
         YHjtu0ntsojxuDcdVny/xvgKj7DEl3Ci5ooAFkXXq40HkgQJh7tR6wXjbMNqOZX3Sxto
         uIB8nCoH5DOs+GG9WaQjPZwBsnpX5tA7kCb8JqttUpmX7S5p72md3J9b7zR650wVpwRO
         9YSA==
X-Forwarded-Encrypted: i=1; AJvYcCXhEzaZ4uMXJP/tLZ+LG1E9ZGurp2rvGmfjUGweGylSyqz3gza2dqK9o309jxsR+mm8ww7dxKw2MOX8b0vwPMFo0XOhIwsb
X-Gm-Message-State: AOJu0YxA6XS0raSHFCIWUGsqgy9oZUXS67vDxc7+0wANGpFH+O1tbDtg
	prIyh3P+nqATbpPq8nlmW+E4hvtc/Y4G9J7/Zic+aJYJJwLTlcddmL18RqLqJlQ=
X-Google-Smtp-Source: AGHT+IE1FodzdIAUfG29+EdpmzWKwJ/TMGMZMZ1OL3CbEJZ1hWlBLWck+b5rA0SpDIRUtCsXMcBquw==
X-Received: by 2002:a05:6512:12cb:b0:512:be57:6dcf with SMTP id p11-20020a05651212cb00b00512be576dcfmr1554566lfg.8.1708688811358;
        Fri, 23 Feb 2024 03:46:51 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id 11-20020ac25f0b000000b00512d180fd3asm1011694lfq.144.2024.02.23.03.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 03:46:50 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: roopa@nvidia.com,
	razor@blackwall.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	jiri@resnulli.us,
	ivecera@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 net-next 3/4] net: switchdev: Relay all replay messages through a central function
Date: Fri, 23 Feb 2024 12:44:52 +0100
Message-Id: <20240223114453.335809-4-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223114453.335809-1-tobias@waldekranz.com>
References: <20240223114453.335809-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

This will make it easier to add a tracepoint for all replay messages
later on.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 include/net/switchdev.h   |  3 +++
 net/bridge/br_switchdev.c | 10 +++++-----
 net/switchdev/switchdev.c | 18 ++++++++++++++++++
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 9bf387664e71..df4db720183f 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -340,6 +340,9 @@ int switchdev_port_obj_add(struct net_device *dev,
 int switchdev_port_obj_del(struct net_device *dev,
 			   const struct switchdev_obj *obj);
 
+int switchdev_call_replay(struct notifier_block *nb, unsigned long type,
+			  struct switchdev_notifier_info *info);
+
 int register_switchdev_notifier(struct notifier_block *nb);
 int unregister_switchdev_notifier(struct notifier_block *nb);
 int call_switchdev_notifiers(unsigned long val, struct net_device *dev,
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 7b41ee8740cb..cc9ed7f6bf1c 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -306,7 +306,7 @@ br_switchdev_fdb_replay_one(struct net_bridge *br, struct notifier_block *nb,
 
 	br_switchdev_fdb_populate(br, &item, fdb, ctx);
 
-	err = nb->notifier_call(nb, action, &item);
+	err = switchdev_call_replay(nb, action, &item.info);
 	return notifier_to_errno(err);
 }
 
@@ -376,8 +376,8 @@ static int br_switchdev_vlan_attr_replay(struct net_device *br_dev,
 			attr.u.vlan_msti.vid = v->vid;
 			attr.u.vlan_msti.msti = v->msti;
 
-			err = nb->notifier_call(nb, SWITCHDEV_PORT_ATTR_SET,
-						&attr_info);
+			err = switchdev_call_replay(nb, SWITCHDEV_PORT_ATTR_SET,
+						    &attr_info.info);
 			err = notifier_to_errno(err);
 			if (err)
 				return err;
@@ -404,7 +404,7 @@ br_switchdev_vlan_replay_one(struct notifier_block *nb,
 	};
 	int err;
 
-	err = nb->notifier_call(nb, action, &obj_info);
+	err = switchdev_call_replay(nb, action, &obj_info.info);
 	return notifier_to_errno(err);
 }
 
@@ -590,7 +590,7 @@ br_switchdev_mdb_replay_one(struct notifier_block *nb, struct net_device *dev,
 	};
 	int err;
 
-	err = nb->notifier_call(nb, action, &obj_info);
+	err = switchdev_call_replay(nb, action, &obj_info.info);
 	return notifier_to_errno(err);
 }
 
diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index c9189a970eec..f73249269a87 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -380,6 +380,24 @@ bool switchdev_port_obj_act_is_deferred(struct net_device *dev,
 }
 EXPORT_SYMBOL_GPL(switchdev_port_obj_act_is_deferred);
 
+/**
+ *	switchdev_call_replay - Replay switchdev message to driver
+ *
+ *	@nb: notifier block to send the message to
+ *	@type: value passed unmodified to notifier function
+ *	@info: notifier information data
+ *
+ *	Called by a bridge, in a response to a replay request
+ *	initiated by a port that is either attaching to, or detaching
+ *	from, that bridge.
+ */
+int switchdev_call_replay(struct notifier_block *nb, unsigned long type,
+			  struct switchdev_notifier_info *info)
+{
+	return nb->notifier_call(nb, type, info);
+}
+EXPORT_SYMBOL_GPL(switchdev_call_replay);
+
 static ATOMIC_NOTIFIER_HEAD(switchdev_notif_chain);
 static BLOCKING_NOTIFIER_HEAD(switchdev_blocking_notif_chain);
 
-- 
2.34.1


