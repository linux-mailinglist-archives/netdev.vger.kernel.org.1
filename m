Return-Path: <netdev+bounces-226416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF99FB9FF6F
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 16:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 437DC563380
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 14:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD602C11F8;
	Thu, 25 Sep 2025 14:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gOtOKgJp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE9C2C11E3
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758809750; cv=none; b=GUe0a+GToL6OIB7vpYglebELO082ZYHpRCJPGsEowLaqmHfNTBAWHY77PFXOBG2lwqn/ZC05cVuDmzZEH7JVBl63tje54/JeE5ojEb9foCTEz84IRSKOWNl50lpz0oZVYXLIvdXNdcyi92WmHaf1IV3OzCga8kMTONFwNX5hMws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758809750; c=relaxed/simple;
	bh=xJx89n/TD1uH/PPYvFRNbeeYRr6JVPkNCfM25rezuQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DSih1Wu0HeZ+cNa+Ux0TVWxi6qYJpowtpGii8UFzRw000Qr0YtMJYgBhjrQhdA6bIlw2faAo+osdQKUkemebcrhczm6gmI++bD6AoI7JJLSWUUYWG8C1mXuedbiy3WWWCFUBAoppJPn1QFSMdapCVNoFsxLx89+2SMCdI+dx8k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gOtOKgJp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758809747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=toRp1/RcimDUHndA+f/TmT1pRY42B19c6ecUTq9ixvw=;
	b=gOtOKgJpAz/DDelMuJwQzA6ChWwPlno7RuqUL/2ZW1YopScEQkoBTDKrfhEWa2gcGw8zrB
	f3gMN8vJl2KcnSS9I931LCXaXrP996cVshthYa8NlaTdvsCsmZfF+lsgnWAEcJ0sGmNQfw
	WBcvzSW2snTNLCEOAH1KCX0g4ZpCvwM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-mVhhm-D2Oeq8g-chGKw3VQ-1; Thu, 25 Sep 2025 10:15:46 -0400
X-MC-Unique: mVhhm-D2Oeq8g-chGKw3VQ-1
X-Mimecast-MFC-AGG-ID: mVhhm-D2Oeq8g-chGKw3VQ_1758809745
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e36f9c651so4173965e9.3
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 07:15:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758809745; x=1759414545;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=toRp1/RcimDUHndA+f/TmT1pRY42B19c6ecUTq9ixvw=;
        b=EKKItXnAn/6EFuXcRN6MAnpMa5YT2N9Fbujlha3rA4cnFmQErAYdMqGDn+EVkBiSt6
         lBM4DthShvTZNbmsMraBNj9g5XjYtjtnCOKqkVEFAKrHiMWuJExC6yvIpb0bKMQa3bfn
         6eLb0TJdg41szfGlzItiNndK8E0TAyxdRCjFYItspNDnkx/Rda6bE6rB/dM3KsA/WU8R
         hGI9DsIe/Hj1/6oWvc9otMGx2/jF9lUgHOA9un5OAKgZk7KK7FfryBk603bojVgy7MoC
         DXKauy5gTRhBeHtmG3QvUICMB+CLpWfzfgovsa1dFu2pYZx+9YCwuzeyuCheieBd4DHA
         zD7w==
X-Gm-Message-State: AOJu0YwPyGNDzzg7MNvu/acDL0d6peRNdM00SN2KmJoqMnQS5jnV+3Ak
	WC0JuTvFX0e6xY5g6449fsO63VoaAp8dh/YqpYFSm1Qcw9FbSSt8vEjLY4XFoKCNEaEezzujZ7t
	pIlkO6krRh1cfFNbRS3KV6r6XXWoCElE3KXk2hhCHoO+YINbGe0ErJAqSvg==
X-Gm-Gg: ASbGnctstyc8WRQ/wIBICmE8cUF9mffEweVbqj93pNvp0k01DFEjbd3uaI1T5NDS6io
	JHXNp7cEUP8oGws10Q5DYtUCC6OWprjQrTmT8jn1X6I2ZmaAR13RXYexRT47sIWFx3x5AI/5i+C
	3z1lpcx184QXwvMn3hH/bcsyJ3ms2ik/REmByzVoR9crSIki4KzEpglXa5Cpqs1wMXYlsh4kurU
	Q4Q96VymKlqWUCiQhdyRWCmzw2s0/MQWusjasNIxcR9BkYV8oaBfGp0YkSf97gZblNRXfIxVcIR
	pq1+Zhh2gnIMyNGcbUFJeqDCb131hPjSxZqHgaYIKXfG1sb36+P3k6IGM/BZcpz5zgs6LJem68d
	P5s1q2y95IzOR
X-Received: by 2002:a05:600c:1d16:b0:45d:f7cb:70f4 with SMTP id 5b1f17b1804b1-46e329bca25mr39093715e9.13.1758809744782;
        Thu, 25 Sep 2025 07:15:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFl8HCCdj8jIlg20UIq3xlz38e2xp5h6nPJpFdTJ5+Oy8TFsvr3FQ/AD9cYQcrax7MzoO6XqQ==
X-Received: by 2002:a05:600c:1d16:b0:45d:f7cb:70f4 with SMTP id 5b1f17b1804b1-46e329bca25mr39093295e9.13.1758809744229;
        Thu, 25 Sep 2025 07:15:44 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e330db1a6sm18736685e9.3.2025.09.25.07.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 07:15:43 -0700 (PDT)
Message-ID: <5b8ed8b5-2805-4cfb-8c9c-2a8fa4ca8fb2@redhat.com>
Date: Thu, 25 Sep 2025 16:15:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 13/17] udp: Support gro_ipv4_max_size > 65536
To: Maxim Mikityanskiy <maxtram95@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Ahern <dsahern@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, tcpdump-workers@lists.tcpdump.org,
 Guy Harris <gharris@sonic.net>, Michael Richardson <mcr@sandelman.ca>,
 Denis Ovsienko <denis@ovsienko.info>, Xin Long <lucien.xin@gmail.com>,
 Maxim Mikityanskiy <maxim@isovalent.com>
References: <20250923134742.1399800-1-maxtram95@gmail.com>
 <20250923134742.1399800-14-maxtram95@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250923134742.1399800-14-maxtram95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/25 3:47 PM, Maxim Mikityanskiy wrote:
> From: Maxim Mikityanskiy <maxim@isovalent.com>
> 
> From: Maxim Mikityanskiy <maxim@isovalent.com>
> 
> Currently, gro_max_size and gro_ipv4_max_size can be set to values
> bigger than 65536, and GRO will happily aggregate UDP to the configured
> size (for example, with TCP traffic in VXLAN tunnels). However,
> udp_gro_complete uses the 16-bit length field in the UDP header to store
> the length of the aggregated packet. It leads to the packet truncation
> later in __udp4_lib_rcv.
> 
> Fix this by storing 0 to the UDP length field and by restoring the real
> length from skb->len in __udp4_lib_rcv.
> 
> Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>

If I read correctly, after this patch plain UDP GRO can start
aggregating packets up to a total len above 64K.

Potentially every point in the RX/TX path can unexpectedly process UDP
GSO packets with uh->len == 0 and skb->len > 64K which sounds
potentially dangerous. How about adding an helper to access the UDP len,
and use it everywhere tree wide (except possibly H/W NIC rx path)?

You could pin-point all the relevant location changing in a local build
of your the udphdr len field and looking for allmod build breakge.

/P



