Return-Path: <netdev+bounces-173942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C827A5C637
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 16:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 833513B25C2
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F2925DD06;
	Tue, 11 Mar 2025 15:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKXsqv4c"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9662571D8
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706333; cv=none; b=Moq+yOJcKXoRw5qw+vroGXNBaTXVoeDVdvuJFhiM4I0kxy+3URbeF7sd/QCpj3uorObsV012oVCKQpBCdSFXfp3vWAtYBY80nhvR4hxmu6QTTXpGefeZQp70Ky9YvMN3JarJBXeCUtNSVUgVYyvL50DXRVO0zZa586vx75tKwG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706333; c=relaxed/simple;
	bh=CAepTdI8+lBhfo1pilBNs8sv4DkCRO1apKwuTSPzjAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZGG3VpZHoZmTLt4rLLeOLOcrC/r6pEA5nMZoDs0dfXn5N0Ljr18u4Cz1GHZLg28eYxsJR5s5QLcJjURN2X+o+mjwZ7qMjBFk+LHAIwH1u4fIyQvGizCbnoVL7hzvqAruEdFlEDn4P/i4bX+88nU5uCono84gzgR5RDXH/KtjfU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DKXsqv4c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741706330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NDk7YEa56yoIlJsRoRKJ7ZZpnSXW+al9zb20kcGee/k=;
	b=DKXsqv4cm5HuqeA3R+nizpxB3TSpOXbUT2kjBtWUbCHGeTB3NKFUXxecI3LSh9mAlJ8Gtd
	RkWn5H/w41rquISym/syKi83F9cQ3WaJPzEGAzdliL0PAd+iKITxrVG2DD+9xQ9xWC4Qo+
	setecwcKGryn5737KqC2p7uWuC8PgLw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509--xv1xVcoMAOpwyLCdbU6AA-1; Tue, 11 Mar 2025 11:18:45 -0400
X-MC-Unique: -xv1xVcoMAOpwyLCdbU6AA-1
X-Mimecast-MFC-AGG-ID: -xv1xVcoMAOpwyLCdbU6AA_1741706324
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43ce8f82e66so16532225e9.3
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 08:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741706324; x=1742311124;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NDk7YEa56yoIlJsRoRKJ7ZZpnSXW+al9zb20kcGee/k=;
        b=I3M7Bz9nN1Y32oJzwDPuLZUutPSsyRGg+w1Jzx6zZ86GlooMFOMomgJJNab6XNsHpY
         BfkUemHALvv3vkzJW/lNMvBHiMvSW4hp279AotLo287mphh3LndWznXCnIAgCNtsMDGB
         MvW8LkJ3aPln1hKUBp6vaMfoLc7sfxyK2jU/NYC6FXKDu+WE6MpA7oQW4ioebRjdUxVZ
         BtL6M+yw1w+eR5QIrY3XkY0TmvZkg1WiAlv+pcKn2/TYzy5o2zoDoalj/bbpw6wOsNT7
         qShF4iAw8iD2/ZWNo6EhLUm8D1IfFrNxCcuC0l/bIBFSK18BSemYMq4Gw75/hrVI1F4/
         LeGw==
X-Forwarded-Encrypted: i=1; AJvYcCUsuzN4PRYNxqiz9AnTQ/YBo+N3ySuQxyWBDALj3K59rPmAZSk+icd7mTToOpTfqlp2Lxcb1Yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfIsCBOorQHSKVQzU18jOAGUf3FGPZ+fngaLCKIa5lN++9vNBP
	Er+38nyMOjAfAnH6YYzQh4uYIPLv4sGOIdmKKWKWg+IvtXrM0qJl4TAiQS1wNGa24rnSDuLAl1A
	o2XI1aruEriIP592sNtX94S/cRd0XODBOkaXxFBfdSsGX16x2qNWtmA==
X-Gm-Gg: ASbGncuqxc2uiwDs1mFLv+6ZJLopeIsRDbVyJezxoDm3vjgbAGOIqiqRqPvCD6O5+h/
	JQcgQzAXJtSlksQ2+omUb3+yE4Jl2wF+lYs0EOCqgWtsKOb/cPucUEJ0EpEPCNBTHjZbp5Fj0Zw
	zXNoSzutUrNJ5VqSjDecwq+NqxT7Q1oW6yopO2SWroXYhIUk36x5Qd/KKd5MFIEQoZTQoP8E6Vi
	j+FSPmSHSTYaBXSWljkJ1gMmiFaUzuHndtIb8ZpOj36599ShyQNco7/EnRX2gbfVXMAK1kMUgsc
	hRaS0PIPvXnAQiQUFkqMNjZIp/sH1wrTs6RLrToaQK0F1A==
X-Received: by 2002:a05:600c:1c1c:b0:43d:54a:221c with SMTP id 5b1f17b1804b1-43d054a2461mr29964055e9.18.1741706320967;
        Tue, 11 Mar 2025 08:18:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMJe6di9LQhQeX/PL7yUVPAZkRIjZmg6PJ3J17XG5YgLVNYqe9duJdzVmy7O2gnXdpBuKRJQ==
X-Received: by 2002:a05:600c:1c1c:b0:43d:54a:221c with SMTP id 5b1f17b1804b1-43d054a2461mr29963775e9.18.1741706320599;
        Tue, 11 Mar 2025 08:18:40 -0700 (PDT)
Received: from [192.168.88.253] (146-241-12-146.dyn.eolo.it. [146.241.12.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cfcbdd0a7sm58941175e9.11.2025.03.11.08.18.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 08:18:40 -0700 (PDT)
Message-ID: <2d5a6210-1565-4158-ad0c-432953f9268e@redhat.com>
Date: Tue, 11 Mar 2025 16:18:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 12/14] xsc: Add ndo_start_xmit
To: Xin Tian <tianx@yunsilicon.com>, netdev@vger.kernel.org
Cc: leon@kernel.org, andrew+netdev@lunn.ch, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, jeff.johnson@oss.qualcomm.com,
 przemyslaw.kitszel@intel.com, weihg@yunsilicon.com, wanry@yunsilicon.com,
 jacky@yunsilicon.com, horms@kernel.org, parthiban.veerasooran@microchip.com,
 masahiroy@kernel.org, kalesh-anakkur.purayil@broadcom.com,
 geert+renesas@glider.be
References: <20250307100824.555320-1-tianx@yunsilicon.com>
 <20250307100853.555320-13-tianx@yunsilicon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250307100853.555320-13-tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/7/25 11:08 AM, Xin Tian wrote:
> +static u16 xsc_tx_get_gso_ihs(struct xsc_sq *sq, struct sk_buff *skb)
> +{
> +	u16 ihs;
> +
> +	if (skb->encapsulation) {
> +		ihs = skb_inner_transport_offset(skb) + inner_tcp_hdrlen(skb);
> +	} else {
> +		if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
> +			ihs = skb_transport_offset(skb) + sizeof(struct udphdr);

You have quite a bit of code dealing with features that the driver
currently does not support (tunnels, SKB_GSO_UDP_L4).

It would be better either enabling such features or not including the
unused code.

Thanks,

Paolo


