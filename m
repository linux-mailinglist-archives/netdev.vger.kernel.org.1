Return-Path: <netdev+bounces-119619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 293BF9565DB
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 10:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7C161F23273
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 08:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9139D15D5A1;
	Mon, 19 Aug 2024 08:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="irBlmyZF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E8B15C158
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 08:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724056986; cv=none; b=ajzzMLoBRWnUSBdB2p35maxaz9w653OphvOeDVeWY7ZXAUSiAoxf8vL8x+XyfF/gzCY1xuBxrRibYMJ++zJJ1/P5qp3x9i04iUmWRI31/xJVfRulqyv5/74juTERmyW1gvAloXDi5ii7xGb+Vs20+wH8hqKTkHc+CcUwofSCPn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724056986; c=relaxed/simple;
	bh=jmPNpZhi/zZX6uJRTalGdwq6GSo+bNuwi+TgyJoFgD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pN4joo53C/Vv1Ypba6zqGzFQNwoh74zbLuthhsIOgiNwljHyzmMMK/bYG2ADCcGS4pZ+uo6hhXOSo3Ud309oReRSy5GS9qZDSw24NzvwVTcfSCGC6HAH39amQTT0QKSjQsWmgH4yVSxiZUND+wks8ifLeOa+UFZAQO7wXepdN6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=irBlmyZF; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52efd8807aaso5464335e87.3
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 01:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1724056983; x=1724661783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w7yVdGN7AhEFuYjS8yNyTv9GtTc20SDOA/b1faEd3J8=;
        b=irBlmyZFoVvQ3SnuWp1IqcAYmQO8F4V5cR32M0/ljL10F4I+Nj363rbQoG1SPk+lR/
         DCDon6mcoCFStdPW4ABRV2iX7vBPIk6OTK8+Da2zTaEUPAmQ93tlfwfM2t7wVZqtKv0C
         bI2vptjTDPqdsrAwPaNpNCuXo+mWsf7O1gRtKTJzWzt88mIJ9yNiJaB91mNrsyPXvHnJ
         gXZ8ZM8vODjNacqkih3t+NqXpUT6MubSysAmt6KTZJQvUUIYUhozdaowdMdwiq67zxJB
         pNdzFzgpMbyo5ZQwwo1ibFwqZB/KBhmSj+xLrjQoSezUACfzvwDP+vyq/cDi2q8V51zP
         cRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724056983; x=1724661783;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w7yVdGN7AhEFuYjS8yNyTv9GtTc20SDOA/b1faEd3J8=;
        b=wXnluquJYzL7BdR/xDXpZndyFLX59AsWAznwbJLQb+5xdsUFN2KQ6HKpGP305Nb/Ox
         hWuMYoD8z4xQZArT1Agbhaclkgm/7H2WbYkGgY5XwyHmFobI2Tc7cU2a0qK51DUks8Vs
         sdBrxDXx/iOf5foYbwlFLUZcJSj50uMQ1QEWBd70LGv5sSvIfd8AlXh69argDq69siKS
         gq9sMcrkA1K2JbOZyxkGpS+6QC8uIBOwqJ4TFbJG4EF5+iLSXL/Kd0F56mujXF/1IGMR
         QzBedBmqFiWlpdS98EeqVxY3vxZhDDja6NDVks0xoawlGvToOpEbfXdVIxuL578maPUg
         DoPg==
X-Forwarded-Encrypted: i=1; AJvYcCU7iRHdmOQrfvJbv3ELnFMuX4ppqNDRBFpoPQDK99RmYylaPowk58yx9Oo9IA2e9riToE6Qg9CmbvPd9VOUMUGWKkQw8xnB
X-Gm-Message-State: AOJu0Yz0KN9l3ov1ooZ5dwPvgVNuyTMJcZyWlIMtrtPM+IVIIreuhOWq
	XU8Xerz3iwH3lCqOnYqkyNmhrF6D4aK6TZTsrtiPxMc75RSi0/9I6KaPK4SS2eA=
X-Google-Smtp-Source: AGHT+IG3s6dtx7lKydNMqUgwlLuQNwLupN7EytXyJA98PjbvyCBVg3TFcBkgJZgfBS43P9PH10bFFg==
X-Received: by 2002:a05:6512:3d88:b0:530:ba92:f9a5 with SMTP id 2adb3069b0e04-5332e074eedmr3966396e87.45.1724056982201;
        Mon, 19 Aug 2024 01:43:02 -0700 (PDT)
Received: from [192.168.0.245] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838393564csm606084966b.128.2024.08.19.01.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 01:43:01 -0700 (PDT)
Message-ID: <f23bad2f-65b9-4539-ad4c-8c3467150283@blackwall.org>
Date: Mon, 19 Aug 2024 11:43:00 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next 0/2] Bonding: support new xfrm state offload
 functions
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
 Sabrina Dubroca <sd@queasysnail.net>
References: <20240819075334.236334-1-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240819075334.236334-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/08/2024 10:53, Hangbin Liu wrote:
> Add 2 new xfrm state offload functions xdo_dev_state_advance_esn and
> xdo_dev_state_update_stats for bonding. The xdo_dev_state_free will be
> added by Jianbo's patchset [1]. I will add the bonding xfrm policy offload
> in future.
> 
> I planned to add the new XFRM state offload functions after Jianbo's
> patchset [1], but it seems that may take some time. Therefore, I am
> posting these two patches to net-next now, as our users are waiting for
> this functionality. If Jianbo's patch is applied first, I can update these
> patches accordingly.
> 
> [1] https://lore.kernel.org/netdev/20240815142103.2253886-2-tariqt@nvidia.com
> 
> v2: Add a function to process the common device checking (Nikolay Aleksandrov)
>     Remove unused variable (Simon Horman)
> v1: lore.kernel.org/netdev/20240816035518.203704-1-liuhangbin@gmail.com
> 
> Hangbin Liu (3):
>   bonding: add common function to check ipsec device
>   bonding: Add ESN support to IPSec HW offload
>   bonding: support xfrm state update
> 
>  drivers/net/bonding/bond_main.c | 93 ++++++++++++++++++++++++++++-----
>  1 file changed, 80 insertions(+), 13 deletions(-)
> 


By the way just noticed $SUBJ says 0/2, but the patches are 3? :)


