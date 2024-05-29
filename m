Return-Path: <netdev+bounces-99181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 842508D3F39
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 21:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1713C28785C
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 19:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9511C233F;
	Wed, 29 May 2024 19:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="0huo6l84"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E774815B139
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 19:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717012654; cv=none; b=o0V6FfOqLYaLO5t6VWlLEKr1JDurixKxhyjf7PQxwN/bA+NROfBpQ3UgNr3YMdDYUug4iTXJuVG7P9jI4ME1BQG5aJkd3+vp5s+ixEeYF4FTu7Lrvx/xzk0F+c/DlDgP+4DBm7PON34MkVsIxxdE2Brmt/kjIluxhfRFkCbas4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717012654; c=relaxed/simple;
	bh=CW5x7XNK7dO4KQCbbKiCHQKgBj5oLeDRM5E0i0NoM84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nOLIY2no+uB1RFhmf56NRR8KP1Gy03VbBosRjzdMkAAR2ysj3FtmPzLIVSl2+JLdEty12e1n5tUpgLqCM5CDIZ5JyWjtQi9ZUUiG5BtKXVZgKhE3RNPBs6yJvyH0Uy4zkYiVhlYGOy3HUH+18aBK33X+FJ3ycbFzpanbfA8d9lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=0huo6l84; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-35dc36b107fso7519f8f.1
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 12:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1717012651; x=1717617451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wh88+FpuPYJmnMYXZn04Jh5VDTevfNouAWPL6zNY57Y=;
        b=0huo6l84BQDNC4+NpdGioq2zyRgHxRRafMRn77cBR9QIH2MOIdRegy2j3B1XxexPGc
         mDPZHEykw0wl4bkJCnj6c/RZmm2xpAew4TU752IlueJr65Jq3J1cLnd+zScDhxvE0GcC
         i3ZvWvGZS9vcWD5al+vQdz/eyH7tZlccgnIMh3c22tW2KAvlfnmzdRR7wakm1LhvSAp1
         Fj2v0SL2ruQ1QKFgvnD5Ip9LNVfACLcX+9T6rQgzLrBfz5j/kWnFtTOVlOKaAO4XELvp
         +f63MnLubpaRUTyq2RVrd4mLrDURRSsi3C7bvMu8SKF7mVjxicRBFuuhRuXAS/w48qls
         7dQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717012651; x=1717617451;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wh88+FpuPYJmnMYXZn04Jh5VDTevfNouAWPL6zNY57Y=;
        b=jGD93ts2TxnmgcdAIqKMEylJzCCCP5ZoQD7hlH7f3A18w6J0XIf4u8BvVLhl7cfTSA
         JwStCUyPE7unWS3qlPrAQTi+ZfDVmsXB6EjN1njzVF4AL8nQ+UZbagFVM0zlDLmX9C/O
         zIzzB7Wx4fkXl7cyQKN/TIVbujWMiqkis0LvYsQ65FjCmMcwPSPL6QMwfSF74Jtu2+1H
         RieaN/ujishnSN1VOwnrQeWhqHKLwLW9Z0chZ8qAetDDGm4236dmqzxAM0dXBs1RsVcE
         Qf4CzgniA/0Omxlw/2b+mLZRmOK99lLep/seRG+3acFlo4w6luJI74XTxpQpHV74v/x9
         GgmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvdaC6mYNt3PhYT3HCtJmH3/QHb19D9lElTVMwXuyDvsniQ+doYayF4zIzniMvlk6yZ0JTUGcZ2lPJiuSgKiW1nGo12bXw
X-Gm-Message-State: AOJu0Yy4M2hhBcSjfBWlX8MRyGLgbLWilDWUG3F/8TpckoGsO+dAESVT
	ErP0L6glXQ2BxSSYHSEFCrPz2WGmuNZBTciQ+hvb3tPuZrxFY0c74sNvMuhoIEU=
