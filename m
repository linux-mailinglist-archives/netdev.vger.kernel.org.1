Return-Path: <netdev+bounces-67818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 815AC84507F
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 05:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3CC2B2AA14
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 04:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282213BB4D;
	Thu,  1 Feb 2024 04:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="13dU4Hjo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B103C469
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 04:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706762915; cv=none; b=CHa/9PSeC8euxsiOTK8sq6tpUWUj4XXs95PXi2tngW4yIps3PzovgrYu0nnpbj9MdZSBX4ExWTZKBArNFKrHicFXsTTpwpVp+ocFnkVQwzVQT1Emfid4Yo0smWBQpoWzaUFkUNp+DfQLNVLBnpr7py3EDBdX5cw3h4QoPaHkkzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706762915; c=relaxed/simple;
	bh=NCUD04nGM05Syps62HkSfuZRJ7fQcYFDrxFyrGsDrTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m8A2o7mQBDmeySoPwl9TvMCL1ngvQPTVJ5VvmmDWCC3IykBo+vl3wZTcJMFqfsGqJ4dM6crvMLpOBp5VfVV2lhwW8LY3d9Ex9UCPRq/5orz5Dk5odnNt4ynwFQppqITgOpcptzEMsd2D7XfspiGZ11y2KHwJ1dal/xqbwdSOjNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=13dU4Hjo; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ddc5faeb7fso410108b3a.3
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 20:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1706762913; x=1707367713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=usH99yMep1ufZbGSoTSSeNe0W2yjPQg8/9Hw+m0QpDs=;
        b=13dU4HjoSBFBHX3Sco6fMIenRXL+mf+pK0ulYeXhpKi2wzb2ErflCFyuVXTcPTil9T
         roTfo5KZVNrBieSua/8kkJgxMaFDMzgQsRQRjEuacjk6eyZM+sovA6/Nad++U2mC1N3v
         JcljAhqSfExcif2KyoIfutnbYyTe+slblUB4b8Z/wXvNmHWpDiurmOQhkkNKcChbs3/p
         vgexuJLOagOkrVzcyJ7CupT02GdBY8e0XNC2qdLTSCxPyBg+sn1gyg0on42rvR07IRpK
         b9HEyqRL6t9Cwu47RJM1OxjvVqT+A1KHP01sk90FElmpHS1rdd2l1UqABmwOFM9xMXzX
         jElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706762913; x=1707367713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=usH99yMep1ufZbGSoTSSeNe0W2yjPQg8/9Hw+m0QpDs=;
        b=RdTxI0lAhXaNUBdxREDUkMqkk5fWSFMgVN5XCeSLcEzybxpqaT7H68fhsIpw8J5RXx
         xIAotjTYzvFoUw/4U6TCoekbiNHaz6tHvJ+q+l3xDnxwexv5ctM+SppNykPNCj0GCXqq
         6fZIC0CNYSwN8AVcwAWj+U/7hWWZdwOX+rySVDmHW5jiJf48Exnopc8FvMQ7avKuaTUn
         BKlGhjs9+p62DzkguvyOgSub9QcY0PL6bowNVbtWFuWiiz1d7NkZmw8a5ptbeAAQPIFJ
         Uzt6pGu8L5/9ol6cr4B1Rg/4SvinwCElQ/MU438efs5nJnSugzZ1dX9berCC3B7PIX6e
         AnuA==
X-Gm-Message-State: AOJu0YwDZmlhEHvssLG81OOWLzVrh5WeGwTsOlTdh2G+o5ntw3IaUyTh
	fLS58weV+UMKQ2ldr7Teq4VWNlO59d++VjW4LV0JwQulyXd3LqPJ63Gx/GYRnhA=
X-Google-Smtp-Source: AGHT+IEqrPPhWLa6hjXAQjyjjJr3DIZqtT22mx8+qW0KuXmL7lfXFiIM9hQTlR7RGj75+kn9RUIt4Q==
X-Received: by 2002:a05:6a00:2d20:b0:6df:ebd1:f33 with SMTP id fa32-20020a056a002d2000b006dfebd10f33mr229030pfb.25.1706762912855;
        Wed, 31 Jan 2024 20:48:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXbhjc8lrk+33YmYMEC/sTzoG0zTQnj1qltwvpddO/JebGkClrvrz1W3mN8HExB0J+FfNBuYakbbsHNoqgFtjhIYEMhq+YOWWqp+uf5zQmrpJIEQGJVfnOjU/DXolScYuSP8rdtrSeNRD/qcKXYDy/LOx8YMMgnw68z/eFbaKXXYW1pED9GOoXei7anIgLkUhADlOSLtWhI
Received: from [192.168.1.23] (71-212-1-72.tukw.qwest.net. [71.212.1.72])
        by smtp.gmail.com with ESMTPSA id h10-20020a056a00218a00b006dbd1b13d29sm10744380pfi.208.2024.01.31.20.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 20:48:32 -0800 (PST)
Message-ID: <15820d1e-8b72-47c0-b35a-b95e47be9a85@davidwei.uk>
Date: Wed, 31 Jan 2024 20:48:31 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 0/5] netdevsim: link and forward skbs between
 ports
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20240130214620.3722189-1-dw@davidwei.uk>
 <20240131164459.314a809b@kernel.org>
Content-Language: en-GB
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240131164459.314a809b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-01-31 16:44, Jakub Kicinski wrote:
> On Tue, 30 Jan 2024 13:46:16 -0800 David Wei wrote:
>> [PATCH net-next v8 0/5] netdevsim: link and forward skbs between ports
> 
> There's only 4 patches here, you'll need to repost because you promised
> patchwork 5 by saying 0/5 :(

I'm sorry for being a bad chef and making bad copy pasta :(

