Return-Path: <netdev+bounces-272734-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6WPcJ0l4x2n2XwUAu9opvQ
	(envelope-from <netdev+bounces-272734-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 07:42:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F3034D843
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 07:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7094E302B39C
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 06:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C804E2DE70D;
	Sat, 28 Mar 2026 06:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="OoEJ8pZ5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B726221275
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 06:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774680134; cv=none; b=PxyHAY6wlBCcH2yv5BqRLdXMbn4yaHzJLIY6qeL7ViDIt3zoMRNv32pnQY/sCIncg9CD+ha+aAUuNs3zhKWtQbznpUkHF5y8NAvIWAXeJRL0DMuofar86VX2Y5ExtKIpE2csea7RvVnM4NvUC8Q+9Z5gODW46JnRobwQbX/w0Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774680134; c=relaxed/simple;
	bh=izjvOThxFBEttXfkR3OTXp8Qh8HrtNzcIZFDoILbPwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bbpByLNgQNZOzyOSTTHP+xsSVXD3ZKraYpAE2H7RFgM+kqlrkRbVQ+8ZobHTDmMMo2mC+oAkAEPPak04RMTBdt3/ecLYGTHHrUtKy4Mku+aAbC+iesDjPoLAZXom7VbxVp/TsX9oQP/QfbDw6NlKRkCxeKuCSXUceTZVKynIo1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=OoEJ8pZ5; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso23828415e9.1
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 23:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1774680132; x=1775284932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vZMboRssjkv4HFLquIG1BzMqG8ARhYN9v0cHdpQlAPA=;
        b=OoEJ8pZ5aOMtZD/ZG2IlV4fTaUf57TpexwOGW5MYvPiIek/RSwcQouWgSunUx4uRfN
         rYF+mEPcskIvTddPXyg3HZjdepIYquHgyCwKPIInpmCMa4exn5EUyJ8vEr45ZwpSteGU
         D7FFqVcyn8XLQtXsYLFI9mR39wByifna6W2H2BVCo4pm7HjdLInyIzBhx5TJoZVfk15m
         AyQJs5WeUMFi48aHmo8mrdgJAU3kzN9rupxpLJA3T193Niu8Lz4ZH9vx4AWH4Tjbsy9p
         /XdJYBEnB/OmVgkPDiO2iE86UbkaIYDkBuul2McunX6BTDL899sgoqL/lWArzdgNZRvb
         y4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774680132; x=1775284932;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vZMboRssjkv4HFLquIG1BzMqG8ARhYN9v0cHdpQlAPA=;
        b=jhBXiBr19eqTjtpOAFCaBrmmLkljBqjmOQG48eL4imTfzxzk8kGIHMkgc4t2NS/rlL
         GTcVbOolrK+7eVy15SxQFckQgxkYWzeUsIuwfelwkzgMU2BitgDSbQyiXuqWQqGi1xc4
         dkCr911xp7LQlsCY50xnrOfzIcJiYYuFFvvWD0t5hMFuSKrDmswyRXbb6kKIZx7Y53W+
         /CxpSge3rVt/4gq8zgSv0zcLxkz4LD7cbpezi/foVGveSjxbnX8ExWaHe8wzvgBB5UJc
         Q1iobdO4nFxgwpnY2VtLGTJSYBdQaMpRmWaYXrxDvLByaXoJybnochtNgVFC0gYkQmjD
         TLxg==
X-Forwarded-Encrypted: i=1; AJvYcCXHUkkXML6xCpdJ1HCW/JwH94pyWAnV5O7woTuebdgrRC4Ujm15dizJFl1kKx0XoaH5G5GoYdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCA1uaPUISXBuYmcSiMV7bvtDdAhsAtaX/OeAyiaTtuduEzKiz
	8fZb3sJxO1593i9nZa8TWfG/XDvCjfHn0V6wKXBUs/l/c1HzAEU1lUQKlAAPfIpMMas=
X-Gm-Gg: ATEYQzyX2v6Cxp8c0MoxaCqiSEJ78rCfZ9eYL2WANUV60n/FWTqgzURjWWA6o0VKG+l
	15pN5rfMLvys39UGBA6nRUT3F+17oFiWc32gRyAgIbJyUSlg1TUr4yTIQzmFZC0aV3dLk+o8Dgx
	AXaZxne0KC1zri8AnUmCVJPQvKdCOB+ExO0e0QdD3cdBtNtRobi2dUjXjyMcneFHhQsTo+9u6Zi
	xZvfvGTAWXESMCsyLgyoKcq3dRWVVxjv2c3Il8DvTOY7RX2cugW+JudWk9FrC+Y2GFru+YYnRzZ
	LnIo0MYDIDtaQgzSdoXFqt53nHimtTBOFzH1UV3+HI0Da2OofmPAGtf4VkPlFPFX4g8W9rbBz5g
	XCdOrd99NQhzJDu8L7hLpSGFZfpUveyGydui6gubovDBEybuA0MpmqQq84WCxXwbTpOh9KE8rQP
	gHOgJfJ/5JyMGO7thLiBsBvuGzJZRwOIIsxVzh1caxPyVD5vxnq2PUmsuA4UUrZN+c
X-Received: by 2002:a05:600c:4f91:b0:486:f634:ef1 with SMTP id 5b1f17b1804b1-48727eda549mr85154515e9.17.1774680131791;
        Fri, 27 Mar 2026 23:42:11 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487270f1943sm38204245e9.7.2026.03.27.23.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 23:42:11 -0700 (PDT)
Message-ID: <7ace5b20-6982-45ea-a137-c0dee5d47c8b@blackwall.org>
Date: Sat, 28 Mar 2026 08:42:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 02/14] net: Implement
 netdev_nl_queue_create_doit
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260327121049.334562-1-daniel@iogearbox.net>
 <20260327121049.334562-3-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260327121049.334562-3-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-272734-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,davemloft.net,redhat.com,google.com,fomichev.me,gmail.com,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[blackwall.org:dkim,blackwall.org:email,blackwall.org:mid,davidwei.uk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E4F3034D843
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 27/03/2026 14:10, Daniel Borkmann wrote:
> Implement netdev_nl_queue_create_doit which creates a new rx queue in a
> virtual netdev and then leases it to a rx queue in a physical netdev.
> 
> Example with ynl client:
> 
>    # ynl --family netdev --output-json --do queue-create \
>          --json '{"ifindex": 8, "type": "rx", "lease": {"ifindex": 4, "queue": {"type": "rx", "id": 15}}}'
>    {'id': 1}
> 
> Note that the netdevice locking order is always from the virtual to
> the physical device.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>   Documentation/networking/netdevices.rst |   6 +
>   include/linux/netdevice.h               |   9 +-
>   include/net/netdev_queues.h             |  19 ++-
>   include/net/netdev_rx_queue.h           |  15 ++-
>   include/net/xdp_sock_drv.h              |   2 +-
>   net/core/dev.c                          |   8 ++
>   net/core/dev.h                          |   5 +
>   net/core/netdev-genl.c                  | 164 +++++++++++++++++++++++-
>   net/core/netdev_queues.c                |  62 +++++++++
>   net/core/netdev_rx_queue.c              |  46 ++++++-
>   net/xdp/xsk.c                           |   2 +-
>   11 files changed, 325 insertions(+), 13 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


