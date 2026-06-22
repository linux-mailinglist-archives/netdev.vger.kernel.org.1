Return-Path: <netdev+bounces-301142-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RnK5BURNOWoUqQcAu9opvQ
	(envelope-from <netdev+bounces-301142-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 16:57:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 821136B0888
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 16:57:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.s=20251104 header.b=Y5RACkEG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301142-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301142-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=networkplumber.org (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E39D53012B07
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 14:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E233101A5;
	Mon, 22 Jun 2026 14:57:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DE530DEAC
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 14:57:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782140225; cv=none; b=hEJ7TdWeiEEt0OGpTfqZEXrI+ENbWGONknJK4wPciFDUJVK2Mt38QaNe1bgEJnwHyNBaPgT+Fl2uEbZ1sZfmmscl5mUx173d/lwtCPKlGvwSkhz+FWtTwshKo2W6IbqCXUV0gAIhEleNnrciYIIhPDwx9TXzIU6LuH4nW7mfYrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782140225; c=relaxed/simple;
	bh=0hLLKMzQu8RNFIKEy1vh7Z2WBSIBgnuV1KVfQH7vWDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JzSVnRozj8n8x/92eTyzsTHNETffMazMbqL7+XkowEY/LXtxAuT1tbqZfn+fLMZDraLbC46OMw8QKPW5IYLba0OXja555NLLRHo8TX/7B4NzdxQpmbGgekZlYBj70xvZAJiXusYqUaIa4DI+9ybd6tEsl+BQdTcvGiopcR8IbLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=Y5RACkEG; arc=none smtp.client-ip=74.125.82.54
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-137eb0d76beso3862616c88.0
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 07:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782140223; x=1782745023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hLLKMzQu8RNFIKEy1vh7Z2WBSIBgnuV1KVfQH7vWDA=;
        b=Y5RACkEGZNO3pkGwCyicMg6kpD/Drgy743ABPojB3MuN2JcL7TyoSLhn49kLw9XbRq
         WkwKS6ZwzImet5AFkptz3jGbAbOts7GU5VwZ4aYcdrq3nUQbOavf9OJRft3pQGnXoome
         CCKy8fvGodrBOkZ4fgFN4w4x4NzyxXp6LSOgpQWPTq/vtCnKFWHlrozQ0Zh/MOZJQtIt
         9BqefDdNsJ6OJ81jAO4O7rb9AIUXX4kNusSd+K+riyy0FJ+5LpRHvcGwi6eDCYkxcPCu
         H8as8F22+iO1xZz7seMHhcrpCZbCicEmsnTmZhg0poHd3kqUqXthzNFVqUK+LYdPyP59
         gnaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782140223; x=1782745023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0hLLKMzQu8RNFIKEy1vh7Z2WBSIBgnuV1KVfQH7vWDA=;
        b=JKKCPu58nC4VsAyDsHGxZ+BOV681I0utdI4Cn32TMPoYPe8oaroWj26QZB9vMFKheT
         DvYznUeCdHwD9UfBAJKO2IUL0Ol3p7Qb3k8Vdrm4bwNzDUykgZR4Jrr560BFbENoid9K
         iOSLaZGFU4nVG9B5/W/GcYKYhmkhHwfvp5r3pMuWiLRPgnGkhZr54scDv8B8HFzHvc/Y
         4RbRcyD/YfyiZCBd7h6liu1E0g40X6WE4WXJ/VS5Jc07DUnpQWv+uTtpncEPEC3NC7Aq
         d24qxGqaAELR8bY5+jdpyaTUChiB00Qs9bSYIcX27VftnMW8XJjNEbIUAHogNoTP7M3r
         wRoQ==
X-Gm-Message-State: AOJu0YwLM+M+h67zyVYmr5hB2ADymSZ5rhAhuMMY20194BWijhrwxVFy
	6f7s1O51hbRpsK5ENjlWgz83hRc0lxPcEj4jw2hPZBAiO0nQsiThfiQjIUhiRzfE/PQ=
X-Gm-Gg: AfdE7ckH55Da46j+G6lns+Ygqe8BHwOhXCOy2+Cbdi6h9hkgmfmvYq411TP0sHddxMm
	xKOOAvJljhSzJJYlT8kKo1ynzl/+mtaOp431WLQUYgxeFj5IYcWF8qa/GoQHKfDeSWLDPRjMxvf
	NMKqW0CY/DnpufAONR3J0yTehmzFmMaxwvbb0QDqAmZ8Fq8ioviNOo9ykRzmA/cu8ILwjJ03mr5
	y+QAqji7nNC5SFtA2CVKCWfVi8enqoBSQOLNBxsHXmxcwOpHrT2oeUeayYiPxKAgE8+/2Maw/wJ
	ZYFc97elUHEtHruJEuXkZAH/VpcgR9SikaAe2hvbbJDc1PbbbgCHEPlAWEEAJ9o+TCpkaaf0HNG
	ym9jYZm/XV+PAY04MBKFRWY9gKC2K3gMjjhAeZAQ/GmilR8IAcEyU0RNA1Qn21cHRKeUZ9wDP3R
	Rd5fz5xG7rCbFFGRfCZPbDKfMxyYWQUSKNbikJdwJn6NgN2/Nc998REQ==
X-Received: by 2002:a05:7022:e989:b0:138:4021:b20a with SMTP id a92af1059eb24-139a3020d24mr8036699c88.3.1782140223186;
        Mon, 22 Jun 2026 07:57:03 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139add5bd68sm8854983c88.11.2026.06.22.07.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 07:57:02 -0700 (PDT)
Date: Mon, 22 Jun 2026 07:57:00 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dmitri Seletski <drjoms@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] "ip help" wrong output, exit code.
Message-ID: <20260622075700.27806286@phoenix.local>
In-Reply-To: <069b13e1-f689-410b-bd40-b5e5831b67e7@gmail.com>
References: <62f09fe8-899c-4d22-b7a1-67e2745613df@gmail.com>
	<20260621082105.1196ef72@phoenix.local>
	<069b13e1-f689-410b-bd40-b5e5831b67e7@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:drjoms@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-301142-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 821136B0888

On Sun, 21 Jun 2026 22:48:59 +0100
Dmitri Seletski <drjoms@gmail.com> wrote:

> From 0805e07105cd15c5b94271a4706e50e3c65dbde5 Mon Sep 17 00:00:00 2001
> From: Dmitri Seletski <drjoms@gmail.com>
> Date: Sun, 21 Jun 2026 22:12:43 +0100
> Subject: [PATCH iproute2-next] =C2=A0"ip help" wrong output, exit code.
>=20
> Changed output of "ip help" from standard error to standard output. And=20
> Exit is now 0 instead of -1. "ip help|grep bridge" - now gives bridge=20
> syntax instead of flooding user with everything from "ip help".
> ---
> ip/ip.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/ip/ip.c b/ip/ip.c
> index e4b71bde..4627b61c 100644
> --- a/ip/ip.c
> +++ b/ip/ip.c
> @@ -56,7 +56,7 @@ static void usage(void) __attribute__((noreturn));
>=20
> static void usage(void)
> {
> -fprintf(stderr,
> +fprintf(stdout,
> "Usage: ip [ OPTIONS ] OBJECT { COMMAND | help }\n"
> " =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ip [ -force ] -batch filename\n"
> "where =C2=A0OBJECT :=3D { address | addrlabel | fou | help | ila | ioam =
| l2tp=20
> | link |\n"
> @@ -72,7 +72,7 @@ static void usage(void)
> " =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-o[neline] | -t[imestamp] | -t=
s[hort] | -b[atch]=20
> [filename] |\n"
> " =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-rc[vbuf] [size] | -n[etns] na=
me | -N[umeric] |=20
> -a[ll] |\n"
> " =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-c[olor]}\n");
> -exit(-1);
> +exit(0);
> }

Your mailer damages white space.

