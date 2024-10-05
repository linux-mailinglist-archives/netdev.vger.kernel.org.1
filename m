Return-Path: <netdev+bounces-132376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B60FB99170B
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 15:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57251B20D95
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 13:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D621537DA;
	Sat,  5 Oct 2024 13:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="IAWsfLgI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29679145FFF
	for <netdev@vger.kernel.org>; Sat,  5 Oct 2024 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728135569; cv=none; b=e7jneamg+w1UYSvp4u0EwClILPzuDODhQo9MZtqM0MM2ibX9yzTU2mjtHWFIslMCZWwW3oF1/ikljeNhMHkxSYFZhMMQwSHxxNDcTmsluTkzVWAZxMz0J0o6W4Hf0UHpyKgxXPlpbxRej6uqp0CasXRFtpLqJugP1rdHpbb+HCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728135569; c=relaxed/simple;
	bh=WPSNbgCRIOzuJvywBwwnI4D7zl4+YhX+vKz5RnNwEo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pZ9zMZ54euYdTymxU1FHFHnewDRdVlCwwsdbuHFp/JATutcv9fKcRpiZR2P8C7r8UayFzWAicORgCtyF9kjdjojUbvJZMJXfDmOhTdiIAgUwTm2AxUW3p7mM7g+pK7BgFiSTQ61dhvfv7atHFAYtK3aGaoWtPePH30yE5yyLp3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=IAWsfLgI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cb9a0c300so26594795e9.0
        for <netdev@vger.kernel.org>; Sat, 05 Oct 2024 06:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1728135566; x=1728740366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/dw2nlO1YbFRY+slXgiXeePfiGcRPzzcnM5E2TwM1mw=;
        b=IAWsfLgIqu7kKgmWoo5NVUpHsl7RpD0J95czYZBBDLILtezoIhdDEWL7a0HwdVvRk8
         tzlyVrKzHlgLjlKuE+V4/iCKrSYaWsufhQ4MI+PoyL94CPxEwW4S3Ywst/hTg/7DhsX+
         5yO7K23nyGf86+Kz9ptoXnZuqslFpksh33TcGCbS+IbxTOcUvilch2GmRdsxsD96W5hg
         XYjgKAGpAd7vCRXQKT4OqPiyN3j9NWt/BiPzftn2+uhteFvCRW7q15DD4ruSQ9u2n3f9
         CwIkmYuVM2xsXm2DWBhOQ7kR9gIYct7ClLoO6aTJ6K3UZPkDHz8MhaMToYUDQT2BfSuz
         rr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728135566; x=1728740366;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/dw2nlO1YbFRY+slXgiXeePfiGcRPzzcnM5E2TwM1mw=;
        b=MwgHO0XmpGdnwDmaBOI/GkrO1r3GWdN2YfaSCaBsjAbEgjd+PH1LV7z69I07nZBzsT
         WcoP3T6KC2ame8rGZqPkWZ1sJLtutod6WRotn9nwUMyQk5Q2tnKNb14H0oZrbOjxAuP3
         z55M1m2SsV1Al1JkPPk9uUu1PAFkrqLqyCixFpe1UBebzoo/FWOJGU+Dc72SiBDGWIvQ
         OwbLiPp8hZhIH/IeU1Ck5BMNYP9UReEqme/jNRnMaSQO9fv+zGAvVnvO5hWI79c/+oIt
         MzwKympDusmTG0uFeBQ4T2B7/I4lVqsAqa48jDEfqbk9q5ZJxs7ntAL6QmG2v4cfxrgG
         1WbA==
X-Forwarded-Encrypted: i=1; AJvYcCXxtTUAjBKr+XYCGWnFhlOT5ogYXHH8aJZgYhk9T/tJ8crXYChc0kmSMNBQNFUstrDrCGgZd74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+LYWg9gYIXghvgYtKGrdLJtWqEeCFiwDkWGq2idaSJQ9MgtEC
	AITHIaJVOsrqZ6OJXLyP2LOpLyz/HV2VNUmWxhSe9M3hnNkRYlJx71os5TviLsk=
X-Google-Smtp-Source: AGHT+IGx2dLlotyR3cxjnKwpRX/npbxndpZPoA3+xIpMUIbipfD89aRLvAoe92tSAM5A824jxkuNYg==
X-Received: by 2002:a05:600c:3ca6:b0:42c:c1f6:6ded with SMTP id 5b1f17b1804b1-42f85af8a7amr47820865e9.29.1728135566500;
        Sat, 05 Oct 2024 06:39:26 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89e8a25csm22860915e9.17.2024.10.05.06.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 06:39:26 -0700 (PDT)
Message-ID: <1a90c807-eb6c-4495-ae93-64e5d099c29f@blackwall.org>
Date: Sat, 5 Oct 2024 16:39:25 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 4/5] tools: Sync if_link.h uapi tooling header
To: Daniel Borkmann <daniel@iogearbox.net>, martin.lau@linux.dev
Cc: kuba@kernel.org, jrife@google.com, tangchen.1@bytedance.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20241004101335.117711-1-daniel@iogearbox.net>
 <20241004101335.117711-4-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241004101335.117711-4-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/10/2024 13:13, Daniel Borkmann wrote:
> Sync if_link uapi header to the latest version as we need the refresher
> in tooling for netkit device. Given it's been a while since the last sync
> and the diff is fairly big, it has been done as its own commit.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  v1 -> v2:
>   - Left the patch as part of the series to not break build
> 
>  tools/include/uapi/linux/if_link.h | 553 ++++++++++++++++++++++++++++-
>  1 file changed, 552 insertions(+), 1 deletion(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



