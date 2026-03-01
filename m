Return-Path: <netdev+bounces-262370-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yK4NKx++o2mPLAUAu9opvQ
	(envelope-from <netdev+bounces-262370-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 05:18:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E96371CE7F1
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 05:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0972300E251
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 04:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8522F4A18;
	Sun,  1 Mar 2026 04:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Mcga8lH1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2591C2264C7
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 04:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772338715; cv=none; b=BxYOJgNMwlnjEldgrCutozteE/smN1tq8HPsDkH6+gBN6Njze/S6sG5MdFRAS6VEMnvVxKqIz+T1HkcI3oNHu92yVath6CIE5MEtWMe2nML3wGoKSlPaU7r+QlTM4kYOgPG+81WUBeitkw4XYps4tsN+KwkzLN8Bm+h7Nqq2epo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772338715; c=relaxed/simple;
	bh=pEpt7nrCP8JCCmw5lmsAvzsIU9AYYaoSSM5V+qdD5RI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GAt2oU0OZ0wmup26ExzKJ7PA89xjBgDIjsVWiAc2NPvQ0UfiApAGIM91RTQBFkv4k2enzzHklUfehwd0/F3mP3flOzy+V73i9Nh1hZBAaz3e4eviFi0PHkLcDMpnKoDF9S0j3u2/r056FWFfpNFZXwM9t63ZiAUJWlok5qZwGtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Mcga8lH1; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-507373bffd9so31203441cf.2
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 20:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1772338713; x=1772943513; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iHrK+sAG20wP+KjRjeg7ewN87L8WXpcr7a47/op8qGw=;
        b=Mcga8lH1ZEdd6ynrGh4m2uwfrlJxGPvGVgzsMIuWHD6QtxPGRvOlpzBZyX5p4O8Alq
         RvfeQj2vmHtWEQdF4YWf/jl/GWw0lgpJJW72jGcTEhefZ3V9XHdoBqVRKZgvdPe+ForJ
         UnHSsm5arqeLLdDykdFpgQc91w+4Rzwkp4ur5GE2FXZaeDQguFZAmroA/sHgjtY3bCDF
         JdndxljqqcoMxrnId5V789lIOcOrTDfIj/eCscCA8fb48c6klc7FGWutR+fSb2lFalcB
         /4RjN5DeFIXnTN3btVOu9xEn6c/3pG+fVpAbuioJdt07HfIziUySM//jhOSiqimUICXp
         s1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772338713; x=1772943513;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iHrK+sAG20wP+KjRjeg7ewN87L8WXpcr7a47/op8qGw=;
        b=shzm039wSvb8lzRXMO38QK39oHiUE/OQLwMbzU7A1ZvoloLY4SbgMiQBxsVxgamMpg
         p6tJVOAvM8j+R5BlzwaAk7iYeeWumNhtzRHJ0bVNvyVMvREYkHzTX7ux/lcToYcVlRl9
         4VEpJoJbT9hiTqD6R9hiAYK/2sCr9FsNwFxd2SoDPXZZ+HMG9VGUJNaxFqWCyrfiYzvU
         3A7BudJjarLpWjjFu9byAFwj9HP4gUAte0ET1eKGVS2vf8FwwyS0GD66WPID3SsToy28
         WpqDFquEAqCKVowMHRedj448y6vvfKoqV/C3aGEhVUPrR3iX8MYIwx6+InHvs51xagEq
         L5mA==
X-Gm-Message-State: AOJu0YzvuVR1I89LoIB6luKPZTpLTq2aWVWKFjSl70OmYJY6uh/OHG1p
	CuHQpgBtT+o/6/imbBBhjVgP7TqAc+LVmkOTV0LgVwi24QSckkvzslkD07r9C2hB3kg=
X-Gm-Gg: ATEYQzxPcfKVhVoMNkzfYtDNNuoSbNAbvoF3L6V3jYHxSqPFwEKsTmHr2dhQcalVx/G
	+Sng7OwTGbTNJXFhywEqt6OjhC7ogA873nALBnObG52MxgHFX5Zi11nn5Fk1iExfppkUA8GIdaY
	y9aBv4vL/6VaAlOBcGVFkW4gHl6bQzmKc4QL2MCVY6kkfDk3hgUV//M+2LIS3dv6Q3hYiDy7ZEg
	uIZ94wybjfM/MVjPLOfXduTCUW4dps+IdHQrcOe3/NK1ZcdBqSl6gNLH4k/MGeEbEqXysl/lFL0
	ki8MRIyQW1nU7jkUqmiON/pEA8Nt6/2ct5fkMka1OEgoaqRgyCfx5tECFohpXiq7aVoFYbBQajB
	Ac8LoGsmijxMAUORptucFsTZA7RtBvDccMjb3In03yFoTMeCCC5Dc32fVqbZFqYaGAxLzGBsBmy
	xLAXXLTUAN94LEQN9FdPCe5vXj8ICXpVk6c3grgHBf/5Ol+jirACYr/q29WVAo/kbyJA==
X-Received: by 2002:a05:622a:11cf:b0:4ee:43e1:e591 with SMTP id d75a77b69052e-507529be42bmr102804831cf.58.1772338712856;
        Sat, 28 Feb 2026 20:18:32 -0800 (PST)
Received: from [192.168.86.87] ([136.27.45.11])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c71a23bdsm75605766d6.22.2026.02.28.20.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 20:18:32 -0800 (PST)
Message-ID: <eda2e2da-6f22-4c8e-9b63-837bc349599e@davidwei.uk>
Date: Sat, 28 Feb 2026 20:18:30 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next 3/9] selftests/net: Add env for container based
 tests
