Return-Path: <netdev+bounces-198721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65043ADD4B6
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 18:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74800173980
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234192ED173;
	Tue, 17 Jun 2025 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="MibmGQ+Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f99.google.com (mail-ed1-f99.google.com [209.85.208.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448582F2345
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 16:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176111; cv=none; b=Bg1UvN8HATXpVA4doyMjY9ORIYmTQ7NRDI6M7i4cAuO/m9+s/fVTYvCEkx+ElKa+DPFuv0Lm34LNB0B5xmM+yZyoJUFauBvzeoVvTebptbRnAugWbfGMOmU05oD0mz1saKV+xlLoCZ2sSrzybQuQMB0m6AQA1DsHnJVBJQQMJLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176111; c=relaxed/simple;
	bh=9toDD7tmhalc4U5luIvrtKKyxtNLA3+RUnV6XemW4e4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pF/MyW27r4ck1AXqL30tg2HaaHSIKgzK6slmhoY0LLAJhnKyq2UcLCQtQLW7wVQi9zy2bzokaNDe8xnXwJqlIPqDN6WHXHur49nHIQNEGQsA3YDBL4QzncRbMgAjOnzxH8mniLWJkKb55mRy/AL4gHzkb4IEIN6zOHtD9fuWFxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=MibmGQ+Q; arc=none smtp.client-ip=209.85.208.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ed1-f99.google.com with SMTP id 4fb4d7f45d1cf-6070a8f99ffso840669a12.3
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 09:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1750176107; x=1750780907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WALP22qPaSmrlHrSd0ASkEUPW5PSB3MfUO3Tow5jPlY=;
        b=MibmGQ+Qu74LE0OzAGdGwlsJPtylbsVGf8JInMOpZvaAXW27/ro1GBFwc89zdxPb3T
         kBMU8O0ZlKYFm/lwdi3UekL3++ILNSaATNLkxqhnyfyw0tYNqGU170p9klnO0FIpFSVO
         /c3DmnLg9J7drI5DUwdg+lvLYK9zc/grgWkGHZ5bBRdz/Ot8w7mkKUgUmGHYmhDa/YCc
         R8uwrEgTaAR0xK76cRkaxym4iEPLWmVRWDhr1qt6rXGGJvxfqfT/CJECaitlmwpP4+33
         E4pxL5IVTz5IEXSqJKPQ2QoM32MK9y3IK5aEENJGVYW4gOQNbSA7kHiAqpCo4wQtGvWr
         SaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750176107; x=1750780907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WALP22qPaSmrlHrSd0ASkEUPW5PSB3MfUO3Tow5jPlY=;
        b=OCnMbwARopoyz5gqg0ZVt0I4QoHXdb+2Wkgj69wv1JezlNOoy4HFlquV3xPCP91ahM
         r/ALW45gfdszsznBjJLNB3wkBV2vBMvBVCfPuebHg2fb17it7vjVtw+MS2xVnOJ1K4XN
         t6TTwf5lBdFj41IlAy5L0EhpKjY2+xxjm9AMyNUe88l05OYw6qENIHEZw6v3qA7iuYmF
         c1Zd3YU6yqdw46YhPU+JBSGRRDcH7xK9Znv4pBch0KFi9hkTfhZf79dcqpercpgc+mZR
         tFH/lsHvvFRqEmAGmvQG9XVsJWuj9wUlkx+8U/mlBeQkOqU6OUFhpDtzHJv+vbEBkg9h
         mNgw==
X-Gm-Message-State: AOJu0Yyvl0DNHzh4ySR4NAaeDAXSa7VsdeENEMjTr1CplJCZTaPre6Vh
	FJAnIXTXMqrBJ82fwtAkRlslpMBBO4j5Wa/9aZO3TFjyn7o1JjmKT3wqKiY8BuT0EKKTtNUFV/C
	jdpdjg8gs7P4z8vM6b0uHFaYdztobW0YK8vfB
X-Gm-Gg: ASbGncuCFsftoOFqg+nNUMZROAdjG0/wrO+jfaVpleEFZtRg+zgwU+D5JtZCEYnbV7u
	PwgX8X9rwO77yYO42cgqvp3YNjpHpedNzKvPmmR5+G5JXvnkVNzmIJzkuNmqgFVNcQx3IRp345t
	vtVpM2LaZfo5YRi5G+M9vX4Uk7Nr2wMK4DgDZeVpwWhXKRkDJ/DiwucMUXwU9eJt8q7MzCksHuO
	WmN30GT9LBv7S869caiSe8T9nTS/Na8HAUL06KTqMrNrNDiDcq+eS97I1AqfEAlBgZiTFj9vXCl
	rq0H37cVJI56AFWcSwlgYCfdZ7XQOeoyReabWyCnLCSPauGOe9IVzh7Si6YSMdp0aa7MBE2SX/F
	5dA==
X-Google-Smtp-Source: AGHT+IGZ+YYeyAaS/UmytzZ4/0h0owiA91i4AAGrzla1ogNt8j4VSgXABaWm/O5pfhlp0PBoeyEYq4mIqAmN
X-Received: by 2002:a05:6402:3514:b0:600:ecab:a724 with SMTP id 4fb4d7f45d1cf-608d09447ccmr4130553a12.3.1750176104222;
        Tue, 17 Jun 2025 09:01:44 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 4fb4d7f45d1cf-608b49e105asm389643a12.29.2025.06.17.09.01.44;
        Tue, 17 Jun 2025 09:01:44 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id B26681065C;
	Tue, 17 Jun 2025 18:01:43 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1uRYkp-004aSX-Dn; Tue, 17 Jun 2025 18:01:43 +0200
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: [PATCH net-next] ip6_tunnel: enable to change proto of fb tunnels
Date: Tue, 17 Jun 2025 18:01:25 +0200
Message-ID: <20250617160126.1093435-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is possible via the ioctl API:
> ip -6 tunnel change ip6tnl0 mode any

Let's align the netlink API:
> ip link set ip6tnl0 type ip6tnl mode any

Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 net/ipv6/ip6_tunnel.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 894d3158a6f0..03ad45189621 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -2053,8 +2053,17 @@ static int ip6_tnl_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
 	struct ip_tunnel_encap ipencap;
 
-	if (dev == ip6n->fb_tnl_dev)
-		return -EINVAL;
+	if (dev == ip6n->fb_tnl_dev) {
+		if (!data[IFLA_IPTUN_PROTO]) {
+			NL_SET_ERR_MSG(extack,
+				       "Only protocol can be changed for fallback tunnel");
+			return -EINVAL;
+		}
+
+		ip6_tnl_netlink_parms(data, &p);
+		ip6_tnl0_update(netdev_priv(ip6n->fb_tnl_dev), &p);
+		return 0;
+	}
 
 	if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 		int err = ip6_tnl_encap_setup(t, &ipencap);
-- 
2.47.1


