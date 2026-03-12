Return-Path: <netdev+bounces-266938-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCHoBfR1sml/MwAAu9opvQ
	(envelope-from <netdev+bounces-266938-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 09:14:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AF50D26EB94
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 09:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1ECC7301D0D9
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 08:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD77732D0CC;
	Thu, 12 Mar 2026 08:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GScT1G/Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D52F3164AA
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 08:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773303282; cv=none; b=nC1IS6o6nw3sq/fFR41eUud+IC7dlQOBgYJJ+zndEsams1A1WOEHU22NS9tGHuI6Vizi+QIiaVvchcaUUr3Ne+lr5W07o7k+nc3VjT6BAd/MKuUZII4Z4NiwRXtsfJx4MS53rZm4FbPgoirzsz8GBNf8iifGyoJhxYPlURz0z7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773303282; c=relaxed/simple;
	bh=er8uEkvKYbxMLBrtAkD/Ds/M1WLkmn8Sf0zjcM183JY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GVA+lgeNe9KhDt6ertd9UvOPkz3IlLgWFtGbNRqQfwL9v5WIJRHwXgHs2CMf8NR5JuKE+FaaOHtg9NbdCyMsU8BpWzME1bQzV3DrNT4NMxYIRdQZRQFeRpwd9QtpiRHytEVwHe2h5Ix711JqhkDczSio6c3QZgEFvvJlaf2KerU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GScT1G/Q; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-89a09ef1e3aso10133096d6.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 01:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773303279; x=1773908079; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FFkV5VaoXwwGdJuWMIX9rdpBK0Bevm1lwza2wIag9uc=;
        b=GScT1G/QC06xwjZjYN4fFrJYyJxJmbl4ZisZxB4W5A/uG72wugoPvaypq0+s4v6SLD
         KZ87wgBrD37o0xozTZeSvtAmoktf/FsZU7YqGpkK+dCvQ2PDPVcuCniCmeisHmeWUZYO
         SesXyaia3c+w0tCUmey+8/B9YmQW7QYUcIaJ81nBuWnnAeYCMq+uP9B3bIV+e21ZT4w3
         JI54AYhw0py911qybx4PYpf5Epcf8Y9jU/o0kAAxlmdcH7+oWr8VzQda4L6pC5vq8Y/l
         +ZPluThT41N3n32mELnOv7uWGpY8okBHz2ub2T+YNo4/9CLfF9jskX6PTDhNH4JGUDsP
         OfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773303279; x=1773908079;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFkV5VaoXwwGdJuWMIX9rdpBK0Bevm1lwza2wIag9uc=;
        b=bthiMvXlJGbgHGtIWMYGlUoivetlo2+hFWQ/4D00qrQIpX+2MV2OTU7+mJkYds3NY5
         AdYNfTkHApIDvloIglkbxSUurt4YC03Br/f3ar1ssVDlMNpUDcgKJ5CAo7w6b66Txctl
         UdgHy/yh+bqGQh9/n2G8iKre/lp5TQit9h7l9icxpaefS9Gz/ySGp0hX2CqxTOIzda53
         mtd7hMByUgGbTfRDe6eSGymrpMY1Hx7Ez1AIXuM74gmbA7teWyKQRGeYkEXBLI6vywpb
         EVIgmgNaSXDg5AbU/uqOmSfzOWqHDwOq5K2r1kxF2w1JhfVVdvvHZpZjOpYYP/5KrfCc
         mn4g==
X-Gm-Message-State: AOJu0Ywt5WD4tXa1nj4zrSEiellxpJUcQeDAceABb+ap5m+QElVKtueB
	McBNjKh5xGtfU4/b4VkrLsRD6KodriYylWcL6QGYQdXLeN5eAesw6SjR
X-Gm-Gg: ATEYQzyME2JUDOd5Tes2fYt7xvgK6gkhRkcBIW0cp+IY9xmu6orRKAxGM6xYRLKewh3
	cEzCoHkbSl0NPLy1Q3eTeKIOM2/WWOjye3RX1NFhmC3mjRkYRB8iUEiPIZisTvBvyc+heUoJEsG
	/i/ngOZZk/u/qP2OEy548k9gQvtpMd+kSXX0IULhPN2gAVqg31ahaOnyaPE1UiakpFPYoOdPV8N
	LltgVI1ETCUr5wtvt9mcG9KZyEuQPGiqygd7D58CuHOTjhZ8Wq68vykXpU2Z+XouYLEFZN7vkWR
	uRkfOayp++JVpckvTXjuHFIxDOYHyV7jFOUMxvaMIEYwkSQ85Fc5+ZeZjNPg4LELDELr+m93LoZ
	Ue2LThtRXlRo+Zb/lC5p6B04xgusOsBRiLuLWdfA0UEqUIREEu19Umx9zYg7nvxvHqHdBTzpAaD
	wwomUWNER9Yh+illTJOg+B2w+IweAnmP3aQQ+g6Laqmq8=
X-Received: by 2002:a0c:fec4:0:b0:89a:3013:be02 with SMTP id 6a1803df08f44-89a66b01056mr52519386d6.34.1773303278891;
        Thu, 12 Mar 2026 01:14:38 -0700 (PDT)
Received: from localhost.localdomain ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a65c122c0sm30423076d6.23.2026.03.12.01.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 01:14:38 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH net 0/2] net: macb: Fix Ethernet malfunction on AMD Versal
 board after suspend
Date: Thu, 12 Mar 2026 16:13:57 +0800
Message-Id: <20260312-macb-versal-v1-0-467647173fa4@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMV1smkC/x3MTQqAIBBA4avIrBPUfsCuEi3UxhooC40IxLsnL
 b/FexkSRsIEI8sQ8aFEZ6iQDQO3mbAip6UalFCDaKXkh3GWPxiT2Tn2nW6tNU5oD7W4Inp6/9s
 EAW+YS/kAAGvwsWIAAAA=
X-Change-ID: 20260311-macb-versal-e5493bbac09f
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Kevin Hao <haokexin@gmail.com>, Quanyang Wang <quanyang.wang@windriver.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,windriver.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266938-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,davemloft.net:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF50D26EB94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Versal boards, the tx/rx queue pointer registers are cleared after suspend,
which causes Ethernet malfunction. This patch series addresses this issue by
reinitializing the tx/rx queue pointer registers and the rx ring.

---
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>

---
Kevin Hao (2):
      net: macb: Introduce gem_init_rx_ring()
      net: macb: Reinitialize tx/rx queue pointer registers and rx ring during resume

 drivers/net/ethernet/cadence/macb_main.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)
---
base-commit: f90aadf1c67c8b4969d1e5e6d4fd7227adb6e4d7
change-id: 20260311-macb-versal-e5493bbac09f

Best regards,
-- 
Kevin Hao <haokexin@gmail.com>


