Return-Path: <netdev+bounces-157390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2581FA0A221
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 10:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A3313A2BED
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 09:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14728185924;
	Sat, 11 Jan 2025 09:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ibw01nRB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E40082899
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 09:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736586367; cv=none; b=GuTw5CqknD74SqwoT8uhe/W0SoXdexLXa3SDMfAv6WcaJxM7LWxhRNuFSqVusRfBMBXjIJY01WMLWsZZuiLCjaYEVUxU4wAH4LYZbolGwwG0Sf1IFP4tJEaqTWmmS+66wce2MJYIlR1J/k3Tdi7RPCxETRKubaxCm0kKyNywKqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736586367; c=relaxed/simple;
	bh=Bqdpjiy2Xyfkq6Z887WJ6xXr5dKSyoAtEYjATBOmHf0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OR2z/xktL+BEgjqujCGMGLgV28V6hMNS5vq4HRoR7/nBZnIiAkLL1ujXDiJuxM3uH0Y3sKVm/YLHWKYeTkyJTAoP2reurnehDHztm2tiepBmvW8eqOhVfXkGymqPTUeG7wq3zmlpEXfNvSTnA61AWURoh88WqOL24Da70oAYDHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ibw01nRB; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3f57582a2so7407141a12.1
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 01:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736586363; x=1737191163; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Akm4k8GByIY19KDTwnJ73KYMOApsswqfySbu8WP9SQo=;
        b=Ibw01nRBEYSknr46Ce71dSAi46R81a08KxLVHVoN8pj5p0NMW7GdYjm5yCktrE3EMv
         e+pch0SLpsg/UWofCUoBHWL3Bfoatbmqhgb7A4AAjqE2RtHvm7/3TFST8VzWp1qI4CgX
         oVF8eMFiHlDHpvdhcSOj1cz3rhiJ/hezKyJ4YPnRD4lGiNN/JpU0Hi0pz4RVtdzqnFsO
         sHYlcPy4WtFpq8fxnAVEUdWeDpkyAp+2ZWcKda2prxdvlWg8msMzueQp2Ry2HRmrlOPc
         Br4D4HB904/toPu2KHcw7yWSGlciKc2BTmHhB8DH+Q/JxQ4POOZHc3K0wlUhl5dPNi3z
         AYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736586363; x=1737191163;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Akm4k8GByIY19KDTwnJ73KYMOApsswqfySbu8WP9SQo=;
        b=cw7AE6H4AFaXggN03If2o3FdT9xK+slQChq9TfdVfdVzaU55qulKVwgprTj7NyqVFT
         0gg+gTIRE08zwwCG7eKxol6FaqhhMb/wRkCJAqx52i218VwjD8gMHdQ8v2CJ/7XMxzGr
         TzKLkefl/1vATcYZHFIHw5zrcsW0zPlhRzEyPMCxOrBuoHT/vFN2nTLa9m9lVL06QEM0
         ysnih+EW3UuEyQSpAHnL08WMjEbjdopXqiU4fXjGIX+sEiToQQD6hza0I/yhE4huYATP
         6EB+M2mJN4vr1feLZ09Gxtd7IRvwf2i4wvrXaXgBP9G0nNJRVqUtZF3t/bQHTiXiLJHf
         d8XQ==
X-Gm-Message-State: AOJu0YyeGr+IWBBR0pbM9cw7RYc0nLtSXcxY4vdZgsJJ/yHblWVXdCcO
	+6mDSAfoB7rQU3vLV9gf7V4Dcykvz4jMzU6741I0U4h9Wm8QlNOh
X-Gm-Gg: ASbGncutepNvNnhCLwKAHjKN6YQ80l8sN13diz0fNv164KKeO59B1xrWBafmUd4ChkV
	wJNW94bZRzNXUe37u46Tkycsc90gICo/44TYFEg0RqC1wjx6Tj9UTrlwqZ8z+I13V/ZL/ScBm0d
	EQSS9Alfb57CgwQgc+hAmNAy6vDQGdwNAtnTGrpuJHU3Z4ZdMhqmU+uwf/vEtVf9kao/bWDCi56
	H30ldJztDknBxoIzYb5z3ARbgJfjSgtWswZQYEy5e/EmtZnBEmbFnmqP9uTILN4l8f+8pAejPBS
	v5SXZpxvEvsP3QZ3466aK6BOf2nwlwL+PoqABbarZgAkJyKpYwTFkrYPernTzziJqy8JvlfA36D
	TqfM7DvYOn+67Kc2FqkiKvVVgEE8v5szMXARFRRiDdIrGyuQ6
X-Google-Smtp-Source: AGHT+IGmSIVXazpsJ2Olbax9HiOSuXo+2QsUcPR+saHjGdS6oKKA8lVJS2imXwX8UqoxNDBWAqU3LA==
X-Received: by 2002:a17:907:9605:b0:ab2:d837:c064 with SMTP id a640c23a62f3a-ab2d8381998mr682574466b.9.1736586363218;
        Sat, 11 Jan 2025 01:06:03 -0800 (PST)
Received: from ?IPV6:2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd? (dynamic-2a02-3100-a90d-e100-d8f1-2ffc-4f48-89fd.310.pool.telefonica.de. [2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab2c95647efsm250481766b.117.2025.01.11.01.06.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 01:06:02 -0800 (PST)
Message-ID: <5964fa47-2eff-4968-894c-0b7f487d820c@gmail.com>
Date: Sat, 11 Jan 2025 10:06:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 3/9] net: phy: c45: don't accept disabled EEE modes
 in genphy_c45_ethtool_set_eee
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <a002914f-8dc7-4284-bc37-724909af9160@gmail.com>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <a002914f-8dc7-4284-bc37-724909af9160@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Link modes in phydev->eee_disabled_modes are filtered out by
genphy_c45_write_eee_adv() and won't be advertised. Therefore
don't accept such modes from userspace.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/phy-c45.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 468d24611..b566faba9 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -1559,6 +1559,11 @@ int genphy_c45_ethtool_set_eee(struct phy_device *phydev,
 				phydev_warn(phydev, "At least some EEE link modes are not supported.\n");
 				return -EINVAL;
 			}
+			linkmode_and(tmp, adv, phydev->eee_disabled_modes);
+			if (!linkmode_empty(tmp)) {
+				phydev_warn(phydev, "At least some EEE link modes are disabled.\n");
+				return -EINVAL;
+			}
 			linkmode_copy(phydev->advertising_eee, adv);
 		} else if (linkmode_empty(phydev->advertising_eee)) {
 			phy_advertise_eee_all(phydev);
-- 
2.47.1



