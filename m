Return-Path: <netdev+bounces-106361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34815915FB4
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 09:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66C8EB22FEF
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 07:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE69A143C67;
	Tue, 25 Jun 2024 07:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXuH7e/0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDCD1474AE;
	Tue, 25 Jun 2024 07:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719299416; cv=none; b=CqqDu2Se0bAy/K9/kVhwrGmhEQd2ihKGyg5ZWmjnxyI4SEnc0gaykZZoqPh2k04dsdAr80yj80XXENX+QflD7qDOc2+/yOmngtPl0KojFm9lS/PRDUQVfFTQJ4GMNJyK7/Yej1l9bEPpaUSHd4vHZkNgcn3dk51NeBo01XWo3mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719299416; c=relaxed/simple;
	bh=ZqZ1f29ytTmMjEoO+x+okDcWIK6x8cmCAWsT1Rq2ncY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=snspL6EI3pdmHTWVcMWvTvIv4TlVwLO194mYKc2eGbUVyLc2lnc4icYylW1rE9CZQOoBd+VED3RqMATK+LNq6qoBRhOeE5Icp2/cwh/ZIMu7ESg+H+87mBHThqC5U40bBpp5CzSqJvl8GbE0L83bTIlUvyr3v8KOgnOLp3I8VrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXuH7e/0; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79c0bc8092dso4555685a.2;
        Tue, 25 Jun 2024 00:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719299414; x=1719904214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CNs45/hkJ33QpKss6CbDBlR6fXOWs9/W3y/uZfvf0no=;
        b=mXuH7e/04fBSG1PzVzJLsGOc2G9f7uP7f4CwvmItyHWzRyep/DswFRAjl9vC8aVNUd
         qY3km+PgiK4mu7zFhsdDdy7aPK7pogekHXboWUjZWpr4Y6QgYmTY/lcG3ugeedWA6k3F
         fqmmTROzWrBSkyNRdJEIk7VYQy+Y/ZUqCzMzlAbziK3sgtBO/hDHKH9TvXWxMAaeyAH+
         qG4QKD6IEnX+6JbIYknT/Erg0DKAeD0rYJbyIm6djAYCwO6wkSXFT5fKJXv97PKVFkL6
         cTmRsLoeZs8nbvdjshi02suwHvGkeDbo9eIPFJb3fJl7lmzPRQ5gaTMS4rrBng6DbiGH
         VU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719299414; x=1719904214;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNs45/hkJ33QpKss6CbDBlR6fXOWs9/W3y/uZfvf0no=;
        b=l/eMn8fjY0Qh9Ir7K5ARbDqIKpuLeGIEtCPX1xn5bYBPFJlKQQUDTTXR9kRhTJGW/w
         gB9VSs1XCcPW6E/mfzatadTalztraokwwV/tPv691koXXtopw+i54UIu5Dr7Q/jeYHBu
         14dZZZ95XNGCMtHODjGPpUUDLt3KVFx5HzZkiKhwwPRtg8Qt7rGSvuqQrWSchM3V1zCk
         ofCtBId36xTb9SbEbX4YbfZMSDyvTPcgBwrMQVnZ+Ix8012Itv6/0BRdSoy2nmy6Wq7C
         23hC7zx27PisGfgy3L7oX4rwAx8jmiL7dgm2PR9lwoMeH49I6kIQ/ppdOfeS89sq3Pal
         PdDA==
X-Forwarded-Encrypted: i=1; AJvYcCXELhweHLpHbdoLwgo557mRelMFQRBX1nBJnKPnQ6QqKrpKeuqbVLR2f8VNhssaM5xB9pBUMee4Y72HjzSw4amabx/go4aH8qK6jhz4ih0E1DfT6SDW8ESzxM0moNsFbI3dJEQRqFaN8w==
X-Gm-Message-State: AOJu0YzkCQPfI3bG33eUKXG752xy12S93Er2WovU5B5of+7PKr3jU6In
	cDXl5Xwlazi1EBOXn3yyP9Yog9Y/AIhOGT25VBFWSChbK2+G865v
X-Google-Smtp-Source: AGHT+IHPdVvKpCxGUVkHRS3VnT5kagbcyrH4UQQFqmFwPeWjgTgqiPFiDviWJWLxA+9iy26HKS7DFA==
X-Received: by 2002:a0c:e0c4:0:b0:6b5:3bc:2205 with SMTP id 6a1803df08f44-6b536448c6cmr77328056d6.32.1719299413865;
        Tue, 25 Jun 2024 00:10:13 -0700 (PDT)
Received: from [10.178.66.211] ([192.19.176.219])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ecfe892sm41763056d6.8.2024.06.25.00.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jun 2024 00:10:12 -0700 (PDT)
Message-ID: <ab82fd74-cd46-455a-8d3e-b1a3072a5316@gmail.com>
Date: Tue, 25 Jun 2024 08:10:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: net: dsa: mediatek,mt7530: Minor wording
 fixes
To: Chris Packham <chris.packham@alliedtelesis.co.nz>, andrew@lunn.ch,
 olteanv@gmail.com
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Landen Chao <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Daniel Golle <daniel@makrotopia.org>
References: <20240624211858.1990601-1-chris.packham@alliedtelesis.co.nz>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240624211858.1990601-1-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/06/2024 22:18, Chris Packham wrote:
> Update the mt7530 binding with some minor updates that make the document
> easier to read.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

