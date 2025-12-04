Return-Path: <netdev+bounces-243581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E3ACA4142
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 15:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A54F3037CF2
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 14:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521493451DF;
	Thu,  4 Dec 2025 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PtYERQ2f";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKCb1Y5A"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050113451C6
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764859384; cv=none; b=l0AGe/sCPUndYo9qq24mlpCHjPg/wRgUUXRz5L9xq2evBMDvI+lXIIjnq8c/E1UaV4H4XFKfy+419s6XFYZ873QZ/DUP57pJUZIKiYusynFlVCi1nze9312q2ksNrLo63o7GBdhAqZXthciEZuoM4H4srACVI9613FxItaUccWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764859384; c=relaxed/simple;
	bh=AV5mxYzuJRY9QKz5J8npWRK+M05FxuwULtIwjrSBO6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XrmDMlDQCgKCeN6Gpb/3f9dTSglQpHPVic4IVxqhpM7v+snPZSZi82kmc7BQYW3BSYg27G3Ou/HL79jk/GAC683jVW/wPuL0YJ502Vz/tBcaHk/fx1JGNjhLiNINkVLZ30JZxiKcrzlJzl7mqgPdXajPbxsvG9FBTjW60/t4eIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PtYERQ2f; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UKCb1Y5A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764859381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5SPciRZnhMCYxxi9bUFLlwchhvtriJcaoeYo268wAs8=;
	b=PtYERQ2f+aRPrk6kRHOJMTfi8ZMRwhdv9HibcO5WS0vLF3DPQQmuh8MlLD0mowiypNJMnN
	5/EW2Qd5xzgVSIS7PGwwCvDPqgrHpOjpzi4NEaDM3g17OgffZkDYyXmlQ50B+VvHz6iaFU
	q2X3mMhPbmyreuGejuPfijioCeuu5dw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-mzuGWZ4qPp2zprJHlMWO7w-1; Thu, 04 Dec 2025 09:43:00 -0500
X-MC-Unique: mzuGWZ4qPp2zprJHlMWO7w-1
X-Mimecast-MFC-AGG-ID: mzuGWZ4qPp2zprJHlMWO7w_1764859379
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42e2e5ef669so1113543f8f.0
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 06:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764859379; x=1765464179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5SPciRZnhMCYxxi9bUFLlwchhvtriJcaoeYo268wAs8=;
        b=UKCb1Y5ACAFsfXNWbE9weuQCJUW7HCP0MOyi5K/uaoCBKlykoTQENz8CQ5RDdldiDF
         s+bE7Nh4WTb6eBKI6EPwiUzkb/OdURH6ZqIhuV111u8pqA9F6oFW0MArdygxgsiiQvEq
         hwuiEp+E3hp0mlN8pl/1JeqYHyLQWmdu8+iK+DnXgSQ4Lh1datrx3AaUrsWJze01FDrS
         9g2TGIqrCvAfckhQUftv9zlwW0IpaH8+D3C5YRsAumNKD4cYTo2YgoIMlIGwdonTGrPh
         48/5d76dHwW+WTSwAf4i/FkUlsfFmFYeYRP4eJtZELjVv1hG44/wQS0+5V6phxGtVrVs
         vJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764859379; x=1765464179;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5SPciRZnhMCYxxi9bUFLlwchhvtriJcaoeYo268wAs8=;
        b=nWwMDfaqHbpAlJM+ctirmmySfDSoNGOGzT/iEJ237r7gN8gdIhGuvsDfgVCGvI7mpn
         dLIU8fnbRyJkJfcPCHe9fwKKifIleKOL96jAJll1ccq4p9sTo77wVKB/4fsIa6NGUGqK
         93MdsSeB/ixc3r6m4rObufusBskWvQhMSTFvdi4FhPdZBMXecL+mdDGdoUROMn1cB7gO
         Br2E+F2KAAivfagLwQTlI79Q7LvBnMk4+A2262rqnBz0XGqpD+N5ghq0fDVMYSt0X1iD
         AOFGrSjeQq+aCKgdccwoaXI+GO8/ZIMOS7BTYCW6ifMSpaDedxvD80xJItuHYXNxincg
         zBFw==
