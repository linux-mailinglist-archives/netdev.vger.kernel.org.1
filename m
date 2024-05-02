Return-Path: <netdev+bounces-92921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C39458B95AE
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 09:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F507281EA1
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 07:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D93D200A0;
	Thu,  2 May 2024 07:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="BCsUqPhv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2792032D
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 07:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636580; cv=none; b=CbUWxx9D7aNV859O761XTXRHDnAaWe/6XFpoFWBqvlZtuwOXfyl2pu/iCunc9cc6g+XZdcBU9WI5L25PMCM/66sjLcqG5oC2XBACTFVuOFFBAPLGJggG8MKvWTMxyHhQD2qIvDKIS2efsNYRsCOtQAYpmvdD2j6YXmSYIXTCK2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636580; c=relaxed/simple;
	bh=NfISg+YrVXDbcn1kXVX/Y3A4p1fJVBoY4nQ5b3GMklY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W2PEC7rz2jX/A4l1KIJWbERNpfaJOF4iZ/6uutdxlz4LeUWS0S2Dymedg8/RQolMPPYxLbK1VJdHt/Ar0AM4DKSOajwwOT/lvUZQBIxUoo/ASLHN3PNjgFav3Haz/RfSO6ssZdkqiUM98Lc+HavZ/wVQgtVQBea9H1AktjpoCCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=BCsUqPhv; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e01d666c88so48928731fa.2
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 00:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1714636576; x=1715241376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TPaHHHwqSCEB+HgAZAFP6AxqHAr1mYzEbxQSN9ry+8I=;
        b=BCsUqPhvkrW3DPuEZJrqgqbu8BrpRSOeCSNgztOJ3TtMUT0Qd+9nBFte0anmwfJiaY
         owyOxvj5cHXh3F5ycEd+jNxJW6oUfARLinQO3RYfUF6TDRd/QC+TfuwoS+aatf4dRypS
         YqpmiSBIwXvwJr50hEHQRe0swjIRhH/6Wdphr4OwsgBeQidIzVbcuR5k4ZUvEeCev17x
         79tSzfItdrJBTWOx2EPOQcbXlZ0XQ9xARsoTz/wSPCJc/aZXbkWQuGbQskdgqJc7P6TW
         A9Lr0iqQhimqYZwjZtw8cXG6e/dL+LdWoAwDLEI4sP+ikIGcYZXRH9zBAjuYVTwzRCaB
         0E9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714636576; x=1715241376;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPaHHHwqSCEB+HgAZAFP6AxqHAr1mYzEbxQSN9ry+8I=;
        b=hi/DYMSN7y6vAZZCo6RTDIUTry93nFcFATy+cnaZ34A74owA95KQsCQkkI0B3K47ub
         3xf1vJCX4WrVtPhMKT+oK0BF8nujfM+c62O8xIrw8QecqA/4HK3/M9QUTPvZbkZibzLt
         QeaDvAnIi+HfpgQfkt90vE8AseaDhLq0Uo3Nv8CScEMPGqXt+4c7m0++MIOGoMVa2WZS
         GRIuT4vEJ8t53qnaK6sRFHABEj/DDwzJzWxIJJd+IPWiTIqY1YFJ+dGrYsrPAsyDnJBv
         9rhXNrzrOevs5mlpfblnLt0R5LNsm4YqPyNeNA0BS+p8uVAUjEV2Vhj1llLKLa5LC7ou
         3wPg==
X-Forwarded-Encrypted: i=1; AJvYcCXv9Vt27NwrwsaateI/zcR9YPorfJ3aVHsM+QqLpEeeptos9wkwsw/dPPAo7cX6ysbkhr3whf1waABMKpXZTismSkmK9RCd
X-Gm-Message-State: AOJu0Yz5KDAl98wm4jUb8bxZwkpDQG4gx7HgTo6jgICSF/467rUOdLa7
	lBKeJFDh4a0A/s+ci1meB47dG6iQLMT5OHh2s7AFGtmTHDFEsz13BJrr5tO9oQU=
X-Google-Smtp-Source: AGHT+IEjlLmfMq7lDR41h9MvEUAUS0eHSkqoVPyGDOywalZ78dwxBIq/HgHsuZpWvSwDNugnJmILbw==
X-Received: by 2002:a2e:a98b:0:b0:2dc:9b50:eabb with SMTP id x11-20020a2ea98b000000b002dc9b50eabbmr3594715ljq.4.1714636576715;
        Thu, 02 May 2024 00:56:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:bb06:acc8:dbc1:95b8? ([2a01:e0a:b41:c160:bb06:acc8:dbc1:95b8])
        by smtp.gmail.com with ESMTPSA id x13-20020a2e9c8d000000b002d69b9a6513sm84092lji.48.2024.05.02.00.56.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 00:56:16 -0700 (PDT)
Message-ID: <8d4a5423-b700-478c-bb94-39c4d5345473@6wind.com>
Date: Thu, 2 May 2024 09:56:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH ipsec-next v14 3/4] xfrm: Add dir validation to "in" data
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
 <d03d08d9bbf0feef6ba2ea7cca12588298af1c0d.1714460330.git.antony.antony@secunet.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <d03d08d9bbf0feef6ba2ea7cca12588298af1c0d.1714460330.git.antony.antony@secunet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 30/04/2024 à 09:09, Antony Antony a écrit :
> Introduces validation for the x->dir attribute within the XFRM input
> data lookup path. If the configured direction does not match the
> expected direction, input, increment the XfrmInStateDirError counter
> and drop the packet to ensure data integrity and correct flow handling.
> 
> grep -vw 0 /proc/net/xfrm_stat
> XfrmInStateDirError     	1
> 
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

