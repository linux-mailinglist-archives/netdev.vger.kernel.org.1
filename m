Return-Path: <netdev+bounces-167857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD61A3C96F
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 21:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A499B3B6302
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 20:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A9822DFF3;
	Wed, 19 Feb 2025 20:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0ayeQlp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809A722DFA9
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 20:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739996065; cv=none; b=nksXyFfoYDegPT/Hd3powfdJFjU71k2c94KbV7ws6OBbya0goXL8hMMXAO3YJJ58D+rYBYXTAX+xTh139rcDQsEwxCkN8+g8nvG+Piiib3p1N5SU4AwiNO79u8+DUIA2V88G5TYaW0FPl1acSKEyn/Oo8T/9n5YPYPyDGZCa+mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739996065; c=relaxed/simple;
	bh=ZnGfQUzoMcbiAcHdPIPzi6bV4RsX5hBV8RczItUUqwA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=VLTXHk4Nz1L7ogyIzsE/iE4DpAMgvX9nbxMz9rSHj8k6MssaT6qDKhW5y1eqBOLYTH0S+kmcFopDXkRqdx9txS4IbW4yKwyi+gIIFjYo+16p2yJ9GTGVgZhWKYSzhwg6zkkVCdU19aOXwdJJ+v8vHAMy3ovav08wYz8SpWVS9Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0ayeQlp; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dedae49c63so293982a12.0
        for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 12:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739996062; x=1740600862; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SsvkVzLYUFY5jTm4MOjOBTjmTMwPJ+Zb+G7fTXQ4L8c=;
        b=N0ayeQlp0nAmBT9AhWUHBsf4GakoVb+AbPZUjSttzinqNci1DvTPVpaFSQewnqStrk
         MaFQRK2iMBKwJ+xbRjuOqQQZ5neq7Yaog2ohBEw9hVc4SIqR6q6/K4LAIKz1NNqhMSUf
         qLu2a8qdCmy2qbK1R6nMr6zYEypZl/PlS/9hq/d5RY9gCR5FCO4867jvgB8qJfjTDKzD
         4hv+CTaukoZvcEx/Kavk+dS7GC41oLgKm2Sc1Q7UC7PNEFse+eBaMjgoKzI4Bgadlrvh
         2NXGL/wcs6E2B++7Z4DPxcuCHPU6qCJRXKLJA2BSRJS5SyXspog/9f5EzvpK8+6yqv4w
         HQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739996062; x=1740600862;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SsvkVzLYUFY5jTm4MOjOBTjmTMwPJ+Zb+G7fTXQ4L8c=;
        b=VVJgtqDZgPE+AgL41EFHJwELquJiF1Y8LEfK7o9siCA8gGR6tFppnIGYn0QOlHunnO
         vgZwGDxBrbTY7Lh6kDV/Z7AJuVJTqTYOBjKss2z77dwqIUox4KtTyxCZVx3gOUP6Yylk
         IqcBESRlBU1xfURwScQFx04BUGDyF1Qkbfh1SG2NLD9+EDwkxciWO4iTyzC4uJlqp3ZM
         nyJpR28dvUq55o9BwyAaesFer9zmYVaC1hwRR9tOSwz+Agv4aMxC7KuP3DWEsLiImSc0
         AIXkByLRkfPJtBHtpB4DXhmCsaUTkRujVhYIBWfmjOR8WJdbI0FwUjcw2JTrrVBtk1fT
         gb+g==
X-Gm-Message-State: AOJu0YwR4iO96uQZBK0lgWOA3jVyIc9GQw/25XzrFF/q9I6q39P0gJmQ
	PodihCi5SV7wW42PDHe4PLYBWmgLBi0HeMASWYAVOSLn6nA0NCHui3YdckaI
X-Gm-Gg: ASbGnct/sWRXgYtGPBwIWlUpkzjzMzIMY84nJCAD4EEDHUR7lSE7egwDaXqJEp7nFEu
	jMFJ3q884pcX2i9mlWfsm50LQ7RUH6T8gNSZOgCw9QgNWhc0gzoMOrp3FTb2nVutaL98PcRl/rq
	aNFCgj3jg/AsK9zqYOKpRB7I1EFN80qWWYHay6MbeWqs9+2JkEOOya/RNRoy+avi9y1WQw/SWQE
	/Z6pp6T4vMfUj2DqBRO5OWOwz/k1Av18KQQGU3JGI90DzXIKPZtwtenRSxQ3h8tkbpv0lUSvNCH
	M48DxWQe3m3Xe91F9jPqng+wEyixp07Ok/7cbhwnIVZ3+FgQUeTyIkBNAm5vrNA3eeYcip7jOlt
	qCFD2fh5pJhRYpNbvmXABK6KjwBbXkXCXTqnwATeVW5ZRBg/Nkk+DXfcbQsSjicMXjW4IZkplNP
	gtY+HLujU=
X-Google-Smtp-Source: AGHT+IE8m/mEzI3mrRlCDouYTal6GIlLPBKIU5YgOP2fs+nzrd90AZgnpYI5SdK5AQCiPMenyWGCJA==
X-Received: by 2002:a17:906:9d2:b0:ab6:511d:8908 with SMTP id a640c23a62f3a-abb70d699f5mr1695658366b.40.1739996061564;
        Wed, 19 Feb 2025 12:14:21 -0800 (PST)
Received: from ?IPV6:2a02:3100:a982:e400:6dd0:628c:981b:2783? (dynamic-2a02-3100-a982-e400-6dd0-628c-981b-2783.310.pool.telefonica.de. [2a02:3100:a982:e400:6dd0:628c:981b:2783])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-abb9d19feaesm630566866b.48.2025.02.19.12.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 12:14:20 -0800 (PST)
Message-ID: <b2883c75-4108-48f2-ab73-e81647262bc2@gmail.com>
Date: Wed, 19 Feb 2025 21:15:05 +0100
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
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: remove unused feature array declarations
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

After 12d5151be010 ("net: phy: remove leftovers from switch to linkmode
bitmaps") the following declarations are unused and can be removed too.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/linux/phy.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/phy.h b/include/linux/phy.h
index 3076b4caa..e36eb247c 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -37,10 +37,7 @@ extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_basic_t1_features) __ro_after_init;
 extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_basic_t1s_p2mp_features) __ro_after_init;
 extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_gbit_features) __ro_after_init;
 extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_gbit_fibre_features) __ro_after_init;
-extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_gbit_all_ports_features) __ro_after_init;
 extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_10gbit_features) __ro_after_init;
-extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_10gbit_fec_features) __ro_after_init;
-extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_10gbit_full_features) __ro_after_init;
 extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_eee_cap1_features) __ro_after_init;
 extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_eee_cap2_features) __ro_after_init;
 
-- 
2.48.1


