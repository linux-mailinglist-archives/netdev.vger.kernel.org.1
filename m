Return-Path: <netdev+bounces-73944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B511C85F61E
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 11:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 699F9287A3A
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 10:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15DF46B9A;
	Thu, 22 Feb 2024 10:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K1K6fESd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2534778C
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 10:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599046; cv=none; b=FgJIxQdOzpERJCHyXEdE3tP3nICBmaR9phD7S7/1rRbiB9lwtdVtblcP4avliuwTFKROVjXq40cyZ45tgpXzYQdh8WVveRYuOD/bNuKaB9GQerpUdPtlnShE8CYo84TN5iYUv759jQDVf77SsITEvJ6357eULhXlJ0f3EDOz+Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599046; c=relaxed/simple;
	bh=VglDODfgTuLREY6IzJg2Hlr5JPXnqGFag1GN5Ss7wKk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uN59STrsuR8LUEMEWHP8hHeI/mZv9KMOh8J5JI1jgj52O8m698hxGeDX8LHGC+FtA/eygdflbsuOCLnIqdbSPyUXdthKvpUKVq5/KUvxqidWSUkG/XutrW6VsWqHkzI+k6cIbsveexSYT8cTcjACxyHxtOkipxNn1qtaE7M5SZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K1K6fESd; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608835a1febso31531497b3.2
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 02:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708599044; x=1709203844; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ekIED0L9mzs+tfyZQFf1JodivwiLa0Xf5K0keSbJ/3U=;
        b=K1K6fESdNM1f7ez6z4oMftdiyw1yItz9PGkaPLziVdlhMEmk4qJ6qdbuMr6LgSoy8U
         Ue6zIOWE/7W5+Fe5CO/e7Vhr3AhGQLuNMDlyCmsh9ZNbyf74zhROmO2tln7uzHtige+K
         J+9b4nJUNGg+R49BxWTHXr9xbtoMG3uoTBoEXbklT/MrOyig+ofOgFYfFNf3GE8ez8lb
         1MXd7cEKin9+1WQRQfMIEFx28PDGPoWUas7sY6ijzFzxSLT6aRWYpYpUcSzWWipQzPln
         3CkxmSm25+Xv3lNxLrxFPuNz+x8NVQMA6ICcMk1pRWCATEUBcWUPHJthVdE2hw3lPfPY
         RIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708599044; x=1709203844;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ekIED0L9mzs+tfyZQFf1JodivwiLa0Xf5K0keSbJ/3U=;
        b=HBqWCVqSg9mdO0onn8WRX2zqZktSzZiawCliXmjbi0VErDs9i8HRRTuuvdBUWj9PlI
         nFW1rWkfLKOpVtKey8XgNxPmpivfnfaKpCVYVAiyd6yIEuMW+zaC8PGPgFOnUz0aeOlQ
         s4rVavdp1vJtVVBnJ6w9WnauNePWS0g9/pYuNQK9+NSgRp94Dx+rwgERaoopQnlThS9T
         rJQkmozOGZHVpb+aV+Tsh/LUQaphyOXRTa8vJ7g93/LouLREyBw5fK9exUkIVhJI6Ll4
         wzBmJe4a03gdr283m9e1upvC1ppve6iQijyD5ugDbVPH4JiMZ2MAyGkzjz16o41/otiO
         JBVw==
X-Gm-Message-State: AOJu0Yz2bzTz5oaK32TL4wohnIINhuuSI1w6TZGyJdEkle4sPbtDFDZG
	orJIInnAv7iRzwKxhMHMPUc4TjNnxUaQiIJtMnsvJo5R/iiJSvWCkz7Jis1noCMZW041YVbsRKl
	uO+t1W1Oz5A==
X-Google-Smtp-Source: AGHT+IHFM8irej62sYOIi/Rg1arSySLzvYhRYIM5b9hyFrOMO8ZAO6sI2sgwNci1e5Kn0nIAdC1jSoiN4Ct9hw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:11:b0:608:c2c:30a9 with SMTP id
 bc17-20020a05690c001100b006080c2c30a9mr3930113ywb.0.1708599044413; Thu, 22
 Feb 2024 02:50:44 -0800 (PST)
Date: Thu, 22 Feb 2024 10:50:20 +0000
In-Reply-To: <20240222105021.1943116-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240222105021.1943116-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240222105021.1943116-14-edumazet@google.com>
Subject: [PATCH v2 net-next 13/14] rtnetlink: make rtnl_fill_link_ifmap() RCU ready
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use READ_ONCE() to read the following device fields:

	dev->mem_start
	dev->mem_end
	dev->base_addr
	dev->irq
	dev->dma
	dev->if_port

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/rtnetlink.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 1b26dfa5668d22fb2e30ceefbf143e98df13ae29..2d83ab76a3c95c3200016a404e740bb058f23ada 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1455,17 +1455,18 @@ static noinline_for_stack int rtnl_fill_vf(struct sk_buff *skb,
 	return 0;
 }
 
-static int rtnl_fill_link_ifmap(struct sk_buff *skb, struct net_device *dev)
+static int rtnl_fill_link_ifmap(struct sk_buff *skb,
+				const struct net_device *dev)
 {
 	struct rtnl_link_ifmap map;
 
 	memset(&map, 0, sizeof(map));
-	map.mem_start   = dev->mem_start;
-	map.mem_end     = dev->mem_end;
-	map.base_addr   = dev->base_addr;
-	map.irq         = dev->irq;
-	map.dma         = dev->dma;
-	map.port        = dev->if_port;
+	map.mem_start = READ_ONCE(dev->mem_start);
+	map.mem_end   = READ_ONCE(dev->mem_end);
+	map.base_addr = READ_ONCE(dev->base_addr);
+	map.irq       = READ_ONCE(dev->irq);
+	map.dma       = READ_ONCE(dev->dma);
+	map.port      = READ_ONCE(dev->if_port);
 
 	if (nla_put_64bit(skb, IFLA_MAP, sizeof(map), &map, IFLA_PAD))
 		return -EMSGSIZE;
@@ -1875,9 +1876,6 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 			goto nla_put_failure;
 	}
 
-	if (rtnl_fill_link_ifmap(skb, dev))
-		goto nla_put_failure;
-
 	if (dev->addr_len) {
 		if (nla_put(skb, IFLA_ADDRESS, dev->addr_len, dev->dev_addr) ||
 		    nla_put(skb, IFLA_BROADCAST, dev->addr_len, dev->broadcast))
@@ -1927,6 +1925,9 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
 	rcu_read_lock();
 	if (rtnl_fill_link_af(skb, dev, ext_filter_mask))
 		goto nla_put_failure_rcu;
+	if (rtnl_fill_link_ifmap(skb, dev))
+		goto nla_put_failure_rcu;
+
 	rcu_read_unlock();
 
 	if (rtnl_fill_prop_list(skb, dev))
-- 
2.44.0.rc1.240.g4c46232300-goog


