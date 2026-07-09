Return-Path: <netdev+bounces-306381-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uvUqFVAQUGoqswIAu9opvQ
	(envelope-from <netdev+bounces-306381-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 23:19:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E95E5735CA9
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 23:19:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=C17PSIue;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306381-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306381-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD615301DAC5
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 21:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0F824BD03;
	Thu,  9 Jul 2026 21:18:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D061B3AC0D0
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 21:18:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783631914; cv=none; b=FfAwpCu1SyNSLTWLvGse900rVo6VXMLNT3eiUOitfJDd+GSNFakUoW2MI2VIsWlO+MiGVe/EI+cIUSNpVqQIXqL8SS7i0K0lQzifZXOpo8wYBXGwyKUzCiqFJw+tvnk2YfPitaBR8pR7UwHWFJbqG3LfJmMOz2UXOZS1b/5yXRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783631914; c=relaxed/simple;
	bh=jX3YXc/Uj8Q32KvLYO8PF7pOiLM6wUtucx5wZAGFeoM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iQmezcOhjHsBhutvPdQJDJ3auHnonhoG2L3SMv1KbJIevnpjsV9mgKGr3j0ix0ErtmDOTuBpqv/DvoxR9SAa791TQovuhudgaDIITBbB2WIeZ6sfVoFTZgQ0zUHL64SibhyYKceZrxEZAfWw6X2uu1ZdqDeXWMIgnyPd3AxSBTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C17PSIue; arc=none smtp.client-ip=209.85.128.181
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-80cbb0688c8so4327387b3.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 14:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783631912; x=1784236712; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=G00RWwYZC2HViOKTjnb8tJyzSdAlUEMFUeiIIZqhKvE=;
        b=C17PSIueFezg7Sepxpi2zgf0IXoVvHSp1JUg5acNQaA3InHbRhR2N9HVnjjp8/8lAx
         NdKySf6YZm/3Y7WvlhFQBRwVlxOV3mOULA9EyZwy6oOb1/KSZezfbf2UbDBeBrkWvcT0
         zIbVvVYpQU1aK3b+bTkc8GTYLJsyxQi/5wfUllySgE1UYDy1lNtThreSrqIij+Cd+z+Q
         bKzy+vR6BjP5LO4ypZrzA2DZpwggmbb3CeZki0eyXq0Gld7o3ql+Z4wqqQkzEYoB0Vvu
         tDC/epnPeMrCrZ+yRrebWy0VARhNf2Uf7C/zlls0LUmcH41xeG3HzEUGSgbUIxvU1jpX
         apwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783631912; x=1784236712;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G00RWwYZC2HViOKTjnb8tJyzSdAlUEMFUeiIIZqhKvE=;
        b=jKw5973lrsJTr6Gt1mO59+YvJFaOHVEC3iAnWHLoEUyKjn4WIm0AUeNPWSamhgNGQx
         NEhiEWOOKJLZQ3v9c0evAE0sIymguSl93Zb52RXvsHuXgk0NSU0aeHzfq5siRG9aHKM+
         4l26Oa1SSMLp8iZqqtqDs/9tRB/nlV5aM0M0cHnWJfXpd0Pv9pD/4H/CKBGVG5j9cJdz
         U/Dwo6snlw6KN1iIjj4YmMvZP2/QKcZ81uyXKJaXsjlD4VHnN+LqoxmYbKRNm8lyNG8S
         HkcPMOY7P6CiVPh/AMlf9jXIrOo71F0TKIph0k0DRIaXgbEOBAKFj4T4BdPeGMcgujd8
         WBbA==
X-Gm-Message-State: AOJu0YzjQYdz9Wz+oMRPEGvgRfdvzuhKoQTnl33/+bVFQQ1ANoID8UcP
	tqpm3Q9kMASy+zyreJUHXuPqfQuRKkyiJVLkw3Fveh147WnVN+Tl7pDf
X-Gm-Gg: AfdE7cnJllhnM6+1mCbzbTQ2LrJK8LjM4Gukp4C2NsRNAPzQylBmtHP9HzIpxpSpPSM
	bFKmaiLqOuL7SUcLXG+VQ5oh7XfLI6FpM9+JauDqp1H7d8pw+kPY2iLxnODHN5tky7CowB4RhvW
	c8JUNhxcvMFOAwpyYwdBmp24Hmx8qC6qvvBxT37OyoUKsqSPuSuAxFyA6umssrHzfaHxDztRCH8
	vtS9sl0tog3Yl+edDccWqe5K2zyuRONEK0nCMEJNyOXq2Z5gy3zIZNlx9DUqBQ8Wwn+ltEqa5hX
	TrgXp2RnIN1N/CsDbuXAYfajyNtPgjWnUMOuH2e6+PAzlwpDK/T9iEdv1B1RUPthIJZ1jvTjkhs
	1nL+1RdBhZpChRqHzWwSQFnD4IPeRpFrN0PgZRDkHJVYLr3jJpTUXWJwFHqdVLyOOF2scPiJoIp
	FuwqFWwoGNHbRNTn7IZHGqT150IBRCmyP/Co4Ej+oqjd6bOpSyweh2wM7vOuYNXH6Yog==
X-Received: by 2002:a05:690c:9989:b0:80e:3d45:5206 with SMTP id 00721157ae682-81dbe755af8mr77147287b3.18.1783631911671;
        Thu, 09 Jul 2026 14:18:31 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6be904a4sm29435337b3.7.2026.07.09.14.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 14:18:30 -0700 (PDT)
Date: Thu, 09 Jul 2026 17:18:30 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Anton Danilov <littlesmilingcloud@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.159e777649f4a@gmail.com>
In-Reply-To: <alAAXv60KUZ9KYx1@dau-home-pc>
References: <cover.1783372173.git.littlesmilingcloud@gmail.com>
 <5372ccac062193147e02b991d5328a5c3fa3a85a.1783372173.git.littlesmilingcloud@gmail.com>
 <willemdebruijn.kernel.2a3e532d3c28f@gmail.com>
 <alAAXv60KUZ9KYx1@dau-home-pc>
Subject: Re: [PATCH net-next v6 1/2] udp: fix encapsulation packet resubmit in
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306381-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:littlesmilingcloud@gmail.com,m:willemdebruijn.kernel@gmail.com,m:netdev@vger.kernel.org,m:willemb@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuniyu@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E95E5735CA9

Anton Danilov wrote:
> On Wed, Jul 08, 2026 at 09:24:10PM -0400, Willem de Bruijn wrote:
> > This helps the case of one encap_rcv socket in the multicast receiver
> > group, so is a useful fix on its own.
> > 
> > But is Sashiko correct that this would still leave the same issue for
> > other sockets in the group? If so, something to address in this series
> > or leave for later?
> > 
> > Might be worthwhile to extend the test to capture that case too.
> 
> The clone loop is not reachable for encapsulation sockets, so there is
> no remaining gap.
> 
> FOU/GUE tunnel sockets are created via udp_sock_create() /
> setup_udp_tunnel_sock() and do not set SO_REUSEADDR or SO_REUSEPORT.
> Without either, a UDP socket cannot share its port, so an encap socket
> is always the only socket bound to its port. In
> __udp[46]_lib_mcast_deliver() it is therefore always delivered as
> 'first', and the clone loop -- which handles the second and subsequent
> sockets in the group -- never runs for it. The positive (resubmit)
> return from udp_queue_rcv_skb() only happens for encap sockets; plain
> UDP sockets return 0 or a negative value there. So the resubmit case
> in the clone loop cannot occur.
> 
> For the same reason a selftest cannot exercise it: a second socket
> cannot bind to the FOU port.
> 
> If useful, I can add a brief comment above the clone loop documenting
> why no resubmit is needed there.

Thanks for that context. No need to respin for that.

