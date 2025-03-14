Return-Path: <netdev+bounces-174912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4578AA614A4
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 16:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D630617E358
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 15:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2781A17BA1;
	Fri, 14 Mar 2025 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDLh2kW0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6F21F3BAE
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741965516; cv=none; b=QLpxmQfRWrbOs71Oit5rqMQSnF5byGW6vcHRU3joXuGei2bN2gcIrY7p4+JOZlunAVbQnunXLLBOGwHV5OvZghlqdnelFapdBTp1esinAne0IbE2oK8SBct8wxsmn36alrU2i2MSUfWwJZjcrMd/PxmiNMC8Q1/ePKIV75Naxjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741965516; c=relaxed/simple;
	bh=Wv6ExHuO/paAEOXuVqvm75amjVPlBf4AYYa6jL7M3kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHmloOyU3il3sf5bW6naJtmcVsHmifqjDwqgEfj379U/1dEwrjbGzHMyNMTrKLXCcN0WcEHwk+GPF60d7ljMI+6lT3oT0kOzMrFYcxwJ5Jk4EMsZAHNj7Yn0sLDToUYKNcnOsTDLwAQ74W2A1NEaJPQPIRxuCGQezq3B4jYC8/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDLh2kW0; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22435603572so38309305ad.1
        for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 08:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741965514; x=1742570314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/tUVW9/u0CoBMdZYY1ZdIEkVO1xPOz7unSLbDMhYqZ0=;
        b=QDLh2kW0aBs4e5RVnI+EmoS4UAu7ihg8KZ8bktvw2fNuMZMaii35Gx206g4/nTXsco
         Tf3hjZDZQwzQApSVO1bjGVmRBw7/gKsNeNtysK2ms2k8HaLIAC9nkLFU1gArABEFvh8T
         EL2nB8sEvNWYmcxhmwcksqNQV4Q04DuRulizkNcfHmbZ1Q5rjmDGPwUN49zD9MUokNvW
         X89Y30UuSBcBxLcB2Myn92Nl5zOCfstN7Jqc/OL5wye9RsuamNLtYf9IC++jSssE8DQF
         5/gbjCVB/OCorgFB5ZCTDoF4FOeMYZm9GzNWgRQ23160uGzDd8XMiSbnwyn0SfAve4e7
         CjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741965514; x=1742570314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tUVW9/u0CoBMdZYY1ZdIEkVO1xPOz7unSLbDMhYqZ0=;
        b=uSjYcGLEpgc55WHPMzy0yRrQT400hQK6WiQg1jQlAwvY0j05SYPsfiU9DE/udhzhiE
         XKgh1RwYtzGIlPEvxmTEi85IgU0d8NXI4fGvGhZgMWnp9fwrEW85evWpl5HLEqGLDEfy
         XLSBG86xDAJAu+EkpkEIglgN+3DFSUNgMShe+lQaNIlZlDPvwoQ9BvnWE8GvWLQQMVgb
         W0AEb9uZ4rlhbaud/bNY1e/PIiYc/Ydqnld1t4yQ50SO9cjZ/IDR9D0Xdcd5bInL9xmJ
         34m6Thnqtc9avOnOIM0g/bs7gAhYe2V9WEmtTGs42yyRFB9t9MOzmQ4ni2L5Y7S/UtdY
         ykPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHg5Q4J/B2uOJlAe7H14kqKV0LLULEiq9OxdNAlH5l8KIaIbx8fzb5NzlGWZKTBBhMZmfl8So=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywph+iAcTceGlvxYNS3rO0/9SMeNUuJIofC1XnlgRfBkwbDrMng
	cmqP1zrxWnC9H0h4OeWXmEOvfRefHA8FoTcq7aLS7sc0qPDUoak=
X-Gm-Gg: ASbGncvrw1FWmKUtuySxOaDvvXxZD+OaxBc30cHI8Dbq+uNCspRymuU81M+whoNUZ/S
	Cbd+bowD7TEnjGxMLZmsh8C7KzVLKzUnB1+L1FUHnSu0ysxitcatLoQIEX+huMbvtsUkTrpC/zD
	7tBgQP44b+uIUhMm7uZkiyiSjomO2ZQeRRLq58aNvM8qZzMplliAxD6ELdq7UugMBj+c0UFlQ3W
	FGlwRkVJqpZ1bm0QwnbJtU1VFtdb4SdyGOXGwuOr0tzt/a1QhBBaRZZh4yyWpyWE3BoaACm62r5
	Viw8zVBfOBG7pScgD4ixTwd1tHuhAAaFYycycYnx3j7m
