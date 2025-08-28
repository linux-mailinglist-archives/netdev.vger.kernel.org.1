Return-Path: <netdev+bounces-217675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 193FCB39804
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 11:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C31116802A7
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 09:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AD922F74D;
	Thu, 28 Aug 2025 09:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X19UdC62"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0531DF996
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 09:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756372760; cv=none; b=AuYRXAHaeovIR8dYaMqukbopzHktZcFX3+HhAOpQlvFUHWSmyJkI2pxFR7D23trupBRoL0F8TaX4Xyx4uIgkiLnVrXNUPRSz8FODWb1xDY9U+QkXQzEo8oRZDCwdhQeVNzIlJtml75jwE7xxVuJjjAoApsWUuAf3Nq2hFnBJzDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756372760; c=relaxed/simple;
	bh=FfoXFGeGmnpKxzS/K/q3q81DIcoMsb+Pu2BTo37S4DA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c2wSmlYjfIkiEx2lxuS02JqTOZk6FSDaO6J1uMiz2eJsaIIegLwjWsct1AEHLTGzGaq80u5og+VALKQIjSn9oU8QYQWeFJNsb9HFbTpiR8CG77W/nlPExRgv+WuyQ8vlcjZWOOl75TVa3GeT1n9zbx67zC+xQ88hy9rg5JWYao8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X19UdC62; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756372758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Bp45yh3Te0X9QhLiIqLtMGTynS3AxXPNJIWRzKQFuY=;
	b=X19UdC6216VrRUCYeg3SfgdSUh/ANcjzIgSFqJb5Wfl/pykjqxLrRQ6NT52vSBw1lnWwlf
	ogn5VlL7h0CX/UiClo7hvKVQiYcJCKwkSb4HXgX5zOWSflZk0Xw/Ar+gSKyq/zpuBjbE3R
	4WKrNU/wM5ew6wssrfCgf8UHZjDqKtM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-vx1a2UUgPbuj1kOuezv44w-1; Thu, 28 Aug 2025 05:19:16 -0400
X-MC-Unique: vx1a2UUgPbuj1kOuezv44w-1
X-Mimecast-MFC-AGG-ID: vx1a2UUgPbuj1kOuezv44w_1756372756
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e86f8f27e1so197151785a.0
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 02:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756372756; x=1756977556;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Bp45yh3Te0X9QhLiIqLtMGTynS3AxXPNJIWRzKQFuY=;
        b=fnJkQFDSjBTmpKzbHiSQNAvJxx8JPd6K0UzBP2WmQTATBT5iPPKIFfkiRC+2C/5poj
         CJB/ZJSUWWBf4wuuR+W7EJwJ+V59tDc7SzTRAk0S9NV/iOXoM1Hs914QylMPwY6RG0e+
         KxPwjdVJvg8uuEE2ifbdzbwkeRTlkq2WK++NTMPy+Ma7HIqsCwtnx614RNSGluSIvWeQ
         iDwq3zDQOFKupN06XgF/bQEaQ5Ir76upXSv9vcrudMFQbMPfTxscAeYYDTFWOMVSdHci
         fH0mqVgIpKwsE0iPHJLBuYjymJZWur6Zbcgeu1pfjEVntwgz9aArBIO6qtVo6Th+o2hO
         jxAw==
X-Forwarded-Encrypted: i=1; AJvYcCXMMZEhHo0mO84xioC9wA7dIHsmWUaInj7DVq2qIZ6BHWVCZY/LREtxqdH14AGvLDeQSRgTirY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEqGyRuWoNA79i+qv8ZEp1/EaMhxMHoscjZ6FYDjtD7VjCmiON
	D+S2vSS9DuRJ6PyI3hIiQp8gEqLGEOPnnLe9rG6g0o/IwcegyoM39S2UNkvR8fnur8u9DHHn8iL
	xezkBgkvMdXwt5U/1FpLqpqgqkT8sSW+438PVCn1HCjKTUADNfK2/Xbcc4g==
