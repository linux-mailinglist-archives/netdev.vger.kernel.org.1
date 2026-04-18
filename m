Return-Path: <netdev+bounces-279557-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJdZKLgH5GmVPAEAu9opvQ
	(envelope-from <netdev+bounces-279557-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 00:37:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 060CD4227F0
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 00:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 620A630071F3
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 22:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F6B363C6A;
	Sat, 18 Apr 2026 22:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgRqYLnD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A08035C1BD
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 22:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776551861; cv=none; b=oldSTIEH0UGB64L/R2fGP3SLeogZgTJFR1RsRoT3Ltp2xtd7Q1AB6wb8YJIL5FkNPukn6Cq8+8o7CeQlS/x/mEbKYiL/9Zt8eOANrCzm5U0Trema7lhfsiFmNSPjjc3PhdssCj75rDnw0F6FSIApQaFgroIEmBhWmUjJr8Kr0+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776551861; c=relaxed/simple;
	bh=q8GTTSTDWQVwJSglC5lud168I/awSIg1vjHACFAXyjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YzSrbpNjcHYHrLZWu+n2MZJ60oPOg+Nw4zw+f+oXKi3eWSEjj7bFvMD9imcxZ6AKhhPvEKAyXXcANh+NlfHz48yHgBIpoK9Wl6Ex3+yuvdEQRXSlo9rLb1Wp/Dk2bfm8nylwzNoMghDZq1xTwh9FpCmjrL6vhCFL7isdkdP3vbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgRqYLnD; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso15921625e9.3
        for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 15:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776551857; x=1777156657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RTdnULj81eGG7Oisgea77vWusJQ8j5guInO38oE50FI=;
        b=fgRqYLnDDRZ6qQc162YmQrVa6bce4/WsiJghSCf0yxfMZU+qGl+s0vfD3bohPxKTdB
         VFgClhPcIf3LHFiISg9QeVA48s3Zf2LDchC5pHOJ0F02VpKlNjbf2gPWAsj088AsA1Y3
         L5YlJ+18r9ywGaG5fJxw7gYzCDHMU4F3nYsh7c/a6mmfhLIbePHhqC0WXvDCptdRcTcf
         lN9gNnexNqnX7cz5vnUdUqyCnnfzvpGlvpm687KUGTYfSW5sBMWOBI28a1qtfeVvlqOe
         velVR1hnqO+yuzjUzZ97FAfLzXbI3h/hmZp9rSBpg49RRuYnX0nZgVQpYDgpsgtYXrdD
         6euw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776551857; x=1777156657;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RTdnULj81eGG7Oisgea77vWusJQ8j5guInO38oE50FI=;
        b=Nisw2WrvZ3fc4u/spryOi3B91vQshvs71UXY5Pai23sHGIkbG+REijdPq50ww+ojdD
         tActrJzfpkGFtjMfApeJU86qtuccct9ZKM8tJuAEGSNDpqLC6ZUyzmb7p71MgQAdi5SG
         0R1fm8IKs/5bYppHC7oauUgCiYoKegeciZJmBSMQa3d1/SzS/jf3dUwBtsCw0ElMADpX
         AetbuNFILm1DCgYDBNxxiFpBMUdB8YcHQ8y0zbQO/umAmumvnIi/QgaDDGsSOCpMd/ag
         bNUHn+V9fxXOTmRw0BUgLK04W1TnyTB+wSToq9IGWs9KQurwD03tzN9YAgiO/8gxB3hX
         5Biw==
X-Forwarded-Encrypted: i=1; AFNElJ8g94NagDvVitKDzzyu5nbHoDOUa4LB5QCkDOFt0EK1bk2SKNuVO5/jLOpG7QrSoHwU3hAXK6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfoAcvhVuiWLEPPn5KLEwLPJ6wmXHNxK0QT8rzK5d4irik4kck
	zcXEgNstGTTqgP9upsciR85WDrFFuFZQ1wp79tC+pGC472BuUWC9Clmz
X-Gm-Gg: AeBDiesAfksC5BMX7efvjqqFrcswXb3kGdBRKUUC+YMWaSzoz0m6yC6AURNJCj9vNAE
	AWcACfX5rnuE4jud5MM6kUwhCyGqv4WBInyMxbOv+ly58mm9Aocbb7zGnpSIONUs6v4qRLCOyMR
	gPj61hef6oxPaD7s4Nta/mPu+UcecytBoedDOiuYC4bLHx7YbTplWmw3M5NPQpgzUdrhgXRc+5n
	chr0OCdBk28uncnTyJsm4lTspjyCw4ErOO0clUjUtSEU+1iLUIVTbeS7jz+LSoxuPvu7W9Y3RKU
	m+iFfS0NFRKnQiBSpot8Q7Hm/0Vkv2iNJ1tueB19bLTmVNTSZUh7h63/sH8IDe0Bb+6UvDpHzgt
	CWTi+kuHaLQvba5fSwDpDAeACJ5oXGqJ2gyKsyzYG7Mh8ioUe/c2QiZHC84xB3BfoWTHzspN1AN
	XyK/Pk92RrSdj1f4Tgo0/lLky34FkgAbL0G1iZrBLxJeZRnGku8ozoRiJ4htGKrokmKqQ9WcGbB
	7epZ++J2TEVEBqc
X-Received: by 2002:a05:600c:1c1c:b0:486:f4d2:eac6 with SMTP id 5b1f17b1804b1-488fb74dcf3mr118579515e9.13.1776551857149;
        Sat, 18 Apr 2026 15:37:37 -0700 (PDT)
Received: from ?IPV6:2a02:a03f:a75e:9a00:5273:4380:96ab:9087? ([2a02:a03f:a75e:9a00:5273:4380:96ab:9087])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc13938fsm242024365e9.10.2026.04.18.15.37.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2026 15:37:36 -0700 (PDT)
Message-ID: <8fdf517b-6217-4df6-8adf-0c79ce8d3be8@gmail.com>
Date: Sun, 19 Apr 2026 00:37:35 +0200
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
 <7c715640-5c20-4226-9c31-d2c5eef551db@gmail.com>
 <d8d60970-6f73-4b9d-8808-76f4f8023100@iogearbox.net>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <d8d60970-6f73-4b9d-8808-76f4f8023100@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,herbertland.com,gmail.com,nvidia.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279557-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iogearbox.net:email]
