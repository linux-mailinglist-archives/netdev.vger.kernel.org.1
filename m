Return-Path: <netdev+bounces-274649-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAeJFo6yzml+pQYAu9opvQ
	(envelope-from <netdev+bounces-274649-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 20:16:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D8D38CFA1
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 20:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 031C730214E2
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 18:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5761E371CE1;
	Thu,  2 Apr 2026 18:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sfNSlQ6G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF0D31B824
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 18:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775153424; cv=none; b=HXuRUWOPuVJs3XOJs0R+oBhnJpCYI+NbmcWIOlmTKqacBfp3wbfLPQWdB+rkJbZIOgHkvkIuwfgzTMqXtsAK5B8LNg2f58gT4GH44koWrcLiZeCilfIcJFyRsuGDw7DG+RG/m/78NxW8Y46d+XjpzHe1JYAz3TNFt3JJcY0eyfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775153424; c=relaxed/simple;
	bh=VKyp35Ah4QwCY7oFfOm3kj6l94xQMWBfs6kqPWBvlsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LjuekN0COr6/SN47GhqvxMFd+fWQtk5VEocZnmGSRcqvvLGyzI9y/+C7G8KYY0hfAevb9mk4+iJ1U6EzerV2H8UYV187SWj3vEVMgXgTZNPtXOGx40voqkmeLgEOt4PEE4dMklAGByIgi94YLcsOR/RJNn2CGAAiuiL2dTdzIg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sfNSlQ6G; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9358bc9c50so167545466b.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 11:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775153421; x=1775758221; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HKThJzqNd63y2Hykf1PvGrQJF6u6w1/Xs8zxw6PherI=;
        b=sfNSlQ6GzYIjOOgKF8+uS0zOkCb/tz4txKaly8lGpYSJHpbRhc5Cr3x1FEV8P00ZfP
         DeN/K4KmzEm7JHJQ6U3cPPdsPZ3wNAMEvCxe0TqKKkDTgFERVgCiuSkJZBsadJFozIto
         W0yuYdd70tkVmrKxZ0xiPGnAe0jmGKH7icIFxhumXctEHJ9MTvS+pqKorjDOWZ+Bt9tB
         TKFWGZdqpNZtBNMDIA1EpkZQAgrKKsJEOBxC/96qLPMOLdhHiOMOfeMNwctj+pf9nnQa
         52VRJm4jyroLx0DjQnvYF9PAXq+9C5/5vQrLVrMzJa1hTkMAFDOPYttzhQ1OcM7hY0k7
         uDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775153421; x=1775758221;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HKThJzqNd63y2Hykf1PvGrQJF6u6w1/Xs8zxw6PherI=;
        b=PfjIIRm0UAUoffw9u9yh1YMKriuIzSwUNPCLbJEfz1AooeEVM/5bNnWaBwUFa1Vpji
         E1tXJns9AVCBwVJDOXTGWDB/6MqYObGlSn+CDH9Y3AQ0NvT3dWH10UhLPm5d6YWzGjmo
         ublljYDKrvLPQX9fQD8PNgu9uYA8OXSfSrvuc2Fgj3aIm+S2QjrbGMaC9JNsMRAsk2qZ
         /nlKunPR1Q0lzK60X1dio9JHb/JFNlCEgMk0G8Pr0NXRmawDjGiG1DWMK3Pv2qK/PWTL
         7TZ2zK5xGfq8k6NiaUwRoyV36x9v5QPNbRzfjUWKIT++PcMUC5uIs2nITWPLY9buQPmF
         NYtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFyq3S9VRRMV5M1HtbnpoPzvJK3/34wNciFO3xwaEkXzNQ+ZS863Iuc5vbIjJSprEAvswvr5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/vwaQhvaFKxvrJkzJ0vxq4cNXgSnaG/2IcLnZSeLMBQRbdRd/
	rOgGJatgntTAT2N9umd5a3jSBHsc95zuEryQk0jFzu/Lo85lxav3BSES
X-Gm-Gg: ATEYQzxKv126+k2HBlKx3JGSy08efwHQfSUVqKWR5cIfJdixYGDI7B1Egd5Gx0of1Zv
	etIHDO3qxlHT4XvdY/oqW7Ffb642/JcpfsasgQObpgq3jeavt3fcxnlzihXwBJi4cXm/FKlb4C9
	uL+Z1RowVseKB4ipXEyFM+u4+7BtDHiy1gk661En4LxhED1AvuGdFXrirbsebzNvTvmZbT8zE+H
	p0pNPDPg2r8hbpI63c6tPB+mJkQuHY2h03P+RNBdIGVkQw3E6fSrjYNbMh1l8muEULIJKeM0y/V
	ozyDXeZyO3RK9EkUiXPhXKqMMLQ+tOwBUrqS1DA6NtiyV1ZfS75SeIxW5pKA/yW9BeVIoMQ6xJ0
	z+lCrGHoX2sYm3ctKavrqTGW/sCaeIKM3KR4Q+MaNlwGblRG+R1vL+XfmwlL6Al+qtKeT2a5Q8U
	v0nGzIayVd2gLOzcMPia4QYkMVdG6jIyi9j7AWDxT7i/GjCi1FkyFlLAHAnapTAdKoDIU+0q+4P
	9qM1tzbp48u59kx
X-Received: by 2002:a17:907:d204:b0:b9c:b3b:841c with SMTP id a640c23a62f3a-b9c13cc3796mr616696066b.47.1775153420973;
        Thu, 02 Apr 2026 11:10:20 -0700 (PDT)
Received: from ?IPV6:2a02:a03f:a75e:9a00:248c:6c47:3ce1:a121? ([2a02:a03f:a75e:9a00:248c:6c47:3ce1:a121])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3c99ec7csm116738466b.14.2026.04.02.11.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 11:10:20 -0700 (PDT)
Message-ID: <6bffeb6b-7d60-4f54-a592-3465d693f435@gmail.com>
Date: Thu, 2 Apr 2026 20:10:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: ioam: fix potential NULL dereferences in
 __ioam6_fill_trace_data()
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Yiming Qian <yimingqian591@gmail.com>
References: <20260402101732.1188059-1-edumazet@google.com>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260402101732.1188059-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274649-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A8D8D38CFA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/2/26 12:17, Eric Dumazet wrote:
> We need to check __in6_dev_get() for possible NULL value, as
> suggested by Yiming Qian.
> 
> Also add skb_dst_dev_rcu() instead of skb_dst_dev(),
> and two missing READ_ONCE().
> 
> Note that @dev can't be NULL.
> 
> Fixes: 9ee11f0fff20 ("ipv6: ioam: Data plane support for Pre-allocated Trace")
> Reported-by: Yiming Qian <yimingqian591@gmail.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Justin Iurman <justin.iurman@gmail.com>
> ---
>   net/ipv6/ioam6.c | 27 ++++++++++++++++-----------
>   1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/net/ipv6/ioam6.c b/net/ipv6/ioam6.c
> index 3978773bec424890cd18db78cf7cac9d3d652130..05a0b7d7e2aac35f634641fc4a791d1965dc85fd 100644
> --- a/net/ipv6/ioam6.c
> +++ b/net/ipv6/ioam6.c
> @@ -710,7 +710,9 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
>   				    struct ioam6_schema *sc,
>   				    unsigned int sclen, bool is_input)
>   {
> -	struct net_device *dev = skb_dst_dev(skb);
> +	/* Note: skb_dst_dev_rcu() can't be NULL at this point. */
> +	struct net_device *dev = skb_dst_dev_rcu(skb);
> +	struct inet6_dev *i_skb_dev, *idev;
>   	struct timespec64 ts;
>   	ktime_t tstamp;
>   	u64 raw64;
> @@ -721,13 +723,16 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
>   
>   	data = trace->data + trace->remlen * 4 - trace->nodelen * 4 - sclen * 4;
>   
> +	i_skb_dev = skb->dev ? __in6_dev_get(skb->dev) : NULL;
> +	idev = __in6_dev_get(dev);
> +
>   	/* hop_lim and node_id */
>   	if (trace->type.bit0) {
>   		byte = ipv6_hdr(skb)->hop_limit;
>   		if (is_input)
>   			byte--;
>   
> -		raw32 = dev_net(dev)->ipv6.sysctl.ioam6_id;
> +		raw32 = READ_ONCE(dev_net(dev)->ipv6.sysctl.ioam6_id);
>   
>   		*(__be32 *)data = cpu_to_be32((byte << 24) | raw32);
>   		data += sizeof(__be32);
> @@ -735,18 +740,18 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
>   
>   	/* ingress_if_id and egress_if_id */
>   	if (trace->type.bit1) {
> -		if (!skb->dev)
> +		if (!i_skb_dev)
>   			raw16 = IOAM6_U16_UNAVAILABLE;
>   		else
> -			raw16 = (__force u16)READ_ONCE(__in6_dev_get(skb->dev)->cnf.ioam6_id);
> +			raw16 = (__force u16)READ_ONCE(i_skb_dev->cnf.ioam6_id);
>   
>   		*(__be16 *)data = cpu_to_be16(raw16);
>   		data += sizeof(__be16);
>   
> -		if (dev->flags & IFF_LOOPBACK)
> +		if ((dev->flags & IFF_LOOPBACK) || !idev)
>   			raw16 = IOAM6_U16_UNAVAILABLE;
>   		else
> -			raw16 = (__force u16)READ_ONCE(__in6_dev_get(dev)->cnf.ioam6_id);
> +			raw16 = (__force u16)READ_ONCE(idev->cnf.ioam6_id);
>   
>   		*(__be16 *)data = cpu_to_be16(raw16);
>   		data += sizeof(__be16);
> @@ -822,7 +827,7 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
>   		if (is_input)
>   			byte--;
>   
> -		raw64 = dev_net(dev)->ipv6.sysctl.ioam6_id_wide;
> +		raw64 = READ_ONCE(dev_net(dev)->ipv6.sysctl.ioam6_id_wide);
>   
>   		*(__be64 *)data = cpu_to_be64(((u64)byte << 56) | raw64);
>   		data += sizeof(__be64);
> @@ -830,18 +835,18 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
>   
>   	/* ingress_if_id and egress_if_id (wide) */
>   	if (trace->type.bit9) {
> -		if (!skb->dev)
> +		if (!i_skb_dev)
>   			raw32 = IOAM6_U32_UNAVAILABLE;
>   		else
> -			raw32 = READ_ONCE(__in6_dev_get(skb->dev)->cnf.ioam6_id_wide);
> +			raw32 = READ_ONCE(i_skb_dev->cnf.ioam6_id_wide);
>   
>   		*(__be32 *)data = cpu_to_be32(raw32);
>   		data += sizeof(__be32);
>   
> -		if (dev->flags & IFF_LOOPBACK)
> +		if ((dev->flags & IFF_LOOPBACK) || !idev)
>   			raw32 = IOAM6_U32_UNAVAILABLE;
>   		else
> -			raw32 = READ_ONCE(__in6_dev_get(dev)->cnf.ioam6_id_wide);
> +			raw32 = READ_ONCE(idev->cnf.ioam6_id_wide);
>   
>   		*(__be32 *)data = cpu_to_be32(raw32);
>   		data += sizeof(__be32);

LGTM, thanks Eric.

Reviewed-by: Justin Iurman <justin.iurman@gmail.com>

