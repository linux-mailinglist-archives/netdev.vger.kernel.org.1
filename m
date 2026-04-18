Return-Path: <netdev+bounces-279499-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNKFN8Z742nZHQEAu9opvQ
	(envelope-from <netdev+bounces-279499-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 14:40:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FD04211A1
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 14:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EC3D30263DA
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 12:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3E6346797;
	Sat, 18 Apr 2026 12:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lW+b8hC5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3CA2BEC2B
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 12:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776516034; cv=none; b=kkPEPmDRpoUVz4Ch0ZEDTErctyiZ6iDArHMlwb9n2rOX/uUJ5gza8pJny5JFdKDJz1lrL4cYwJyAS3v8inh98OgKIeqV2m7LGwH6s/sSFie+y1qrxY+H/PZMethX5xFnrnjrBQsBCdh+kj5bKKr9g7+KLPq3Bhdw7umCjS4JlII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776516034; c=relaxed/simple;
	bh=xGiWwgVaCqhdALzs+ir4Rla3GGRfhCHp0wxl7RXArYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r6xZTnszr19ytjGzYiIIBhKDirBErfcMbvdKFOG5HAs6Vl34+amnL7XmZrWOug5gnePqzUYZXrG+9HBkqHrS5buB37wPhGfV5HdjeSddO0qFFgg11oa0L9t+iSyigX68VNOYYIIfNVIjoQX7Hrm4i2gTIF1g7e5BMVVAdUOEe2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lW+b8hC5; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b9c6680aaf8so249257866b.3
        for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 05:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776516032; x=1777120832; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/q5eRUxQRg231brhP5YYym458K73wq0PWd6vzoPeO0Y=;
        b=lW+b8hC5fM8+iigJa+J4Rd9VzV/JcIvQixiuP24o3YCOBeLWTUdNpGQdRPDrw942QU
         9v6UHSBh5ln5KOqL7sVT32B2pPmJsfV9zeIeYOB8fLjlGCQM8vnJjQ5sMRk1nJfiXFld
         7leX0yl3C7veX0hKOeqY4kYRehlOgfKbZleWpoxdGjs9FAVv8FBPegrABxwlPCtKL8sD
         4WfMSwLqgbz4+KmLoOmwpPf4w47rtGm5TzsgyVvnY/tPudN53uEl8ywBmKWRpgq8DH3O
         kUHGxFpTVgf/BdkdbKDqaweMfpo1b/Kb8wV6P74FVrIOePTrlKck533I0Gmx++JwGJCT
         OW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776516032; x=1777120832;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/q5eRUxQRg231brhP5YYym458K73wq0PWd6vzoPeO0Y=;
        b=RBJBbZIEWUZzi16jMfFM1+N7mIxSuDk0/6CpbGYVeWsDymSJLzVoxErj+4recdmTmI
         3vuAiMHlshys88CPS+j07amPaB7Y7J09x2EsLuBOpbuWgOP4iRevpSdOYONEfXurm9gB
         oks1UWnB7vhfm6h/FVM54CU1E+R2zbvBuwPrnREDLHWO3Valy2uoACUyKPzCOUl8WSzd
         B0CLP3AfGgnrH/xWpN8wMgO/6dXjWaxfpXZdK7q3Xl3e5MWPpE+bPddgc5lZjSeUrV1F
         W3CLJEk/ic4Jd3q7tc/J8CtCAMGn8LYYnZVgA22BYzALtM4C7W1YtoRB6HNXQJe+x85v
         r2RA==
X-Forwarded-Encrypted: i=1; AFNElJ+Gz0nz29PcLYsC8zlDhx21YRnard1aD3Xtl/QlDfqddFOmPupskOupvBufGz9QZONqk6/I73A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkDsdMFf/GxZ+bjyocHidviJ++S9uvNuRFBNc08nil0QNC0Iwr
	7jAdHaglktlqwpzGOGx2fs3EsM1+rtUu0YHQ0dmHMfAD5OOp2mCtM4af
X-Gm-Gg: AeBDies+zQ/ZL2YBVcE6k10gexJXnpfAbPWGNdzC2gCG0moh/hPTamALq1VcMX4rgjH
	q+Kp8TYPqk3oufO/BkQUdi6KljXCVR3z1dPx3Jr6jgimPiXh9AI7E4pJUAu3BrSNj17TJviQJ+G
	t3GjEuEFErgXr1x6tRrdFZmYUABiHvwR+ZPzeWVU+2O5oVaAuoRu4W6CH1n76U/hXgIVJbBqhgd
	K57+LyqYe6/I9lQG7TS0w+YBN6DgviMAtBeUq43jpyf8ymNb0NPhv9t9Jo+S0JBPu87TpWt4bPx
	S3SSg6ELMiTiokZdZaHJ6EZxUiu6PIJrsqk+kL2xNoQMedSn9gTXLTOvbCF0XHRk7lj6cW8e1R9
	1dviuhM1UDYPMKlN/UNoZVHi6IRfGPwlMgZbru6y7rEtwMhykHZTBlWTtsTHy1pQkYTNuV4WFop
	L4Ayun4Kkk49PAL4uqA2cljBcVxuNkGmn5U6YosN8R6sebIIIoVHRGyfUHlHxKd2UDzBr+oBnpB
	0TgrIxv4L7YmRrK
X-Received: by 2002:a17:907:1c16:b0:ba3:22df:1f4 with SMTP id a640c23a62f3a-ba41b9d7be1mr348651566b.41.1776516031785;
        Sat, 18 Apr 2026 05:40:31 -0700 (PDT)
Received: from ?IPV6:2a02:a03f:a75e:9a00:5273:4380:96ab:9087? ([2a02:a03f:a75e:9a00:5273:4380:96ab:9087])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba45553e9e4sm161246666b.60.2026.04.18.05.40.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2026 05:40:31 -0700 (PDT)
Message-ID: <7c715640-5c20-4226-9c31-d2c5eef551db@gmail.com>
Date: Sat, 18 Apr 2026 14:40:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] ipv6: Apply max_dst_opts_cnt to
 ip6_tnl_parse_tlv_enc_lim
