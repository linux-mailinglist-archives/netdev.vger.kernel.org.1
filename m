Return-Path: <netdev+bounces-148118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B25219E07AA
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 16:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3EF5B3F315
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C6A205E2C;
	Mon,  2 Dec 2024 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="esPEu45F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D722040AA
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 15:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733152113; cv=none; b=gNl7WvHFV/McJG3BQdVLU9QC2ExauJkjo9w0kOohybXeRDIit67C9Fdzj/DJjqpfnG3fdwxWeZpwK1rlZ0apX7XPRUZnYPOG+XznZ1wnjWXaCxnCmwuZDnbFz27ieOs5nHdO06LdlkG0GF/3nmwZp1P/RoA/6QnkWofjtDeFXbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733152113; c=relaxed/simple;
	bh=GchxL43RZVWbeeTak50ypiKEh4su8ul45OjPZ601Tf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KjmL6elC4ys+COQ967FqlbXelqaOXUGDuA91ruVKtBSKpMCqT9o7a8YepnN6Xw7DLmAdn4REBVlJc9oc1Ptvd5NCpIRJXGSeLQgdiK74AzFK6jM6firLViefypgAh2v+ZJ9x4SUfVNt8tB80PE0YgyFeTgKVj00QVEib/GjKJhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=esPEu45F; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434a742481aso35444135e9.3
        for <netdev@vger.kernel.org>; Mon, 02 Dec 2024 07:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733152109; x=1733756909; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFk85mO/CYRQjFZfRXq+/JqMZn31zCiBs+VMv6XbtEo=;
        b=esPEu45FQ2zf0tcLqVuhRUOOYBeN282xm9W0GrnxPIqSOqHFpbpw0NsLM1ozSGDb2y
         tKeYvDSn0eRBH3nlry+eMC5n0mnv5e2cBBkwsQW7amhgSKWlmpG4Q2epexmxuIkpI3aE
         NgqyszcLRbHnr4RARkQR4oQ1gzho24bt1ZWy+b/ubUXq56Rik5s37dWceazjCGBL1nga
         Eq4mONolGf8Xdn3TS3BLuIHTwbpmIpDyb+o/+iXYWpwLRqRAwit0IIFxgtzOydJjv9m4
         IerPemQ1CtPM+7+PE5r12JOKDmICqa+imU27Wh+aJVF/aI8LuK1OQ5trMvLywADtzegI
         SG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733152109; x=1733756909;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFk85mO/CYRQjFZfRXq+/JqMZn31zCiBs+VMv6XbtEo=;
        b=by/lXoTTZmCbvPQGIvleGvuhzQEylwTKenqOJDQsJgg6++LRHOCQ98zSA0KXyLvKx5
         XMKLtNlcNDB9boCBjwYIGksbxBvm9P17kLbsSOmMNuhZ2QRrGQI+31ShBJOscMP9/rvl
         OckVXluJBgSQ93I/SU398eQr3+TPNbHIj204XpUUhfQxMhtvOADaoP5ETKVJ6spe7viL
         axillDRBAIGgUSx/9uWMTqbp5Y3PiQC44hqzF+csR2teXQBlM6nZli9jKPJpzNCY0v+9
         hdhgDBolu4n3XWSa1c0DCXFo3nYL62Pbv2kzWvQ3fQhkd9+x760yBmysrsJD68PQalPc
         5Phg==
X-Forwarded-Encrypted: i=1; AJvYcCVlh9bTrrO15aNfEcIHjEvlbmQKyq+sltwWlBEgJhJF03OjBmG9NMzhYOZy7sUcp3XCcfzqbSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwinKsp2u2YWhXssWdlt1SuHfElcxkM3KViYOIRPnHHx7/VFP5n
	6rOB+srK7f7eTUlslBkdakrezvaIziGOtSWxJbMiStFCBDCy+BUi8IozK1bpTj4=
X-Gm-Gg: ASbGncsA3dpWpJPd1UjAoycPL+k8qhl1wj67CQPSqKUz4jh9vWcpYOlkWWwh2eK4Ro/
	H6tOPrl6tapFdAnZyQVCRbvPQ+aD2poPm7+l6rbuwvnCG2PLGkd78RrKsRkUAVXs4801fj9o4yJ
	E68WctXuBL9Rjivu+GqlgxonVj/yfgdBCMVOWqo+M8ll072N11YOuodZRj88W5Ewx0A9AtV93P9
	xm8h3uGW13M/ERmZqxT8sCMQGP/qAXsB2oL4z2Zzc7hyCwPGn9GyZ1Yz6UW
X-Google-Smtp-Source: AGHT+IE9+NpE7NGThJI4CkKY2J7SsTibLxytfXaCc5NoapUYpxSgqRJT4hJqKc1EJkgF72rjCKebsg==
X-Received: by 2002:a05:600c:5488:b0:434:a91e:c709 with SMTP id 5b1f17b1804b1-434a9e0c1e8mr174361285e9.28.1733152077890;
        Mon, 02 Dec 2024 07:07:57 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:5d0b:f507:fa8:3b2e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e8a47032sm6570395f8f.51.2024.12.02.07.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 07:07:57 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 02 Dec 2024 16:07:22 +0100
Subject: [PATCH net-next v12 04/22] ovpn: keep carrier always on for MP
 interfaces
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-b4-ovpn-v12-4-239ff733bf97@openvpn.net>
References: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
In-Reply-To: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 donald.hunter@gmail.com, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1056; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=GchxL43RZVWbeeTak50ypiKEh4su8ul45OjPZ601Tf0=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnTc1lMvkiriFWfbYx3aXmiy27DEU6gCwkU5U1W
 xWoMBJEYm2JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ03NZQAKCRALcOU6oDjV
 h6veB/9JdnZ+5+QBboFK3XmI04EenUg5uTWy1foOJqjQZn/x7RVCXTKoi/LpkySyiz5o72ulOSj
 nUwafSmFFdeArvM51iWOSlDbEKhWvZ2oVMmbw3VpUaLTejFLMkcPliWaU6hHvVtFqqCQCcjF4uN
 zB8uqxNlDqbkdb1MybWIPxWRMArjy+MVebNC4KxXtcS4f/X+Oo3AJTmFz8YJtcI6+ghKCECsjCT
 Fl+zCBaarLhyKu+ftRqD3QJ1SfcacDpwV2PXxogrx9erNvH1HlI4MRvwc/t55SZm7q7gzSLuJG8
 vlpcEGEu2UjMLlUQDvPt5xR3ZJ8J6Qdww6KkCPpFAc1ZKZUE
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

An ovpn interface configured in MP mode will keep carrier always
on and let the user decide when to bring it administratively up and
down.

This way a MP node (i.e. a server) will keep its interface always
up and running, even when no peer is connected.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 60954c5b2b9254db1d24d01ac383935765c7ce5b..274d6166741ef2d6275a252d0c042bc66f8f41f7 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -23,6 +23,15 @@
 
 static int ovpn_net_open(struct net_device *dev)
 {
+	struct ovpn_priv *ovpn = netdev_priv(dev);
+
+	/* carrier for P2P interfaces is switched on and off when
+	 * the peer is added or deleted.
+	 *
+	 * in case of P2MP interfaces we just keep the carrier always on
+	 */
+	if (ovpn->mode == OVPN_MODE_MP)
+		netif_carrier_on(dev);
 	netif_tx_start_all_queues(dev);
 	return 0;
 }

-- 
2.45.2