To: Bobby Eshleman <bobbyeshleman@gmail.com>, Wei Wang <weibunny@fb.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Daniel Zahka <daniel.zahka@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Daniel Borkmann <daniel@iogearbox.net>
References: <20260224002410.1553838-1-weibunny@fb.com>
 <20260224002410.1553838-4-weibunny@fb.com>
 <aZ3pl177Q6+uJCCN@devvm11784.nha0.facebook.com>
Content-Language: en-US
In-Reply-To: <aZ3pl177Q6+uJCCN@devvm11784.nha0.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[davidwei-uk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262370-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,iogearbox.net];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[davidwei.uk];
	FREEMAIL_TO(0.00)[gmail.com,fb.com];
	DKIM_TRACE(0.00)[davidwei-uk.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dw@davidwei.uk,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davidwei.uk:mid,davidwei.uk:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,davidwei-uk.20230601.gappssmtp.com:dkim,iogearbox.net:email]
X-Rspamd-Queue-Id: E96371CE7F1
X-Rspamd-Action: no action

On 2026-02-24 10:10, Bobby Eshleman wrote:
> On Mon, Feb 23, 2026 at 04:24:03PM -0800, Wei Wang wrote:
>> From: David Wei <dw@davidwei.uk>
>>
>> Add an env NetDrvContEnv for container based selftests. This automates
>> the setup of a netns, netkit pair with one inside the netns, and a BPF
>> program that forwards skbs from the NETIF host inside the container.
>>
>> Currently only netkit is used, but other virtual netdevs e.g. veth can
>> be used too.
>>
>> Expect netkit container datapath selftests to have a publicly routable
>> IP prefix to assign to netkit in a container, such that packets will
>> land on eth0. The BPF skb forward program will then forward such packets
>> from the host netns to the container netns.
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> ---
>>   .../testing/selftests/drivers/net/README.rst  |  19 ++
>>   .../drivers/net/hw/lib/py/__init__.py         |   7 +-
>>   .../selftests/drivers/net/lib/py/__init__.py  |   7 +-
>>   .../selftests/drivers/net/lib/py/env.py       | 163 ++++++++++++++++++
>>   4 files changed, 190 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
>> index eb838ae94844..39370a83f238 100644
>> --- a/tools/testing/selftests/drivers/net/README.rst
>> +++ b/tools/testing/selftests/drivers/net/README.rst
>> @@ -62,6 +62,25 @@ LOCAL_V4, LOCAL_V6, REMOTE_V4, REMOTE_V6
>>   
>>   Local and remote endpoint IP addresses.
>>   
>> +LOCAL_PREFIX_V4, LOCAL_PREFIX_V6
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Still not sure we want LOCAL_PREFIX_V4 here, since it is not supported?