To: Daniel Borkmann <daniel@iogearbox.net>, kuba@kernel.org
Cc: edumazet@google.com, dsahern@kernel.org, tom@herbertland.com,
 willemdebruijn.kernel@gmail.com, idosch@nvidia.com, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20260418121538.706095-1-daniel@iogearbox.net>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260418121538.706095-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,herbertland.com,gmail.com,nvidia.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279499-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iogearbox.net:email]
X-Rspamd-Queue-Id: 55FD04211A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/18/26 14:15, Daniel Borkmann wrote:
> Commit 47d3d7ac656a ("ipv6: Implement limits on Hop-by-Hop and
> Destination options") added net.ipv6.max_{hbh,dst}_opts_{cnt,len}
> and applied them in ip6_parse_tlv(), the generic TLV walker
> invoked from ipv6_destopt_rcv() and ipv6_parse_hopopts().
> 
> ip6_tnl_parse_tlv_enc_lim() does not go through ip6_parse_tlv();
> it has its own hand-rolled TLV scanner inside its NEXTHDR_DEST
> branch which looks for IPV6_TLV_TNL_ENCAP_LIMIT. That inner
> loop is bounded only by optlen, which can be up to 2048 bytes.
> Stuffing the Destination Options header with 2046 Pad1 (type=0)
> entries advances the scanner a single byte at a time, yielding
> ~2000 TLV iterations per extension header.
> 
> Reuse max_dst_opts_cnt to bound the TLV iterations, matching
> the semantics from 47d3d7ac656a.
> 
> Fixes: 47d3d7ac656a ("ipv6: Implement limits on Hop-by-Hop and Destination options")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>   v1->v2:
>     - Remove unlikely (Justin)
>     - Use abs() given max_dst_opts_cnt's negative meaning (Justin)
> 
>   net/ipv6/ip6_tunnel.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> index 907c6a2af331..0f50b7fcb24e 100644
> --- a/net/ipv6/ip6_tunnel.c
> +++ b/net/ipv6/ip6_tunnel.c
> @@ -430,11 +430,16 @@ __u16 ip6_tnl_parse_tlv_enc_lim(struct sk_buff *skb, __u8 *raw)
>   				break;
>   		}
>   		if (nexthdr == NEXTHDR_DEST) {
> +			int tlv_max = abs(READ_ONCE(init_net.ipv6.sysctl.max_dst_opts_cnt));
> +			int tlv_cnt = 0;
>   			u16 i = 2;
>   
>   			while (1) {
>   				struct ipv6_tlv_tnl_enc_lim *tel;
>   
> +				if (tlv_cnt++ >= tlv_max)
> +					break;
> +
>   				/* No more room for encapsulation limit */
>   				if (i + sizeof(*tel) > optlen)
>   					break;

Thanks for v2, Daniel.

I'm still wondering: should we align the above parsing behavior with the 
one in ip6_parse_tlv() to keep things consistent? That is: don't 
increment tlv_cnt for Pad1/PadN, make sure we don't exceed 8 bytes per 
padding (consecutive Pad1's, or a PadN), and we could also check that a 
PadN payload is only made of zeroes. Open question...

Otherwise, LGTM:
Reviewed-by: Justin Iurman <justin.iurman@gmail.com>