X-Gm-Gg: ASbGncsQ23XODNQTFmueTCmP6ozM5vv0VbUuqZVKagdzxRwdzQ0AxKDDjoY3XVyLA5H
	vaVD7XHoMqohgowMNeobl0Om3XMr08Balu/6ymYME5MQMNY9SYBmOsLSE6UFEd/jqhnn2gJO+E7
	lzGX4x+Igg7v3mYwn7wvlAVSRzaE55rGJs4M9BJnL3tHdLsBctTelAQZn30Em0um6QnTISUug9c
	snG7gfZwNJx6X95RGCA5izeJCIZ9SBW8BCQJIufaQBVKln+A5HLSwypsBdK/aUl4zq9hiOkV4bV
	CIr7+iRzktwJBAcwYYtzAcRfSDMzsW+0axjXZ/A6FdDrwPc34CPGJLVDToMFseCp49WQqKPzNTL
	r9JfZPZnSUyc=
X-Received: by 2002:a05:620a:7013:b0:7e8:7a7b:5723 with SMTP id af79cd13be357-7f58d942121mr778015685a.22.1756372756141;
        Thu, 28 Aug 2025 02:19:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHi9aA2lip4GhP2MqXoLgeWU1mVLS0aUtyXoB0MHe+cWNBrCSQkgSBeTYDleWgs/vjgtimwMg==
X-Received: by 2002:a05:620a:7013:b0:7e8:7a7b:5723 with SMTP id af79cd13be357-7f58d942121mr778013985a.22.1756372755714;
        Thu, 28 Aug 2025 02:19:15 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebf3da460fsm1040835785a.62.2025.08.28.02.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 02:19:15 -0700 (PDT)
Message-ID: <147f016f-bf5e-4cb6-80a7-192db0ff62c4@redhat.com>
Date: Thu, 28 Aug 2025 11:19:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net] hsr: use proper locking when iterating over ports
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Jaakko Karrenpalo <jkarrenpalo@gmail.com>,
 Fernando Fernandez Mancera <ffmancera@riseup.net>,
 Murali Karicheri <m-karicheri2@ti.com>, WingMan Kwok <w-kwok2@ti.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Xiao Liang <shaw.leon@gmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Johannes Berg <johannes.berg@intel.com>
References: <20250827093323.432414-1-liuhangbin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250827093323.432414-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/25 11:33 AM, Hangbin Liu wrote:
> @@ -672,9 +672,13 @@ struct net_device *hsr_get_port_ndev(struct net_device *ndev,
>  	struct hsr_priv *hsr = netdev_priv(ndev);
>  	struct hsr_port *port;
>  
> +	rcu_read_lock();
>  	hsr_for_each_port(hsr, port)
> -		if (port->type == pt)
> +		if (port->type == pt) {
> +			rcu_read_unlock();
>  			return port->dev;

This is not good enough. At this point accessing `port` could still
cause UaF;

The only callers, in icssg_prueth_hsr_{add,del}_mcast(), can be either
under the RTNL lock or not. A safer option would be acquiring a
reference on dev before releasing the rcu lock and let the caller drop
such reference

> +		}
> +	rcu_read_unlock();
>  	return NULL;
>  }
>  EXPORT_SYMBOL(hsr_get_port_ndev);
> diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
> index 192893c3f2ec..eec6e20a8494 100644
> --- a/net/hsr/hsr_main.c
> +++ b/net/hsr/hsr_main.c
> @@ -22,9 +22,13 @@ static bool hsr_slave_empty(struct hsr_priv *hsr)
>  {
>  	struct hsr_port *port;
>  
> +	rcu_read_lock();
>  	hsr_for_each_port(hsr, port)
> -		if (port->type != HSR_PT_MASTER)
> +		if (port->type != HSR_PT_MASTER) {
> +			rcu_read_unlock();
>  			return false;
> +		}
> +	rcu_read_unlock();
>  	return true;
>  }

AFAICS the only caller of this helper is under the RTNL lock

> @@ -134,9 +138,13 @@ struct hsr_port *hsr_port_get_hsr(struct hsr_priv *hsr, enum hsr_port_type pt)
>  {
>  	struct hsr_port *port;
>  
> +	rcu_read_lock();
>  	hsr_for_each_port(hsr, port)
> -		if (port->type == pt)
> +		if (port->type == pt) {
> +			rcu_read_unlock();
>  			return port;

The above is not enough.

AFAICS some/most caller are already either under the RTNL lock or the
rcu lock.

I think it would be better rename the hsr_for_each_port_rtnl() helper to
hsr_for_each_port_rcu(), retaining the current semantic, use it here,
and fix the caller as needed.

It will be useful to somehow split the patch in a series, as it's
already quite big and will increase even more.

/P


