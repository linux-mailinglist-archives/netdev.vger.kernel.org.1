Return-Path: <netdev+bounces-130818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFCC98BA8F
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 13:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1CF6281D6D
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 11:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D927D1BFDE2;
	Tue,  1 Oct 2024 11:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGlYWr8n"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D1A1BF7FB
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 11:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727780626; cv=none; b=IvNrp4kRdO8Ev7JWF3Zto8+QcU/+0wGoqecfPz0y341TPNKS68X6vWRFKIWtChxiyNHxHLDZheHO8JbVut/wWwGPbBOljIwdFWEmjJzBVuMwjxqeyNLyAJKCosfFEtHK4A0tHF4WBMlERO0mRaruMb0Hw2aAsppzHBne/C/GicI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727780626; c=relaxed/simple;
	bh=jR/bG8z0aKX1C61HPpm+lgjncRIz+l7lDc3JyXKwE9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nVBD1xlsosSAaopmhKvdqdQCcNaBMWAM/BaBybSWg4SI/hY970Rg5hoFmBEjY4Uxdvh4amGz9fW5vsSDutAbPy9hRQIFB2wW2wCB1TaoNvP0yiHSBawss5pAf4mo8ETuMp2w2r1dWDSHPER1R4U7LnAiEOUhHKw1RpV90eCKHFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eGlYWr8n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727780624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ncjckRH7/yyn/ADQFjQxA+df+TjkuJuNYa5mD4g5EJ4=;
	b=eGlYWr8noXHhz5dGJ557aOEu4laWYYnWSCHfwxZRTM2QiPQ68KTZMGOm3olKyV5lRYwf/d
	WixDEbGY3HzXlGDKCBGOf1dFWyl/fwSF0AkCw4A/N0fclak2l0CkGjcJqtHPsIn+9iQUWl
	gA6180bedk2Y7Z5SbCaBdVikuCg0Pb4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-vefsdd82NCKOn7Ve80EtXg-1; Tue, 01 Oct 2024 07:03:42 -0400
X-MC-Unique: vefsdd82NCKOn7Ve80EtXg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cc4345561so30597115e9.1
        for <netdev@vger.kernel.org>; Tue, 01 Oct 2024 04:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727780621; x=1728385421;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ncjckRH7/yyn/ADQFjQxA+df+TjkuJuNYa5mD4g5EJ4=;
        b=L1NXvSzGWuj7HPjNa4n12lOyB99pJXPr5FqoyqeUIxHEZn4Y+1WVdOvza2mUAPjyeM
         LLDBcHZitHI27ekWcGQFc2SJcJLr4+d0oymwaIJkfk/3YjJQsEfCJrvQXi/iSwNrwA7w
         BcB+P/668nhYjcj3vkKj3O9piGo/1pwE+dwt/V6zs/pjygbAszUDgvCXDl6AgzE5Zx9n
         zxuQksxcM73oQ7ypXmaqMZLvz4Y07tlLHy158PynOz6s8SJ6/r823ewRW+cM6DAh/mUc
         MRfZ5T+KJE9KcnlBVdIyfA12c6U7tAjAypz1u8SIuWgMM9Lo0El6cSLKF3T8GZGbCRSr
         ZTxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3XDuAFKAbxFcEJWJfIStpvxYMLCNvjzTafKDISua2XyO9LcUii5ZMSclEEoRIGq2sD22giEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVRzGSUZmJEagvAIWXpIhqvpbITHSRC0gfbtw8KPgA2FHJ4wMj
	QH9obN9XIpn9O6Xtcw0mPVa4jQWo7WPubXkchkz8NexkRlYGpSyYmKREHRr+LfpndOf2F9ZPiDr
	RijlgthXYFhI6CfX3HI6wZo0hBTKZQtcR9IhSVC/8L9/MRUzEUqVe9b7EJZ73qRRe
X-Received: by 2002:a05:600c:1da1:b0:426:6f17:531 with SMTP id 5b1f17b1804b1-42f58434120mr103320425e9.13.1727780620981;
        Tue, 01 Oct 2024 04:03:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4qgoYP4ljSTLgN26fJih+mkcB1DvCVdRVlSPQFTYIwAm0cREMFkomMyMkaHsnqYrx1Co8Sw==
X-Received: by 2002:a05:600c:1da1:b0:426:6f17:531 with SMTP id 5b1f17b1804b1-42f58434120mr103320235e9.13.1727780620588;
        Tue, 01 Oct 2024 04:03:40 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b088:b810:c085:e1b4:9ce7:bb1c? ([2a0d:3341:b088:b810:c085:e1b4:9ce7:bb1c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57dee0d3sm128334315e9.28.2024.10.01.04.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 04:03:40 -0700 (PDT)
Message-ID: <e73981c3-608f-4ea0-9812-f840a9d0e100@redhat.com>
Date: Tue, 1 Oct 2024 13:03:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] ipv4: ip_gre: Fix drops of small packets in
 ipgre_xmit
To: Anton Danilov <littlesmilingcloud@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Shigeru Yoshida <syoshida@redhat.com>,
 Suman Ghosh <sumang@marvell.com>, linux-kernel@vger.kernel.org
References: <20240924235158.106062-1-littlesmilingcloud@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240924235158.106062-1-littlesmilingcloud@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/24 01:51, Anton Danilov wrote:
> Regression Description:
> 
> Depending on the options specified for the GRE tunnel device, small
> packets may be dropped. This occurs because the pskb_network_may_pull
> function fails due to the packet's insufficient length.
> 
> For example, if only the okey option is specified for the tunnel device,
> original (before encapsulation) packets smaller than 28 bytes (including
> the IPv4 header) will be dropped. This happens because the required
> length is calculated relative to the network header, not the skb->head.
> 
> Here is how the required length is computed and checked:
> 
> * The pull_len variable is set to 28 bytes, consisting of:
>    * IPv4 header: 20 bytes
>    * GRE header with Key field: 8 bytes
> 
> * The pskb_network_may_pull function adds the network offset, shifting
> the checkable space further to the beginning of the network header and
> extending it to the beginning of the packet. As a result, the end of
> the checkable space occurs beyond the actual end of the packet.
> 
> Instead of ensuring that 28 bytes are present in skb->head, the function
> is requesting these 28 bytes starting from the network header. For small
> packets, this requested length exceeds the actual packet size, causing
> the check to fail and the packets to be dropped.
> 
> This issue affects both locally originated and forwarded packets in
> DMVPN-like setups.
> 
> How to reproduce (for local originated packets):
> 
>    ip link add dev gre1 type gre ikey 1.9.8.4 okey 1.9.8.4 \
>            local <your-ip> remote 0.0.0.0
> 
>    ip link set mtu 1400 dev gre1
>    ip link set up dev gre1
>    ip address add 192.168.13.1/24 dev gre1
>    ip neighbor add 192.168.13.2 lladdr <remote-ip> dev gre1
>    ping -s 1374 -c 10 192.168.13.2
>    tcpdump -vni gre1
>    tcpdump -vni <your-ext-iface> 'ip proto 47'
>    ip -s -s -d link show dev gre1
> 
> Solution:
> 
> Use the pskb_may_pull function instead the pskb_network_may_pull.
> 
> Fixes: 80d875cfc9d3 ("ipv4: ip_gre: Avoid skb_pull() failure in ipgre_xmit()")
> 
> Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>

For future submissions, please note that there should be no empty line 
in the tag area - i.e. no empty line between 'Fixes' and SoB.

Thanks,

Paolo


