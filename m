Return-Path: <netdev+bounces-228903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B0DBD5C1B
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 20:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E737F350F8F
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 18:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3CE2D7398;
	Mon, 13 Oct 2025 18:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiKepl+L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCA927055F
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 18:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760381001; cv=none; b=Ncgr7Knm9nmPQGYV7yGQ1zr/93GKhByXjZmBEu3GLkNaPTiYzEt3UwsR6wQgnBareeZBSISsy2rFiCLgl0p5g/4WgnrXj9PkfopapvqUM1sE93Vtji2q1zcbVIMj4sxV3meHhzuGlx2U/cZulFyRmzRJ5MIQeS8RgkGTfXO1dCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760381001; c=relaxed/simple;
	bh=cK3Q/GKRGQa66ZI/Mdbk5VVntqpmTjc2YE2ardVQBBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDP8bkMYInHQpr1bshHHGt1cWPHIjbcDBjNvYA+zFXJcTx+opU3xkm7WOluDufzHhdchH6jEcmZzfCsjZiFLCfM9snoC4P62sSFAyPcmVmy8be9WHP4dWSaGQ4l5BRghICxLZvBJiA8V12kvjF8OHTLgjjpnjo5qxWD614EeKwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiKepl+L; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42568669606so3330547f8f.2
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 11:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760380998; x=1760985798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WJjHP9rcpNHEPZhVPAqBOx3rwvBPa3qqjA4yW6apwA4=;
        b=UiKepl+LmAg8iCcao1cGEdoBuhTyu+DpJSQlpBk5X9rlNhti3TTuo8DX0uXxswXAM3
         /nGNGrmagkaYklCGyOKntYRYndbYscA8DO/aNRqkYOOpB3wKA2IlIi5O2eDBfLMgxZ5g
         klumlExIeOpLvEBcSjq89sZzhubLN5LcZHrE226xrMACgG+GLc3R5PLIUBT7JnoL8Up+
         Bzo7gMOMlRAZjXRMcIwMXG5WvLKi8n8PMhzIjHnClk62f9/t8K2jZPeuVlNWY4MY1Caf
         3kt30N+oSkrk9jymS6Cw0VR8HyEC+OTx5qfteQubxgCJIgj8MLlqV4W7cG5RG/RjdjnM
         juCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760380998; x=1760985798;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJjHP9rcpNHEPZhVPAqBOx3rwvBPa3qqjA4yW6apwA4=;
        b=tvdXf4D2a2lCfWBnDWP1aDH7d9KjPtoIhC5B3Zf8FtujpRpP18e0f7oGhYFTifnIwJ
         DAhF73RjXdmz7FcZFgpXrA3lbRTJGlYk8v3i2ELCOm5OfbvH22W1rHi5WijDOGuQDW4m
         3S6m2nlHF7jCVdB0akZVhMA9qGC2APvlg/G5F+Z5YfSV+SP6O8Cca/HyBuH7n/3iWKBH
         OcGvXML8k6621etJ7ahA4wdV5Vm2wiSjXMBesKkoDIVoTcJy2qhg8oiD0hTY8X7R1m+1
         xrKUKNZT4WZHb9pH4//bVhX87LdS/f9v7BzAyu07BL11UJ0NLFCBykHNt+ScHWAexm1J
         yBWA==
X-Forwarded-Encrypted: i=1; AJvYcCUzkB/C/wltRFoO643SKQxvRQ7rQbEIuOlMqM2K1FLJ1dB7FAIlN9lnM/vz+j+n+oa2PpE4HXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaKfv3bCU/ZJ4pG0kLujp6SP1eSQEbtwXi1OPHr8M53yQhNI8n
	dlfv6lgJ9P7nkXRBie+uD24F8+lqwUaS3uf6CrUdFK8cuUR1aXsAveBOsiH1dA==
X-Gm-Gg: ASbGncuMaKpyx3CDEwMaAYi66Goy9AI3f3Jo/BT7MI9pP5vH87S0jc4kRhj0s02Ci/E
	YEro/otvNmSFaLJjt9HneRRyuoR/YZu3f09GZZ/7PcGPPlL7Gv2aeU9L2EHk1wAVi5MJgC4PDfU
	XudFXKhG9PZa6tLFtxqeeEFpX9OUygk8H1OJG52SHxsZq9+eHdSlPMy8EhPTqCzYJgx4NFQl84e
	LB9tIOptfIUKjPlrPv2ElPZqNarjsAgk0O291IaDZU6T21uyc5L48p4i3IujvffhaP8kOJk9aX5
	BVFONyHkpgB7ovTMsu2ngAnd9DlIQlIUBbCKKTouWMRoOB2mfeB0JSFy8aIy8Sc5yEBIxrpo6Rx
	mzlA1ygnVPXyFmvzarH4wG6Qx6UAGzftJBHxHipRQDnERiFPt8BDSxFRNvED4xmOtBlvFxzh4da
	WyDMpKA22s3t09dz20ZheoNYRFfPXCusM7C5rmEvCD0G3LAQmgXQS+tW9FNkQa8gFqjVHNW0WiX
	+KRfDzk
X-Google-Smtp-Source: AGHT+IHQxCyPwYFe/gZoQ+jypd80ftSxCb066ALCxOmBQh0lPbF6uLIkueKiHkwgxHfhBnb4YpGrtg==
X-Received: by 2002:a05:6000:491a:b0:426:d5a1:bda3 with SMTP id ffacd0b85a97d-426d5a1be31mr7050225f8f.36.1760380997781;
        Mon, 13 Oct 2025 11:43:17 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f35:3c00:45f6:d7f9:ba96:7758? (p200300ea8f353c0045f6d7f9ba967758.dip0.t-ipconnect.de. [2003:ea:8f35:3c00:45f6:d7f9:ba96:7758])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-426ce5d0006sm19722120f8f.34.2025.10.13.11.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 11:43:17 -0700 (PDT)
Message-ID: <41a2108b-2125-48f4-8478-ccd44281380f@gmail.com>
Date: Mon, 13 Oct 2025 20:43:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] r8169: fix packet truncation after S4 resume on
 RTL8168H/RTL8111H
To: Linmao Li <lilinmao@kylinos.cn>, netdev@vger.kernel.org
Cc: jacob.e.keller@intel.com, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org
References: <20251009122549.3955845-1-lilinmao@kylinos.cn>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20251009122549.3955845-1-lilinmao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/2025 2:25 PM, Linmao Li wrote:
> After resume from S4 (hibernate), RTL8168H/RTL8111H truncates incoming
> packets. Packet captures show messages like "IP truncated-ip - 146 bytes
> missing!".
> 
> The issue is caused by RxConfig not being properly re-initialized after
> resume. Re-initializing the RxConfig register before the chip
> re-initialization sequence avoids the truncation and restores correct
> packet reception.
> 
> This follows the same pattern as commit ef9da46ddef0 ("r8169: fix data
> corruption issue on RTL8402").
> 
> Fixes: 6e1d0b898818 ("r8169:add support for RTL8168H and RTL8107E")
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>

