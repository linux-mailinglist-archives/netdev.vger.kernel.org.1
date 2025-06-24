Return-Path: <netdev+bounces-200625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B959AE6542
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2D2A7AD297
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 12:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6467127C16A;
	Tue, 24 Jun 2025 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Qu1pbB/6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0EA222571
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 12:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750768913; cv=none; b=P/7dQOEX1+C6AhPVAgVqTiqUO/RYfAPIcIfNe564mkAx0z2zsWhamrhaS9o7ANCWdhZHhckJw/CTa+EB5DvtYbiwQZ0eYPxlpDKPUohBbOM3MwCNV6zo2LGWY9jGbEqTI8NSZUl/WHvPPdUinEMmV6NQ+TRb0q+Bhm968PrT49M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750768913; c=relaxed/simple;
	bh=cXGzktznsPaCd9niYVc++U800pwYs32DegeREu5MQF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SRowAWWkAgHgqhRn4iq+noxmuy7gfS+o5DIkNs17mhF72i3NODAhVtxx/PDV3uqJV+bjFR3agWzBun0G1+a8h68WBa4G1iqOqfS+4JXTFH7fq7F28SUNxF8gnmu0hT6kaG3BrDmycMTFkef2EnviBiJleyisvg8ur1adgKkj+r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Qu1pbB/6; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60c3aafae23so847507a12.1
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 05:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1750768910; x=1751373710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4iJYQvGe8WCzmQmQubLMat5jwWy7Evztun3tUQTNGJQ=;
        b=Qu1pbB/6iKNe6kSnzz6Cwi4DReuOX07vtEWtioTerfKwSB+JJjKjm6GjdZXFjGSkwn
         /3+MAm9dcl/tfyD4QWb6z7u2U60c75DyPIMtO3GpG3cqbvPSSl59EaMI3ER1rFkN7a0B
         Rbn+D3zXR1JiYqIx2EQs+hVAG1eTK8oC1/l/QtYCn3+esg/eNTeOiybP7ZkuRQsKaUgc
         NJAxG+6/TESfjLTuWkjil8EaUTFZExt6hZ0o0h8nvJYI3zfpCYu+p1d46AHQmoBs90Hy
         EvS/NmwbLwzjsiG5gel33gap8764qEJYU24goJmY2Ogx9D0V9nFHExDSfpnIhJI/UVlO
         yhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750768910; x=1751373710;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4iJYQvGe8WCzmQmQubLMat5jwWy7Evztun3tUQTNGJQ=;
        b=f1lwMIgYFm6ltqFEk5Af7yDAd7JYxkTNCY7RtHqtKu2vV6fT2A9JS/KQCf61e4Y+5R
         jnjW9kLnzV5ivpAe4ANuelysy0MDGtd8eNe1Cz4UlufEwMCA+7l3e+x/T9LIPAf7EGay
         Hx/kF7mwUjoFyv/zez/a4m+3+92qxPAafdv4MgnrfV+INpRueT78WpsZoRXVKxc/lYI9
         pXK2l4M1PNLwgVHMp/tUeB13/nQWxIsfCcNaJWfJbECBSeZyRFO4ZFZ7yY2eRtdj+ygV
         qyuKxjlkxDqvdFzTNkMnXRLapwPP0UALRUVOMysX3Nj0gyJiyPMBTU2kyVNNq6NnZrFK
         eHcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhsCzHvJGVdxUBHERFIqRZ10vTR9/5QNzW3bntQHzVLHG9beTY90UqUqqln9JxXVX46dz8sw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZGTF2MPsBuXLcjqU3lNokrzhpUleH8hCNucG9F4ShMw1JgU07
	PHAkhGRvt/yG2YLzAjonFJCkYOhGmDcfMcER4CUIjSrEB+7dxElYJ8NLw2xAp7Olhw0=
X-Gm-Gg: ASbGnct9xIeIoWI719szfANoENjNk71Wu1tUJaUpKA6lqLbjxL7ekTe8/UAYo3ElNpi
	OtYPKQzzcEqWQ30t7K+MUx8z3OnX2fI30bd9ovOldaqEmi4WgD/SfavJR+dlv7wNwuKNjS9R2uZ
	Y2Af5UcPPfjNQtE4uAP6NL+6Rk62jRB25Jej3NY27yfHQkvQg1xKMXY7hTGrCBYDUnB2vrYYLeL
	QKPwEDXEaSav7WeMvwDT9mzrKIYlNSELBtQ6sWBmIjiNgln9GL2Oj4RYfJOC9dPs5ym2Kqeh4/C
	iwB0GLNTTOBvMdkE1Cn4mHE75RwT2C4M1CwLTb5lg7QafJkXSoZ8VQaxPRqqxSByCfxwJFsSRrj
	iakDbUNhA6FgBLY/KPQ==
X-Google-Smtp-Source: AGHT+IGXmUe4yUvnAnWDcICMoNz7pR9dQh11kqyZfBlXN8ECSr1NR39mxMd3RQDLoTWSrCl/S1IVzA==
X-Received: by 2002:a17:907:7f2a:b0:ae0:a351:6208 with SMTP id a640c23a62f3a-ae0a715cf32mr298541266b.1.1750768910090;
        Tue, 24 Jun 2025 05:41:50 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053e7fbd9sm869476366b.33.2025.06.24.05.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 05:41:49 -0700 (PDT)
Message-ID: <efd218b8-df7d-4d22-a22d-8c8a59c171b0@blackwall.org>
Date: Tue, 24 Jun 2025 15:41:48 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next v5 3/3] bridge: refactor bridge mcast
 querier function
To: Fabian Pfitzner <f.pfitzner@pengutronix.de>, netdev@vger.kernel.org
Cc: dsahern@gmail.com, idosch@nvidia.com, bridge@lists.linux-foundation.org,
 entwicklung@pengutronix.de
References: <20250623093316.1215970-1-f.pfitzner@pengutronix.de>
 <20250623093316.1215970-4-f.pfitzner@pengutronix.de>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250623093316.1215970-4-f.pfitzner@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/25 12:33, Fabian Pfitzner wrote:
> Make code more readable and consistent with other functions.
> 
> Signed-off-by: Fabian Pfitzner <f.pfitzner@pengutronix.de>
> ---
>  lib/bridge.c | 72 +++++++++++++++++++++++++---------------------------
>  1 file changed, 34 insertions(+), 38 deletions(-)
> 

+1 for Ido's suggestion to remove the blank line, checkpatch isn't always
right :) but it's a minor nit, looks good to me overall:

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


