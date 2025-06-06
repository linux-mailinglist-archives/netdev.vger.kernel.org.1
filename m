Return-Path: <netdev+bounces-195356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 093BEACFDB2
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 09:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB836178990
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 07:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAC327A462;
	Fri,  6 Jun 2025 07:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="LpszYZbg"
X-Original-To: netdev@vger.kernel.org
Received: from forward201d.mail.yandex.net (forward201d.mail.yandex.net [178.154.239.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5700283FE0
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 07:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749196047; cv=none; b=Oqar4jkSltOR368vZ+JIOFY5TJ/V+LUDazpU5hOjHkPBFwp1dF35uUxM9wVJQZx1wmJscnxyIHMttz+ySGHsAE4secYhHO1weOCxHGtTT13WURsOxZ9x3zlQ5yyjer2z2SqBVuqXh/gsxCLfS8/XqC6XpcfXevYnks2XPrD6NVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749196047; c=relaxed/simple;
	bh=0npsLd/6pFeEZup/Yh3eJaGZUNzviGnNc7rt69TQhiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZNsRQFP80Z3KQyJ9OS5RmgqVfo3jknHQgzmyTUmXv7ZV43CNelchEDscufa5SAahPZGzGwaCbp/PcO4ZFwxo4WxZ5EEDsCQltsBZkjG99f0Swh9eS4RLtZUm6B1GA9zQLyrKWECpue/C//mDxGK+Bmd7HDiuHdCdylsqSykYmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=LpszYZbg; arc=none smtp.client-ip=178.154.239.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d101])
	by forward201d.mail.yandex.net (Yandex) with ESMTPS id 7C03A64A1D
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 10:41:16 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:c122:0:640:3648:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id 49CE560C13;
	Fri,  6 Jun 2025 10:41:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 7fYNPgtLhiE0-dfj2Qw25;
	Fri, 06 Jun 2025 10:41:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1749195668; bh=cSKubfbGT1GLAXRbLdQih6MQJBQ/UfRuwYW3g6Ku7yQ=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=LpszYZbgwmmnKnlMptTJiWtoqof/1ArtpD5L7sxkOLFmgk3ArW6Tu4sZafyR4j7zN
	 pspAWk1FyHXC2Kr2dasor+W10Bgu/l33CjkkaBSMnVwwmUU7aGqQcVpK+4VD9Y4Huu
	 sGRclTObAWoKBeyy+AkoQIKlC7+g3P/OUTfu48os=
Authentication-Results: mail-nwsmtp-smtp-production-main-76.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] netlink: avoid extra pskb_expand_head() in netlink_trim()
Date: Fri,  6 Jun 2025 10:41:05 +0300
Message-ID: <20250606074105.1382899-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606074105.1382899-1-dmantipov@yandex.ru>
References: <20250606074105.1382899-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When 'netlink_trim()' processes shared skb, using 'skb_clone()' with
following 'pskb_expand_head()' looks suboptimal, and it's expected to
be a bit faster to do 'skb_copy_expand()' with desired tailroom instead.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/netlink/af_netlink.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index e8972a857e51..efb360433339 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1285,11 +1285,15 @@ static struct sk_buff *netlink_trim(struct sk_buff *skb, gfp_t allocation)
 		return skb;
 
 	if (skb_shared(skb)) {
-		struct sk_buff *nskb = skb_clone(skb, allocation);
+		struct sk_buff *nskb;
+
+		nskb = skb_copy_expand(skb, skb_headroom(skb),
+				       skb_tailroom(skb) - delta,
+				       allocation);
 		if (!nskb)
 			return skb;
 		consume_skb(skb);
-		skb = nskb;
+		return nskb;
 	}
 
 	pskb_expand_head(skb, 0, -delta,
-- 
2.49.0


