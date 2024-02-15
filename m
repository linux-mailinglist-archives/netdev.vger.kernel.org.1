Return-Path: <netdev+bounces-72031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8E08563FD
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 14:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A111C221C5
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 13:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806A612F394;
	Thu, 15 Feb 2024 13:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J10VhP56"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF95D10A34
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 13:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708002357; cv=none; b=IRYpGR0lpX/TMb8VkvHQVkCG54QsODS8/9b3EmB2WyVBcIfWg/sRJq18wC/TNYtYFHWrTgD8DhVCCCOv8f0k1nSNthYLF7A2tmAteZszCB7PqrPycOXDKAQxlZuDvWWXDSTHvbRgG6qpPqvJIxu1/MQAhG5tF/6GEgrBWwkAQx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708002357; c=relaxed/simple;
	bh=VmlnCvxM/O0nR+xkgQ7eLSH0m1uZdyg4Wllw+GUmDzc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=CJap2C3IkG4u80syPJ/IYr4WeGSr+0C3WXjlV0gIYi0TBF1TFxj9oUo1K83WABaGd1Xmt2v2tt/2dMLazJI0lrCUK8pfR3Z7gMMP4f+xaJNL+/Kcik+3VMXceHOKR7keECXwDI4c5ujdTk6p4/Z2Um7tsDbbXQdnMSKcHI2/4ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J10VhP56; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a26f73732c5so111570566b.3
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 05:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708002354; x=1708607154; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZcpIPIkULySX0ZvO01/8JEv0cP+koYT8cs/3IESm9HM=;
        b=J10VhP56Yhcm6qkwrIOKlumOpQineSDSVIX8bXmtNqgBCtNKZtpkNzk3fYrrMngtyI
         SXwKGO3iPkryeBZK8zSP9xUqPApLHtP1ne8bMRvhcXvkmsODmNxKpDi8Swl71pjaB/9c
         qgLvcb0tVGraKmdNexexrZRuFMLfhI6GiVYk+3GbPt+aqRwrv7lCQV3Cbl6sUCwIxZbO
         J943MYV7Agf/hcrgjO5UwV8TMEpcP4neta6HGu5OrSQtC/J9yaaDCTGMpFzwlMkmv5xr
         rb0FljE1q8Nek3zT7s6MlOGgAH+YjZtdghHtQOMPEP+OgEnGPDunC+Tgu4IE+DpJUCMe
         Okng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708002354; x=1708607154;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcpIPIkULySX0ZvO01/8JEv0cP+koYT8cs/3IESm9HM=;
        b=ogC4dPgbmnfxtXyjVX2/IeuKbhMhJlbehBtnJVZbgCS8zib3oAfs42GBWYRBIxw0uw
         0OCO+rJA4X2+238jADk8qXA7iiodO25vf2B6jTMcVXZvPA/vq43mQzwdevEB8a9JMAkd
         s8Sv6KuzZ3JOTmqEq+dPwucE/H1W60PNyjVxhlyhkGEPCeQnVLoYxiHeeIF5lULjaBel
         ajTCLS5a0Esclza+0nMF/jHG5QClo3Ua8hV7ckC6IDA159CdtWINTx8g7hxFiYc9oPxj
         BVCHGbRKXsa7SRA5rQr/05CD/nGz25DzAo8BKpD4UqZrZbAmGBsdngXN3kLocG6s9zGH
         ktwA==
X-Gm-Message-State: AOJu0YzEnkUIdq56P5ug5S2VFlSkt6KAo07GGwpenazLyuXfKoxAFDGz
	WE1YmrXcvM3IdbG7YnUhdE1VKVgBKdCf0jdx8Po6NjoEyxFYkBQD
X-Google-Smtp-Source: AGHT+IHChLAndcbEJpfGiKoc56FHRahZZ4vxSYxkIagBMCbuh3vwZc7D0gqWIaz2DqxXa3d3PUfjyw==
X-Received: by 2002:a17:906:7196:b0:a3d:1899:ec3 with SMTP id h22-20020a170906719600b00a3d18990ec3mr1297354ejk.35.1708002353646;
        Thu, 15 Feb 2024 05:05:53 -0800 (PST)
Received: from ?IPV6:2a01:c23:c544:200:c86b:b878:f9d:eec0? (dynamic-2a01-0c23-c544-0200-c86b-b878-0f9d-eec0.c23.pool.telefonica.de. [2a01:c23:c544:200:c86b:b878:f9d:eec0])
        by smtp.googlemail.com with ESMTPSA id n13-20020a170906088d00b00a3d2f55bc2esm515441eje.161.2024.02.15.05.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 05:05:53 -0800 (PST)
Message-ID: <c02d4d86-6e65-4270-bc46-70acb6eb2d4a@gmail.com>
Date: Thu, 15 Feb 2024 14:05:54 +0100
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
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] ethtool: check for unsupported modes in EEE
 advertisement
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Let the core check whether userspace returned unsupported modes in the
EEE advertisement bitmap. This allows to remove these checks from
drivers.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 net/ethtool/eee.c   | 12 ++++++++++++
 net/ethtool/ioctl.c |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/net/ethtool/eee.c b/net/ethtool/eee.c
index db6faa18f..9596cf888 100644
--- a/net/ethtool/eee.c
+++ b/net/ethtool/eee.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/linkmode.h>
+
 #include "netlink.h"
 #include "common.h"
 #include "bitset.h"
@@ -145,6 +147,7 @@ static int
 ethnl_set_eee(struct ethnl_req_info *req_info, struct genl_info *info)
 {
 	struct net_device *dev = req_info->dev;
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(tmp);
 	struct nlattr **tb = info->attrs;
 	struct ethtool_keee eee = {};
 	bool mod = false;
@@ -166,6 +169,15 @@ ethnl_set_eee(struct ethnl_req_info *req_info, struct genl_info *info)
 	}
 	if (ret < 0)
 		return ret;
+
+	if (ethtool_eee_use_linkmodes(&eee)) {
+		if (linkmode_andnot(tmp, eee.advertised, eee.supported))
+			return -EINVAL;
+	} else {
+		if (eee.advertised_u32 & ~eee.supported_u32)
+			return -EINVAL;
+	}
+
 	ethnl_update_bool(&eee.eee_enabled, tb[ETHTOOL_A_EEE_ENABLED], &mod);
 	ethnl_update_bool(&eee.tx_lpi_enabled, tb[ETHTOOL_A_EEE_TX_LPI_ENABLED],
 			  &mod);
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 1763e8b69..622a2d4fc 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1590,6 +1590,9 @@ static int ethtool_set_eee(struct net_device *dev, char __user *useraddr)
 	if (copy_from_user(&eee, useraddr, sizeof(eee)))
 		return -EFAULT;
 
+	if (eee.advertised & ~eee.supported)
+		return -EINVAL;
+
 	eee_to_keee(&keee, &eee);
 	ret = dev->ethtool_ops->set_eee(dev, &keee);
 	if (!ret)
-- 
2.43.1


