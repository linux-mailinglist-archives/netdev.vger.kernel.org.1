Return-Path: <netdev+bounces-230583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D8EBEB72D
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 22:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2FF587C9C
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 20:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B152256C70;
	Fri, 17 Oct 2025 20:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRG0rJSl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EB633F8DB
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 20:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731886; cv=none; b=T9KzuyRRagMeMuDw98nVpiqcQJcvNc0LNKGYnFEu8M3drN3pUxTTTI+0d78Sa5BCMyRIuGrkSR4dI2hwaHWKR2uVqJ68iAgLxnCsTfkbdqgujbn+4SV1qCGMAvcGAZOKqmiCFJUTZ1ZyKrsjNtpu6xt+Z2uPaG22jH7J6yd/CdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731886; c=relaxed/simple;
	bh=UvoovnsRRi2X2NY1vy78FtJBBAtxGOK+03MejuGxwww=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Jq0rIvzR/R9hSTyNrw0UnB8sE02unYoI6QnszipUQlW6rluGC4btZtUWG3ihn+z5sk7j3NBBjwiARgoLypTso5HSKx8iZNZOLqc/JLW1kgj3hRos1YHmejdloMyFX7nFt4f1EMsaR2EHsGOI3t342kB6aHFVeFjZPfBH4olAe5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRG0rJSl; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46fc5e54cceso17426845e9.0
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 13:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760731883; x=1761336683; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25kpzmXycx9gQ98g6XpOj5wse0z1LQbP+7dofoJBKRU=;
        b=fRG0rJSljYi1a8sLMHCioXzFjz9NH8G9yVIll2UFDWUQYp5zdJHsgspYYXIdMmDHW4
         hCrmLkkhYmMjoI50H4pU5bsJe87ycP25H71gJCeGVUNp51uLhJfmnUIlMNNWZARlsVmX
         UPgliPb2Of113EWm07mxvAI5HKeZiV3Gj4b5p4Hn1lQuazNJXUw4+AueTiSY3HTwOtrg
         rWwnzp3xBW+/L0luf9QyPF09/PPORBXqm+0lAXZ/KknxwTth4QRBdFTIVAKMD2BJNkXA
         o/yJWsFKBvgLm9mI8t31SRvLjUCGegZSs9Mrl2dNZ7rhr/mUXzTzQAbAcAr9kyDB9LcT
         gGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731883; x=1761336683;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=25kpzmXycx9gQ98g6XpOj5wse0z1LQbP+7dofoJBKRU=;
        b=ogNZyW68YcpqOIOvxNLrrGwQTxrZ+dGNGyBKItarc06LEe7csuNVUeqI5Vv2Yq0AbS
         9r2lCDNWBSNRU1QukwUSJF65YT1cW7CIDbwT3wDc5YCn055mXFkXMEzm9yFiugBlCl68
         8BDyAN3afG6xGgZ4htlWbN+1NClqNs8FrrbeEn1GB1OhwBitYOnbuNehdJi3NNDhM+as
         E2htOKIWb/EDw3vNgv2z8hND+Br1C6l+GJVbcGHpf0j9TlT5PsuYgrJfdPGdOwNSxKtU
         JGheBWAGgozqpaXiFxfC16JpiVVzyztjHI79DoRJkviOslD9JRmqYeN/8nuEu3eSN6fD
         O/0A==
X-Gm-Message-State: AOJu0YyewluBmTnFJvUJ9pq/GA86jUr5zNDn5ETNIQcaTtq6A5cfQCXE
	gjAryruf5cktxllcCnnRu9h4mDd8yKs6XUDYYdD0+HucQ8MOn/7kXSkF
X-Gm-Gg: ASbGncvk5faGIYfI2+aWReeOIRZkQdBBWUngkSZULPIlpk0slz0K95uMjFXGlTLELMo
	syeK7PbyIDfW4jpGXXgphqDk9ybruwaImRGPfo+9mey6M/Q7/lCD0H/CKwZ4SbG7gpG6Too88Hm
	Q8LYiP+2icoDC5V9xs0WVPYOE0VY5AvCCVKqkcyaL73DNNawKB0cxL1GBbVhIWbsvYN35SmxbTh
	FP/SltKeXzNJfbAzwFLgTL1Tx9AgmKhH6yU9Cm2Z+uxPd1PQUmVlU7/abelw6hbK0MnQZoA/4xr
	aeN61UMj4ESOAX/5pvzpW+0qeOs9XuO9GEFd8lnBVBiTCI9CZYl1Bw6Gj2qaRBh/BCK0E+KBy4d
	sCjqKyTvoVNy6cKZ1jojcPPsCMa92NOf/O/HFpwc6W1lBDxP3dMHLCyaTx155x3XU+3dXoTkB9h
	DBXHkgaMbGbqBuZK9dLOM8h/nXSj8MzIOZTGkFSo/xA7MFHZ4YbH+JhO5izpXvXvl8276qetwWa
	g/mpcUPRy/OaH1Ka+YtI2Zht4aRPPI9uZv4FcMbybcg4x4VNlM=
X-Google-Smtp-Source: AGHT+IG0IawYH5YjUYhc7BPhvfAe6z1ZY2rYILWCjiklF2edhDC3e253g4Skuvr9DCwNEUhZQntikA==
X-Received: by 2002:a05:600c:3b04:b0:471:350:f7b8 with SMTP id 5b1f17b1804b1-471179017damr32353175e9.20.1760731882794;
        Fri, 17 Oct 2025 13:11:22 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f33:9c00:f581:27c5:5f61:b9b? (p200300ea8f339c00f58127c55f610b9b.dip0.t-ipconnect.de. [2003:ea:8f33:9c00:f581:27c5:5f61:b9b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4711442dbaesm100212225e9.8.2025.10.17.13.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 13:11:22 -0700 (PDT)
Message-ID: <d6598983-83b1-4e1c-b621-8976520869c7@gmail.com>
Date: Fri, 17 Oct 2025 22:11:44 +0200
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
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Vladimir Oltean <olteanv@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 0/2] net: phy: fixed_phy: add helper
 fixed_phy_register_100fd
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

In few places a 100FD fixed PHY is used. Create a helper so that users
don't have to define the struct fixed_phy_status. First user is the
dsa loop driver. A follow-up series will remove the usage of
fixed_phy_add() from bcm47xx and coldfire/m5272, then this helper
will be used too.

Heiner Kallweit (2):
  net: phy: fixed_phy: add helper fixed_phy_register_100fd
  net: dsa: loop: use new helper fixed_phy_register_100fd

 drivers/net/dsa/dsa_loop.c  |  7 +------
 drivers/net/phy/fixed_phy.c | 12 ++++++++++++
 include/linux/phy_fixed.h   |  6 ++++++
 3 files changed, 19 insertions(+), 6 deletions(-)

-- 
2.51.1.dirty


