Return-Path: <netdev+bounces-67548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 484C9843FA8
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 13:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D469B23158
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 12:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066997AE50;
	Wed, 31 Jan 2024 12:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="dorngAuD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C117B3D2
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 12:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706705420; cv=none; b=Yf0ClVf+zTB29wMuAWFl8qITROlDwHdUmyGAQfphqeDzRaRVC5gdwO/iuikal13/sH89Bh1/xQbl52yJUHZwmTmoFhhFcS0+ywIi57cKNVoKdqRAF7Kbvms670PtCRemFhcT0wF5vranGfJKaANRk1dCLvrB3gqWqrn1MyG3Sos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706705420; c=relaxed/simple;
	bh=vdC/28mZ3AO42VX/8yIFFv1FKGdt7O1G/wt/UiG81Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V16BR1lOg45qN6bj1vIEIEu28VUUZtNNjIfPELM8TIruKozUDAlD8poGDsoOV+pvFbZbg27A3HsPMMP6h46DpwnujGkS/Ke6JnxUGINJ+jRL54kiQ29qZZGtpZpqgKl/loksbWs/ZjUyZcDJTQdTpfKJl3za3JQxhHBIQRO4Njk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=dorngAuD; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-33aea66a31cso1991519f8f.1
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 04:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706705416; x=1707310216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rQN5M7XVgkAAlALJa5Q7p1kEHiTu8VHYsO5MNF4mfto=;
        b=dorngAuDtGQ2j/wicCrDs2AVFANBgj7Q7jn5owa4sOptdRyQ1y1FVx45QRUH9pcdwe
         5Kl90GmXa5CaAtvUxe+AeDxMZRnN9kSMJf4GUneVzczL8M1Hp5dVqUy93UKI2rqFnr4/
         5coacJ/WxTdgUxL8KzC4n2JFo8FnUoGXytfZWJLoK4J5jkzZCKo8CQuX23Q9hyF49A/6
         GgDeEraAgM9ZMAUkQHDr8EvSitf3L4xDwVl+k6bSeP3gna8QLkyJra0fOZ6cLsg32EcA
         EbQumQkYByrLG8AINx0ICH3Y3nkcr3t/YN8hdZy2RwVbvl86DnarTaCrcyEg9pJ6ZAhk
         qxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706705416; x=1707310216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQN5M7XVgkAAlALJa5Q7p1kEHiTu8VHYsO5MNF4mfto=;
        b=AAWLs/6wUDQqJADwDxspnOnKtaVrbuttlksghDA6lbhcqQoOOV6/c9kdyQ1dWna85z
         /OnGWjgbTZ2XACIPVWITY2NPjubsZzMEzR9nSmTB+uA8pDsJctu/OhHafmod47r4vvMD
         9LyNRLeLmo5RkbkiWFKK6HvEvrT798sbQG/UNbQnsvJJmYSv5NYALNVjLv/XA4l96WBo
         g78U2Yo6Hy/r1YBrcvRrj2jSeHdw5qXsvqyk5MDCTurOCdZ/H0lwBingyXyMYpOTauWB
         oLUV/NeK4+Inzo8pA1JDqU44TUqtfrnISOy+Y1BRiDhUaAZ4i9jAi/qBOMzjfBykkFgF
         yn9w==
X-Gm-Message-State: AOJu0YxyMapJVmPxsYOOAWf40BsJ7/1RT7CTZs6pvOS1seGg8KiW/49y
	wwhvTYPtxlawobzwYkY0NOq2A6ZtOqgwibtsWhFpy5SD+fg9a91fM3+55UXnsCU=
X-Google-Smtp-Source: AGHT+IFxwTSaLVQj11Ax8Y9mO3ewQhvQoZSge3oeqveK0qDfAQJWX/w7EDrxTM4pIC7nXM96e+FuMw==
X-Received: by 2002:a5d:4dc9:0:b0:33b:1ff:f677 with SMTP id f9-20020a5d4dc9000000b0033b01fff677mr1177987wru.50.1706705415592;
        Wed, 31 Jan 2024 04:50:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVgrdks3MpfUEXYPHYxb76540xWWRviMQVg/CADGI0aAbYJNF8/c+u/kMzw0vkuszrkIhLd5LpxBvdUdsyu9Wvr47UTTEOAI9RgXQAJ86wmCDbdQkhrLlfw6TMwPnBebzr0T/D0DLEyWDvbCdAD4yFhhgLhCuhLLYApjni5AP/xXYL/KhufBQS2AONxW7spFcnaWJrmDeFe5naHACbXPwSaBxClkoQOrHXJ4wz0a93LMzDBxUGvrND1/Qw7DQFt1Fzb3K9b2daz5YQi7jK7CMA=
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id cx16-20020a056000093000b00337d5cd0d8asm13335210wrb.90.2024.01.31.04.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 04:50:15 -0800 (PST)
Date: Wed, 31 Jan 2024 13:50:11 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, olteanv@gmail.com,
	roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
	netdev@vger.kernel.org, ivecera@redhat.com
Subject: Re: [PATCH net 1/2] net: switchdev: Add helper to check if an object
 event is pending
