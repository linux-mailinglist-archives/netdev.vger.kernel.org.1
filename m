Return-Path: <netdev+bounces-146841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 670DF9D6381
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 18:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8A3A160428
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 17:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3D6158848;
	Fri, 22 Nov 2024 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vRpdBDfe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661BF1DE3CF
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 17:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732297543; cv=none; b=SB4rt8QqqctBqYA/JjqUy6EAdHPCSC2Y0Qwf2ZFK/ec9V4TKYdh2bxtj3Xr0JY507dpnE/zzHE9OBRqAJbenaXJhwtd42OqCA3Fg6vYQsoYFKGx0NLawDe9E/k3bEzJeEwLyB1d6Hy+gjxB9s8NznZr6s4XttTXeC7aQCY1pwvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732297543; c=relaxed/simple;
	bh=GzDOHvjcxzQzuwVAI8aacTcXN5qiXjiblZ5GPw3Jb3Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cUXA1SbyjJ3YlcJbqMAXw7Byd5erPllOTW40jeacnmEfSdGMl2cJZy4ycon12cqmC8kTASEKME5C/KX9UxryreJSpTVf5h74TSZ9deNRHPMPwcV/iz23YsdOlWAM/rO+SfAJr56EhN56W8IT8d5WHzIsu9Qi9geqK4OA1ZpRGF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vRpdBDfe; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e38797ab481so4686051276.0
        for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 09:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732297539; x=1732902339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2veOvqcd8OHbMSkqCARfAafTZ6QmJgZjD8FJhS72cj8=;
        b=vRpdBDfeZKirbaifT7cm6tGWj+NmTJqH2PcBSHg15AvkOuBDbM0DReW9stZGADx4tU
         ZV91SL7cuwoCB7ODiAe4BwQYWQ+KM8qa3bpc/G1Or56Eu5f+IO5nRuKq+PlfdBh62/v5
         Bp1wQhzbdZZE1OtVVQzHRY5tyv4KD/Om1LvD9Mjo1qQQN7KmQjR9DPm4wSZoV66phdxM
         hRETn6JuqnOrve0nMcTeNqemT6ZhYPTJmV+vyqUCnO4bP95aagoEiFJYpbxyX1Buzht0
         cm1QaxXbDqefieOv98LUvcmMN2eq/wtuLAWCPBJs5uD8AvbTRC8FNAyFmX/Abjx23AOz
         qdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732297539; x=1732902339;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2veOvqcd8OHbMSkqCARfAafTZ6QmJgZjD8FJhS72cj8=;
        b=vPX7DQzy+YJQxUSiNeybupts/J9HBlEPQV1H/GFpRvc915OMDMifsjpJ9rn1scRTOE
         Bw9r+jLAAzzkuuqI3X+bMTbLTlAT2ZwWt3BcSl8fUTP8Px5JqjFjI86K2ROSaGEyNbkU
         Cdo1VDT9fxCZaKYAr3YQ/yTPc1NIRkD5jQUP4DYFxDklEeq+dAcmJ0EEbGA/dHuMZaAT
         X6goXs5PHMHEm4A2EOXGgJB1KudoObNbpa5Sv3T/Kql8k4+8w2GDbZQT5xPjkT9Ere2B
         1qeQy7dPiDoVQkSgdzRFQzZ7IeJhTfCz0ZWP6iMLqLnwqJY8FrldmgCUk2Q6pbUcAgR5
         ENOw==
X-Forwarded-Encrypted: i=1; AJvYcCVSfPwWhtrj+ZoDu0fsXBFvKne4GMI/LW3Pc3/C4LG7qXhVnJ1RdaLeh8WxV6alelUC3Ph8F8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyue80aTLj1PSz31v6m6At2cTimjbc07hYG5LHouJCM3/FnhMRy
	k3x5q5iJZEYGtqyVKzQybz5kD4BNbGQMjzKJ5MgYY4GfkRBCbGgwMZ4JqwZ0QrAk1cYH5BggXu3
	eOA==
X-Google-Smtp-Source: AGHT+IHpEH/kPLV9idcYzJND6POdq3yx44U5bnV0sZuSwFiXFLFRZYwm6InrSGcTHIk7sCXgXu9JFIe7vzc=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a25:d802:0:b0:e38:1f5f:485a with SMTP id
 3f1490d57ef6-e38f8acc967mr1566276.1.1732297539121; Fri, 22 Nov 2024 09:45:39
 -0800 (PST)
Date: Fri, 22 Nov 2024 18:45:36 +0100
In-Reply-To: <ea026af8-bc29-709c-7e04-e145d01fd825@huawei-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240904104824.1844082-1-ivanov.mikhail1@huawei-partners.com>
 <20240904104824.1844082-2-ivanov.mikhail1@huawei-partners.com> <ea026af8-bc29-709c-7e04-e145d01fd825@huawei-partners.com>
Message-ID: <Z0DDQKACIRRDRZRE@google.com>
Subject: Re: [RFC PATCH v3 01/19] landlock: Support socket access-control
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: mic@digikod.net, willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, yusongping@huawei.com, 
	artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Mikhail,

sorry for the delayed response;
I am very happy to see activity on this patch set! :)

