Return-Path: <netdev+bounces-106258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BD0915927
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 23:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA0F1C21C90
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 21:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A681A08DA;
	Mon, 24 Jun 2024 21:40:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891E68F6B;
	Mon, 24 Jun 2024 21:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719265227; cv=none; b=aBsoM9RMB+8YcJ1n9DsigaLdfy9GXKV5S2Vl/01bQ0ODn/SPN8l1w+Tr3bz+XAF7cl9qkGu8OapUUBL4VF6MBWc2CekMHoDy3nPFbWyVDm/4tGfVKS8tlZHX6Hr5/AR6HYDhP7FMUrv2+V79tiIqOA8OXTj30aYRT9zNhdMwsAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719265227; c=relaxed/simple;
	bh=92CkypWCKRo21iK/39AGivsX+yFazOH7qt52Zq6Z2Xg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d9TQfKnQc86BQ4KLJfD85qKEia3DtMi20hO1rUtwtxLK57vNUQMz+VvyfBrZblYuLtYl+uviAMDQzMK8XBOMf1fDWTeXZdVQpGcxOSKo8oquCAuJ4+LV9jpTJOqfmBJN4PJ3CKdfoiPLIGPWr69vA9UGe4Wqsu7wFbLgkAlGEdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=ovn.org; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ovn.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 39D5FC0003;
	Mon, 24 Jun 2024 21:40:20 +0000 (UTC)
Message-ID: <a0b35837-375b-4650-9e68-ef4883c0d0c9@ovn.org>
Date: Mon, 24 Jun 2024 23:40:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, aconole@redhat.com, echaudro@redhat.com,
 horms@kernel.org, dev@openvswitch.org, Yotam Gigi <yotam.gi@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 04/10] net: psample: allow using rate as
 probability
To: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org
References: <20240619210023.982698-1-amorenoz@redhat.com>
 <20240619210023.982698-5-amorenoz@redhat.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20240619210023.982698-5-amorenoz@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: i.maximets@ovn.org

On 6/19/24 23:00, Adrian Moreno wrote:
> Although not explicitly documented in the psample module itself, the
> definition of PSAMPLE_ATTR_SAMPLE_RATE seems inherited from act_sample.
> 
> Quoting tc-sample(8):
> "RATE of 100 will lead to an average of one sampled packet out of every
> 100 observed."
> 
> With this semantics, the rates that we can express with an unsigned
> 32-bits number are very unevenly distributed and concentrated towards
> "sampling few packets".
> For example, we can express a probability of 2.32E-8% but we
> cannot express anything between 100% and 50%.
> 
> For sampling applications that are capable of sampling a decent
> amount of packets, this sampling rate semantics is not very useful.
> 
> Add a new flag to the uAPI that indicates that the sampling rate is
> expressed in scaled probability, this is:
> - 0 is 0% probability, no packets get sampled.
> - U32_MAX is 100% probability, all packets get sampled.
> 
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---
>  include/net/psample.h                 |  3 ++-
>  include/uapi/linux/psample.h          | 10 +++++++++-
>  include/uapi/linux/tc_act/tc_sample.h |  1 +
>  net/psample/psample.c                 |  3 +++
>  4 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/psample.h b/include/net/psample.h
> index 2ac71260a546..c52e9ebd88dd 100644
> --- a/include/net/psample.h
> +++ b/include/net/psample.h
> @@ -24,7 +24,8 @@ struct psample_metadata {
>  	u8 out_tc_valid:1,
>  	   out_tc_occ_valid:1,
>  	   latency_valid:1,
> -	   unused:5;
> +	   rate_as_probability:1,
> +	   unused:4;
>  	const u8 *user_cookie;
>  	u32 user_cookie_len;
>  };
> diff --git a/include/uapi/linux/psample.h b/include/uapi/linux/psample.h
> index e80637e1d97b..b765f0e81f20 100644
> --- a/include/uapi/linux/psample.h
> +++ b/include/uapi/linux/psample.h
> @@ -8,7 +8,11 @@ enum {
>  	PSAMPLE_ATTR_ORIGSIZE,
>  	PSAMPLE_ATTR_SAMPLE_GROUP,
>  	PSAMPLE_ATTR_GROUP_SEQ,
> -	PSAMPLE_ATTR_SAMPLE_RATE,
> +	PSAMPLE_ATTR_SAMPLE_RATE,	/* u32, ratio between observed and
> +					 * sampled packets or scaled probability
> +					 * if PSAMPLE_ATTR_SAMPLE_PROBABILITY
> +					 * is set.
> +					 */
>  	PSAMPLE_ATTR_DATA,
>  	PSAMPLE_ATTR_GROUP_REFCOUNT,
>  	PSAMPLE_ATTR_TUNNEL,
> @@ -20,6 +24,10 @@ enum {
>  	PSAMPLE_ATTR_TIMESTAMP,		/* u64, nanoseconds */
>  	PSAMPLE_ATTR_PROTO,		/* u16 */
>  	PSAMPLE_ATTR_USER_COOKIE,	/* binary, user provided data */
> +	PSAMPLE_ATTR_SAMPLE_PROBABILITY,/* no argument, interpret rate in
> +					 * PSAMPLE_ATTR_SAMPLE_RATE as a
> +					 * probability scaled 0 - U32_MAX.
> +					 */
>  
>  	__PSAMPLE_ATTR_MAX
>  };
> diff --git a/include/uapi/linux/tc_act/tc_sample.h b/include/uapi/linux/tc_act/tc_sample.h
> index fee1bcc20793..7ee0735e7b38 100644
> --- a/include/uapi/linux/tc_act/tc_sample.h
> +++ b/include/uapi/linux/tc_act/tc_sample.h
> @@ -18,6 +18,7 @@ enum {
>  	TCA_SAMPLE_TRUNC_SIZE,
>  	TCA_SAMPLE_PSAMPLE_GROUP,
>  	TCA_SAMPLE_PAD,
> +	TCA_SAMPLE_PROBABILITY,
>  	__TCA_SAMPLE_MAX
>  };
>  #define TCA_SAMPLE_MAX (__TCA_SAMPLE_MAX - 1)

Not a full review yet, but this hunk seems unrelated to the set
as you're not adding rate_as_probability to act_sample.

I suppose, it was part of the plan at some point, but then 

Best regards, Ilya Maximets.

