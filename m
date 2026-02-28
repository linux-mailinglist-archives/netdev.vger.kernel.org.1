Return-Path: <netdev+bounces-262176-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qN9JGkAgo2mC9wQAu9opvQ
	(envelope-from <netdev+bounces-262176-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 18:05:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C04731C4B1C
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 18:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 058583055413
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 17:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766212F49F6;
	Sat, 28 Feb 2026 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vTRDmPta"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3837C17ADE0
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772298295; cv=pass; b=epVgMnJJNrrvx9L2ns4FgiI1TZfK++T8frU6CJ5+DlUi6jnS0zIl0Sr/LpGrQU0AD/76jYsJLpOubQ5qmk9LRQX3ln39wm1XSvCSoANOQOS6UReCYyHh0qio/3jyOD9GQdyOcKvVZrgSj2+ZaMcmBMaTZdMLGCUAjMjuvzlCbPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772298295; c=relaxed/simple;
	bh=lwcs85eb82PnM2kCqSelXTs1AsfWuMBqA/H67xN/sy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nRv01MuSpgJQQ0KGzcmLXGq7oRa4II2dnHmW0Aqhs01+CMrdB1iXOcICMlgAy2lgY0iEyYA7qM2Zs92BQKAFzy+BltQ4VOEOc5objVsluK8+EDkUsZWuNa6xWFj8uL24sR01dfAmHaxaa4S28TODRtMoMttKj14iPSMUB2qhHmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vTRDmPta; arc=pass smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-899c97c5afeso21900916d6.1
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 09:04:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772298293; cv=none;
        d=google.com; s=arc-20240605;
        b=fLx1+Xxm1HRsYr4qLDin7oiELh9DbXvkBFTuZZg5BfNyhhMotM95P/CyBzzyegeqDj
         zhrSzYxHcSYZjHk7jVpyTncC87Sm23+eSSnm8Dz8tLkA0Netfz4lw6oOHwqcMxLo/aPa
         RTwOSGhsGiS+CRFyOdVcNjkVoJukmSA3l7kmv5Jfhx1oNswmv3ijkULrFaPLkEebNJA/
         Ii7COvfRYruihUjO5c8xvvZy2IrTinXqzgqSkCaAkT4pcneBKb0Ng9H/WS3Rs9rv3ZQy
         KI04fVgVufTvczMn7AcW3OR16bypOzytq20xMx9YCvsBPruf03BRpx7r5uXgMoQ1BVIo
         z1ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lwcs85eb82PnM2kCqSelXTs1AsfWuMBqA/H67xN/sy8=;
        fh=XyZwUWFl3+EYfeMKKd0Kw8LmhSaulbmy2ojGyKAc70w=;
        b=Dq+HzXIw62Puu4GGQLpe+2SHCohBztowdFWagav8j9BkchpyGwXPR8R6JMoN01onmp
         pfmQHuDUENW/TJYcUZz4KLim5CzY+DIj3CC1ZSO4VXbxk6biNQCIw5cfaG7ioEC1rAqe
         S0qz68sTpKT9SEir7ggKy3lXdhlFFJdscgLEEf7JNNWZp8IQcjDYsO8fk3OfX7h0iVWY
         TzzrdPaTorHXZXWPwej5RQTx/aJjyY8fqkh/g/MpbemAd/l9wW0ApwcGEeHs7loxE6ma
         WRfeOa1dX7d+jDC7N38IS0TgBVxp4cAguSXGueU00yYd9PnTe5obngRuSCH4abjJUUci
         A33A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772298293; x=1772903093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwcs85eb82PnM2kCqSelXTs1AsfWuMBqA/H67xN/sy8=;
        b=vTRDmPtaNyiB8BUM2iJFFpa+Rv1tMRl2HM2ieqUpBwGrsbAsktAma9I5F6OPk9YMIo
         e0cNfDpsvOulXg37RMHod6nXdMP+hyyeQXzFk+4la10e+GbB54K6+6DwB3gtgrNGTq/f
         W5HcUq5DQ3EsYSUv1DADdmKqbtHGq/3XxHRIScOhfiZely/mAtqKQYFL0zYDzDI9zjmn
         BRGDeBJKmupKGQ58kLOaBzXbbknIZamQnvKZCojBk/zHQVZ3zISj8NTcxqMfLR7674sH
         TK8WrLShBTYuXdH59UyPPXIiCyOQ1M5Dk+6BO3HsBub8FJGYE8VbBYKRlJTIkhdJIkqE
         f89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772298293; x=1772903093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lwcs85eb82PnM2kCqSelXTs1AsfWuMBqA/H67xN/sy8=;
        b=Eeqk9UqG8HC2+X3KeySj4YTR7MpkZgZnacjKDaWKZVAWX/WO7Y5lND8WFpAAuholJk
         xZj0kmjiCtATmDh6pDilnjKa50mJH9wuK5veOwyYeXwxppKFobCocQYZwql5WKMnfhqU
         ykHuDaPjAj01bkFsWFLLxd7U6zIKQXB0xh6mFQJ7NlfEu1KemklzlzCa13TyXmy2BQsV
         SWiBTWzoKCKdmxT74aYiXe/VeCZSIdUbFWuqj3t+LVJbN8ejeozmocdwKgtFuW6eaQQa
         2Jm+4a9OzXCkQMJQKaq3ODOaZ3gv/e1z5AHu1A1eZzrO+LJ+K4nVBs2hLKkUU4Re8/Dz
         n2bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLB6/vBzeRw9796tCpduLuldjSNb6tfvr6nwinAPqGbtG5LCd9m00ct0f5HvDpImYb+h0a85A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5R57gMxITiBv9uCqMEH84WO5qfyvXXBXi+VsrI0Eqv+daHyeP
	7F0mNr18FOF/a5bILMr0rPY6DP/q4Pisyoxlx7gNw2diMvjTCjNOeZA7+cZSUrVlDJvMMVf+8xk
	QLQ0kR8Ht3nhXGBQ/1PSFtCBgXvOOud17QT0QdbN0
X-Gm-Gg: ATEYQzwQPuVlOlYQxTofNvpUWjpIJ6+bQ2SFrny7zjkm6UeuvfZAU2OZDU3GV3d6+5J
	fh2pDn7qttGN6cAnjBTBNCsRHM0OFQ4QKHv1ekXGnZRc1pZed4iN/isOGv6xrKKkkrGXU1vWR4n
	S92CG8SxaERpTb1PPJyW7SMwtTODb2NloADYCVuQQofHVmi2GShk4O2pZnroOQnbjofp8dLlc4K
	R3sY8VbOW5ZUtEWOlUdvLhH/9bat1ff7BqAjd3hXVtrHl2HV534I/ELNznwitVMuvm6mFKJIcbE
	rlUIGEhR
X-Received: by 2002:a05:622a:190f:b0:4f1:e9f7:4dee with SMTP id
 d75a77b69052e-5075296e804mr87241821cf.35.1772298292636; Sat, 28 Feb 2026
 09:04:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228031400.163009-1-jiayuan.chen@linux.dev>
 <20260228073959.0ef1b33f@kernel.org> <3a00c5bf-6740-47c3-b885-c1e0cfe62289@kernel.org>
In-Reply-To: <3a00c5bf-6740-47c3-b885-c1e0cfe62289@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 28 Feb 2026 18:04:41 +0100
X-Gm-Features: AaiRm53zZdYxj0hgST7r2_w0rWkvWB9gb4T2R6wOkVmpmm9_S0sYQUiXbiVmCQk
Message-ID: <CANn89iJjjNW4U6ZxVcuRxWaKPbo1wfEyBD4Etkf+f6CWyhAHFg@mail.gmail.com>
Subject: Re: [PATCH net v1] net: nexthop: fix panic when IPv4 route references
 IPv6 nexthop
To: David Ahern <dsahern@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
	Jiayuan Chen <jiayuan.chen@shopee.com>, 
	syzbot+334190e097a98a1b81bb@syzkaller.appspotmail.com, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262176-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,334190e097a98a1b81bb];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shopee.com:email,gre_multipath_nh.sh:url,fib_nexthops.sh:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C04731C4B1C
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 5:33=E2=80=AFPM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 2/28/26 8:39 AM, Jakub Kicinski wrote:
> > On Sat, 28 Feb 2026 11:13:59 +0800 Jiayuan Chen wrote:
> >> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> >>
> >> fib_check_nexthop() does not validate that the nexthop family matches
> >> the route family. This allows an IPv4 route to reference an IPv6
> >> nexthop object. When the IPv4 route is looked up, __mkroute_output()
> >> accesses nhc->nhc_pcpu_rth_output which is never allocated for IPv6
> >> nexthops (fib6_nh_init does not call fib_nh_common_init), causing a
> >> NULL pointer dereference.
> >>
> >> Note that this is not about IPv4 routes with IPv6 gateways (RFC 5549),
> >> which uses an AF_INET nexthop with nhc_gw_family=3DAF_INET6 and proper=
ly
> >> allocates nhc_pcpu_rth_output via fib_nh_common_init(). The bug here
> >> is an AF_INET6 nexthop object being directly referenced by an IPv4
> >> route, which is an invalid combination.
> >>
> >> Add the missing family check in fib_check_nexthop(), mirroring what
> >> fib6_check_nexthop() already does for the reverse direction (rejecting
> >> IPv6 routes that reference IPv4 nexthop objects).
> >
> > AFAICT this breaks a bunch of tests, quickest to repro with is
> > gre_multipath_nh.sh but you should probably run fib_nexthops.sh
> > on your fix as well.
> >
>
> nothing to fix. The patch is wrong. IPv4 supports IPv6 gateways; that is
> a known feature.
>
> please post the stack trace for the panic

https://lore.kernel.org/all/698f8482.a70a0220.2c38d7.00ca.GAE@google.com/T/

