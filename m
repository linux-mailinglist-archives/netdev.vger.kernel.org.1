Return-Path: <netdev+bounces-288598-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MCwHYQvCGr/dAMAu9opvQ
	(envelope-from <netdev+bounces-288598-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 10:49:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE7D55ACD0
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 10:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 134923016011
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 08:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E924A363C7A;
	Sat, 16 May 2026 08:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKbGWecD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414BE3803DE
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778921342; cv=none; b=l6qxNbyxLd+PlhDV2qhUqEu2s+jap72OXVx92wsUaWKZvsIMMeVVRGz6GyQYKg8KbfxR7Z/yAAvl28yzUDVXTTAECobTXwi4oyJiNRI95eZnE3rPBqi3E2y7RNqJuA64mnxKr0YY/O2dyjx0ENjc1wet399IWnXSutOS2khrLI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778921342; c=relaxed/simple;
	bh=hC1pnnTj2YmTbb1/inKjFbYCPrHajsuMGjuM5RvZWq0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJFpKxik23ARL6qX/KB3//cIQJ8bRNk7+w2bNinQzKwd5WjoNw0MwRVeVgYBHL2VOu4CWyR4+zVVxTb3Rhp/sarG6YQg+LQt9ug0zEkIjP+1nLqlMCJPyjTWFELIDKiE3TXFnqpo9SS5ADKKQ0YMdLfwi9F5cEU+eWy5hdxXwbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rKbGWecD; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso3807055e9.2
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 01:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778921340; x=1779526140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWDhEh0VUyusmqIuXBpbDsyQkdanrqM00cM/70nu0Ls=;
        b=rKbGWecDs1UI53OJd7gZhuKtYfU/nBwV1WHmLyjSyKXPzXaPy67DXc8cpBdkE0hphP
         PvPQ4RP2o/XBfcVRXowurYxnib9oJpg6f0Gsk8fb3jYItwVGirRdzP1dLlaxaDMM5CWK
         tn4Himm2zGsBethotVCtrs3RtTGYki6syP61pS9Z4lYowhENPcQgaJsMbA/o1UAMBYK8
         F4cIPEEgD2Zks8FfWFJGhfFogRD7hvqdYkoVqdfAfoTnrrUJHs5rtqR1pSZuoCNiQWMt
         wZJrdDRpOpYNVDj7Xe1dQaVcpeJ91CI7nHc/Syijv1H8z3Iqw65ah2dasYBtqbawCVOC
         Fxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778921340; x=1779526140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NWDhEh0VUyusmqIuXBpbDsyQkdanrqM00cM/70nu0Ls=;
        b=Dg0epgnTEKLu5QTuMeaQbI8C7bebXUl2XFLAPfIo/bxVKPcIDzzu2tssjyluDJl5tB
         7dYdmdbvJQ9zTaS/XcntNm9UNjruBjCJYn+dLOfjOjD7vO5k+sAmBuDlaZ6+NymBN9b1
         sCcgXuejgAaHk/aiSkuVf1dkoXESO3JnEUNeWdctYGNnNGTF+TdhHOLnrALNaLsoxVhJ
         Woz6TFv3gA8bkc3As/KD5uyLy/dqA3zw7bYPTQ614kx9/20penrKfmZFyKpLQHKQuzHq
         rCRA9l1CrVRkr9LgfJU8LyWPQCf2aHqHTNGku4aC1XQjM5W5g7hzZh9uHdwnRD18iiK8
         7zag==
X-Forwarded-Encrypted: i=1; AFNElJ/BNmltT3cSTj9cXFUVvP/6C+1MQnXg09cTbdmOCfdwgWuy90kJVfzg8W8DxjkNaHjG+ZEltrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlTrF6NdQiJ8+3HroMcXctj+RbWOBZCBQVKNQPHetnv88vAGsh
	5W0AM+yaMD1g050kl7iHA8+Extq346xoZTo4W1fB3ArDeL7N2pfLUkJW
X-Gm-Gg: Acq92OEMYjiDtFgFe9c24AothPyoFNgnd1eW0tWhuXfX5xPRK2Pwd7VHINjvmQVK8x/
	syjx6pDBHa6qbSWRPd96pWP7Cg13ao7C5nBWzecwnfmFD1fhQen4q0GtD1/ktYaFRH6wAjXxBFB
	g4xF+AALXZuASYibnLIOnyo3okT+J7Z4t8kiDqV+avUnQnC9T18DoIRX+RID6rQtC4c42yBcgXL
	4x8OsPAwUgQa5wOPbCMfSOaSkdD3Jx/hAnwebsglEDiEDVL+1NQw3fPoc54de0puEgDTbyTt23u
	ab/s8aEyFbu+a4lCQ30QdBsBzmm6eloYDXhH6+jm9FyNoUgx3i6gKZCJ1IBpyRvcfGgNSvptZVJ
	wf50YvH6eDco5Q/dYnnv9pucdPqPdI/TfNXpCeIbASm87XCjflsb28+zl8ERm3aJnuBm9D+msQb
	QomYdl5voClcmbFkkm4DwgqhOs6Hh6/6NjWkXEiq36i84HaRzf9P0NNwfaJQXO
X-Received: by 2002:a05:600c:4e47:b0:48e:8345:6f8f with SMTP id 5b1f17b1804b1-48fe632361fmr105367375e9.18.1778921339454;
        Sat, 16 May 2026 01:48:59 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe57943b2sm116227845e9.8.2026.05.16.01.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 01:48:59 -0700 (PDT)
Date: Sat, 16 May 2026 09:48:57 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, "Arnd Bergmann"
 <arnd@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, "Martin KaFai Lau"
 <kafai@fb.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@redhat.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Simon Horman" <horms@kernel.org>, "Stanislav Fomichev"
 <sdf@fomichev.me>, bpf <bpf@vger.kernel.org>, Netdev
 <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: test_run: reduce kernel stack usage
Message-ID: <20260516094857.2ad1c850@pumpkin>
In-Reply-To: <20260515193804.4d85283b@pumpkin>
References: <20260515113102.2389020-1-arnd@kernel.org>
	<CAADnVQLYitAZVpXCTygA1uAUtN6m8pMkWzFi9su719M=nktmQQ@mail.gmail.com>
	<b387dd31-0ee5-41b9-b07a-13b718080e89@app.fastmail.com>
	<20260515193804.4d85283b@pumpkin>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: EAE7D55ACD0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-288598-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iogearbox.net,davemloft.net,google.com,redhat.com,fb.com,linux.dev,fomichev.me,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, 15 May 2026 19:38:04 +0100
David Laight <david.laight.linux@gmail.com> wrote:

> On Fri, 15 May 2026 17:15:46 +0200
> "Arnd Bergmann" <arnd@arndb.de> wrote:
>=20
> > On Fri, May 15, 2026, at 16:47, Alexei Starovoitov wrote: =20
> > > On Fri, May 15, 2026 at 4:31=E2=80=AFAM Arnd Bergmann <arnd@kernel.or=
g> wrote:
> > >
> > > 1k?
> > > pahole -C xdp_test_data
> > > /* size: 192, cachelines: 3, members: 9 */
> > > /* sum members: 120, holes: 1, sum holes: 56 */
> > > /* padding: 16 */
> > > /* paddings: 1, sum paddings: 36 */
> > >
> > > what s390 doing to make it huge?   =20
> >=20
> > I think it's a combination of cacheline alignment (256 byte
> > lines) that leads to padding before 'rxq' and at the end of
> > xdp_test_data, as well as CONFIG_KASAN_STACK that increases
> > the stack usage further. =20
>=20
> There will also be a 'double stack frame' in order to put an
> aligned item on stack.
> That could be slightly larger than a stack frame and probably doesn't
                                       ^ cache line
> show up in the figures.
>=20
> -- David
>=20