Thanks, I'll remove LOCAL_PREFIX_V4.

> 
>> +
>> +Local IP prefix/subnet which can be used to allocate extra IP addresses (for
>> +network name spaces behind macvlan, veth, netkit devices). DUT must be
>> +reachable using these addresses from the endpoint.
>> +
>> +  +-------------+        +----------------------------+
>> +  | INIT NS     |        | TEST NS                    |
>> +  | +---------+ |        | +------------------------+ |
>> +  | | NETIF   | |  bpf   | | Netkit                 | |
>> +  | |         |-|--------|>| nk_guest               | |
>> +  | +---------+ |        | | {LOCAL_PREFIX_V6}::2:2 | |
>> +  | +---------+ |        | +------------------------+ |
>> +  | | Netkit  | |        +----------------------------+
>> +  | | nk_host | |
>> +  | +---------+ |
>> +  +-------------+
>> +
> 
> One thing I noticed when I tested this was the flow broke down when
> NETIF's address happened to match LOCAL_PREFIX_V6. I didn't fully reason
> through why this was the case, but maybe it's worth mentioning in the
> docs here?

If NETIF's address matches LOCAL_PREFIX_V6, the installed bpf prog is
going to forward _all_ packets to Netkit in the netns. That's likely why
it doesn't work.

I'll mention that NETIF must not match LOCAL_PREFIX_V6 in the kdocs and
the diagram, then assert that in NetDrvContEnv as well. Thanks.

> 
>>   REMOTE_TYPE
>>   ~~~~~~~~~~~
>>   
[...]
>> diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
>> index 41cc248ac848..857ae0f37516 100644
>> --- a/tools/testing/selftests/drivers/net/lib/py/env.py
>> +++ b/tools/testing/selftests/drivers/net/lib/py/env.py
[...]
>> @@ -289,3 +292,163 @@ class NetDrvEpEnv(NetDrvEnvBase):
>>                   data.get('stats-block-usecs', 0) / 1000 / 1000
>>   
>>           time.sleep(self._stats_settle_time)
>> +
>> +
>> +class NetDrvContEnv(NetDrvEpEnv):
>> +    """
>> +    Class for an environment with a netkit pair setup for forwarding traffic
>> +    between the physical interface and a network namespace.
>> +    +-------------+        +----------------------------+
>> +    | INIT NS     |        | TEST NS                    |
>> +    | +---------+ |        | +------------------------+ |
>> +    | | NETIF   | |  bpf   | | Netkit                 | |
>> +    | |         |-|--------|>| nk_guest               | |
>> +    | +---------+ |        | | {LOCAL_PREFIX_V6}::2:2 | |
>> +    | +---------+ |        | +------------------------+ |
>> +    | | Netkit  | |        +----------------------------+
>> +    | | nk_host | |
>> +    | +---------+ |
>> +    +-------------+
>> +    """
>> +
>> +    def __init__(self, src_path, rxqueues=1, **kwargs):
>> +        super().__init__(src_path, **kwargs)
>> +
>> +        self.netns = None
>> +        self._nk_host_ifname = None
>> +        self._nk_guest_ifname = None
>> +        self._tc_clsact_added = False
>> +        self._tc_attached = False
>> +        self._bpf_prog_pref = None
>> +        self._bpf_prog_id = None
>> +        self._init_ns_attached = False
> 
> One problem with these attrs is that if super().__init__() fails
> (NetDrvEpEnv.__init__()) then these will raise attribute errors in
> __del__().
> 
> This can happen if NetDrvEpEnv.remote_remote_ifc() (for example) throws
> an exception because it couldn't find the address the user configured.
> 
> One alternative to getattr() is moving these assignments before
> super().__init__()?

Sounds good, I'll move it above super().__init__().

> 
> Best,
> Bobby
> 

