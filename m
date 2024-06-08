Return-Path: <netdev+bounces-102006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC27901147
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 12:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23A91282EF7
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 10:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5270C61FF6;
	Sat,  8 Jun 2024 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="xztZQq8w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76474482D3
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 10:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717843155; cv=none; b=UNsndR+GVVB8ZHjymTe0eNjAE0p4/4d9J2mQ0M5CDegIBWEkADdZbPRrvm3dKEfflRqN2VxlS1j5hGGL9yVsOB6cwRQDQlx3NhezXkHsWTxkMsZDaeJusbN8NjlNS8CcqBj8HKNXFFV54LEbUk/EoFf5OLh0p1IbbM5Ry/rIL64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717843155; c=relaxed/simple;
	bh=HgKMxrx7Vhfb7v6pwh6CotIQaz+hhVrdrCfu1DMMoxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HBqauYKyQRI6jnEqphRGOFeyAIrPuicCVInArwN7u5L3URYf9GBPfCZeK5TOlb73rMVfKhM+rvGcPcrdM9nYtiFyUq0c1kvqRuQIKsualK/L/yfqB4almMg3NB5f4Miv0mwvo184szwBfilFePKorAvmHpeFrrK/4aB3+2+mX3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=xztZQq8w; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6ef8e62935so95668066b.3
        for <netdev@vger.kernel.org>; Sat, 08 Jun 2024 03:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1717843152; x=1718447952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uNTt+twmqUz+x1X4zI5nblU92yoejGy84NJrk4xU8dc=;
        b=xztZQq8w/a/9x5Mj4fwX3SwyTp8j8PMnMiE9GggM9TtEa/dzCpqlO9KObBeMFu/0Ve
         D1Bx/La5Wdg1ss6wwoW+SrTiwHA1zJJVSWLAHd43c3QritQFer88aQk78TMZr/JnWd9a
         ajv4h69isT0S0ToO+S6Ewz9VrrZXl00USIB9GTViMHee+l53dZzGzL/In/4+8mM9wzYq
         nMayZkjIKzPgSKGbe2SpNFW45v12xaTjcv6kVkd2BhcUWsLenMujsTXkLYk5IjRfy4hH
         xucVpGVRN9Di/sZl0TQHM4Dum3HG1MZ9BalM2LtSaQzmTcoUrudZkw40fGliV089VCeW
         VY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717843152; x=1718447952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uNTt+twmqUz+x1X4zI5nblU92yoejGy84NJrk4xU8dc=;
        b=V/qpzlLvtbZfum4VUmKdJHmjW+iLnOZGGDCXh6peMx7pPXS3akdRxuPyoGDYG0ZXH1
         J1uTyoKI7bxgFADlnlcPihlBhrZsDBxr2dr/IK3qJlqzkg3VcCwWv/xWM30WfwNgEWrR
         MrFdqkh4Ee4gXLMftpsgFahsND5pi6jud7YgJu/u3ZnedMnK7yWjlASNtybD19wi8qTc
         QDQpeDURIXuC8TIMPPM/bKJfA+aX4SfJoTiqakgFJtAvNSjoKSdmXV72Ufzh+y0vymh0
         QG7VpPYevMIyYgZR0kGKQUFMXCQZX3CuHuE26XW3SyyflXlTjmDwx8FfV7tBB/iwbcvC
         gzPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQRaVvAUspNhAhtPIxItQ+Cov9xCPAXFoe/f+IquOMvVwkcIG7W11+f85xBAU/hv39+guiQB0KzsF2KG3Fypn4e1sqjfwV
X-Gm-Message-State: AOJu0YylooN0NeDc2NWR8j0cf/OXRtFY0xZZiJJgJrEAtgm1RdxW1Jyo
	BNEcGA5D79Vobu3Iggkpct7EJ7bZCbYwrCjZ6iTcsMCzt9CvJh6NbK0K0TpB6KE=
X-Google-Smtp-Source: AGHT+IFMBKohX2q2XE0vrhe/K97lOPMAJulGUak9+pmMHod9V/B0Z2DR1sB8s0ogEnxqLIzNvRvDiQ==
X-Received: by 2002:a17:906:a850:b0:a68:cbc8:178e with SMTP id a640c23a62f3a-a6cd70ecd8amr402561566b.33.1717843151692;
        Sat, 08 Jun 2024 03:39:11 -0700 (PDT)
Received: from [192.168.1.128] ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f0e858d7fsm23639266b.127.2024.06.08.03.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Jun 2024 03:39:11 -0700 (PDT)
Message-ID: <ab507096-3757-431c-b040-1353e762f9bd@blackwall.org>
Date: Sat, 8 Jun 2024 13:39:09 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/5] Allow configuration of multipath hash
 seed
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
 mlxsw@nvidia.com