Message-ID: <ZbpCA3kgoCKsdQ4J@nanopsycho>
References: <20240131123544.462597-1-tobias@waldekranz.com>
 <20240131123544.462597-2-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131123544.462597-2-tobias@waldekranz.com>

Wed, Jan 31, 2024 at 01:35:43PM CET, tobias@waldekranz.com wrote:
>When adding/removing a port to/from a bridge, the port must be brought
>up to speed with the current state of the bridge. This is done by
>replaying all relevant events, directly to the port in question.

Could you please use the imperative mood in your patch descriptions?
That way, it is much easier to understand what is the current state of
things and what you are actually changing.

https://www.kernel.org/doc/html/v6.7/process/submitting-patches.html#describe-your-changes

While at it, could you also fix your cover letter so the reader can
actually tell what's the current state and what the patchset is doing?

pw-bot: cr


>
>In some situations, specifically when replaying the MDB, this process
>may race against new events that are generated concurrently. So the
>bridge must ensure that the event is not already pending on the
>deferred queue. switchdev_port_obj_is_deferred answers this question.
>
>Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>---
> include/net/switchdev.h   |  3 ++
> net/switchdev/switchdev.c | 61 +++++++++++++++++++++++++++++++++++++++
> 2 files changed, 64 insertions(+)
>
>diff --git a/include/net/switchdev.h b/include/net/switchdev.h
>index a43062d4c734..538851a93d9e 100644
>--- a/include/net/switchdev.h
>+++ b/include/net/switchdev.h
>@@ -308,6 +308,9 @@ void switchdev_deferred_process(void);
> int switchdev_port_attr_set(struct net_device *dev,
> 			    const struct switchdev_attr *attr,
> 			    struct netlink_ext_ack *extack);
>+bool switchdev_port_obj_is_deferred(struct net_device *dev,
>+				    enum switchdev_notifier_type nt,
>+				    const struct switchdev_obj *obj);
> int switchdev_port_obj_add(struct net_device *dev,
> 			   const struct switchdev_obj *obj,
> 			   struct netlink_ext_ack *extack);
>diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
>index 5b045284849e..40bb17c7fdbf 100644
>--- a/net/switchdev/switchdev.c
>+++ b/net/switchdev/switchdev.c
>@@ -19,6 +19,35 @@
> #include <linux/rtnetlink.h>
> #include <net/switchdev.h>
> 
>+static bool switchdev_obj_eq(const struct switchdev_obj *a,
>+			     const struct switchdev_obj *b)
>+{
>+	const struct switchdev_obj_port_vlan *va, *vb;
>+	const struct switchdev_obj_port_mdb *ma, *mb;
>+
>+	if (a->id != b->id || a->orig_dev != b->orig_dev)
>+		return false;
>+
>+	switch (a->id) {
>+	case SWITCHDEV_OBJ_ID_PORT_VLAN:
>+		va = SWITCHDEV_OBJ_PORT_VLAN(a);
>+		vb = SWITCHDEV_OBJ_PORT_VLAN(b);
>+		return va->flags == vb->flags &&
>+			va->vid == vb->vid &&
>+			va->changed == vb->changed;
>+	case SWITCHDEV_OBJ_ID_PORT_MDB:
>+	case SWITCHDEV_OBJ_ID_HOST_MDB:
>+		ma = SWITCHDEV_OBJ_PORT_MDB(a);
>+		mb = SWITCHDEV_OBJ_PORT_MDB(b);
>+		return ma->vid == mb->vid &&
>+			!memcmp(ma->addr, mb->addr, sizeof(ma->addr));
>+	default:
>+		break;
>+	}
>+
>+	BUG();
>+}
>+
> static LIST_HEAD(deferred);
> static DEFINE_SPINLOCK(deferred_lock);
> 
>@@ -307,6 +336,38 @@ int switchdev_port_obj_del(struct net_device *dev,
> }
> EXPORT_SYMBOL_GPL(switchdev_port_obj_del);
> 
>+bool switchdev_port_obj_is_deferred(struct net_device *dev,
>+				    enum switchdev_notifier_type nt,
>+				    const struct switchdev_obj *obj)
>+{
>+	struct switchdev_deferred_item *dfitem;
>+	bool found = false;
>+
>+	ASSERT_RTNL();
>+
>+	spin_lock_bh(&deferred_lock);
>+
>+	list_for_each_entry(dfitem, &deferred, list) {
>+		if (dfitem->dev != dev)
>+			continue;
>+
>+		if ((dfitem->func == switchdev_port_obj_add_deferred &&
>+		     nt == SWITCHDEV_PORT_OBJ_ADD) ||
>+		    (dfitem->func == switchdev_port_obj_del_deferred &&
>+		     nt == SWITCHDEV_PORT_OBJ_DEL)) {
>+			if (switchdev_obj_eq((const void *)dfitem->data, obj)) {
>+				found = true;
>+				break;
>+			}
>+		}
>+	}
>+
>+	spin_unlock_bh(&deferred_lock);
>+
>+	return found;
>+}
>+EXPORT_SYMBOL_GPL(switchdev_port_obj_is_deferred);
>+
> static ATOMIC_NOTIFIER_HEAD(switchdev_notif_chain);
> static BLOCKING_NOTIFIER_HEAD(switchdev_blocking_notif_chain);
> 
>-- 
>2.34.1
>

