Return-Path: <netdev+bounces-239737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 298C5C6BDB5
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 23:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 195F54E52BC
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 22:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B270F311588;
	Tue, 18 Nov 2025 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="ZCgSaFVx"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD09311C22;
	Tue, 18 Nov 2025 22:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763504667; cv=none; b=iOFPE4QQakEzD0LL+zpcS3S33vF7Y0VtlR9VrptwS4GPYr8tu5ZcU1hVwPCe0Hb8ZfVyOfSJw41ximw1+Hn1VYD0Ygt5y4LIgWekN9j/eL4RPKx+kCCB/oqG2AqR9b1zCiZowJSFvdD+WkhslyDzAB1AR/h2hXYV9l84BVs57JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763504667; c=relaxed/simple;
	bh=d1hsAgUp0S7O3xktC/JjGyw+tK5U6MXAFsvdNg7H1Fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BmX/y2XXoTY6jolucXTPywAvW1CyBuQjk3IWw2C+NFEthVsPPLOhlSnvm5ECmPfDgzAz9SJrqnONIADSJM/v75pNiAqe5AgAsfrJOBdgr7ODZ//tTnq8W9hIKc/KR5dj7llqAbNm+8XEkK/MuWE8RE1TtmC+M4XSUFfX4AGQJ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=ZCgSaFVx; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1763504661;
	bh=d1hsAgUp0S7O3xktC/JjGyw+tK5U6MXAFsvdNg7H1Fw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZCgSaFVxD9ry+FnSAey6z6hm1/tnZHSDSLHMcRa4lA8s4xygB5rCB6eomM8Lo1+qP
	 duleYI5sfJopH8+Ajy+n4DMCpv9cFPyxX/qpQgp6kbEQkZd2x0z3Ddf9PV/G1N2lom
	 fJbqAbABR7pskYTMacqq9XKLjAn5hTU58EzI6orDYdIiTcmDLOqPF+mOVp5mzVjuWI
	 qCtB/r/slfjDc59fiFbBxi15j3x4ga67P33LQq6UqVTH2/cpoP8906ttYBCVC707+C
	 jSYYmfX4DDkRGz5kTKFEwf6TxqVhaHKZ2OFLcaR1LOl7zJXTdyp0Ri6iQln6IZY+/D
	 6FKhOZvKFYK2w==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 9437B600FC;
	Tue, 18 Nov 2025 22:24:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 5F27620187F;
	Tue, 18 Nov 2025 22:23:13 +0000 (UTC)
Message-ID: <d2e84a2b-74cd-44a1-97a6-a10ece7b4c5f@fiberby.net>
Date: Tue, 18 Nov 2025 22:23:12 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 11/11] wireguard: netlink: generate netlink
 code
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, Jakub Kicinski <kuba@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jordan Rife <jordan@jrife.io>
References: <20251105183223.89913-1-ast@fiberby.net>
 <20251105183223.89913-12-ast@fiberby.net> <aRyNiLGTbUfjNWCa@zx2c4.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <aRyNiLGTbUfjNWCa@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/18/25 3:15 PM, Jason A. Donenfeld wrote:
> On Wed, Nov 05, 2025 at 06:32:20PM +0000, Asbjørn Sloth Tønnesen wrote:
>>   drivers/net/wireguard/netlink_gen.c | 77 +++++++++++++++++++++++++++++
>>   drivers/net/wireguard/netlink_gen.h | 29 +++++++++++
>>   create mode 100644 drivers/net/wireguard/netlink_gen.c
>>   create mode 100644 drivers/net/wireguard/netlink_gen.h
>> +#include "netlink_gen.h"
>> +// SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
>> +/* Do not edit directly, auto-generated from: */
>> +/*	Documentation/netlink/specs/wireguard.yaml */
>> +/* YNL-GEN kernel source */
> 
> Similar to what's happening in the tools/ynl/samples build system,
> instead of statically generating this, can you have this be generated at
> build time, and placed into a generated/ folder that doesn't get checked
> into git? I don't see the purpose of having to manually keep this in
> check?
> 
> (And if for some reason, you refuse to do that, it'd be very nice if the
>   DO NOT EDIT header of the file also had the command that generated it,
>   in case I need to regenerate it later and can't remember how it was
>   done, because I didn't do it the first time, etc. Go's generated files
>   usually follow this pattern.
> 
>   But anyway, I think I'd prefer, if it's possible, to just have this
>   generated at compile time.)

The main value in having the generated kernel code in git, is that it can't
change accidentally, which makes it easy for patchwork to catch if output
changes without being a part of the commit.

I will leave it up to Donald and Jakub, if they want to allow these files to
be generated on-the-fly.

Alternatively, the generated files could be put under YNL in MAINTAINERS, so you
only maintain the spec, but not the generated output files.

I agree that there could be a note in the header about how to re-generate
the files, or just a link to the doc:

https://docs.kernel.org/userspace-api/netlink/intro-specs.html#generating-kernel-code

The easy to use regeneration tool is ynl-regen:
./tools/net/ynl/ynl-regen.sh                           # skip if output is newer than yaml
./tools/net/ynl/ynl-regen.sh -f                        # force, when working on ynl
./tools/net/ynl/ynl-regen.sh -p drivers/net/wireguard  # run on a subdir

