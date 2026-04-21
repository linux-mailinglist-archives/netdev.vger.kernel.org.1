Return-Path: <netdev+bounces-280005-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BpAGzUD52lI2wEAu9opvQ
	(envelope-from <netdev+bounces-280005-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 06:55:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B90134364FD
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 06:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD0E23011129
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 04:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47CB231836;
	Tue, 21 Apr 2026 04:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rp4E6Orr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9843818DB37
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 04:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776747313; cv=none; b=jIMbL2K89d0SnDmWgOubHKe25AK9f3jDKCd3LDQUqUNv0+8inhurPXs/RPD5S94c1b91AwpxVMx72nn+bWf0Gcwbx4oMe05Z8fJQ/Iooz2EatdNxdv0swj4MJ9JaKwgAupBb1Cw//0O4g5Ivx4c0dXV/8Gb/ZWigJxEfjNCbhBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776747313; c=relaxed/simple;
	bh=PEgvQn374iqDL5RrBmvD4euFmcfL03RSsN11ytKG2rc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PvHQUDgA57nARCizBTwcGBpoeUtoD/ZHr2sh2IjtUVSPwJyerQ0mbTGKk+cgv2Nz3Bfsem4ns86YwcMypQXfwti74kH+b44hL66Mcmfoi6EKeEbbVhcF9kWeux3tgKJACvlTSUDOVjKeawqA6HMYKx0QscvmAEn1Ffq/gfP9EYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rp4E6Orr; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82d40278103so2594136b3a.2
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 21:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776747312; x=1777352112; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fylDq0Vzqoenb8KNUYZJ5n/qedPO+TbraMzggxR1xlc=;
        b=Rp4E6Orr2aR3/lThshbVC1JT1xnTkNvWGW3xkhRGmhLEOflL9X9Tl5fYAC2ZzPGwWb
         g9xRWuFUCW93fkX+TFoohuX0ki3Yx7gXfBAltVWRU7fB7kdW2v0JgH6RR202BPAwMk2p
         4lx4+VI8FiQb5xb5WZxBoJn1zvbebtzctCBFuPSev1sVEgvuCENCKgS1LThbnpC+MSGY
         hvSoMfSwQEmBExDu54txmtAP14Fg4034tVTWBXTIcphqilFq00253ZFFRaKP5q2LfZ+t
         MBmW30n7r9l9YyWyvBg56jAVfuAUH4v5Ogi1473YtLlcd3vYnrw1Fx9q97zf3qcYkGDc
         FEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776747312; x=1777352112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fylDq0Vzqoenb8KNUYZJ5n/qedPO+TbraMzggxR1xlc=;
        b=VJqGpS9xNeDIqDU0o3lqYQDDeTPF1nA6aWl8y2mYHQQgAiSmx/zp+G5zR/YTLzqdUv
         JNduYuw7fXz3zd7k+cXYK1Ogh/VcpP5TpVGsZaVtdnWpggSgEoK+O95Tdb/grN0jfIJq
         cUG5Olz068d0N2YcDMHeQ3Hk+qLOKYeox8jWuAhevbJWNTN7TY6xxCcKpkMgoKZbgftt
         3MufmmmVFBycWXWD2Vr3YE+ZlSVZGEP8W11l+fLuUZ1GEQI0+G/QtuqhhHl5n45TwVJ3
         5IBOc67OtZjzXs5/UcepfHfpwGGG6K4+oz7xaFY+buotFVbEAAOXBjeAHRnE/KQlHciD
         qcGQ==
X-Forwarded-Encrypted: i=1; AFNElJ9hI0bmd6NnUWOwQO+I53w6abpuQIGSq0ueTWCY+idM2PjJ8KR2e/4fibb6BsEkeo3ni+iHsyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3/djq+F/SXp8BEnHBLAs7aA/UFNG4awdszWqMYFdKDiuRAg+Y
	Uirw0KOw6HzKam3l02rTRq0Epm+zCU689iJngYqomsWxWe3Ml1URP/m2eb6upZiQ2PebE8JlJgI
	tw09etw==
X-Received: from pfbhr17-n2.prod.google.com ([2002:a05:6a00:6b91:20b0:82f:b98c:2101])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d01:b0:82f:401f:2db7
 with SMTP id d2e1a72fcca58-82f8c82dda7mr15995145b3a.9.1776747311790; Mon, 20
 Apr 2026 21:55:11 -0700 (PDT)
Date: Tue, 21 Apr 2026 04:52:52 +0000
In-Reply-To: <2026042024-cabbie-gills-9371@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026042024-cabbie-gills-9371@gregkh>
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260421045510.1546375-1-kuniyu@google.com>
Subject: Re: [PATCH net] ipv6: rpl: expand skb head when recompressed SRH
 grows, not only on last segment
From: Kuniyuki Iwashima <kuniyu@google.com>
To: gregkh@linuxfoundation.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280005-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B90134364FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 20 Apr 2026 21:32:25 +0200
> ipv6_rpl_srh_rcv() processes a Routing Protocol for LLNs Source Routing
> Header by decompressing it, swapping the next segment address into
> ipv6_hdr->daddr, recompressing, and pushing the new header back. The
> recompressed header can be larger than the original when the
> address-elision opportunities are worse after the swap.
> 
> The function pulls (hdr->hdrlen + 1) << 3 bytes (the old header) and
> pushes (chdr->hdrlen + 1) << 3 + sizeof(ipv6hdr) bytes (the new header
> plus the IPv6 header).  pskb_expand_head() is called to guarantee
> headroom only when segments_left == 0.
> 
> A crafted SRH that loops back to the local host (each segment is a local
> address, so ip6_route_input() delivers it back to ipv6_rpl_srh_rcv())
> with chdr growing on each pass exhausts headroom over several
> iterations.

How could this occur.. ?  Did AI generate a repro or just
flagged the possibility ?

ipv6_rpl_sr_hdr.hdrlen >> 3 is the size of addresses in the
header and 1 >> 3 is the size of ipv6_rpl_sr_hdr itself, which
is pulled into skb_headroom in ipv6_rthdr_rcv().

In ipv6_rpl_srh_rcv(), the number of addresses is calculated
based on ipv6_rpl_sr_hdr.hdrlen, and when hdr->segments_left
is not zero in the "if" below, the new header has the exact same
size with the old header, so there should be no overflow.

Also, before the "if", ipv6_rpl_srh_rcv() calls

  skb_pull(skb, ((hdr->hdrlen + 1) << 3));

and after that,

  skb_push(skb, ((chdr->hdrlen + 1) << 3) + sizeof(struct ipv6hdr));

and if we jump to the looped_back label, it calls

  skb_pull(skb, sizeof(struct ipv6hdr));

So, I think the same size are pulled and pushed for each iteration
(except for segments_left == 0 case) even with local addresses.


> When skb_push() lands skb->data exactly at skb->head,
> skb_reset_network_header() stores 0, and skb_mac_header_rebuild()'s
> skb_set_mac_header(skb, -skb->mac_len) computes 0 + (u16)(-14) = 65522.
> The subsequent memmove writes 14 bytes at skb->head + 65522.
> 
> Expand the head whenever there is insufficient room for the push, not
> only on the final segment.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Reported-by: Anthropic
> Cc: stable <stable@kernel.org>
> Assisted-by: gkh_clanker_t1000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  net/ipv6/exthdrs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 95558fd6f447..d866ab011e0a 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -592,7 +592,9 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
>  	skb_pull(skb, ((hdr->hdrlen + 1) << 3));
>  	skb_postpull_rcsum(skb, oldhdr,
>  			   sizeof(struct ipv6hdr) + ((hdr->hdrlen + 1) << 3));
> -	if (unlikely(!hdr->segments_left)) {
> +	if (unlikely(!hdr->segments_left ||
> +		     skb_headroom(skb) < sizeof(struct ipv6hdr) +
> +					 ((chdr->hdrlen + 1) << 3))) {
>  		if (pskb_expand_head(skb, sizeof(struct ipv6hdr) + ((chdr->hdrlen + 1) << 3), 0,
>  				     GFP_ATOMIC)) {
>  			__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)), IPSTATS_MIB_OUTDISCARDS);
> -- 
> 2.53.0
> 

