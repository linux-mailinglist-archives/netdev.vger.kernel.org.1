Return-Path: <netdev+bounces-305183-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3Z2YEBYETGpMewEAu9opvQ
	(envelope-from <netdev+bounces-305183-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 21:37:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C858B715107
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 21:37:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=WAvrRO0w;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305183-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305183-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D716312A073
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 18:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A890414A03;
	Mon,  6 Jul 2026 18:10:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491233AE712
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 18:10:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783361428; cv=none; b=W+lOdkqcCJ23h78PKSuh6YNlG7vBomg3hgbZN6w5SnGrc9yDvfwbCeppf8qCsfzR0ARDrhurAK+K9q7u7x1XFdwb0uLkeO76EtgTFMFN/PCeAXgzBWmqLMAoVDdOT+Yi1rYcXR6W4J1uDXXlVcBkqbECn66IumLbg52zI2m/XmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783361428; c=relaxed/simple;
	bh=ObiSmLx1vp3nTPUnHoufN7msYecVmO+SBh33oVQIJEg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=NyoQAtLHuHi5A6rcaUXm6qT/lQTnGpz8WXiAYaEzp2MtRza9EMxMOmnCGnZG0epSQ9n9CfE5BjEs/337m6/Ulz+rL7n61gEjhZ7FUql70cjrRZltpzDolBd4aqPAeomQVGNJl4zWsZjK0b32utMLo39zZX+TdSb72NXT75/HL2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAvrRO0w; arc=none smtp.client-ip=209.85.128.182
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-80bb8287d99so41737117b3.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 11:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783361425; x=1783966225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZ0WjjQDXIgL/o11ypg6tIN5gUP5sdHKhZMCBbiGhfQ=;
        b=WAvrRO0wl+jl4enFW/MKNpU2s8eKch/N94a/FD2wHGgl+u8xni/KauL+GqeEyL5cVI
         y/NPjeRCmRJfa+TAZVpkUsWAuFDCs0IWWD/P1zATo+Wn6E/miWsqFf+Xd/7VrQ6EWhXv
         d+MeJdnEPNG5GLhcFOv/bHMTfbzm7RVH2Bl/WdxdQ0inyvK4ieLPAoZ1HugHE/KY9i66
         0AMhBgvIr+ddPVKw+raYJ/G19i1bqWXerVA4uP4Z5p5u/p9x6f8d9Y8YY/oLmdkmK419
         PWFCUWpZRIGGbggGUq2dq1/uOGCj0G9fDLo+nm98PSy5aYv4hRK/TtSf8fNg8oSa+2K2
         xwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783361425; x=1783966225;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RZ0WjjQDXIgL/o11ypg6tIN5gUP5sdHKhZMCBbiGhfQ=;
        b=CjZjurMm+qszjhoIAWdcEVfQeWmRqP9cQFeVWxFZkNTM4V/cQiZrSRytEVDSs6eEaa
         25kgJXWzMjf2zGmwMEozwRykKu1Rp6Y3UWvxrXJCHSmhlTILF+E4LDp5SotFipyYIwfK
         nam3GrRVlUtJvvklCYpRhonY+TaBrAxfddhq0TqE74SI2IqY2/S6nG7yotcVpzYK3AKq
         VBgvimyy3ijBSlcdP4XtZgPcHYq8FxiW3Z36OJG/krP9YKGj9icTh+GHOnZ2e2+vmXBz
         9N9roczXyX23YH8jL9wgZlvVG+CiPN8LJwN9xGSjVp2Z+B3ICHRxnoPDvN9f2uqj4BYa
         hqfg==
X-Forwarded-Encrypted: i=1; AHgh+Rp240fzcLfynHBzKIX0/7aMCjDiTiAjgjXcMwoLkoYTB6sH0OO+xAHWbB5anqt9icGJ9lphNF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnMsZUjk9CTPJc8mkOGqcK5X2/1VvL9bS+fsgMkkFBnf9nwztZ
	y93SW7biaF5kkAZSi4RwVpDXXPtcFZa6pBPaczqIpi6YnJU482g6/Kds
X-Gm-Gg: AfdE7cnWOrJIFQqAFhjpJO9x0YHEatWwzSMpv6uHvjY46PwWusg/KxQMGubiiehL9DW
	IUJzZjurV+IiihUMoAeT30SqkXTpYLZsTAL1+ZAdNeIetVxF728CAJcijaYAbSXuzBM9O2Boqrd
	r+zWU7p3ADmbdDocucLQjOX9lmJZX0e95RU2sS+Au5In6fi6SjOTBq3sW0/pjUhAAvkYs0h+kby
	kGA9ehXdlzTNZviQ51YIABZKgGLGnxBFcGn4Xv1xkzkP+Er57fUKib3UrCiV4IbxQqjTKrAFyoQ
	DAoNVSzltXpJAnK3oYBBoTwYp7ryvtNle7EIBbyim2Uy8qUqIhEedmRoQb3PlHcKcXS+03zZ8cj
	vhkl5xt/nJvruSE7fbRY3/58BFB+ImeFZvTqKKQAeD7NuVvyIO6Y1cxHlaAOQ4koXflhi6rfgCa
	P9s3rZk3OFhaVW4mzqPEd4RzfoRk/tx0gMyjDHSIQfJVBythPNoyaDS6hHDcjlEi5AQg==
X-Received: by 2002:a05:690c:4c06:b0:816:a321:5629 with SMTP id 00721157ae682-81be4809eb4mr10911757b3.71.1783361425326;
        Mon, 06 Jul 2026 11:10:25 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8144af52027sm61232527b3.25.2026.07.06.11.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 11:10:24 -0700 (PDT)
Date: Mon, 06 Jul 2026 14:10:24 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Anton Danilov <littlesmilingcloud@gmail.com>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemb@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.f82efcd5c32d@gmail.com>
In-Reply-To: <e00539aa8c6f9428e7e92be0c0271c0d7e13a33c.1783218197.git.littlesmilingcloud@gmail.com>
References: <cover.1783218197.git.littlesmilingcloud@gmail.com>
 <e00539aa8c6f9428e7e92be0c0271c0d7e13a33c.1783218197.git.littlesmilingcloud@gmail.com>
Subject: Re: [PATCH net-next v5 1/2] udp: fix encapsulation packet resubmit in
 multicast deliver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:littlesmilingcloud@gmail.com,m:netdev@vger.kernel.org,m:willemb@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuniyu@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305183-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C858B715107

Anton Danilov wrote:
> When a UDP encapsulation socket (e.g., FOU) receives a multicast
> packet, __udp4_lib_mcast_deliver() and __udp6_lib_mcast_deliver()
> call consume_skb() when udp_queue_rcv_skb() returns a positive value.
> A positive return value from udp_queue_rcv_skb() indicates that the
> encap_rcv handler (e.g., fou_udp_recv) has consumed the UDP header
> and wants the packet to be resubmitted to the IP protocol handler
> for further processing (e.g., as a GRE packet).
> 
> The unicast paths handle this correctly by propagating the return
> value up to ip_protocol_deliver_rcu() / ip6_protocol_deliver_rcu()
> for resubmission. However, the multicast paths destroy the packet
> via consume_skb() instead of resubmitting it, causing silent packet
> loss.
> 
> This affects any UDP encapsulation (FOU, GUE) combined with multicast
> destination addresses.
> 
> Fix this by returning the value from udp_queue_rcv_skb() when it is
> positive, matching the behavior of the corresponding unicast paths.
> Note the sign difference between IPv4 and IPv6:
> 
>   - IPv4: udp_unicast_rcv_skb() returns -ret, and
>     ip_protocol_deliver_rcu() resubmits when ret < 0
>     (using -ret as the protocol number).
>   - IPv6: udp6_unicast_rcv_skb() returns ret, and
>     ip6_protocol_deliver_rcu() resubmits when ret > 0
>     (using ret as the nexthdr).
> 
> Both mcast paths now follow the same convention as their respective
> unicast paths.
> 
> Suggested-by: Willem de Bruijn <willemb@google.com>

Please drop. No need for this based on just feedback to a previous
version.

> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
> Assisted-by: Claude:claude-opus-4-6

With that aside

Reviewed-by: Willem de Bruijn <willemb@google.com>



