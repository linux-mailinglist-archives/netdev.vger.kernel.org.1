Return-Path: <netdev+bounces-69901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 342DD84CF30
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 17:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE17A284A8D
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 16:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC71681AA9;
	Wed,  7 Feb 2024 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xvx06St2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD38446C8;
	Wed,  7 Feb 2024 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324184; cv=none; b=oOWpUzmp5vRT06nuTjjL/i380uv3Fc3jonrS1YBLWlSdhgNkPHPxIwZTK9gfKE2RLdhUZ3qHoheE6+cNm6bIVOYqNaHovvsA8pWUHCdhXnkh+u+G2LyGOSOIbVbpY5f1Dvx5YMjaSqCeRp2pC6Z/9hSZLTMpsV9Ei5LM24iuotc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324184; c=relaxed/simple;
	bh=dM9aSJOtmobHSxOQ3ThvJSH1uyZwrF91Rs+r30p1SzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FeleAXLm4WZ2+s40aMuvoyJD8Iy1n3q0i7DqDIqqMBVimgnXScq7PnJVScLHcNOAbVZL4+rSdzo5vAV+HKwBQPGl8m6c9b8mMn2EvqCqw32ZsS1ZrRlFOwaMV2No6e5XZxZ5sLuZVfL3RTUv4m+Q0uQNokvmGxv8B/LfDSIMpw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xvx06St2; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51165a488baso1096875e87.2;
        Wed, 07 Feb 2024 08:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707324181; x=1707928981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wBOK+c3+hP2qQWcAN44E5Gw5lPmBwcFuRFbj0SFINPY=;
        b=Xvx06St2Ym8tGKQGBi4D3X8qjqWpPvPMzqGLsbcha69BcPLrB60l3bosAN2vAcMkiw
         /axuimKpomLF/WbAFaHWAVLEsfX+ULLhbqFAk2vtAtrn5tmD2KJ6aNAf2gxquAtPMk8B
         mObDagxd7LJAIRHxDQ+ScOpO+TPU7+T5BoZEfRsV7w2Pi3OaqWIGWOf3udOWDuNUV0hL
         RfPW87U/ZIkNEuC2khW7OitgawQHbNRoI9UIa5qYBwNWvLBUBHVqprwQSocNVH350kOS
         SI32faVJ6mWlcx5q8ILfvnBRDdRKF+2OFLL182rBK4o6mSaO6w+RL06yfKsoLzqLX953
         ct/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707324181; x=1707928981;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBOK+c3+hP2qQWcAN44E5Gw5lPmBwcFuRFbj0SFINPY=;
        b=ELdWL80uA4wwQc4c+OqRuN0gXhQKpBF7Z6ocpF9BZgMd0jEip1nbIhk833Y5AEe2Kh
         ju6huQyxpGHzbUpjDXQ4aSEfVTljXmxlPj69dSvBKHdvinuN5NRcvzIT2EOWHzhOFIjD
         BTQZyEVIgwSg/vNpVfMuwXgeuziMtuH9LDccYyfcY8kBl7D4fjpE9plVg4d2Kv2ZpVdn
         L5ch5InB1lHON+cZKj+o5kBlJLrfHpvIlNzLdjnmDnvp7xrtfgVFdSrWZFgSWjrElJl3
         l4duC/ksuE7l3g6YBsxG7H/qTq0IymcPMHGvaIAzOKCsBfoC2tm3LjCF9CiGI36KaKKg
         l7oA==
X-Gm-Message-State: AOJu0YwdLcAJ5HfwbAfsUS0nSLiENHlAkFNc5B0cTEH90jPoAH10KruW
	R5SG+RgTlzLenaXfBAdWeiYyWkD8blhqTpZqrTReuUe7VkqUn6wb
X-Google-Smtp-Source: AGHT+IEZ4qttvw0sChR5/tIcPFpecv2+IF6R+I/BFE+8rJaehlfzgaWQiuo3Ntl1jBI/ajGNVrEC2Q==
X-Received: by 2002:a05:6512:5c3:b0:511:5a3a:aa0a with SMTP id o3-20020a05651205c300b005115a3aaa0amr3973577lfo.20.1707324180765;
        Wed, 07 Feb 2024 08:43:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWFG/mJ+Pe0N6iSGxjCKQfdasT38bhEWs4RZEFxLfrDYUoKzQLD/wT6CJLQKi4tHiMWj7CMkXgLtMqdBrXYDjfjbbiBj60Toh9fhJ0Rf+TBw/idvqH+71N+k9XVF8H6ya4w1fIfR5WPCsuwY0t56H/sDSGFSV5qYVe+EuIImiz+XKQ5w07N2pVwZMy1gQQ5ygGatl/s+wVqOrQm73VBIh5s4phkaGpY06ghdvtecJLbFZamI9fW2n7hiKrfWWrV1OEEZIZrqecFtB4q22zpLik/6w9CDO4nODT01vCnaBXs0Y1YZBGlHyCdOaSEFmdg3sZICfV+ZJ3sKEv6TCTz/1hZnIYpDgqmsukm331mScxOALoLpYNxu8IN6rWspPmvMqxalM7QHCWKTnvGg2Ep6/f0nhqYktHaaOuvGDcvPK9so7GDCxTugmS1XslZ5lCLyECcQIUhkvn1BzKUzln4wNMKwcA8zPoEEL37U5+j4SKpUro6MU5OuaQBYDxiPa5edarWlMG3nEUNsz+PY0g8HHtsfZ4gimPBUo/aBrR/MGO93g==
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id q10-20020ac246ea000000b0051169bfab0dsm94715lfo.68.2024.02.07.08.42.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 08:43:00 -0800 (PST)
Message-ID: <f2b4009a-c5c3-4f86-9085-61ada4f2ab1e@gmail.com>
Date: Wed, 7 Feb 2024 17:42:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: airoha,en8811h: Add
 en8811h serdes polarity
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>, Lucien Jheng
 <lucien.jheng@airoha.com>, Zhi-Jun You <hujy652@protonmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org
References: <20240206194751.1901802-1-ericwouds@gmail.com>
 <20240206194751.1901802-2-ericwouds@gmail.com>
 <76f9aeed-9c8c-4bbf-98b5-98e9ee7dfff8@linaro.org>
From: Eric Woudstra <ericwouds@gmail.com>
In-Reply-To: <76f9aeed-9c8c-4bbf-98b5-98e9ee7dfff8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Hi krzysztof,

I mistakenly thought that changing from rfc-patch to patch, the number
would reset. I will mark the next one v2, or do you want me to mark it v3?

I have been using realtek,rtl82xx.yaml as an example. I see all your
comments apply to this file also, so it would seem I could have chosen
a better example. I will change it according your remarks.

>> +
>> +allOf:
>> +  - $ref: ethernet-phy.yaml#
>> +
>> +properties:
> 
> This won't match to anything... missing compatible. You probably want to
> align with ongoing work on the lists.

As for the compatible string, the PHY reports it's c45-id okay and
phylink can find the driver with this id. Therefore I have left the
compatible string out of the devicetree node of the phy and not
specified it in the binding (also same as realtek,rtl82xx.yaml).

If you are implying that I need to use it, then I will add:

select:
  properties:
    compatible:
      contains:
        enum:
          - ethernet-phy-id03a2.a411
  required:
    - compatible

To the binding, and

	compatible = "ethernet-phy-id03a2.a411";

To the devicetree node of the phy again.

Best regards,

Eric Woudstra