X-Google-Smtp-Source: AGHT+IF6/VQk5D12CA33BW4Xypdtvi/c3ibML4wOHhpTCxm4Oy06wCEwrLwDwgyFkuTHBHfFKqxbIQ==
X-Received: by 2002:a05:6000:c5:b0:358:380:f44c with SMTP id ffacd0b85a97d-35dc0087caemr115690f8f.5.1717012650947;
        Wed, 29 May 2024 12:57:30 -0700 (PDT)
Received: from [192.168.0.105] (bras-109-160-25-143.comnet.bg. [109.160.25.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dbdad9a0bsm604822f8f.40.2024.05.29.12.57.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 12:57:30 -0700 (PDT)
Message-ID: <878d1248-a710-4b02-b9c7-70937328c939@blackwall.org>
Date: Wed, 29 May 2024 22:57:29 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] Allow configuration of multipath hash seed
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>
References: <20240529111844.13330-1-petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240529111844.13330-1-petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/29/24 14:18, Petr Machata wrote:
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
>     The new sysctl is added with permissions 0600 so that the hash is
>     only readable and writable by root.
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
> interface in the past[1]. This patchset uses broadly the same ideas, but
> limits the externally visible seed size to 32 bits.
> 
> - Patches #1-#2 contain the substance of the work
> - Patch #3 is a mlxsw offload
> - Patch #4 is a selftest
> 
> [0] https://www.usenix.org/system/files/conference/nsdi18/nsdi18-araujo.pdf
> [1] https://lore.kernel.org/netdev/YIlVpYMCn%2F8WfE1P@rnd/
> 
> Petr Machata (4):
>   net: ipv4,ipv6: Pass multipath hash computation through a helper
>   net: ipv4: Add a sysctl to set multipath hash seed
>   mlxsw: spectrum_router: Apply user-defined multipath hash seed
>   selftests: forwarding: router_mpath_hash: Add a new selftest
> 
>  Documentation/networking/ip-sysctl.rst        |  10 +
>  .../ethernet/mellanox/mlxsw/spectrum_router.c |  14 +-
>  include/net/flow_dissector.h                  |   2 +
>  include/net/ip_fib.h                          |  24 ++
>  include/net/netns/ipv4.h                      |  10 +
>  net/core/flow_dissector.c                     |   7 +
>  net/ipv4/route.c                              |  12 +-
>  net/ipv4/sysctl_net_ipv4.c                    |  82 +++++
>  net/ipv6/route.c                              |  12 +-
>  .../testing/selftests/net/forwarding/Makefile |   1 +
>  .../net/forwarding/router_mpath_seed.sh       | 322 ++++++++++++++++++
>  11 files changed, 482 insertions(+), 14 deletions(-)
>  create mode 100755 tools/testing/selftests/net/forwarding/router_mpath_seed.sh
> 

Hi,
I think that using memory management for such simple task is an
overkill. Would it be simpler to define 2 x 4 byte seed variables
in netns_ipv4 (e.g. user_seed, mp_seed). One is set only by the
user through the sysctl, which would also set mp_seed. Then you
can use mp_seed in the fast-path to construct that siphash key.
If the user_seed is set to 0 then you reset to some static init
hash value that is generated on init_net's creation. The idea
is to avoid leaking that initial seed, to have the same seed
for all netns (known behaviour), be able to recognize when a
seed was set and if the user sets a seed then overwrite it for
that ns, but to be able to reset it as well.
Since 32 bits are enough I don't see why we should be using
the flow hash seed, note that init_net's initialization already
uses get_random_bytes() for hashes. This seems like a simpler
scheme that doesn't require memory management for a 32 bit seed.
Also it has the benefit that it will remove the test when generating
a hash because in the initial/non-user-set case we just have the
initial seed in mp_seed which is used to generate the siphash key,
i.e. we always use that internal seed for the hash, regardless if
it was set by the user or it's the initial seed.

That's just one suggestion, if you decide to use more memory you
can keep the whole key in netns_ipv4 instead, the point is I don't
think we need memory management for this value.

Cheers,
 Nik


