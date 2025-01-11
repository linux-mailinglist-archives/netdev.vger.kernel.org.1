Return-Path: <netdev+bounces-157387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB964A0A215
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 10:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A118D16B5D6
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 09:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A99133987;
	Sat, 11 Jan 2025 09:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEtiBo5l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154A27E1
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 09:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736586113; cv=none; b=tzVT5ePaQbOi/wcq5VRRsiq042j89j5wL3qMADr9LJKYvFytIA7V2TJyRZcM9BIbKlyX69UuCW3epJ7GsLFwAdYaSWW7kxkQbuepKiJMgVmEo7P4cnGw6/+rNHZ0A7Q02D7rkpwzJzRHbnzn6GTmRLpbQMrEdtrfhwS08wgzYbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736586113; c=relaxed/simple;
	bh=7und436Q26Gx9BgGg0vF9lL9tF31Wkx+JOeMHJQCP+0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=DZsQvdMycq/8g8/Q036q/iwOS1xk/XGCnEzVm0YkuD/dycNmDVWF2mWOf9CMklVZS2oIs8M545DBlC4p7dSwpqXcFmZmZWggz0iiLHkYryxEpkB9yMBN6AQ9ikEheq/gaWGWjCHc3kEUKyyuJQdr4F3lobiLnAGdTIVYQZLwonM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEtiBo5l; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaf6b1a5f2bso723848366b.1
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 01:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736586110; x=1737190910; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q3EL0mFUontLIwni3K6WnRinnXenTDF78HLlrcX4Tzg=;
        b=FEtiBo5ldfMku7AoQnkbtyBqCkeUbvi6uElcOFRC9+ZFQlqJJrQU7YZY/Q4wHagdoK
         6hxRt8icUZpDmebOFZptA1F/WKP9mV0sR7UBR1GU5OKilo2P65QQRI+VgIcO2khtAyMa
         s3JbsaOzLHlvcd11Ha9FAdKZEzQNoyZeIvQzkS0I7xNX0K2s21UzubZ83TieuhfLmII6
         oyORioRfXRIxKZsaC+ev+/lWl58fVuz5t/pNzwyn5i4G6qRZBRu/Pe4t9ALKDRw3QNmx
         rdIy5TzuD4lx/5SH3W62b0f4lNvMURxUuH3WGWfZd1YTeh/l1QWBVDtsYW5KT7OmdWVH
         ncmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736586110; x=1737190910;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q3EL0mFUontLIwni3K6WnRinnXenTDF78HLlrcX4Tzg=;
        b=F+/rJEgHp/vcHKdrOdgE4/5wM16MNCgNPkDjECgJrwdh8U82jgXI8GVArjX0s5YcJI
         d5IInoHWTPAZa0tFP4S8rl3m9K8v2CnFWeNTFLH2Q90fzR+ERAHoKAAVgjDSy9msFzwp
         xNJjNuqrg0JS1luzeWljLiDlHnv6CXuFlY5310XC88OyvqD8A8gywr1gE9BD92tKCu5O
         qeMge1Qv49IWSSTvgsdXnbPfNQMg16E9NS+YaE+g5AK1QFhKDvk4EIYmtgGCcLr5cTlo
         g0lISWvZvHks+ffAp1rt4Sj88/0as2ZLx8rO8z4GlIiRyZMNsw4bKnszitgMIxQ5KVDN
         3HVQ==
X-Gm-Message-State: AOJu0YzJ2Rng/CILg2twJxcFUZyKI9CL9Z6cqT6d2tv5TdO7UsFGXGni
	MS0Bu4n3AoEGyhz7ZPDjlM8lhA1O7I8+zHuNJojkku2gh+hAj9vO
X-Gm-Gg: ASbGnct36Bk1HCzejgTpu29k3ZitrRiwTsyNCPQrZa4IhEpTbvAKFdAPf+YGsJVwbaF
	OJLGz43BnHibQmiV8F3DboRSC6LuHbINcY8gc/6x/mu8CroFejSXNMGrjSG/GGItrqOobR07Vot
	QVJ/l5Je3fNteOTHjMtwH6q6KOkx16L8N2onzXNk5ywrKzlIyJctbqQsSXPn224EATjbAFqb5J3
	oThuYVUWqT4F/3CyWNy+sMfRZP5fJnAPW4CcAevEcbIloRJ+JW46JAlXUgB7isxWnWVZsvvQpD6
	Y7YIbgHYxeHiwONDGdsMUNSJL72saNc+WQP6tDu6RGOTYIzcfuuRpvjICzj2n+gbHIpkUflUVKi
	kx3fjiOP4ShBIOSz+k54XisFlYK7eQ3gMxDR6j1pZoiYUnvpc
X-Google-Smtp-Source: AGHT+IFztFfvqQXGWLdmkfV6L61YUrVVg3onDkuwF02xnaE1rrbtQDk5xqaOU/Uh/+ooGnJy+IoGww==
X-Received: by 2002:a17:907:1b05:b0:aab:a02c:764e with SMTP id a640c23a62f3a-ab2c3c7a0c6mr981817366b.14.1736586110108;
        Sat, 11 Jan 2025 01:01:50 -0800 (PST)
Received: from ?IPV6:2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd? (dynamic-2a02-3100-a90d-e100-d8f1-2ffc-4f48-89fd.310.pool.telefonica.de. [2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab2c95b1bc1sm253128366b.147.2025.01.11.01.01.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 01:01:48 -0800 (PST)
Message-ID: <a002914f-8dc7-4284-bc37-724909af9160@gmail.com>
Date: Sat, 11 Jan 2025 10:01:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next 0/9] net: phy: improve phylib EEE handling
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This series includes improvements for the EEE handling in phylib.

Heiner Kallweit (9):
  net: phy: rename eee_broken_modes to eee_disabled_modes
  net: phy: rename phy_set_eee_broken to phy_disable_eee_mode
  net: phy: c45: don't accept disabled EEE modes in
    genphy_c45_ethtool_set_eee
  net: phy: move definition of phy_is_started before
    phy_disable_eee_mode
  net: phy: improve phy_disable_eee_mode
  net: phy: remove disabled EEE modes from advertising in phy_probe
  net: phy: c45: Don't silently remove disabled EEE modes any longer
    when writing advertisement register
  net: phy: c45: use cached EEE advertisement in
    genphy_c45_ethtool_get_eee
  net: phy: c45: remove local advertisement parameter from
    genphy_c45_eee_is_active

 drivers/net/ethernet/realtek/r8169_main.c |  6 +--
 drivers/net/phy/phy-c45.c                 | 45 +++++++++--------------
 drivers/net/phy/phy-core.c                |  2 +-
 drivers/net/phy/phy.c                     |  4 +-
 drivers/net/phy/phy_device.c              | 23 ++++++------
 include/linux/phy.h                       | 24 ++++++------
 6 files changed, 47 insertions(+), 57 deletions(-)

-- 
2.47.1

