Return-Path: <netdev+bounces-281806-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHGNC3qb8Gl3WAEAu9opvQ
	(envelope-from <netdev+bounces-281806-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:35:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2639483E34
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F11EE30544C0
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 11:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82F9407586;
	Tue, 28 Apr 2026 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fHtWFyYk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8273FE342
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777375289; cv=pass; b=jI9Hkqh/+fC4C377KIvoh1f5H4RHirv8B+VyxYL6nv0Oq9GRKzhLUEqvnFDL55a9YwZ3z+RDuej41bv9ETEDq7I2brzvhO0NCnbSUoNrw9ffj7OHhokKE17OCBVqhWFQuv2Ua3VZ1SQYpKlHoSeN/fL+g2qMxHr+2WADhEYsbEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777375289; c=relaxed/simple;
	bh=7hoGj8/xuNHMHGnipzfbn6G/BSAJOVMpf5JmEo1pNO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z51CpUz50NmLbTKRr9oV4a1d1LyWTRIAQnMyGBTxmbJOCI39ZkaETsnZ3vn9VQMKjVlX3hrgqR6FZS+B8qar78GticfmgC6yRPrpQZbVprCHVAg5VmUKhbfKvbQLqM7QlYTacD/JjpWgShf5u7E/IcSd7nx/MTnsQcy8FlK4ihM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fHtWFyYk; arc=pass smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8eab809593cso977225485a.3
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 04:21:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777375287; cv=none;
        d=google.com; s=arc-20240605;
        b=ZScPuAOIghln3GFFO7jFiPMonWPhSab5IX681IbD0BOU+YLACTsvlUD8tDIYE6AtEP
         zXUryRovmE46J2IV9oj6mDST0uOU/B0zJe/LARpm78J61QirlSIcDvlOpx57gI2jpKl9
         Hk3YT7wPqPnXNJ0XJq91hrGFncWzeRzLD/saVegGwlgeFo1pUx21ZdPd6ZVGmguzC0+j
         u9NcT6tP+QuUM2HLWvHgTZ1CprgjTo044z3kGdkFbTMxq8J9H7FqSr1vKvV+nGfD60t/
         xf1BKoGdzDUrQzRB27KzdaOxWuxjm94aEjeO0L1S9rpgPa0jJVJPPZarXNoRpn4Ze1zl
         SG7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7hoGj8/xuNHMHGnipzfbn6G/BSAJOVMpf5JmEo1pNO0=;
        fh=LLAzGqP2Gh9EIp9xewe1+RcN3ISVvibZyc/avGKj+uc=;
        b=Aoxwucu0UlsiqDYNghUUAHZ3/633sKzZrDz5Qdxcpyhrs32Kuu+i+K8qQOj5vPzD47
         KzKVSV0H1UL1HpEUwXQyph/xIVWVV4huim4mVVH7/iE6ff7urHnUN8jSep9sAmfC40eT
         KJhn5PGNW5DcnbMHFPXgn6cJn2qQPJfACgTXwIlvHcgKw56yMSWnURhYDWJy04RVQhdl
         uWYUMVFoJC0Hnq/c7Jpq19S++oW4fCfZLneaHeo6jVuIeDCv8tiSI/ekgxkdhCw+dY18
         GbAr6TqSVoCowegExXMpCv0MhWJc98KC/J3NvEeu1xGjSwQ4xkzDtqv6cfHvSNq1IR/O
         jf6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777375287; x=1777980087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hoGj8/xuNHMHGnipzfbn6G/BSAJOVMpf5JmEo1pNO0=;
        b=fHtWFyYkGiXWbruSBwdLdiIYVcsM86ZR3y6Fd549rx+NazqYR1CzaJCY9c2Damjsj4
         G/BO6Y/cWBZrCTVNMLV9XWuBFFeMiIYmEiT6RYmDenkkRfEv6Gf60eemeT/b+FOBOULN
         6MERbUDiQwJXk4Tj41lzmLlUO5DgjZTp16VSYye0n6OF7h4ZoCuRJhYwACgfVdFHDqFZ
         iDV3c6Q8//+5aSKY05tVJMSa74IbPku3sVLI9PtTQCTtiAFwb327Ya8PBkzokeVzEvui
         07bW5WOk/4X/jw1rRG/In+7X1GDVORMpu2qlxrCCkZpbEwnh1zInBzfdCvSqcpFLiHTx
         dCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777375287; x=1777980087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7hoGj8/xuNHMHGnipzfbn6G/BSAJOVMpf5JmEo1pNO0=;
        b=eGwVmzOnChzCusIbYv1uH6ZIPtVcjHfDq48+f9vG5w/miw3MH5dM1BGUXFBaHuNoAJ
         dYQlEJ0R7FdwRJkA2X0NYNExelzI1iuxf1bFHBYxdPU2VL0ZkNC/99e2iHmr4ZbJr3Oq
         cE2iTnw9giHptYphHksqUVKyLEOOb78gIKZeyjo+tu7WGCSJ/hd3V3ARGllg5cNE7Q+K
         5ufZ/Qg+qMyI/CFaHQ7do0pB1Aae9ZakD9IRpuR8vV0LV9yx0QR3rQbx2QoyP90xZkqR
         GMgXM+AAsJ00FfukYAbE80XXCfEA579Xw/uG1FdS0nIYUyEMkwKdyjr+YWnEl9KQzVng
         QVkA==
X-Forwarded-Encrypted: i=1; AFNElJ+LDNLoeWtonLRU0kisNFAsmL5IypTSqOACnSRcXyaEuK6ti3C6r1JdQZCduMfXY6Dl7xRasx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO+NcRvgUyHuiph4EBhzxSCyiPLLJp8PkmBZxevcCLCm3u3Tyz
	koxslbllyt2X1OwYylsd4FWZSocl7+pTQ5BRuY8YHyT0aP837weN2ghuCfY4g54QTxWhwNqo3Nt
	Mbz4jUEzHprDDU1CAAWT+XO+jKdL9BD1HGV/2lvXO
X-Gm-Gg: AeBDietMi+2eUuAaWGe8PxgizmaCWQIxayNOeiMaHza1MwmXVQkTNxCbh0ZrvUY6Z7M
	pYqZeDiFsX6c/K8KHvzki4iQZr2Qc17GbfOsrwAFRbSryud8+Puv5cNRem8EqL7wXrWri00LZHL
	8wWsUK3KP9d0qcX43A8EIzdA+1ZOFOSoVvduunykIo0hSCquuiL+ABPp5dglvLY3mU0hyZ11fKZ
	7Rm8cvQhXQ3fBLOLKafg3rOCyZog7i6GReGpsPQU+TXK9zuxpinBo1K1HerTsuhgckp2WXTfRa5
	MoHkR+Tm924CE07W5UIdacEILf27o6y4okT9LFadTNb1lSEJKVwi+50afTeXQh5mpfzXrXfPWmr
	4tNf2BWF/
X-Received: by 2002:a05:622a:4d4c:b0:50e:614e:4433 with SMTP id
 d75a77b69052e-5100e19ab26mr32850641cf.30.1777375286472; Tue, 28 Apr 2026
 04:21:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427224243.3499162-1-sharmasagarika@google.com>
 <20260427224243.3499162-2-sharmasagarika@google.com> <20260428110708.GA571865@shredder>
In-Reply-To: <20260428110708.GA571865@shredder>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Apr 2026 04:21:15 -0700
X-Gm-Features: AVHnY4LMXCaEBa5uvR4wqE0QzYjHTahqHeIugW5yAVMSZFazKczpzJjPrXgJqLU
Message-ID: <CANn89i+aaWE11Fttpdbq-OvFAkhtkqQwkWzDACvh=Do_wStJqw@mail.gmail.com>
Subject: Re: [PATCH net v1 1/2] ipv6: update route serial number on NETDEV_CHANGE
To: Ido Schimmel <idosch@nvidia.com>
Cc: Sagarika Sharma <sharmasagarika@google.com>, "David S . Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D2639483E34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281806-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,nvidia.com:email]

On Tue, Apr 28, 2026 at 4:07=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Mon, Apr 27, 2026 at 10:42:22PM +0000, Sagarika Sharma wrote:
> > When using IPv6 ECMP routes, if a netdev listed as a nexthop experience=
s
> > a carrier change event (e.g., a bond device generating a NETDEV_CHANGE
> > event after its slaves go linkdown), established connections utilizing
> > that nexthop fail to fail over to other available nexthops. Instead,
> > these connections stall or drop.
> >
> > This happens because the IPv6 FIB code does not invalidate the socket's
> > cached destination when a NETDEV_CHANGE event occurs. While
> > fib6_ifdown() correctly marks the nexthop with RTNH_F_LINKDOWN, it
> > leaves the route's serial number unchanged. As a result, sockets with a
> > previously cached dst do not realize the route is no longer viable and
> > continue to try using the non-functional nexthop.
> >
> > This behavior contrasts with IPv4, which actively flushes cached
> > destinations on a NETDEV_CHANGE event (see fib_netdev_event() in
> > net/ipv4/fib_frontend.c).
> >
> > Fix this by updating the route serial number in fib6_ifdown() when
> > setting RTNH_F_LINKDOWN. This invalidates stale cached destinations,
> > forcing sockets to perform a new route lookup and fail over to a
> > functioning nexthop.
> >
> > Fixes: 51ebd3181572 ("ipv6: add support of equal cost multipath (ECMP)"=
)
> > Signed-off-by: Sagarika Sharma <sharmasagarika@google.com>
> > Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks!

