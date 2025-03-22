Return-Path: <netdev+bounces-176916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C223FA6CADD
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 15:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A9DC7B0405
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 14:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C8C221738;
	Sat, 22 Mar 2025 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b="lfFIyEI0"
X-Original-To: netdev@vger.kernel.org
Received: from forward204a.mail.yandex.net (forward204a.mail.yandex.net [178.154.239.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54E5234966;
	Sat, 22 Mar 2025 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742654715; cv=none; b=f0zOOCYA3o0qvTCIzE6nGBVGji+gJibqraBCICsj+GzMo3G6bU+OKE/+uZmH3EB4ZeJ5oAn8cdJYpeLQTGWIa1nhj6mlzhsghD2L2VhnFzpSZgy9PYNUmuWSjeGSeMBa8Dt13ZxHBDQq51NkQWO89b3C/xBQ3iSX3b3stYhSgRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742654715; c=relaxed/simple;
	bh=r83oXkDwjm6cPhBNItb7W87iX4UWsgDCb65xZ/iP1tI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pkJRM46YToBh+h9t6PC4cztQPsDnAgQm7abC9GrfVHqXDCc1l8ASoqcAd1sW+g/7a9myuw3ZROpaV+4KMWUPsK6bKB2hLESKHgPvDJNDliKrB7XlBhFQlTl+VTu1rsV/beelKf7eDB1sp7rjTrJQcb3AuctLDkU/iqO9T06gf9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru; spf=pass smtp.mailfrom=ya.ru; dkim=pass (1024-bit key) header.d=ya.ru header.i=@ya.ru header.b=lfFIyEI0; arc=none smtp.client-ip=178.154.239.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ya.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ya.ru
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
	by forward204a.mail.yandex.net (Yandex) with ESMTPS id 256C1668EA;
	Sat, 22 Mar 2025 17:38:18 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:1a98:0:640:f7e1:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id 3998060D40;
	Sat, 22 Mar 2025 17:38:10 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 8cNgSTXLe0U0-UE0nrEQU;
	Sat, 22 Mar 2025 17:38:09 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
	t=1742654289; bh=/AcLQT1UDMkihd8CbkVJcYZwUKXPIgVgM64Mf44dsTI=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=lfFIyEI0KnbUUPmC5B2ivgdRB98Vkeo0ABGODrhzp/99Aq51atJFL6L/FIlp8HfbL
	 U7eO+aCS03371xEqvxsrxA7IXVPhIrMzp1BjVVaA0c7/E14Hl6VtNfzxjALXz+68sV
	 V47Zje3IjcwgW0k6yQFAylV692Z0PGgehtvfpt+I=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net; dkim=pass header.i=@ya.ru
From: Kirill Tkhai <tkhai@ya.ru>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tkhai@ya.ru
Subject: [PATCH NET-PREV 02/51] net: Add nlaattr check to rtnl_link_get_net_capable()
Date: Sat, 22 Mar 2025 17:38:08 +0300
Message-ID: <174265428803.356712.5393035417908731217.stgit@pro.pro>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <174265415457.356712.10472727127735290090.stgit@pro.pro>
References: <174265415457.356712.10472727127735290090.stgit@pro.pro>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The patch is preparation in rtnetlink code for using nd_lock.
This is a step to move dereference of tb[IFLA_MASTER] up
to where main dev is dereferenced by ifi_index.

Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
---
 net/core/rtnetlink.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index b33a7e86c534..34e35b81cfa6 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2363,6 +2363,9 @@ static struct net *rtnl_link_get_net_capable(const struct sk_buff *skb,
 {
 	struct net *net;
 
+	if (!tb[IFLA_NET_NS_PID] && !tb[IFLA_NET_NS_FD] && !tb[IFLA_TARGET_NETNSID])
+		return NULL;
+
 	net = rtnl_link_get_net_by_nlattr(src_net, tb);
 	if (IS_ERR(net))
 		return net;
@@ -3480,6 +3483,7 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	dest_net = rtnl_link_get_net_capable(skb, net, tb, CAP_NET_ADMIN);
 	if (IS_ERR(dest_net))
 		return PTR_ERR(dest_net);
+	dest_net = dest_net ? : get_net(net);
 
 	if (tb[IFLA_LINK_NETNSID]) {
 		int id = nla_get_s32(tb[IFLA_LINK_NETNSID]);


