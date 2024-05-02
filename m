Return-Path: <netdev+bounces-92920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD518B95A9
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 09:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEAB21C20A2B
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 07:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC43249EB;
	Thu,  2 May 2024 07:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="SWfxAsnm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5D61CABF
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 07:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636550; cv=none; b=tocfOWAMO4zNcxypUoujnOE+G+tyhUcUo6RRR2RQ6jUyKgR6toDgM4IeZ5Dhc+nyYZZmn6dPVSM6WADHXJGhatFsMoxnLrxYE18dC3KbvFKv/SThTuqFHUPPmHfxnY/E/a1fo5TRSRdlTz24wVQMEPDZ9vRUez/sf98TdSORoJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636550; c=relaxed/simple;
	bh=vLRt0/jjT8AsY8yTKAFaa/OPfRSsRSle0avKdLUpUoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TiXwCRqeCgiRp/NT5Ik4ASL45TVzgFMDUZ0P5ujxM8bx/EvpPiGwPSx9KElhbeovEqUD6tk7JNPdgc43DOcX6YOy+i8lcBrJ++1nZw0tlt1cHbzP35+muuXJeJQiOhge6L3WxIYXXi4XqTDT/omPXfKFIOC+R+PzKYU5GjkSN0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=SWfxAsnm; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e09138a2b1so51716771fa.3
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 00:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1714636547; x=1715241347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DvWNwldD6F06+qCMWDdOiQ3XI/0W6VSQtr3QY0v6k+E=;
        b=SWfxAsnmlzucAfaP0AnguSGXhGccmfny4gfngTofG1eBxAYEPJm3w3jLh6LhUpbCF3
         ZSXP9urVAPC69oGlZkSlbMm7a1t1Kkx4Yyi1hFlZcQYVQoLCBv29YoHuWN5q0ujODScK
         lI4AIqEQD0LIWhvV7TATMBvUt3DvRHxvXpiJgKwSxAjxVzWTQggtc4lBuM16AADeGoU+
         +MNL4F7fNOWctzRimLKuKWzKewUH7n3h//kWAdrz/vSY3igpKY5q2WBuFzvOkghzcWZ4
         NBHDJ5dv832PqmDi4HsQXvPrpdPZhfW1Kg96Nzc1ieb3PgY8kEX+0pTHgZYY+UWzjPEJ
         6vyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714636547; x=1715241347;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DvWNwldD6F06+qCMWDdOiQ3XI/0W6VSQtr3QY0v6k+E=;
        b=T1Iy/3I3m6l94MRRj9d0J0KS1QyLHqTgdo2/BZymsJbi5z2L7d1qmbAnIe5sUpP9oF
         M7zScahhtcN8GdmJI9AieWylouz3yx/gkrrJZfkcban7Ljk70Z+GjnmcyoyNVBEZB3An
         ZGU48BDR1KwEuebeLFw0m7GCyPntGKWGLW77XI1x5sVZtp9Xpu9Xx0QXEM+jxX7/xfMi
         yy1tcho7yYvoNfVzuey3HbcQGwVAVd4QFk+MfEi+X7DnjhKmD9A/ofjEgJNHTzJQXFqa
         u+IBJmWMYRRzrFtnq9dOujgHjBjGy7VJRL0DPMPmYXb1kDkfbjM5Ad2y+PwCMXhAryFX
         Kl3A==
X-Forwarded-Encrypted: i=1; AJvYcCVaSFVWcsXK/a1EndDyjmkVGWaFRC7OHLgU8PaNZ1tW8CXSFcTK3C8JVTRs24WilqFYP3sRd9y4fexc3JqgGYF20x6pYloL
X-Gm-Message-State: AOJu0YwD99H+lvK3nhTmK1H+tDZwnqmxFZME4ds6LjjjwyskDIVppUKq
	+9wmWuU/3810y8bErRzKcI9c2gQFO0VSOns37B8zCJ3wInhozoAO4j0DS7ozQmY=
X-Google-Smtp-Source: AGHT+IElEUScEEtT84yNJMgNaZ7siH06KY0ckrcehIQHuZBeGxeMAj5vVHlWwwW9Wmy19Y2jPRF/gA==
X-Received: by 2002:a2e:9d52:0:b0:2df:76ab:4e69 with SMTP id y18-20020a2e9d52000000b002df76ab4e69mr821647ljj.46.1714636544962;
        Thu, 02 May 2024 00:55:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:bb06:acc8:dbc1:95b8? ([2a01:e0a:b41:c160:bb06:acc8:dbc1:95b8])
        by smtp.gmail.com with ESMTPSA id l1-20020a2e8341000000b002de47101c98sm86481ljh.16.2024.05.02.00.55.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 00:55:44 -0700 (PDT)
Message-ID: <67ea59ea-4183-43e2-809a-ced6a1c26858@6wind.com>
Date: Thu, 2 May 2024 09:55:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH ipsec-next v14 2/4] xfrm: Add dir validation to "out" data
 path lookup
To: antony.antony@secunet.com, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, devel@linux-ipsec.org,
 Leon Romanovsky <leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>
References: <cover.1714460330.git.antony.antony@secunet.com>
 <fe3efb96a5902ed40ddcff7d92076fa2f316f65d.1714460330.git.antony.antony@secunet.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <fe3efb96a5902ed40ddcff7d92076fa2f316f65d.1714460330.git.antony.antony@secunet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 30/04/2024 à 09:09, Antony Antony a écrit :
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

