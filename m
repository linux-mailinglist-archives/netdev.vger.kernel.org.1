Return-Path: <netdev+bounces-138061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A2C9ABB93
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 04:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87289283C80
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 02:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E47B762F7;
	Wed, 23 Oct 2024 02:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SH4k0FJj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD0C5FB8D
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 02:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729650736; cv=none; b=Dgdm+vR46lA7/0pnwv1ouPan07ZtXPmYJ0Zw5cZOUGe7KUFCOKEEUZVwO0Nzuqzil/OtRiv9cB9wrwoP1/j0j382gQ3xHLhHW2LVISri9mjOC30+D/FAf9gVXxItwb3Bq7W35tpL9tDAnVNXoS26WsW+0ry6Sa1i6HCOg58wpQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729650736; c=relaxed/simple;
	bh=fc2NOfta+FSn1SOHQi2N2meCboovslY0zPfdlwGpmp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kK+DqVVVGYLAw4ytkbN9YlZcsdZ51CZdFkeWE+mkQt9prsAJ2IEkZp+PC12UIsiHINVnG3adEaM5qxqC/EzCIxjOtVqMaCuAf43xUH+Bdya3FO6cmhp+jfD9SeIWs6ClNlvPPuu16zMaC9TZzp/LnP4YFhc9U1oNtEMraAcyhM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SH4k0FJj; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5ebc1af8f10so1313431eaf.2
        for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 19:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729650734; x=1730255534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aI6AWkQNI/okCcU8bkSh5OZLcAKrZZzAC/ATARuWBuI=;
        b=SH4k0FJjyDs1owIrMuiUJsspsLhC2M6W1lFvj/wAh+FZo9uFsM5kmA3M+hsdrgapX2
         yOKzMWLusucsjS3SfLLgvySbuT+o3D+foLASSgjpojoUBg5NGAIxYZJ8rdGOVCiw6Joq
         vQEcEtE6njg5joPVeWwRBpfUU61BenIwEcU5JiQf2jqu3cCaKXii5hQwlC7jt9lPZzmK
         kqAcjVtNtKCSkKJTpVSaOKLMVvkTmThABsNByAQAEv/sZg0pTvU3uOHxOj6GcFfgKx0V
         oAERqu7E78rMLnL+5E7AwsOw6dPs9mLwkk7O5DdmSjDRm2ze9CCvtwmtppl/jtGvumAe
         VjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729650734; x=1730255534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aI6AWkQNI/okCcU8bkSh5OZLcAKrZZzAC/ATARuWBuI=;
        b=W1cOBrJlFH3reYoSCsJUWOc0n1zsQA6D7QOLIzbUn3iHaHEGIFae/yndR+trRbUJGU
         Q4Sm5au87JXIqy22hol8cwJ1GXtL3lPQC/xjX62uAaQ89GW3qaq01G/nhZ0JD5A4s1f4
         c1tQatZE9ha/xygQ8GeJe+2oIyWZhHKUzy4xzrfl2jJiGiA7pOGbaSHfctNzkCNMe6Zt
         Ns/BfKZBL0DePKuq7q7FCRbThN/SonWFDgpbJIMS1MRRRv4m9dA1fTDjrWVsyoNrgsS+
         WFTII834q8XONyd1dlH/MwE5Hkzm6Fts2v3p+T40jFUvigC95yMSL1m3MccZQ6ICokrm
         K3DQ==
X-Gm-Message-State: AOJu0Yz4DZZFiVOXpUOp27R4BAx4GxW9Zck58otfF9ZzDmZAlEjToUpj
	JwOv4uBYDgQL2D1fWMYXRVEIgfhqW27Yt6LNHZKl4O6Fli1BbOPzn7LZpj2AkBk=
X-Google-Smtp-Source: AGHT+IH2P29vbbMfuRgBLG5crsf6VPpcy+ecoc2b1iEqq1lRrHU/7klqffQ5YntPOLxhcmlolHgn7A==
X-Received: by 2002:a05:6870:b409:b0:288:59d3:2a03 with SMTP id 586e51a60fabf-28ccb9f79cemr1331637fac.39.1729650734194;
        Tue, 22 Oct 2024 19:32:14 -0700 (PDT)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaea9386e5sm4972284a12.0.2024.10.22.19.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 19:32:12 -0700 (PDT)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 1/5] rtnetlink: Lookup device in target netns when creating link
Date: Wed, 23 Oct 2024 10:31:42 +0800
Message-ID: <20241023023146.372653-2-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241023023146.372653-1-shaw.leon@gmail.com>
References: <20241023023146.372653-1-shaw.leon@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When creating link, lookup for existing device in target net namespace
instead of current one.
For example, two links created by:

  # ip link add dummy1 type dummy
  # ip link add netns ns1 dummy1 type dummy

should have no conflict since they are in different namespaces.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/core/rtnetlink.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 194a81e5f608..ff8d25acfc00 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3733,20 +3733,24 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 {
 	struct nlattr ** const tb = tbs->tb;
 	struct net *net = sock_net(skb->sk);
+	struct net *device_net;
 	struct net_device *dev;
 	struct ifinfomsg *ifm;
 	bool link_specified;
 
+	/* When creating, lookup for existing device in target net namespace */
+	device_net = nlh->nlmsg_flags & NLM_F_CREATE ? tgt_net : net;
+
 	ifm = nlmsg_data(nlh);
 	if (ifm->ifi_index > 0) {
 		link_specified = true;
-		dev = __dev_get_by_index(net, ifm->ifi_index);
+		dev = __dev_get_by_index(device_net, ifm->ifi_index);
 	} else if (ifm->ifi_index < 0) {
 		NL_SET_ERR_MSG(extack, "ifindex can't be negative");
 		return -EINVAL;
 	} else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME]) {
 		link_specified = true;
-		dev = rtnl_dev_get(net, tb);
+		dev = rtnl_dev_get(device_net, tb);
 	} else {
 		link_specified = false;
 		dev = NULL;
-- 
2.47.0


