Return-Path: <netdev+bounces-249684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CDBD1C263
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 03:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32C66300FD4B
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 02:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD75131354F;
	Wed, 14 Jan 2026 02:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cHNL/83X"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274413148B8
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 02:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768358354; cv=none; b=YvQXk8vKkggqHJRA2Dyl3RUCIrHQQB2jjhVX0tOzCR8RHG0doylH5bFB6oTHsuwFg3cnECBTRB3gJKXwTQHk9CW0K9rftiXNJED5iqZc8eQvuLfA6e12XTIjIZjDwkedtuqL5FOINS4IC7UMXHEtiSR2rxPpQWz74qD3VdcB/ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768358354; c=relaxed/simple;
	bh=+BHGhlR91oVn6ZUyA9eoQ6q4H2oY5Kdr98FBuLNBnNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHGP+RyBX4nHHAGSogDnSJnWERltjXMAir8DvSxsQoIPlr9xZHkEBK8/kiekPXTTA1ykkPB9lcLF2WqaRMcZS01pY5C/M+YQ5CHlcwxt3nWwxwrFwKFKjzlJr4AwuLII/AxxpxNp/OQN3qQmCTAKXKDJV16kkc5ecfj5CCz0xS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cHNL/83X; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768358339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+BHGhlR91oVn6ZUyA9eoQ6q4H2oY5Kdr98FBuLNBnNg=;
	b=cHNL/83XJvxkBqzU+D/wOM0d8gXOzpz0elUPpI26wxSEEqSu/nIeiK8yZFLvsImb3cDqY8
	pzqTI34xJjWm9sm/b1m7NONR8xPd+yvNrm4P0+RI8KHeqr1PAMX9NszOPi4W0NGccBSH9E
	0FFUsQyrFOkV37bvZMAmyxPj7LDEndA=
From: Menglong Dong <menglong.dong@linux.dev>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, jiang.biao@linux.dev,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject:
 Re: [PATCH bpf-next v9 05/11] bpf: support fsession for bpf_session_cookie
Date: Wed, 14 Jan 2026 10:38:46 +0800
Message-ID: <2687399.Lt9SDvczpP@7940hx>
In-Reply-To:
 <CAADnVQJzkXysOO9jqdvJUYbe2t+urReRV2xWQ0L2z0qcjgxdcw@mail.gmail.com>
References:
 <20260110141115.537055-1-dongml2@chinatelecom.cn>
 <CAEf4BzbrYMSaM-EEwz4UhZr0BG4FDyxtaG16e4z10QhmAY8o=g@mail.gmail.com>
 <CAADnVQJzkXysOO9jqdvJUYbe2t+urReRV2xWQ0L2z0qcjgxdcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/14 10:33 Alexei Starovoitov <alexei.starovoitov@gmail.com> write:
> On Tue, Jan 13, 2026 at 5:24=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sat, Jan 10, 2026 at 6:12=E2=80=AFAM Menglong Dong <menglong8.dong@g=
mail.com> wrote:
> > >
> > > Implement session cookie for fsession. In order to limit the stack us=
age,
> > > we make 4 as the maximum of the cookie count.
> >
> > This 4 is so random, tbh. Do we need to artificially limit it? Even if
> > all BPF_MAX_TRAMP_LINKS =3D 38 where using session cookies, it would be
> > 304 bytes. Not insignificant, but also not world-ending and IMO so
> > unlikely that I wouldn't add extra limits at all.
>=20
> I forgot that we already have BPF_MAX_TRAMP_LINKS limit for the total
> number of progs. I guess extra 8 bytes per fsession prog isn't that bad.

Ah, so it's OK to not limit the session cookie. I'll remove such limitation
in the next version.

Thanks!
Menglong Dong

>=20





