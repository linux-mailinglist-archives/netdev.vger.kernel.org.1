Return-Path: <netdev+bounces-300744-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p7qzG7ybNWr41AYAu9opvQ
	(envelope-from <netdev+bounces-300744-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 21:42:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D40CE6A790E
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 21:42:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=c5jVUG8h;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300744-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300744-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC877300A50A
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 19:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BBB3B27EC;
	Fri, 19 Jun 2026 19:42:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB68138D68F
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 19:42:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781898167; cv=none; b=WmytcAuHdbgV7HuipsOjc1YA944ZmLB4ShETO2DcNC+v3DFXa0osTX4agfJjZb7QxRP01lH2NfodM58/6M8WLW0TUTEztWih5Rnkvv+WQ6Kkre9VxgkFpZe5N+4vV7w93SKy5Mxe1sO3b95shNkihmBrcHL/UqjUgj7jRhFealg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781898167; c=relaxed/simple;
	bh=m+b4fQy9zLt6qBxVNtMicZZhSVJtKAocJ60Ir7oCTbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QR1JjFCzDyvubHjyaVpek2Orm9qqE3w0MKiJLCTKRphWyYjGnRJi6jtnMaAgJuYvqW7rDwEBXOqpEjC5A/Cr3VXqJlTqIzpzvkfrhB+78cm0i3/NscTosrb5ySsnhWYg6Koap4YTvvDSFGSB1yRLlXXdq609z3xT/z2AoZkOzGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5jVUG8h; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490bb83a3f6so16461345e9.0
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 12:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781898164; x=1782502964; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l2FOt2xMVSD61mBdKIPdNZOLnnUXVz8M2JYOdHzDiWI=;
        b=c5jVUG8hPaqNBC4hdbFaJn+zu0tTXmxG90bVeQVkHNktySwCW9aYLKHbrPcDnhj8tC
         +MZEyyMZ1mazB7Gct3znU0yufejYCNU+EA8QaZDH8KquW2rjptoK/4fvePovI0QPdaJ4
         /SoHXcXPHQ6upYVQF2bK9pkJF40cNbI4ZEMyI1P33SjJslni/ogex0coYJ1nW4qM4nbF
         7v+T+Kfu7jeDNeJ+FeoNmySByirYOAhqAy4eeNMFApXeJi/8LlgWH3dFxzqO5kNIfJ1n
         K/vatGePbAaJVYQWmWpqZZPgCxQKNbgL7O5B2/dQWdqaXWQMwR+a062/bQeNJKUODJJ8
         mmzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781898164; x=1782502964;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l2FOt2xMVSD61mBdKIPdNZOLnnUXVz8M2JYOdHzDiWI=;
        b=blyhuYUvcbvCsHy1RfGEQbzLTO9PWlVlMiCb5skBL5l8eugdtlrmdsZ+/DlIBzUZ+m
         +bxzvTObhqXAYHTLs8tgyy8BXEnyMULIkBTK7tNomjmaoi+qfSUOH/73EwUFmhpYW7P7
         nTG/6UtUapTStrKDOSB4lmKWglM9K9/8IFuTY42I6uc0lt41PMaeGyXU4nbdLVpCuZnA
         1D3ittUOw3CxiRmMK7q925E6sRJAFH52L98I8gdr2D+AKtE2pHUOKKqnMn5IuLae9HdO
         ZWNhOHEC/zTEVIlPJy6iFYhhjIr2AJk/V971h+h9e2Ps5njlMTt80Gg5kYv29pEM+K0I
         5ZOw==
X-Forwarded-Encrypted: i=1; AFNElJ+9wWZ2ljShWspb0D4TsHsNFIR8s9W7p5TAmjzXNv5G82F0l3Z0yw6Nzy7UplcqM/Oe//GdPGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxecrbwQtmq24hu1kWR6u+ksPWfxfGGgB54jQkiMrYOcbqMfhBS
	rGkJ0Oi1UQjAynPctcnKKX8qbYsVXVFJj7nznEPOydgAhmNlkKNLVIkk
X-Gm-Gg: AfdE7cmuRfmZwmYtIQ/2LJqlsjD3Ga/Xb+sq5yW73qdXHjbOJOy5pYpvLOqjhVANMFC
	XRGDQIZYyI9Lt4RYrsyLwPsYT8/u/3v5kELCfWf6RagecT669J4DHjU3m+aCfovvihMaVyOsav9
	IBGXVOmWCi2CROb1UgXOw0kfD9qC3VqRGp7In7XQo+1twA/j1SZ8Cu7p3ZJwg1llYHoN5MAGbkm
	wZHGW47eYeEqYBF8Nz0noV+kiTx6DGc25S5mYuIFe5/KkTpcOf4wn50R/4SB1fbI6A5FFMkfKa6
	aPTFYGnSOwwUtX+gtSH1luw9o5sIft9WhjSnQ8OSL4R7J4PtHi+S96R7PX51AHw91nV/6I82vlQ
	mxZmJOZC2tzqNrlJ7gpjuXlLsppq5RYNjMRH7SwVJqUH3REvd9a1hyMvsWEuBjMijYWGJHe+l9o
	9Jb3udmsGaAGFXPZziOkl0KaRoBUai57Vcf/iyE6zKtW+XeqP2zzAq6F5eiSi3lH206Dc=
X-Received: by 2002:a05:600c:3550:b0:490:e913:6564 with SMTP id 5b1f17b1804b1-49249083bf1mr9671345e9.3.1781898164119;
        Fri, 19 Jun 2026 12:42:44 -0700 (PDT)
Received: from ?IPV6:2a02:a03f:a75e:9a00:29d8:afb1:8888:c7aa? ([2a02:a03f:a75e:9a00:29d8:afb1:8888:c7aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fcdd08esm53293745e9.0.2026.06.19.12.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 12:42:43 -0700 (PDT)
Message-ID: <0785bd89-fbde-45cc-9ade-6d769c57f418@gmail.com>
Date: Fri, 19 Jun 2026 21:42:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: ioam: fix type confusion of dst_entry
To: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20260618104336.48934-1-jiayuan.chen@linux.dev>
Content-Language: en-US
From: Justin Iurman <justin.iurman@gmail.com>
In-Reply-To: <20260618104336.48934-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300744-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justiniurman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D40CE6A790E

On 6/18/26 12:43, Jiayuan Chen wrote:
> IOAM uses a dummy dst_entry(null_dst) to mark that the destination should
> not be changed after the transformation. This dst is stored in the IOAM lwt
> state and may be passed to dst_cache_set_ip6().
> 
> However, the IPv6 dst cache path eventually calls rt6_get_cookie(), which
> treats the dst_entry as part of a struct rt6_info. Since the null_dst was
> embedded directly as a struct dst_entry in struct ioam6_lwt, this resulted
> in an invalid cast and rt6_get_cookie() reading fields from the wrong
> object.
> 
> In practice, the wrong cookie is not used while dst->obsolete is zero, but
> rt6_get_cookie() may also access per-cpu value when rt->sernum is
> zero. In this case, rt->sernum aliases ioam6_lwt::cache::reset_ts, which
> can become zero, making this a potential invalid pointer access.
> 
> Fix this by embedding a full struct rt6_info for the dummy IPv6 route and
> passing its dst member to the dst APIs.

Good catch, thanks!

> Fixes: 47ce7c854563 ("net: ipv6: ioam6: fix double reallocation")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Justin Iurman <justin.iurman@gmail.com>

