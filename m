Return-Path: <netdev+bounces-70972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9E38516B6
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 15:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95A4E1F239C7
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 14:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBF53F9E5;
	Mon, 12 Feb 2024 14:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0vPRQ35+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2ED3BB3F
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707746827; cv=none; b=QCohCjoeRfgt5Fmew6Q+i3oCPe3FIiqSCw2XX6Pve2kcFwyveR706iNgHS1lhwgjDpj5OJvy9FJ03FrBchs/07ScI4+0XjY6qATHSfOTTDdMvSBbTBZsS0cxJKRZBXjGDM63xLnzRUStXhNFP7V2/t3hfl+XYlJssgLCdKg3LBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707746827; c=relaxed/simple;
	bh=IPqNqGIc8kIKoDZuU1paAFTTGFIg9Tc3BbfdBLZUdxc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MJtRvo54w9XBR952Tlicjl8P4cbeYrlKRG1ZzT81xSe22EXxhyyzyzHCwm3tJvIYiBnFN0yV0ziqFSwotE0My0nDbfdrVxjEvD7U7KLvalQsWQG3Ui4CSng0zTLnjGbt8EzZ5PEQp832N8uZH0PCYrjBoDw/NKUd7UMwxjjAMes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0vPRQ35+; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcbee93a3e1so133050276.3
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 06:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707746825; x=1708351625; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tELwppBIAZGg+qWDuApk3XWWBWnxW0NyEosDkAQoZ0E=;
        b=0vPRQ35+ma8WZKo/3ly+tv61JYv+pnB4NMOf6wBY3d4BWhtd9tEtv8kCp0q2vWAN0M
         E3XnuYvDBnjPKqk5eTaMzFJT+MHWMJEMfUT1XdG7UCdKM5gfCM2SoNgBp+wD3gKplGhZ
         KJ/QFcIh4hvWJ+NZ5EqDL3Ksd85jlAAcagjiK42pbQTT9x9zDz4ctlUQ/4z3JF5gcszT
         Z3qTVJCyWPu4JHPRgUtnr9Wgi19/vfmAP1PXEhHNSC0A+2isxYEKNGzwzSIZPIQCATlZ
         0vdXKJeNSNL965SawhtNz705yUQiHoYythjWB07j8USQ3f+MSkf0EBwr+rlMjl9aoAmH
         e5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707746825; x=1708351625;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tELwppBIAZGg+qWDuApk3XWWBWnxW0NyEosDkAQoZ0E=;
        b=lSkACdUpmOFK2GEBqiL3k8HfhqCUILoGXZgnOZYpudztDGYapcC23qVaa70tSqt9dz
         Q4raAhqzJB6v4XxruXKnotUaAQzqze4Nzv4lDLcErXb9nv6xhMAl8SmmQOVHhE/SDzFP
         lS+w6TDj08jYy4Eqw5NCXwBViVZfo8hdAB248qPJ70l3AMugkd/neYn/dGehF5dpjw9Z
         NyOmNlU5qdhZpdk7I+8iVzggL+bGhMqD4l0NfNUbPgXJscu4HjdJV6t0z3RLf6qMbkEG
         KoNSS4eTOPawZ6OVYj9FD83ttfJLFtDTmIxI/ZTqozWkTfAH+YfRiZEzM8VoUlvn+zpu
         Rj6w==
X-Gm-Message-State: AOJu0Yz3Jgr4oUUq6Usj7CVr/whb1J9NGCBptqQxIeWzb6hIeLX2zowG
	KTThWeu2dp4D7CTSMF86KYhjuPL8OoqpeW2lW0sa3q9dXAoRO9+z5aDJ5+oZsVMsbAQwILG33X4
	Q7kdJXBMlkA==
X-Google-Smtp-Source: AGHT+IEXkr5LgzAb8Vg5R0kd4a/J0Gclnw+33bs2HrOoBTcwgMPY7mn7Ds1/N6/ajHJI2IlgzCe/nWSVFisSXA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:b13:b0:dc6:bd9f:b061 with SMTP
 id ch19-20020a0569020b1300b00dc6bd9fb061mr289509ybb.13.1707746825113; Mon, 12
 Feb 2024 06:07:05 -0800 (PST)
Date: Mon, 12 Feb 2024 14:06:59 +0000
In-Reply-To: <20240212140700.2795436-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212140700.2795436-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212140700.2795436-3-edumazet@google.com>
Subject: [PATCH net-next 2/3] net: bridge: use netdev_lockdep_set_classes()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

br_set_lockdep_class() is missing many details.
Use generic netdev_lockdep_set_classes() to not worry anymore.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/bridge/br_device.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 65cee0ad3c1b6d90e644abce0a53de7b4657121a..717e9750614cdbb68b612688d94ffcd62fb929b7 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -108,13 +108,6 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
-static struct lock_class_key bridge_netdev_addr_lock_key;
-
-static void br_set_lockdep_class(struct net_device *dev)
-{
-	lockdep_set_class(&dev->addr_list_lock, &bridge_netdev_addr_lock_key);
-}
-
 static int br_dev_init(struct net_device *dev)
 {
 	struct net_bridge *br = netdev_priv(dev);
@@ -153,7 +146,7 @@ static int br_dev_init(struct net_device *dev)
 		br_fdb_hash_fini(br);
 	}
 
-	br_set_lockdep_class(dev);
+	netdev_lockdep_set_classes(dev);
 	return err;
 }
 
-- 
2.43.0.687.g38aa6559b0-goog


