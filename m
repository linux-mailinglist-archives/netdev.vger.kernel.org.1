Return-Path: <netdev+bounces-109831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC3992A0B8
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 13:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60501B21A94
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 11:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F0F7C081;
	Mon,  8 Jul 2024 11:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="evuMQzB4"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1F3482DE;
	Mon,  8 Jul 2024 11:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720437125; cv=none; b=d0EKQBzQnJ0nKorvDZ2idmHaFnPLhb0exYRUx2ksmAzWIzBQsRU/HJX44Gv5Z9Y+BJ4fp8WfP9zok4uqgsHTVX8kfeilsYmZWhehRUYqrEDcVNDApC2n72NXS4+S9SzNR6JIOmrG3zxcXEiOnxrsPfqZd7XSpBYEkL5E030OvDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720437125; c=relaxed/simple;
	bh=EYvd8/6a40rLnTFvrM7ilLg/ECtaPmwgpRnoz6Mhw8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UB4PvSuPIrqGbfk9T5FieBIwTFaweE7jnM7lpyOqdMPUXIi3X4ucn84i4KUinqiQawInY0sX52ZA5+y+1SlBNQRYzhuWeXybwW88znu2SrEksUn2WD/isXn5+u3D490hfIF3E6XQ/SzbHHRG9vBaNK6XRDuFLHtmB/qgobAlFIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=evuMQzB4; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1720437112;
	bh=EYvd8/6a40rLnTFvrM7ilLg/ECtaPmwgpRnoz6Mhw8U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=evuMQzB4rPHOYerp94tBUMG55hxqnDx1emnqziCh/IKUSGgkB9r7o1ZmHshIl15rt
	 xVH2zUb+25phZbhJRvkSZjtNLGpCQ7zATZR/B4kNGzbUn103sSXp49ChWe2b3zZqEI
	 WaaT2CzV4wudUpLsewvNYbebZ8R74Wktphnl9hkKbFvTsPfuZkxpmDbmRkskrnFwaq
	 qKJ8I8B2+4VeO3YKp2Kn21o30L9DAqIL+C//fmSHCfuLinZ+Ye5qR2s4xInvys9p1U
	 IQBmqKmhMDhnARP2NVmb3bE3NUJjsKPmuEXF6OTpgODR4zgHGIxcwYRWHPjwuKCTox
	 iWa3vWOhtpDPQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id D2B6860078;
	Mon,  8 Jul 2024 11:11:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id D0866201E4B;
	Mon, 08 Jul 2024 11:11:44 +0000 (UTC)
Message-ID: <aadf8f7c-2f99-4282-b94e-9c46c55975dd@fiberby.net>
Date: Mon, 8 Jul 2024 11:11:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 01/10] net/sched: flower: refactor tunnel flag
 definitions
To: netdev@vger.kernel.org
Cc: Davide Caratti <dcaratti@redhat.com>, Ilya Maximets <i.maximets@ovn.org>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Simon Horman <horms@kernel.org>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Florian Westphal <fw@strlen.de>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 linux-kernel@vger.kernel.org, David Ahern <dsahern@kernel.org>,
 Stephen Hemminger <stephen@networkplumber.org>
References: <20240705133348.728901-1-ast@fiberby.net>
 <20240705133348.728901-2-ast@fiberby.net>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <20240705133348.728901-2-ast@fiberby.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/5/24 1:33 PM, Asbjørn Sloth Tønnesen wrote:
 > net/sched: flower: refactor tunnel flag definitions

Should have been: "net/sched: flower: refactor control flag definitions"

After the split, tunnel control flags are first introduced in the next patch.

I will properly do a new spin tomorrow.

Davide, I think David Ahern would be happy [1] if you could post a new iproute2 patch,
since the kernel patches should preferably hit net-next this week (due to uAPI breakage).

[1] https://lore.kernel.org/c83bb901-686e-4507-b4b1-020ae86d2381@kernel.org/

-- 
pw-bot: changes-requested

