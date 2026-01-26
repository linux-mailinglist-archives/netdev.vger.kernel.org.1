Return-Path: <netdev+bounces-253574-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIC4Jyu+d2l8kgEAu9opvQ
	(envelope-from <netdev+bounces-253574-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 20:19:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C40F8C7C5
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 20:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16E04301B14D
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 19:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF6D27F010;
	Mon, 26 Jan 2026 19:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCMhsNji"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623BB27AC5C
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 19:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769455143; cv=none; b=BycBvpgUUa82S4f55/OCauVxuGEZRwxVIcSrm+tam/I4IF6YfBdpC9zHUcOCw3BFYoT6TqSM9/aGp4qHfDP42O7diSqiCFIGHxNrLSgBxqBRxq6l7sQ5umUY/xa+1ROKkFjJJM3dBugwyzTpW6j2pS9puadW9ZB42K4CIUDnMBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769455143; c=relaxed/simple;
	bh=X7WKfIe2F3sKHAkHtT8gREVlj3Y0lWqGCtTKhqJkDFs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PGqKtYGlBVG4HNz1ZMxpPHoGf5Uvquz9a6rsjM+nYiqbNcUf6RwdPz1hv3wtsdo96yddumCkNEeArwZPPp3CPg+mrWmwCDWS2Qm15lfgdWxIuJOSgoe27mFj2bRTbKt67oju0LVFIeEWslr329EHtJBQY+lWvTBo7xXV+TcKm38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCMhsNji; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so56204965e9.1
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 11:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769455141; x=1770059941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMORb+r1omq1DqBVvxD9Q2gvnIjSytvIGqt6iuJXuFo=;
        b=JCMhsNjiaIbp9WUn0wKRa7p9oZeoVwCthQb+Yyh/DlJe6HNX9Zw/LU4jlrohrdaVEP
         PVtFx/IgXgGiuv2y74MlHKc2/iTJsCNFRWrA33nqCbE7LCaJC58kSQG2aCR4hSk4/0/z
         9P/lSgREzGR2iQLGbZGRnmQAKfvAJfQp8uIa8rWfiFe8sLEKR7xnd13xWwK9b7JKG9qI
         EA0nlCL9ujjPwhcnu/MO+TDY7frTesfjbtNwT4ywLyIkk5WRAv/gcc1mGlqh4Kogb75l
         SON+DLpYL/CrEFfwa9nEsEE2huhuajcSPiz6t7rBNE9TDZUy1F8hcUbxbxA18kavVyHz
         +jKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769455141; x=1770059941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UMORb+r1omq1DqBVvxD9Q2gvnIjSytvIGqt6iuJXuFo=;
        b=C7xfLU9+Vl77tYNBS5kSh6KaFicl2rnrYO2jQZHZ3MN8ZDVupMICrm7I4yWTZ0UAt6
         RcI8yC0EDSE1RwwWYRR3ZvHUxifm+z7HJFdbCiti9bqW8oSO6yJO1DvPP2qTbMy0zLki
         jABWzPtZxessVg1tKwJr/um+CVoz4NPEFgUYVfPKf0Zi8Gal9UuFghu0w4otKcdh7X8Y
         Xlc8GUBRshRvwIikw8JwE7jhQ9ivgNVed13kwRIQ4lRJMhMO0Pgqbgd67qlLWSzy43N1
         vBRf6Xl0rrB/1wEdnqDdPrSaz0NY0kbu4A49YjMbCiKX4CKEk10B6pQIS8DZXb/rh38W
         e5Ng==
X-Forwarded-Encrypted: i=1; AJvYcCVgcSrdk6Ckm/NzOeXNGvHk8m3gWlf2lTf9qjQNA67lfCtlGVQ4IWTCqyDVvnCkS0hkI65Tm78=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlPR3O+RfquRNYKe9L4N9s6pTLpj3KZPC+Uu6dTBzBHpXNPLcy
	Dx3izq+l2qRI1hYMZRuKs508ePJyPyupJWkJmcdEKTSEykBduJrumqq+
X-Gm-Gg: AZuq6aJI4hsYz267gBCZHkDl/UyfI0nujNa51a63/2mtaBK/jYdjWQfvv64OcvXBrxy
	2E50+RVRRjtlYla7rGBKPPkTyBxY8/sIM02N5rSQT/9o/dd0u5/NGmwM6u33PJR87V+fgcf+ciE
	c56TP/HuXXWyLP5yKhhG9zckChFCFlPYe0vj7v2Vtgyhab9S00bcfA44ySlMJu0UtiM36fiBurV
	99XCmCQVfn31TmaAH8z+6dkUJO6iH4sHDVxaNeFS564w+1YopOgeMbVdAvv6bSY2txtyf9EW4iU
	FXOSLXJfVfzWZD7ahkO7yacP+CcN0x+i/e30IhV1DSEZKhfppA6S2VrX1T1tPBVgHitorzbalk5
	hE2F0CeB5bkSLrR14xRPQ6cKlSuxd4o9y5sXApe9tivABplyWixQpB7YDojAxkswCW5Mxh+be7R
	+ulGvi0x4c4J9iP9eHPXJRQYRq8GNGEGhCT/5frRUDEFWQ8XIljCvA
X-Received: by 2002:a05:600c:8b16:b0:47e:c562:a41f with SMTP id 5b1f17b1804b1-4805cf5f1a5mr80909895e9.18.1769455140603;
        Mon, 26 Jan 2026 11:19:00 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c24a8asm32075802f8f.12.2026.01.26.11.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 11:19:00 -0800 (PST)
Date: Mon, 26 Jan 2026 19:18:55 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org, Aaron Conole
 <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets
 <i.maximets@ovn.org>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, dev@openvswitch.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/7] net: openvswitch: fix load tearing with
 u64_stats
