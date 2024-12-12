Return-Path: <netdev+bounces-151315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A04AD9EE0DE
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 09:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 175422812B8
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 08:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA3720C01D;
	Thu, 12 Dec 2024 08:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRKccMB9"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D0D20C004
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 08:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990901; cv=none; b=UvyhekOSzqAJ67uUzct7nWY6UhJZly5YFzkqKtv3x4R13gf8LU4rwK1XpwyJCkzmAz2/9CUa6+XLb9WJfM8jWDLhHWUDxL/UC3TKXJBPdsEojsKhsLwauFEIBuYKBjiew9CUh6zYvEd4BG6Xxq9db8Qm4YiVnlJwIaAUOdRxFn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990901; c=relaxed/simple;
	bh=4zY98UHHGfgFUFQXkyrd6VkTOS0moSnEAon1VWvcJWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JLr860WOBotS1VUrlbh2qzv1ERAusrxXZ15EsKq2ZnlpxUk70Mp1TPLC5B+SP4iVS/MXmhwImb3S1wFCScl6fULD4SzUJCbfVcWtettLg4D/9MCiKavmvt96GoAtg08jA3R4S9LCE5gcJcBJ1c+Vmis6gKqnq9wPwd0mGtAUbZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eRKccMB9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733990899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bjf1nmOaVLrku/wXD9lDjECZxn/Olb8fTnRITGTTN/E=;
	b=eRKccMB9S/K/gLAn/D4QJP+UX3uFs2y71HpcCjFpzFEI/21EEpjNeBlbfrBxR956U25OZY
	7KYm0CNYHglB5E1BHmjSfL5JmVi6908tt//juAIsmwhGzI+kt6t9t5mYrrWoBfTkidjjK2
	Pp/S1vrEc8sfmdjAgfo8vlL0r+BXu2Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-wJz1nytsMUiXG3bmpsAkHw-1; Thu, 12 Dec 2024 03:08:17 -0500
X-MC-Unique: wJz1nytsMUiXG3bmpsAkHw-1
X-Mimecast-MFC-AGG-ID: wJz1nytsMUiXG3bmpsAkHw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4359eb032c9so2449175e9.2
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 00:08:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733990896; x=1734595696;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bjf1nmOaVLrku/wXD9lDjECZxn/Olb8fTnRITGTTN/E=;
        b=Wxip1PAV27fM9JGbF8mzY757Jty+2kFFiavDSWPQmrDvFvhkO7nYAa7saQpXxUY12M
         daq1+OjOAUQsWscNnSSxNez5VJ4yXSFH41A6K+l31e2lWy4BggdpFE3z4AeXEdokdQud
         BNzQ0M93Gn08k6H8oJBCMG9DuQ5rcs1cROjWhSiOSO3mkQHk9J2RjFO2l6RYTOIQlO0e
         2Wh+2BevBdpzhVcfcI+xtJyzlVWnHT/9x6w8sCoDvbloT6JuYNASrYGMzu/yMRHshwIF
         fgubQ/pbYa2MbCRUQkvninoch3kmJ3Z5Q4aIQn/EvOkLo6GqbaCTtmJt6Df/xw21HeRN
         mrXg==
X-Gm-Message-State: AOJu0Yz6EdGGyAg/EHzmYp3dBHwemdk8hE1cJsouKTEpJd10jAeQmfxI
	XR+uZkTz14EN0zZZ2Wx2Ag2YI6qBtuI/w0ZfKQ4nIpCgq3l3ElSBLQLkNHPhxUPPc68mW+AdtKv
	NaITNnmiZFt6/LjP5z+S1avIWSKUQD3TePRfzjBl31jIDlCMVIwePPA==
X-Gm-Gg: ASbGncuvQwvZz+uyE+4Lx6zfYGqio0e2zhk6YvUML3KNxl0K3zz+P4IfO8tWGskKHH6
	oKmz+4r37fhxUygkBw7bMQIvB7ox3MgI5M1FQVBmgBObXZs7jR6ebEmhJaH0WGPq+LVzlu4lYN0
	gNrqZz5FmExiw4M+BOVY3AC3fjma9SyDlHtmRkHQhN1H46UdJYXI3/16+XQBWgLyfGCnPf1/nWS
	2elyjCorLoArza127P/OGJ3GDzLr92gaOUeGnJbaCCW4szSQilIXMlfVQuiUAFAq2TViC0RLDwW
	0MkKtbU=
X-Received: by 2002:adf:e18e:0:b0:386:4571:9a22 with SMTP id ffacd0b85a97d-38787695702mr1905600f8f.31.1733990896399;
        Thu, 12 Dec 2024 00:08:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTBQqIZP4mAbmNDkq+BdMt3lJ9rORZUl6zp6FVSlb2GdXN4hAbWa7GzDXPUGiEy3/sL0XluQ==
X-Received: by 2002:adf:e18e:0:b0:386:4571:9a22 with SMTP id ffacd0b85a97d-38787695702mr1905577f8f.31.1733990896075;
        Thu, 12 Dec 2024 00:08:16 -0800 (PST)
Received: from [192.168.88.24] (146-241-48-67.dyn.eolo.it. [146.241.48.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3878251dcdesm3227619f8f.104.2024.12.12.00.08.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 00:08:15 -0800 (PST)
Message-ID: <ee865add-5f30-4c7d-b14d-fbc693dba265@redhat.com>
Date: Thu, 12 Dec 2024 09:08:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] mdio support updates
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael Dege <michael.dege@renesas.com>,
 Christian Mardmoeller <christian.mardmoeller@renesas.com>,
 Dennis Ostermann <dennis.ostermann@renesas.com>,
 Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>
References: <20241208155236.108582-1-nikita.yoush@cogentembedded.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241208155236.108582-1-nikita.yoush@cogentembedded.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/8/24 16:52, Nikita Yushchenko wrote:
> This series cleans up rswitch mdio support, and adds C22 operations.
> 
> Nikita Yushchenko (4):
>   net: renesas: rswitch: do not write to MPSM register at init time
>   net: renesas: rswitch: align mdio C45 operations with datasheet
>   net: renesas: rswitch: use generic MPSM operation for mdio C45
>   net: renesas: rswitch: add mdio C22 support
> 
>  drivers/net/ethernet/renesas/rswitch.c | 79 ++++++++++++++++----------
>  drivers/net/ethernet/renesas/rswitch.h | 17 ++++--
>  2 files changed, 60 insertions(+), 36 deletions(-)

@Yoshihiro, could you please have a look here?

Thanks,

Paolo


