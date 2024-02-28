Return-Path: <netdev+bounces-75584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A559A86A9C2
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 09:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57CAD1F22DA2
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 08:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C512C6BD;
	Wed, 28 Feb 2024 08:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="GXqLgSm0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512C42C6B9
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709108516; cv=none; b=ZNlvHk0CIBcPdpGK422RApYvp2ctOZAk0dBDFAL4kpnyr0PaSs603+dx35W/4JUomD2IRMP1kOwHSmj8mXHmnNMZTDZZD7UQIpG0l0V6EQlhFmP8W9zBkDGr/H4MLUnfaFXZfXMn/n+NrrNI7jj0B1keyiP91zSiA7NSKxdrFq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709108516; c=relaxed/simple;
	bh=d3ruLEhN8/mXu/y50MPalUo8IFFRBwgViBtOB7yjd8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YDO1cRt+igQF3eTtowrB8BecsF4CylGb0DBJHUYppY+LPq3PTk0anul9zr4F9WY+VZpaLXhTRguPCSXcBvU+bn5YAAiQ8lrvP69vRiC0aO98AC7SdvudhRjSNyR/to/hOvZfHm5BfFmSVWwwxWetj+aV+hGxFfpcKVuZmOxs29s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=GXqLgSm0; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33dc3fe739aso310821f8f.0
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 00:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1709108512; x=1709713312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O78iNb+R3eZGGesm2kszgznFhQc/xEBlsxU0zneU1mg=;
        b=GXqLgSm0rarXWr19ocgh6pEM+FXCOkGYLk9E70wT24ovwW+Lm1mFCbTEToJE6PbxUr
         xsGS+39hPEW7oeWTxfWZ+cC4CJ5cfti8vTM+db0XXUj1f531n4e02lMXK02HovfeaM9k
         +kc0NlY/OUs9E/wcGA2r0VBLIkkjLhF8Q2HqRKCCP+22dBkJTx9yxH6UOSlowb0xHfQp
         5FyEdwQ36DACm2/7TkNeobWrQtJwszl0fIGFI7V3wkmI3nk1COtqfGtdkFUGobG3tyuU
         U7SDPcGkSjUJPECGbeEaX7Rc3wJhh41z2veUXjsPjKZrAkgekMuNVXYnH4vsOMk8JpRD
         H8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709108512; x=1709713312;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O78iNb+R3eZGGesm2kszgznFhQc/xEBlsxU0zneU1mg=;
        b=JI6kCgaOGDk1Ht7pk+CIbiaNjU0bzZTNoxkb5giGD1P0m6reL9eEV1t3NJ0RIeGuV7
         bOK401rx9juGL5yhei0her/Tw/lvl7laboC/9P+tAGwhacPJckxjI0gsxMCiehNGRVW9
         umQ+pXkzjC8AzVRSRW7Rt58EeMTHvcjeVwlG6mpe9psAU8ZS2+DSTJbLPt7p13TPRftx
         Oj0YZIS/ADFJzrRHqfb4nrYvwKKIeM2bGA+5ww30rQdM9cZ4iMToXKJKgIzyGIqZCkF8
         9HNC+yvGW+Gna8xmtLsQsooa/uwyo158alUXteLDulXNkgbZrenO6RSH+tCVa5vIVqcX
         oCFQ==
X-Gm-Message-State: AOJu0YwPlTJO/gmQzubx7q3Wb41Ie0O6eMdwJcyLKO75jkz/xjc8232Y
	myVB0Xnk65O346BwypJlM6Di0/DREp0cRrdGAk6wHC3/hZ9JGyctShcZrS1TBrI=
X-Google-Smtp-Source: AGHT+IFuTXJJCWPkS6A8u3OZPLUKtKna4UGcVLbk+fkD/aBSgUMirvPMakSG+FPz2wwF8Jk6wfWEPQ==
X-Received: by 2002:a5d:55cf:0:b0:33d:f524:a9f6 with SMTP id i15-20020a5d55cf000000b0033df524a9f6mr1439768wrw.1.1709108512680;
        Wed, 28 Feb 2024 00:21:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:535b:621:9ce6:7091? ([2a01:e0a:b41:c160:535b:621:9ce6:7091])
        by smtp.gmail.com with ESMTPSA id fs11-20020a05600c3f8b00b004129f71b80dsm1299658wmb.28.2024.02.28.00.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 00:21:51 -0800 (PST)
Message-ID: <2d212cbe-d03b-4da8-b716-4c74243e3d2c@6wind.com>
Date: Wed, 28 Feb 2024 09:21:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v3 02/15] tools: ynl: create local attribute
 helpers
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 donald.hunter@gmail.com, jiri@resnulli.us, sdf@google.com
References: <20240227223032.1835527-1-kuba@kernel.org>
 <20240227223032.1835527-3-kuba@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20240227223032.1835527-3-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 27/02/2024 à 23:30, Jakub Kicinski a écrit :
> Don't use mnl attr helpers, we're trying to remove the libmnl
> dependency. Create both signed and unsigned helpers, libmnl
> had unsigned helpers, so code generator no longer needs
> the mnl_type() hack.
> 
> The new helpers are written from first principles, but are
> hopefully not too buggy.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

