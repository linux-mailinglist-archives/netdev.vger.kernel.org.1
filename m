Return-Path: <netdev+bounces-302074-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vQ0SJPeePWqD4wgAu9opvQ
	(envelope-from <netdev+bounces-302074-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 23:34:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 427CF6C8C4C
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 23:34:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.s=20251104 header.b="QpS/JOYV";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302074-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-302074-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=networkplumber.org (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5F4F03015C9A
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 21:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98352FC898;
	Thu, 25 Jun 2026 21:34:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8DF1C84A2
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 21:34:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782423281; cv=none; b=PY/LuHobrEmNGEMXukRNG2TyO7FMcsuhRJ+9uXO+DWgSuGqp4RV2GLNTVGYqmBdG9TVGz6YX8Bu9IN86P6Unkf2T4StcnJSqUypvJ77wTCSAqcWEzt/0Q6IfKxhVwSo0kbR4UneGTEhTXASEBh6+FaCx1QO3sIrJMOgw3sf7gp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782423281; c=relaxed/simple;
	bh=m7riEsHTEU0WwlQdON33yglybPtxhEV4cOV/iQTL6mA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=okGpj4qfgzhBi10FSToXFbpHlyYeJzbL6QwIPWhFDdmbcEszeUjjxxsK1hMWbERjh6y/iLz4gUUGtVyNqWsGal1l2fwfTN3I5hSKA7faAWwybqG91ztzKPZMG52vUowIsBLEbe699+mMrhVALMgxz0cF/AKYmnrQdWMHBXzZq68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=QpS/JOYV; arc=none smtp.client-ip=74.125.82.43
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1390f75d8bbso85067c88.0
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 14:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782423279; x=1783028079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ljH/KMgLH7Lrbue8zNvL1sbxgsVhEOc7v3lh4fLKh4k=;
        b=QpS/JOYVXbi0Jaucgm3n2eOBjilIPnE70j+z5TyLKksiG+cIjGt2I4b3w6b04gkvDq
         6ekCQOByIqDBw7jSjf7Rfck8O1KA5uGhjsblT1pY8xsI2SN7bjrK3IBgQdltGtbec4aV
         ngFf9JdXQim4YQaeqzgm/RHoeE2qa1R4mWRHql0TK3066DbPU/v3mw648Bbg9Bud17Xn
         Dv1yWLd9AeW1hEbD5r7xIG01dAXQw+taThM4T8c2UgdHejGT6D1phlrwQ57rweOTNLsM
         NtnpGWD+EB3+232v1dv8r9MzmtZMZkzdj6QcNbOQd/3KiJM1TRQq4qe/RHBm1d6/e1KL
         4dLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782423279; x=1783028079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ljH/KMgLH7Lrbue8zNvL1sbxgsVhEOc7v3lh4fLKh4k=;
        b=G+Xv9Za8gPye6u56V1nMN85cS0Lo8IJaUVbyuUtUihEX/ZUAU3JFvhqCIE3PHwBACX
         tG7GBtDewNtOARbgLRZE2QMoYVmigskkzT+Gif4vCOIvQg/HjiL/6oWg4iVrIFl+IVce
         ga/wJwJXUCMaZFRtyBFg90Na1Ky0oIZLUSQXq6GnMn65TjICeUEWsFDqbtSk9Zb8LtqD
         vpItrMUjn/rOXHQZpMScJd65AcVte5DzI8KqbJatcd921levRX5JlFZDR5keDuLaPUft
         3vs/6JMqabiV3briM5qsC5niGOz+psk7Fp5A48rW+R/T7PmaBgegTAPLthV36gDTEF8R
         K3GA==
X-Gm-Message-State: AOJu0YzhjH9oMg0oJU2X5Wh4ULp6r6WBiR3MmPkayc72m+XOgk/FsTpF
	+ONPvK0YYy8Hu1mH44KR9NfDqdV9gBcBL877oxVJKzjjfeQbFw+GKXIomMU9nWia70I=
X-Gm-Gg: AfdE7cnEUbn/TBsng1DHmFINn6B5LquClrFo+daKMHTsRbsh/+XLYWE/7Qw5a83oMmT
	geyscdIo4AGSOoQt5IiiJLqtl6ThlhbgzcqvA2dLjmjlP6xhlc6uld4YduMuPnndfFr1cbjmQjX
	WuiCgIiaYO8whoAC0mmDLKpZ+pj+T79qI2bp8CRtM1/NmC08w+f4+hD5Yi8GWMwXh6JFejkmwaM
	KqSMx88w3ZyIfqqMka4kGFVXl8Q0y3epPBrRCX46JgY3UeKeHY84MmuVCZwM72QeQlzs314JPP4
	0l5o2dTwZ/BMgJGKJYOX7akJUipEp6RZPoKBlhuj9JsOIltfFGGX5bfgtYl4v3cdxZEzj/7WB8l
	r7ycCEccCmn9ewh/5oC+jlRh9zRuwnyq80va+p6nKGFXUb4k850J4L+e7uVF8t8+/VShdX2Tphf
	5geZvisZjS8gZJUInctaicnXBIfSCCJPgEsUsl8KPc7JlkJOilXIac2w==
X-Received: by 2002:a05:7022:7f15:b0:139:819b:3b86 with SMTP id a92af1059eb24-139dbb6ace5mr2520082c88.32.1782423278809;
        Thu, 25 Jun 2026 14:34:38 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d91006bcsm12076300c88.13.2026.06.25.14.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 14:34:38 -0700 (PDT)
Date: Thu, 25 Jun 2026 14:34:35 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dmitri Seletski <drjoms@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] "ip help" wrong output, exit code.
Message-ID: <20260625143435.6147e1d9@phoenix.local>
In-Reply-To: <65f53987-c992-41b9-9603-9e9a448e469d@gmail.com>
References: <62f09fe8-899c-4d22-b7a1-67e2745613df@gmail.com>
	<20260621082105.1196ef72@phoenix.local>
	<069b13e1-f689-410b-bd40-b5e5831b67e7@gmail.com>
	<20260622075700.27806286@phoenix.local>
	<20260622174454.576b3580@pumpkin>
	<3d6f256c-3bd0-441a-bece-8692985c5ddc@gmail.com>
	<65f53987-c992-41b9-9603-9e9a448e469d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:drjoms@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-302074-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,phoenix.local:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 427CF6C8C4C

On Thu, 25 Jun 2026 16:54:29 +0100
Dmitri Seletski <drjoms@gmail.com> wrote:

> I am confused.
>=20
> Whats the next step here?
>=20
> Regards
>=20
> Dmitri
>=20
> On 6/22/26 18:47, Dmitri Seletski wrote:
> > Hello David,
> >
> >
> > Based on change introduced:
> >
> > Two samples of "ip help" with demonstration of exit code and standard=20
> > output are below.
> >
> > This is in line with what expect.
> >
> >
> > dimkosPC~/compiled/iproute2-next #if ./ip/ip help a >>/dev/null =C2=A0;=
=20
> > then echo help triggered =C2=A0; else echo error code triggered =C2=A0;=
fi =C2=A0#this=20
> > redirects standard output =C2=A0to /dev/null, so text missing is not er=
ror,
> > but standard text
> > help triggered
> >
> > dimkosPC~/compiled/iproute2-next #if ./ip/ip help =C2=A0=C2=A0; then ec=
ho help=20
> > triggered =C2=A0; else echo error code triggered =C2=A0;fi
> > Usage: ip [ OPTIONS ] OBJECT { COMMAND | help }
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ip [ -force ] -batch filename
> > where =C2=A0OBJECT :=3D { address | addrlabel | fou | help | ila | ioam=
 |=20
> > l2tp | link |
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0macsec | maddress | monitor | mptcp =
| mroute | mrule |
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0neighbor | neighbour | netconf | net=
ns | nexthop |=20
> > ntable |
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ntbl | route | rule | sr | stats | t=
ap | tcpmetrics |
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0token | tunnel | tuntap | vrf | xfrm=
 }
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0OPTIONS :=3D { -V[ersion] | -s[tati=
stics] | -d[etails] | -r[esolve] |
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-h[uman-readable] | -iec | -j[=
son] | -p[retty] |
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-f[amily] { inet | inet6 | mpl=
s | bridge | link } |
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-4 | -6 | -M | -B | -0 |
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-l[oops] { maximum-addr-flush-=
attempts } | -echo |=20
> > -br[ief] |
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-o[neline] | -t[imestamp] | -t=
s[hort] | -b[atch]=20
> > [filename] |
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-rc[vbuf] [size] | -n[etns] na=
me | -N[umeric] |=20
> > -a[ll] |
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-c[olor]}
> > help triggered
> >
> > Two samples of command that is broken on purpose.
> >
> > dimkosPC~/compiled/iproute2-next #if ./ip/ip idontexist =C2=A0=C2=A0; t=
hen echo=20
> > help triggered =C2=A0; else echo error code triggered =C2=A0;fi
> > Object "idontexist" is unknown, try "ip help".
> > error code triggered
> >
> > dimkosPC~/compiled/iproute2-next #if ./ip/ip idontexist =C2=A0>>/dev/nu=
ll=20
> > =C2=A0; then echo help triggered =C2=A0; else echo error code triggered=
 =C2=A0;fi=20
> > =C2=A0#this redirects standard output =C2=A0to /dev/null, so text missi=
ng is not=20
> > error, but standard text
> > Object "idontexist" is unknown, try "ip help".
> > error code triggered
> >
> > This works as expected as per my understanding.
> >
> >
> > Not everything is fixed, but chunk of things fixed is better than non=20
> > of it.
> >
> > for example:
> >
> > if ip =C2=A0add help =C2=A0=C2=A0=C2=A0; then echo help triggered =C2=
=A0; else echo error code=20
> > triggered =C2=A0;fi =C2=A0#this redirects standard output =C2=A0to /dev=
/null, so text=20
> > missing is not error, but standard text
> > Usage: ip address {add|change|replace} IFADDR dev IFNAME [ LIFETIME ]
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0[ CONFFLAG-LIST ]
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ip address del IFADDR dev IFNAME [m=
ngtmpaddr]
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ip address {save|flush} [ dev IFNAM=
E ] [ scope SCOPE-ID ] [ to=20
> > PREFIX ]
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0[ FLAG-LIST ] [ label LABEL ] [ { up | down=20
> > } ]
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ip address [ show [ dev IFNAME ] [ =
scope SCOPE-ID ] [ master=20
> > DEVICE ]
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
[ nomaster ]
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
[ type TYPE ] [ to PREFIX ] [ FLAG-LIST ]
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
[ label LABEL ] [ { up | down } ] [ vrf NAME ]
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
[ proto ADDRPROTO ] ]
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ip address {showdump|restore}
> > IFADDR :=3D PREFIX | ADDR peer PREFIX
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ broadcast ADDR =
] [ anycast ADDR ]
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ label IFNAME ] =
[ scope SCOPE-ID ] [ metric METRIC ]
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ proto ADDRPROTO=
 ]
