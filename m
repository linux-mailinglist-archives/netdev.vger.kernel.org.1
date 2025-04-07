Return-Path: <netdev+bounces-179829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AFCA7E984
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAED31782EF
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0314A221731;
	Mon,  7 Apr 2025 18:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Cbj8Ztff"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA5922171B
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 18:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049357; cv=none; b=M8NxKHt7c8Xy2Y8mCQh6jSrfIVkH/iusrlVo3qKPxDt8PBcf2z+iNdI648XDUjRJRJBsSnLcfYnSFIEK9q+XhiYoLREgmrVlzlwRvnxn92uMCf2ylxvJR5/eU9bAvF2hUdRUoHn2AuWVAbYCjnlAbnYaPSEm4roCXQ6zYSmz1TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049357; c=relaxed/simple;
	bh=IBZucvcqT4kByOB/2qkqY3AG1+DBDmog6A5GixPbISQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKtjxCef5BnEvVXaM9v6sHLwMdFSK/m765HschYHsz6FxXixaEeeoltvfmKdB7yRgiE0FH4fRccU8K5KsPLkq0qIGRd4Py2gWISyuc8DgyW+p5oUfFkwSS9cBKeu9/wKUhR8FCCzDmEjTdbFGDCZe54VEU0eE3z8D0dVYsuHCPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Cbj8Ztff; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-227cf12df27so35234745ad.0
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 11:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744049354; x=1744654154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=goTb4dVxB6asAZ8vEe4CdQ+UwUmo6qha4hQXKVTgnGs=;
        b=Cbj8ZtffRvqbsEfa+ASeW2SwD2/XJxb+tCMIiUHlQqi90fgQ+PT97Hsdh6pYA9cBvv
         00oWWfky1Qr2l8pcMIsnHLgJI9oKD3M3KhjgTVVU5d5CCu/rCCfzwCPnuC6jYZITwwiH
         gC5SeDlz4EPL3J+/XX5UDSFAqxAyT+HfVIYro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744049354; x=1744654154;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=goTb4dVxB6asAZ8vEe4CdQ+UwUmo6qha4hQXKVTgnGs=;
        b=ZnZeGlNa/+86KwJOj5btTLpbO3096bI+FtSU2H8QeHQWSJCGJs9xVU5Z1DQIb70us4
         2fWK2FaQMTAsqlL8ghefxbEi1XqpIbb1PoSojTT6XLMNBoI/s+bwUeUqhZ6ecTDUMLZx
         aYLnzBsl6c8Q6DaMUZwhQZyoSZdnItiHYfef2YpGtq3fpE47r0W9rYshCq/CGUHl7Pwz
         qydsVk30nibX8aUiHQGMNj+eftGzM4B0BR7sFNNv4VSv1pZqouAEwWwYoFFDYap1NK+E
         UTa8rXopQZ5F68B4rYoYm1u3EvI9BsJRzq11p1G+dGb7jKNLcRuIcnry5Zdlo8nK8vZr
         5TwA==
X-Forwarded-Encrypted: i=1; AJvYcCWpRrMIEVqJF5Fv5NyJtiGysqIyEzlW0IiS6VjbtaW8RflMqOatzINLg5ar8zOCpAZ73dZj8as=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSnLP+mOcjnRqg6eI4EhXPNejZL2/2R8gV8rXHMFq0MaWiI1x1
	h4GEK9tafbOk9/DoKqmfaHToZsnQqUOrAQ1Td0825jIVe63sge+QU/6SsU9HUIY=
X-Gm-Gg: ASbGncuGOc+EhAZ/3r75/9EfQ9+Tu3yP0hYAFjVOB++Nppt9dDJQBmwTBvVxf+swc+7
	vjOKbHnXK0UdN/BixKAp84u1UYxhi1bwyndaaYw2jVVzr/Q+jqJHKpdvGcvO8pb8hhi21ggTp8C
	19v1+8zZ98rAzpJkrs1i9pto55gXUYpW6PRRIDf6H9qhUVPP49DUHhhUa+EoQJmlsabsGHBu779
	AwEuDDm02EDdBaxTiVzpJJcYIKk0mMcRnFmj5+XKXKUJe7ddmEqqoy18fPu+YDGNaHGTLmrLy52
	iS1cdVictWxM2SPwiWjtr26bHdJCAz20hl3CGMWi9KjNg9gZC3JmNzDy9KhLydCr8JabVWAeQj2
	SrOStJVOdHkc=
X-Google-Smtp-Source: AGHT+IFLFsq6DRleDxDBCSlGG/JwhggVdYbV8Uae51gZrs6k16xW2fXW9cgZsr1hVDVTIFkLlBCTbw==
X-Received: by 2002:a17:903:1a08:b0:215:9eac:1857 with SMTP id d9443c01a7336-22ab5df17cbmr6648305ad.5.1744049354385;
        Mon, 07 Apr 2025 11:09:14 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866cf04sm83985115ad.161.2025.04.07.11.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 11:09:13 -0700 (PDT)
Date: Mon, 7 Apr 2025 11:09:11 -0700
From: Joe Damato <jdamato@fastly.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next] net: ena: Support persistent per-NAPI config.
Message-ID: <Z_QUx7c-7LxPEuor@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20250407164802.25184-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407164802.25184-1-kuniyu@amazon.com>

On Mon, Apr 07, 2025 at 09:47:59AM -0700, Kuniyuki Iwashima wrote:
> Let's pass the queue index to netif_napi_add_config() to preserve
> per-NAPI config.
> 
> Test:
> 
> Set 100 to defer-hard-irqs (default is 0) and check the value after
> link down & up.
> 
>   $ cat /sys/class/net/enp39s0/napi_defer_hard_irqs
>   0
> 
>   $ ./tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>     --dump napi-get --json='{"ifindex": 2}'
>   [{'defer-hard-irqs': 0,
>     'gro-flush-timeout': 0,
>     'id': 65,
>     'ifindex': 2,
>     'irq': 29,
>     'irq-suspend-timeout': 0}]
> 
>   $ sudo ./tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>     --do napi-set --json='{"id": 65, "defer-hard-irqs": 100}'
> 
>   $ sudo ip link set enp39s0 down && sudo ip link set enp39s0 up
> 
> Without patch:
> 
>   $ ./tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>     --dump napi-get --json='{"ifindex": 2}'
>   [{'defer-hard-irqs': 0,  <------------------- Reset to 0
>     'gro-flush-timeout': 0,
>     'id': 66,  <------------------------------- New ID
>     'ifindex': 2,
>     'irq': 29,
>     'irq-suspend-timeout': 0}]
> 
> With patch:
> 
>   $ ./tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>     --dump napi-get --json='{"ifindex": 2}'
>   [{'defer-hard-irqs': 100,  <--------------+-- Preserved
>     'gro-flush-timeout': 0,                 |
>     'id': 65,  <----------------------------'
>     'ifindex': 2,
>     'irq': 29,
>     'irq-suspend-timeout': 0}]
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  drivers/net/ethernet/amazon/ena/ena_netdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thank you for adding support for this!

Reviewed-by: Joe Damato <jdamato@fastly.com>