On Mon, Nov 11, 2024 at 07:29:49PM +0300, Mikhail Ivanov wrote:
> On 9/4/2024 1:48 PM, Mikhail Ivanov wrote:
> > Landlock implements the `LANDLOCK_RULE_NET_PORT` rule type, which provi=
des
> > fine-grained control of actions for a specific protocol. Any action or
> > protocol that is not supported by this rule can not be controlled. As a
> > result, protocols for which fine-grained control is not supported can b=
e
> > used in a sandboxed system and lead to vulnerabilities or unexpected
> > behavior.
> >=20
> > Controlling the protocols used will allow to use only those that are
> > necessary for the system and/or which have fine-grained Landlock contro=
l
> > through others types of rules (e.g. TCP bind/connect control with
> > `LANDLOCK_RULE_NET_PORT`, UNIX bind control with
> > `LANDLOCK_RULE_PATH_BENEATH`). Consider following examples:
> >=20
> > * Server may want to use only TCP sockets for which there is fine-grain=
ed
> >    control of bind(2) and connect(2) actions [1].
> > * System that does not need a network or that may want to disable netwo=
rk
> >    for security reasons (e.g. [2]) can achieve this by restricting the =
use
> >    of all possible protocols.
> >=20
> > This patch implements such control by restricting socket creation in a
> > sandboxed process.
> >=20
> > Add `LANDLOCK_RULE_SOCKET` rule type that restricts actions on sockets.
> > This rule uses values of address family and socket type (Cf. socket(2))
> > to determine sockets that should be restricted. This is represented in =
a
> > landlock_socket_attr struct:
> >=20
> >    struct landlock_socket_attr {
> >      __u64 allowed_access;
> >      int family; /* same as domain in socket(2) */
> >      int type; /* see socket(2) */
> >    };
>=20
> Hello! I'd like to consider another approach to define this structure
> before sending the next version of this patchset.
>=20
> Currently, it has following possible issues:
>=20
> First of all, there is a lack of protocol granularity. It's impossible
> to (for example) deny creation of ICMP and SCTP sockets and allow TCP
> and UDP. Since the values of address family and socket type do not
> completely define the protocol for the restriction, we may gain
> incomplete control of the network actions. AFAICS, this is limited to
> only a couple of IP protocol cases (e.g. it's impossible to deny SCTP
> and SMC sockets to only allow TCP, deny ICMP and allow UDP).
>=20
> But one of the main advantages of socket access rights is the ability to
> allow only those protocols for which there is a fine-grained control
> over their actions (TCP bind/connect). It can be inconvenient
> (and unsafe) for SCTP to be unrestricted, while sandboxed process only
> needs TCP sockets.

That is a good observation which I had missed.

I agree with your analysis, I also see the main use case of socket()
restrictions in:

 (a) restricting socket creating altogether
 (b) only permitting socket types for which there is fine grained control

and I also agree that it would be very surprising when the same socket type=
s
that provide fine grained control would also open the door for unrestricted
access to SMC, SCTP or other protocols.  We should instead strive for a
socket() access control with which these additional protocols weren't
accessible.


> Adding protocol (Cf. socket(2)) field was considered a bit during the
> initial discussion:
> https://lore.kernel.org/all/CABi2SkVWU=3DWxb2y3fP702twyHBD3kVoySPGSz2X22V=
ckvcHeXw@mail.gmail.com/

So adding "protocol" to the rule attributes would suffice to restrict the u=
se of
SMC and SCTP then?  (Sorry, I lost context on these protocols a bit in the
meantime, I was so far under the impression that these were using different
values for family and type than TCP and UDP do.)


> Secondly, I'm not really sure if socket type granularity is required
> for most of the protocols. It may be more convenient for the end user
> to be able to completely restrict the address family without specifying
> whether restriction is dedicated to stream or dgram sockets (e.g. for
> BLUETOOTH, VSOCK sockets). However, this is not a big issue for the
> current design, since address family can be restricted by specifying
> type =3D SOCK_TYPE_MASK.

Whether the user is adding one rule to permit AF_INET+*, or whether the use=
r is
adding two rules to permit (1) AF_INET+SOCK_STREAM and (2) AF_INET+SOCK_DGR=
AM,
that does not seem like a big deal to me as long as the list of such
combinations is so low?


> I suggest implementing something close to selinux socket classes for the
> struct landlock_socket_attr (Cf. socket_type_to_security_class()). This
> will provide protocol granularity and may be simpler and more convenient
> in the terms of determining access rights. WDYT?

I see that this is a longer switch statement that maps to this enum, it wou=
ld be
an additional data table that would have to be documented separately for us=
ers.

Do you have an example for how such a "security class enum" would map to th=
e
combinations of family, type and socket for the protocols discussed above?

If this is just a matter of actually mapping (family, type, protocol)
combinations in a more flexible way, could we get away by allowing a specia=
l
"wildcard" value for the "protocol" field, when it is used within a ruleset=
?
Then the LSM would have to look up whether there is a rule for (family, typ=
e,
protocol) and the only change would be that it now needs to also check whet=
her
there is a rule for (family, type, *)?

=E2=80=94G=C3=BCnther

