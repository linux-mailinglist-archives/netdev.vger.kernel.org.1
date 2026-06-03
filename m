Return-Path: <netdev+bounces-294660-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NA+SFXrbH2oHrQAAu9opvQ
	(envelope-from <netdev+bounces-294660-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:44:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1589B63558C
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:44:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackwall.org header.s=google header.b=FAAfJEvx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294660-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294660-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A92E305DF84
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 07:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C7B3FD122;
	Wed,  3 Jun 2026 07:43:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48273FC5B0
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 07:43:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472588; cv=none; b=jNtJeezWJIynPKIPXAKuo5MHdCzrpi/PkEFSXnB/3Yl/8D8BtXsKooOSsbKl/vrcEJkTkC5XHWWE5LuwI+SHhdG3RzyVYB3whOdcaJNMJEi9m9Vr4P+yctwpkDcnmiEVQYKIFAEvNRhpL5m0nBljM492nKgJ447m9rPhddtWsa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472588; c=relaxed/simple;
	bh=OlI66EilPnqu8QuClGwFlVmdcWOlIjldFP0w1ONK4/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TVbM3Wb37AcHhlLbLPkcEk0l0/rjKFzWYY4zpovQU3Gdt18Sy/buqzgqvbDjOSEjqJ2TqowAYAhQTg0bLCDvPcbdJ4JpOBLbR98b4AfaK/4VFXFCLpi90jVTEzDL5k8VE7pIr9Dv6zrd655CS6ds0QBcWM/0y/VnLX9rY+/gx3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=FAAfJEvx; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49041e84237so2987235e9.1
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 00:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1780472585; x=1781077385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XqRhiUHLirM2psgZn8D3gubdS1eIpRFhNr3ak+JjW8I=;
        b=FAAfJEvxeoEeZADeBpbQppcafYgn3bK/VRg+0B7wUhKMdpkJhZuFyzbGw3+VQ8KQW1
         Y7BXmf/4J69CTu7kjuth2ha5B2x0B9sFfAS8fjXHrBZ2zTedXOjeFtfS5TDLt2VMAMEU
         z4En/pU3bNT6dm83/6gVe7ADjt2rwR0JqRGaTILU85T/5+PyUwLKYuBZCpavNY+r5EZk
         E6Kwb4DqIZ97cdmdD1fb3G9M6EyuMYoSkk5DrL309BuVxC4UpSwcd6VEkh/nlZQScXBl
         PHzPBxru56Gac6RUs6+zNG2UsBjomf2N+jgWd8yj0VUrPzD+GMSnsZZ4SOMqA+qhQE25
         /Vpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780472585; x=1781077385;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XqRhiUHLirM2psgZn8D3gubdS1eIpRFhNr3ak+JjW8I=;
        b=BRahc8+bLhELDQfIlEUhZAMDGCT93+0PM5m7NzT39oK1pzi3EcBZvZFrIraT7SfWqi
         sKxNxkM2pj66iZB2jSljsPsvYt89pyeparDjSVoSGgGXRe7KGXs1h/qUsf8Bhn2Pu05c
         7mVNB6CpUUtShExFDac6HSWgVIxcFIZGysRxYfDWn7tqQJ94T3OxFWv40I5rI9aETMTK
         GtUp43oPNkKJMg/2oOeQJsIBxEJJWw2L9a/h0QtP3q6dNFLMLYm9VSp0EDLMGE84amWi
         Xz7lDIS1a4VT84YgwzGf19x7zOgmzVqQ0OfaaLlmivFNZ3yFrEhYYbUhOXa8/Qx1uEHO
         NmtQ==
X-Forwarded-Encrypted: i=1; AFNElJ9su5HuJ0asDlFb4ChCX0l/TOe4Uj2yYP00Hxe5YnNnmN2KkBkVcIuxyTEaRUtGqmyllv49Pw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyaTufATV5BrDfAPlW0Wx7gXLo8G5k+vTo2Z9wqsnve6OWzNL+
	wr7oPEe4KHPZieOnjgou0cuGW1EO9QJk3XmYq45xox/CeJvl1lCwmIfqCuj1wOkIqy4=
X-Gm-Gg: Acq92OGc9LrOKKZnfN+txJhD5W1r1NNpc1VLY0VUX9KWEUBEbeGu8ZVa3gh10URwacQ
	YL/Nztomgn1vZv4/yA4zqQ1eUSTybTRlQJ7hC/ocBtiLDAhbnAsgc7sxqOcMqD9qlEeW4Q00cAo
	hmp458cKdu2C0rOFsU9IfdAbUwhvuWRYhx2k1XsxkaLqhS0DcBLtwSi0HtEoTzx5280nP5o/HDa
	KsxOtLM5mYEW7WIdF3uwfUH4vAM2EpZwe0b2bA+UGEs321O8PQv5uv0/oN8IQPZwQApy/QtOS0V
	tuvJ/vjGVPxPfxZCvNHvPPxqCgO4fv86dh4cuKvAYkhxzHKcQ9OSTtHKJtORPsM5czZaNPVqY7a
	14C7TZiUfIuAAHn+jFHvHwzGKi8HcQgTXdCIMniJbS0EvJtRwSXo/7nVT93inTYfRkYuUJmDx0U
	0N8HcGP2znfhaV7v8yR3GFCizUG/6rXjcz+cnXrJie08CkgtYl/y3Gr4SAq+/jkTGi
X-Received: by 2002:a05:600c:458b:b0:490:af63:2cb1 with SMTP id 5b1f17b1804b1-490b6128dc3mr30475795e9.7.1780472584731;
        Wed, 03 Jun 2026 00:43:04 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b63e63d7sm41036715e9.12.2026.06.03.00.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 00:43:04 -0700 (PDT)
Message-ID: <b8f5d0be-4a0b-4bf4-b47a-d809fc9a2775@blackwall.org>
Date: Wed, 3 Jun 2026 10:43:03 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 04/11] bridge: use BR_ADMIN_COST_BIT
Content-Language: en-US, bg
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20260603062043.3911278-1-edumazet@google.com>
 <20260603062043.3911278-5-edumazet@google.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260603062043.3911278-5-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294660-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,vger.kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,blackwall.org:mid,blackwall.org:dkim,blackwall.org:from_mime,blackwall.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1589B63558C

