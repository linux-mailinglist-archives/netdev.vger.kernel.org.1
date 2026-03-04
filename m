Return-Path: <netdev+bounces-263572-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCf3Alamp2kHjAAAu9opvQ
	(envelope-from <netdev+bounces-263572-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 04:26:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 346FF1FA512
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 04:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D31B2303D72C
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 03:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727CB3659F5;
	Wed,  4 Mar 2026 03:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7M0rOX5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D3C3659F0
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 03:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772594770; cv=none; b=bTxDW+d5bnWY38CJr1O0rFvyyxaf+12y0ZNslYrOrPSxR2Oe/ZUFLhCf9GEsLNJpMLBG9Z3LoYz80TnNLHtP9u110nWcX2jnCFI/fVA+nTqyn/xfYZ0ochWCAGI636l5Bh01Cvv/YaarrOuNwej0735ugI7wzeUQAFvwWaJ3Yds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772594770; c=relaxed/simple;
	bh=PPSHNIFhWrfBJZOrHV4rIJe9IugSq6K+nYmO15iPa0o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=lKzAAOn6Mgfz7AqVPeIaujrkmIDxWPzmHyZSjqQZyLfJG9Xa6UCLJW2wKRhP6cWJ2UzZHjEoL9Jtkd8RoShvbeBTtg6TMqplu1K2/0wxS+Khwl+wpW9aln1/Rz38MqNxGB6l9Hj1wOyilhceVns14zkOBlJipZV4YVJJgq0vDog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7M0rOX5; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64ae2ce2fe1so5520759d50.1
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 19:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772594768; x=1773199568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BB57YsAFvhCZTbc38bVWsIH6/LDK/xxpo8jyV3Wgtsc=;
        b=a7M0rOX52V8GGviLKGRuX1t06WjDtmNSuWgq1/hqipVAnZvNrpvNjcRo0tVH8pnksq
         ntRBjmQiTxEZwF4LWLoJs+YMSqi48/ZB+HEnVzmKytnpSnsSRdqadXSRSXk0sxEr5s20
         ewUA0w/0wS8krxg6YPcTI6Vdghr4ybtyeQAX/yIHVUXSDGUYDWXTjFYkZWsuA7rWdHQd
         +KzAHcp39T9/Ev8A0/9Gwin8levxFQuuigAvSVfCR7FDGSU/xcuuFXkCZXkIetRtX8zA
         71/wxeGXbog3ASuDrw81SKA1I670KCFzW1l4jwqdTXMwmv0eGADf96UZvP3FqDtrVVGr
         8AQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772594768; x=1773199568;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BB57YsAFvhCZTbc38bVWsIH6/LDK/xxpo8jyV3Wgtsc=;
        b=iq8VFtmLPjmDUYg0VFRX6Oue1fRNqRwSen72E0cpDExc5NywB505dbWEcDpYc210cP
         o8Ws0rv9k9vr/+YJcH8MOJs1XvNQh1JWQJDPPXHbdX1Gcaz97TInftpKyi4NV1DJ5ZwQ
         Loky9tagKKZity4i6Glrvle29gskuIEHW+/RctW7HaDq5FQ0Gb2imxyiWeOPPdEgHB6K
         x3tBV06xTMJ0rKGgz0M+dsMZX8k5AECURNGjOYFp5f8jcl32Yq8NSDlxVBtKLZILTmxq
         okYOAZxcsO8YVeY5azCAlcVouHrEBflNxEnZIruLMt3x9iQaSy3ThD4ha/boOU1itgKu
         2yZg==
X-Forwarded-Encrypted: i=1; AJvYcCUF268jUKxILwZ8RvEiRcg9BiMKi5A6QoaLexi+OAAq3rZfK74M5v22VPz9S0a95KXLmNzOSjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy+pSGMlIkOsU9nedtGyVbiE2obMzi5ff1TRiJ32sMGn3erA/z
	K9i/VBXsZO5TCxFb6qkHRh70bBZJK92DSV8t3xpWcU+4iopieeSbrs1y
X-Gm-Gg: ATEYQzxSqzu/KnfqFNgFDM1oygTkIZ/gdBnVH0+ryoyRQXg9Gkt+6fxEQUdkEz+fF/N
	BU6scPsQzmy7/klP7mvU1oTqdRdSMtoU7Aonw1sMremqU8QnwRMQNJjo85EIQAoKpPeYtXT3U9z
	AYj2p/k+qPKAL3ACEarSzUasNd6vs4pXD5OoreLAaLwKrrjAXDHLPw6mt2xCCnmHhpDgboxVTxl
	Ba6zCPBszHECfCS1UWXvBd5rMjrCu30nM9TMC3nxWq8vxDe8wqw4M4RtkPXo+bkqMbbeG2/QGuI
	jivFalQJVjST2zmlq1zJWOgDi2KSNxpp3Td4mVqETrJkKVqSK4POjYg6MCGqcAGOQ5CAUhsjp6Z
	ozc5B/naw9CDeKDSEy+VXVwZ1ikTaoYGjWZOoioVWUnlBNdKIovhsltc2Th1CmB+Io5WBVB+pKn
	CxnBLchyLfw7uYo59kLo/7ZMdy59p2PwGihJLxN7WIUDUsHEWE/kbOz9zOJnucvC+4PuMLeU4=
X-Received: by 2002:a05:690e:4197:b0:64c:c1b6:7150 with SMTP id 956f58d0204a3-64cf9bf10c4mr581189d50.46.1772594768188;
        Tue, 03 Mar 2026 19:26:08 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64cb763d7fbsm7302541d50.16.2026.03.03.19.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 19:26:07 -0800 (PST)
Date: Tue, 03 Mar 2026 22:26:06 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <willemdebruijn.kernel.24c9a9b9e12df@gmail.com>
In-Reply-To: <20260304012747.881644-1-edumazet@google.com>
References: <20260304012747.881644-1-edumazet@google.com>
Subject: Re: [PATCH net-next] net: use ktime_t in struct
 scm_timestamping_internal
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 346FF1FA512
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-263572-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Eric Dumazet wrote:
> Instead of using struct timespec64 in scm_timestamping_internal,
> use ktime_t, saving 24 bytes in kernel stack.
> 
> This makes tcp_update_recv_tstamps() small enough to be inlined.
> 
> The ktime_t -> timespec64 conversions happen after socket lock
> has been released in tcp_recvmsg(), and only if the application
> requested them.
> 
> $ scripts/bloat-o-meter -t vmlinux.0 vmlinux
> add/remove: 0/2 grow/shrink: 5/4 up/down: 146/-277 (-131)
> Function                                     old     new   delta
> tcp_zerocopy_receive                        2383    2425     +42
> mptcp_recvmsg                               1565    1607     +42
> tcp_recvmsg_locked                          3797    3823     +26
> put_cmsg_scm_timestamping64                  131     149     +18
> put_cmsg_scm_timestamping                    131     149     +18
> __pfx_tcp_update_recv_tstamps                 16       -     -16
> do_tcp_getsockopt                           4024    4006     -18
> tcp_recv_timestamp                           474     430     -44
> tcp_zc_handle_leftover                       417     371     -46
> __sock_recv_timestamp                       1087    1031     -56
> tcp_update_recv_tstamps                       97       -     -97
> Total: Before=25223788, After=25223657, chg -0.00%
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

