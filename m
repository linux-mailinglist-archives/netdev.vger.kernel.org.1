Return-Path: <netdev+bounces-115101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E393E9452A8
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 20:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862FA1F23F49
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 18:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC5413C901;
	Thu,  1 Aug 2024 18:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+sld5lT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D34F182D8;
	Thu,  1 Aug 2024 18:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722536488; cv=none; b=VVkIvySG6UGVlMghE/Vqr2y0ynwP3GaS5pSE2nGSsufKNXA6ChgKSBAACS+ZBDh7mLHRLBM7qTzmcBbfRxoTsPhHROHrJ+X4Y6nNVOJu8QAK5iSzwKbC4ogGeLALCCMtm0Cg0yEEy+1xp2+2HXMxTwLFJSsxhYcn2SSIdx3cjoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722536488; c=relaxed/simple;
	bh=ZrfeY8gFpftPtIhjCK++NCKwfW3eRyrt7pDu/cIuqCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JnY/rEWl46yP+bg6UBH96nyD/WBFV/mnOaA8UwF1th7y+NHwpEd4Y/+M3DtLgPmAjRYVZA6LAMCjjUKME7ZHzOJpy26Xz/Q8tkIS6joQg5X5sb9IjOwQUniU+vs4mxxi1XrwAlnCpFY+bitI4IfL5HVTr2VeWVoXjFqfOCcHlPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+sld5lT; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2cb52e2cb33so4918885a91.0;
        Thu, 01 Aug 2024 11:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722536486; x=1723141286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8xicDpp2Pybe+VM3D+eIlwcNQ7VkGdkDp4enPEYyuvI=;
        b=J+sld5lTlHkb01FwjI1y4cRIrjLwUu+/U1yCIdhkYviknf2qYFm0tcqXgBVsY4IEY0
         GBji6Gg2V7DDE3fTKuq/9Mjr9BC7lElqxvBm4mT2IiuQ3BcTdpjVxVRaZBLiDI3Jmkdq
         SZZSb90XWXURMEAoIb1HaXwOqZjr1ayySPrPwqluCbvMINID3yNCZBG/r/NXVIfESaBF
         VxwKjiQnIrVW+1/Ko6iq0xBu2mONfsSWorH2KWX2X+C7McBVQ0BXbr/RnM1ok+dEWypv
         ude8oGkHZButlIXvkKv6XV+1WLKPBYwZGbMQDuJQL66DeCP9SMWXBppFdAzx5cDdnky7
         3KdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722536486; x=1723141286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8xicDpp2Pybe+VM3D+eIlwcNQ7VkGdkDp4enPEYyuvI=;
        b=MWzcho7nYt3j8cokNXBIt55HZv7MG6IiU2sfnCTexd3QFV9/3YkCAvWJJGsPvc7E+B
         ulvF9lILQfHo48RKhq/wanv6V6MIyzLnI07UpYwu5XMffwKBX3YHm9MZWm62V6vEE3nM
         WQkuVsKNQpu7sjdpneV4hVNkGcfrBPYIG6dPtUhVgJkfMZnDYJSYqGDKPvjSmoMMF+9M
         E2YCnMO+QqGlJ5NEbXlwajaHZF3RPWBArXjvCtOdJDGmcQa39TiQdf/xHnmtZMxw3XRa
         /qumSH2PR0vsekL+H6J4FhQOLqTFnsQdDxw1CtHyb9SG2xiscA5AoCwXqep8LOrJAuEj
         nrrA==
X-Forwarded-Encrypted: i=1; AJvYcCUf9MQOaAA8cFS49CD2Q3yE9at/yabi1lDmC0pIPV5iK2qzeNDwDzvlrgfaxHfM6o69waQhLiEplgR1xfWgM5brJvzHHPEyXjc2STu/Im2wjldqrRIvn9z7aSSLO32jaSeZ3Q==
X-Gm-Message-State: AOJu0YxaQhnAh9KcN7T/3d1GGtuptzwbDkxrIuu59bzb360NFimIRif/
	TBfObO+kJvP2MxUfL40lvVP/1LU+FE9D6vumXJJ7n8YnlHkk4c0Z
X-Google-Smtp-Source: AGHT+IElt3mXJkSXP29i902rBSXpOxzh9qQMuW9h8m3PGOg9TjhDId7phPJigjHSBnWYVJ9bWg+izQ==
X-Received: by 2002:a17:90b:4d12:b0:2c8:5cb7:54e5 with SMTP id 98e67ed59e1d1-2cff952d021mr1260405a91.32.1722536486216;
        Thu, 01 Aug 2024 11:21:26 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2cfdc4cf69esm3690327a91.35.2024.08.01.11.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 11:21:25 -0700 (PDT)
Message-ID: <dfd6dccc-f82d-4642-b4a9-30d3b8ee308b@gmail.com>
Date: Thu, 1 Aug 2024 11:21:19 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 1/2] dt-bindings: net: dsa: mediatek,mt7530:
 Add airoha,en7581-switch
To: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org
Cc: arinc.unal@arinc9.com, daniel@makrotopia.org, dqfext@gmail.com,
 sean.wang@mediatek.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 lorenzo.bianconi83@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, upstream@airoha.com
References: <cover.1722496682.git.lorenzo@kernel.org>
 <f149c437e530da4f1848030ff9cec635d3f3c977.1722496682.git.lorenzo@kernel.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <f149c437e530da4f1848030ff9cec635d3f3c977.1722496682.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/24 00:35, Lorenzo Bianconi wrote:
> Add documentation for the built-in switch which can be found in the
> Airoha EN7581 SoC.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


