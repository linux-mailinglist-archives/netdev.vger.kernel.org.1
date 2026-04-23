Return-Path: <netdev+bounces-280666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNIiIMbc6WmNlwIAu9opvQ
	(envelope-from <netdev+bounces-280666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:48:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8EE44EBEC
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BA4E300CBCE
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 08:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A10382286;
	Thu, 23 Apr 2026 08:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Thd0PYsi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sZ9HH/wA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707012652B0
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 08:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776933960; cv=none; b=I9GKXE+Z47QXDRb7Vcs659Y7LeKHOwsu0RidfBSU9MFJeUJdsGlLPhnCLbNmVym4lfUxnRaCMkTdAt/F3yYuJp6yk8sFBBMtJlBgTuAP0gxq2WsR6dR1rNGCeg7KAjK92GOb6g5JC/UPftO99n2MQS1TaJIqlbueCOPI5z0kG4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776933960; c=relaxed/simple;
	bh=Hl3hSmH93Bqev331kDF8KjK2ERB5SGQ0m/HhaWWR8Dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O2PB19yGMdhkmMXJX2LfWx5wAQCvWKfuDs1WSRxi7rUIdUQgX9K/sUz4rqE7da7CJSPN7zQxxRrUA9MvuElszis0GeuU6fflf+chBexvMwn0k8cslqtx7aWHpPnQS92TBsYV+Zn6PnCiFNeB03Pdfm/TmZB4nMY2/fREaFL+Sow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Thd0PYsi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sZ9HH/wA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776933957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m1tx9VCvrtYdimdcJctan93WIkq+ToiKW1leQ49VU+c=;
	b=Thd0PYsimBEJ8EqaJHjolDMenuGCP1Yv1mJhqjU1nySIZEwfdSjBn2KIv5BsbpXEPkvhKt
	Z55pP1KfNOQjvAJH8Z01ck0V72WVTP5YsDxwKNwGlwSaF/VI4iXtFsjOVEPnAZHNPi0bND
	YST1azrCoHk1cFbLYcnVRsftj5SFMcc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-KetWKyY4N06UFlK2cSGyVw-1; Thu, 23 Apr 2026 04:45:56 -0400
X-MC-Unique: KetWKyY4N06UFlK2cSGyVw-1
X-Mimecast-MFC-AGG-ID: KetWKyY4N06UFlK2cSGyVw_1776933955
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48a5fb71a84so2615885e9.1
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 01:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776933955; x=1777538755; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m1tx9VCvrtYdimdcJctan93WIkq+ToiKW1leQ49VU+c=;
        b=sZ9HH/wAcgcTmgicHZx/TiQ/fpCYPkwMgGLhXiGmLy5EB/aYPprRomWi6GddpyWGO9
         qfW7+++yS5qubn9KUsZLqZiUPNqqJJlcRSB//dt2gBlE329Q5InOr3ve2lptCymWAMdv
         tfUbQYUZYu+oLZGx6XDykpFdmkZFoRbUx4wE+BOAPByIoMMwpxF+6HPnq/K0wTZJhhgf
         ctAA+YqTCPiJqOhEB4K6NuQ2WpShISR5ZUQL4cKi+3AReH/vkWDd9IBwiKpuOnuVNuFl
         hRsbpFZGVFBxqjHAVI0GVl4IMOVIqhJFD6jJ6OXnXscfkmg5iIKb7WRhovyl7nXmt77i
         SoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776933955; x=1777538755;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m1tx9VCvrtYdimdcJctan93WIkq+ToiKW1leQ49VU+c=;
        b=DxbBna8cbbKgtGwYZlbCFXbtTryNW/ERUzxgOzvArR5zG5AJHIIQqDbk9vpSkC9IPZ
         g2DqxNFZQEcn/eZ7XeqCOzIZpWjCnptnkrlBv5TGOMmdCxNwgM+Om8u2LOCP3YZtHgcb
         ZJUDOJTNYSiQanUzsCZ14E8vWf74Zy69M9d9x00vvcQsffl48DtIIXpjfWJMpBOSKyoy
         6HUA3+AIRdytiKRM8p8n0NOF1JvTX/f+KF5qhBEXIKOnBePIuCHigQKSLZF0KjIaNq3N
         j4jurcgtT24k4zd3jEeit1QEomJ5jrDJtMWVtiLEiQu5n14jxw0Xlkslp0OD0ap/zkRq
         9P6g==
X-Gm-Message-State: AOJu0Yy3kxLiMO9x81hvefoNpHq0A7TIsa7lQjDgN5h1MAEHCu9rbF3P
	v9borTSu5HPoq1b+Pvra5eIznW8jbCyrG0TKbdxijHF2LGCnqEJfJvR0waAGz93tyPlaMRNdxEP
	Lx9xnX/PeeHMIoWajWTSPg7dtC1y6esQgSqVn6WOV7vSYlfje38OvcmDFtQ==
X-Gm-Gg: AeBDieuHiHpxkqmEPi89V+cvg+1mbELvPPFnazGQNHX1liep2cwnyvJkl05dHkbERXb
	aK20UYEbQvKYggidTzXkX5REOwD35MP/TTTTEicxcmaW5Ul2T4q9D95cC2yscQ1Zlog90gmSAOl
	rpzqZb95sEj7m6IDDEzlehLkzoqINH/6Uo5o+ZnFRa8uyg7ZtKSrHGips+oceAQwLWohazfrSEk
	uxF0hOh7xW3j2BSPRyIa2IzJHtSvFTrVdaoyMdJKHYE5CHQgTEMJ9LVKGU/tWWJ7juDGtV5au0+
	96h3X31CuNF4ftq85CycW4Br9ROXXdh2cT2M9gPAsM9xhcyiAmmTyIRqmJXMJIKlPCpTAoRP58W
	uDu57u+c/vNkLuGOCTC1HkuS4wZeG9QQ53naldhBUNYW+P1gY+7GVoWx3QLaSJC9b1Fs=
X-Received: by 2002:a05:600c:1d05:b0:489:1baf:8c03 with SMTP id 5b1f17b1804b1-4891baf8d2cmr221491305e9.11.1776933954937;
        Thu, 23 Apr 2026 01:45:54 -0700 (PDT)
X-Received: by 2002:a05:600c:1d05:b0:489:1baf:8c03 with SMTP id 5b1f17b1804b1-4891baf8d2cmr221490965e9.11.1776933954462;
        Thu, 23 Apr 2026 01:45:54 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a55dc9f58sm415049885e9.6.2026.04.23.01.45.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 01:45:53 -0700 (PDT)
Message-ID: <01e90b44-88c8-4e29-86db-b9258d8271b2@redhat.com>
Date: Thu, 23 Apr 2026 10:45:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: validate extension header length before copying
 to cmsg
To: Qi Tang <tpluszz77@gmail.com>, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260419150344.624673-1-tpluszz77@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260419150344.624673-1-tpluszz77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-280666-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,kernel.org,google.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD8EE44EBEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/19/26 5:03 PM, Qi Tang wrote:
> ip6_datagram_recv_specific_ctl() builds IPV6_{HOPOPTS,DSTOPTS,RTHDR}
> cmsgs (and their IPV6_2292* legacy counterparts) by trusting the
> on-wire hdrlen byte (ptr[1]) when computing the put_cmsg() length.
> The length was validated only at parse time (ipv6_parse_hopopts(),
> etc.). An nftables payload-write expression can rewrite hdrlen after
> parsing and before the skb reaches recvmsg; the write itself is
> in-bounds but put_cmsg() then reads up to ((hdrlen+1) << 3) = 2040
> bytes from an 8-byte header. nftables is reachable from an unprivi-
> leged user namespace, so this is an unprivileged slab-out-of-bounds
> read:
> 
>   BUG: KASAN: slab-out-of-bounds in put_cmsg+0x3ac/0x540
>    put_cmsg+0x3ac/0x540
>    udpv6_recvmsg+0xca0/0x1250
>    sock_recvmsg+0xdf/0x190
>    ____sys_recvmsg+0x1b1/0x620
> 
> Clamp each cmsg length against skb_tail_pointer(skb) before calling
> put_cmsg(). Extension headers are kept in the linear skb area by
> pskb_may_pull() during input, so skb_tail_pointer() is the correct
> bound. The check is replicated at each call site (one HbH, four
> RFC2292 sites, and four switch cases in the DSTOPTS/RTHDR/AH walk)
> rather than hoisted out of the switch, to keep the fix minimal and
> backportable; a follow-up cleanup can factor it out. In the walk
> loop a failed check also aborts the walk, since subsequent offsets
> depend on the tampered length.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Qi Tang <tpluszz77@gmail.com>
> ---
>  net/ipv6/datagram.c | 35 ++++++++++++++++++++++++++++++-----
>  1 file changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
> index ca3605acb..a7b9f5a24 100644
> --- a/net/ipv6/datagram.c
> +++ b/net/ipv6/datagram.c
> @@ -643,7 +643,10 @@ void ip6_datagram_recv_specific_ctl(struct sock *sk, struct msghdr *msg,
>  	/* HbH is allowed only once */
>  	if (np->rxopt.bits.hopopts && (opt->flags & IP6SKB_HOPBYHOP)) {
>  		u8 *ptr = nh + sizeof(struct ipv6hdr);
> -		put_cmsg(msg, SOL_IPV6, IPV6_HOPOPTS, (ptr[1]+1)<<3, ptr);
> +		u16 hbhlen = (ptr[1] + 1) << 3;
> +
> +		if (ptr + hbhlen <= skb_tail_pointer(skb))
> +			put_cmsg(msg, SOL_IPV6, IPV6_HOPOPTS, hbhlen, ptr);

The patch looks functionally correct to me, but the above 3 statements
are repeated multiple times. You can put them in a local helper and
avoud a lot of duplicate code.

>  	}
>  
>  	if (opt->lastopt &&
> @@ -668,27 +671,37 @@ void ip6_datagram_recv_specific_ctl(struct sock *sk, struct msghdr *msg,
>  			case IPPROTO_DSTOPTS:
>  				nexthdr = ptr[0];
>  				len = (ptr[1] + 1) << 3;
> +				if (ptr + len > skb_tail_pointer(skb))
> +					goto ext_hdr_done;

The packet is corrupted, allowing processing of later rxopt requires the
IMHO not nice empty label. I think it would be better just returning
from this function.

/P


