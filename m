Return-Path: <netdev+bounces-281808-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NLWFKSb8Gl3WAEAu9opvQ
	(envelope-from <netdev+bounces-281808-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:36:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4D6483E85
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB76C303C331
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD5B3F7874;
	Tue, 28 Apr 2026 11:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cgUjOLwc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pQhWKqJg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9D23F54C3
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 11:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777375499; cv=none; b=dx2i2dtH/WYDZoMESLwqlStNhqvuKeEJDDGM+OzpfH/vtmZoD0cjw3UxVtP24rw1TR1m6aE8PYaoJbEpys8Teu7HpiR5Tywtz6AJL+zS7CcncKHilUi8v/U/GRveTcOpOqr7O5c+AJd+89wMyzPe7YY72KdK2X0FePoBDJtX6/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777375499; c=relaxed/simple;
	bh=dB/ynnwMrqlWTCloUoctRJBoyb577PU1lz+xaLW6ppY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPYsI/ECH2zwlWz74aJI3sV8GqjTHMqPky6KKxPIdrzaO9j4JMz8AGNL3soMEE8Xj+7Et+GOcyu5JTPqQGsc40KW5M+uNnRIY8Wed1/lgGZYMJG0467CVi8f7Fu3KQGnNWwOSahE8boEhp2VBrc8av1ip1FDFnvxVSKmlCR8bYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cgUjOLwc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pQhWKqJg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777375496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3jk6Fo1QHm8Ghha7OWGjPXMfwmrBwT2+lWSiFlXStk=;
	b=cgUjOLwcXR9Sex1BsF/4XWGOB8Ps1Wgf7yvL/MP2VKWvcxbrmjsjQ7SZEM2N3e5zD4h5kZ
	c7qMf+XawTyAiYW+RjZ+/swe0/uvh3Sgj3Ohu+CC7egDXKxja2+fZ4ByqXxRnlJ75VQvXW
	c+pI3oXjkmA+lrThp2bewcMxTYooh9Y=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-8zro8SnkP1G5Tk3CxQOO4w-1; Tue, 28 Apr 2026 07:24:55 -0400
X-MC-Unique: 8zro8SnkP1G5Tk3CxQOO4w-1
X-Mimecast-MFC-AGG-ID: 8zro8SnkP1G5Tk3CxQOO4w_1777375494
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8ac566014e0so78776136d6.2
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 04:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777375494; x=1777980294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q3jk6Fo1QHm8Ghha7OWGjPXMfwmrBwT2+lWSiFlXStk=;
        b=pQhWKqJg9MkPbVpLV85kcOciOz/4Hmn6nhjYIkZLMJULS7LyjJBWhpVIkHrUIfafxj
         2L+owSvt9ZdOn/TmfaSlAnlUX4+l/fxfYwYXSytNvwe+Pu1EjSQNUdk5tQjuNo7B3rtR
         9Bf9fvd3FKPviVPRuNdu16qtTamgRPOsA4yvBcdR+Akxgq3i+cOYnuOooW7nq8aDbehc
         KVCgPZrI5uuy+fBonIlh62vk5yd/RGxpYow9hGgrQEvkHXXcIAcmAFR1Tdg+BiUnCdEm
         N85RC9rUKhwRuxAGY8YpsX5DDrcnZ/7PAHfT8oiqmsWnRCD5B86zaDnjsqCbhO1tYOcf
         LNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777375494; x=1777980294;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q3jk6Fo1QHm8Ghha7OWGjPXMfwmrBwT2+lWSiFlXStk=;
        b=oQG/INXdFuhkH2fhK8sxZKMwyHTWC6qeBnepqQ+LIxnJGqJOA8zt4aVRGnOwnc8NY6
         JPgipMcOcDFLdkLHZF2K84ddJfeFFvGF6aZfL7yRj7rYa4Um32eZOQO0SXbijx5d2PRW
         vkXmmV8h7qfsZW72YvyCwe+Uot88reHO8L//+prw7HrFH/Ja4ZxCU3K5kioa5dF/B2k+
         VArUlcN3PMdqE+2tnd9eSmVAZhiKIr5e+fJ+ObZi7HaO5g/JBcaw8KU760LoQqptSWi0
         HZ0sUXGgM9zyzZnuSqG9rj8E9gndpLFwawR1tGCZ49o2Th+A3Kd0/rBYHIaZApcoK1+I
         +7MQ==
X-Gm-Message-State: AOJu0Yz6QVOUm2vtaLQjLv8JZS2nHW+fKa5e2fp9Beex0S70HNXogB+f
	QS7PzLGkaXXv4IdbP1q+ZEuOMfdQgQ0CGhLyEi4GUr/MFNdEVYRdw2DpU4Qr/OjERkESH5Cm69C
	4ofz15brR+lbKu0Ec3pKgFO2ZJdXhJSbJs9ZE9cEhlGpadbAaGdJI0MTVXw==
X-Gm-Gg: AeBDietXazBhygRU/iNxYAXTW2tjueD+aL6qT80TVzrZyXWnqP21ygYp1qPYW+nLouC
	tblmjSY2rTI96thrLeLmxSoBue8PaDnXVTvKdmKn2lXPj7H4qQHmYYsiau/ZT4WQCXttUCmtlc/
	l6AThJQPhFH24Dzfg7rn1jEly/hXoYj6fVXUN6l46fuKOvvTLrrzg9lKnmpTtezDG6ZzWiUzRfJ
	TtD6qKAma4GNObOTQJKWGqpLFUEFCg/5MAHECKwvdkTLARROkkFUlV6zQ4TgKZLViVl23KyAIKA
	wUq9MEXV/hJF5bdrGGVQKoJRZhJB7e+ZqwslRZ8AKNdZ1qRthIFsN/ck3AMM0ZIJRqPiLZrI9mi
	XMsoDW9Pf/kk4K8cWaiEnh2g8pDMkU5PbxlTconUKyxvCl8uJLwHZFmVHkIbF5F+0xg==
X-Received: by 2002:a05:6214:f05:b0:8a4:7977:e5fa with SMTP id 6a1803df08f44-8b3e307a767mr41663836d6.25.1777375494235;
        Tue, 28 Apr 2026 04:24:54 -0700 (PDT)
X-Received: by 2002:a05:6214:f05:b0:8a4:7977:e5fa with SMTP id 6a1803df08f44-8b3e307a767mr41663276d6.25.1777375493702;
        Tue, 28 Apr 2026 04:24:53 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.114])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3e28162easm18673876d6.3.2026.04.28.04.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 04:24:53 -0700 (PDT)
