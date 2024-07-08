Return-Path: <netdev+bounces-109924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF8392A495
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 16:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD11B28285D
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 14:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A57E13D639;
	Mon,  8 Jul 2024 14:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Tche9g9/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DC378C75
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 14:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720448751; cv=none; b=lr3KkY54/if7MCZIQL9s9dy6ZPXMdg65KtVRS3AIZJ6KwR97dcPrGhOCepZ3C18/lvk/L58pcBHRfLrY9aYeJuJYQ1eXkwUykvq3pJuy4XqqFNb+tKkj4iquZFZqrFenOt9jbp6nyR/UQXwjlGKdi0r07jmBJBXNgFE5iUWeeSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720448751; c=relaxed/simple;
	bh=sVqP3HYILE8K4kseLkzHEkhKSuPq7y6d7aGwycP+SqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fw3GZFMNqQvAs/xx1A9mGyz2xIbZhqU7MwtIYEWPE/k/K8/9IU0VLHHdEZnWiyGFI2T5mmGFHKmKFXIFcZUccuGZ+EnyAANsc6Xq08/erc+qdLvspw/Ppaksz457jk30Q0fFHHMdKJ6qD0iXmNmZZnDRPIl23E0hOIR/RFfjAH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Tche9g9/; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-367b0cc6c65so1707477f8f.3
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 07:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720448745; x=1721053545; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W/eF7oIcPCmgh2btkuGSELcXuAe2AdViMi7aYroQLWw=;
        b=Tche9g9/WVvR0FFk/CXfJuU/V9Wg9CJg+77U3ZPs8OV+/E8qjPQzL+ihN2gYyataOe
         gKZzPyFhLYQAl5wgRST8RHj+9M7dXyfBIUcXILaRKK78OEivUSH4KJzjbs+NaWtxRFMq
         53QbOg9cMnMPOWppotREzjSgYFeBDJPJ/TL2mYY5wbvwcBogYZW0QaBkL+NNKRViMjyq
         wYigJwySeBWBtX813DVeBeOo1Q4QxV9CdxKLnxUWHFCGbvPrPoZSHVzJzfoURtgna6/8
         sLzrzHQxcM0l/biX0QZGpw/acYbqBWnha08STsw61jWDG2kGQYfvj5lak9RWDTvZ+6qX
         IBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720448745; x=1721053545;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W/eF7oIcPCmgh2btkuGSELcXuAe2AdViMi7aYroQLWw=;
        b=JQ/dnDZWTphjHkR4F28XFEU8acArObdVHJBiWxzzs7cvty4uxZLHE2mxHRMoDiJXGz
         +ZKROBfpRbIOkC89T89szBBmp4uqkvEXvju2ZIeSIQVtW7TBXZp1la9HnwWzoCuE4YMj
         oSQ2qAx0/J3P48ODLoF0Fg0qti4Up/iY+byY/tuZtucIwXQFPFUfHJN8cuPRefvdmY4d
         7BservJPD04wLgXEPQhIPd3lh2qYNBZlU4QAnIx/Kh0lyQx14Asv+/NWl8lOw/MlosvJ
         FPfyk8/bTtwoFp4oMJ+ekHHnmdsOS+oUqhQ8OinSmkeCh35hmmdM91hSvd2OrY90+SxF
         WWNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaTqgZhmKXVQD0mr435sh20gkurtP50xBLsEsfw64j1vXbcF0ODTAGBOnJ8MAw+pBZbfm6pGHcEN7jpmhU7uU4oxxQkVRU
X-Gm-Message-State: AOJu0YxqbuVWGLfh4+NG2TNA5IS8A2e/DRP5pw9QD1+TOgufJhZ38+yH
	xh6+GDqCynwjhpQVHtQ/0OSoD9Hiq9aDS1k984Vg3XEmwT9YUkR+mRRxE6uNrZ4=
X-Google-Smtp-Source: AGHT+IGdkjg5ScqQmofH+S1f2GzeJU8mlai3Mw3zLq/JArqhrfdX0A2oYma/TLFVS0tZC1Er+OwZ+Q==
X-Received: by 2002:a5d:6690:0:b0:367:89b0:f58a with SMTP id ffacd0b85a97d-3679dd73c4amr8167197f8f.58.1720448744888;
        Mon, 08 Jul 2024 07:25:44 -0700 (PDT)
Received: from ?IPV6:2a01:cb09:d029:b5a2:628c:ea6c:7082:b40d? (2a01cb09d029b5a2628cea6c7082b40d.ipv6.abo.wanadoo.fr. [2a01:cb09:d029:b5a2:628c:ea6c:7082:b40d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36789d5ec1csm16066152f8f.37.2024.07.08.07.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 07:25:44 -0700 (PDT)
Message-ID: <f8f33e5d-5595-4218-a754-eaab71e30510@baylibre.com>
Date: Mon, 8 Jul 2024 16:25:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ti: icssg-prueth: add missing deps
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, MD Danish Anwar <danishanwar@ti.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240708-net-deps-v1-1-835915199d88@baylibre.com>
 <1eec9f10-9eda-4f9b-b0f8-28f25a6153ca@lunn.ch>
Content-Language: en-US
From: Guillaume LA ROQUE <glaroque@baylibre.com>
In-Reply-To: <1eec9f10-9eda-4f9b-b0f8-28f25a6153ca@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 08/07/2024 à 15:53, Andrew Lunn a écrit :
> On Mon, Jul 08, 2024 at 03:38:20PM +0200, Guillaume La Roque wrote:
>> Add missing dependency on NET_SWITCHDEV.
>>
>> Fixes: 5905de14c2a5 ("net: ti: icssg-prueth: Add support for ICSSG switch firmware")
>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
>      Andrew

I will send a v2 , shaeone was wrong on Fixes line.


Guillaume