X-Forwarded-Encrypted: i=1; AJvYcCUn4j/u2GO4BbJFKfucZ7hoXU4B7tEj1s51t8fSto4fgHAjkC6pZ/EmmWlTlOG/OJ1tZruVwAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEMy6x3Xu+YdvVOEfexQu0FyU7vnvbRY8mIApf5vsYmazlkgNf
	V63X+pVlzGfA0AqVTGQ8ktB8jkL43li0Y6DLAcFeRBfw/gBa2rYEfELNmmHjDhqN8to9JjWDu2W
	Cz+Kk8jIHzEP6P7MuuwgAId1K9xl8qNERtlclFDodXQYTn7kFXKUZmy+v2A==
X-Gm-Gg: ASbGncsCKTGiFb/vuRFbIIdCPzf3RxaqQwRFAJWMETXX5aNSrTjoYCGhFRCOwbgh1eZ
	jtvfV1Fcm5QRZimq/6qvHzHAgInLv77n7BxQ+QmT4PBCfkCY8GICR3FF0W6ZM7Q20uJDU6Ka3jE
	PlVwGi4DDTD2zZxG/2yJhhvFxWvQNA2OyHwId2BQcJo7Y5fD6EAPPD1eRkb0zEuFEuo5W79wIkc
	1jKjk8jFoQI0ErzaDzyLbDqnzn20wANgvWrZ1FbiuYMFPah15SNyVmrszOZjdNd+PX+uDaauiLC
	ctMeBlqCCVvT7tFR+eWE89jyUJeDdJYiKwtXlZNwMOTAfebP9ocvjlJau/3F/c1Wr5Lk7kaxDAO
	1wdReAnNClX3W
X-Received: by 2002:a05:6000:40dc:b0:42b:3c25:ccea with SMTP id ffacd0b85a97d-42f79854663mr3262706f8f.42.1764859379079;
        Thu, 04 Dec 2025 06:42:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHq5iHKmbwlNS+kV/3eOCvmvglxRGYX2IRDqq4Wl36tZWf7LIh1cmyHgIKvKJm10WNznK22og==
X-Received: by 2002:a05:6000:40dc:b0:42b:3c25:ccea with SMTP id ffacd0b85a97d-42f79854663mr3262682f8f.42.1764859378686;
        Thu, 04 Dec 2025 06:42:58 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbfee66sm3527210f8f.11.2025.12.04.06.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 06:42:58 -0800 (PST)
Message-ID: <3029c00c-4df4-4389-a031-76d4793a426a@redhat.com>
Date: Thu, 4 Dec 2025 15:42:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] ipvlan: Take addr_lock in ipvlan_open()
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Xiao Liang <shaw.leon@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Etienne Champetier <champetier.etienne@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>
References: <20251202141149.4144248-1-skorodumov.dmitry@huawei.com>
 <20251202141149.4144248-3-skorodumov.dmitry@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251202141149.4144248-3-skorodumov.dmitry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/25 3:11 PM, Dmitry Skorodumov wrote:
> diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
> index c390f4241621..53d311af2f44 100644
> --- a/drivers/net/ipvlan/ipvlan_main.c
> +++ b/drivers/net/ipvlan/ipvlan_main.c
> @@ -182,18 +182,18 @@ static void ipvlan_uninit(struct net_device *dev)
>  static int ipvlan_open(struct net_device *dev)
>  {
>  	struct ipvl_dev *ipvlan = netdev_priv(dev);
> +	struct ipvl_port *port = ipvlan->port;
>  	struct ipvl_addr *addr;
>  
> -	if (ipvlan->port->mode == IPVLAN_MODE_L3 ||
> -	    ipvlan->port->mode == IPVLAN_MODE_L3S)
> +	if (port->mode == IPVLAN_MODE_L3 || port->mode == IPVLAN_MODE_L3S)
>  		dev->flags |= IFF_NOARP;
>  	else
>  		dev->flags &= ~IFF_NOARP;
>  
> -	rcu_read_lock();
> +	spin_lock_bh(&port->addrs_lock);
>  	list_for_each_entry_rcu(addr, &ipvlan->addrs, anode)

I'm surprised lockdep/rcu debug does not complain above. In any case I
think you should replace list_for_each_entry_rcu() with
list_for_each_entry(), here and below.

Thanks,

Paolo


