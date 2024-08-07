Return-Path: <netdev+bounces-116581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9240994B0D9
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 22:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D5D6281B7D
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 20:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE66145354;
	Wed,  7 Aug 2024 20:02:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE5484A51;
	Wed,  7 Aug 2024 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723060965; cv=none; b=LIbHYuDOKRasz0EoGJCpAuqL8D+Yx7NwzPbcqgD1esQ+6g1KZWfTL8L6P5rethmtiYndObRQdRbfz8HdtSc6p0S5Mb6CldEiKLgqbmptuN1TZXtqdKXWDJ0GkK/AX5OS80jkMUL4+mpM5GvrlBlYscIUjNHxwAstK2vnpSTxOa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723060965; c=relaxed/simple;
	bh=6E6ue2xLntVa0zLAon87+tkD4nau8DimoBNDAvRZzrM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VD+9AqXeN0AIhIkH4fA3qFPcMRSiGM4AFswMYopf3R/iSIhRkolZCXC1rp6nlNZBWZQho8UyS5woxTxVbhDAHyAkIwkY9nDb130YOfJeKBbXRsgSFGl8yj2ze0hOwKLYTZLi6wCklLvNGQ+/Nfp6/qxz2BoGuuUzkNAqDfQ5NEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E624C32781;
	Wed,  7 Aug 2024 20:02:42 +0000 (UTC)
Date: Wed, 7 Aug 2024 16:02:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Liju-clr Chen <liju-clr.chen@mediatek.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Richard Cochran
 <richardcochran@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Yingshiuan Pan <Yingshiuan.Pan@mediatek.com>, Ze-yu Wang
 <Ze-yu.Wang@mediatek.com>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-trace-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-mediatek@lists.infradead.org>, Shawn Hsiao
 <shawn.hsiao@mediatek.com>, PeiLun Suei <PeiLun.Suei@mediatek.com>,
 Chi-shen Yeh <Chi-shen.Yeh@mediatek.com>, Kevenny Hsieh
 <Kevenny.Hsieh@mediatek.com>
Subject: Re: [PATCH v12 20/24] virt: geniezone: Add tracing support for hyp
 call and vcpu exit_reason
Message-ID: <20240807160241.2370ae9b@gandalf.local.home>
In-Reply-To: <20240730082436.9151-21-liju-clr.chen@mediatek.com>
References: <20240730082436.9151-1-liju-clr.chen@mediatek.com>
	<20240730082436.9151-21-liju-clr.chen@mediatek.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Jul 2024 16:24:32 +0800
Liju-clr Chen <liju-clr.chen@mediatek.com> wrote:

> From: Liju Chen <liju-clr.chen@mediatek.com>
>=20
> Add tracepoints for hypervisor calls and VCPU exit reasons in GenieZone
> driver. It aids performance debugging by providing more information
> about hypervisor operations and VCPU behavior.
>=20
> Command Usage:
> echo geniezone:* >> /sys/kernel/tracing/set_event
> echo 1 > /sys/kernel/tracing/tracing_on
> echo 0 > /sys/kernel/tracing/tracing_on
> cat /sys/kernel/tracing/trace
>=20
> For example:
> crosvm_vcpu0-4874    [007] .....    94.757349: mtk_hypcall_enter: id=3D0x=
fb001005
> crosvm_vcpu0-4874    [007] .....    94.760902: mtk_hypcall_leave: id=3D0x=
fb001005 invalid=3D0
> crosvm_vcpu0-4874    [007] .....    94.760902: mtk_vcpu_exit: vcpu exit_r=
eason=3DIRQ(0x92920003)
>=20
> This example tracks a hypervisor function call by an ID (`0xbb001005`)
> from initiation to termination, which is supported (invalid=3D0). A vCPU
> exit is triggered by an Interrupt Request (IRQ) (exit reason: 0x92920003).
>=20
> /* VM exit reason */
> enum {
> 	GZVM_EXIT_UNKNOWN =3D 0x92920000,
> 	GZVM_EXIT_MMIO =3D 0x92920001,
> 	GZVM_EXIT_HYPERCALL =3D 0x92920002,
> 	GZVM_EXIT_IRQ =3D 0x92920003,
> 	GZVM_EXIT_EXCEPTION =3D 0x92920004,
> 	GZVM_EXIT_DEBUG =3D 0x92920005,
> 	GZVM_EXIT_FAIL_ENTRY =3D 0x92920006,
> 	GZVM_EXIT_INTERNAL_ERROR =3D 0x92920007,
> 	GZVM_EXIT_SYSTEM_EVENT =3D 0x92920008,
> 	GZVM_EXIT_SHUTDOWN =3D 0x92920009,
> 	GZVM_EXIT_GZ =3D 0x9292000a,
> };
>=20
> Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
> Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>

=46rom a tracing POV, I don't see any issues with this patch.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


> ---
>  arch/arm64/geniezone/vm.c          |  4 ++
>  drivers/virt/geniezone/gzvm_vcpu.c |  3 ++
>  include/trace/events/geniezone.h   | 84 ++++++++++++++++++++++++++++++
>  3 files changed, 91 insertions(+)
>  create mode 100644 include/trace/events/geniezone.h


