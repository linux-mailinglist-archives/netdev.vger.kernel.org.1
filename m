Return-Path: <netdev+bounces-296830-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d8CbClRoJ2pQwQIAu9opvQ
	(envelope-from <netdev+bounces-296830-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 03:11:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF85465B8F2
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 03:11:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=SndYndnS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296830-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296830-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 60D5D3013BB9
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 01:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE741A682A;
	Tue,  9 Jun 2026 01:08:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB2B42A80
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 01:08:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780967302; cv=pass; b=QoubjTxAE3B6ds/4p8fziZSBtU0WyN6wOHhKSla7toGDPreD/1r5gJyTve+bZ3ZRPFLKtJjqrn0w961CdDDStvzPIKD8ve7w6VQHifQa2tDP0S47mXgLiyWLZC5iG/08/sUQPp13s49F2UbiW79/TinIyaoZRQanNFiSnuPd2+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780967302; c=relaxed/simple;
	bh=cZ0jw3ng+NlvVzkHf0LH9zv7jxtMR7ght4NCOa0aFbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H38+VjbI4KQ440hhvVogER8ldGnaxzQYGzLZ+p2UEZSFgV6UMlbisM5tbtx5MG5eb6baub7VV/oowZejeh4FXIlt5PgG0jBT73irMe4LLlTcmcM+z6AttsDsLVV6NrQT+mcXQ6+vLSxYD2NjlY6GBkcHDvYlMoVZ0FPK06oICUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SndYndnS; arc=pass smtp.client-ip=209.85.219.44
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8ccdf8d4ac5so54367426d6.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 18:08:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780967300; cv=none;
        d=google.com; s=arc-20240605;
        b=Auven/ubbhrIOTWgxwVPkjOeBIhLkFMPRuG6Zi2CmwIIS8sDqZPyHsq0/a27c/szE3
         H/KPrypWx7lS5K+hjpiklZTVrop9LkByd+PAk+esFQC8lUVRXn0eHh8ODW5QflVqWCEm
         9ebxOzhScTNr4o81MduF2LVRwpg2zHgd3KMgxmg2kU6KTbtS5+iN2uwtRBunmZHWjY9p
         lNL33gzEUXSCqt+8dp6BXGcpIq7JxaOf/IiX6g+sSQBKQ9c8jHdDYR1e78yYUFKARPvZ
         8FplNkcnVKgqR8BgUprboh1KLEJx+UUus25BkqnHLeOaBHFi2RrEKp5ScZYDufqtlIy8
         /wYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cZ0jw3ng+NlvVzkHf0LH9zv7jxtMR7ght4NCOa0aFbI=;
        fh=tkZr4JIYxpATKjmHj9YSz792dQWqRAFaqW74gfMDpo4=;
        b=Gm/0iamVGZQogybv9vNZQuXGmbgMaW1OjrQ09VEPHSh6PK0rSsras6yX3Zdp2crUiy
         0KhZCTaEr5xBe3B0SH4vW2Itw495KLH619HnwQEGRkYBGGX9RaWKrMR+HVLqtI5TvrIF
         IGrZiqBksZrvuSEZj9hNCDIBAnr5IF+KUYI4ExcBKWDZc010kXyWML3etRBh8U4AxBjz
         48iStPQHcw2EU9ama9LUrmUKn1VVOX0/hS6W0D5Jgi4BXRJWIr4YjUHLKpIl2Ga1HTWb
         alZ72/BalhcICZ/ROEWNyMNpYqk239W7ffeyX1uFgCTo9uOErH3yfq0IxaRCxY6CSPBW
         Glug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780967300; x=1781572100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZ0jw3ng+NlvVzkHf0LH9zv7jxtMR7ght4NCOa0aFbI=;
        b=SndYndnSc2Xj1EAkBuDMtqjn9W0qQTHPH2XYbDtKQPX3hlugHC0mtABVt1QI3AgVJv
         3y5+hw+QF45yrX6D3Qr2UE2eeVdW+vEWDdmbj1GA9Ttxr3pBTIXFhlMeKjWSQFrGZ+wA
         YJBNNj8XwLB6PtVn3lpogSDNLq9AFdDjFYLLnk/9gjr7BQbapoVgpP3WjTK0TqfzOO2l
         5gFNdKhZl78mxAs57nRu3UKKRWSFJtxOG+pZizIlsx/FKs4RbOXuz9Zy1td1XTwyqRyo
         IzvjyboYwIIxLezqRMEhQ3B0ZrNZwilaRwgkThyoI31TcfSp/lVEYlZOC1h36OUi4ZMD
         cCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780967300; x=1781572100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cZ0jw3ng+NlvVzkHf0LH9zv7jxtMR7ght4NCOa0aFbI=;
        b=Rx3IuQ/Xahp3s2Ue+5h4B6tPJo4qeP/ZPPlHYohvJ3hEmfA4tjQoU20xy8gdHdSc+x
         SUYUjgJU0gLhVSKOk7rrpIE/63KlpUeb22idqZoxgEHgGX9ev6/bNCYkXBc1W2xvkbVt
         pg5sTkJ8GUhaCF18dLdIcXgM7XrWYjMW+KAG/cN9/JJlx8FvNvN1gcTTyUUjnZj0rSWI
         iVtrpBs6BVcmMO89EKs8SrHbYb7ffuFY+ROSwA96qF3GllCnzS1bEvpgcTEPaU5jjCyt
         2AsCE0+OMyhbDjKK9E+FHyrsujieHeI1BiYE5MVvzIuqErQTdUSXBSnNf7LCZ+sN6Gna
         OKBA==
X-Forwarded-Encrypted: i=1; AFNElJ/2VpifF+rkDtIX23GsgPXGSVv+ZDVDQ1KW7RR5WqSFpuyGRR13d/JbbT6MzbOiPFHZmEg2Jq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW1VBz2K1XWaJOSg6fVIgjUoGuUAosnAa7t7GHmcdQfmhvPjYS
	FwBQ6RAMirqTgkw1Yr1JJrG4NP1fxW5+QAMmXerQSrpRGjRi1oQl2E65qoqlpbgiJozA+VSJrvW
	XtZSysTkKhwY0Sc/evwMUbAP8O9oC4PRazIs/kFYG
X-Gm-Gg: Acq92OFSX8MXJc9s1tyZwg2JfqIZ1hsqXMiR5vxxJ+ZDZgbeQFmocLvq6gir9HTNwSF
	KiBLUtiUxP6KHJJ06yBwVjhXcFo2ugK/DT2/7QF5iCqWwN1A5cViDp+BllObP5aFd5CRiuOi7yK
	iNuKsdLmj72UP2RtgNVNRzcm7buRgzC315dm4EGPpBpTI9lWpeyG2jHmFONC7WaBHSsrYzTjGo3
	vch4AbjrxxeB8QAfNk1cTg6GbuZDtJHRos3sCGNBNvu6SSP8dg6P0dZVp2my6/W3Hf//VgH0sOi
	WJJ6vk5t3gdlHUImjC3M0OcR4Ega9NVvgjLidLnUmsQF1JEJtPfNEsBHV89M9wwIk5T56khiyka
	jiD6MMvazE8pqNHP0jient0T3pv1R
X-Received: by 2002:ac8:4809:0:b0:517:905d:dc78 with SMTP id
 d75a77b69052e-51795bbf697mr168742361cf.37.1780967299211; Mon, 08 Jun 2026
 18:08:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609000605.1234374.9ba17536ec9e.cake-rate-change-stale-flow-deficit@trailofbits.com>
In-Reply-To: <20260609000605.1234374.9ba17536ec9e.cake-rate-change-stale-flow-deficit@trailofbits.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Jun 2026 18:08:06 -0700
X-Gm-Features: AVVi8CcWqj5XkBGeI0RWp9QsvgH183uDTooR3NDMdJKlXMm8EzL2qdTzeZnRykg
Message-ID: <CANn89iKOVOhJz8gPf1hJEcHTxbErVbXF0dAEfrEPjk6X+h2N1A@mail.gmail.com>
Subject: Re: [PATCH] net/sched: cake: clamp active flow deficit on rate changes
To: Samuel Moelius <sam.moelius@trailofbits.com>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, "moderated list:CAKE QDISC" <cake@lists.bufferbloat.net>, 
	"open list:TC subsystem" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-296830-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sam.moelius@trailofbits.com,m:toke@toke.dk,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:cake@lists.bufferbloat.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,trailofbits.com:email,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF85465B8F2

On Mon, Jun 8, 2026 at 5:08=E2=80=AFPM Samuel Moelius
<sam.moelius@trailofbits.com> wrote:
>
> Changing CAKE rate parameters updates the quantum used for future
> scheduling, but active flows can retain deficit computed under the old
> rate.
>
> That stale deficit lets an already active flow receive service based on
> the previous configuration after userspace changes the shaper rate.
>
> After recomputing rate-derived scheduling parameters, clamp positive
> active-flow deficits to the quantum that applies under the new
> configuration.
>
> Assisted-by: Codex:gpt-5.5-cyber-preview
> Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
> ---

This is bloat for a not existent issue.

pw-bot: cr

