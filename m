Return-Path: <netdev+bounces-228345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E152BC84DA
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 11:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0054E3E7B5B
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 09:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FDF2D5C67;
	Thu,  9 Oct 2025 09:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/mejTVL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BA5241CB7
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 09:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760002107; cv=none; b=PQP7fDUe0LXOgsVdh3aW3wlmgQMZhZMxpU3YjxYbCSllZjfE9WSv3xmALdi2iv+l2LqPaB39lp14w+tB0Y4mLvcTg0s0s4/U7px3g9YFofEckh7CHnczrddwSluaB4BULqb/d59x/vwF1P2nHBtJhqKSFKIcliURzYLe6njTMpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760002107; c=relaxed/simple;
	bh=BQczyE5Zdk5A2N+2sEJ3+Qj9fhfLVuv1k6SDtzvhgwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kHWA/dwe8Lk5iHzJq4aqXleZSHArs4w+eCTfjBywzEVygtP3Bqkwu7UPD0kzRiYYy8cW9rnhCtRO5amRDpo9mu35z2pl2Hmeb2brF7YZ/BoEesdkydYjNSdvmMnandRYXQGo3u6mxugvylx1sybxbrzVY0C50idKmPIXB0ElJTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I/mejTVL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760002104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BXHkdfv5tUm0CpyurnPpmySUCFcyGseszzZdpVNrQUA=;
	b=I/mejTVLwyHu4siBdvmC3pX+l5zwJg1Juufmb/ysGHQEaXOFS894y3fqj8fM8IPkOZr1Vc
	49PzrYZxrHPNzP1BlQvT00mGR03GYZbYXf8ekvdBIqu0+d3xa2STtiAvgLr1TC1XZs4BAO
	Z0dh4fW7Ga5WNBeRvDCbqHqT+oPKDa4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-Co-I5eDLOFOgHRI-Tte5sg-1; Thu, 09 Oct 2025 05:28:23 -0400
X-MC-Unique: Co-I5eDLOFOgHRI-Tte5sg-1
X-Mimecast-MFC-AGG-ID: Co-I5eDLOFOgHRI-Tte5sg_1760002102
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e35baddc1so8848305e9.2
        for <netdev@vger.kernel.org>; Thu, 09 Oct 2025 02:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760002102; x=1760606902;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BXHkdfv5tUm0CpyurnPpmySUCFcyGseszzZdpVNrQUA=;
        b=uyoe6Pw1l/7jmIozoqNa6FRWqdUjdNU0ayolu0st/Q7UZJ9xvLK+MVD9bDDK5HFH2T
         dBsEkC60yYmZvyidkJeynvij0jcseddnm2pd98BRLrUij84J/OPpjbMatq1tfA9+tSRS
         2kV4oqaCXJkA+KXNRKHdWdjBdYzwkq6pv77eU8wPH7HeAoddydTnbgb5353XExcMi7cS
         AY+CdBOQWDwDt2K7Wg0Tt2fcVQTi8hVXJM5119rB9qYKogtOZfkfAVWtH3KP7GjMp/L7
         28lcY/t5STOjpQDIoLxQJwvYWF6kYcGMLdXYwG1G95JUuq6CJwCm3EH01VYj359+Axhf
         pfzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOxZHAIMWPfQ6mn1JuAvW2O3u/3Peot+x+9caFB7/Ly66Sf98SmB6W/zKrbY5Aoor/hiMcJWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy68OGVOBBYvCKXLNBHB8jMCGH7qg8Ijerb5wUWPQ/LSW7WcfoM
	tLynzoSpkya9ioUG685dTtQwDgdX0wFP5z19nOk6Ydni4EWKwc4W1NcZMGaApWAG6RkqJ0zf8kW
	h43glG/j7Y5aXqOpxFip0dDuifVmowm4ATpPIWQbCbmmN0aIkFkSCVAI+vw==
X-Gm-Gg: ASbGncuSRqFJY12/e+v15P+gDBhJEEuLK96/vPuSEKGt+zBKcQNOgqbrhyIiaSZ6IF7
	6WeEybBaTJm02z43OtfFOhroCWe60zvsFyXeZQE9yELik9YCwg28TOogm9vs+88EPDzxyPdg2or
	X0UsATK11EuD/APZgLEFyNpGOTk26fk3kobUK2CELuE5n/o4OqWlCsHpbtyx9QjMnwVL8zpdvWp
	Zr6m1om14n+5pk0CNsfN5+uzxCb92D16rdcDJvGyCutGwfTNcDjF300dgVVUCssbGGDYwStsqFc
	tMl/F5aCzYjZ7npl4CXcwIZokZRBzkpuq/NtxzyelJYqd1+9Ex0QKerMxHhEAcDMNlp9oj8laDZ
	pWYEp5Uxi1/1GytQgow==
X-Received: by 2002:a05:600c:4e01:b0:46e:6a6a:5cec with SMTP id 5b1f17b1804b1-46fa9a8e5e9mr45746335e9.2.1760002101717;
        Thu, 09 Oct 2025 02:28:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY3/Xon/8eow6YV6te1PVIUeQNsTPhTN4xL/Kc6c75ZTtzIKnnqNPMPgFzo3E/3FgK5+ApKg==
X-Received: by 2002:a05:600c:4e01:b0:46e:6a6a:5cec with SMTP id 5b1f17b1804b1-46fa9a8e5e9mr45746105e9.2.1760002101274;
        Thu, 09 Oct 2025 02:28:21 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa9d7f91esm75339585e9.20.2025.10.09.02.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 02:28:20 -0700 (PDT)
Message-ID: <3184d938-5100-43f8-93e8-f88549ea4b72@redhat.com>
Date: Thu, 9 Oct 2025 11:28:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] net: stmmac: qcom-ethqos: add support for SCMI
 power domains
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Vinod Koul <vkoul@kernel.org>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20251008-qcom-sa8255p-emac-v2-0-92bc29309fce@linaro.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251008-qcom-sa8255p-emac-v2-0-92bc29309fce@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/25 10:17 AM, Bartosz Golaszewski wrote:
> Add support for the firmware-managed variant of the DesignWare MAC on
> the sa8255p platform. This series contains new DT bindings and driver
> changes required to support the MAC in the STMMAC driver.
> 
> It also reorganizes the ethqos code quite a bit to make the introduction
> of power domains into the driver a bit easier on the eye.
> 
> The DTS changes will go in separately.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> Changes in v2:
> - Fix the power-domains property in DT bindings
> - Rework the DT bindings example
> - Drop the DTS patch, it will go upstream separately
> - Link to v1: https://lore.kernel.org/r/20250910-qcom-sa8255p-emac-v1-0-32a79cf1e668@linaro.org

## Form letter - net-next-closed

The merge window for v6.18 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations. We are
currently accepting bug fixes only.

Please repost when net-next reopens after October 12th.

RFC patches sent for review only are obviously welcome at any time.
---
Also please specify the target tree in the subj prefix ('net-next') when
re-posting and possibly additionally CC Russell King for awareness,
since he is doing a lot of work on stmmac.

Thanks,

Paolo


