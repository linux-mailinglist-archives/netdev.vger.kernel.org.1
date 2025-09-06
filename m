Return-Path: <netdev+bounces-220629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E69B477C9
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 23:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50ED61B250B1
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 21:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2232C3272;
	Sat,  6 Sep 2025 21:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVMRAOpm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12FA2C2358
	for <netdev@vger.kernel.org>; Sat,  6 Sep 2025 21:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757195949; cv=none; b=SVZGIcqZFs/gsol/qlYNAbMDJpixSdA3cyxYSohQrakiQlg8HH+CHHmVIOQL0y/tk6Feru+DJJBoXP2ygegm3VK8UdUBWthruzE3DG58+8SgXZO/MqSmPs64hD+aXiGwbI8d02qihdoDRAuFaCUhmC9y9l7WIi94Bh2kv8lZeCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757195949; c=relaxed/simple;
	bh=IrQS2xXDVDiDbxjDtxLsXe/5hxyoRiG9UZUJHVNc3TY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=jrZtc/Ief18DGg+Z0PcvyEuxbWg6rPrYBY/1LIAEjmulUEy4W59exTevxrbX7dFzzyACtM6Q3J6MSZxO7aJJaahtWyY6RKkjmq80SkNhRpCgEiNHVnMRD908i1kIk6w85zZSpDZaUFGhY83rAXnzjoJ2ayrjxGDSilEyTe9lcEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVMRAOpm; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45de221dc05so2241745e9.3
        for <netdev@vger.kernel.org>; Sat, 06 Sep 2025 14:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757195946; x=1757800746; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+ucr9JhNb9bqM8vH2tA0Z5EI0zaNlUTPAMCQLF6GTw=;
        b=KVMRAOpmyGdLV5cvWf44Hxok7EhrzaE0JkqWnaqIjYlY9xPF3galWZg151AmGr40PV
         /duu92uIPdYR7hG5+oo2mjmtf0ID4x5b6rVHcM25c2zjCVJWQbQb4x+mtiTJPh+G2wFr
         bfx2BTZzL6iYgEe6QARlxoE+XagstFVt4gjvzc6zhtXd8isBgVT4zpvgSQhpSl97jIAw
         tRoiqv60Gky+bpn/3P2dWonqdg+j3a4edNUS6baL0+4eZ/k/DMcaCoN4coB+HsJSkTt4
         DmQ/H1/AZcpUcpWVlP96kA+d/9gSJl8js0Bjf8aSKMbV/ISXnIbt/5gAYNOw41Vtzy7e
         aHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757195946; x=1757800746;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y+ucr9JhNb9bqM8vH2tA0Z5EI0zaNlUTPAMCQLF6GTw=;
        b=v6A2rOTYGDp34Cu3gUiHdIC+s5SMo12ImtQvO0OzLGFvzyL1Wj2LJ4WKKe84Q3sHcE
         2GFw8J8ExBHIKgwrDPKsskogv3xs7DSHvHgIAsmZKBs6Ss5HJvUszgZNaZCwTGO13hFH
         pVSzIUQFVzbnxvsnBsbkMoGZfzyhVQoPWp2JEbbiwkixIkuLU0GR1qLJ4UDFy3A0cZF0
         WHmP79LArcepYcjVh5OqTEdCiiTbyeNAslI9BrcPKEk8F2PohlWvBfzLvliZQgdQ5h2g
         h1QR61iqutnZ+gs1EnH4ODMXhg5poc2s+EJMwmp/hh2TA9eUWfowcq3hbFCTfjOW0dGn
         552Q==
X-Gm-Message-State: AOJu0YwUBU0SL3FXwXjKFZBHgrySWnvVLl+gmxYrOFfS90AMDprfO4Ik
	dOodi+611RCCoXc3HOIFm8Dc8IEcVfCWyskFA8vmRFN1XkQxVQLff7kT
X-Gm-Gg: ASbGncvnGKm2mKyhME8e2lxp4/304dV5tYnu7fTgw1jdaagTw5n7ODp+cO0C3QrJlLL
	7nQ9NCVDl5EgxP1hK2BU84NLe8I4nI6dXHwAEbesA9Kh/i47xz7foh5SoKvjEXDV7UmrT5rfhnD
	sIOGB5li5SeKYDm5QujhywRdJNGvRLi21jrdF0tyNipivnhrmw9ddjC3VX2SGjNTS7clRhjms32
	nFCC2zL6nMwKFiBHYc2Po7Wi2LhzdHmS73xDHQbvC7j4P/SP7AJ3OZPk4Qf+qqZFDoBV2mnlE3N
	UnaFRbnbv0GdsO13jbPlnSuWKh/LBEicHmtby3lx1X/wz47Nw6mZaqh1MFew27TEhxYShvFYUex
	ykYUx3KMK3QT6sh464Lm8q0Lj3NhJE7/N31vu7hkmrC41YjR9KXDGcpnntKOyT3r4qaeyb7eUKh
	KO274RMO+BqtZc+4Qn6csLu48L90UowJW4PkqQaob9mCuSBuP4d4g5AwP69lg=
X-Google-Smtp-Source: AGHT+IFeMyPAHp08qq3AUu6QP4Tws5MvOxk9P0rNSw01dx10USVCnt3SYNRpAP4XaTLwt5RGS5d/8g==
X-Received: by 2002:a05:600c:1d16:b0:45c:b56c:4194 with SMTP id 5b1f17b1804b1-45ddde8984amr26440235e9.2.1757195945947;
        Sat, 06 Sep 2025 14:59:05 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2b:f400:f9ef:5bb:5d77:26c7? (p200300ea8f2bf400f9ef05bb5d7726c7.dip0.t-ipconnect.de. [2003:ea:8f2b:f400:f9ef:5bb:5d77:26c7])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3e23d29bb9esm9648807f8f.4.2025.09.06.14.59.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Sep 2025 14:59:05 -0700 (PDT)
Message-ID: <e81be066-cc23-4055-aed7-2fbc86da1ff7@gmail.com>
Date: Sat, 6 Sep 2025 23:59:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 0/4] net: phy: fixed_phy: improvements
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This series contains a number of improvements.
No functional change intended.

Heiner Kallweit (4):
  net: phy: fixed_phy: remove unused interrupt support
  net: phy: fixed_phy: remove member no_carrier from struct fixed_phy
  net: phy: fixed_phy: add helper fixed_phy_find
  net: phy: fixed_phy: remove struct fixed_mdio_bus

 drivers/net/phy/fixed_phy.c | 137 ++++++++++++++++--------------------
 1 file changed, 61 insertions(+), 76 deletions(-)

-- 
2.51.0


