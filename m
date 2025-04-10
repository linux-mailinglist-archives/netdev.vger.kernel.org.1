Return-Path: <netdev+bounces-181147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 748B0A83E05
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 11:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8EF18998E0
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA54D20C03F;
	Thu, 10 Apr 2025 09:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Pf4J4cEz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27C3202981
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 09:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744275902; cv=none; b=Z04IYmWHQ8X8rk8FUMOzUAp62FFscEkIyDYRQ5Ssqm0UHPWR8lPe6d4o+9DkY7S+WHMquJPuak1jFt08F/Q181wTodIX3F9bPTkeV0SjL8JGuZVu3S0sOQzkknD+gy59E15y7VcnFiquyZ0OLDLKBuRqwWj3XqP4vnAtz3dc2Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744275902; c=relaxed/simple;
	bh=OZwIbSvRUSGLWl1tL9qmG4B11LFmxdD7C1OePlZsyUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AHIoRMxe6mmJdqfGnAMrjURbbunmlx+lseC5+gGHQ7ADtNME+dAqvIp7w1OcBnMzB+M9+hQYcHnpIGHfcqU75uILklB9rSn5/4jYUKtT/2EGLoz5kKAZHYaf1pB1q12+TfRMqEoc+slusCrDNFQ0mZCtEdkLZ+Ij0piN6FNkzFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Pf4J4cEz; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3995ff6b066so236974f8f.3
        for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 02:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1744275896; x=1744880696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1952btLXU7cHQsNcVWb727zYRH7/3qTLg3XspNVuRZ4=;
        b=Pf4J4cEzO4zqLpsjTGtiIzeMbenJ3exGPmBTf5XfHHmVNKyLDEnk9Tp1/HijcxW7WR
         KazZbvwNZLeapZhGzWIg6M2Xu3ubdyNi2UezMcagpCAKmcVpVLBF3JfOcyFljZg7V8pD
         FG0bVpiXYNyIiIqWtntsoa0ohhTneej00842D5neLJZjnFl0gnRbkuF7TQr5Z/GtRc6J
         0IOKmgHTq2wOhD1qEriOZF8ENuTORXxpZZ/Q+QBQH6LV0HoxWyWdbVRvRfAMHIy2BACV
         iAYnrx8IEgpAZt4kWol9JjatwP2G5ej3048aFQpxmMFUqqFdlEh8xiGCHtNwsN8hdVha
         5eVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744275896; x=1744880696;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1952btLXU7cHQsNcVWb727zYRH7/3qTLg3XspNVuRZ4=;
        b=ZQ7qLUgpgn8XTgT37Ap9PSEaNARtnO8T1/NtY23U2IFyRVVGb2aV+XF0gAZJy71kUQ
         Q5pnuUUEn7FsWDl266dMIroTLTUPs3lnHxQH4Cv7Cb/EJg99k2Vna/uF/wx+hrzj8dok
         Zm4mywO7LYOPI0qsSPwZbMo7uSy1dHYTpgValCvjDJZxdMiOXREdfOwdJX1O/GucvzuR
         uxsp6oWlvLqAByOb9nQz3RNNiA+sLTRXeGhKptU0+svDkcMKgjwwHsFwkLrT0STm7HpI
         23RiyjDf0ScSKH6p2kR7+TLCTWGNjCbN9BNpvNgShYsUzcrlFg0YLDI2/Q5nHbwnI2tg
         zYIg==
X-Forwarded-Encrypted: i=1; AJvYcCWPg4n8/OUcLZO0mow86QQQOEtX/7DxRh//L/8NIGHubCO4vAeJAXdP/z7biK+igxNkOUxWLZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqOrbKaPTpD+Qru2fdsZz5R/GnzuuiScQapmucISOae6v+iU7L
	GswbyD4EFRzNiaVi8iX6JC0C+mNZ9YkJHsQhTuIEBLqMP824ybPfcFPia2Nc+O4=
X-Gm-Gg: ASbGnctA7ie9FeS/53vm4HFuvAxxXMmsNrd05O7cv/uuDXStVdmQ1Mh5l12Ot4gICpA
	sEFu2D6SanwFXco4ZD5QiYpK/6/eyfOfzDVYhh26d/yu3hBOzOVt7Wv7nrp6aZLgFd0CBgmx+Rj
	/YyqnT6aqcnDRPHbCZSvpye1q+PsuhhjlLM5XZFZQNnM0TykIeJkpb2EU5MCWYMbiXRMMUVQtYC
	ZveaHl+WTutA+eQ0zDAxRrR75gtynuuIxDb24u4BZpoLgwnhBrWh4C2yl1PqvhZXg5eLfedx6i4
	qq7pifSYVlLnQ1cjhhpn9gBCILdH3Jb9G8ZFOSu88Uy0IlWOfHYNcH4sAlYQeqg+yo00gzBj
X-Google-Smtp-Source: AGHT+IGkkQjBLplBuR9HbwrVjOdM4XOXyIYoFr5+9dCZpFldizkztvBxns4wuQQumwTlwlkWqHrZvQ==
X-Received: by 2002:a5d:64cd:0:b0:390:fc83:a070 with SMTP id ffacd0b85a97d-39d8f2254d1mr1400236f8f.0.1744275895761;
        Thu, 10 Apr 2025 02:04:55 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f205ecb20sm47986345e9.3.2025.04.10.02.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 02:04:55 -0700 (PDT)
Message-ID: <07eadf62-5ce3-4202-9372-3e7d0350702a@blackwall.org>
Date: Thu, 10 Apr 2025 12:04:54 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 09/14] bridge: Convert
 br_net_exit_batch_rtnl() to ->exit_rtnl().
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>
References: <20250410022004.8668-1-kuniyu@amazon.com>
 <20250410022004.8668-10-kuniyu@amazon.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250410022004.8668-10-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/25 05:19, Kuniyuki Iwashima wrote:
> br_net_exit_batch_rtnl() iterates the dying netns list and
> performs the same operation for each.
> 
> Let's use ->exit_rtnl().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/bridge/br.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/net/bridge/br.c b/net/bridge/br.c
> index 183fcb362f9e..c16913aac84c 100644
> --- a/net/bridge/br.c
> +++ b/net/bridge/br.c
> @@ -363,21 +363,20 @@ void br_opt_toggle(struct net_bridge *br, enum net_bridge_opts opt, bool on)
>  		clear_bit(opt, &br->options);
>  }
>  
> -static void __net_exit br_net_exit_batch_rtnl(struct list_head *net_list,
> -					      struct list_head *dev_to_kill)
> +static void __net_exit br_net_exit_rtnl(struct net *net,
> +					struct list_head *dev_to_kill)
>  {
>  	struct net_device *dev;
> -	struct net *net;
>  
> -	ASSERT_RTNL();
> -	list_for_each_entry(net, net_list, exit_list)
> -		for_each_netdev(net, dev)
> -			if (netif_is_bridge_master(dev))
> -				br_dev_delete(dev, dev_to_kill);
> +	ASSERT_RTNL_NET(net);
> +
> +	for_each_netdev(net, dev)
> +		if (netif_is_bridge_master(dev))
> +			br_dev_delete(dev, dev_to_kill);
>  }
>  
>  static struct pernet_operations br_net_ops = {
> -	.exit_batch_rtnl = br_net_exit_batch_rtnl,
> +	.exit_rtnl = br_net_exit_rtnl,
>  };
>  
>  static const struct stp_proto br_stp_proto = {

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