X-Rspamd-Queue-Id: 060CD4227F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/19/26 00:19, Daniel Borkmann wrote:
> On 4/18/26 2:40 PM, Justin Iurman wrote:
>> On 4/18/26 14:15, Daniel Borkmann wrote:
>>> Commit 47d3d7ac656a ("ipv6: Implement limits on Hop-by-Hop and
>>> Destination options") added net.ipv6.max_{hbh,dst}_opts_{cnt,len}
>>> and applied them in ip6_parse_tlv(), the generic TLV walker
>>> invoked from ipv6_destopt_rcv() and ipv6_parse_hopopts().
>>>
>>> ip6_tnl_parse_tlv_enc_lim() does not go through ip6_parse_tlv();
>>> it has its own hand-rolled TLV scanner inside its NEXTHDR_DEST
>>> branch which looks for IPV6_TLV_TNL_ENCAP_LIMIT. That inner
>>> loop is bounded only by optlen, which can be up to 2048 bytes.
>>> Stuffing the Destination Options header with 2046 Pad1 (type=0)
>>> entries advances the scanner a single byte at a time, yielding
>>> ~2000 TLV iterations per extension header.
>>>
>>> Reuse max_dst_opts_cnt to bound the TLV iterations, matching
>>> the semantics from 47d3d7ac656a.
>>>
>>> Fixes: 47d3d7ac656a ("ipv6: Implement limits on Hop-by-Hop and 
>>> Destination options")
>>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>>> ---
>>>   v1->v2:
>>>     - Remove unlikely (Justin)
>>>     - Use abs() given max_dst_opts_cnt's negative meaning (Justin)
>>>
>>>   net/ipv6/ip6_tunnel.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
>>> index 907c6a2af331..0f50b7fcb24e 100644
>>> --- a/net/ipv6/ip6_tunnel.c
>>> +++ b/net/ipv6/ip6_tunnel.c
>>> @@ -430,11 +430,16 @@ __u16 ip6_tnl_parse_tlv_enc_lim(struct sk_buff 
>>> *skb, __u8 *raw)
>>>                   break;
>>>           }
>>>           if (nexthdr == NEXTHDR_DEST) {
>>> +            int tlv_max = 
>>> abs(READ_ONCE(init_net.ipv6.sysctl.max_dst_opts_cnt));
>>> +            int tlv_cnt = 0;
>>>               u16 i = 2;
>>>               while (1) {
>>>                   struct ipv6_tlv_tnl_enc_lim *tel;
>>> +                if (tlv_cnt++ >= tlv_max)
>>> +                    break;
>>> +
>>>                   /* No more room for encapsulation limit */
>>>                   if (i + sizeof(*tel) > optlen)
>>>                       break;
>>
>> Thanks for v2, Daniel.
>>
>> I'm still wondering: should we align the above parsing behavior with 
>> the one in ip6_parse_tlv() to keep things consistent? That is: don't 
>> increment tlv_cnt for Pad1/PadN, make sure we don't exceed 8 bytes per 
>> padding (consecutive Pad1's, or a PadN), and we could also check that 
>> a PadN payload is only made of zeroes. Open question...
> 
> Hm, so it would be sth like the below on top of this one, I'd wish we 
> wouldn't
> have to open code another ip6_parse_tlv().
> 
> Have you seen such cases with the encap limit in the wild (vs encap 
> limit as
> first tlv) where a stack places leading Pad1/PadN before encap limit 
> which the
> v2 patch wouldn't catch?

Nope. But if it happens, users would be confused as max_dst_opts_cnt 
would not have the same meaning in two different code paths. OTOH, I 
agree that such situation would look suspicious. I guess it's fine to 
keep your patch as is and to not over-complicate things unnecessarily.

>   net/ipv6/ip6_tunnel.c | 42 +++++++++++++++++++++++++++++++-----------
>   1 file changed, 31 insertions(+), 11 deletions(-)
> 
> diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> index 0f50b7fcb24e..1fa42a1cd97c 100644
> --- a/net/ipv6/ip6_tunnel.c
> +++ b/net/ipv6/ip6_tunnel.c
> @@ -432,28 +432,48 @@ __u16 ip6_tnl_parse_tlv_enc_lim(struct sk_buff 
> *skb, __u8 *raw)
>           if (nexthdr == NEXTHDR_DEST) {
>               int tlv_max = 
> abs(READ_ONCE(init_net.ipv6.sysctl.max_dst_opts_cnt));
>               int tlv_cnt = 0;
> +            int padlen = 0;
>               u16 i = 2;
> 
> -            while (1) {
> -                struct ipv6_tlv_tnl_enc_lim *tel;
> +            while (i < optlen) {
> +                struct ipv6_tlv_tnl_enc_lim *tel =
> +                    (struct ipv6_tlv_tnl_enc_lim *)(skb->data + off + i);
> +                int tel_len;
> 
> -                if (tlv_cnt++ >= tlv_max)
> +                if (tel->type == IPV6_TLV_PAD1) {
> +                    if (++padlen > 7)
> +                        break;
> +                    i++;
> +                    continue;
> +                }
> +
> +                if (i + 2 > optlen)
> +                    break;
> +                tel_len = tel->length + 2;
> +                if (i + tel_len > optlen)
>                       break;
> 
> -                /* No more room for encapsulation limit */
> -                if (i + sizeof(*tel) > optlen)
> +                if (tel->type == IPV6_TLV_PADN) {
> +                    padlen += tel_len;
> +                    if (padlen > 7)
> +                        break;
> +                    if (memchr_inv((u8 *)tel + 2, 0,
> +                               tel->length))
> +                        break;
> +                    i += tel_len;
> +                    continue;
> +                }
> +                padlen = 0;
> +
> +                if (tlv_cnt++ >= tlv_max)
>                       break;
> 
> -                tel = (struct ipv6_tlv_tnl_enc_lim *)(skb->data + off + 
> i);
>                   /* return index of option if found and valid */
>                   if (tel->type == IPV6_TLV_TNL_ENCAP_LIMIT &&
>                       tel->length == 1)
>                       return i + off - nhoff;
> -                /* else jump to next option */
> -                if (tel->type)
> -                    i += tel->length + 2;
> -                else
> -                    i++;
> +
> +                i += tel_len;
>               }
>           }
>           nexthdr = hdr->nexthdr;


