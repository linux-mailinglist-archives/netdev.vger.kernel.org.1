Return-Path: <netdev+bounces-302422-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DxCVM1eYQWrQsQkAu9opvQ
	(envelope-from <netdev+bounces-302422-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 23:55:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5136D50A8
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 23:55:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.s=20251104 header.b=UHSIhnvP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302422-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302422-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=networkplumber.org (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 980F83003812
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 21:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299E835B62C;
	Sun, 28 Jun 2026 21:55:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71278348C47
	for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 21:55:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782683732; cv=none; b=L02c7XvnEaVs0EcYuHVq+qBZGgCT5Sv6WJbLGpDt7N7UqrI17Q7DBM/6+S9Y6nmICbyto5aBgYBXHl8Zs4AV3MhjmnPZxKerjrCj7k/rHTnl34AA9JP4IJAm1B/bqtQmRn1fTBuJN7feAklp3OOBJzkrsd4QX3pKEMtkJNJeEc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782683732; c=relaxed/simple;
	bh=v22FU7dO/NfwTxxtlz98ZJp4r5l20SjSHadu7l60+D4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nXBL/JruOtcQjE/K4YLR7UxO3eThdEhUzByoT+lU8b4m3CNxLQlCi999ewBT2oDUZPpKOEfwMQA0NF3DDzmKf63Nue8QjIpJhoWPVsfPv9R5ShUpmFhtGBbtUFMgiPBMEXVuGxDX7PWO51QAm2NO80oV5+6V2FoWBfudirdhHVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=UHSIhnvP; arc=none smtp.client-ip=74.125.82.173
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-30ec3dfbcd1so766783eec.0
        for <netdev@vger.kernel.org>; Sun, 28 Jun 2026 14:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782683727; x=1783288527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwYYieVRiY7CSKF7WlI8aiADaq9weQSRdUvUyZR9pUo=;
        b=UHSIhnvPncNOrHU6NgHZ6LmsvD5K/WQX/yhiaHjNiByEjuAZwN5ZXBb5gcsSEydXfi
         P7B/k6e9EkwMQWNf8hOx7Pp1VPG3pGxJU8elhDVLuaaHr5enX/a7wI1zXGZ4TZXZWX5g
         bBWUf+INWYYUnuyz/1WOW5jMNaY7oalQmM0C7lqe1B4ZlNZFgy/NtgW1pC4zU+OE4gtQ
         LlHppZ6H6i2/UUQaCOYWo7VSCB7XmG9sLCpZFEX06W5WVlagEujyNPvlbf7lu87XxFEP
         UnhVYXlGK/EaNSFbhH5/94mHVsHm9aYfSQ22Ki7+TfUnoX+g/WWPduBE85oEVs/RXI+g
         RONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782683727; x=1783288527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mwYYieVRiY7CSKF7WlI8aiADaq9weQSRdUvUyZR9pUo=;
        b=T3Jo5z6vZnNXpG45XinEsDjdaxe+LIrgijcBIMNyWPFH7fERYLRX7fUsC1o00hTTMw
         lbSY0vLZJZlV9OLe2UgqVcMRy4h2PkzBwakQayk4cBXJ8wvGvo57tmDLKIWAFGWDutx5
         XHf/CNKUkEfYmCLx03ArQzOQdssmZOqxNXpyF1O+/JlItQ1wd0y6qbdTA8EuR9kwWl55
         JDDB205+cbVF1JqYNUt5tuXRQ/8NSnQKM/JLOQWuoGjEdpgP4f4UriHKnXdLD6/Xe+YS
         o827hb3umlcIKbwiNsRTN6iPGtcQ0pEuFGnto0pi5nycReLx9SMOsVK0kQc0ohzkGNdV
         EgVQ==
X-Gm-Message-State: AOJu0Yy77Hn2TuOBE8/sRp01Zbkms1TYwB9e1LFNB1Mvi76TqCAlqaHi
	ZOuKAa0j+Xs/jjvyPvOewXg0qRU3+N5xYaFpFvK9H9ag25Sx1npNKBx9kl8NHfMg1lg=
X-Gm-Gg: AfdE7cmNT2OgwalTGzmvngFoYr8H22YdWFtNrXBnrDgjA94UVEU6VXRVauuVXvkbpZQ
	tthYlW6BGlhpq66ZdctvEMiFY0G4K59ZK5OY7lIbQzNpjbFSj7UOZ/zztRHAsaVOFZgyNjc6E2B
	4Oj1guCt0aPpKXvTUpRgKi8uN83mu3o50tnjTzLFDucAnnHpHWvfGUNTCK8CB8qM9bkUpGaZaRU
	RLQ4ZJQevL7F3EcJg0Bk/J1aIN45oxOOHcHQGjeMG7U8ZZNC2I2FPCiA7ilC+TPHKZ2YNrSzxxE
	t1J0hO7z57JVW1yB9+cDe5JwD0FWTQWoC4e5QsGhcvtnM1soIAbuEp1tstKcncK3vf5t1XEn7pS
	1R/rKtNhAEdOVOBLL3isuwS+eOWgdFUwQ7qujcfCEhxekxsJzS06Mq59FOI6QbOjdxcLRilbj9a
	Z3YIbkqZYoDdO3xpQkKUs/4sD4iyI3U5YLac63KhMZrTrAczwwctXFkw==
X-Received: by 2002:a05:7300:23d3:b0:30c:ab4d:382b with SMTP id 5a478bee46e88-30cab4d3c28mr7828672eec.45.1782683727136;
        Sun, 28 Jun 2026 14:55:27 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c4ca240sm41464915eec.4.2026.06.28.14.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 14:55:26 -0700 (PDT)
Date: Sun, 28 Jun 2026 14:55:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bjarni Ingi Gislason <bjarniig@simnet.is>
Cc: netdev@vger.kernel.org, Debian Bug Tracking System
 <submit@bugs.debian.org>
Subject: Re: iproute2: trailing whitespace in man pages
Message-ID: <20260628145523.5da461b8@phoenix.local>
In-Reply-To: <178243847243.6540.10252433987238870483.reportbug@kassi.invalid.is>
References: <178243847243.6540.10252433987238870483.reportbug@kassi.invalid.is>
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
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302422-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bjarniig@simnet.is,m:netdev@vger.kernel.org,m:submit@bugs.debian.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,networkplumber-org.20251104.gappssmtp.com:dkim,phoenix.local:mid,simnet.is:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F5136D50A8

On Fri, 26 Jun 2026 01:54:52 +0000
Bjarni Ingi Gislason <bjarniig@simnet.is> wrote:

> Package: iproute2 (in Debian)
> Version: 7.1.0-1
> Severity: minor
>=20
>   Additional remarks.
>=20
>   Mails from me to "submit@bugs.debian.org" are no longer acknowledged.  A
> Debian maintainer told me, that he would contact the mail administrator
> about me not wanting to send bugs upstream.
>=20
> -.-
>=20
> Dear Maintainer,
>=20
>    * What led up to the situation?
>=20
>      Checking for defects with a new version
>=20
> test-[g|n]roff -mandoc -t -K utf8 -rF0 -rHY=3D0 -rCHECKSTYLE=3D0 -ww -z <=
 "man page"
>=20
>   [Use=20
>=20
> grep -n -e ' $' -e '\\~$' -e ' \\f.$' -e ' \\"' <file>
>=20
>   to find (most) trailing spaces.]
>=20
>   ["test-groff" is a script in the repository for "groff"; is not shipped]
> (local copy and "troff" slightly changed by me).
>=20
>   [The fate of "test-nroff" was decided in groff bug #55941.]
>=20
>    * What was the outcome of this action?
>=20
> troff:/tmp/gz.roff.tw9zTq:10: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.tw9zTq:15: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.tw9zTq:20: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.tw9zTq:34: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.tw9zTq:36: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.tw9zTq:38: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.tw9zTq:40: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.tw9zTq:41: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.tw9zTq:42: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.tw9zTq:43: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.tw9zTq:44: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.tw9zTq:45: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.tw9zTq:46: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.tw9zTq:47: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.tw9zTq:48: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.tw9zTq:49: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.tw9zTq:50: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.tw9zTq:55: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.tw9zTq:56: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.tw9zTq:57: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/bridge.8.gz
>=20
> troff:/tmp/gz.roff.m7ah0F:12: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/dcb-app.8.gz
>=20
> troff:/tmp/gz.roff.lEZOzh:12: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.lEZOzh:32: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/dcb-apptrust.8.gz
>=20
> troff:/tmp/gz.roff.WIScEl:12: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/dcb-buffer.8.gz
>=20
> troff:/tmp/gz.roff.lQyzHW:11: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/dcb-dcbx.8.gz
>=20
> troff:/tmp/gz.roff.i604Vp:12: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.i604Vp:43: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/dcb-ets.8.gz
>=20
> troff:/tmp/gz.roff.21mI9Z:12: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.21mI9Z:37: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/dcb-maxrate.8.gz
>=20
> troff:/tmp/gz.roff.tNIhrB:12: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.tNIhrB:38: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/dcb-pfc.8.gz
>=20
> troff:/tmp/gz.roff.rSgJgv:12: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/dcb-rewr.8.gz
>=20
> troff:/tmp/gz.roff.Q8vb3N:11: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.Q8vb3N:18: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.Q8vb3N:24: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/dcb.8.gz
>=20
> troff:/tmp/gz.roff.IodjFN:12: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.IodjFN:17: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.IodjFN:32: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.IodjFN:34: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.IodjFN:36: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.IodjFN:54: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.IodjFN:123: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.IodjFN:133: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.IodjFN:149: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.IodjFN:175: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/devlink-dev.8.gz
>=20
> troff:/tmp/gz.roff.Nx3P7S:13: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.Nx3P7S:18: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.Nx3P7S:28: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.Nx3P7S:32: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/devlink-dpipe.8.gz
>=20
> troff:/tmp/gz.roff.f7fvNK:12: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.f7fvNK:17: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.f7fvNK:24: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.f7fvNK:66: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.f7fvNK:68: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.f7fvNK:184: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.f7fvNK:188: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.f7fvNK:193: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.f7fvNK:197: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/devlink-health.8.gz
>=20
> troff:/tmp/gz.roff.hTtjSy:12: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.hTtjSy:17: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.hTtjSy:24: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.hTtjSy:25: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.hTtjSy:29: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.hTtjSy:50: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.hTtjSy:54: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.hTtjSy:55: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.hTtjSy:56: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.hTtjSy:68: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/devlink-lc.8.gz
>=20
> troff:/tmp/gz.roff.soeA6o:12: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.soeA6o:17: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.soeA6o:22: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.soeA6o:24: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.soeA6o:29: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.soeA6o:35: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.soeA6o:50: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.soeA6o:66: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.soeA6o:68: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.soeA6o:69: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.soeA6o:71: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.soeA6o:74: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.soeA6o:77: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.soeA6o:80: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.soeA6o:83: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.soeA6o:86: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.soeA6o:91: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.soeA6o:101: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.soeA6o:127: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.soeA6o:167: warning: treating total indentation -72u a=
s zero [-w range]
> /usr/share/man/man8/devlink-port.8.gz
>=20
> troff:/tmp/gz.roff.kYqBeN:12: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.kYqBeN:17: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.kYqBeN:26: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/devlink-rate.8.gz
>=20
> troff:/tmp/gz.roff.9tHyhr:12: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.9tHyhr:17: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.9tHyhr:28: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.9tHyhr:48: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/devlink-region.8.gz
>=20
> troff:/tmp/gz.roff.9MYeZd:12: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.9MYeZd:17: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/devlink-resource.8.gz
>=20
> troff:/tmp/gz.roff.ZhPBEk:12: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZhPBEk:17: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZhPBEk:22: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZhPBEk:23: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZhPBEk:28: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZhPBEk:29: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZhPBEk:31: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZhPBEk:39: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZhPBEk:41: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZhPBEk:43: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZhPBEk:48: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZhPBEk:49: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZhPBEk:51: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZhPBEk:59: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZhPBEk:61: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZhPBEk:63: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZhPBEk:66: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZhPBEk:67: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZhPBEk:69: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZhPBEk:71: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/devlink-sb.8.gz
>=20
> troff:/tmp/gz.roff.cbJFkk:17: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.cbJFkk:79: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.cbJFkk:114: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.cbJFkk:139: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.cbJFkk:143: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/devlink-trap.8.gz
>=20
> troff:/tmp/gz.roff.QOaboD:10: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.QOaboD:16: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/devlink.8.gz
>=20
> troff:/tmp/gz.roff.m0E9ov:11: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.m0E9ov:19: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.m0E9ov:29: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/dpll.8.gz
>=20
> troff:/tmp/gz.roff.hhba1k:12: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.hhba1k:19: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.hhba1k:24: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.hhba1k:29: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.hhba1k:31: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/genl.8.gz
>=20
> troff:/tmp/gz.roff.UspeXf:12: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.UspeXf:17: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.UspeXf:27: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.UspeXf:29: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.UspeXf:31: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.UspeXf:33: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.UspeXf:39: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.UspeXf:41: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.UspeXf:43: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.UspeXf:45: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.UspeXf:47: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.UspeXf:49: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.UspeXf:51: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.UspeXf:63: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.UspeXf:65: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.UspeXf:67: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.UspeXf:69: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.UspeXf:71: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.UspeXf:76: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.UspeXf:77: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/ip-address.8.gz
>=20
> troff:/tmp/gz.roff.ACnG5f:10: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ACnG5f:15: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ACnG5f:17: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ACnG5f:56: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/ip-addrlabel.8.gz
>=20
> troff:/tmp/gz.roff.5eqgIA:14: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.5eqgIA:21: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.5eqgIA:27: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.5eqgIA:31: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.5eqgIA:35: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.5eqgIA:39: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.5eqgIA:48: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.5eqgIA:52: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.5eqgIA:56: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.5eqgIA:60: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/ip-fou.8.gz
>=20
> troff:/tmp/gz.roff.muormS:10: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.muormS:21: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.muormS:25: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.muormS:49: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/ip-ioam.8.gz
>=20
> troff:/tmp/gz.roff.YZqY4h:12: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.YZqY4h:18: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.YZqY4h:85: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.YZqY4h:232: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/ip-l2tp.8.gz
>=20
> troff:/tmp/gz.roff.x9nPAk:10: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.x9nPAk:59: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.x9nPAk:67: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.x9nPAk:159: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.x9nPAk:164: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.x9nPAk:186: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.x9nPAk:195: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.x9nPAk:197: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.x9nPAk:223: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.x9nPAk:224: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.x9nPAk:226: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.x9nPAk:227: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.x9nPAk:228: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.x9nPAk:229: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.x9nPAk:230: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.x9nPAk:236: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.x9nPAk:237: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.x9nPAk:248: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.x9nPAk:249: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.x9nPAk:256: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/ip-link.8.gz
>=20
> troff:/tmp/gz.roff.r9LukD:5: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.r9LukD:64: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.r9LukD:65: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.r9LukD:67: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.r9LukD:75: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.r9LukD:77: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.r9LukD:80: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.r9LukD:83: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.r9LukD:85: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/ip-macsec.8.gz
>=20
> troff:/tmp/gz.roff.fk7Uej:12: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/ip-maddress.8.gz
>=20
> troff:/tmp/gz.roff.OtuwHM:11: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.OtuwHM:17: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.OtuwHM:45: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.OtuwHM:51: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.OtuwHM:57: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.OtuwHM:58: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/ip-monitor.8.gz
>=20
> troff:/tmp/gz.roff.DLgQwy:12: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.DLgQwy:14: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.DLgQwy:16: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.DLgQwy:22: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.DLgQwy:30: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.DLgQwy:32: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.DLgQwy:35: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.DLgQwy:37: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.DLgQwy:39: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.DLgQwy:42: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.DLgQwy:45: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.DLgQwy:52: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.DLgQwy:88: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.DLgQwy:89: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.DLgQwy:92: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/ip-mptcp.8.gz
>=20
> troff:/tmp/gz.roff.Bf2muc:9: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.Bf2muc:10: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.Bf2muc:11: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.Bf2muc:13: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.Bf2muc:15: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.Bf2muc:17: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/ip-mroute.8.gz
>=20
> troff:/tmp/gz.roff.aIjjMP:12: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.aIjjMP:17: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.aIjjMP:18: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.aIjjMP:20: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.aIjjMP:24: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.aIjjMP:26: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.aIjjMP:27: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.aIjjMP:28: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.aIjjMP:29: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.aIjjMP:30: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.aIjjMP:35: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.aIjjMP:37: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.aIjjMP:39: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/ip-neighbour.8.gz
>=20
> troff:/tmp/gz.roff.sjvvc4:9: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/ip-netconf.8.gz
>=20
> troff:/tmp/gz.roff.bAu8qy:12: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.bAu8qy:46: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/ip-netns.8.gz
>=20
> troff:/tmp/gz.roff.nM3cIw:12: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.nM3cIw:18: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.nM3cIw:19: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.nM3cIw:23: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.nM3cIw:28: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.nM3cIw:40: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.nM3cIw:42: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.nM3cIw:44: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.nM3cIw:46: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.nM3cIw:48: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.nM3cIw:49: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.nM3cIw:53: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.nM3cIw:59: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.nM3cIw:60: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.nM3cIw:62: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.nM3cIw:64: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.nM3cIw:65: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.nM3cIw:67: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.nM3cIw:68: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.nM3cIw:70: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/ip-nexthop.8.gz
>=20
> troff:/tmp/gz.roff.Kn3w81:12: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.Kn3w81:18: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.Kn3w81:57: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.Kn3w81:59: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/ip-ntable.8.gz
>=20
> troff:/tmp/gz.roff.gv3LBB:12: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.gv3LBB:18: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.gv3LBB:19: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.gv3LBB:33: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.gv3LBB:36: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.gv3LBB:38: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.gv3LBB:40: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.gv3LBB:42: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.gv3LBB:44: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.gv3LBB:46: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.gv3LBB:56: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.gv3LBB:60: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.gv3LBB:62: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.gv3LBB:64: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.gv3LBB:66: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.gv3LBB:68: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.gv3LBB:70: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.gv3LBB:72: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.gv3LBB:74: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.gv3LBB:84: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/ip-route.8.gz
>=20
> troff:/tmp/gz.roff.6owsuu:12: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.6owsuu:31: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.6owsuu:34: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.6owsuu:36: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.6owsuu:38: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.6owsuu:40: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.6owsuu:42: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.6owsuu:44: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.6owsuu:46: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.6owsuu:48: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.6owsuu:49: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.6owsuu:51: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.6owsuu:53: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.6owsuu:54: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.6owsuu:55: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.6owsuu:56: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.6owsuu:57: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.6owsuu:58: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.6owsuu:59: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.6owsuu:61: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/ip-rule.8.gz
>=20
> troff:/tmp/gz.roff.6yXkbF:10: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/ip-sr.8.gz
>=20
> troff:/tmp/gz.roff.glO7gb:11: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.glO7gb:18: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.glO7gb:20: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.glO7gb:28: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/ip-stats.8.gz
>=20
> troff:/tmp/gz.roff.XiAasB:12: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.XiAasB:25: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.XiAasB:26: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/ip-tcp_metrics.8.gz
>=20
> troff:/tmp/gz.roff.XtavYp:10: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/ip-token.8.gz
>=20
> troff:/tmp/gz.roff.TS3gWw:12: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.TS3gWw:18: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.TS3gWw:20: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.TS3gWw:25: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.TS3gWw:34: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.TS3gWw:39: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.TS3gWw:41: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.TS3gWw:59: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.TS3gWw:76: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.TS3gWw:81: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/ip-tunnel.8.gz
>=20
> troff:/tmp/gz.roff.5llFkR:11: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.5llFkR:28: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/ip-vrf.8.gz
>=20
> troff:/tmp/gz.roff.91zMPC:13: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.91zMPC:19: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.91zMPC:29: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.91zMPC:103: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.91zMPC:158: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.91zMPC:171: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.91zMPC:175: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.91zMPC:183: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.91zMPC:198: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.91zMPC:240: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.91zMPC:274: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.91zMPC:325: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.91zMPC:327: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.91zMPC:345: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.91zMPC:363: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.91zMPC:367: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.91zMPC:371: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.91zMPC:427: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.91zMPC:448: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.91zMPC:564: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/ip-xfrm.8.gz
>=20
> troff:/tmp/gz.roff.gY3yJ3:10: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.gY3yJ3:16: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.gY3yJ3:21: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.gY3yJ3:31: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.gY3yJ3:39: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.gY3yJ3:169: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.gY3yJ3:175: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/ip.8.gz
>=20
> troff:/tmp/gz.roff.j0dcO5:10: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.j0dcO5:15: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.j0dcO5:111: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.j0dcO5:112: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.j0dcO5:203: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.j0dcO5:204: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/netshaper.8.gz
>=20
> troff:/tmp/gz.roff.EOKA9l:12: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.EOKA9l:17: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/rdma-dev.8.gz
>=20
> troff:/tmp/gz.roff.j9CeKZ:12: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.j9CeKZ:17: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/rdma-link.8.gz
>=20
> troff:/tmp/gz.roff.NBliDx:16: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/rdma-monitor.8.gz
>=20
> troff:/tmp/gz.roff.n7n6Ij:10: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.n7n6Ij:15: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.n7n6Ij:16: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.n7n6Ij:21: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/rdma-resource.8.gz
>=20
> troff:/tmp/gz.roff.zNQGc9:12: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.zNQGc9:40: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.zNQGc9:85: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.zNQGc9:89: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.zNQGc9:93: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.zNQGc9:97: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/rdma-statistic.8.gz
>=20
> troff:/tmp/gz.roff.w2n0Tg:12: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.w2n0Tg:17: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/rdma-system.8.gz
>=20
> troff:/tmp/gz.roff.G452XU:10: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.G452XU:16: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.G452XU:21: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.G452XU:26: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/rdma.8.gz
>=20
> troff:/tmp/gz.roff.8E9eVD:10: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/rtmon.8.gz
>=20
> troff:/tmp/gz.roff.cESP7P:447: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.cESP7P:607: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/ss.8.gz
>=20
> troff:/tmp/gz.roff.ux4fN1:9: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ux4fN1:11: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/tc-basic.8.gz
>=20
> troff:/tmp/gz.roff.E5yQLK:9: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/tc-cgroup.8.gz
>=20
> troff:/tmp/gz.roff.xDoFMo:10: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.xDoFMo:49: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/tc-connmark.8.gz
>=20
> troff:/tmp/gz.roff.EPr6TY:15: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.EPr6TY:26: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/tc-csum.8.gz
>=20
> troff:/tmp/gz.roff.ozliFK:7: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ozliFK:9: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ozliFK:11: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ozliFK:13: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ozliFK:18: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/tc-ct.8.gz
>=20
> troff:/tmp/gz.roff.NlhG4f:34: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.NlhG4f:39: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.NlhG4f:51: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/tc-dualpi2.8.gz
>=20
> troff:/tmp/gz.roff.AXC30K:14: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.AXC30K:20: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.AXC30K:22: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.AXC30K:33: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.AXC30K:73: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/tc-ematch.8.gz
>=20
> troff:/tmp/gz.roff.Xqn4yW:12: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.Xqn4yW:13: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.Xqn4yW:21: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.Xqn4yW:22: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.Xqn4yW:24: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.Xqn4yW:32: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.Xqn4yW:34: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.Xqn4yW:36: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.Xqn4yW:38: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.Xqn4yW:46: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.Xqn4yW:47: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.Xqn4yW:54: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.Xqn4yW:55: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.Xqn4yW:56: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.Xqn4yW:57: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/tc-flow.8.gz
>=20
> troff:/tmp/gz.roff.SN8HX6:8: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.SN8HX6:9: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.SN8HX6:11: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.SN8HX6:13: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.SN8HX6:22: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.SN8HX6:24: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.SN8HX6:26: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.SN8HX6:28: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.SN8HX6:29: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.SN8HX6:30: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.SN8HX6:32: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.SN8HX6:34: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.SN8HX6:35: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.SN8HX6:36: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.SN8HX6:38: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.SN8HX6:40: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.SN8HX6:41: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.SN8HX6:42: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.SN8HX6:44: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.SN8HX6:45: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/tc-flower.8.gz
>=20
> troff:/tmp/gz.roff.75BF9d:69: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/tc-fq_codel.8.gz
>=20
> troff:/tmp/gz.roff.ATqeiC:9: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/tc-fw.8.gz
>=20
> troff:/tmp/gz.roff.0gJmYD:11: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.0gJmYD:12: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.0gJmYD:21: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.0gJmYD:24: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/tc-gact.8.gz
>=20
> troff:/tmp/gz.roff.1ht4Bu:9: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.1ht4Bu:11: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.1ht4Bu:13: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.1ht4Bu:15: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.1ht4Bu:16: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.1ht4Bu:17: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.1ht4Bu:19: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.1ht4Bu:22: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.1ht4Bu:26: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.1ht4Bu:32: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.1ht4Bu:36: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.1ht4Bu:59: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.1ht4Bu:67: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/tc-ife.8.gz
>=20
> troff:/tmp/gz.roff.eEZB5X:8: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.eEZB5X:10: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.eEZB5X:12: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/tc-matchall.8.gz
>=20
> troff:/tmp/gz.roff.BCTuKt:11: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.BCTuKt:15: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.BCTuKt:22: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.BCTuKt:26: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.BCTuKt:30: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/tc-mirred.8.gz
>=20
> troff:/tmp/gz.roff.KuFNwq:8: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.KuFNwq:9: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.KuFNwq:10: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.KuFNwq:14: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.KuFNwq:19: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.KuFNwq:23: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.KuFNwq:25: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.KuFNwq:27: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.KuFNwq:31: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.KuFNwq:35: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.KuFNwq:37: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.KuFNwq:40: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.KuFNwq:57: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.KuFNwq:80: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.KuFNwq:81: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/tc-mpls.8.gz
>=20
> troff:/tmp/gz.roff.9RiFlD:235: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.9RiFlD:237: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.9RiFlD:254: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.9RiFlD:274: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.9RiFlD:282: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.9RiFlD:284: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/tc-mqprio.8.gz
>=20
> troff:/tmp/gz.roff.t0JWAM:12: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.t0JWAM:22: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.t0JWAM:23: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/tc-nat.8.gz
>=20
> troff:/tmp/gz.roff.ZHcyYL:6: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZHcyYL:14: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZHcyYL:18: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZHcyYL:25: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZHcyYL:26: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZHcyYL:34: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZHcyYL:35: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZHcyYL:37: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZHcyYL:41: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZHcyYL:45: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZHcyYL:47: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZHcyYL:51: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZHcyYL:55: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZHcyYL:56: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZHcyYL:59: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZHcyYL:60: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZHcyYL:63: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZHcyYL:67: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZHcyYL:383: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZHcyYL:387: warning [page 1, line 269]: cannot adjust =
line in b adjust mode; overset by 4n [-w break]
> /usr/share/man/man8/tc-netem.8.gz
>=20
> troff:/tmp/gz.roff.DJ46bB:12: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.DJ46bB:18: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.DJ46bB:22: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.DJ46bB:29: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.DJ46bB:44: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.DJ46bB:48: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.DJ46bB:53: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.DJ46bB:57: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.DJ46bB:62: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.DJ46bB:63: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.DJ46bB:67: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.DJ46bB:71: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.DJ46bB:77: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.DJ46bB:79: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.DJ46bB:80: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/tc-pedit.8.gz
>=20
> troff:/tmp/gz.roff.HpJEdr:34: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/tc-police.8.gz
>=20
> troff:/tmp/gz.roff.JYFwIE:9: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.JYFwIE:11: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.JYFwIE:13: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.JYFwIE:15: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/tc-route.8.gz
>=20
> troff:/tmp/gz.roff.TQDw2w:14: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.TQDw2w:16: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.TQDw2w:19: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/tc-sample.8.gz
>=20
> troff:/tmp/gz.roff.LzdwcT:69: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/tc-skbedit.8.gz
>=20
> troff:/tmp/gz.roff.EeoYee:8: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.EeoYee:9: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.EeoYee:12: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.EeoYee:13: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.EeoYee:17: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.EeoYee:19: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.EeoYee:21: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.EeoYee:23: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.EeoYee:26: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/tc-skbmod.8.gz
>=20
> troff:/tmp/gz.roff.LaXqMO:8: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.LaXqMO:12: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/tc-tunnel_key.8.gz
>=20
> troff:/tmp/gz.roff.0SnZpw:9: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.0SnZpw:11: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.0SnZpw:13: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.0SnZpw:15: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.0SnZpw:17: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.0SnZpw:19: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.0SnZpw:21: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.0SnZpw:23: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.0SnZpw:25: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.0SnZpw:27: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.0SnZpw:29: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.0SnZpw:31: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.0SnZpw:32: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.0SnZpw:33: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.0SnZpw:37: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.0SnZpw:44: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.0SnZpw:46: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.0SnZpw:51: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.0SnZpw:52: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.0SnZpw:53: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/tc-u32.8.gz
>=20
> troff:/tmp/gz.roff.ZLTTLY:12: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZLTTLY:16: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZLTTLY:20: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZLTTLY:24: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZLTTLY:28: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZLTTLY:30: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.ZLTTLY:33: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/tc-vlan.8.gz
>=20
> troff:/tmp/gz.roff.bkv7BO:128: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.bkv7BO:129: warning: ignoring escape character before =
']' [-w escape]
> troff:/tmp/gz.roff.bkv7BO:717: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.bkv7BO:723: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/tc.8.gz
>=20
> troff:/tmp/gz.roff.My0dwn:57: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/tipc-bearer.8.gz
>=20
> troff:/tmp/gz.roff.bYd25b:18: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.bYd25b:27: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.bYd25b:28: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.bYd25b:30: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.bYd25b:32: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.bYd25b:42: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.bYd25b:53: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.bYd25b:62: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.bYd25b:66: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/tipc-link.8.gz
>=20
> troff:/tmp/gz.roff.rs4kL6:17: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/tipc-media.8.gz
>=20
> troff:/tmp/gz.roff.z8m3fR:15: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.z8m3fR:19: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.z8m3fR:23: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/tipc-node.8.gz
>=20
> an.tmac:/tmp/gz.roff.9VgwLV:30: warning: cannot call .SS while an input t=
rap is pending
> an.tmac:/tmp/gz.roff.9VgwLV:34: warning: cannot call .SS while an input t=
rap is pending
> /usr/share/man/man8/tipc-socket.8.gz
>=20
> troff:/tmp/gz.roff.rBSHKg:14: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.rBSHKg:19: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/tipc.8.gz
>=20
> troff:/tmp/gz.roff.gPfIxK:11: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.gPfIxK:12: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.gPfIxK:17: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/vdpa-dev.8.gz
>=20
> troff:/tmp/gz.roff.wHzGiy:11: warning: trailing whitespace [-w trail]
> troff:/tmp/gz.roff.wHzGiy:16: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/vdpa-mgmtdev.8.gz
>=20
> troff:/tmp/gz.roff.qSwXBM:10: warning: trailing whitespace [-w trail]
> /usr/share/man/man8/vdpa.8.gz
>=20
>    * What outcome did you expect instead?
>=20
>      No output (no warnings).
>=20
> -.-
>=20
>   General remarks and further material, if a diff-file exist, are in the
> attachments.
>=20
>=20
> -- System Information:
> Debian Release: forky/sid
>   APT prefers testing
>   APT policy: (500, 'testing')
> Architecture: amd64 (x86_64)
>=20
> Kernel: Linux 7.0.12+deb14.1-amd64 (SMP w/2 CPU threads; PREEMPT)
> Locale: LANG=3Dis_IS.iso88591, LC_CTYPE=3Dis_IS.iso88591 (charmap=3DISO-8=
859-1), LANGUAGE not set
> Shell: /bin/sh linked to /usr/bin/dash
> Init: sysvinit (via /sbin/init)
>=20
> Versions of packages iproute2 depends on:
> ii  debconf [debconf-2.0]  1.5.92
> ii  libbpf1                1:1.7.0-1
> ii  libc6                  2.42-17
> ii  libcap2                1:2.78-1
> ii  libcap2-bin            1:2.78-1
> ii  libdb5.3t64            5.3.28+dfsg2-11+b1
> ii  libelf1t64             0.195-1
> ii  libmnl0                1.0.5-3+b2
> ii  libselinux1            3.10-1
> ii  libtirpc3t64           1.3.7+ds-1
> ii  libxtables12           1.8.13-1
>=20
> iproute2 recommends no packages.
>=20
> Versions of packages iproute2 suggests:
> ii  python3  3.13.9-3+b1
>=20
> -- debconf information excluded


I didn't go look at Debian packages in detail but this report looked bogus
so sent AI to investigate. It did motivate me to look and fix some whitespa=
ce
issues; but those weren't the ones in this report.

=E2=97=8F Based on my analysis, here's what's happening with the whitespace=
 report:

  The Issue with the Report

  The report appears to be overly sensitive or potentially faulty for sever=
al
  reasons:

  1. Testing installed packages, not source files: The report is testing the
  installed Debian package man pages from /usr/share/man/, not the source f=
iles
   in the git repository. The temporary files (/tmp/gz.roff.*) suggest they=
're
  uncompressing and processing installed gzipped man pages.
  2. Blank lines misinterpreted as trailing whitespace: Looking at the patt=
ern
  of warnings (often on lines like 10, 12, 15, 17, etc. - early in files),
  these appear to be blank lines between sections in man pages, which are
  normal and necessary for readability. Traditional troff/groff with strict
  warnings enabled can flag these as "trailing whitespace" even though they=
're
  just empty lines.
  3. Already addressing real issues: Your recent commits show you've been
  fixing actual whitespace problems:
    - 66d16c41: Fixed whitespace in bridge code
    - db4d810d: Removed trailing whitespace from CREDITS
    - 328ba79f: Removed trailing whitespace from .mailmap
  4. Source files appear clean: When I checked the actual source man pages =
in
  your repository (like tc-fq_codel.8), I couldn't find actual trailing spa=
ces.
   The blank lines between sections are standard man page formatting.
  5. Tool methodology questionable: The report mentions using a custom
  "test-groff" script with modifications. The sheer number of warnings
  (thousands across all files) and their consistent pattern (mostly early l=
ine
  numbers) suggests the tool might be:
    - Using overly strict warning settings
    - Counting blank lines as trailing whitespace
    - Processing files after some transformation that introduces artifacts

  Conclusion

  The methodology appears faulty because:
  - It's testing packaged files, not source
  - It's likely flagging normal blank lines as trailing whitespace
  - The pattern of warnings (clustered on early lines) doesn't match typical
  trailing whitespace issues
  - Modern groff with normal settings doesn't reproduce these warnings on t=
he
  source files

  The report is essentially noise - flagging standard man page formatting as
  errors. Your source files appear to be properly formatted.

