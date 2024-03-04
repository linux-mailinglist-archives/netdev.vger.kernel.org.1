Return-Path: <netdev+bounces-77132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 235C48704DE
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 16:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83167286C2C
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 15:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020874653A;
	Mon,  4 Mar 2024 15:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="R5HF2NMf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E2D4654D
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564946; cv=none; b=PIoz3H9xmO/HIcd2NCBrVmfpLsOU0GLKRyonPOwq+bddPl1eUysqxZxYfhTfeLL3WMqrWNMSgzzXhZirMJMyBmZyZb331YH20lwP13rH08w38vBtGgIZrQMxCHdYibg10GUvAS2D85Ek7os7kwXfMZ6z5kbujmehszP+CqSRbDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564946; c=relaxed/simple;
	bh=IQbjttEnQ74THMeTgztW0WK55rT481MYtB8mN5uEavU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnJWevC9A8ZuTk9779vtdP8T/5d9arqXSYeLP7mjwMRHmgLISYP3nSlwXa3YslnsLI2YmLCVFiY6b0AaiHNKRuFKO1lv8wphVNvkQ02mNW+qLUnzNN1kl2TH/ts2rlI0QG6YN3BaW2+o5K+EhL2IBJ0O1kTF6pbiTxdnwCEOWxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=R5HF2NMf; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a458850dbddso42531066b.0
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 07:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709564943; x=1710169743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0eFZtQnqKAOEuLVPNzsXHze3ou9h+U9TU2yz4F8kR4=;
        b=R5HF2NMfKj1MZ7olzRB9OdmKnZ7O/JsvJ0iczwMYwIte7jDcoEjEAlFkGK8yCJ/F9s
         350zcFtGVglkZ9IKtflDs/guUPIVk5o2huBgYE4siCzFlPQHXsyDkpaLW4p3G1EXup32
         d6hFcQwl4gBDJPTbGHEuymyJisqQYomli1dufW+inGu3XjpGvpOjVYsMeble0An3LSIY
         GqUVAHoK7bldRN0GvRDny8AsFnXvxjKmFnrygBjCh/NHUEPhhXTNFaHrhBONPPYNi9DC
         9dPkSHEGRU+oc+I0Ir/+X7g2uGuieEy618UizDAPYNqo9JFxlnCagSlTSpNMeN65aizB
         Y+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709564943; x=1710169743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0eFZtQnqKAOEuLVPNzsXHze3ou9h+U9TU2yz4F8kR4=;
        b=vwvVaPr03Lhp7cqQnWM8Xjo47u6l8eEZ7RzlqIAxNjEZu3M16pXCC8lDG0UPgcU4wx
         pTrnItow5zO4Tisen4zQLnJh5q/zN75GoGnk1tsUiPIXj0ygEsq/T1MUKwE4RKAz/uVw
         bjNrak7HEbECaSzcVxLetjAyMnWfYX1Gidt9vLEf5sZoy9hgNZWjV7y4LdfKQzb7o5nX
         MA+/LSGZUHKOLjf1PVYLvrmfu0x6pozdVJc/2eloJiyRe9V/lsm+etp7LO5wve/Do37R
         JCVcds1u5V94UWixWlqTqIUj+1JGoTsh2PkC7MGcSpggu1n7EmIEXUN0C0ZCwuBzS3N6
         +06Q==
X-Gm-Message-State: AOJu0YwyYvVMB8emXZEikz4XqFOtz8bcioG9EUrVzM4HZaaFeVv8XHD2
	NqN3Rf7gUBl6eLu8UsB4V8Z3AAyvFNs5FP7zWg1gRImiL7/Up5uI5RWMzAEHtR/ZPUgjr0A/EJK
	zmaQ=
X-Google-Smtp-Source: AGHT+IHy8hAn+Ks42LYGNRCIAzDZIFucreTlfxWzhl1sckBYfqExMh1O0RHNP3Dm7X/tmlZ//3RAKA==
X-Received: by 2002:a17:906:50c:b0:a44:deba:2e6 with SMTP id j12-20020a170906050c00b00a44deba02e6mr4215357eja.36.1709564942931;
        Mon, 04 Mar 2024 07:09:02 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:0:1d25:beac:2343:34ef])
        by smtp.gmail.com with ESMTPSA id um9-20020a170906cf8900b00a44d01aff81sm2904069ejb.97.2024.03.04.07.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 07:09:02 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v2 05/22] ovpn: implement interface creation/destruction via netlink
Date: Mon,  4 Mar 2024 16:08:56 +0100
Message-ID: <20240304150914.11444-6-antonio@openvpn.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240304150914.11444-1-antonio@openvpn.net>
References: <20240304150914.11444-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow userspace to create and destroy an interface using netlink
commands.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/netlink.c | 50 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index 2e855ce145e7..02b41034f615 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -154,7 +154,57 @@ static void ovpn_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb
 		dev_put(ovpn->dev);
 }
 
+static int ovpn_nl_new_iface(struct sk_buff *skb, struct genl_info *info)
+{
+	enum ovpn_mode mode = OVPN_MODE_P2P;
+	struct net_device *dev;
+	char *ifname;
+	int ret;
+
+	if (!info->attrs[OVPN_A_IFNAME])
+		return -EINVAL;
+
+	ifname = nla_data(info->attrs[OVPN_A_IFNAME]);
+
+	if (info->attrs[OVPN_A_MODE]) {
+		mode = nla_get_u8(info->attrs[OVPN_A_MODE]);
+		netdev_dbg(dev, "%s: setting device (%s) mode: %u\n", __func__, ifname,
+			   mode);
+	}
+
+	ret = ovpn_iface_create(ifname, mode, genl_info_net(info));
+	if (ret < 0)
+		netdev_dbg(dev, "error while creating interface %s: %d\n", ifname, ret);
+
+	return ret;
+}
+
+static int ovpn_nl_del_iface(struct sk_buff *skb, struct genl_info *info)
+{
+	struct ovpn_struct *ovpn = info->user_ptr[0];
+
+	rtnl_lock();
+	ovpn_iface_destruct(ovpn, true);
+	dev_put(ovpn->dev);
+	rtnl_unlock();
+
+	/* we set the user_ptr to NULL to prevent post_doit from releasing it again */
+	info->user_ptr[0] = NULL;
+
+	return 0;
+}
+
 static const struct genl_small_ops ovpn_nl_ops[] = {
+	{
+		.cmd = OVPN_CMD_NEW_IFACE,
+		.flags = GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+		.doit = ovpn_nl_new_iface,
+	},
+	{
+		.cmd = OVPN_CMD_DEL_IFACE,
+		.flags = GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+		.doit = ovpn_nl_del_iface,
+	},
 };
 
 static struct genl_family ovpn_nl_family __ro_after_init = {
-- 
2.43.0


