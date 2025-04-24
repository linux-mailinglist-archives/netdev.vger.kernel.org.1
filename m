Return-Path: <netdev+bounces-185525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08B4A9ACCB
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 14:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1433AD845
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 12:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD5622DF8D;
	Thu, 24 Apr 2025 12:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RfCFJofi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D899322AE48
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 12:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745496259; cv=none; b=IkbK8dDsg5cy3AUfPisU8QGtLOei1oaml2KOpmyyD7PfoMtjxX5uol4UWVV/CrIha3UTEibs9XOP9OIk6vRRqRATnZgevR2kQY+LD+gtsnHbg9wDUaVxdfG8GZHP3Qi6dxtkb/AI6IGxylkzpj6D/vFCg8rqnrJlNVgQxyOcajg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745496259; c=relaxed/simple;
	bh=U9tXpkXlvhzzOmQducjg/3aquEnpGt33HHWQ/gxaN9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JfYgCjzEoA8zK3zBuXqRWH0P0L/cXfKsKpF3NrdZkhofXjnrLUZbAXAqGVmWX7MtJ/rIZ3AYHU/NY9rHGchtyLh1ysUPm764rWw4RMX2013CoF+l/efSR0/m6+VjnVEfNG03kSj4LTS+bXlaYKvep3XA19rG3aQeFh/D4qDfjN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RfCFJofi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745496256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bh3s53lxnJJO2dUSgO66le/Ri+7+LskKQ0VlwKBl9JU=;
	b=RfCFJofinReThLLPAxUpncM7jJJVBtQdGVB25jKgOslYU13MyiUAwiWOS5Kt4I6mcvG0z8
	qg4hasKkfq8B2MT+vtOvxhrfCSmge7mWxaKTHw/tl76jSPyeymC/afoprlIZ6t82V4IycS
	UrJWrEdx4dhvUcnaEYJkKeLInXb0nMQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-mEx_GyS1MJ2jkIZa8tNHNg-1; Thu, 24 Apr 2025 08:04:13 -0400
X-MC-Unique: mEx_GyS1MJ2jkIZa8tNHNg-1
X-Mimecast-MFC-AGG-ID: mEx_GyS1MJ2jkIZa8tNHNg_1745496252
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3913aea90b4so302977f8f.2
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 05:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745496252; x=1746101052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bh3s53lxnJJO2dUSgO66le/Ri+7+LskKQ0VlwKBl9JU=;
        b=usJJA9U0xsayqyEENsh7+kOoMERJRsNRy95Uf7rm2wNt5XNwqruJIufzuDih+4rqT/
         /Nr+3fn0zFpmVt1cxRke7teQxXS707dsk+E6kKZbAHFrCrr+jVHUAAa7AUVIdkE9wi4t
         rwytXjHUz/Ve4v0KPM/sSEYKcn/K74JTMnMXmATGTNx4ZA9s8RqI3Q3c1R4y1Mr7pcle
         z5wo/R+CaibuTC8F95tenUe1Vqlzsl+0Od0McZuPCi+6iIKYBgamJjYbrHoR/ZOY0qKx
         AGcN2LRhiUoBf4Xo9WS/UeRMQ029ECFr+NLHRPtqrn3jNdu8aaTcbl4ElDdXFM86xe16
         uVKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCeXo1Ve/swiTp5ja9t2OqpVwLxsALArNSFKFO1W6XYbqSC6QfkQhM+Dz048MDzT0ihzOlnqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLcOLMDz7boaBZgNoKULcrntnALtDfNJ8Jf+x7v9r4sKSEqGxW
	KXe3LB9FBIG7Nz7yiuY/vW+FX2oMOY2hV2BU596vF8W1m1FYYMDevSGNJhvh3l78ws0wNWzO/eh
	8slhViFW+qx4ExqtDaRG2avriguxdHkoyaXxmqh2/WuLz3o2txDgDHQ==
X-Gm-Gg: ASbGnctRC/Y6L5Za2sRdgOulB3TsHvqRydoESYMKFXXDfnsSsUNVkrbZYjEoxzkM2cg
	q1lx2vS3vbL6YC4Im55fp1Vc7pPI5pgJQ+3WcZrGEPcKxknpMQ48APvUvrYMOxuS2IoQn3wEbt2
	pNE3C4CTulZuGtiry1CwWRfjfHmwiRzlVEgdqF98RCoNiRCOjXlvVRbn7ddnS6G0Y1Ky7do/jRJ
	+3dxFHJMuRe7KSR8n1KNGvEc0taZKm0ExIkz8a6bbEMMWoC4s+z34GO0UFZ1/hGKhkvereIO7xC
	bj4KBGmyJUs5zR/tS7IjI/AM7QbnPT7yk9YENWE=
