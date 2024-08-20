Return-Path: <netdev+bounces-120169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244E39587A8
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 15:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5672D1C21CD2
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 13:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37BD18FDB1;
	Tue, 20 Aug 2024 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGCnDeO2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8D32745C
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 13:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724159641; cv=none; b=E76W5tquhQm4s5QPGsKhWC/kpS/WCICfWozgOZloa7LMBwkrNqL3KNS1t7Wwb5egsJz2ZQ+45O1yxn86+5JtJLqxdbZUnh4r4ommUOl+VaPowddmQtOu3StY5lvV4JoTcSCoaSC3vrTR4Op22cFF0DF2aLldAHMFfyL+GaI5UX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724159641; c=relaxed/simple;
	bh=uhrLadRMTglIPn3Zn3SZWPzmTNTTKZiHQxUwnCdahcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mnP4nk7hIwuA0kjWyT2PAhKCb1gRUhnCKzVNMVSmKD2v0InFxpPePwfQ23efRRKRNbGCSCbNNg80RRcVscXZPUYmQMGkb/GiwRnSHMH/siA4eheaxpip72ZJL9MPrt27AU4dUOi/fHPHIFvqfw0qNgsfFKvGUy9aleSb+XwJ9ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WGCnDeO2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724159639;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vZA9NsmYfHqlh7uFA5Iq6DDdHEhytABPy8E65xYTnnY=;
	b=WGCnDeO2jrNR/HmGd+px6F2GqWLG8uiSb/TXs1v6AW+z4QfNbH+zYim3oMHsKYDPHKhjga
	JmguSJXKODftS7CSKZ33NyG4LutDUD7Z9kcwiRVsgfDkn7ANb0UaMEAJ7LUy+ZN47vZtiN
	bxUn5zHX5C4fJNUo8NRxLT9Yx5LkdCI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-LfcEiLaROvGpfoZ-3tunmQ-1; Tue, 20 Aug 2024 09:13:58 -0400
X-MC-Unique: LfcEiLaROvGpfoZ-3tunmQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ef286cf0e8so50712441fa.0
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 06:13:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724159636; x=1724764436;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZA9NsmYfHqlh7uFA5Iq6DDdHEhytABPy8E65xYTnnY=;
        b=YPaQKT/QlFini7UiQG0JX/3CUup8Cx70j87ZiDvKTlUuy/YDEm64T6hdlHabF3uzei
         WqomFZftUKOg4pC/yXKSDCjYi2AcR3Z5alUJVTx3ItoKJZYjI8kHceWX4gQXgcovsq7k
         zBnAwwb0G/oSbkeEA5e47nUq3bLbGveZpReXhDLUWnTUAiuKU2plrlHnG4glf8oD+HPP
         Kexn4oWbUSdfDQ7ISk54EQ4amXMYRZzpWCvn7CwCJu1XhVOQt+mIAnVvefbGrqyg+bi0
         VgXFvO3gWyl5Hao7kQroaczfuy8v5C/ZxLK8PX6ce8fZ9zbJuk1TiTRlUoOL84e8Vggl
         80EQ==
X-Gm-Message-State: AOJu0Yy6QaohQewFW6g1zoWD3a/xDEoVC5viwFn1ale9eflCRFKI/Wqt
	yZ9zhg9QL7kPc7C52YORyS/y6eqjCePZ0jSNZuh1+OLtvV+7wzOiED2UucK6RTMGsaaHzqXAcc4
	REA13pyNclzHDLrSxJMqGBX6+CGij2vY3Jo9W/WGtuXJpMHUp7JX41g==
X-Received: by 2002:a5d:4e4e:0:b0:368:327c:372b with SMTP id ffacd0b85a97d-3719444bfa6mr9305631f8f.19.1724159626060;
        Tue, 20 Aug 2024 06:13:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzI6GnucFTXbBS1llruGpj59nWY1C+0+wKIAAyQncc21XjuGko7iEFzA9mv0ekZasAiQdM5A==
X-Received: by 2002:a5d:4e4e:0:b0:368:327c:372b with SMTP id ffacd0b85a97d-3719444bfa6mr9305594f8f.19.1724159625543;
        Tue, 20 Aug 2024 06:13:45 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b51:3b10:b0e7:ba61:49af:e2d5? ([2a0d:3344:1b51:3b10:b0e7:ba61:49af:e2d5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898abf2csm13028775f8f.107.2024.08.20.06.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 06:13:45 -0700 (PDT)
Message-ID: <a95f1211-0f1b-4957-8e31-1b53af888cb5@redhat.com>
Date: Tue, 20 Aug 2024 15:13:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: ip6: ndisc: fix incorrect forwarding of proxied
 ns packets
To: Nils Fuhler <nils@nilsfuhler.de>, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240815151809.16820-2-nils@nilsfuhler.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240815151809.16820-2-nils@nilsfuhler.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/15/24 17:18, Nils Fuhler wrote:
> When enabling proxy_ndp per interface instead of globally, neighbor
> solicitation packets sent to proxied global unicast addresses are
> forwarded instead of generating a neighbor advertisement. When
> proxy_ndp is enabled globally, these packets generate na responses as
> expected.
> 
> This patch fixes this behaviour. When an ns packet is sent to a
> proxied unicast address, it generates an na response regardless
> whether proxy_ndp is enabled per interface or globally.
> 
> Signed-off-by: Nils Fuhler <nils@nilsfuhler.de>

I have mixed feeling WRT this patch. It looks like a fix, but it's 
changing an established behaviour that is there since a lot of time.

I think it could go via the net-next tree, without fixes
tag to avoid stable backports. As such I guess it deserves a self-test 
script validating the new behavior.

> ---
> v1 -> v2: ensure that idev is not NULL
> 
>   net/ipv6/ip6_output.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index ab504d31f0cd..0356c8189e21 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -551,8 +551,8 @@ int ip6_forward(struct sk_buff *skb)
>   		return -ETIMEDOUT;
>   	}
>   
> -	/* XXX: idev->cnf.proxy_ndp? */
> -	if (READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
> +	if ((READ_ONCE(net->ipv6.devconf_all->proxy_ndp) ||
> +	     (idev && READ_ONCE(idev->cnf.proxy_ndp))) &&
>   	    pneigh_lookup(&nd_tbl, net, &hdr->daddr, skb->dev, 0)) {
>   		int proxied = ip6_forward_proxy_check(skb);
>   		if (proxied > 0) {

Note that there is similar chunk in ndisc_recv_na() that also ignores 
idev->cnf.proxy_ndp, why don't you need to such function, too?

Thanks,

Paolo


