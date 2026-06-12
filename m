Return-Path: <netdev+bounces-298743-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Bb00HD48LGqVOAQAu9opvQ
	(envelope-from <netdev+bounces-298743-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:05:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F23E67B321
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:05:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=h0XmpJfB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298743-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298743-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF556301484F
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 17:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091BE403B15;
	Fri, 12 Jun 2026 17:04:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8E05C613
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 17:04:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283859; cv=none; b=uQd+FzXHCStga0+2Crr86AdzMgl/bQk2YpOnpQ6YVVEEIzEIUFLVudv8uc+UzE+22jCZhNG2kyOXTJg29nr2jdIG/8F6sg1Ps/mIOGwn8y5jYYFNyvw4XIcZJ92WGj5XD0Rne4IQcPecUFVmJkx+5RJ1Q4jnrr1KZ3r9x654sis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283859; c=relaxed/simple;
	bh=x7JBV1YxVrPj4/1vBdgzqqKO1DpryrChHhSxeL1cbvA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=joqdWzyTErKz8bh01PYmn7uWNkpTuowlbQxMx3GrCcuAzFtseW2b3X9ZI7oVlgIezjPgrv2n+5osMVanKuUVruLWXZr6IPjElhXoze3dZy8w97khvVNqt/LEugU6QiYKxpXHzTpYgZ8MfOVfdvKKSdESIwRXwfswcrok1pTr+uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0XmpJfB; arc=none smtp.client-ip=209.85.167.171
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4865b9e16d4so536549b6e.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 10:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781283858; x=1781888658; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+CzGFIuAycc3JTH3gFYPgt2Y0prLl/gqutaLhPH2tg=;
        b=h0XmpJfBN3aA8/I9MeOh7mZ22rIraPMCUXRe6Uo+/kmLDnY9rZbBQMd568HZA4h3ZQ
         gsbgQTr1ZOzAtsFlwOoeLGnJWH6s5sVqlCui/ppWHwNXmded1gzYe18b6n1ZkkjrsTay
         +8vWO01kLZCQk4QMFMae6yrQtiLSPg5vMOJ9QItqfoUxtoEMb430ANmT7CWRCtW7czJP
         EnjYHStfTfrmHOUUfMnKsZ9jHlCpUV3QX0DPhbceYjLSztdE4KUjdCSx9tIJdyEagyua
         hDl3djBwg5mRxvlSvSnk2gh+w3RuCKIi7bRW7FlM+BB4ZfoadunexQWEkMy64bKkT2+y
         JX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781283858; x=1781888658;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O+CzGFIuAycc3JTH3gFYPgt2Y0prLl/gqutaLhPH2tg=;
        b=fgzvd7kYyGPEh5jLSKK+0PJO91dCDzdsvU7Nv2gJAHIcx1+2OO21cv0DxeAj8sEvzX
         xgDHETasYR317ME3NVLCFZA3Dtt+iL/gnAooeqJQaQ7yZ3X81UVUA+C7ktE1KpbWMa0R
         cnT2N8fLQAZf3G00fWzizICmkJP0h80P7U8QN1s4VAIuKlYydJDjKxv/3GvhlCU9hSu1
         EJ+yrqGd3Qf2omDiAlB13F94Tzh8S+DsC5EolMY4YTlcoLbrOT7dzR6jUdJ1DTRauhxM
         k1zt90L0+nQmMYbux3Gu6i3ON8njeAgGx1SAhGzrz44J1HYkxZlg4KORa4p/n58T9vQp
         Cu+Q==
X-Forwarded-Encrypted: i=1; AFNElJ8zIs2GEgbnNFAq+WExGAB3/lQEcf7OBZmmAyTbCaCtPS3jXml43qicGT+z7EsNyzx65j2WGjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YziPx+NZ5MOF5OtBaCFv+UiQ3HqErXsOiZ/Gs7Mt7EWjV9fjDBI
	cKZrCij0Bq0PxVyhV2LuA2lLgYl4wK2DzZvLCzpPq8ToJWLtqX05I+Pb
X-Gm-Gg: Acq92OH15C4GXVvDjLBds40teo0JlFA3QQ412klRAO9/WLxBVyEPjDws56hMT7q8wdw
	mgWVYLrWwuHGFAPn7lgv0eqjnkEKEOegDtxaU2sVsvX2rqz37fi+co5i2kTKqur3YxuuagsD2bY
	Dn8ASIsPcyRdidjHtVq6GxpQ3S3gpsufADzRmVvanegIc9LZVOz8cvUf6rghyH/41YcO8+o93y8
	ZFjOy6O4Z9DBntt3W3CPjDTiUN6GkSsexb0OdPG+XGkpt7SPBPnU/aNuUk/jdb2ukGg8PRp9SU/
	73pm6J4cdr1NC25y0AzaeE1X2/xWe0e5UwJSX6rb5gl69CvUQuB12hXWafACExDXYM4hImnU+yh
	d2jNGn2H0dDFAVeSOUUlX+6Sbhj6kuJ7jLO7V09RQyiHJSJ6b5NE0Q88rvQNE7RAi+7n7w2NVjA
	9HtNwXrPpz4o7PAtfs6dJBSuWxJ1LszH++6tWJP0xihGa6a2wiVzrwDg8tzIQdDh88daf5CZ/6E
	k5k1UxreJ0SEjCT6A==
X-Received: by 2002:a05:6808:c413:b0:486:a606:c6b5 with SMTP id 5614622812f47-4872f50eab1mr2764073b6e.23.1781283857489;
        Fri, 12 Jun 2026 10:04:17 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:18::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-487313bcf8asm1337937b6e.2.2026.06.12.10.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 10:04:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Jun 2026 10:04:15 -0700
Message-Id: <DJ78FEGKX5S8.1H2M4C8415L98@gmail.com>
Cc: "Zhenzhong Wu" <jt26wzz@gmail.com>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <john.fastabend@gmail.com>, <andrii@kernel.org>,
 <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <kpsingh@kernel.org>, <haoluo@google.com>, <jolsa@kernel.org>,
 <menglong8.dong@gmail.com>, <eddyz87@gmail.com>, <stable@vger.kernel.org>,
 <mykolal@fb.com>, <tamird@kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: add helper retval linked scalar
 pruning selftest
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Shung-Hsi Yu" <shung-hsi.yu@suse.com>
X-Mailer: aerc
References: <20260611160749.391279-1-jt26wzz@gmail.com>
 <DJ6DMGTPWXJN.1YKSBHULQ1PB9@gmail.com> <aivZ9jYGw6QRxLQQ@u94a>
In-Reply-To: <aivZ9jYGw6QRxLQQ@u94a>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.15 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298743-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:jt26wzz@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:kpsingh@kernel.org,m:haoluo@google.com,m:jolsa@kernel.org,m:menglong8.dong@gmail.com,m:eddyz87@gmail.com,m:stable@vger.kernel.org,m:mykolal@fb.com,m:tamird@kernel.org,m:shung-hsi.yu@suse.com,m:johnfastabend@gmail.com,m:menglong8dong@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,iogearbox.net,linux.dev,google.com,fb.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,r0.id:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,r7.id:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F23E67B321

On Fri Jun 12, 2026 at 3:18 AM PDT, Shung-Hsi Yu wrote:
> On Thu, Jun 11, 2026 at 09:55:55AM -0700, Alexei Starovoitov wrote:
>> On Thu Jun 11, 2026 at 9:07 AM PDT, Zhenzhong Wu wrote:
>> > Add a verifier runtime test for a branch pattern where a helper return
>> > value and a related scalar stay live across the same control-flow
>> > sequence. Rust/Aya-generated eBPF can naturally produce this shape whe=
n
>> > a match on a helper status keeps data derived before the helper call
>> > live across the same branches. Such code commonly uses the helper retu=
rn
>> > value in r0, where 0 means success, producing an r0 =3D=3D 0 / r0 !=3D=
 0
>> > branch shape.
> [...]
>> > +SEC("tc")
>> > +__description("helper retval linked scalar pruning")
>> > +__success __retval(0)
>> > +__naked void helper_retval_linked_scalar_pruning(void)
>> > +{
>> > +	asm volatile (
>> > +	"r7 =3D *(u32 *)(r1 + %[__sk_buff_data_end]);"
>> > +	"r5 =3D *(u32 *)(r1 + %[__sk_buff_data]);"
>> > +	"r7 -=3D r5;"
>> > +	"r2 =3D 0;"
>> > +	"r3 =3D r10;"
>> > +	"r3 +=3D -8;"
>> > +	"r4 =3D 1;"
>> > +	"call %[bpf_skb_load_bytes];"
>> > +	"r0 +=3D 1;"
>> > +	"r6 =3D 1;"
>> > +	/* success path keeps r7 independent; failure path links r7 to r0. *=
/
>> > +	"if r0 =3D=3D 1 goto l0_%=3D;"
>>=20
>> this exercises linked registers with BPF_ADD_CONST logic.
>> We already have such tests. Why do we need this one?
>> How is it different?
>
> BPF_ADD_CONST wasn't what was meant to be tested.
>
> The main logic is r7.id =3D=3D r0.id only happens on "if r0 =3D=3D 1 goto=
 l0_%=3D"
> fall through, and does not have such link otherwise. I only check tests
> added in commit c0087d59e504 ("selftests/bpf: tests for per-insn
> sync_linked_regs() precision tracking"), but it doesn't seem like such
> conditional linking was tested.=20
>
> The other rational is that this seem like a common pattern that is
> genereated from Rust-based BPF program.
>
>> > +	/* success path keeps r7 independent; failure path links r7 to r0. *=
/
>> > +	"if r0 =3D=3D 1 goto l0_%=3D;"
>> > +	"r7 =3D r0;"
>          ^^^^^^^ conditional scalar linking

Fine, it's a regular register linking without BPF_ADD_CONST.
Still the question remains. I believe:
"We already have such tests. Why do we need this one? How is it different?"


