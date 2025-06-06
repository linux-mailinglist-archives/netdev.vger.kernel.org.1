Return-Path: <netdev+bounces-195495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DABAD0826
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 20:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 183B57A3F6D
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 18:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129C01DF755;
	Fri,  6 Jun 2025 18:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LlnB/C8W"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5FC323D
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 18:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749235083; cv=none; b=FMTw0ujL347DMLQzHIkhprfJ22bmpZRlJwCR7J1DlhyJDNGEw6sNxYcCJ4vC96sZH5VWBNXOIdu38LS0pXU6mzxFmftx2ANjZbnTsIUa/zD0hCp1O2J4zm1el4/Vun4ha2foW4ZVuq834WNx7MwBMoQ9/1qLZWpr08nFTQ3vD38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749235083; c=relaxed/simple;
	bh=imD6ZSayNfSVwZx/blZuazEzy1ybdpsgUf98M0iHw7s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AnpOR8O0cpAqd3N2e4gyiem0FgxgMaUjFVjMmuaKg+Ez0ZU6ILbiDteCq1zcIsg8MWHyuSqZif3K0qwLBwU9yXC/fjZ/joLH9RzW3DCvrkpKPQVRh1Fl1mBVfMPd+yeX7a+huQMIFp4qI8kvGqkbXXphr56/aWMhe9OhA3C3msg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LlnB/C8W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749235080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QYk2NEAtOlpT7LhP5jummxbLR5KyLp36GZzjyWqqbPQ=;
	b=LlnB/C8WC5cjUutTUZkvxXGc3Jui5gvZoTEwHhWRBcrBvgm3P2px8GUNkhHehcumoZVmDJ
	17cKk9560OMZ8HuB0sbA5e/ZhVAZlpIYkwd5dn2Vqw7sB2g6kbqjKyCmYEssps/RfhVQi5
	O5uHz9L5CWdAUxOZ0tqLoBCu8FoLhDY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-u61ZBuz7Onmny-S62fG7QQ-1; Fri, 06 Jun 2025 14:37:59 -0400
X-MC-Unique: u61ZBuz7Onmny-S62fG7QQ-1
X-Mimecast-MFC-AGG-ID: u61ZBuz7Onmny-S62fG7QQ_1749235078
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ade0abc1ce0so173281766b.3
        for <netdev@vger.kernel.org>; Fri, 06 Jun 2025 11:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749235078; x=1749839878;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYk2NEAtOlpT7LhP5jummxbLR5KyLp36GZzjyWqqbPQ=;
        b=INFZJAydPIBJXM3eXssmCI07hpzNAIsRrPpf67oLcUKjGE+9M2FNngvd6Khtr2l47L
         48CGEv4gpPgkc6jNEijbCzoUZOgK65YnJOZg8Vkubxq37D8dRk8GTicRDg8ScTk65QEu
         ecCquk6lRNVXm1WgaLrjKS8j4hjDUth+0MLPXo4Cj8JlRDJ579cafXQVwBTRNPhk6sFw
         1U7DnG8/t2MSFsDdHiMh3NSA+mk0Bz0eMEpcstv2CT6l29Gmi9u4NZ/CLjZURSCaj58Z
         9rXpJxQHuyBS/fsLDNyr1MOlJAJI+UACIxJsISiASXciMqBUz4Wv5CyVxdJY+0UwLL7c
         Aiyw==
X-Forwarded-Encrypted: i=1; AJvYcCUhiySGXf6SLj9SKk2vjhSwdhyjMwQXK2A201BU3lxXt/gOSQTK3wKN15bWg5sxPmcInIBxBZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YymiV8s1ANDzqkWmlXzPiP+fIyDgdCQoBAhVGjOgA0PF/JpRXSC
	WvqVPqDR95KS6FmPGD/jNNwWg9sUnjmP0ULqmTSCKkkGfvTXIU8vhbthYJIFixOdf4zRGtO44dm
	uQWJ9VbQHl77iRZva/+jAtqyIiqsbuDK8gFDcvKF9dp7kQTHFAuV1bsW3dQ==
X-Gm-Gg: ASbGncslDEvIaOBOb1XlUX0KLQko7FvQjnbcreCkWNc/oEl+d0SyKUHdH/wgwz3Gv0W
	QZZXN6OTtWUbAGoH0X/jchCIxyXJvIzRCpUwFKc1yFFtIaMyNX2hjFjBq0o32HfxIQmZdnSymKk
	Tro0jCeGm3S3XO5pIQw4AKtdX5wDk80FWMdb1WKCIIe+HCiWzsv3dIMMezelI/3tCiZEfOy4N6t
	3t80EXwmK/keV98eI71AWlCuu2NKqrgkANBWDyg7xP4HtuVifZoLjWgjBsiESwLhEzYa6JG68OU
	hO5TfVc2b3TrrJteG5QJJ49asTO3wamUOepk
X-Received: by 2002:a17:907:7ea4:b0:adb:300a:bcc0 with SMTP id a640c23a62f3a-ade1a9c8279mr401296766b.46.1749235077751;
        Fri, 06 Jun 2025 11:37:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKB8cMvREIGn4LQz6CGGdktnmGeAkGQxxQfYplyC7dXFAz8mlvZwIq16WDNlbTccxvvDVZ2A==
X-Received: by 2002:a17:907:7ea4:b0:adb:300a:bcc0 with SMTP id a640c23a62f3a-ade1a9c8279mr401295066b.46.1749235077295;
        Fri, 06 Jun 2025 11:37:57 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc7d635sm157251666b.177.2025.06.06.11.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 11:37:56 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0B9FD1AA94E7; Fri, 06 Jun 2025 20:37:55 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, Eric Dumazet
 <edumazet@google.com>, Marcus Wichelmann
 <marcus.wichelmann@hetzner-cloud.de>
Subject: Re: [PATCH net] net_sched: sch_sfq: fix a potential crash on
 gso_skb handling
In-Reply-To: <20250606165127.3629486-1-edumazet@google.com>
References: <20250606165127.3629486-1-edumazet@google.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 06 Jun 2025 20:37:54 +0200
Message-ID: <87jz5ou35p.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> writes:

> SFQ has an assumption of always being able to queue at least one packet.
>
> However, after the blamed commit, sch->q.len can be inflated by packets
> in sch->gso_skb, and an enqueue() on an empty SFQ qdisc can be followed
> by an immediate drop.
>
> Fix sfq_drop() to properly clear q->tail in this situation.
>
> Tested:
>
> ip netns add lb
> ip link add dev to-lb type veth peer name in-lb netns lb
> ethtool -K to-lb tso off                 # force qdisc to requeue gso_skb
> ip netns exec lb ethtool -K in-lb gro on # enable NAPI
> ip link set dev to-lb up
> ip -netns lb link set dev in-lb up
> ip addr add dev to-lb 192.168.20.1/24
> ip -netns lb addr add dev in-lb 192.168.20.2/24
> tc qdisc replace dev to-lb root sfq limit 100
>
> ip netns exec lb netserver
>
> netperf -H 192.168.20.2 -l 100 &
> netperf -H 192.168.20.2 -l 100 &
> netperf -H 192.168.20.2 -l 100 &
> netperf -H 192.168.20.2 -l 100 &
>
> Fixes: a53851e2c321 ("net: sched: explicit locking in gso_cpu fallback")
> Reported-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
> Closes: https://lore.kernel.org/netdev/9da42688-bfaa-4364-8797-e9271f3bda=
ef@hetzner-cloud.de/
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Thanks for the quick fix!

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


