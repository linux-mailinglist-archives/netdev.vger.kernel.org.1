Return-Path: <netdev+bounces-143808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D159C4448
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 18:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0968B28A452
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 17:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6771A76D5;
	Mon, 11 Nov 2024 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOvniEwq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A1314D283;
	Mon, 11 Nov 2024 17:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731347893; cv=none; b=ecrlAXfsmKqnSgakFSw9TjpVNlcvv/FvSgMi8ZOG009Y3n421U2NCZfN4Q5RSvdu5nyIggzb+HNjpiRk0Fj8ARZ9FD2T7cAwNrvHZutdncz7GMBfUt12A2Nl/2uiUJTJCKm6s7yLBMl5BG8OAPrE+2ryu5/y/NvTwPCEFagsxpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731347893; c=relaxed/simple;
	bh=pfv1aUuAyB1V7kpVXxrt4xJT5uoHOXAUmdiy1dXw850=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=SO5zr0/PqWd/6LXwyR6RJk21PS83kbcc6u1+PiRbI7MTfN0F1lyqeP8OPk2THcUDIo2aKZ5htaYCCheAddk5GkmZPXvrUllpBV1nvbfiW5X7YIlw+U31nTRLk48cJKPb/b+2r2VXvfI+ZTnkZwr+30viVhd+1mdtl6n4IUcLAcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOvniEwq; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b13ff3141aso355919385a.1;
        Mon, 11 Nov 2024 09:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731347891; x=1731952691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWd+AjjN8r+ZEiXPSSHyKtvGpI4+DyWu+bjKTvlcvP4=;
        b=FOvniEwqPMfZRF1XCELqVB3uRvkdGLJB78Ez3kn+ujUGm6XnMKlRWkxT24pyqXiAn4
         wEjHIIKQiNBi/wsY+ivWn0O8S8PlbedKG5Et5cCqxVx8aFrYyTvlSqZMUgmEgUHNmr29
         o/Zmy/BnhvlZSDUQDp1hHwqYwthCxJHnwDKDypm+qCgjTCocasbAtAnnHZhGI3gFenns
         OEKLh6Xfwr+1DuGJVK/T8WamqQQ1OKUjr4b7zs/8MNEyez4ypqHiYP/+4S7cyk6kxN4t
         Rg4oiO+yK5JyUBt+pVEEvjMRZmU2G/roUDrbrHpRzZJpLsfMbcZxATu/G/K+adqWQON6
         Wxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731347891; x=1731952691;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eWd+AjjN8r+ZEiXPSSHyKtvGpI4+DyWu+bjKTvlcvP4=;
        b=E2IGkUin8LYqcuUz4eTFCQy8W/eKZX/Wtw/rA1yrgUWawDnH0/H6KeaZJ1BqJn0Z+V
         C9sWmx2tyuZzee/fRwRRuf5JJ85B4fty9vzbQWpPxoMqZ8zlKoc6TzQbuVs2I+25szwV
         nuC/tDUSPHPcP6jLjGwEsoLGgrQ/u5RPpmKYtuK6dj8jrLfhCYbo4ghZluZzQWV4cSyT
         +zikU0apXYeQXv9Bx1jZ4+Dm2Twp3em1L/Rtc9EY/AAg5P1MKTBGFEhaRCsAGpi4U25O
         m+CahTCpOjlZGEjlE7/lKSkOBNpP4o6cT4vR2bNC4F4YmtZ6AwvZHLd0Z+8wzh/8K8b5
         y/jw==
X-Forwarded-Encrypted: i=1; AJvYcCVcG2lbz5OXAIgpA/AGatfVQ2B+syiU9baflQC1JaUSxMzItV1Tnk3OVpNj6nWwJYQBJo+DIZ6G@vger.kernel.org, AJvYcCW7mTFQHtJEoP5idd9gdQz77b47Y8km/qrRpUSCfqZNCjg8t/2umbBTCFkkVjD1NSt4hKGegg5G42ZOCb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzceo7OtrJk1NW4bopfUr/IbsGD4vID675JdmOcM+65+fbuWpOj
	5RvLlRK9foc6iKuE9n0/6x43Ic7KEWbJh+k2/UazP3dn31avG4RY
X-Google-Smtp-Source: AGHT+IGcXV3Ka0MzggMGHC05+2UrOkriOvJ7qmRUm3WqX7WvMO37jBaWWh9wPAZVNM7rbE3eHdJRxg==
X-Received: by 2002:a05:620a:2985:b0:7b1:4948:109f with SMTP id af79cd13be357-7b331e75540mr1839857685a.57.1731347890969;
        Mon, 11 Nov 2024 09:58:10 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac678c2sm515974085a.61.2024.11.11.09.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 09:58:10 -0800 (PST)
