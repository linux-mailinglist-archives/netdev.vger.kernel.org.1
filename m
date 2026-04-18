Return-Path: <netdev+bounces-279487-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LGWBX5k42n5GAEAu9opvQ
	(envelope-from <netdev+bounces-279487-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 13:01:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A7461420CE2
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 13:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4F77304729B
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 10:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF3235F18F;
	Sat, 18 Apr 2026 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsytzas8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C2C35CB6B
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 10:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776509947; cv=none; b=IVd+cAYk/os5vF8aJecZ9wXJiH9fVLXIT2Mdk1pGsSO4xejrkFvbIOkD20+eYPZHnz54qTAmhQ/FuF466kXc+AIH8Ivy7YWtbc/LBuF2zNTyL36uLbmj0EwiTlHyS4kEK0LBh5QOCJN5xtT1+mvZhDsL5kdwyoGMfbtHWmT0d0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776509947; c=relaxed/simple;
	bh=GEfn2cvUXCZYu8R3K/hHuva9mqWVpe6oUwR+lZao2Gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BeaDxWMrV3Lz91b013LS6ExXhkg8RLzrOMnJ3F/nHWdR6U3x2N4T+PCZKyo4cU/Y2bN25HowTyTk7xCKMb5ZZFcIt3Le2og5EyzfrStBiyK6GBaujWawFRZXcCq0pYf1ekGkYE7hpthfU0MuAYs0k9k1oMk+Yn/hGHLodHFE3jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsytzas8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso13844265e9.3
        for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 03:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776509944; x=1777114744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vnBuFIUCfikb5ub/f9rRSioO6vPlb9VFmQqFga+l/6Y=;
        b=gsytzas85Am8f+juTKEPhjE/xOwLHKMssq46OGtn9GxMCl2smuDYgipttJV7W5ugvd
         FonhKvFIxbiK1xH3N4GRYW5uXrNb1RhuWgncZn63PUBbAFTOAZmI11Ld0lZFYPuGj4L8
         W5pkcd9u7pcEtOsTWYNy17mAV04Z9JjJ6Ye/w++WCxzd4S7HUfoxaO5ry0JfvJlhyB0I
         D3hFUZX0prsf4nMkxzeCOAxrFzSTHDD/q2pCr0R55XquMSuJ6/E9a3dx+otSx9CuK0wp
         xkctcS/b/nH8kYO9xWIu+aaqXFj6zZKwpWT2NJWnVmQ1WR2dRJAq8WwWWlxmsKfpTjna
         cT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776509944; x=1777114744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vnBuFIUCfikb5ub/f9rRSioO6vPlb9VFmQqFga+l/6Y=;
        b=Jd5khyQesYO6ntaoQD0LiAGBwzPYAtfPtz8benIR9Mn8SXeaEzFfki8rh7LBxWI/q/
         keKouqYqDpYByOwJ90mATCh20kV0pIpM+vsF03bYuQISb3UPVvlB6RHcf1LwUy7dyO64
         32SAQ6a5TwRkvjlRgFZBLq22YwwCGzkvST4BqZrM7o4NYCN5EDKGV4YXlq3oWvVG2eIj
         yb+R80ncHSomrV6lsx8UGFLmaCkbErhrh/xQvdpBkb7faw1SSemFPlZGJ6Or49d1e58E
         ehk68zmjExX9I5nhn9o7EvU+0yHz7/7LM/hq3L+RDUjCyC+s8IEA79HTqoSGwFyCWj5+
         JOnQ==
X-Forwarded-Encrypted: i=1; AFNElJ9p1tEvT5WW+yuCZWZhEYipZl3kff+FNr7d/OwJFE8kbO8R65lp+hF1sMc1Ua7b+OXKxCWRb9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqphOGmSHzoDkbZuCF4H6x+OGs8wnB6+c/tJG0/0nRPah0qRRT
	5hFxhXZzVBQMLJIMUdQNLJL+s4R2H54OwtK7HZYJxSrzDadksNnCvkGv
X-Gm-Gg: AeBDieuVPaw63tFYPiGgiq2uQKR5sOCUhqrmJMOW4D+SKbKyVzKbm4+n6o6j7hIEvap
	bhtQI0m5Hy/yyBPK4+qy+K2hB7zoeaDons6HfN2ODNh7pnidlq8e5t0mebYwLRobhE/LQOZoTLo
	ZO/XI1AKbA3g74AEMRHsQYJCNn2CbZavwo7vxf709mNRFQtZPMnIdS7UArtjjNsL8LX3V4Oza0o
	NWtgJ1oGOD5bgHLzUXzoPgfgn8zKZQN+DzMOrKwkvZmira6eso+Ijp205Pj82edc1jxEf9J7mH2
	d8qIrAoEK3JQlNiI3J4950LuXgZQ8cMQJkQoBlEuVDEj89HrczR2FfSccii95SD35/4RjmGM2Rz
	r95tR41Ir8tpKkf2V0UIhTx+nCIgmETXCm7n3syuolhYGwd6yZtoZtRl4xP/diI9Qtu13ZZlDMt
	0ueZgUfpjbsHyOE440cum93eLupa3KnOd6mybt9HGgGPUmYkgelHunw3Lw+3EAfrzIoOAJPIGwV
	gbNyvuwr1rnelzR
X-Received: by 2002:a05:600c:a413:b0:485:419c:4eba with SMTP id 5b1f17b1804b1-488fb73d229mr67979495e9.1.1776509943863;
        Sat, 18 Apr 2026 03:59:03 -0700 (PDT)
Received: from ?IPV6:2a02:a03f:a75e:9a00:5273:4380:96ab:9087? ([2a02:a03f:a75e:9a00:5273:4380:96ab:9087])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a341sm13236059f8f.24.2026.04.18.03.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2026 03:59:03 -0700 (PDT)
Message-ID: <acee197f-1821-4304-8759-a02ac1d5c808@gmail.com>
Date: Sat, 18 Apr 2026 12:59:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: Apply max_dst_opts_cnt to
 ip6_tnl_parse_tlv_enc_lim
To: Daniel Borkmann <daniel@iogearbox.net>, kuba@kernel.org
Cc: edumazet@google.com, dsahern@kernel.org, tom@herbertland.com,
 willemdebruijn.kernel@gmail.com, idosch@nvidia.com, pabeni@redhat.com,
 netdev@vger.kernel.org
References: <20260417220358.693101-1-daniel@iogearbox.net>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260417220358.693101-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,herbertland.com,gmail.com,nvidia.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279487-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,iogearbox.net:email]
X-Rspamd-Queue-Id: A7461420CE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/18/26 00:03, Daniel Borkmann wrote:
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
>   net/ipv6/ip6_tunnel.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> index 907c6a2af331..0ab76f93c136 100644
> --- a/net/ipv6/ip6_tunnel.c
> +++ b/net/ipv6/ip6_tunnel.c
> @@ -430,11 +430,16 @@ __u16 ip6_tnl_parse_tlv_enc_lim(struct sk_buff *skb, __u8 *raw)
>   				break;
>   		}
>   		if (nexthdr == NEXTHDR_DEST) {
> +			int tlv_max = READ_ONCE(init_net.ipv6.sysctl.max_dst_opts_cnt);
> +			int tlv_cnt = 0;
>   			u16 i = 2;
>   
>   			while (1) {
>   				struct ipv6_tlv_tnl_enc_lim *tel;
>   
> +				if (unlikely(tlv_cnt++ >= tlv_max))
> +					break;
> +
>   				/* No more room for encapsulation limit */
>   				if (i + sizeof(*tel) > optlen)
>   					break;

Good point on reusing max_dst_opts_cnt in ip6_tnl_parse_tlv_enc_lim(), 
but this patch is not ready yet.

We need to be careful: max_dst_opts_cnt can be negative. If this is the 
case, ip6_tnl_parse_tlv_enc_lim() would probably return 0, which is not 
what we want here. From the doc:

max_dst_opts_number - INTEGER
         Maximum number of non-padding TLVs allowed in a Destination
         options extension header. If this value is less than zero
         then unknown options are disallowed and the number of known
         TLVs allowed is the absolute value of this number.

         Default: 8

Since ip6_tnl_parse_tlv_enc_lim() does not check for specific option 
types (e.g., Pad1, PadN, you-name-it) and does not differentiate known 
from unknown options during parsing, I would simply use the absolute 
value of max_dst_opts_cnt by default.

Also, I wouldn't use unlikely() because it could harm us more than it 
helps in this specific context (consistent with ip6_parse_tlv()).

