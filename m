Return-Path: <netdev+bounces-267381-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDwNIwLls2ktcQAAu9opvQ
	(envelope-from <netdev+bounces-267381-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:20:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E62B4281595
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 11:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D07B8303E2C8
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 10:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31C036C9E4;
	Fri, 13 Mar 2026 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="cDvUl9ur"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF99309F1D
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 10:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773397230; cv=pass; b=UjH6w2qWndmn1UNciai+T5+cQYhXtkLWyPc7uL65I8/mCM8A9WFaU/IL7zfcwDSLp13W0qvgRi7Sszdidc5deCMxYnOErIyLi/MrpY7A3ypNBZ1ejq8NOr8Xvy3f0jFk3iVlRrTI2YotmuzSwmQiolewFOrNJqqq+WzJX+swZjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773397230; c=relaxed/simple;
	bh=+B8uqafmAg1ZCzAAhnDnZ9Muoo/hahpr6Lp382JFWr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CHdrbDyoblgR2Az61bF/+BM7rTdBolW6oc78BUFtsQ0lWfIK26SVrt5jB1l1b2CXnmhb72GaihavCIfYTzejAWWdJDeMVOQZ7yFulY6jiZRTGJBbSb95ey36fyX2Tr9YTJg7cSe5swAmJnEcHhlgkkDBY4ri+3ColM798POdxyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=cDvUl9ur; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-662b933f8d1so3357683a12.2
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 03:20:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773397225; cv=none;
        d=google.com; s=arc-20240605;
        b=MUwvloMhc6xV+mbs+J0rT5GMiflcUBpwaxQpB6n3IvSqGU2sf6FsxVk+2EKOf2vhzz
         osSjZF3Y6RcWrLh2Z3EcI46vVnALS1dH/o0SfkHfdNO7dM5B/7a1TFXtYsN3iRt/Bq9b
         gDXvqEwMBxpEV89ztVSekuJzetSiVPyvlUXHF7W0fiIIY4CP9QtDyozC186PqFhed4ww
         ZJpNagGHHi8mQhfZg8S+/osQ/0h+50bumVwYRqE99bkZ/dRmersJ3ga+RGSq18fzrGPQ
         S/p68KzwV7MpLmjFrEzgGueTNU2epx066rIYmhuJafwqUvr+rMCCOrLHfNm1pXD20iWx
         j5yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+B8uqafmAg1ZCzAAhnDnZ9Muoo/hahpr6Lp382JFWr4=;
        fh=e+w0bpo4WS5DcuYPiOuAnM4Hww4/js6moFInRLdu3Jk=;
        b=VcRxv0WOdGR7LZevu4FB3f07k6CnvoPcuQ2afUqmNhDw8wUJmZ+sRt2EUOlP90Tc81
         UzqsiSVsPKdjTJYD+od8vhe5UH2TOQt+fQi7ZCDJ32YS+PxoolXDDnpyhaytcBRiCPuJ
         ybDe1b3pJY8AhuLjpGx6c4NyJEY5baDdvtYzKLJhuTkvDKDhCmzvI5H/SOd/lsPmQP1r
         tPXd9jWH9DhDcheLcPBwtFT5OpMZejTCpytIqfZ/nX8EOQHm3eq7T6gYJ3ca44JIiAby
         QurvIhYlTgrBv/x53xrz6qn3dswFt9vnPEMXi92aUlXy8pXRU2G6lixeeypaB48ZP6KY
         7L7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1773397225; x=1774002025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+B8uqafmAg1ZCzAAhnDnZ9Muoo/hahpr6Lp382JFWr4=;
        b=cDvUl9ur6B3HCEntDQAN1lfLadcYFznVO2Zi7dPzaXwHbTzqibCerBBDGWBjHjNj1X
         rK8k92I3MZGP3GCoVQOh5zfbjbbrwiaWW9D2SV6+BcuUAQGIuaLD7y1ryl+qWeEMd+Kf
         LCtfrXds6mpWWZR0i7gmcflKF56gOUOj8EUmq+OHH0RGe5UmCflABt6ai6R7Qv34ehr4
         sCXeNc4I5m0SA/vm0oR7fRcVQty4MROhf76/1BrmGhxhW/eReuQOebQvKcLYcg30keno
         lnRIY7P1YMwz1t5zkOVSX5FxOowzS1QrRdKjqXnugr3WhjLR970ZxO4xnok+p9zZuAr8
         2IUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773397225; x=1774002025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+B8uqafmAg1ZCzAAhnDnZ9Muoo/hahpr6Lp382JFWr4=;
        b=AF/6VNgorn0ZLrN2kXgo9C+l6HWKSWpjhKC0Dhgj+Ysm1S3RA73YwmKw0W36u537ek
         kgZbluHgKjRmRlfej45AM7NpXIjS+NM9ydv7NsuozEVl+O3yPfxCxDolPFQM3mEMMCl6
         fgR388NYf7YsewS9SXYcWp+l0j1pZ5Qzdg9rOGS9mRDYeDnpC1WdQovyMSgKBYstU6Nu
         e+wl/7GU6UtkpYO6kIMtUSm2q3zws+Ji9pWCW/gawQ0steL+AOkZ48OgQEVChhnfpKXa
         Z+K0lvrT6R+KrT+EA5kz98KaissrQj8G5nfwwujhDpl8k6i8m9YV7BTcl+27WRCcH+IN
         msAw==
X-Forwarded-Encrypted: i=1; AJvYcCV2Miy0+AOSLwk+tZvcxfBw27SFpouw7TTUg+LheI8wp5wFLAYa07b7OlpgMbPYUGYLkvkgJ8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKfLh1X9+NHiFJvVvmwC8bGp0KZc6DVcbZA/9agPreMcfSbb3Y
	BRa26VZe0s+uoSaQ6qQ6YEeQFnPxd/5viEpa3+1sN9zl83tv9j+92xyUjnOF+m1w7tRVB3/JGVp
	81KKf1Pk8g4cSBByurXCc83ZOjEqOOYl0IE2uEcJCMQ==
X-Gm-Gg: ATEYQzyoxS7cweqeTl7VNjB78lfX7jvbzg2/qxHnl1ZbYjwDCZ+DOpUDjKRgPZ4XfKx
	ufyoyIoeLhW6xk5tddhhpqVM6dJOaW1A5aKS6zD09uslkS6YNHCshqgInpyJY8nYoa2SUAep5+c
	O4wbmiBZBjnDlYApwh7QeEwy/ARJORfBOJavZ8hQJ6Bl57V860rGadnx+/yUwo045QewQK2KVJl
	z6xee5uWXI8AEGnSXs8y5e3SepELU3L5WNB7KUQtwzAK+q0C062EMUbw+OVscdSyvHzCydIkhZV
	hIfkZbBXvESMXl6NuIwPecN6tchnDMymE4ZNoQWH2A==
X-Received: by 2002:a05:6402:5204:b0:658:3972:3a3d with SMTP id
 4fb4d7f45d1cf-663babcf3b6mr1577955a12.15.1773397224529; Fri, 13 Mar 2026
 03:20:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311152845.278354-1-justin.iurman@6wind.com>
 <20260313030220.af70f3b5f2c5d2cb7b4a840e@uniroma2.it> <CAOY2Bqz8_8iT2Auw=sWob0-XUQg-sPmdAFvzRLg+KszrU6LMqA@mail.gmail.com>
 <43e16e45-5fb1-4413-bbd1-4752bbcdec7d@6wind.com>
In-Reply-To: <43e16e45-5fb1-4413-bbd1-4752bbcdec7d@6wind.com>
From: Justin Iurman <justin.iurman@6wind.com>
Date: Fri, 13 Mar 2026 10:20:12 +0000
X-Gm-Features: AaiRm51vK-Q8dBYr1rv86TC6wilDXIPypW7VQyRgd_sYFBT0mHAsSI6ovya1eww
Message-ID: <CAOY2Bqx6jjBc5FCoRg+64v2L17bBsaAE8sy7P4JCwVXc+1n7_Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2] seg6: add per-route tunnel source address
To: nicolas.dichtel@6wind.com
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, netdev@vger.kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, justin.iurman@gmail.com, stefano.salsano@uniroma2.it
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[uniroma2.it,vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-267381-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.iurman@6wind.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[6wind.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,uniroma2.it:email,6wind.com:dkim,6wind.com:email]
X-Rspamd-Queue-Id: E62B4281595
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 9:47=E2=80=AFAM Nicolas Dichtel
<nicolas.dichtel@6wind.com> wrote:
>
> Le 13/03/2026 =C3=A0 09:44, Justin Iurman a =C3=A9crit :
> > On Fri, Mar 13, 2026 at 2:02=E2=80=AFAM Andrea Mayer <andrea.mayer@unir=
oma2.it> wrote:
> >>
> >> On Wed, 11 Mar 2026 16:28:45 +0100
> >> Justin Iurman <justin.iurman@6wind.com> wrote:
>

[snip]

> >> Whether to also reject link-local is debatable: ip6_forward() does
> >> drop it, but is there a legitimate use case where a link-local tunnel
> >> source would actually be needed?!
> >> I'd argue we should reject link-local addresses as well.
> >> For instance, using them as a tunnel source violates scope boundaries =
and
> >> breaks ICMPv6 error reporting.
> >
> > IMHO, I also think we could reasonably forbid LLs.
>
> Why rejecting LL? It's legal to use LL as a source address of a tunnel (a=
nd
> forwarding packets in this tunnel). Is this forbidden with srv6?

Well, this is indeed legal (at least nothing prevents it), but they're
not routable. So question is does it make sense at all? We're talking
about two nodes on the same layer-2 link as the only valid use-case
here. I'm not sure it makes sense, especially in the context of SRv6.