Date: Mon, 11 Nov 2024 12:58:09 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Philo Lu <lulie@linux.alibaba.com>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 horms@kernel.org, 
 antony.antony@secunet.com, 
 steffen.klassert@secunet.com, 
 linux-kernel@vger.kernel.org, 
 dust.li@linux.alibaba.com, 
 jakub@cloudflare.com, 
 fred.cc@alibaba-inc.com, 
 yubing.qiuyubing@alibaba-inc.com
Message-ID: <673245b18be9c_b4a05294bc@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241108054836.123484-1-lulie@linux.alibaba.com>
References: <20241108054836.123484-1-lulie@linux.alibaba.com>
Subject: Re: [PATCH v8 net-next 0/4] udp: Add 4-tuple hash for connected
 sockets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Philo Lu wrote:
> This patchset introduces 4-tuple hash for connected udp sockets, to make
> connected udp lookup faster.
> 
> Stress test results (with 1 cpu fully used) are shown below, in pps:
> (1) _un-connected_ socket as server
>     [a] w/o hash4: 1,825176
>     [b] w/  hash4: 1,831750 (+0.36%)
> 
> (2) 500 _connected_ sockets as server
>     [c] w/o hash4:   290860 (only 16% of [a])
>     [d] w/  hash4: 1,889658 (+3.1% compared with [b])
> With hash4, compute_score is skipped when lookup, so [d] is slightly
> better than [b].
> 
> Patch1: Add a new counter for hslot2 named hash4_cnt, to avoid cache line
>         miss when lookup.
> Patch2: Add hslot/hlist_nulls for 4-tuple hash.
> Patch3 and 4: Implement 4-tuple hash for ipv4 and ipv6.
> 
> The detailed motivation is described in Patch 3.
> 
> The 4-tuple hash increases the size of udp_sock and udp_hslot. Thus add it
> with CONFIG_BASE_SMALL, i.e., it's a no op with CONFIG_BASE_SMALL.
> 
> changelogs:
> v7 -> v8:
> - add EXPORT_SYMBOL for ipv6.ko build
> 
> v6 -> v7 (Kuniyuki Iwashima):
> - export udp_ehashfn to be used by udpv6 rehash
> 
> v5 -> v6 (Paolo Abeni):
> - move udp_table_hash4_init from patch2 to patch1
> - use hlist_nulls for lookup-rehash race
> - add test results in commit log
> - add more comment, e.g., for rehash4 used in hash4
> - add ipv6 support (Patch4), and refactor some functions for better
>   sharing, without functionality change
> 
> v4 -> v5 (Paolo Abeni):
> - add CONFIG_BASE_SMALL with which udp hash4 does nothing
> 
> v3 -> v4 (Willem de Bruijn):
> - fix mistakes in udp_pernet_table_alloc()
> 
> RFCv2 -> v3 (Gur Stavi):
> - minor fix in udp_hashslot2() and udp_table_init()
> - add rcu sync in rehash4()
> 
> RFCv1 -> RFCv2:
> - add a new struct for hslot2
> - remove the sockopt UDP_HASH4 because it has little side effect for
>   unconnected sockets
> - add rehash in connect()
> - re-organize the patch into 3 smaller ones
> - other minor fix
> 
> v7:
> https://lore.kernel.org/all/20241105121225.12513-1-lulie@linux.alibaba.com/
> v6:
> https://lore.kernel.org/all/20241031124550.20227-1-lulie@linux.alibaba.com/
> v5:
> https://lore.kernel.org/all/20241018114535.35712-1-lulie@linux.alibaba.com/
> v4:
> https://lore.kernel.org/all/20241012012918.70888-1-lulie@linux.alibaba.com/
> v3:
> https://lore.kernel.org/all/20241010090351.79698-1-lulie@linux.alibaba.com/
> RFCv2:
> https://lore.kernel.org/all/20240924110414.52618-1-lulie@linux.alibaba.com/
> RFCv1:
> https://lore.kernel.org/all/20240913100941.8565-1-lulie@linux.alibaba.com/
> 
> Philo Lu (4):
>   net/udp: Add a new struct for hash2 slot
>   net/udp: Add 4-tuple hash list basis
>   ipv4/udp: Add 4-tuple hash for connected socket
>   ipv6/udp: Add 4-tuple hash for connected socket
> 
>  include/linux/udp.h |  11 ++
>  include/net/udp.h   | 137 +++++++++++++++++++++++--
>  net/ipv4/udp.c      | 245 +++++++++++++++++++++++++++++++++++++++-----
>  net/ipv6/udp.c      | 117 +++++++++++++++++++--
>  4 files changed, 468 insertions(+), 42 deletions(-)

Acked-by: Willem de Bruijn <willemb@google.com>

My expertise in routing is limited, fair warning.
But I see no significant remaining issues.


