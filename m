Return-Path: <netdev+bounces-240130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A86F4C70C89
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F1B97343F33
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F0E2DFF13;
	Wed, 19 Nov 2025 19:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="L/aGmNKH"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E2A28751F;
	Wed, 19 Nov 2025 19:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580018; cv=none; b=rS1IebQHDmntb7q4iITasghYy7jWU4U+PaCdcgMgr8dfjwU6UHiCbIMPBW/8DSm+BZDNniutV36rLtMk8873K6vC4+cJt+e3XNfPPV8I3GBpBHed3ehGnvTEwRA2oeOiSqeh5DQr667xQK+FD9qxra/Lns+MrEg8w2auODaukQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580018; c=relaxed/simple;
	bh=0o+sGUVZev9fr7qLJnF2Qyzc60L4WQBdRLP4ge47zGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VRiz3QnM6hTHSVDx6+TQAnVJgJ8EXGvFuYKvIsF5bQs6etZj8UD6t+AfO4ihW9vZ1Z8LoJoaevrqK9HEIP9ZrahRjstQnyqCLfl27d+Hasm7RjoHjtcJPAeThbWOnObD2pzh2ZXRaNlOZlaH4D+Z7NxUcz3w7kd7mPbOtusYhjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=L/aGmNKH; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1763579999;
	bh=0o+sGUVZev9fr7qLJnF2Qyzc60L4WQBdRLP4ge47zGY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L/aGmNKHW9vNFv9rZTEg4cC5ahBfD0qCPHT9ZnyPpXgVNPyR/ysBBqcmg2/rkdiKM
	 MzBLC33oyhcRTzDywwHEGpmZ9yl7lCAG0UZCnhCmmtzA1BRq1OyJDYhcKwuZ6K0F8U
	 XS5YUTddIqoYPkEDZbat06yiJ+zrgAGaP119IzAgZ/SKAol3CTlD7Tku25Rri70Ko6
	 KM/xqdjhsqMBoOSyGzC2CeOfjueyCakVSb/GX7xk+FUljIJxGW3X1nPgIiG8kV3PsX
	 8I/uJv3OggsIBLZu2IKWYiGTcxmuIiHDsR9tO7XFS5e9cZ9DgeaNNkF8C9es5yk1Em
	 Ve7yXcq9afoDw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 70A14600FC;
	Wed, 19 Nov 2025 19:19:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 0152D20177D;
	Wed, 19 Nov 2025 19:19:28 +0000 (UTC)
Message-ID: <f4d147da-3299-4ae7-b11e-b4309625e2c9@fiberby.net>
Date: Wed, 19 Nov 2025 19:19:28 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 04/11] netlink: specs: add specification for
 wireguard
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, Jakub Kicinski <kuba@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jordan Rife <jordan@jrife.io>
References: <20251105183223.89913-1-ast@fiberby.net>
 <20251105183223.89913-5-ast@fiberby.net> <aRvWzC8qz3iXDAb3@zx2c4.com>
 <f21458b6-f169-4cd3-bd1b-16255c78d6cd@fiberby.net>
 <aRyLoy2iqbkUipZW@zx2c4.com>
 <9871bdc7-774d-4e35-be5f-02d45063d317@fiberby.net>
 <aRz4rs1IpohQpgWf@zx2c4.com> <20251118165028.4e43ee01@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <20251118165028.4e43ee01@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/19/25 12:50 AM, Jakub Kicinski wrote:
> On Tue, 18 Nov 2025 23:52:30 +0100 Jason A. Donenfeld wrote:
>> On Tue, Nov 18, 2025 at 09:59:45PM +0000, Asbjørn Sloth Tønnesen wrote:
>>> So "c-function-prefix" or something might work better.
>>
>> Also fine with me. I'd just like consistent function naming, one way or
>> another.
> 
> IIUC we're talking about the prefix for the kernel C codegen?
> Feels a bit like a one-off feature to me, but if we care deeply about
> it let's add it as a CLI param to the codegen. I don't think it's
> necessary to include this in the YAML spec.

IIUC then adding it as a CLI param is more work, and just moves family details
to ynl-regen, might as well skip the CLI param then and hack it in the codegen.

Before posting any new patches, I would like to get consensus on this.

Options:

A) As-is and all 4 functions gets renamed.

    Stacktraces, gdb scripts, tracing etc. changes due to the 4 function renames.

B) Add a "operations"->"function-prefix" in YAML, only one funtion gets renamed.

    wg_get_device_start(), wg_get_device_dump() and wg_get_device_done() keep
    their names, while wg_set_device() gets renamed to wg_set_device_doit().

    This compliments the existing "name-prefix" (which is used for the UAPI enum names).

    Documentation/netlink/genetlink-legacy.yaml |  6 ++++++
    tools/net/ynl/pyynl/ynl_gen_c.py            | 13 +++++++++----
    2 files changed, 15 insertions(+), 4 deletions(-)

C) Add a "call" in YAML to override the default doit/dumpit names.

    All 4 functions can keep their current names.

    This compliments the existing "pre" and "post" (which are only rendered when set).

    How these map to struct genl_split_ops:

       kind \ YAML | pre        | call    | post
      -------------+------------+---------+------------
       do          | .pre_doit  | .doit   | .post_doit
       dump        | .start     | .dumpit | .done

D) Add it as a ynl_gen_c.py CLI param and make ynl-regen set it for wireguard?

While A is a no-op, then B is simpler to implement than option C, as the names are
generated in multiple places, where as it's simple to just use a prefix.
So option C might require some more refactoring, than is worth it for an one-off feature.
OTOH option C is more flexible than option B.

Jason, would option B work for you?

Jakub, would option B or C be acceptable?

WDYT?

