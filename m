Return-Path: <netdev+bounces-131154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2199798CF84
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 11:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538B21C2258D
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 09:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7A919CC2F;
	Wed,  2 Oct 2024 09:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="eErUjJbj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592FF195FEF
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 09:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727859808; cv=none; b=kXPHY3nOllcsCW0UKh8Wowj/Bg/lPkfJTABh7YMsZYMDWeAPjHOHxnYtqY3EFIO6mIdh6RnNhybuZer/l1Ic7efHnidL+Cs8NCnWXxfjVp5wZAc89zD97VhgqBacV6FgkG9zqPdu2RPuZleIuUJtg4nQCubKtEhNCa4vIbIQ+dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727859808; c=relaxed/simple;
	bh=x9G+LQPmQGZYYXuIUN42CrVqwqLTedzZV5YjkHc4IrQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dJH/p1kEJ+TnnUP6uDqboYNuC0Dyx+1R0dtCYWa2EzpxkuZe2iJviXbzGPdHdNJGECsd49I7oI4XNXSgVcNFB6sfSWPBJTsds1/VCiNFodn3gEdleYT/H7vAy4TKQcr1ZzV/rMFX2DxJAuZM3xcKDE80Jm8viwIYKk7XbU3gmfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=eErUjJbj; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cc8782869so60075835e9.2
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 02:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1727859804; x=1728464604; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tg3GhQ9M4IeLDst9adgxAt09NjdE9INBvd09onQRqV4=;
        b=eErUjJbjta7riz5ixicsgnAZfLz+rk/7MaA8BOpR+o0C+EPmwD737ADqS5M/iLMZpR
         W8GN/Lpyv1YJySBY1YzJ8IM/9aTt2/sbZKoLeqG85Rz7/r64/4JpjP/gnsdEJZUSYs23
         bfbN4xl2tqcLch1TpshA02qdDNCUMvBoCMBIOBWz4B/2PFzIrvsr2kEvnGL2zcTSxJ3e
         JGF8IRqdAIeMvlZNBHWgubisFw6on04VaUY1yW8eOWEp6VcZvQbxUAtCSaeXq55gLnbF
         7oY/I+JZ5+xYSzBmQRG0eIJEmtTIgixoopVAp+0a1CPUYhjfmXbUdBcaTPVS136F6ykE
         j5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727859804; x=1728464604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tg3GhQ9M4IeLDst9adgxAt09NjdE9INBvd09onQRqV4=;
        b=Oxs3u6NagQzINER6CMJLb7sFobawRYOGssQtutbMJFXDgVzuNW7iaY5LKwBMGeN+iU
         MNJktDRq+Tq9WLevf/Cv0yTkWpG+UYwXziCJyp0oQEnbFQvtxPjQhHtDhKi3x5xlHPrI
         Bd6ClxSVSMqcnwVZzdeSDULfuPGgYF23sBlzKt74ak8fX+635UsqtVpBgOsxFZ/h365h
         exFJT/jxw9/nK9d7Fwus9CDfjdpXwzwsiXoCeflFF+ui35dpmRfExO0dc45dY+lwWLOX
         xaYtV9M7I2zu9jrvaqsYEKVIuABl/g7qXVV5q31s8vgVFYiJkpfrGs9gWsOztqZQxdBY
         AIAw==
X-Gm-Message-State: AOJu0YwyZUMCMdoT1xwOvaCprWevtA4uTV01X8lVU1LenZsd/27mpqzz
	BfbXtPUdLcD8XTOlDCaeQP05IMeYSs//Q3iSy4OdrNaQbPtW7T2jADQ0Zg/DvYI=
X-Google-Smtp-Source: AGHT+IFtihufaLNlEccDvXEC3MOXZ1Lwe8AxJAaJJwULIjchFGU9U7BHFhbJDDnaREOsi/jt4YJLdQ==
X-Received: by 2002:adf:e3ca:0:b0:37c:cd1d:b87e with SMTP id ffacd0b85a97d-37cfb8cb7a9mr1350404f8f.18.1727859804558;
        Wed, 02 Oct 2024 02:03:24 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:da6e:ecd8:2234:c32e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e8822sm13602320f8f.50.2024.10.02.02.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 02:03:24 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Wed, 02 Oct 2024 11:02:20 +0200
Subject: [PATCH net-next v8 06/24] ovpn: keep carrier always on
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-b4-ovpn-v8-6-37ceffcffbde@openvpn.net>
References: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
In-Reply-To: <20241002-b4-ovpn-v8-0-37ceffcffbde@openvpn.net>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1171; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=x9G+LQPmQGZYYXuIUN42CrVqwqLTedzZV5YjkHc4IrQ=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBm/QxR+jXN6hJpn0LHlII6NutC7Jtdt4tAgr0H2
 5iFVODP4l+JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZv0MUQAKCRALcOU6oDjV
 h8XLB/9junbiwI77zqocVNhkjjsd1RqrDdh7my9KGyD4qH1RzyTfuLoDMnLqALcQukgpj14FJvr
 PuoUNIePjF2BwzrOTAM8NR4iy11E0Us5lHFR75nNiL2GpqckrmU5+FJ/YiFD69qt1YSIMnybd//
 4crN2QQ/ZChDDOFc+d/PgUy3+ukF4NhN8StmPGFk6578xHFP/Xr4jRLAqPJ+y4Nq7Kscc9P/t8c
 d6SXS4UB4QIk9BDKyZ/1h3bEBYQ+cei+BQhEK3z+F6Ju+xX47LZYIKN91wJuJ1KoqBB98B/HHdm
 +ScyNFIh3GLaAnSytWgFGWpVqQHiAr3XMZpH/RZEJFNfSFvX
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

An ovpn interface will keep carrier always on and let the user
decide when an interface should be considered disconnected.

This way, even if an ovpn interface is not connected to any peer,
it can still retain all IPs and routes and thus prevent any data
leak.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ovpn/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index 12f6258f94c8baef855e2ce90cf70380d5af5ca9..87d49b83107aa9c276c5b200ac919965379c99be 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -46,6 +46,13 @@ static void ovpn_struct_free(struct net_device *net)
 
 static int ovpn_net_open(struct net_device *dev)
 {
+	/* ovpn keeps the carrier always on to avoid losing IP or route
+	 * configuration upon disconnection. This way it can prevent leaks
+	 * of traffic outside of the VPN tunnel.
+	 * The user may override this behaviour by tearing down the interface
+	 * manually.
+	 */
+	netif_carrier_on(dev);
 	netif_tx_start_all_queues(dev);
 	return 0;
 }

-- 
2.45.2


