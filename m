Return-Path: <netdev+bounces-299128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eKOOGjgkLmpdqAQAu9opvQ
	(envelope-from <netdev+bounces-299128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 05:47:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B779C6804BE
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 05:47:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=NLzKiCBv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299128-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299128-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0BD53028821
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 03:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD91277029;
	Sun, 14 Jun 2026 03:46:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22A6244694
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 03:46:57 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781408819; cv=pass; b=lWI/Qh+PqZcBzr+e9lZbFpLohxGi25VSL/HUX/DZxCjm9dAUYVQcIcmdq0MiaWGI3qy4nGamJv9sQQ26edOG1nl67sNbGMjqtIqLRkDcZpQBYSGJBQnwSTEAfR8+L8FkfZ62G3iave0VVBC4EZtIbjoFMT7jmYDjMK6BfWbvvKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781408819; c=relaxed/simple;
	bh=eRVFYlLNmeSGg3OY7gKvJQsWIErX/iR++Ro+lG+7u2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivxudQ5e/9fCsvaPn5vopgZDANQFem7bWLIkVrUrMHS5zKQiCGCaz1j+PUs9rK/dpJt/1qY17gwQXGT0nybUo3kZv+tYIfOiMw9Mp+/uIp2H8hS7LtYCPpHV/K8YE6MNHDsXjHAm1XkCZ/OO+5suNE8OQlcOknoTAe3xlFcmCxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLzKiCBv; arc=pass smtp.client-ip=209.85.128.177
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7e266714bd3so24782687b3.2
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 20:46:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781408817; cv=none;
        d=google.com; s=arc-20240605;
        b=cmdnocRpsH3g+I+gXLS+QfduKw2+Qe0FTL4hH+Z3QIQq6v2sjsA8ay9l3mCsFbpD+V
         SmE9NgR4fyaryUaDsL3f6WvnbR3aSNgjfk8xVZxmhZun0oLzeNKg3iwLq0qQFak0GQ9G
         GJsn+W0lJx0EL8W3htMn391+mbqSdjlTZU7L4kVeejL2Tl/dtp/c9oL89RlKxjsBVBBP
         29g+06pCo9vXhvRILCgpA4HYoT/5KYrh9foaxsbrxIW+qej6uCuaJ7+MXAk7K8uzOoaJ
         tL3XAdJJmfshIQqVYCGMzvcNrWE0z8WGf6myKbp4TAquL3lLgtcgXL+fnvJNrC9aHtK5
         Ml2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eRVFYlLNmeSGg3OY7gKvJQsWIErX/iR++Ro+lG+7u2Y=;
        fh=Di8M3mXvBohSCLdLuUEWfVybZoQ7ag7wEC+7rSwvR18=;
        b=RQZb3PAgNhIXb34WsFnxQ8DmIYNH+EWfkZGqiQ+Fw5iJarnBotPxAKoQeHaT+F/fvC
         cc+/3DuBOiboatWfMSu2taEyvVGpE4Wr1HCod8/SBPA6yUsEAHuD9AWztkyEG3mgdJdD
         sl4ohUv7cR2RvWPlA14xgJJ9+PScZ1GfeN8Tq8QIUfO8cqKArRdJvtcMsVSaU4+EZN/k
         h3E+OuCwRa5U3kCUnF+x7p4OdPZ5aNb6xD1vrmjLAqEHAPYIlkHzA37yt3rgCAf6d0kP
         +lnsAIMAC0kRbrmYf8swnwrx9rHCALtbl40Bv20+eYknkB4rO8ZZgggQC9yc68cIeAQj
         fKEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781408817; x=1782013617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRVFYlLNmeSGg3OY7gKvJQsWIErX/iR++Ro+lG+7u2Y=;
        b=NLzKiCBvHBcuw4Q5i3phBnygyZxRE1PTbUnT0uRi1oaTxA+DYtMdX5YyX3/UIR5N6N
         qpnhdW6Jy/DGgBqFRqW64IHK2B8BHPgXORkNmthYK82/9+nB2TP01UfVmqx0w82C2tZ6
         LGSstKyCdeo9dbbBzY9InGtBYO+XQqjdyJ6A0gTBvueripynuCUUY018H1O3ReDu3tXi
         QxpHbhbBneOZH6JFcY9kuKYbKUJKulI5EPoqQnTFpSjHRn+bEjAnkdgTKnuuAdJsqsX6
         ieoyv8jMBmIngk+ar3kWqKZ4Q0i0cEmyjo8Jco7anIiObAzl8itFZSXrSfZ9JSV2CWir
         1oVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781408817; x=1782013617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eRVFYlLNmeSGg3OY7gKvJQsWIErX/iR++Ro+lG+7u2Y=;
        b=psVFpcm578PrBjOSr59Iwy7YIAmvj9lNdCTNTlnVaHwLALBH7XvnSd8R4g53HbR/zT
         3HsPqnQyTer5M8xqzBRXaFEeDMoZhYlDJzyFN/8lEnvI6EnlGvAYVWKo5dlc6+BZy4MA
         4YXrir22qTOVZjagaFFSX9kGPGsKPKvDKtjn2Iw9BJyXYvCaT1cy0dplLPQf+ZZmNM2L
         WU4xKt2oUpzsJ/bGRiGiiLWdeguFGjW8XSv6LIBxOUiGk4D6boyuQpvzzBCKO++KBxoV
         OXQr88yt2eJWOIRidZb184ihxsXmJgYnlUVX8RWpa6py6wmiofvIR47a8Yi8uNl9N0bY
         lVug==
X-Forwarded-Encrypted: i=1; AFNElJ80uo9bluYKFIk0bAMjh3n70uLCa/nVPjGgHJkJ3F386G16L6gl6poM1OMByQvhX9chC9TyjWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv6elSyHz9W7bVJRKlksct/G4i4gZE7kVVmMxSvtx2rzd8EY6H
	GVCmnn7FBVInlfCyN2zm1JbXTDRYjjelERUKrvp50lQKlux3sAZZqQI2Glc6zh0wizXzNRozlLF
	f7dyXuUFkZw+0EsF9DIODgW/7gtDJYns=
X-Gm-Gg: Acq92OFI+ZZZDBT7M8s7JYNS+MQ+XIHTfyaAs2+nGngnBNJuB4b0gWSYVq340G/x1uY
	bAeYZP9XkX2FHXR8NXgr8e5gTP3czO4xrV8UdmTBAetTcT/gdA4qFf9Ev/nirodrM2l4w8doRtj
	/ua2wsRcdSLM6yaWS90v9B7TL5loDs1+/iHzXXrll48ENTSe+fEA0x89aFPs6IHbyhr15Ph+xrO
	LVKmRpL4pKcBAF9zb4971Ax/YqlMiRAZt4YK1DztJq0w2E1st/rsuNddo+MO68lgvR1ul/53T1J
	qXd7PbigmUrijTRZV8NpLMM1kpa5c4geWOLy8pSA1yzACPfqb1Qn0/j92gFyAg==
X-Received: by 2002:a05:690c:6c93:b0:7bd:9ce7:164c with SMTP id
 00721157ae682-7f8c3fdd5bemr51633187b3.43.1781408816861; Sat, 13 Jun 2026
 20:46:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612114032.244616-1-sun.jian.kdev@gmail.com>
 <20260612114032.244616-2-sun.jian.kdev@gmail.com> <20260613102549.0061a875@kernel.org>
 <CAADnVQJyOR0hppTmhbTRS8Sp5ci-L0fmQ6V+R9eiJDop_95rVA@mail.gmail.com> <20260613130343.3984878b@kernel.org>
In-Reply-To: <20260613130343.3984878b@kernel.org>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Sun, 14 Jun 2026 11:46:44 +0800
X-Gm-Features: AVVi8CeuSoLbqKZ8hO8Mj4s69jiQxW-2c__whedvojWfFSqVia9mVfTsO1WPvBM
Message-ID: <CABFUUZFG5fybb=2A_2x-aa0Y2zvHn86sTV-ZBoLSzxLw0VLvGA@mail.gmail.com>
Subject: Re: [PATCH bpf v5 1/2] bpf: Run generic devmap egress prog on private skb
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Menglong Dong <menglong.dong@linux.dev>, Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299128-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:alexei.starovoitov@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:davem@davemloft.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:shuah@kernel.org,m:jiayuan.chen@linux.dev,m:toke@redhat.com,m:menglong.dong@linux.dev,m:emil@etsalapatis.com,m:alexeistarovoitov@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjiankdev@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,iogearbox.net,linux.dev,davemloft.net,fomichev.me,redhat.com,etsalapatis.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B779C6804BE

On Sun, Jun 14, 2026 at 4:03=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 13 Jun 2026 10:53:35 -0700 Alexei Starovoitov wrote:
> > On Sat, Jun 13, 2026 at 10:25=E2=80=AFAM Jakub Kicinski <kuba@kernel.or=
g> wrote:
> > >
> > > On Fri, 12 Jun 2026 19:40:31 +0800 Sun Jian wrote:
> > > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > >
> > > I did not suggest this
> >
> > ohh. I didn't follow discussion closely.
> > Do you want me to revert the whole set or just remove that line?
>
> It's alright, I was just being grumpy.
>
> Maybe we can amend Chris's prompts to catch these?
> Noobs tend to add Suggested-by for people who simply commented
> on patches.

Hi Jakub, Alexei,

Sorry about that. I had meant to drop that Suggested-by tag before
sending v5, but missed it.

No action needed from my side.

Thanks,
Sun Jian

