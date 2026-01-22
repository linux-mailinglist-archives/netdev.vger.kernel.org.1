Return-Path: <netdev+bounces-252151-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NQyLWCQcWkLJAAAu9opvQ
	(envelope-from <netdev+bounces-252151-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:50:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 210D061147
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 03:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E4834E4E73
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 02:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267163148AF;
	Thu, 22 Jan 2026 02:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XSsOoHQh"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D038A2AD22
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 02:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769050202; cv=none; b=jw6mjVs7fkJ8oyrfIG4Vr0pkozsetqYf1Cg/po8OA9JRnNHLeStwJ3D1C2MStZ+oC673CW+elfm2D49mmbMeHPXsAFIfY6XXJWeC3P5ZS6CGlOQ+cSXTT6+oiLbaurycVQnj5NUa4REB29S2ha1W3IkjMxmsKYPYcHHYlvxy604=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769050202; c=relaxed/simple;
	bh=lQRMsW/DIzakWp3Z6e8jYtTsZJehbKtDnMWY2SdS4Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mxZmOork0Gr5O3FL83hE3jjVCFmdyrBEmsuRo8aasSmGe5ai9OvGOVSlsJyq1dNZUpZgsIKPA1RXoR9qxJQPYf7E10/zXdcsH0G0z4IkrwHncOU/Scp10NH6/x4YNrnKEcEAEY+YFfEJnllUWhBLc8lp0Qk7ZOkk8/AcfS8JNXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XSsOoHQh; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769050196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NAquLWkfaoXFtBTk6QgDbkMnqVzynMeysZ13SKr6Pgw=;
	b=XSsOoHQhH/9GrcwQQCzpjBLNAmFfeaUlMyi0zN1thH51fomXA/1qqLTaRFO5j+MJckW3YO
	YphtBRZXYY8oJTh4BExWHjGghEzSczZOnKtixDqF8x+G+PXuOUaKV3hc7qu8bFPGmlJf19
	bMzhpvplmrWkle6vFpDjdw+NrokGgdE=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v10 00/12] bpf: fsession support
Date: Thu, 22 Jan 2026 10:49:35 +0800
Message-ID: <2026435.PYKUYFuaPT@7940hx>
In-Reply-To:
 <CAEf4BzZX+hDww=MvMrqx3h9uKdB+Sef8rVMxrvxcm+9jj7MUjg@mail.gmail.com>
References:
 <20260115112246.221082-1-dongml2@chinatelecom.cn>
 <CAEf4BzZX+hDww=MvMrqx3h9uKdB+Sef8rVMxrvxcm+9jj7MUjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252151-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	R_SPF_SOFTFAIL(0.00)[~all];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[menglong.dong@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,davemloft.net,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,linux.dev:dkim]
X-Rspamd-Queue-Id: 210D061147
X-Rspamd-Action: no action

On 2026/1/22 08:09 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> On Thu, Jan 15, 2026 at 3:23=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > Hi, all.
> >
> > In this version, I followed Andrii's suggestions in v9, and did many
> > adjustment.
> >
> > overall
> > -------
> > Sometimes, we need to hook both the entry and exit of a function with
> > TRACING. Therefore, we need define a FENTRY and a FEXIT for the target
> > function, which is not convenient.
> >
> > Therefore, we add a tracing session support for TRACING. Generally
> > speaking, it's similar to kprobe session, which can hook both the entry
> > and exit of a function with a single BPF program.
> >
> > We allow the usage of bpf_get_func_ret() to get the return value in the
> > fentry of the tracing session, as it will always get "0", which is safe
> > enough and is OK.
> >
> > Session cookie is also supported with the kfunc bpf_session_cookie().
> > In order to limit the stack usage, we limit the maximum number of cooki=
es
> > to 4.
> >
> > kfunc design
> > ------------
> > In order to keep consistency with existing kfunc, we don't introduce new
> > kfunc for fsession. Instead, we reuse the existing kfunc
> > bpf_session_cookie() and bpf_session_is_return().
> >
> > The prototype of bpf_session_cookie() and bpf_session_is_return() don't
> > satisfy our needs, so we change their prototype by adding the argument
> > "void *ctx" to them.
> >
> > We inline bpf_session_cookie() and bpf_session_is_return() for fsession
> > in the verifier directly. Therefore, we don't need to introduce new
> > functions for them.
> >
> > architecture
> > ------------
> > The fsession stuff is arch related, so the -EOPNOTSUPP will be returned=
 if
> > it is not supported yet by the arch. In this series, we only support
> > x86_64. And later, other arch will be implemented.
> >
> > Changes v9 -> v10:
> > * 1st patch: some small adjustment, such as use switch in
> >   bpf_prog_has_trampoline()
> > * 2nd patch: some adjustment to the commit log and comment
> > * 3rd patch:
> >   - drop the declaration of bpf_session_is_return() and
> >     bpf_session_cookie()
> >   - use vmlinux.h instead of bpf_kfuncs.h in uprobe_multi_session.c,
> >     kprobe_multi_session_cookie.c and uprobe_multi_session_cookie.c
> > * 4th patch:
> >   - some adjustment to the comment and commit log
> >   - rename the prefix from BPF_TRAMP_M_ tp BPF_TRAMP_SHIFT_
>=20
> This is minor nit, but I think BPF_TRAMP_IS_RETURN_SHIFT and
> BPF_TRAMP_COOKIE_INDEX_SHIFT (note added INDEX, because that's what we
> store, not the cookie itself) makes more sense naming-wise and is more
> natural to read. Consider updating this.

Yeah, looks nice.

>=20
> >   - remove the definition of BPF_TRAMP_M_NR_ARGS
> >   - check the program type in bpf_session_filter()
> > * 5th patch: some adjustment to the commit log
> > * 6th patch:
> >   - add the "reg" to the function arguments of emit_store_stack_imm64()
> >   - use the positive offset in emit_store_stack_imm64()
> > * 7th patch:
> >   - use "|" for func_meta instead of "+"
> >   - pass the "func_meta_off" to invoke_bpf() explicitly, instead of
> >     computing it with "stack_size + 8"
> >   - pass the "cookie_off" to invoke_bpf() instead of computing the curr=
ent
> >     cookie index with "func_meta"
> > * 8th patch:
> >   - split the modification to bpftool to a separate patch
> > * v9: https://lore.kernel.org/bpf/20260110141115.537055-1-dongml2@china=
telecom.cn/
> >
>=20
> Overall this looks great, I was actually trying to apply and push it
> despite those minor nits I left. But unfortunately there is some
> conflict, so you'll have to rebase and resend. Hopefully just one last
> time :)

Haha, sounds great! I'll follow your comment and rebase, and
send the next version later.

Thanks you the review ;)

>=20
> > Changes v8 -> v9:
> > * remove the definition of bpf_fsession_cookie and bpf_fsession_is_retu=
rn
> >   in the 4th and 5th patch
> > * rename emit_st_r0_imm64() to emit_store_stack_imm64() in the 6th patch
> > * v8: https://lore.kernel.org/bpf/20260108022450.88086-1-dongml2@chinat=
elecom.cn/
> >
[...]
> >
>=20





