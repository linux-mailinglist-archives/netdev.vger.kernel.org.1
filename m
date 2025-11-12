Return-Path: <netdev+bounces-238067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E20C53A14
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 18:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ABBEA507647
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 17:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A347343D92;
	Wed, 12 Nov 2025 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oi31aoAG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A5033CEA1
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 17:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762966949; cv=none; b=skby/rVDvIMK7dDEvnb8e0JJugldGceiGfv2gwrIeaB59bPKxJkoeAPgGYjO5vK46ungNuYfJT/ZBFWsqoE9PwgvggYAq0h3/5+oH5mjxZ/aI+0NiTUKUNmPsZyjN6Vl3oDjX7rZEDL1Ay222rSgRLrvTigEYyZwKEiHOGOweiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762966949; c=relaxed/simple;
	bh=ngNDA+yZ4zTUwtZtG5I6JVuMZQa4L9vej78HoJgmWmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R4yNysX2Ir+cCfuWweXsb+VUO7Y1x2BNwmio9SZEii194KUhJqdlUUgW1JE68ZUnWQAyiv4cZnUtYqKR+hyPaWvSqxvZQowxznO7S3l5JnuTfehsuNhOHR6dAyy25klmmX/DeS4DoKSRFWoeKO213FLnJNo9JYbNDvSJtKaKTNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oi31aoAG; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4775895d69cso6103705e9.0
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 09:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762966946; x=1763571746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RpxJUrH68rRTzK3W6ebRdgdts3S5XzYIMF8TSgTuh94=;
        b=Oi31aoAGL1nMlYO4k3gIK/VrlUUSqUjMbWbqrZb7AixDFm0D1S76WZ8MSH94nrotr5
         WWM0s3TvD3/X0uQ4l4iLKW67oW4jojSpXf7IHDoG+sFegGF1E6ShUaMye51AllJj8OyX
         0+3umsknEjlP3Qx7ad0nMEXdHmAV7dLvgd/NWPNcvkxqlKRgnhJkqjui+ybbO7elpsJs
         WYEp/VqK2zaKIhor/YYbPbGAwbdyq4Ga7bYx4dFvJq8LjRD6MOkJgPYTgKjJkarhCzMA
         4qX9jgYRARqD1IIhmZAn6QMqiV9lmpg5mvaKhH5CAP1Gltiy1Q5uyvbijqWCEFNyrNJb
         R2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762966946; x=1763571746;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RpxJUrH68rRTzK3W6ebRdgdts3S5XzYIMF8TSgTuh94=;
        b=C4mxsw+RVoi14BAxXGq94OCw76O6g6leywLq9Mag0yJAPCjChD73fBzAe4SpkFHJuL
         uGzqqhULJRyRY0yl7iKcFEJR9JcfNOELqoeO+vkFWlwxsEWtU4XYVnw8zdGR6w7fpOmi
         6DrIioeaM7R9DMsAO/X5SqxOHTBfuahA10cAIKpGsvcGmLQ5K+Au5tZEIUVw1ku7ACOj
         ydkO5hrED0T2Lq3tMGq2nN0DQBIR2k112jNYdD/VddrC/g6oa03W9oy1Jj+AmLrRSVj/
         msbGdL0LFRkTuGvuCtHZlI7cGwhpqjS53lf+dFyXUm6eHOBdKsXMQQie4d1x3JhWW8fA
         AKUw==
X-Gm-Message-State: AOJu0Yzfuv0i+OZMoCGwH4l82W10H9jFAP2cGqPB2dB4B+uBwgmJpgMP
	0WawncMvj5TkWqhu4lfYYdaumZc7XAidpGuZgeXloJUsaWil3ds8Jp9p
X-Gm-Gg: ASbGncuqYKl0xi4Ejwd+ii1ANIplZIVOht+mwpfHzsJo2Ptv5e+K/UjV6IIbiC6sdgs
	imAQa28foK1sq3tUebOPkFrVEBtzkVWd2sDmsTm+htkjEtLIJHQrCVOzqAETPCLH4Aexbsshp/d
	NggPfRyGawY05jBXoAmsgdokHAxYEVbgcj1mwtUF5ccZLcz5nsXNbJSd6HtviSKJW4RA1pjS8je
	MmqnWF2zH2gsOpE1LCkvu7FCGhQb1IwdyCyw7C2Ki30EMY6UcZB7Z5HRZGz4Lyd5A2riClyQ+qc
	yAjro/VM3L6mUK1F4qrUVCsudiEvrnuVGC578zGc/Q3xGrJDVP8FZAqKK1mN5Nblpm4ftgu9kYd
	SWCwFEKu5IUrLncqayazN9fMIsJkIBAyAjYGgTn+xZ3YmpfW9C5eBSlK5UjuC+Kx+wQeb5ufWfZ
	HhJ1dHl70SD4WsvpKY421oZokCeTmxYTHniVhPUSZhyPZGsySVmPpzwh8tIQMtb88E4pX344kOp
	W6JR3Tak9rBmSZc5ZD+9e01ca97CvcVA4pVbqlQ+SY=
X-Google-Smtp-Source: AGHT+IF3A2FgIRBiOzC9kR2tSI0jG4eAs6wb/P/xtcFVm2dyctb5r1FI1LpdlWldxO25ClS2vaHfKw==
X-Received: by 2002:a05:600c:3511:b0:45d:e28c:875a with SMTP id 5b1f17b1804b1-477871c33damr35789965e9.31.1762966945872;
        Wed, 12 Nov 2025 09:02:25 -0800 (PST)
Received: from ?IPV6:2003:ea:8f26:f700:b18b:e3d1:83c0:fb24? (p200300ea8f26f700b18be3d183c0fb24.dip0.t-ipconnect.de. [2003:ea:8f26:f700:b18b:e3d1:83c0:fb24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe63e131sm35578303f8f.20.2025.11.12.09.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 09:02:25 -0800 (PST)
Message-ID: <85f7b9de-9f00-4238-878b-6ba73ab01134@gmail.com>
Date: Wed, 12 Nov 2025 18:02:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] r8169: add support for RTL8125K
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251111092851.3371-1-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20251111092851.3371-1-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/2025 10:28 AM, javen wrote:
> This adds support for chip RTL8125K. Its XID is 0x68a. It is basically
> based on the one with XID 0x688, but with different firmware file.
> 
> Signed-off-by: javen <javen_xu@realsil.com.cn>
> ---
> v2: This adds support for chip RTL8125K. Reuse RTL_GIGA_MAC_VER_64 as its
> chip version number.
> 
> 
> ---

Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>