> > SCOPE-ID :=3D [ host | link | global | NUMBER ]
> > FLAG-LIST :=3D [ FLAG-LIST ] FLAG
> > FLAG =C2=A0:=3D [ permanent | dynamic | secondary | primary |
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[-]tentativ=
e | [-]deprecated | [-]dadfailed | temporary |
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0CONFFLAG-LI=
ST ]
> > CONFFLAG-LIST :=3D [ CONFFLAG-LIST ] CONFFLAG
> > CONFFLAG =C2=A0:=3D [ home | nodad | mngtmpaddr | noprefixroute | autoj=
oin ]
> > LIFETIME :=3D [ valid_lft LFT ] [ preferred_lft LFT ]
> > LFT :=3D forever | SECONDS
> > ADDRPROTO :=3D [ NAME | NUMBER ]
> > TYPE :=3D { amt | bareudp | bond | bond_slave | bridge | bridge_slave |
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dsa | dummy | ers=
pan | geneve | gre | gretap | gtp | hsr |
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ifb | ip6erspan |=
 ip6gre | ip6gretap | ip6tnl |
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ipip | ipoib | ip=
vlan | ipvtap |
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0macsec | macvlan =
| macvtap | netdevsim |
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0netkit | nlmon | =
pfcp | rmnet | sit | team | team_slave |
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0vcan | veth | vla=
n | vrf | vti | vxcan | vxlan | wwan |
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0xfrm | virt_wifi }
> > error code triggered
> >
> > This is still problematic.
> >
> >
> > But so far code leaves "ip help" command/argument in better shape than=
=20
> > it found it in.
> >
> >
> > I may try improve things more, but lets submit what we already have=20
> > "better", please.
> >
> > Kind Regards
> >
> > Dmitri Seletski
> >
> >
> > On 6/22/26 17:44, David Laight wrote: =20
> >> On Mon, 22 Jun 2026 07:57:00 -0700
> >> Stephen Hemminger <stephen@networkplumber.org> wrote:
> >> =20
> >>> On Sun, 21 Jun 2026 22:48:59 +0100
> >>> Dmitri Seletski <drjoms@gmail.com> wrote:
> >>> =20
> >>>> =C2=A0From 0805e07105cd15c5b94271a4706e50e3c65dbde5 Mon Sep 17 00:00=
:00=20
> >>>> 2001
> >>>> From: Dmitri Seletski <drjoms@gmail.com>
> >>>> Date: Sun, 21 Jun 2026 22:12:43 +0100
> >>>> Subject: [PATCH iproute2-next] =C2=A0"ip help" wrong output, exit co=
de.
> >>>>
> >>>> Changed output of "ip help" from standard error to standard output.=
=20
> >>>> And
> >>>> Exit is now 0 instead of -1. "ip help|grep bridge" - now gives bridge
> >>>> syntax instead of flooding user with everything from "ip help".
> >>>> ---
> >>>> ip/ip.c | 4 ++--
> >>>> 1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/ip/ip.c b/ip/ip.c
> >>>> index e4b71bde..4627b61c 100644
> >>>> --- a/ip/ip.c
> >>>> +++ b/ip/ip.c
> >>>> @@ -56,7 +56,7 @@ static void usage(void) __attribute__((noreturn));
> >>>>
> >>>> static void usage(void)
> >>>> {
> >>>> -fprintf(stderr,
> >>>> +fprintf(stdout,
> >>>> "Usage: ip [ OPTIONS ] OBJECT { COMMAND | help }\n"
> >>>> " =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ip [ -force ] -batch filename\=
n"
> >>>> "where =C2=A0OBJECT :=3D { address | addrlabel | fou | help | ila | =
ioam |=20
> >>>> l2tp
> >>>> | link |\n"
> >>>> @@ -72,7 +72,7 @@ static void usage(void)
> >>>> " =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-o[neline] | -t[imestamp] |=
 -ts[hort] | -b[atch]
> >>>> [filename] |\n"
> >>>> " =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-rc[vbuf] [size] | -n[etns]=
 name | -N[umeric] |
> >>>> -a[ll] |\n"
> >>>> " =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-c[olor]}\n");
> >>>> -exit(-1);
> >>>> +exit(0);
> >>>> } =20
> >>> Your mailer damages white space.
> >>> =20
> >> The output also needs to depend on whether these is a 'usage' error or
> >> if 'help' is requested.
> >> Code code is correct for the former - except it should do exit(1).
> >>
> >> =C2=A0=C2=A0=C2=A0=C2=A0David
> >>
> >> =20
>=20

We need to have a broad solution that doesn't look ugly.
There are a couple problems with current code:
  1. Help should exit with 0 (ok); invalid argument should exit with non-ze=
ro
     by Gnu convention that is 2 but other commands like git use 129
  2. help should go to stdout; usage on error should go to stderr

The solution should work across iproute2 commands: ip, tc, dpll, tipc, brid=
ge, ...
and the sub commands.

So far the mailing list patches were kind of messy and limited.

