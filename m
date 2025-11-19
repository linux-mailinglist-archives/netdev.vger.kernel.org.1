Return-Path: <netdev+bounces-239846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6BBC6D074
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 08:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 952A034763E
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 07:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAE83074B7;
	Wed, 19 Nov 2025 07:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+Z2pbnD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D0221CC5C
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 07:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763535944; cv=none; b=uFzRQyU8+KFKBeLnpOYH9sH/rdTcQyxLIiIIQKwz+7c8DZOp6grBShla2qTIrIfs2GyVoPV+cbSi9PY/aMgoGIa0Gmwa29gXltWz0wHzdSKZ63aIqNoCIarjgoRusjiX26Hh+Zhvlv33gqmKzPzm9S2kihRlKH61upySfPQKH8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763535944; c=relaxed/simple;
	bh=miYxDlmUzjtGp0AzgCI6NI5EJEuVCQp3VnwC6TDRcJw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=hO0FywR+ALcnAy49Fr0vUlYcemRIOLFsfo5BUf5uQR11OlP3OxN6dqX/FotM/l6KN8K2o7nCD4C5g1uWiqfnrYcRAgIky7fgt+b5jqQp6NF95fKephld6/AGIwx8OKJeMPEs+I1BHh8iJRcfszDIw39/hDdlCozA328dbxdWPAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+Z2pbnD; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so41451485e9.3
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 23:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763535942; x=1764140742; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=id3qcmOQ7t+hT8D7Y+OZA5GDuTBDTyZCmgDKwNo4pdQ=;
        b=Y+Z2pbnDm2BUNx7Ism9/UOpVVUlPko1EYeTIcPIaoQDn3Rd8xpdkG4sA5Twhg63TJL
         x8o3XGtHYkou8M/6dvNOWpxA7UCPQfT0V9MWZtN+C59cweSmCOqjNFw2Av6k6fq8/RBf
         xw3PzFskHOvXQVo4cpG2Pvm257PI8oGRTadsRKTrOINPdZM6319rS716eQS/pU7iXN5s
         vYYw8kfaSRfOcZFbO0/s9T0MSAikkH0JNmCdD9klYDTR3KNSZe6rFqW5Zr3MCBZhO4ox
         yKcpgipNRHwWcGUFpmFpFWbLVny95VQdMUdd01CyPmN6fqvCaAISMJ9a3//3YcZM8enn
         CdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763535942; x=1764140742;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=id3qcmOQ7t+hT8D7Y+OZA5GDuTBDTyZCmgDKwNo4pdQ=;
        b=gMOXt+e3vsevP6TRtTfo275ARV+McCUFzgDk8xLbyLqVgnzGT+MH4bMt9J2210bIcn
         zarlk8v+M7kX0hX0F+IySBbHfudUtaMSeSS8NlU4I1RdBnSLNCLZQAxqFSytSa+XAS85
         4UrdBmgy2t5Fzf9xWXnAP4jlw+7jG92f5DwppN6PnyTGOi7HIToHccx+8XjT+82gWuZe
         OY8bHRuA+2HwKeYgDs1hKBTO4uAgisw8NOt67xXjsR75r4bhY7sYdpGf3UfewZiH//C7
         PPMPMOzxw1Is88vg6jrMas/mYkvww0n64MGs9ITTtrkYBP2PR7YYVVwxveH9ajM1CJvh
         +XVA==
X-Gm-Message-State: AOJu0Yz68sa3Vht+qcbBQv5/MVwmP3xkFgYsXBIv2Ruf2ZKLizPHJ+iJ
	YRe1jqygyFXrExajviyzedw1gpS0NqDLkfamMoAdFAG49Vt6MvI43VsozbrfgA==
X-Gm-Gg: ASbGncsoD/Za33EfxCaAfFRpkYvNR7j65gV7t+dljnHR+wVemDnVllqDfIPpLz3QU9h
	ymGN3U0v5b5mU2EFp2SI83vXEEfQa/ee4gNG8nobeXdLkN+VkuCc+asbYEnD6BHQG6t+X+5hJsJ
	+/yyrpVZCX8OXB/DaWzwWhJuSxhMOv1s4O6mZVTyifv1Ob+7otPvkQ6qD5MlwKGgoT2WTl+yHNK
	57RIcKu+bIEckw2NburogCd53wQzdJwA6txFSxBhh5VnUnfUqEqMsgQXan+h0ruUgqw18kz5wYo
	dRVcmQg/8A1uGHKe/oM4pusCdzPh+dVm8uGas7ZzSGfWFN49ln2FzNrgNrgImq9mZSxnmDPk8iw
	Xj6evYMbFHcTmnY3kjcd+eZImY7dqdq8X3NV+ttskpINWMscjX1zNkUjT2yRa626wlgYp4c99a/
	pX9uKAZnJDjk6McQOLIDj+OEXa9dUIUuyygh8VzChll50bDv22gyCq7NTRsmPvHxld9Tf3bQszD
	9yNqb5obaPuMCqxmoLgXWPHuUe8gl4l0yjYeZHNT390NbVOF0Y=
X-Google-Smtp-Source: AGHT+IE+9jlKZSYi/J6P8ICJ3vgH/qzaVwGuvhXkjV40yCwsAj2k1cZC3I+gHxrzmzklUJAXora0cw==
X-Received: by 2002:a05:6000:1884:b0:42b:3339:c7ff with SMTP id ffacd0b85a97d-42b595ade54mr19124863f8f.43.1763535941514;
        Tue, 18 Nov 2025 23:05:41 -0800 (PST)
Received: from ?IPV6:2003:ea:8f29:4200:d0a:45b2:7909:84c4? (p200300ea8f2942000d0a45b2790984c4.dip0.t-ipconnect.de. [2003:ea:8f29:4200:d0a:45b2:7909:84c4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f206e2sm36706873f8f.41.2025.11.18.23.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 23:05:41 -0800 (PST)
Message-ID: <dab6c10e-725e-4648-9662-39cc821723d0@gmail.com>
Date: Wed, 19 Nov 2025 08:05:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: fixed_phy: fix missing initialization of
 fixed phy link
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Original change remove the link initialization from the passed struct
fixed_phy_status, but missed to add it in all places in the code.

Fixes: 9f07af1d2742 ("net: phy: fixed_phy: initialize the link status as up")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/fixed_phy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index cb548740f..50684271f 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -124,6 +124,7 @@ static int __fixed_phy_add(int phy_addr,
 
 	fp->addr = phy_addr;
 	fp->status = *status;
+	fp->status.link = true;
 
 	list_add_tail(&fp->node, &fmb_phys);
 
-- 
2.52.0


