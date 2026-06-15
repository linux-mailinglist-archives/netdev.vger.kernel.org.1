Return-Path: <netdev+bounces-299567-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w5EUGkpIMGpSQwUAu9opvQ
	(envelope-from <netdev+bounces-299567-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 20:45:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CE1689455
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 20:45:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cloudflare.com header.s=google09082023 header.b=AecFFvZC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299567-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299567-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cloudflare.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC884302C7A1
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 18:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC0F38F954;
	Mon, 15 Jun 2026 18:45:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45C738D3E8
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 18:45:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781549127; cv=none; b=MLctIUXhnu8QCVHGEWo32dVnwmibpATNT5k8OH9BcnLeyK/wMmRVQI4KtqQ0xfysvqueBeU4cQgD554/j6OAE8PSM2gUCAsutAiif4OcpUB2f2Cxbj/dnrtfoFBb5LaOwuGo1vpldthqJDuPi5Y/c0SWwDNIJdQCF3H4W0Op1ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781549127; c=relaxed/simple;
	bh=y2PIwVUXoCW9TnSY2n/aKtOQkJRqNDHne/v+icBH9dY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kV3abFs9xWHVqJYWR5gmVNYC7IDEibwgg/ZJ/etrpnfCngPZpTFjxpOa6tXxjJRpTJ8KlXbZv9PuyDgLmBIoDHUu1sAK+eKsh8KJcCCooH+Eg4PL/KF3QqOwhFAuGjD/oQFnj6mFZLqW4+CV7MxEJKYYqtGYMsYLCbqgqDjzCHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=AecFFvZC; arc=none smtp.client-ip=209.85.208.54
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6913160c9ddso6881496a12.2
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 11:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1781549124; x=1782153924; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y2PIwVUXoCW9TnSY2n/aKtOQkJRqNDHne/v+icBH9dY=;
        b=AecFFvZCFUH+cdH3xWC23SZCDdYeUbTajF5x2BOZ9BujrUyVGpfbKNhK6GDYs2fp+N
         fQhk/eclpof/q8Hr6r6g90pavh/L5kjBaugKJEmmLI+3gE/00OBCvS51QGIBWJwjqZ/x
         ihijKdSUBNQGrcnXtMvNaEtmdQpH844E2JOvwcl8HjMlyuxZaAkJMbfosyHng5oyC2Er
         nmMhtQU43pCHTiX254XOvSGxYR2NU+mxysr69PKVxiwzQphaeeewXOYHacfx82xWtVAQ
         3WZ1r+Udf7PEPInyWWMV08aK7AFq7Dwt9RVIxD4loVIULKs3hF5Gethnac+pyYz21OYv
         2eZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781549124; x=1782153924;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y2PIwVUXoCW9TnSY2n/aKtOQkJRqNDHne/v+icBH9dY=;
        b=EzXt/Fvi91YlxYLDvsMz246sjFFeK2scuZrR3o4+cbareVVs3spVclFFhyYQ7PnGp3
         8eAi+sqxGSc8WMetQGflBU4KIXWfZT2GPSryl5FvcXney4IeOzcY0Gk/sS0h0JHnEho+
         l1IbJp8KhM73Yi6F4zHUOm7587L5CyvkQoIoV7tHf4shMT+f/IW7NcaB/alkE5ayGX2M
         iS9y60Cfm4Lk8wkGRGjXUzeWdv/6d86bI4w5xK/9Zckml7jHGdjmuWFH/Lh0JTGrHi+m
         deYUWPpDcTnF1rFcXSS7thgmJGHM1762juZWAbBKPEadOWMgEcp60pY0rHvOmTw94vqF
         yp4w==
X-Forwarded-Encrypted: i=1; AFNElJ9xu1R0h6ABiw2MNV+vSwxD3q0Fd6HwmpA1OSwMqF8T7pp4hHSuNjPv59vOg2dvXTzYMyckYM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAbuamoGubYvaiXbYmQb+UZ7tmtuoWEaN30iMwwFn0DMq0ee0a
	SGYweepez+RHpS/q5iSZV+4+E2Os6+69pla64JyLpzFzaqcpb5Q0XHuFqkdF4XgPIeY=
X-Gm-Gg: Acq92OH69vut3xx9+U1Fiki99Jb9hDD/tc/7WRbgKeyXFKvidm2/frQ3i9WH6ASPPCz
	+ygjhhRBLroMZol/caaxh9YK0nPrXguYywXQU/PKfQYbzwtlBqGcI/bY7h0SzRulY9iExSKIlgP
	yeF+YuI6J9zK/ap4BOncQCXAousBnBxGrj4gxsLrnAr3nk+6B2NEocnLySnpUCqPTks4uYzU+yi
	M8QlIKuPkrnpZhwBbAjLfpZgjLMxFkK49ByHhIBpCE7V+AYOIt9vf6+9bMnMMlxK03rMbqF4xyB
	nQcvmBHE2sqdFYIvRKB70LIM4VNAF0YXa/AGeo65H0RUGeehOGURg4u+LlzZZ0UD6DxXYvwA/nT
	qsjaKC+SHvHM03cAtYROREj/sw9znbQEj6rcwkl96sd+w9NjeE92sv63e0BWlSijSfbeeWeMHXT
	gCfJdL5wOR021VTHIoax7gMa/Q5Il5oPRW/y3S
X-Received: by 2002:a17:906:8473:b0:bfe:ed35:e85a with SMTP id a640c23a62f3a-bff4c9eaf3bmr461429766b.50.1781549124175;
        Mon, 15 Jun 2026 11:45:24 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb5223309sm513470166b.28.2026.06.15.11.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 11:45:22 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  bpf@vger.kernel.org,  john.fastabend@gmail.com,  sd@queasysnail.net
Subject: Re: [PATCH net-next 1/5] tls: reject the combination of TLS and
 sockmap
In-Reply-To: <20260614014102.461064-2-kuba@kernel.org> (Jakub Kicinski's
	message of "Sat, 13 Jun 2026 18:40:56 -0700")
References: <20260614014102.461064-1-kuba@kernel.org>
	<20260614014102.461064-2-kuba@kernel.org>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Mon, 15 Jun 2026 20:45:21 +0200
Message-ID: <87tsr3bq2m.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299567-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,queasysnail.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:bpf@vger.kernel.org,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid,cloudflare.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1CE1689455

On Sat, Jun 13, 2026 at 06:40 PM -07, Jakub Kicinski wrote:
> TLS and sockmap (BPF psock) integration hides a lot of latent bugs.
> Bugs which may be more or less relevant for real users but they
> are definitely exploitable.
>
> We could not find anyone actively using this integration so let's
> reject this config. Adding a TLS socket to a sockmap was already
> rejected by sk_psock_init() through the inet_csk_has_ulp() check.
> We need to reject the attempts to configure the TLS keys (rather
> than adding the ULP itself) because checking prior to the ULP
> installation is tricky without risking a race with sockmap getting
> added in parallel (sockmap does not hold the socket lock).
>
> This patch is a minimal rejection of the feature. Subsequent patch
> in the series will do a light dead code removal. Full cleanup would
> require a major rewrite of the Tx path, we don't need skmsg any more.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

SGTM until we can come up with a generic way to exclude sockmapped
sockets from ktls and espintcp.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

