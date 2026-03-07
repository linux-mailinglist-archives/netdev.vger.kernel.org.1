Return-Path: <netdev+bounces-265188-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4J44Of+YrGlarAEAu9opvQ
	(envelope-from <netdev+bounces-265188-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 22:30:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABB522DB6E
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 22:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D38E3014513
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 21:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D414823B62C;
	Sat,  7 Mar 2026 21:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6bhg/Dl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2ED1AF4EF
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 21:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772919036; cv=none; b=MO2hjJky8dGbeOwgVu3tU+/F2P9wgPBED8KaqDF64G10IcicErPLlWch0nGHSPsTny13msjzaXrGJu/4DAiCz7N73u6D302AqtgPQouzdoK8SB7ZrWYv1zX09quBfukBlv66WJJO7gzlDVszRCkHyGPo+vd8DlpXxAy6X3BAJIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772919036; c=relaxed/simple;
	bh=z864TyzABOtYMtQeHQAosZ3lSecPscocjISXWpc1Pq8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=YUEuu+j4e4OVslm2Sg4VKEeVkMha7pnhjXmefczWsiO7WDtT0+gNlvOOZbg4BDlmGXhfuM8i6Q8RyRdZ6u86sESFGMCKR3ONOfbHBtk8y8Snak5nR3/PAdUu0IUqMPNRz01F2BDy07+xxE7kjn4E53DUX/IOfWEm1he5b3y1Wqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6bhg/Dl; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4327790c4e9so7973771f8f.2
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 13:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772919034; x=1773523834; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FebKW6Yr63nJXVOjkkbWJf1p6+srXrnOt4l6HU3sWX0=;
        b=a6bhg/DldYfNWDl+Z/2wAXyFaXj8mA5+tolT8j3jOlU1vvAh+osQumg+NRc4EqXU0N
         q+wlZWEehLiGTA8NgS528zJ/4EeLmnQdqKlSfg9pDZ9KvSfA3ZFjnpxWXOhUYEoT/HZ+
         f4ps72R3Gl2PluWkHMSwX97fWNJjCigW3yQRp7syKL2tBIodFHXOkqrwqBlmbZO9W2Qi
         lFTOxF7IboMNaTGDKogeSeeIlcvsydNXDEmruOCdyw0KZWy00Ig1+jvyVCGfUFsRHtTQ
         vmfFJaHq6Vn0i0QX5mDNm50Y5SSkn5iSl65KT8F/0lPpDR66AKdueKJPBeWBWoirfhvA
         fnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772919034; x=1773523834;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FebKW6Yr63nJXVOjkkbWJf1p6+srXrnOt4l6HU3sWX0=;
        b=ZRifv7IylIvhYUJxhtIP36exp00CQ/nENS6zEx99lDRes9aLs4SOTosQnq3GQ/pvr2
         8mWVkfgIeY67qsIkBfhHZ9dSbOhIOEzRzaSuBH4ZNJf7oP3BE3B6vvr1Nx25THppaWnB
         /ARaZCEwcDPyFz2lZ4eT8F7m4+vqx9ZO0kGOdjjwO2f2tXUcVmCNvAwWAvjzfn+o1COU
         gE09ZUQ6P0T+22/dZ9/Sw64NGq2vyCnG+11yxJUGB4NfMi2E/1iyXc0K5narBQ3bTjyk
         8hjChoHHQ3+oKW5H4mUjw6T8fYJU7/3CIWL6ciVGgcmA8Xp21UV9HMj5ygkIIT4gI8Nk
         t/sA==
X-Gm-Message-State: AOJu0Yx96TCM/ybvxai89UdH7sxlWQ3qb6e1t5Z8t6HTiHUPZvw3MSYb
	Z8BvB6OT9wQyN1tM4wLZVXeZ5uPZBmzSKbnCvz20yIPgyOCVEYvFEaUQ
X-Gm-Gg: ATEYQzx8TPgfXBQCWoB9me9QUxFmhYF3xqcYnYPdgmgphjP+Wsac7Xyh4Qlz4B6IJpt
	3q6zOulxnel4RBy2/Cc98jQ0tYR89i/Kl5M9hDTTzRiz2ZgJY8aMuohn2wBXYhs2m+/Z81292Qn
	7itYgCH0IgjxF/LMeRt491DJlvw10csdLsqu3QHSFkWXuoUiJpcAxn+S6qyZp4MWJHVoLwj2w/h
	lEp7ttsvriZzr0edya78JS4kv03sJO5InjQme50LpLCz1Zhg7ZzGW9f0JBCzVV70/e9qZEySt7m
	teI+/DMkhBLFZBI0lvQg6KnUlbuixn3TyasjXx6xitmy2ufDfCgy42K7JXkhiFjwxMC++YLq8TJ
	Et3Q0DJUc2qyR0ODK6m1xyIESXmOeiDWkD7j/kKARzdXMQ09gGgbYBeXQIugCA4GpoNLuJsp3Zv
	HO+qUF1a05CNOc0zZm+CwxDG/skBM+XIPlOeC5wM32iTC3qoMvlpzB2/yAkrfVGTo+eKOO+OOSI
	jElLTEg4tDO2aDGVGEAzQzh2FRiQIxwZiIbpu8mTE2KOfK9s9g+woauXLFdvuFDCg==
X-Received: by 2002:a05:600c:c11c:b0:483:c12b:fe3c with SMTP id 5b1f17b1804b1-485269188damr78533035e9.4.1772919033829;
        Sat, 07 Mar 2026 13:30:33 -0800 (PST)
Received: from ?IPV6:2003:ea:8f0f:7f00:f48b:e818:2b17:74e3? (p200300ea8f0f7f00f48be8182b1774e3.dip0.t-ipconnect.de. [2003:ea:8f0f:7f00:f48b:e818:2b17:74e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4853044d849sm94946455e9.11.2026.03.07.13.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2026 13:30:33 -0800 (PST)
Message-ID: <8b34944e-3abf-4dd1-908d-c21d08c62c34@gmail.com>
Date: Sat, 7 Mar 2026 22:30:32 +0100
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
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 0/5] net: phy: further decouple provider from
 consumer part
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6ABB522DB6E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265188-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.879];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

This series aims at further decoupling the provider and consumer part
in phylib.

Heiner Kallweit (5):
  net: phy: move mdio_device reset handling functions in the code
  net: phy: make mdio_device.c part of libphy
  net: phy: move (of_)mdio_find_bus to mdio_bus_provider.c
  net: phy: move registering mdio_bus_class and mdio_bus_type to libphy
  net: phy: move remaining provider code to mdio_bus_provider.c

 drivers/net/phy/Makefile            |   6 +-
 drivers/net/phy/mdio-private.h      |  11 -
 drivers/net/phy/mdio_bus.c          | 385 ----------------------------
 drivers/net/phy/mdio_bus_provider.c | 319 +++++++++++++++++++++++
 drivers/net/phy/mdio_device.c       | 165 +++++++-----
 drivers/net/phy/phy_device.c        |  13 +
 drivers/net/phy/phylib-internal.h   |   7 +
 include/linux/mdio.h                |   2 -
 include/linux/phy.h                 |   3 -
 9 files changed, 441 insertions(+), 470 deletions(-)
 delete mode 100644 drivers/net/phy/mdio-private.h

-- 
2.53.0


