Return-Path: <netdev+bounces-178528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3FEA7775C
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 11:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79819188CFD9
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 09:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE081E7C16;
	Tue,  1 Apr 2025 09:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TCa92KmI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85F91514F6
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 09:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743498979; cv=none; b=sn1N5X3UnsEePoPc7u0qO4sqTCTGxxqDeEaolbNHj2RpqWPiGswKCnPASjN63OpWfODxWt5FCqL5y8KBlF6YeBwSFrwqqrwtf7IiQoIoppAwifiu54FvY5eFBhduwJBw2HrXE32dMYw9jVirxGL+vMPB9IFLjKgBWvzvCg5q21M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743498979; c=relaxed/simple;
	bh=jb0s6sNJzrZn4grn/a6EZGNfWQ7GxhBT54eAJVswL70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gJgvQfEdhKwG7L0yWcspqJF322ee4TEIDuW1kkzMI1DHTb3v8fZ1/Q4/urlikCWAM2d+dHxTerPe9JBXAZiLy76ELdSPEd9gKE57iaHSOVSXoSeykNrcpA4iK4qAYtfuux5h6EfWAD1H6qzUowm44oEgaji244VLwlfESveOnmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TCa92KmI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743498974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yg/PyeyR/PrHoTgfmAqCZFQYAX+5NdthsibcNQ2zsRU=;
	b=TCa92KmIxrMkYT5+kUvH8Q5sYpKt4VgZs01SGdu/LQMRU/KS8K/L1o2YTmHeA1pSI1fnwX
	TJFUX6BfzvJ+bj6qmQp5Bd+aZLz6vh91izsGTYKNritpn0EcO8Y1YSejgX1LXTXAoDXNmb
	+VUL/e8z8UDLgGgDrgUyUYdaPQrXO8s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-AufD4w2KP4WA53Pd4UzmiA-1; Tue, 01 Apr 2025 05:16:12 -0400
X-MC-Unique: AufD4w2KP4WA53Pd4UzmiA-1
X-Mimecast-MFC-AGG-ID: AufD4w2KP4WA53Pd4UzmiA_1743498971
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-391345e3aa3so3021957f8f.0
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 02:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743498971; x=1744103771;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yg/PyeyR/PrHoTgfmAqCZFQYAX+5NdthsibcNQ2zsRU=;
        b=NeIYXgGYuD46j9JFOsxxgIC7xQTZqOdriXuU7rU1I7X+aflf5YqhlxA226V5LSbEKK
         LId8rMBzoiaCUgn8Jxfywhqmk9CjSCcWp5PgHSJmbRPoUfgLUnWaZ+UeAD9e9jFCCvMN
         gOGW611kZKbQ17nAduoy8JWThrDNa4BUEYd4mb/wz7n4jggdsWCSBpcxXa91I05lzXNz
         vNuIgQ5UNEGzVhh+MCHx9cxK0fs6eguGajfHbwFFEuYiZuss6XW/zBPeqec5enDdNPFT
         HtgkUjvPKLVcxjOBBEWWdcipLL2ORrGK0fmEIhUOOLVn4yH+9mjBnk/dP8CK2lpsbFwn
         E+SA==
X-Forwarded-Encrypted: i=1; AJvYcCXcacmDtQFVZhiYBEjXjzJff1tYznCx3j3oqg1SXEfH5POH9yZbQDvUef5a3NviiUjbLlGFHA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxloE3c6QrVlVY7lLFm4r5Sc43JZS9hecD3U6lgHVY7rdxhoGws
	1J4h2pnDZQRJ6Y3+OjWBFH/TaTmLlPhN3QknF0COjqCgvgDgvAD22oibDkj1khUuMX4UyMcHdL/
	UzWImQ1Yr0meU9FpnYiSWG+kxTeFY64+V7LY5vvkWZVgx4km22Hlgsg==
X-Gm-Gg: ASbGncvROEZkoJKIPpJ/inhydj7pljdVzhOIeRcrZAkpq144+Sr6UnYeIFCrw40CaEI
	CzoOT8ka2Rvy4ci03Mx18772fIXyev6bbcB/8+sHEWRnCHS7P1ns4xwr7EoC3waeeB2hyqbMYZy
	ZnCT7EOrQp0vT0z78oELWaKBUoDe6YVUYAbiiabAckOshSpVp90oWoL8K2g8pz5A6RZjmVdITPC
	jzUrQKDEcX4h2D50H4QNt1HL8BaooYH9fAFaLVWSGutCRyUeC/MvvaMfgst5N1WRf95V+Zh39O6
	1iM7lQp2kKt6nuzxfDX3ByLkv3tqI0jHTAI4REr37BWKyw==
X-Received: by 2002:a05:6000:2484:b0:39c:13fa:3eb with SMTP id ffacd0b85a97d-39c13fa059emr9082599f8f.39.1743498971045;
        Tue, 01 Apr 2025 02:16:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEQN2Qx3JwnrEVxh3+dB2sk9rOX5XR5+HsV2PApSAl1hhYUeGvXSX9PSYeef8etGLvbbQjlQ==
X-Received: by 2002:a05:6000:2484:b0:39c:13fa:3eb with SMTP id ffacd0b85a97d-39c13fa059emr9082587f8f.39.1743498970716;
        Tue, 01 Apr 2025 02:16:10 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b79e0d1sm13566397f8f.70.2025.04.01.02.16.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 02:16:10 -0700 (PDT)
Message-ID: <05c4da9d-6701-48ef-b80b-a28646940be3@redhat.com>
Date: Tue, 1 Apr 2025 11:16:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] net: hsr: sync hw addr of slave2 according to
 slave1 hw addr on PRP
To: Fernando Fernandez Mancera <ffmancera@riseup.net>, netdev@vger.kernel.org
Cc: lukma@denx.de, wojciech.drewek@intel.com, m-karicheri2@ti.com
References: <20250328160642.3595-1-ffmancera@riseup.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250328160642.3595-1-ffmancera@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/28/25 5:06 PM, Fernando Fernandez Mancera wrote:
> In order to work properly PRP requires slave1 and slave2 to share the
> same MAC address. To ease the configuration process on userspace tools,
> sync the slave2 MAC address with slave1.
> 
> Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
> ---
> NOTE: I am not sure the call_netdevice_notifiers() are needed here.
> I am wondering, if this change makes sense in HSR too.
> Feedback is welcome.
> v2: specified the target tree

Please respect the 24h grace period before reposting:

https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/process/maintainer-netdev.rst#L15

Also please note that net-next is currently closed for new features due
to the merge window. Please resent after Apr 7th.

> ---
>  net/hsr/hsr_device.c | 2 ++
>  net/hsr/hsr_main.c   | 9 +++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index 439cfb7ad5d1..f971eb321655 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -706,6 +706,8 @@ int hsr_dev_finalize(struct net_device *hsr_dev, struct net_device *slave[2],
>  		 */
>  		hsr->net_id = PRP_LAN_ID << 1;
>  		hsr->proto_ops = &prp_ops;
> +		eth_hw_addr_set(slave[1], slave[0]->dev_addr);

I'm unsure about this. It will have 'destructive' effect on slave[1],
i.e. the original mac address will be permanently chaneged and will be
up to the user-space restore it when/if removing from hsr.

I think it would be better to additionally store the original mac
address at hsr creation time and restore it at link removal time.

Thanks,

Paolo


