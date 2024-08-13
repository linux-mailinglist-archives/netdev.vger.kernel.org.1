Return-Path: <netdev+bounces-117995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 564BD95033E
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 13:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C3E1284704
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 11:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3571F189918;
	Tue, 13 Aug 2024 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ch0rXnO0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C99421345
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 11:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723547183; cv=none; b=sQKGRB3KHtbr0b5f7kI1Scvxrsva4PYPc4e5zreIu/4ysFK3RxfWea4Y/qxFng0fG7EIzORN1P472G+qnywRRbVtSDotPCdeQ32NVO02n6wk2eKxGeH4fRD6giUnp2Bk0tPoP0QnYqLUfEPI3Y6eO0RO2B7MSD25KvPK4RR+JMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723547183; c=relaxed/simple;
	bh=bkhqbZYWYWSZvsQl29u3Z23IpM9oWQsNayuAc+Nsvbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o0LxyNETgss1Uu5b/3IJn5cM66ysS5vCNP7b7N+GlCeYPGoOjTwn/AZBMIjMNH6mZW+8YJ81qKsHmAsK9m5RAPBpD36zZHWTd2cbBOPrHEdObl1+naI2Z/8GV82WVCpK38MLBtqC3bHljS/YLZ63QnLFx2fil7yaoDB2OvDBwQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ch0rXnO0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723547180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t2NdeYI2y6Sud7cQVQ4w+JoVN5gbV8B7m8JMtP5JxuA=;
	b=ch0rXnO06Iwpnkc/pwi8uQRYVMlKkPWXAn+wqEh3VbGJfo0Rwe0pDGazAzC+MXbIhexPx0
	HbmoI0Qea46ACIKXkroY7ICaEpuGo7+x9nCKuu90Mv0gaqqJEBbFwHyXh56PdWFOIXMlss
	HojUMqkv+5fRJWFNNyAWj8lU8scnqU4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-PSBImtjeN0uO_DM0JFKfTg-1; Tue, 13 Aug 2024 07:06:19 -0400
X-MC-Unique: PSBImtjeN0uO_DM0JFKfTg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-428e4f08510so10394445e9.3
        for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 04:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723547178; x=1724151978;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t2NdeYI2y6Sud7cQVQ4w+JoVN5gbV8B7m8JMtP5JxuA=;
        b=PttxMCCmStkrfgIGeNjowy6BrKVukDAC44ZMwh4AfTHk0MiJIdhRY3ZmfTjvcxTIjF
         SARQiGjMtrlYRU5xk2IvTvOYzgEINoTcmc/0Dr6uq/V9St7Odu8X6BFRZPxIWCs9un0p
         KgUqE0C2DycZgMPq0NOfYAyGPLq5mGWFbJ4gSEt8HJkH7xvCTIXbUiigeLIRug4GNNM1
         C/s1aiB0r3ivmnfMSyX7iRrxCCt+40H7e7WqVB4jwff/PimH8ynIL56EAxJdL7ViAEhA
         OJeQKhks8su67bCxPJgw1Bp3TFDj/fEQmLccErG5GrG6i7oXcyvqeEIN1JaCGyz140Hz
         h7zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxx6ZJ7qqn8XRenA5P536VpqeUlt6J35XvwyWftSkDlFKBWC0bXJ79spiEMjDPa7IAhLBjxf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5S24PpC0ROb13uXwyQClqtQ/R7NRK0t2rB3fNchpCNOaIJT1R
	hP6KPyj321yBIkuxiB/Jh1wfGS4AQj+limW1MS+DdOItbRIfgmwguBkJRplrHP0X38qyB1fm412
	QQwbAx2WsaCbpY6tggjXXVOLS4x3YU06hBu8SBfMpTME8DvPgnOw3kg==
X-Received: by 2002:a5d:6d82:0:b0:367:9505:73ed with SMTP id ffacd0b85a97d-3716fc78f67mr732476f8f.7.1723547177673;
        Tue, 13 Aug 2024 04:06:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa7Vi7jbvh74+IcXC90KHicELNDDcvYfv7kh0HQ3hv001MY6PHY4Uwx5U6i85VLvRvhb37Nw==
X-Received: by 2002:a5d:6d82:0:b0:367:9505:73ed with SMTP id ffacd0b85a97d-3716fc78f67mr732456f8f.7.1723547177128;
        Tue, 13 Aug 2024 04:06:17 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1708:9110:151e:7458:b92f:3067? ([2a0d:3344:1708:9110:151e:7458:b92f:3067])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4cfef6fasm9961156f8f.60.2024.08.13.04.06.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 04:06:16 -0700 (PDT)