X-Google-Smtp-Source: AGHT+IHZ8rVWIKhy1C59rpMHOxKIIx+075WX/gUEdBhx8LKF/EijJg3A7eKMrDG30dlQFDhdiCq2zQ==
X-Received: by 2002:a17:903:22c1:b0:224:ab0:9b00 with SMTP id d9443c01a7336-225e0a8ea3cmr38710355ad.27.1741965513635;
        Fri, 14 Mar 2025 08:18:33 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73711695b4bsm3073582b3a.149.2025.03.14.08.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 08:18:33 -0700 (PDT)
Date: Fri, 14 Mar 2025 08:18:32 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Ido Schimmel <idosch@idosch.org>, Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net v4 1/2] gre: Fix IPv6 link-local address generation.
Message-ID: <Z9RIyKZDNoka53EO@mini-arch>
References: <cover.1741375285.git.gnault@redhat.com>
 <559c32ce5c9976b269e6337ac9abb6a96abe5096.1741375285.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <559c32ce5c9976b269e6337ac9abb6a96abe5096.1741375285.git.gnault@redhat.com>

On 03/07, Guillaume Nault wrote:
> Use addrconf_addr_gen() to generate IPv6 link-local addresses on GRE
> devices in most cases and fall back to using add_v4_addrs() only in
> case the GRE configuration is incompatible with addrconf_addr_gen().
> 
> GRE used to use addrconf_addr_gen() until commit e5dd729460ca
> ("ip/ip6_gre: use the same logic as SIT interfaces when computing v6LL
> address") restricted this use to gretap and ip6gretap devices, and
> created add_v4_addrs() (borrowed from SIT) for non-Ethernet GRE ones.
> 
> The original problem came when commit 9af28511be10 ("addrconf: refuse
> isatap eui64 for INADDR_ANY") made __ipv6_isatap_ifid() fail when its
> addr parameter was 0. The commit says that this would create an invalid
> address, however, I couldn't find any RFC saying that the generated
> interface identifier would be wrong. Anyway, since gre over IPv4
> devices pass their local tunnel address to __ipv6_isatap_ifid(), that
> commit broke their IPv6 link-local address generation when the local
> address was unspecified.
> 
> Then commit e5dd729460ca ("ip/ip6_gre: use the same logic as SIT
> interfaces when computing v6LL address") tried to fix that case by
> defining add_v4_addrs() and calling it to generate the IPv6 link-local
> address instead of using addrconf_addr_gen() (apart for gretap and
> ip6gretap devices, which would still use the regular
> addrconf_addr_gen(), since they have a MAC address).
> 
> That broke several use cases because add_v4_addrs() isn't properly
> integrated into the rest of IPv6 Neighbor Discovery code. Several of
> these shortcomings have been fixed over time, but add_v4_addrs()
> remains broken on several aspects. In particular, it doesn't send any
> Router Sollicitations, so the SLAAC process doesn't start until the
> interface receives a Router Advertisement. Also, add_v4_addrs() mostly
> ignores the address generation mode of the interface
> (/proc/sys/net/ipv6/conf/*/addr_gen_mode), thus breaking the
> IN6_ADDR_GEN_MODE_RANDOM and IN6_ADDR_GEN_MODE_STABLE_PRIVACY cases.
> 
> Fix the situation by using add_v4_addrs() only in the specific scenario
> where the normal method would fail. That is, for interfaces that have
> all of the following characteristics:
> 
>   * run over IPv4,
>   * transport IP packets directly, not Ethernet (that is, not gretap
>     interfaces),
>   * tunnel endpoint is INADDR_ANY (that is, 0),
>   * device address generation mode is EUI64.

Could you please double check net/forwarding/ip6gre_custom_multipath_hash.sh ?
It seems like it started falling after this series has been pulled:
https://netdev-3.bots.linux.dev/vmksft-forwarding-dbg/results/31301/2-ip6gre-custom-multipath-hash-sh/stdout