On 03/06/2026 09:20, Eric Dumazet wrote:
> Use set_bit() and test_bit() lockless functions.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/bridge/br_if.c     | 2 +-
>   net/bridge/br_stp_if.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
> index 3169fab686a534cf2a6458ff228eee2b6fc7e7e4..0bd5cf925fa321b785e3578d6e99d8d7003fa89f 100644
> --- a/net/bridge/br_if.c
> +++ b/net/bridge/br_if.c
> @@ -75,7 +75,7 @@ void br_port_carrier_check(struct net_bridge_port *p, bool *notified)
>   	struct net_device *dev = p->dev;
>   	struct net_bridge *br = p->br;
>   
> -	if (!(p->flags & BR_ADMIN_COST) &&
> +	if (!test_bit(BR_ADMIN_COST_BIT, &p->flags) &&
>   	    netif_running(dev) && netif_oper_up(dev))
>   		p->path_cost = port_cost(dev);
>   
> diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
> index 28c1d3f7e22f6e0a0edd8b3b3f501ea7acc31394..b29dc97b9ad8a5b5c56517d34fe426abd00e2ad6 100644
> --- a/net/bridge/br_stp_if.c
> +++ b/net/bridge/br_stp_if.c
> @@ -340,7 +340,7 @@ int br_stp_set_path_cost(struct net_bridge_port *p, unsigned long path_cost)
>   	    path_cost > BR_MAX_PATH_COST)
>   		return -ERANGE;
>   
> -	p->flags |= BR_ADMIN_COST;
> +	set_bit(BR_ADMIN_COST_BIT, &p->flags);
>   	p->path_cost = path_cost;
>   	br_configuration_update(p->br);
>   	br_port_state_selection(p->br);

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