Message-ID: <8fe01ef6-2c85-4843-b686-8cb43cc1f454@redhat.com>
Date: Tue, 13 Aug 2024 13:06:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: ipv6: ioam6: new feature tunsrc
To: Justin Iurman <justin.iurman@uliege.be>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org
References: <20240809123915.27812-1-justin.iurman@uliege.be>
 <20240809123915.27812-3-justin.iurman@uliege.be>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240809123915.27812-3-justin.iurman@uliege.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/24 14:39, Justin Iurman wrote:
> This patch provides a new feature (i.e., "tunsrc") for the tunnel (i.e.,
> "encap") mode of ioam6. Just like seg6 already does, except it is
> attached to a route. The "tunsrc" is optional: when not provided (by
> default), the automatic resolution is applied. Using "tunsrc" when
> possible has a benefit: performance.

It's customary to include performances figures in performance related 
changeset ;)

> 
> Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
> ---
>   include/uapi/linux/ioam6_iptunnel.h |  7 +++++
>   net/ipv6/ioam6_iptunnel.c           | 48 ++++++++++++++++++++++++++---
>   2 files changed, 51 insertions(+), 4 deletions(-)
> 
> diff --git a/include/uapi/linux/ioam6_iptunnel.h b/include/uapi/linux/ioam6_iptunnel.h
> index 38f6a8fdfd34..6cdbd0da7ad8 100644
> --- a/include/uapi/linux/ioam6_iptunnel.h
> +++ b/include/uapi/linux/ioam6_iptunnel.h
> @@ -50,6 +50,13 @@ enum {
>   	IOAM6_IPTUNNEL_FREQ_K,		/* u32 */
>   	IOAM6_IPTUNNEL_FREQ_N,		/* u32 */
>   
> +	/* Tunnel src address.
> +	 * For encap,auto modes.
> +	 * Optional (automatic if
> +	 * not provided).
> +	 */
> +	IOAM6_IPTUNNEL_SRC,		/* struct in6_addr */
> +
>   	__IOAM6_IPTUNNEL_MAX,
>   };
>   
> diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
> index cd2522f04edf..e0e73faf9969 100644
> --- a/net/ipv6/ioam6_iptunnel.c
> +++ b/net/ipv6/ioam6_iptunnel.c
> @@ -42,6 +42,8 @@ struct ioam6_lwt {
>   	struct ioam6_lwt_freq freq;
>   	atomic_t pkt_cnt;
>   	u8 mode;
> +	bool has_tunsrc;
> +	struct in6_addr tunsrc;
>   	struct in6_addr tundst;
>   	struct ioam6_lwt_encap tuninfo;
>   };
> @@ -72,6 +74,7 @@ static const struct nla_policy ioam6_iptunnel_policy[IOAM6_IPTUNNEL_MAX + 1] = {
>   	[IOAM6_IPTUNNEL_MODE]	= NLA_POLICY_RANGE(NLA_U8,
>   						   IOAM6_IPTUNNEL_MODE_MIN,
>   						   IOAM6_IPTUNNEL_MODE_MAX),
> +	[IOAM6_IPTUNNEL_SRC]	= NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
>   	[IOAM6_IPTUNNEL_DST]	= NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
>   	[IOAM6_IPTUNNEL_TRACE]	= NLA_POLICY_EXACT_LEN(
>   					sizeof(struct ioam6_trace_hdr)),
> @@ -144,6 +147,11 @@ static int ioam6_build_state(struct net *net, struct nlattr *nla,
>   	else
>   		mode = nla_get_u8(tb[IOAM6_IPTUNNEL_MODE]);
>   
> +	if (tb[IOAM6_IPTUNNEL_SRC] && mode == IOAM6_IPTUNNEL_MODE_INLINE) {
> +		NL_SET_ERR_MSG(extack, "no tunnel source expected in this mode");
> +		return -EINVAL;
> +	}

when mode is IOAM6_IPTUNNEL_MODE_AUTO, the data path could still add the 
encapsulation for forwarded packets, why explicitly preventing this 
optimization in such scenario?

> +
>   	if (!tb[IOAM6_IPTUNNEL_DST] && mode != IOAM6_IPTUNNEL_MODE_INLINE) {
>   		NL_SET_ERR_MSG(extack, "this mode needs a tunnel destination");
>   		return -EINVAL;
> @@ -178,6 +186,14 @@ static int ioam6_build_state(struct net *net, struct nlattr *nla,
>   	ilwt->freq.n = freq_n;
>   
>   	ilwt->mode = mode;
> +
> +	if (!tb[IOAM6_IPTUNNEL_SRC]) {
> +		ilwt->has_tunsrc = false;
> +	} else {
> +		ilwt->has_tunsrc = true;
> +		ilwt->tunsrc = nla_get_in6_addr(tb[IOAM6_IPTUNNEL_SRC]);

Since you are going to use the source address only if != ANY, I think it 
would be cleaner to refuse such addresses here. That will avoid an 
additional check in the datapath.

Cheers,

Paolo


