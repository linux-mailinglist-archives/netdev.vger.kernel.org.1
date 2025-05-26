Return-Path: <netdev+bounces-193511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FB0AC446E
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 22:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC9A43AAF19
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 20:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FF51CAA6C;
	Mon, 26 May 2025 20:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJdjlQOr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFE820010A
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 20:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748291216; cv=none; b=dfINvUhAqioX85H/WbPn2A+b1RLXaMFLuVoWbu04Xv3sFtEeQlgo1eiVmwmeJf5YSJ5MWPn9NZbD/lbEG/O1pNAosQuqfRdQPmCfiIAs+14hgdFgWLuFKcyys400wnzQdjGYqoLGIPPwqgftY/lvFpD7nY40CSLLI0ME9os28cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748291216; c=relaxed/simple;
	bh=/pF8uflug4iJXw8P2bPeBVRDCzFidAhfVujarTx3tBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bk1oUA/nCtX/xsdijSbpKTIrE5N7ZibjCUtAWtoMoj6SQ9ZzJ92UOkZN7dGg5XzdHP6KQl2Eg1xxFHOwEkO1m+MphyhLoOCPwA9KEAsX9UiIper/nvUxYUh4kFL9LfsE/SIFBavTKAYHCyOyi31l9t/IaqO3rS46Ey0pQmUZhUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jJdjlQOr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748291213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HyWXqN+5wHGnA02x8VIFqjuokIUgrwEnON4MEoIF74U=;
	b=jJdjlQOrZMc6VIvq3OVLaypup/+U4vY4/Tu9aattgruQyCYTM0vrgKC27u0HrUjQuxzvTd
	NCXVhXUjV7B+hsRxBxIi5layaWBS4ttkHE84yazvfpSP+POc0HwnWGHlVBMff06KZeXx1v
	OxBYi3/D/OlGIhSEVzw2PVMN+iNZ4w0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-MYc2I0PGPOKfMvDKX-Gjkw-1; Mon, 26 May 2025 16:26:52 -0400
X-MC-Unique: MYc2I0PGPOKfMvDKX-Gjkw-1
X-Mimecast-MFC-AGG-ID: MYc2I0PGPOKfMvDKX-Gjkw_1748291211
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d734da1a3so15030025e9.0
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 13:26:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748291211; x=1748896011;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HyWXqN+5wHGnA02x8VIFqjuokIUgrwEnON4MEoIF74U=;
        b=OQ67QPvND6QZ+OcGkQTZFzJmjddC98vSd9n2q+hnG+a1OnpxQ7K80jAqhvohgcy4DC
         odWYgowzbtda+mT8DkEbpIC1Nd9PBoLsgdejpmbbjaf3xq6fpsCfr+aKMCGawyjDFhEp
         UTSWn+MahshvcLZG+kANwZ9gxD/R1X+KMj5rbI4SdQ+XiMd7MvCkLOUOkuaUmhaWlS51
         X5TNq2hqZMqmy+1tVYp7Rl8yINyEslhHghFwMF7XPpnUNqmDlLAMhUSICx7aN1GxdS/g
         zskSZcLNTp5vHNiN8bChlkdp/eyXoMBKWKjNPg+KTNj3062Idk5Vb/GxK5yP/qEP3nFx
         k9UA==
X-Forwarded-Encrypted: i=1; AJvYcCU1XkEFUosqdtw3BQyjjAtNMySEkDpAyhK23aMpO2G7/7MwXLNOAd40hY16hGw6telZRdR8CXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5fklvCA2HEhS+OGJ8F94QWV/9sxS3xyCYhod1JEpSy9kMfylR
	ygboKxpLJPf2ipp0zgU1IeC5lvQVcSstGEhbCYFeTIYjdQPXh0FqOXfZqtFVXDHjrhXGMgHoiRj
	dN9WvskICXbNZpbJEwWpgPyH1qyRaKpBiC/rK+aHU9ek/SgfGAJyhd3LAwg==
X-Gm-Gg: ASbGncvlxZ60sHzPI8Jh4L0TcsSUYB3UhuLrOHVkU3WW5vEMU531uqn5F715m3xcK/M
	KUKtuYG66XV4iiLwUfGdIED2rfvvwMEIOCLdB2GSRIT9M3UdX+YKSGG0M+Re9/nDu5sakHWE/FW
	b2LUps1fYTV+8cIc10PAi2hGlmIwYGARyJf0bxwXzwjoHMXPe/WIYVi+QP7Hm1FxeXVTmHZMyy0
	EA30r2qVDWBQyElguv/jUP5U9dSvl/s0v4sXQ3vJ7wHw2MiU9SKBzYGwsHWecQplIxb2RbU7G0k
	gFK47aBM3ZMiT74PPVg14WSth2DALLiQHgJIFVcY
X-Received: by 2002:a05:600c:5126:b0:43d:a90:9f1 with SMTP id 5b1f17b1804b1-44c93016686mr92837525e9.6.1748291211233;
        Mon, 26 May 2025 13:26:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSrD54L0gvE46Mtr1bEDCW7JZuh1RueZXOjVf2VgxDZDxuwPNbxQGifhSFMWHJcVtKTkfH2g==
X-Received: by 2002:a05:600c:5126:b0:43d:a90:9f1 with SMTP id 5b1f17b1804b1-44c93016686mr92837385e9.6.1748291210810;
        Mon, 26 May 2025 13:26:50 -0700 (PDT)
Received: from [192.168.0.115] (146-241-32-247.dyn.eolo.it. [146.241.32.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4cfcece9dsm7354854f8f.5.2025.05.26.13.26.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 13:26:50 -0700 (PDT)
Message-ID: <b3e3293a-3220-4540-9c8b-9aa9a2ef6427@redhat.com>
Date: Mon, 26 May 2025 22:26:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: platform: guarantee uniqueness of bus_id
To: Quentin Schulz <foss+kernel@0leil.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Jakob Unterwurzacher <jakob.unterwurzacher@cherry.de>,
 Heiko Stuebner <heiko@sntech.de>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20250521-stmmac-mdio-bus_id-v1-1-918a3c11bf2c@cherry.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250521-stmmac-mdio-bus_id-v1-1-918a3c11bf2c@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/25 5:21 PM, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> bus_id is currently derived from the ethernetX alias. If one is missing
> for the device, 0 is used. If ethernet0 points to another stmmac device
> or if there are 2+ stmmac devices without an ethernet alias, then bus_id
> will be 0 for all of those.
> 
> This is an issue because the bus_id is used to generate the mdio bus id
> (new_bus->id in drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
> stmmac_mdio_register) and this needs to be unique.
> 
> This allows to avoid needing to define ethernet aliases for devices with
> multiple stmmac controllers (such as the Rockchip RK3588) for multiple
> stmmac devices to probe properly.
> 
> Obviously, the bus_id isn't guaranteed to be stable across reboots if no
> alias is set for the device but that is easily fixed by simply adding an
> alias if this is desired.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

I think no need to CC stable here, but you need to provide a suitable
fixes tag, thanks!

Paolo


