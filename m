Return-Path: <netdev+bounces-147355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 257A29D940A
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 10:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0C1716808D
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 09:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FF018E057;
	Tue, 26 Nov 2024 09:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="cULfpnUA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A22410E9
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732612806; cv=none; b=Y3YA5RfliSQ3sT7pRaSUqP3tbqp+lP8Ao4ZV3FAYBVP1a1EV06y2Khc/1rXuGpCiFJhq76t7v0A86s+I83SCS/crd7ESPUw1Yu7m6OL9Oxv4wfrudv8KYpab3rwC1/AJDxEGeanmjr3+J9UqWtnK8GAjEZmPyZbv8U4VQZIpE5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732612806; c=relaxed/simple;
	bh=UlH9TeFdyUK77c5LaPyqc8+xM8w7w84iAaAxA1vgaiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DXCC+LAZ5Ysq/FWL8TTsJD4pV4Mj9T7uL9OMdaNrqnNZV4qhgSYe+5bZHjJqNbp4Uz5n0brO/8EM7egGrcRh1wBiJkRocGx2yxpd3UDw1FUKoAqjZwB6UP3RYFT7Xhpr0Ve9shsDN7SPqOBf3DI1U8dHT34G+F7oKCIXL504iww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=cULfpnUA; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53dde5262fdso3115217e87.2
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 01:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1732612802; x=1733217602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kaF0hhFeZqJ53nXGAucayOM39WQN5SbER/LsZp1+LUY=;
        b=cULfpnUAvG8SMer7BRtu3cWzUZJTmYV/2q/JbAmkJhtbAw+5iWlreZ8HF2Hwrh3pvv
         ragjkTWwxHa2nIB5BnLTm2NrKz5QEGlNRDhe7Ho6QFiVZoPZ7sdLKp5nm4tMPep1ta6b
         SNjleLNA3OG2bJQk7uPEWXFvGGqjXR8Pdnt1b2rovZxFoZjW6HMB3358TqQcP7nrs+MG
         V5NJhzCqx0w4/IogDoy1VIrK48lvZFgyRkdAvpB1mox1WegkY9AO81rjxDT6n31IKxBv
         PaG2bO4662Co99oNh9yo8GWG0GuIct7U0bmpee1MuKW28cDmL7zikG937sU4WKKwi9EI
         1sNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732612802; x=1733217602;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kaF0hhFeZqJ53nXGAucayOM39WQN5SbER/LsZp1+LUY=;
        b=ktDs27UemE1Q2tQrUrziZSN+DuDLjoZ0o8VvWWuTs1bK5FoypyM2JOoaMyGELDfI6T
         7Qk6B2QLNBgfbU5RQPv+qItLqVOFKVne1b/aiavTEQu2c6z3U5vwfgJ9NrHoPdyhYl9g
         putOjsUrgEp5DjgzKEEWnl3L8CqZRaMuE4aNXTjPYKeHk5SCU5bszwMDThjHzkG9gQl8
         49iNfty5mCyyzOikRQWRoWK9f9EG9Xpyi5Zj6DioAUQ1VTasmYX1TRgf2OxUnLkLvyo8
         sV9Yy6M0+mnDm0AKOXcopJ759b/YMONgAfysaTX9hF5vHWkge+X2ebpjloCgHYpoCBL6
         jR6Q==
X-Gm-Message-State: AOJu0Yyk9Du9+hNEw7R13QtF3wfteJBEqTDtg6AgWICUyCMRifhrChQO
	M/X5pdODd2Xy0Dfg1EvLQQ58Zd85CKgRpg0SpvbRlVd6DhOhvSxxEhx2Hxz4OwQkGfwlsM5EdRL
	s
X-Gm-Gg: ASbGncvtPk8phqYlf7N6G22HAPudEW9drm/XekSc4NgioFtIy2Tylonyud6Z9uT+CW1
	beiGP55YxEdZ/hSlYCcPcTXc89+j2p6y/38ooux8P1z2Wq6OlyCBVUeoRXS8Xh7VqfYt4KoWfyt
	2F5j0Irda8Klacc3R1FN/08C+7Nm1VcF9jbN+YymaCmbgkK61UcntZ84lZu06U0NtXY7L5IDU66
	7arSTnxYgJcOXkZMHEtYJNRz24LnIAedZvcAOWOXjna5k4Ahq05
X-Google-Smtp-Source: AGHT+IFMQlMD/+sEPnsIN/xKT487wNnAGDZa0f++OBznM+1stx5PfMyoV8Jo1hWXVzxuOONvvXULsA==
X-Received: by 2002:a05:6512:3ba2:b0:53d:a883:5a3e with SMTP id 2adb3069b0e04-53dd39b0e57mr8021529e87.39.1732612802387;
        Tue, 26 Nov 2024 01:20:02 -0800 (PST)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434a4b0af1csm25796725e9.40.2024.11.26.01.20.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 01:20:01 -0800 (PST)
Message-ID: <80c68c36-8d24-4231-9808-f3d3b76a099f@blackwall.org>
Date: Tue, 26 Nov 2024 11:20:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2 v2] bridge: fix memory leak in error path
To: Minhong He <heminhong@kylinos.cn>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, roopa@nvidia.com,
 bridge@lists.linux-foundation.org
References: <385b4ead-8d43-4845-ac66-4218b285be32@blackwall.org>
 <20241126021819.18663-1-heminhong@kylinos.cn>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241126021819.18663-1-heminhong@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/11/2024 04:18, Minhong He wrote:
> The 'json' object doesn't free when 'rtnl_dump_filter()' fails to process,
> fix it.
> 
> Signed-off-by: Minhong He <heminhong@kylinos.cn>
> ---
>  bridge/mst.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/bridge/mst.c b/bridge/mst.c
> index 32f64aba..37362c45 100644
> --- a/bridge/mst.c
> +++ b/bridge/mst.c
> @@ -153,6 +153,7 @@ static int mst_show(int argc, char **argv)
>  
>  	if (rtnl_dump_filter(&rth, print_msts, stdout) < 0) {
>  		fprintf(stderr, "Dump terminated\n");
> +		delete_json_obj();
>  		return -1;
>  	}
>  

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

