Return-Path: <netdev+bounces-196684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB724AD5E64
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 20:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A1157A2F44
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 18:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB43280CC8;
	Wed, 11 Jun 2025 18:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="f10PutLJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46BB380
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749667231; cv=none; b=BEdIv95H5FXm1PHkEqEJWXV9tqJIp3wh0ItdlBYuA+EsTDNvmUKcqFikqU1c/E9lVoBVCaBjSz0JrzMk2vjGyVW4H0uRwq8msnEq3kvgKpWPLmHEByCEwEbGVpiHlA+6lSoC4Fn5avgHgBmbAzRlZvUhta27BHy/Ue9dCYKEVjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749667231; c=relaxed/simple;
	bh=HMhlSkga6NsUy49odABAYwMqDR9HyYRUDmUOq/wXbjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dt96OOow9j5GZYA74hwtQX6zljuFeqFCii7Pp61BOdkxSjiNgHMdcaTT2EYKjekNbRi/spZhcVZG6JCx3c7j6k+NGWm1CXzvrYt87vHJ1Cn+9Wdq06yJz72c4BTUwUfyR8N21buj9iQpakSWIZ1qmSYFIAXOcw51hCrhHSU6tc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=f10PutLJ; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2dfb991cb45so43517fac.0
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 11:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749667228; x=1750272028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Djd1i5rxedMLOFd1UOLUKIIRYBSnAcaMORynrrbmIlU=;
        b=f10PutLJHlH7fNFYV+CqhV81di559bbemsVBNGaG8NboPZ2LenJOgC+cKZqEHbtpNJ
         bSYgXoHAJ/onEqxJAhokc00jNIkH9DWNorttZf4iHQtqQSAqu+7Q7WZntj6r2RbD5r8I
         +f2B9RC0UkTfQahXs5BCaF87xWvp1Kip/jJUJ0WMINLz60VcarYlky+JZ3D6Rk6oEh79
         DfaKYCZzz4MSx79ZsvghGGtyYTRDrQiSpi340lobKNCjiWyyme8/VrQO0N4cf4o6PSAu
         Bx0TIdiJIKPRxbLR7W4Cf6YdB3mY5DW4tq0cCMI4GGSYBK3ECCec9HklK5bYsiQJapAm
         lSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749667228; x=1750272028;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Djd1i5rxedMLOFd1UOLUKIIRYBSnAcaMORynrrbmIlU=;
        b=NEhwS2KKi9b/k1twDOVJIVck83YAOYvUH6eAgNzHYWQNr4XeMAyweKHTNUJCyICf8l
         bddxhFBRAiXGgTeS3/3/dq+b2iQRBSQGiEvepRWfkfcqIqail27leG/uYMOYaTIOgfSM
         I/GiECVFE7JtR1MEZjZeN2NSsJlXHutyQ0Bij8UheLFLcPWSoGyIeKn6BIJX/DqIqhJB
         +m6N8qRcd1NHAf+lDnSrlx6orn6flVMlsdpF8yMIHm9Ooicsr2yVzElu9Rymb7icKKdV
         c+BMe/Dh59cDwd917DKsusKZOIfeU2tBmava7kiBJZyyPPSo4yxCnJ+CxqrAJeqBt6sW
         ACWw==
X-Forwarded-Encrypted: i=1; AJvYcCWa7A07tp6xdT4ABEB4jVnUWoPTLGpL/0k6iXhd82kO3WYyeKyHUX1uMBY74HRvmhHdov0MCQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxYVJT2i47fhuJpTrIAbWwcf1tztAhxsB11eGNLx1qFXotNDoD
	OtVpLZy9MpATyG0roCvFIZglBOLEpavX1tT0oIN0m0ZAQbQdIrE1VxdwGDCwdGwv0nU=
X-Gm-Gg: ASbGncu/zFJRaePEgTk8FjULGPhCma08zKWEs21J779BwkDR+4X4MFbBtJ6ZFXKxtiU
	OTDqCCwMlOqhBQUP2tzFgbNCH5wPQgEBKdochmXE3R/jZahBEOSjhH4ziXYkKKyAm4cPicffFE9
	D5Qj7wFwNVYZ9sKv2saxQqel22nOPDMPLMfT85DZlrZ5dy/emkOCqpiLHL6O6KMSqywBMO9j5Ab
	Uq6d0ccH6+2vA+ALrWsDBtdLcxF8GBjaouGhLoXk+7MuGml1h6F3On0maPuoZKCJvrO1wXVNShQ
	oDQisFqklvW7Gk4xzI+75LW0N4zOxZgV+FTxoAWuW6H2DLAL08MLpl9OYqjJrgtJxKngiYoqtBu
	1n1nVYS0bUOAQ8S/PA46gn2b6wBAt05OzjIwo/Dk=
X-Google-Smtp-Source: AGHT+IHW+d53gUPdMcGV63cjcfUEL+hnwMjEYMcU0Da0YqyG/fIcFC3GGy1U2GK4Hxm1I7PSQRdSNA==
X-Received: by 2002:a05:6870:7024:b0:2d6:49df:a649 with SMTP id 586e51a60fabf-2ea96f28331mr2946286fac.31.1749667227842;
        Wed, 11 Jun 2025 11:40:27 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:4753:719f:673f:547c? ([2600:8803:e7e4:1d00:4753:719f:673f:547c])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ea0734106csm2944930fac.40.2025.06.11.11.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 11:40:26 -0700 (PDT)
Message-ID: <55bba029-9243-439d-9f1c-985f48ad2ec8@baylibre.com>
Date: Wed, 11 Jun 2025 13:40:25 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] net: mdio: mux-gpio: use
 gpiod_multi_set_value_cansleep
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linus Walleij <linus.walleij@linaro.org>
References: <20250611-net-mdio-mux-gpio-use-gpiod_multi_set_value_cansleep-v1-1-6eb5281f1b41@baylibre.com>
 <d4899393-f465-4139-ac3d-8e652c4dd1dc@lunn.ch>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <d4899393-f465-4139-ac3d-8e652c4dd1dc@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/25 1:25 PM, Andrew Lunn wrote:
> On Wed, Jun 11, 2025 at 01:11:36PM -0500, David Lechner wrote:
>> Reduce verbosity by using gpiod_multi_set_value_cansleep() instead of
>> gpiod_set_array_value_cansleep().
>>
>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>> This is a resend of a patch from the series "[PATCH v3 00/15] gpiolib:
>> add gpiod_multi_set_value_cansleep" [1].
>>
>> This patch never got acked so didn't go picked up with the rest of that
>> series. The dependency has been in mainline since v6.15-rc1 so this
>> patch can now be applied independently.
> 
> It is not surprising it did not get picked up when it is mixed in with
> a lot of other subsystems. Please always post a patchset per
> subsystem.
> 
> This also appears to be version 4.
> 
> Since you did not annotate the Subject: line with the tree this is
> for, i'm not sure the CI system will accept it an run the tests.
> 
> https://patchwork.kernel.org/project/netdevbpf/patch/20250611-net-mdio-mux-gpio-use-gpiod_multi_set_value_cansleep-v1-1-6eb5281f1b41@baylibre.com/
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> 
> 	Andrew

OK, I will try again tomorrow with [PATCH net-next v5].

