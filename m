Return-Path: <netdev+bounces-91770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9EB8B3D18
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 18:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA43C282448
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 16:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA3C148854;
	Fri, 26 Apr 2024 16:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="R41j1eWP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEB112C493
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714150135; cv=none; b=i96yZ7byrGAenw+Ut6fPDKvkzOvNzHbBi40HROqjQirOZPI1UAieN4+yC8h08HCsnV26HA0ECmETUtaYxebjx292p+ZStDYli6TA/EgEDzE6wmGpJSv48N5YfgJYw1p1h6QQVSaEBN6AY1TzJIUtNJD3/iXFYywNHmqLjaprXTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714150135; c=relaxed/simple;
	bh=OM3Bq4/u/SSXhRox/uVdkauXfRD7peCjecJj2cSYp+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EMJp8Uok+q2fF/yGAUofLu68s+drscBnz1kTi7znN8PfZHkayVNy3Io9PyjV5IZaP8GTT81ME7Z9Y2QoNQCegm0M5CwHE9OXp1f/YrGAWajRmPiAt+lvCYLes0U3ajWXGq0vI/8p4k+Epxu+rJAxyLYm8BO2O6e/hnIh5+wKyos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=R41j1eWP; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-343b7c015a8so1708092f8f.1
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 09:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1714150132; x=1714754932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8DGz9LXXhaa7I1AUNAR58aOZ9hPLhgIkCt6iR5qWsb8=;
        b=R41j1eWPhiWa+cNyo6iVxTlvo99dQrUiI/CgmI00vA/0kc8RELxJdFwymXMjuSm9Xp
         rjOW144Odl+SdMl1roLcf6I4s6huMZi55oa83M/JJa8i4Fv+geDjk1DbR2aOUvyu4cRP
         iSSYBoFkDza1B87Yi4B+0RqP5yzlIZ+37t4jaKVonGsLZr6Q98H7qR7Vvg+G8aN7FkC1
         uo4B5we9AZ+vDcGxoPDGyarweaAjrGelmI4p+GuTKXSF0TqQ4Dj5evL19pHJb++/e400
         YlTTTrE0h1aouQRM2i/2I/v/3Z+tB8oPIBp/H1ALnILqdGF9IV/gCtuBrDczzrFN7R8S
         psHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714150132; x=1714754932;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8DGz9LXXhaa7I1AUNAR58aOZ9hPLhgIkCt6iR5qWsb8=;
        b=q3c7mGXZfu2RCDq4Z3zYOiC7VOXVF11PpJQbxTRTcXPwmnM9qB9cTGunyoUt8t132t
         4DYSu57zxiUvTHBgzgOrNxlhXTbM9gcUOwMsZh1TnlbYhz6d9QyelrDi+AktD9Qs8Wxz
         2lA4s7kkQA4QcaYS7Fj+dyzm0L/uaAMI8TVZRFT2SdeIGqm2walDSzqIucHAbvV5Fj0B
         bk6K5sihEL1/VWD/lh38Tq4cuNjf/4Q+PWEz8x4jyvfNieTooAAGWzoaBYlhBvvNo4wk
         42YDGU4/SC3QDW6qbmCpgZctkZFDfBnUkiz3F8ZW63QBH9DgwPuaYENBUi6qqPQyJ8Ez
         Eryg==
X-Forwarded-Encrypted: i=1; AJvYcCWLeDe4e/+77+I90clVyAQz4y90GdVlJ8pALcUhpyxcJEeh82xBSuTbU2QvMZXuCKUXkGw4ZWd1/nnBGzhuBVNq2Z/QFjaS
X-Gm-Message-State: AOJu0YzCQvJ96wbYzhdmXQYdAWdop6VPEKcIBqzhCAA2k74BrjNYUWgT
	Ixf5N7tlBnz3XzUNEkeHBaLhr6UUb8XLuEBfj7ifOTqgmBlyMBpHRJM1qkTGYV0=
X-Google-Smtp-Source: AGHT+IEGU95l6hvlscYqUH6jMHUp+/AN9u8YCTM/77Q3YgYIbtDvsooh8djGPDtc2LGfajZwXvZKJg==
X-Received: by 2002:adf:f6c3:0:b0:34a:80ed:9930 with SMTP id y3-20020adff6c3000000b0034a80ed9930mr2093172wrp.8.1714150131945;
        Fri, 26 Apr 2024 09:48:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:7ec0:9b49:16d6:3c30? ([2a01:e0a:b41:c160:7ec0:9b49:16d6:3c30])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d434c000000b0034ad657deccsm15672106wrr.71.2024.04.26.09.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 09:48:51 -0700 (PDT)
Message-ID: <59e9b8e3-8315-4994-80b7-f6386029ee5a@6wind.com>
Date: Fri, 26 Apr 2024 18:48:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH ipsec-next v13 2/4] xfrm: Add dir validation to "out" data
 path lookup
To: antony.antony@secunet.com, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, devel@linux-ipsec.org,
 Leon Romanovsky <leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>
References: <cover.1714118266.git.antony.antony@secunet.com>
 <a3550869365b8426e256552d79c41b483eda7a86.1714118266.git.antony.antony@secunet.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <a3550869365b8426e256552d79c41b483eda7a86.1714118266.git.antony.antony@secunet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 26/04/2024 à 10:05, Antony Antony a écrit :
> Introduces validation for the x->dir attribute within the XFRM output
> data lookup path. If the configured direction does not match the expected
> direction, output, increment the XfrmOutStateDirError counter and drop
> the packet to ensure data integrity and correct flow handling.
> 
> grep -vw 0 /proc/net/xfrm_stat
> XfrmOutPolError         	1
> XfrmOutStateDirError    	1
> 
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