Message-ID: <d0cc3e95-f03d-4bed-b18f-0517f56b8f05@redhat.com>
Date: Tue, 28 Apr 2026 13:24:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] ipv6: validate extension header length before
 copying to cmsg
To: Qi Tang <tpluszz77@gmail.com>, "David S . Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260423103238.3987364-1-tpluszz77@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260423103238.3987364-1-tpluszz77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3B4D6483E85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-281808-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On 4/23/26 12:32 PM, Qi Tang wrote:
> ip6_datagram_recv_specific_ctl() builds IPV6_{HOPOPTS,DSTOPTS,RTHDR}
> cmsgs (and their IPV6_2292* legacy counterparts) by trusting the
> on-wire hdrlen byte (ptr[1]) when computing the put_cmsg() length.
> The length was validated only at parse time (ipv6_parse_hopopts(),
> etc.).  An nftables payload-write expression can rewrite hdrlen after
> parsing and before the skb reaches recvmsg; the write itself is
> in-bounds but put_cmsg() then reads up to ((hdrlen+1) << 3) = 2040
> bytes from an 8-byte header.  nftables is reachable from an
> unprivileged user namespace, so this is an unprivileged
> slab-out-of-bounds read:
> 
>   BUG: KASAN: slab-out-of-bounds in put_cmsg+0x3ac/0x540
>    put_cmsg+0x3ac/0x540
>    udpv6_recvmsg+0xca0/0x1250
>    sock_recvmsg+0xdf/0x190
>    ____sys_recvmsg+0x1b1/0x620
> 
> Add ipv6_get_exthdr_len() which computes the extension header length
> and validates it against skb_tail_pointer(skb), returning 0 on
> failure.  Extension headers are kept in the linear skb area by
> pskb_may_pull() during input, so skb_tail_pointer() is the correct
> bound.
> 
> Use ipv6_get_exthdr_len() at all non-AH call sites: the five
> standalone cmsg blocks (HbH, 2292HbH, 2292DSTOPTS x2, 2292RTHDR)
> and the three standard cases in the extension-header walk loop
> (DSTOPTS, ROUTING, default).  AH retains an inline bounds check
> because its length formula differs ((ptr[1]+2)<<2).
> 
> When the walk loop detects a corrupted header, return from the
> function instead of continuing to process later socket options.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Qi Tang <tpluszz77@gmail.com>
> ---
> Changes v2 -> v3:
>   - Resend as new thread (v2 was incorrectly sent as reply to v1)
> 
> Changes v1 -> v2 (Paolo Abeni):
>   - Factor repeated bounds-check + put_cmsg into ipv6_get_exthdr_len()
>   - Return from the function on corrupted walk-loop entry instead of
>     goto + empty label
> 
> v2: https://lore.kernel.org/netdev/20260423102255.3752004-1-tpluszz77@gmail.com/
> v1: https://lore.kernel.org/netdev/20260419150344.624673-1-tpluszz77@gmail.com/
> 
>  net/ipv6/datagram.c | 46 +++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 38 insertions(+), 8 deletions(-)
> 
> diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
> index 972bf0426d59..0a7b74d5f402 100644
> --- a/net/ipv6/datagram.c
> +++ b/net/ipv6/datagram.c
> @@ -617,6 +617,13 @@ void ip6_datagram_recv_common_ctl(struct sock *sk, struct msghdr *msg,
>  	}
>  }
>  
> +static u16 ipv6_get_exthdr_len(const struct sk_buff *skb, const u8 *ptr)
> +{
> +	u16 len = (ptr[1] + 1) << 3;

Sashiko notes that you should validate even this offset (1) before
accessing it.

You may also consider switching to pskb_may_pull().

/P


