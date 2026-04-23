Return-Path: <netdev+bounces-280662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EXrL1TX6WmglQIAu9opvQ
	(envelope-from <netdev+bounces-280662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:24:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFE244E825
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D00A3305BDE8
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 08:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E9A3BED66;
	Thu, 23 Apr 2026 08:23:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FD33BED32
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 08:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776932592; cv=none; b=bSrVy5rm9pIWem4+VAt8l4RMBpgNx5OqUj7eyQ6ul0BNaLcMHxLcH5otrBqk2rSNrn2WGw75UtFm9TPsiutCmqjaJ31OmvrnvKIjn5YAB5HIl1hK3LtZgUvRh0MccuyZNI9SPoYQnHELGrVHSUsl/fmTupypbuPfJk4DiZA/Idc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776932592; c=relaxed/simple;
	bh=OuVhWkYoFR1uSY9kX6h2w077HPz8GUpg7bFRP75AdkM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=c1JTxXfnC+wtUNmV/zB6q1mK8yBjILcMRoPyiolkYKUOvyZeF5DQTeKY25lrnipsuwUiU71vl490Va2BhIpihTfPWcXOSTQd95j0k+/IkLbDzvRO1ZBV20Mo/6kmlnVMwtZyTzjYFdO+YpzzzQDBpDMGbss5CoLMCUEOArIlCiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-6961a3ba180so231594eaf.2
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 01:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776932589; x=1777537389;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w247/q97QzvcC14agKy5HCk9YHvwopdZ1ppEdRTa+cw=;
        b=gShJJxkT97bvfT6TCXduR2loQioi598a77lnKPGwF0GMhcV14160qnOnVyr+wvnQBr
         3NXDg3BKzS/KQE7DAUJjxvsl1RRfIHLwTJeyOGEi+he+y5NMPbhZsl252rfvepdZMu3w
         d2UztimvmTDC4ooA4T9wl6EVp1YgTCmGthJgwO9qvRCnUaRAQ2anfmDScmJPNIWdXxkQ
         mpJR3GYsNMWRWwYuoxqYkLW1+ChunEMZoIw4Qs4EVn8s7I64Ik3pITWt80lctfajIQgB
         KB4mzWuH2P2wdFhpijQZcsi7xkG7hPq9QKR9SbcFSbOVW3ScGmj+k3G89CSBdAYgXK8Z
         0UIg==
X-Forwarded-Encrypted: i=1; AFNElJ9d41GP9NXqOaQOFpNw8QOJAdT62izUlI8FDkstVymdsy5Za3rJiTgee2dE3NjN0L6wy1x5Pwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxezMDaPjAvPdVsJ6Kpf0kwXl55bxtIdu6ar/Q8UmOBag1oYoD6
	X9T9tpKfaibVOQWzhjXyiP3Gk3OWe33nJ3dTdlTY+mzF2fNogANpbIGth/ztHzpmnkmNGUD8SwT
	WCYWMuhRxyJyI++HZsAspLn0WGbc2i6pCLoCFP/mZvqvKMgA0dNOOiQLE8qY=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1ca5:b0:694:914a:ebe1 with SMTP id
 006d021491bc7-694914af143mr7662434eaf.47.1776932588922; Thu, 23 Apr 2026
 01:23:08 -0700 (PDT)
Date: Thu, 23 Apr 2026 01:23:08 -0700
In-Reply-To: <20260423082233.514056-1-25181214217@stu.xidian.edu.cn>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69e9d6ec.a00a0220.9259.0025.GAE@google.com>
Subject: Re: [PATCH v2] ipv6: fix memory leak in __ip6_make_skb() when queue
 is empty
From: syzbot <syzbot@syzkaller.appspotmail.com>
To: 25181214217@stu.xidian.edu.cn
Cc: 25181214217@stu.xidian.edu.cn, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	sd@queasysnail.net, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [4.94 / 15.00];
	SEM_URIBL(3.50)[xidian.edu.cn:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[stu.xidian.edu.cn,davemloft.net,kernel.org,google.com,vger.kernel.org,redhat.com,queasysnail.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-280662-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,meta];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: CBFE244E825
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> During fuzzing with failslab enabled, a memory leak was observed in the
> IPv6 UDP send path.
>
> The root cause resides in __ip6_make_skb(). In extremely rare cases
> (such as fault injection or specific empty payload conditions),
> __ip6_append_data() may succeed but leave the socket's write queue
> empty.
>
> When __ip6_make_skb() is subsequently called, __skb_dequeue(queue)
> returns NULL. The previous logic handled this by executing a 'goto out;',
> which completely bypassed the call to ip6_cork_release(cork).
>
> Since the 'cork' structure actively holds a reference to the routing
> entry (dst_entry) and potentially other allocated options, skipping
> the release cleanly leaks these resources.
>
> Fix this by introducing an 'out_cork_release' label and jumping to it
> when skb is NULL, ensuring the cork state is always properly cleaned up.
> The now-unused 'out' label is also removed to prevent compiler warnings.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+e5d6936b9f4545fd88ab@syzkaller.appspotmail.com
> Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> ---
>  net/ipv6/ip6_output.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 7e92909ab5be..82210dd5eb96 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -1934,7 +1934,7 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
>  
>  	skb = __skb_dequeue(queue);
>  	if (!skb)
> -		goto out;
> +		goto out_cork_release;
>  	tail_skb = &(skb_shinfo(skb)->frag_list);
>  
>  	/* move skb->data to ip header from ext header */
> @@ -1998,8 +1998,8 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
>  		ICMP6_INC_STATS(net, idev, ICMP6_MIB_OUTMSGS);
>  	}
>  
> +out_cork_release:
>  	ip6_cork_release(cork);
> -out:
>  	return skb;
>  }
>  
> -- 
> 2.34.1
>

I see the command but can't find the corresponding bug.
The email is sent to  syzbot+HASH@syzkaller.appspotmail.com address
but the HASH does not correspond to any known bug.
Please double check the address.