References: <20240607151357.421181-1-petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240607151357.421181-1-petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/7/24 18:13, Petr Machata wrote:
> Let me just quote the commit message of patch #2 here to inform the
> motivation and some of the implementation:
> 
>     When calculating hashes for the purpose of multipath forwarding,
>     both IPv4 and IPv6 code currently fall back on
>     flow_hash_from_keys(). That uses a randomly-generated seed. That's a
>     fine choice by default, but unfortunately some deployments may need
>     a tighter control over the seed used.
> 
>     In this patchset, make the seed configurable by adding a new sysctl
>     key, net.ipv4.fib_multipath_hash_seed to control the seed. This seed
>     is used specifically for multipath forwarding and not for the other
>     concerns that flow_hash_from_keys() is used for, such as queue
>     selection. Expose the knob as sysctl because other such settings,
>     such as headers to hash, are also handled that way.
> 
>     Despite being placed in the net.ipv4 namespace, the multipath seed
>     sysctl is used for both IPv4 and IPv6, similarly to e.g. a number of
>     TCP variables. Like those, the multipath hash seed is a per-netns
>     variable.
> 
>     The seed used by flow_hash_from_keys() is a 128-bit quantity.
>     However it seems that usually the seed is a much more modest value.
>     32 bits seem typical (Cisco, Cumulus), some systems go even lower.
>     For that reason, and to decouple the user interface from
>     implementation details, go with a 32-bit quantity, which is then
>     quadruplicated to form the siphash key.
> 
> One example of use of this interface is avoiding hash polarization,
> where two ECMP routers, one behind the other, happen to make consistent
> hashing decisions, and as a result, part of the ECMP space of the latter
> router is never used. Another is a load balancer where several machines
> forward traffic to one of a number of leaves, and the forwarding
> decisions need to be made consistently. (This is a case of a desired
> hash polarization, mentioned e.g. in chapter 6.3 of [0].)
> 
> There has already been a proposal to include a hash seed control
> interface in the past[1].
> 
> - Patches #1-#2 contain the substance of the work
> - Patch #3 is an mlxsw offload
> - Patches #4 and #5 are a selftest
> 
> [0] https://www.usenix.org/system/files/conference/nsdi18/nsdi18-araujo.pdf
> [1] https://lore.kernel.org/netdev/YIlVpYMCn%2F8WfE1P@rnd/
> 
> v2:
> - Patch #2:
>     - Instead of precomputing the siphash key, construct it in place
>       of use thus obviating the need to use RCU.
>     - Instead of dispatching to the flow dissector for cases where
>       user seed is 0, maintain a separate random seed. Initialize it
>       early so that we can avoid a branch at the seed reader.
>     - In documentation, s/only valid/only present/ (when
>       CONFIG_IP_ROUTE_MULTIPATH). Also mention the algorithm is
>       unspecified and unstable in principle.
> - Patch #3:
>     - Update to match changes in patch #2.
> - Patch #4:
>     - New patch.
> - Patch #5:
>     - Do not set seed on test init and run the stability tests first to catch
>       the cases of a missed pernet seed init.
> 
> Petr Machata (5):
>   net: ipv4,ipv6: Pass multipath hash computation through a helper
>   net: ipv4: Add a sysctl to set multipath hash seed
>   mlxsw: spectrum_router: Apply user-defined multipath hash seed
>   selftests: forwarding: lib: Split sysctl_save() out of sysctl_set()
>   selftests: forwarding: router_mpath_hash: Add a new selftest
> 
>  Documentation/networking/ip-sysctl.rst        |  14 +
>  .../ethernet/mellanox/mlxsw/spectrum_router.c |   6 +-
>  include/net/flow_dissector.h                  |   2 +
>  include/net/ip_fib.h                          |  28 ++
>  include/net/netns/ipv4.h                      |   8 +
>  net/core/flow_dissector.c                     |   7 +
>  net/ipv4/route.c                              |  12 +-
>  net/ipv4/sysctl_net_ipv4.c                    |  66 ++++
>  net/ipv6/route.c                              |  12 +-
>  .../testing/selftests/net/forwarding/Makefile |   1 +
>  tools/testing/selftests/net/forwarding/lib.sh |   9 +-
>  .../net/forwarding/router_mpath_seed.sh       | 333 ++++++++++++++++++
>  12 files changed, 484 insertions(+), 14 deletions(-)
>  create mode 100755 tools/testing/selftests/net/forwarding/router_mpath_seed.sh
> 

Looks good to me, thank you!
For the set,
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>