Message-ID: <20260126191855.04018872@pumpkin>
In-Reply-To: <CANn89iJrDgD4J=mgWRcQMW70621OUV37hucj76ugZUXBLdy_VQ@mail.gmail.com>
References: <20260123162159.2877941-1-mmyangfl@gmail.com>
	<20260123162159.2877941-5-mmyangfl@gmail.com>
	<20260126182928.39ab1d58@pumpkin>
	<CANn89iJrDgD4J=mgWRcQMW70621OUV37hucj76ugZUXBLdy_VQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253574-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,redhat.com,ovn.org,davemloft.net,kernel.org,openvswitch.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1C40F8C7C5
X-Rspamd-Action: no action

On Mon, 26 Jan 2026 19:35:38 +0100
Eric Dumazet <edumazet@google.com> wrote:

> On Mon, Jan 26, 2026 at 7:29=E2=80=AFPM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Sat, 24 Jan 2026 00:21:36 +0800
> > David Yang <mmyangfl@gmail.com> wrote:
> > =20
> > > On 64bit arches, struct u64_stats_sync is empty and provides no help
> > > against load/store tearing. struct copying should not be considered
> > > tear-free. Use u64_stats_reads() instead. =20
> >
> > Except that the compiler doesn't ever generate 'tearing accesses' for
> > aligned 64bit accesses on any 64bit architecture.
> > Similarly memcpy() won't generate problematic accesses.
> >
> > The problem is purely theoretical - the C language lets the compiler
> > split accesses, but it doesn't. =20
>=20
> Yeah, although we still have races that KCSAN can detect.
>=20
> data_race() or READ_ONCE() would be necessary to avoid noisy KCSAN report=
s.
>=20
> While many KCSAN reports are boring, some of them point to real bugs.
>=20

Could something be put in u64_stats_fetch_begin() to stop KCSAN bleating?

With the way READ_ONCE and WRITE_ONCE now get enforced I do wonder if
some data shouldn't just be marked 'volatile'?
That would give 'non-tearing' accesses, but without the inter-cpu
ordering that (I think) READ/WRITE_ONCE also give.
For stats counters that is enough.

	David

