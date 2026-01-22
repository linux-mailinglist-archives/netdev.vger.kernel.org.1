Return-Path: <netdev+bounces-252421-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0N8jCcdTcmnpfAAAu9opvQ
	(envelope-from <netdev+bounces-252421-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:43:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8806A316
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCFB0314FFDD
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9E3366064;
	Thu, 22 Jan 2026 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vOG9jW/2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C23366041
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 15:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097439; cv=pass; b=vA1p9aX0Zk56NpLR24LD/5JPbel9+xtRyC1pO4zhR0rh3YQ5+IROWXNYmu8F3Uj3RhLoQQJ61MUG3gfehLynYq/YApa8vO8C3kNCvlshOUmkyWoufnXVrYpPS8p5zwnDtN7Im6jCR0vMmQH8E18av8y5dVarD27do2Rlz911tp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097439; c=relaxed/simple;
	bh=Yj4BIWXcszVHy3RbHw3mIijcq3FuH0VHZcWejptXT2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dxPEZpUi8dddgXQPc8Rywoql+ysfH3hX8P02+aPjGtYNmM50Znnzldb9l6N5jr84f28jwjz7HqcZwOKB2tHcl9o8YkUCDJnshWeZpp5o75JomdpvQXU4XqMAkQY5ERbIiVzCuz3vkgJYhgPC3nZVezrgorX7RRtEMurtBrGgjWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vOG9jW/2; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-501506f448bso8315001cf.3
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 07:57:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769097435; cv=none;
        d=google.com; s=arc-20240605;
        b=aM2D4yk7Epj33wk0LoYZ6gOVnjAHAIX4Og4mEBpPBSKMh/HNzmbdnsDbBBEWI5x7zo
         Q1CZWZ6biirv/rArqVY/rhXaiW2db86jS5wsowsTL54bwZT1vBWylOq7m0kiO4jSjpEs
         pahmAen7vUD/apt3rtyWOICWeyHy6Ry0kDpJSvF0kVnC6mcBFFE2GzIzsJIW5+Gd64L1
         CPsRgGVJK8FSRF1Ri/NLU7NCAeiwzhUD59FmZSQ2s8iR0WrG5PIGLW2l5VogfhtCWpAk
         knS4HhWQlffu/xsaKRq2G+6QwPxsRQFjoBG4qeeVP77tXij+OdjKS2MBA2PtxnF96jD6
         eVMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yj4BIWXcszVHy3RbHw3mIijcq3FuH0VHZcWejptXT2c=;
        fh=3Rk5QNjezc4mX5WbylVOe50dx4lNaBmVPjoqE/ClL78=;
        b=NzHsYTZWa/kh+rKigUQIMfcrjFJ2poPnW7xcqTfhYfaLFPLNXm0s4Xqoz8Z7QJ6Ucd
         jZ4IfVS/L0HQqnZCjR8lT59iNQ5Ebiga74CKWp7syKhG3ExacSautDlHrIWyWELDGMqH
         UIOhO7PeYm71JOv2JZ6UGWpzaLc8QeDUnXRDUjT/YIoiqLQWqgjQ/wmzMiNM1fFH32u9
         7muHLEzWvLpYeuIlO5NFCQJSOUTXIX4ExleTjG/zTCRZNUCTPmo8H654ypCIbVz9Yrep
         OIGxEx9wv/LlYu6AyRVN6EIHgWP8E+sTxa4kQoBPbSmuI55w0SsbxtJ4zkEsA7Y/Kdpn
         k8NA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769097435; x=1769702235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yj4BIWXcszVHy3RbHw3mIijcq3FuH0VHZcWejptXT2c=;
        b=vOG9jW/2ymkVmDowptiaV4KZWiO0JMtNgpPsS124nS+tVr7zw4Z5p5J1mnMyGwz94a
         4/BXvcylZpc6HHWjmjo4cwjthmFvcGW/xMgX/34HmVtmiCcw4oR1xpiW+0b80bhp/R8/
         ilK2R49cvSTKRBY+u12HGB4xuATi1ZVFJSnWIqpZ9HCdfONd16B8PDY/ezzy1oMKzw4O
         8XSa+voc5YmY39vnkMq1ebryANiX3rCooV5Jn9SUwqmGO94JYALEGA7BmzhgUgx8r3/7
         R/i18qkdS9/99T3ij6RFk5QOcIplDUQnTm6yagdz7AcYXrlZIZEGySUwA8prQ92hVO3A
         2C9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769097435; x=1769702235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yj4BIWXcszVHy3RbHw3mIijcq3FuH0VHZcWejptXT2c=;
        b=LAkBR2seHO4h+2aFWIZOmcZeCqXHTmzZZCepzKBgNLMWO+AQCYYwQqGwIxSgrgI1w3
         X0GtGCRxZ+isiIJtXV0aNJd4wtqUL43Qvj2zyhVX2bnGoB2rm52oCK5IVpogGLra0z1V
         jxtxGWhuXHu17M5kX2KK02At/a2lIHF7A69li98j3T9fMQkj5yZm01bdu+n22Lebh+aC
         dK0lTlKgZ4OE3TSEMdyhtNLkImCQSkv+tJu7bGDHY06FIwbiX3YolRE8uF3IMxvpthCq
         wi8Xc0D0J/MaCeMGexjPloPtlYdyqQg+zTCsh+Uk2sN2fWT+8gTF+j9iGsxuO/UDtpEk
         HnDw==
X-Gm-Message-State: AOJu0YwI+rLLdHjfm2PliCQIDlYXdxto5QpCS9b6XAnI6ieiI04XXlY+
	ZKTMNRFaaKho7BOQDtVVzJ2siyRbV4n+KFNm1mR32Lw+ecxF2pAFv97AF1Le7uQgQNtSOQuyrZw
	0Bt74EXCtyRueZ72Af0nzNKMCY8AjfsYMveohFGig
X-Gm-Gg: AZuq6aJIV39a/PivJGoWuBEmJuwuLGac7Fmn2bC66WzvatIqy1SrFZuYrmoYNk5mOba
	BhYnLE5LtDBQR82+C8/Sliy5rVn1zqi6SDD9M/U9EhbkdP/IidoNWTXVJrH7Tu14kIvfQevlF/r
	w5Sz4+m8WiteVlGLA255zl9039tYddFvHJbMip8JrLlHvV81o5dqItCqJuRWk7+cjMiJ7pJAXN8
	42sdGz2PhYPYWGmXyh1pqCmAdcDG66+wY3VH329AVd9nGSzMU5LtWY2v62Qdo1tsZt7+qoL
X-Received: by 2002:a05:622a:1195:b0:502:6ed5:7b04 with SMTP id
 d75a77b69052e-502d853be68mr131098091cf.74.1769097434554; Thu, 22 Jan 2026
 07:57:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120152856.1694824-1-edumazet@google.com> <20260122022237.2529455-1-kuba@kernel.org>
 <CANn89iLK1saW=7jxhtew_skR-rPPonFi71brvTApeKM5VVadiA@mail.gmail.com>
 <20260122072858.2b652eb7@kernel.org> <CANn89i+0kJ5M1_6NPxbe4k5eY4sPwNeKN0yKyaHzFhZDT9-=kQ@mail.gmail.com>
 <CANn89i+7H32ODq3=nEfoORTR+6FiO2mOWRcLFf-K=+4UQcOmig@mail.gmail.com>
In-Reply-To: <CANn89i+7H32ODq3=nEfoORTR+6FiO2mOWRcLFf-K=+4UQcOmig@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Jan 2026 16:57:03 +0100
X-Gm-Features: AZwV_QgdaPaEBuvZtdaLr8nBTuHIJSiHHMzzSG-NQO1IG2LBCMmqKn-eORHodA4
Message-ID: <CANn89i+eEGOkU0gS8CEh1WepoSBczt8Rq4r0nMA41Q=y5EADxQ@mail.gmail.com>
Subject: Re: [net] bonding: annotate data-races around slave->last_rx
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, syzkaller@googlegroups.com, andy@greyhouse.net, 
	eric.dumazet@gmail.com, pabeni@redhat.com, j.vosburgh@gmail.com, 
	davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252421-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,googlegroups.com,greyhouse.net,gmail.com,redhat.com,davemloft.net];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B8806A316
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 4:56=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Jan 22, 2026 at 4:50=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Thu, Jan 22, 2026 at 4:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > On Thu, 22 Jan 2026 05:42:55 +0100 Eric Dumazet wrote:
> > > > > This seems like the same concurrent access pattern that the ARP I=
Pv4 path
> > > > > needed fixing for.
> > > >
> > > > I saw this spot, but determined this was used at setup time, not in
> > > > packet processing.
> > > >
> > > > I was maybe wrong.
> > >
> > > I guess if nothing else we should do it for consistency?
> >
> > To be clear, I will cook a V2 with this part.
> >
>
> _bond_options_ns_ip6_target_set() probably needs a fix as well.

Sorry, copy paste error : I meant : bond_option_arp_ip_target_rem()

>
> Is AI review stopping at the first error ?

