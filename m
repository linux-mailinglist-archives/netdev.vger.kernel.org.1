Return-Path: <netdev+bounces-136631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 046909A27D2
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEAB1287652
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B7A1DF24D;
	Thu, 17 Oct 2024 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/guCUie"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EA91DEFC5
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180879; cv=none; b=kpRpK9Sdl4+/BGcDZ/sB2QmByZpoKcDbenZIbFv8sWyfRJpj3T7NbHeyoapylkjA/0Tfu1irAxanTP/RB/PTXHoFK7w2/tQSIm+46EHYNaKqwf8iTj2hMr72Go4nXAwvs6//KraBFU7bNHhw5fa/H9Dv0DhdglH4k6f+0fSCisY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180879; c=relaxed/simple;
	bh=S5X/uVMCC6mmhZLaLnzogCah5dagKy4sZjyxTopYVe8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Oqbu7KNF3iSsEUp8KC48v4zmySf2Sn2XoWe7W29LEWBwLj3MWyEvqD/ihjU+I88C7s/hYV45nxW7fZfmgGIX8syUOJ5Dv2ZcofWzhgg0MiN5jrqHbTGuJoRteQbGJn4JnrD0H6BOEs4RtC2V7HWuNtdsK2VEIY8wbpGQSeU2Ies=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/guCUie; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a0f198d38so168009166b.1
        for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 09:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729180876; x=1729785676; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdE99R33FY/Y/U3IwVB9TpxYAmcdXJnwySR1rbpqamo=;
        b=I/guCUiekVFeAcA9TijxOmz1oIF4mp/0ZPF9pfQUT5RZaEMUevBnDs+hA9aoqymACd
         RQ6wBGxsnp9MDIIT9op7qI8IN+LO2ppLaXK+7AR+LF1m799veDG4G02hrwQMFEDrnEsq
         pxFP/6iB44Bx6apKghs6kuXU2Cfh7TVZMyYj3E7x9rCmbO/YnT/nXdB8Bqtzvo4D139A
         gJMC9EQdmunn/PJVtEZp2S6X7bXCqqvwpIZw968rEyc7LG5XSevOqbkM36mOS2epX2Pc
         eIrAZgtzgJlsFVbb8EAadUDmKHaq1cRQum4sWgMq8Y56z1COKTI/e+ODRLPxk8q+/s/T
         RhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729180876; x=1729785676;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JdE99R33FY/Y/U3IwVB9TpxYAmcdXJnwySR1rbpqamo=;
        b=LebIQjUlVByW9SfiTm9X9cNzq8i5hHZwXx35fnNKcEEDf8ioxuOq1qfwRoJ2x+DHQF
         ki9zAQuI7Ex/3YAMadsbj5i4dCmnBL3j8ed+s3QbfvnW0yO7vLv2OoHxKXAZknyHvLLu
         HntTCPVTtLg8gDvmHjk3ep4THdO172YFDJL1tKOwqqSvMDQFHAc1kR87q1Wk7zx/XFq2
         HzMO19ry2rrBAAd2Q/wckr99mQRVZRmUaBmfRYw3eET7j7jQuwwzyboMj8fyRp3oU1TJ
         OFMBuGRPt/fkZ6KIgW7qjM7JSU5SvKbc+eCoOFI/YmZTKiJSzQHtY2/2181Boc/+BgpT
         BD1g==
X-Gm-Message-State: AOJu0YzD/fjT5DXi4w7rt+Q0g9GCsBOoEisD/teqhyWvBHP5JJ+ns9pO
	EtYHMcmxkjQDaWPVIC5X2Uo3eHS2Skek+g0YA52aHuaPEjN1fZa+
X-Google-Smtp-Source: AGHT+IGernB/4yaxSXF6WQzyo7uIpTEXqy1wE2pn/LBdk5of+baA8sP81uxzIb5ZNjEMoiwafw735A==
X-Received: by 2002:a17:906:ee8e:b0:a99:d6cf:a1df with SMTP id a640c23a62f3a-a99e3e445ebmr2072449866b.46.1729180874842;
        Thu, 17 Oct 2024 09:01:14 -0700 (PDT)
Received: from ?IPV6:2a02:3100:b38a:4000:ec28:59f0:fa6f:9fb6? (dynamic-2a02-3100-b38a-4000-ec28-59f0-fa6f-9fb6.310.pool.telefonica.de. [2a02:3100:b38a:4000:ec28:59f0:fa6f:9fb6])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9a29740f93sm311473066b.49.2024.10.17.09.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 09:01:14 -0700 (PDT)
Message-ID: <7d2924de-053b-44d2-a479-870dc3878170@gmail.com>
Date: Thu, 17 Oct 2024 18:01:13 +0200
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
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: realtek: add RTL8125D-internal PHY
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The first boards show up with Realtek's RTL8125D. This MAC/PHY chip
comes with an integrated 2.5Gbps PHY with ID 0x001cc841. It's not
clear yet whether there's an external version of this PHY and how
Realtek calls it, therefore use the numeric id for now.

Link: https://lore.kernel.org/netdev/2ada65e1-5dfa-456c-9334-2bc51272e9da@gmail.com/T/
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 830a0d337..8ce5705af 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -1114,6 +1114,7 @@ static int rtl_internal_nbaset_match_phy_device(struct phy_device *phydev)
 	case RTL_GENERIC_PHYID:
 	case RTL_8221B:
 	case RTL_8251B:
+	case 0x001cc841:
 		break;
 	default:
 		return false;
-- 
2.47.0


