Return-Path: <netdev+bounces-190896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DEDAB9345
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 02:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 733387AACCA
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 00:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A086FC5;
	Fri, 16 May 2025 00:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=goosey.org header.i=@goosey.org header.b="nf1/x/lg";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="coBo0Wvj"
X-Original-To: netdev@vger.kernel.org
Received: from e240-9.smtp-out.eu-north-1.amazonses.com (e240-9.smtp-out.eu-north-1.amazonses.com [23.251.240.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B034B1E6C;
	Fri, 16 May 2025 00:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.240.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747356332; cv=none; b=OtvsgZwtla1gY/Q2buwv9IPkz/pv1Y+opPpyr1Pyu1v+yqI7uMdrTwuEaOnNqRffyZ8paUQcqxsu4jGbS4MKa5SoWMrbNTyRLsK1tiLWMHg+hM3C04Vj1nAt9BX7gocf6dE6VErPUf/pyKcCIAwOTdKjTLwg6yha5133pOaZIAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747356332; c=relaxed/simple;
	bh=T/YwGhrvkZa8/LYWuVFz+QrZ0SqJFqQlvcWinD0H2KE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Tdui4UG25NAf1vRm6/vtUynWL7tBYJ2uFsLYFsBZBs5jXFyCVJGO/W1waHrMM1rsNEGzcrN5lLeK5IP5pbjevh55RN/X9iqncxDsN4bZN7gPfNMhQVEl4ht/RpsjGJLVNP3QGI+zXRq1+kjjhagFQbBemMyqd3ifSK9iARvI3YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goosey.org; spf=pass smtp.mailfrom=eu-north-1.amazonses.com; dkim=pass (2048-bit key) header.d=goosey.org header.i=@goosey.org header.b=nf1/x/lg; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=coBo0Wvj; arc=none smtp.client-ip=23.251.240.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goosey.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eu-north-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=iuunfi4kzpbzwuqjzrd5q2mr652n55fx; d=goosey.org; t=1747356329;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type;
	bh=T/YwGhrvkZa8/LYWuVFz+QrZ0SqJFqQlvcWinD0H2KE=;
	b=nf1/x/lgQc3fKWnajVB+meRipFxHLq7tlZLCm3tKfsIOe/lE1+4y95ZfjfmI6fuB
	zMzheqTr8GVzW8iG2CxXM+UWo8W2AsnNMCQRUFmFzuH6pYAcvduqIGQjgvdCnLNIJ5z
	30hERHT7BFnvSzxwvU0qS2ZyW15InFqIhtm6Iw8OjV08l2qnru19QliDAW85A+jWv9j
	wPB9F0IjiV0oQm65HD8TytCM5MPxPEMW6ZmP0Wj5P19oKlp/eCcg+5XhgrKv9Iyuf+W
	Z8pY/mN/dYqWh15w6i3LZmR4NZhL17aqZvAFxx8xNMPwd1uGObNRQjmwmjkfQE14KF0
	UPPRz+ZbUA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=bw45wyq3hkghdoq32obql4uyexcghmc7; d=amazonses.com; t=1747356329;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type:Feedback-ID;
	bh=T/YwGhrvkZa8/LYWuVFz+QrZ0SqJFqQlvcWinD0H2KE=;
	b=coBo0WvjfcivjOs1qlI1e/OR1ZbYjAWfAAHkZcBOCO/7kCaj4Z0qHyTeCT2J6YxA
	7jhC0I2Gg3/ZDwYtCb38q9CAQnQXiJsYbvYe85WB9hQRnY1uAC6BGk3IhZ6dIZ7I1oy
	jfViTlDoT6JCGVxByVH7hgtu76y3jYroswlZOSho=
X-Forwarded-Encrypted: i=1; AJvYcCUw2t+M38i74Vh59UeRgWe9c371NFYM6tVJic7khC7DXNL9xPeBGDrl98BYimWJAgloYHIQT+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4cYvGPyKoMzTqYeYVx6sP5/amrsqffYuhSq+FCnnz5N4TJ1MO
	QNJOArewTgJdr4q1xZsv3tiB8vDuv2R+RKURc7LIGNy/pQhwm1QSLXfdCLbese2z7l0xgoKGy+J
	1qZz6655RCfc8RcXvB671pCtCCDB6wTg=
X-Google-Smtp-Source: AGHT+IG1pTOQaD+jmkarDrcjmV9Nxe/MMO8PqBrwWsrEM+pRiib9P/AF8+9y6y+NWzjk/s/O9uhy+4+g1F4DnRn0Mvk=
X-Received: by 2002:a17:902:d543:b0:22e:5d9b:2ec3 with SMTP id
 d9443c01a7336-231de376e6amr6052465ad.30.1747356326531; Thu, 15 May 2025
 17:45:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ozgur Kara <ozgur@goosey.org>
Date: Fri, 16 May 2025 00:45:28 +0000
X-Gmail-Original-Message-ID: <CADvZ6ErUKdn-fTPcfdQ6kD2A641ALuokyT_SXugbcREH=-MVew@mail.gmail.com>
X-Gm-Features: AX0GCFuzoFnxo68T0Bg3qkV3vNAHc_FQsJvH5PDstEDzD6WvTDRPsSJ-ECoFkM4
Message-ID: <01100196d68da413-7c61137a-cfaf-4b23-9f91-9ca7064e4d42-000000@eu-north-1.amazonses.com>
Subject: [PATCH] net: devres: fix SET_NETDEV_DEV to devm_alloc_etherdev_mqs
To: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Feedback-ID: ::1.eu-north-1.jZlAFvO9+f8tc21Z4t7ANdAU3Nw/ALd5VHiFFAqIVOg=:AmazonSES
X-SES-Outgoing: 2025.05.16-23.251.240.9

From: Ozgur Karatas <ozgur@goosey.org>

Hello,
I read netdevice.h file and here when netdevice is allocated with
devm_alloc_etherdev_mqs() but this device is not set with
SET_NETDEV_DEV() and i think devm_register_netdev() is probably
crashing during device removal.

I guess ensuring ndev->dev.parent get devres_add(ndev->dev.parent, dr)
is loaded correctly and unregister_netdev() or free_netdev() will not
break anymore.

So if SET_NETDEV_DEV() is not present I guess ndev->dev.parent is a
null argument and devm_register_netdev() may bind resources to null
instead of dev.

This can be fixed by explicitly calling SET_NETDEV_DEV() immediately
after allocation.

Regards

Reported-by: Ozgur Karatas <ozgur@goosey.org>
---
 net/devres.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/devres.c b/net/devres.c
index 5ccf6ca311dc..a9ff607b916f 100644
--- a/net/devres.c
+++ b/net/devres.c
@@ -33,6 +33,7 @@ struct net_device *devm_alloc_etherdev_mqs(struct
device *dev, int sizeof_priv,
                return NULL;
        }

+       SET_NETDEV_DEV(dr->ndev, dev);
        devres_add(dev, dr);

        return dr->ndev;
--
2.39.5

