Return-Path: <netdev+bounces-80682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD438805A0
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 20:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF6321F2328A
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 19:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADDF3A1AA;
	Tue, 19 Mar 2024 19:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uSjosQNn"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066F53B29D
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 19:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710877598; cv=none; b=DyE6HocOQqZBLpLbdzEv6mAoQAxodjC0vKY7nwjC1qfhU8T7QKYwmB4Q8dxodboSwspOQ/3fOgQ0Z02Rv+cJtkyHkJyz5XMa3GxXWbdESdPi6KVNrp8JRZwmpHTi0R2y5AF73ed5A53oTunES8v52gRoOfM8XaNRTNA8GmpE+hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710877598; c=relaxed/simple;
	bh=kXd2i+AOWYw8mNhkzMSPRsJ1BAfSMk5UbmtyY1hKQ4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OF/EEnOFQTKXuTekibTE631Upz3emmzmNobS6VPaEaXM7+ArFnDtMtBOxa/3oxQ7qGpVO9ZMxoPuO5GZxNMXHahWXJj04iw2sbmurTiW8RZtKVKOBr8lJkZL0OfLWTMaS9jWQatTlq1F21rOCblFKFGBDMeiyXeuw+RI9wvuUvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uSjosQNn; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5b1d5758-3510-47c5-97e9-2edc5112d046@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710877595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+GT3KW1575UJ01KouvR9HZva7hTJApu0idB1GvqPOVU=;
	b=uSjosQNnzCRjKn06REIRfbqr6tgrO2Qo7zhAniZ0awIiRTtfyEWuK2Hyi3ndgcrNlR3s+w
	ZZLB/PTPqMx6mhyh1DRVV0unlZHqRqMg2r379g286Z/TbO9uUPvq8ttVj2HDOUzKivnUYi
	XHBwD6NqJEhyHn5e/0kAGO1a08uXSn8=
Date: Tue, 19 Mar 2024 12:46:26 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4] net: Re-use and set mono_delivery_time bit
 for userspace tstamp packets
Content-Language: en-US
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, kernel@quicinc.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Halaney <ahalaney@redhat.com>,
 Martin KaFai Lau <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>
References: <20240301201348.2815102-1-quic_abchauha@quicinc.com>
 <2a4cb416-5d95-459d-8c1c-3fb225240363@linux.dev>
 <65f16946cd33e_344ff1294fc@willemb.c.googlers.com.notmuch>
 <28282905-065a-4233-a0a2-53aa9b85f381@linux.dev>
 <65f2004e65802_3d1e792943e@willemb.c.googlers.com.notmuch>
 <0dff8f05-e18d-47c8-9f19-351c44ea8624@linux.dev>
 <e5da91bc-5827-4347-ab38-36c92ae2dfa2@quicinc.com>
 <65f21d65820fc_3d934129463@willemb.c.googlers.com.notmuch>
 <bc037db4-58bb-4861-ac31-a361a93841d3@linux.dev>
 <65f2c81fc7988_3ee61729465@willemb.c.googlers.com.notmuch>
 <5692ddb3-9558-4440-a7bf-47fcc47401ed@linux.dev>
 <65f35e00a83c0_2132294f5@willemb.c.googlers.com.notmuch>
 <e270b646-dae0-41cf-9ef8-e991738b9c57@quicinc.com>
 <8d245f5a-0c75-4634-9513-3d420eb2c88f@linux.dev>
 <d10254cc-a908-4d81-98d2-2eed715e521f@quicinc.com>
 <66ad9e5b-0126-476e-bf0f-6a33f446c976@quicinc.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <66ad9e5b-0126-476e-bf0f-6a33f446c976@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/18/24 12:02 PM, Abhishek Chauhan (ABC) wrote:
>>>>>> I think the "struct inet_frag_queue" also needs a new "user_delivery_time"
>>>>>> field. "mono_delivery_time" is already in there.
>>> [ ... ]
>>>
> Martin, Do we really need to add user_delivery_time as part of inet_frag_queue struct? I was wondering why is this required since we are using tstamp_type:2 to
> distinguish between timestamp anyway .


The context for this was before combining mono_delivery_time:1 and 
user_delivery_time:1 into tstamp_type:2. No need to add user_delivery_time to 
inet_frag_queue because it is combined into tstamp_type:2. If 
mono_delivery_time:1 is replaced with tstamp_type:2 in sk_buff, the same should 
be done in inet_frag_queue.



