Return-Path: <netdev+bounces-264180-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIjdDGEKqWlc0gAAu9opvQ
	(envelope-from <netdev+bounces-264180-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 05:45:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA4420AE22
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 05:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25BCD301225D
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 04:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8013A73463;
	Thu,  5 Mar 2026 04:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nPpepieA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345E7336898
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 04:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772685918; cv=pass; b=ockr6NG7rbcODHXGVGHfxx9daizEAHHb+sqax+NWZQkXXOSY5EuHaE4qVAL42NRORt8PCMngIySyImA+A8eSxtKf6No52wbbYKgtrrQbS3zU3+4dmcwcuHZqU45U/TnxXwVmnXzlJfBid0H0bAAH7r+FPNOFEnOo7Eec5Qhw71I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772685918; c=relaxed/simple;
	bh=OPUnVQUQwUoRKe/iMpI0rPb4P5CYoqChP3wIgOEhfV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LONMhUKPT2Y2fOOYSKWsPM2YDKO+qSuf5TnYhSi0mmdoXy61f1fpL+BRKmXviDhDZ52s31h1xBuXMJtX0V6Qi0473V1JhUJ5VXFZndACc1XKIgMFamxbAXPUaUzoY9j2sS4u7FFcIMlVTDmu+z/anwPLtPW8Vk+iJYLIuP4nAME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nPpepieA; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-65b9d8d6b7dso12398366a12.2
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 20:45:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772685915; cv=none;
        d=google.com; s=arc-20240605;
        b=bFmuJR+46onQ1iYPwjrQYtIqmmsV21xwR3JzFb9F/DX9JWGY205qO9O/LkazvVI+Te
         0tOT1FPflOfUQER4NWntc7nGXzTbqUnO5v8KRyX3K11ye5E8V32+0ibt0pXDSJOBG9KR
         w7+hEiIkhf+ipHLeGjWJJ/O/15cha+4FzmveV56/Qds7vEq7k0aoh85Vo5dc/4f3FhB+
         SsGH31g1yWGD4UxpZGLXvFq7xcTAtHcu8ZFgA8EdhtDOZ3MVGhaAmO9TQrD8wlVmXz5E
         vu1OxOWGUrUt00fw3+OkS+7BhviASDf6jNb0JbhssqcAiVXGl3iGUkyAuqbYl+DY6ouO
         dEaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OPUnVQUQwUoRKe/iMpI0rPb4P5CYoqChP3wIgOEhfV8=;
        fh=7/bVzhbVC9a77k7iErMnDLhheFu5Um3K5RmzuAtUzw0=;
        b=kKbuevv8zaflpYi/sXGGlValEYjugUYJLJtLJdiGg6sLUia2KEedwn/+43kpTl3yHJ
         9DQN8hu+/sBmvzOJ4EDb4YRJpBWL55CYOiopP5asJ7XJjMI8+jciW+oaDw6eCpdTT21J
         dp/lSsdquCeUakbWJ+slCHBS1O4twv11mdcCXkiUnquKmSXqWNp2sA0MSXAcES2GCKQ6
         lCPVv3h9q36xDA13+algZGpFvBBmdn+BQE3xgsG6k99VtTY7o6kf8FPgijN69XlAtoJe
         W/Fc2nzxjbhjihGM1VgUugSIF3MeGlduMEXlHhg6xJN/H4o+sXnPwUmh+PUa3Pz0RuFH
         QUxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772685915; x=1773290715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPUnVQUQwUoRKe/iMpI0rPb4P5CYoqChP3wIgOEhfV8=;
        b=nPpepieAy1ToWRdFEf+6ooLOF/HxdN9PV1NOoFMvn+FaWSgykbnOy76F6KaA9ORAaD
         p8nxYmDGSlRaqrEpdmXz7+wvoY175+d9JtyPs73w1md+QTpgvApgIs+sfILVVoVKtEYa
         2EWN5WuckRVvu6LpMJGnCPpdNUSD0Mof8XUWlGIPC4lvMnDm6MPdzPkutzXrSsl16hoZ
         UYyIobMkFKrNezkpCDBMfInIV2IHGMRarqdUTU7Z4MNZtna4TOwDqWR6J11RSKgHtqr4
         /PylVx7cDhdUX4H3IpH4/SKHUOIuz9yKqUMzjewDakYukGk9Pc+p0ub9FZK0P+zmbFpR
         226A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772685915; x=1773290715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OPUnVQUQwUoRKe/iMpI0rPb4P5CYoqChP3wIgOEhfV8=;
        b=LJ7lLoTlXrEXJFtSuw/R9cqCoSdH4XVMBRsj/YzxHQepbn3yVd0UFEZBjuexboDY2l
         Kkx+UbO9ojXl7RI/K0RKMQHG4gFpK4DDPjivZyfsaz1UdaamxDayQcmLsc3wopBXYP2+
         9xoIduu3X/j2vgf24Yx3MgZvsqtl9P6WSk2Ehh210t1rUFINBZ5IgDY7ywvzFIOlfkMY
         Tu9GFqpqFIMXCBLPkgeOrNulDKr5STWLgHIlcGlrwBPPzlggFbMI06xzC4ohjNSNRhqX
         eLN6OIekV+MCi/WFpmAgp9nDHK8lgbQ8KIEDrYiy6eHt6GnF4fzWlGzuU2suaPSo3MIF
         eAww==
X-Forwarded-Encrypted: i=1; AJvYcCU1US/9AioqFxELJ5eA+M+Jbpq+ajAOvuZEqRp0MEewtzl4xnKKkYxPJxFTiXsM+ReJMQrCdhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNRSaVpvKCqX78zBsTZ6kWaYbL3JcVQDVM39NUxUTFcmEBwQK8
	NtQLcdBX6UwL0kDFu3umzFQ6bg4fJ/f3kZDNKmfU77kFuIieufhBWDiq9vryfF9Slf/yEoAtbI1
	0/ZKyLGrQHpzAaZqioLndYfUOEBb7olQUnJjCTmui
X-Gm-Gg: ATEYQzxhp/Je9Lo7EOJ/x6JH9I5r4rODIwdc08df81Sh8EAZxCfbT4D/V+lCiLkGmeU
	ERBQkMC6elyBRInCfAMqSOXET+7OqjtbaUOhXPX/QvfqKtCffGg/L0w6Xv255z1BQmkMD8MrOkl
	PsAxs+gmgA+4ZJ5kCtS/Q5tBIEGUsy/4P1vsU/ekOAvpkYKRBZLQIU24kRKnnDN/kAoZcZJR/pF
	jUAiNxZe2bYR3hINul1hzuTmSrYB9nG2xzXswEq/4jidyYEBjEyPTknI0YFIqd8qIpZizE+N8Wd
	haFmvNVulVj7jSdTU59CInSDpQJRM/e2Tb5KqGqvM6EgRkJU81iTdWYvzAKS37MW1zluXJt/
X-Received: by 2002:a05:6402:270e:b0:65a:3de6:c55 with SMTP id
 4fb4d7f45d1cf-660f02d456emr2660157a12.28.1772685915274; Wed, 04 Mar 2026
 20:45:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305022703.3946470-1-kmta1236@gmail.com> <CAAVpQUC8Oiy53MG08tR1OXGgJSWse1nSLFhUdJtVzSvc-qsB-w@mail.gmail.com>
In-Reply-To: <CAAVpQUC8Oiy53MG08tR1OXGgJSWse1nSLFhUdJtVzSvc-qsB-w@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 4 Mar 2026 20:45:02 -0800
X-Gm-Features: AaiRm518_m6aMPWkL9pN4HGbF1X4z_Q0239D7wG1kVLM8LMleQwL-7vqrSkWeZA
Message-ID: <CAAVpQUDy_fLy4TQNfJbqj9QVr2g=_bykiH7GSQQRjtLTT0SYyw@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: remove unused hash_size from struct tcp_out_options
To: Keita Morisaki <kmta1236@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7FA4420AE22
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264180-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,cloudflare.com:email]
X-Rspamd-Action: no action

On Wed, Mar 4, 2026 at 8:37=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> On Wed, Mar 4, 2026 at 6:27=E2=80=AFPM Keita Morisaki <kmta1236@gmail.com=
> wrote:
> >
> > hash_size is declared but never read. The MD5 path always uses a
> > fixed size of 16, and the TCP-AO path uses tcp_ao_maclen().
> >
> > Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> > Signed-off-by: Keita Morisaki <kmta1236@gmail.com>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

btw, AFAIU, patchwork does not use git am -3, and this does
not cleanly apply after your another patch and you'll need to respin.

