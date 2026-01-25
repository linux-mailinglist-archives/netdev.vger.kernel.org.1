Return-Path: <netdev+bounces-253218-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id n4KLMPWNdmnkRwEAu9opvQ
	(envelope-from <netdev+bounces-253218-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:41:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D6882861
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADE323003EFD
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 21:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071C42F5A0C;
	Sun, 25 Jan 2026 21:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhRul0Nc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E3F1CF7D5
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 21:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769377266; cv=none; b=RWE5lzJmptyEXabagqZ/fpV6pTtRUi+ohD87X/FS4FxrWkbgHIXOLi/54kktsVWCOaH1i7+CLAAFBIigUgMSeGoJpATQ6wK3DmeKnSjsODybFL4kz3hlu6jNBrjZJ5DQaPj7j7WoQOnlPKPzmT/Jy73FrHIsiXg8g4DCgO3IEBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769377266; c=relaxed/simple;
	bh=TZH6xvfrFbRcjD5TSz2MMll2JWuPXEBJ7mhoZb7h9t8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FIYFGKZ992bTeAhHLY3jsODv/EBBlGqm7yiTvAeWIFZfqlQadnn+ZGUUnBj8bYwPdpQmd+pAsWI0be5zKOvNxMbTbZDnwHN6oIYbwmgBGdMVlznQ0RoFlHIcmsXTQ0xiFFQxJTUwDf8O7m0JBWnIFc21EVm+mSTfb+1OSd4JAeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhRul0Nc; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-78fba1a1b1eso59167017b3.1
        for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 13:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769377264; x=1769982064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6P7bD4DSuJfhr/yNo25gJbf091wDg4aA1qig7B92Iq0=;
        b=WhRul0NcdgLJhpAgETcl92qIgJjc/QMpaySupqPT93xX8U3WCwXIvXZlWtiQYsrlX0
         lWZMFCJhGCnHx0PKjQcrLlvc4X2rRhjYgW/1rJzobWAC4dX2fGmogf4Ll2hpYQsVidgx
         dmInYUij7NedP8ZAMnn80fwxgZg4eiYRTdnalsexUqxOBwHqw9DPS+KBYTj0fu1kHp+r
         sZnwBg01ZXkZJSG9sGcJ2JwgP2YCu0SwPLXJhqAkSV+xxjYSUwCY5nHPeD+GusmSXyn+
         Xtknxze4RvbjbliJE+h8Hyeww1nIqAalwnodqHjCVrQvWwfNtxDRuAXjCKelqF9rnIKS
         7dMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769377264; x=1769982064;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6P7bD4DSuJfhr/yNo25gJbf091wDg4aA1qig7B92Iq0=;
        b=xBKugkWrTAgpM3KT/E3ui5RyTqgNNF7xMhlEPLciM/ovD+jzwsC+fBJzIL48yNIt1W
         0IMcZ7Py2+v6D+cWY890l9ty5hAQKVa9rG/m3PRJpkOA9la0DYDHtqx40LUSXvDZRzO+
         lUH9hEg1egtel0s9e0RlVrBimvanUyqdJzc/cpHL2/RavFuHuTtR3EGvdna7QAGE0db9
         bUTdqN7TqK+2zJk2oPNqRPWZLxSRs6irB/oX6N7UeyQgfvsxYaoaWVGn59zRfxu/wP5i
         oRtnX+dTU+SQmcT0PhchudI6hkYUoH2toIAvEF/PQSxUfwDR5fjQXnQqIA38EP19iu74
         5D8A==
X-Gm-Message-State: AOJu0Yy6OoXDooUB6/y3riRlGVXSid0BQOQLKE6/9JsHRIR0yK3IaAsW
	sTGlnOg66h91XoaxJ7qhdsuHjqp9EzvTYSx2JQnwfGc2Vg3qjUyrMlGq
X-Gm-Gg: AZuq6aJWQEr4gCGaNT9j/MI7UBVSBdTqPOOa179TmnQEX6i2uxnTjFkT0hxSbWNVxA7
	bNgonJIBelQwjfOuU+tt/hbAeEW8C+XzNSaVb/aG3ZLC5qO06UFstXAk60j4Xj+9ybig1wKurNB
	cTr/jxgbxmIEoH4rYO59Z1KZSoYgrGBrJ0RMpSBVQrEE3sli6om4bwh60UkqQRVuQtsWmXRo5tQ
	6it39FOo+O0LCxg7r7MVLFbhDXCIbhcZ2VzvJpna/pVDZwcof9csyoIXuGXQ5Hw2u3OC3sN8kU3
	cM5QjnrQJX2J8xLlXf6z+3TZJbw9TGKZFxI15Iih1AwDSHpVadN6CFnH5YNQ5j16atUH6JePCdf
	RiJho+iOaKbwTlQ1SdRYnkTSqjFsTNsGBCjY2JnJQh3P0EgfxmToZrCSsjtmbUOLjZy1Q07ciM8
	zJmuE1KAH3cKGLeoHGbO9vHcm5W8OfbvZ85hA8Nl7My3tyx7JjHZfwQA24WqLuwrtT9B0rNg==
X-Received: by 2002:a05:690c:498b:b0:78c:6a53:15d7 with SMTP id 00721157ae682-7945aed2998mr19578577b3.34.1769377264496;
        Sun, 25 Jan 2026 13:41:04 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7943b01bd39sm39938507b3.20.2026.01.25.13.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 13:41:03 -0800 (PST)
Date: Sun, 25 Jan 2026 16:41:03 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Gerhard Engleder <gerhard@engleder-embedded.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Kevin Yang <yyd@google.com>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 David Miller <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Joshua Washington <joshwash@google.com>, 
 Richard Cochran <richardcochran@gmail.com>
Message-ID: <willemdebruijn.kernel.976a69fefaaa@gmail.com>
In-Reply-To: <9d21ddb4-5e7d-4dfa-9ee4-ecdf73499f5b@engleder-embedded.com>
References: <20260121160458.990785-1-yyd@google.com>
 <20260121160458.990785-2-yyd@google.com>
 <c5ba02dd-e81f-4590-9e35-90c9b2c33bee@engleder-embedded.com>
 <willemdebruijn.kernel.13b62cc180aaa@gmail.com>
 <9d21ddb4-5e7d-4dfa-9ee4-ecdf73499f5b@engleder-embedded.com>
Subject: Re: [PATCH net-next v2 1/2] net: extend ndo_get_tstamp for other
 timestamp types
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253218-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[engleder-embedded.com,gmail.com,google.com,kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,lunn.ch,davemloft.net,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05D6882861
X-Rspamd-Action: no action

Gerhard Engleder wrote:
> On 22.01.26 23:28, Willem de Bruijn wrote:
> > Gerhard Engleder wrote:
> >> On 21.01.26 17:04, Kevin Yang wrote:
> >>> Network device hardware timestamps (hwtstamps) and the system's
> >>> clock (ktime) often originate from different clock domains.
> >>> This makes it hard to directly calculate the duration between
> >>> a hardware-timestamped event and a system-time event by simple
> >>> subtraction.
> >>>
> >>> This patch extends ndo_get_tstamp to allow a netdev to provide
> >>> a hwtstamp into the system's CLOCK_REALTIME domain. This allows a
> >>> driver to either perform a conversion by estimating or, if the
> >>> clocks are kept synchronized, return the original timestamp directly.
> >>> Other clock domains, e.g. CLOCK_MONOTONIC_RAW can also be added when
> >>> a use surfaces.
> >>>
> >>> This is useful for features that need to measure the delay between
> >>> a packet's hardware arrival/departure and a later software event.
> >>> For example, the TCP stack can use this to measure precise
> >>> packet receive delays, which is a requirement for the upcoming
> >>> TCP Swift [1] congestion control algorithm.
> >>>
> >>> [1] Kumar, Gautam, et al. "Swift: Delay is simple and effective
> >>> for congestion control in the datacenter." Proceedings of the
> >>> Annual conference of the ACM Special Interest Group on Data
> >>> Communication on the applications, technologies, architectures,
> >>> and protocols for computer communication. 2020.
> >>>
> >>> Signed-off-by: Kevin Yang <yyd@google.com>
> >>> Reviewed-by: Willem de Bruijn <willemb@google.com>
> >>
> >> Like Jakub in his reply
> >> https://lore.kernel.org/netdev/20260119115710.6fdde8c0@kernel.org/
> >> for me also the question why this is a driver implementation came to my
> >> mind.
> >>
> >> With vclocks it is already possible to get timestamps for arbitrary
> >> clock domains in parallel. So it is already possible to synchronize
> >> the hwtstamp to CLOCK_REALTIME, CLOCK_MONOTONIC, ... in parallel.
> >> Therefore, user space synchronisation is needed, but e.g. ptp4l does
> >> a much better synchronisation job than your solution.
> >>
> >> Maybe CLOCK_REALTIME is not supported by ptp4l, because due to daytime
> >> saving this clock jumps. IMO these jumps will also be problem for
> >> your solution, as it will lead to wrong delays two times a year.
> >> So usually CLOCK_TAI or CLOCK_MONOTONIC would be a better choice.
> >>
> >> To sum up: IMO you suggest a driver specific in-kernel solution where
> >> already a driver independent user space solution with higher accuracy
> >> exists.
> > 
> > Definitely a promising alternative.
> > 
> > With multiple netdevices, a TCP listener socket may receive packets
> > from all devices. This would need new infrastructure to lookup the
> > correct vclock for a given net_device, cannot hardcode a choice with
> > SOF_TIMESTAMPING_BIND_PHC.
> > 
> > And this needs to happen for every packet, so with minimal overhead.
> > 
> > Though for established connections the expectation will be that
> > packets generally arrive on the same netdevice. Bar infrequent path
> > changes such as from sk_rethink_txhash on the peer. So there this
> > value can perhaps be cached.
> > 
> > It would still have to be learned by the kernel, no explicit
> > setsockopt.
> 
> Maybe it would also be an option, that the kernel learns with which
> clock domain the timestamps of the PHC and vclocks correlate. Then
> the TCP stack could calculate the delay if it finds a valid e.g.
> CLOCK_MONOTONIC timestamp in the packet. This would make the
> TCP listener socket independent from the devices. Just an idea, without
> thinking about implementation details.

I think we're on the same page.

- use the existing vclocks
- look up the right vclock based on the original incoming iface
- cache this known clock with an established socket

But I also have not looked at how/whether the lookup infra can be
implemented to find a vclock automatically, i.e., without userspace
admin.

In some cases shinfo hwtstamp raw format may actually be the
CLOCK_REALTIME that TCP requires. But if the raw clock is not
realtime, we'll have to adjust based on timecounter/cyclecounter.