X-Received: by 2002:a05:6000:178d:b0:39c:266c:423 with SMTP id ffacd0b85a97d-3a06cecb362mr1842819f8f.0.1745496252003;
        Thu, 24 Apr 2025 05:04:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRZkkYGPeYcct/UGZCOBgEUQnsD5s94C5Hyp3c2PijFG72me2Lm433rHFIjvW+57vf1ZeXEA==
X-Received: by 2002:a05:6000:178d:b0:39c:266c:423 with SMTP id ffacd0b85a97d-3a06cecb362mr1842753f8f.0.1745496251410;
        Thu, 24 Apr 2025 05:04:11 -0700 (PDT)
Received: from [192.168.88.253] (146-241-7-183.dyn.eolo.it. [146.241.7.183])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a06d4a8150sm1852436f8f.7.2025.04.24.05.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 05:04:10 -0700 (PDT)
Message-ID: <43ef6713-9ae1-468c-bc43-2c7e463e04f4@redhat.com>
Date: Thu, 24 Apr 2025 14:04:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/2] net: stmmac: Refactor VLAN implementation
To: Boon Khai Ng <boon.khai.ng@altera.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Russell King <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Furong Xu <0x1207@gmail.com>,
 Matthew Gerlach <matthew.gerlach@altera.com>,
 Tien Sung Ang <tien.sung.ang@altera.com>,
 Mun Yew Tham <mun.yew.tham@altera.com>,
 G Thomas Rohan <rohan.g.thomas@altera.com>
References: <20250421162930.10237-1-boon.khai.ng@altera.com>
 <20250421162930.10237-2-boon.khai.ng@altera.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250421162930.10237-2-boon.khai.ng@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/21/25 6:29 PM, Boon Khai Ng wrote:
> Refactor VLAN implementation by moving common code for DWMAC4 and
> DWXGMAC IPs into a separate VLAN module. VLAN implementation for
> DWMAC4 and DWXGMAC differs only for CSR base address, the descriptor
> for the VLAN ID and VLAN VALID bit field.
> 
> The descriptor format for VLAN is not moved to the common code due
> to hardware-specific differences between DWMAC4 and DWXGMAC.
> 
> For the DWMAC4 IP, the Receive Normal Descriptor 0 (RDES0) is
> formatted as follows:
>     31                                                0
>       ------------------------ -----------------------
> RDES0| Inner VLAN TAG [31:16] | Outer VLAN TAG [15:0] |
>       ------------------------ -----------------------
> 
> For the DWXGMAC IP, the RDES0 format varies based on the
> Tunneled Frame bit (TNP):
> 
> a) For Non-Tunneled Frame (TNP=0)
> 
>     31                                                0
>       ------------------------ -----------------------
> RDES0| Inner VLAN TAG [31:16] | Outer VLAN TAG [15:0] |
>       ------------------------ -----------------------
> 
> b) For Tunneled Frame (TNP=1)
> 
>      31                   8 7                3 2      0
>       --------------------- ------------------ -------
> RDES0| VNID/VSID           | Reserved         | OL2L3 |
>       --------------------- ------------------ ------
> 
> The logic for handling tunneled frames is not yet implemented
> in the dwxgmac2_wrback_get_rx_vlan_tci() function. Therefore,
> it is prudent to maintain separate functions within their
> respective descriptor driver files
> (dwxgmac2_descs.c and dwmac4_descs.c).
> 
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
> Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>

This patch does IMHO too many things together, and should be split in
several ones, i.e.:
- just moving the code in a separate file
- rename functions and simbols.
- other random changes...

> -	ret = readl_poll_timeout(ioaddr + GMAC_VLAN_TAG, val,
> -				 !(val & GMAC_VLAN_TAG_CTRL_OB),
> -				 1000, 500000);
> -	if (ret) {
> -		netdev_err(dev, "Timeout accessing MAC_VLAN_Tag_Filter\n");
> -		return -EBUSY;
> -	}

> +	for (i = 0; i < timeout; i++) {
> +		val = readl(ioaddr + VLAN_TAG);
> +		if (!(val & VLAN_TAG_CTRL_OB))
> +			return 0;
> +		udelay(1);
> +	}
> +
> +	netdev_err(dev, "Timeout accessing MAC_VLAN_Tag_Filter\n");
> +
> +	return -EBUSY;

... like the above on (which looks unnecessary?!?)

/P


