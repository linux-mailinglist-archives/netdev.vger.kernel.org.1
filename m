Return-Path: <netdev+bounces-249813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E250AD1E650
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 12:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05883301E5BD
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 11:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5442B393DF9;
	Wed, 14 Jan 2026 11:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuuK1kw3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3659387348
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 11:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768390035; cv=none; b=iNw87K4W8b0uTxeEZyA8DB8e9k0kfVgQOjy941onqtIRNLFJtvaJqJdmjcvETs5/WZ0X0VIIRaOEUb2fTLMDiPXoUF8nag3aqkzY4ct/krw3crWAd1NNb2z7VFecuWZTBJyZd9IymCQtkPm/v9dcMDi/xBjmrkNRBZkrTYVeu/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768390035; c=relaxed/simple;
	bh=TjRPWgqhyUjPxRvze8WCNnZOW3HL1hS/GHohlno25Xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTVMMKJSdYVbrDclbbN4qObOMv9+Sgcv9UMsOZwJVRYgDbzERemoK6GNBMzuY/M3yJDQoyGr8rwv6f+G3Ja17F00gSgSNd+atg3EoMzBHA+FtAeyhJqi5UgRbzDm1c/SJvWJlxdm+IIIkeh7m+yit+X8qlIBd371cZtgn+YdLzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuuK1kw3; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-12339e2e2c1so164397c88.1
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 03:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768390033; x=1768994833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TjRPWgqhyUjPxRvze8WCNnZOW3HL1hS/GHohlno25Xk=;
        b=EuuK1kw3ln98NcxEvqpQnihIP/lbx7LmyHR407dyTlVgL+F8pg9U1SblXUXJckqCvD
         xVb/O8LlYLoyPpqeXR2LK+uMvvaQM19jxy5fjetbYmPc95jEyDKDlCkKs1/+WdaQm2zv
         a4+PZdiBjwMlFEtXZxbytbd7M8C/8Lb4Zp+788Puv8619SYETJvl7iBvsQTC1OT6o438
         FIwkhjLJYRstQ9QQmj5tURP12Hf+eu7KmGhJMY5fSHUYQPECWQp/dwEdE/S6edUdzbFy
         F0pjLje7bByK57HFT4oxv9YhH7Mg9MJtxBlne8PgDCExqvtdKWJP+KPwSYsWzHkdScel
         vEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768390033; x=1768994833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TjRPWgqhyUjPxRvze8WCNnZOW3HL1hS/GHohlno25Xk=;
        b=I1TevOl9pkM9wuaiaCaS5oZ8ndWqAtACZlye014GS/CQikW/zx7Zv5mREozrrTo9+w
         2TUPYzbvqs2QGb9PqlWdp2DuaBvGw3/TMrXSXGOVHETZDNY0IED+v1foc5SocUQAp2x/
         o1g4Jk6MGRFBNoETaEp46wpq0B6vAhv5h5UIHGYinny0SsjyTctYmzrx9Vwvygo+hKX+
         XT5V0ytZ2ETD8dnVtR8buGDtTYiUeU0zP73bxz9LMMyPQ/6ZmjWttYIw61hvWnpIPTDY
         o529mAv43pJ8BYnY45XPDP8LtqWv86J4szmMprt8l2Y+P8RCq3sV/WxML8jEmAHvNz99
         mpqw==
X-Forwarded-Encrypted: i=1; AJvYcCXQw2L8LPPmY3oOrf8B6CZ100i1IzwdqDIBZs2uxpdCvsbT1i6gqnF8kWsms65wEislS6Zq1qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoAXu9eOOPPIYJnCg7Hfg6attd0ifwG86f0yjj+GaQxK3xThqn
	nMIG4S6ZF9BEY7P8kg8EDcOjamXazFyOWb4auG1i/DI78XcQlOGllep+SpbesMvGjhD4jWpvyIf
	Lg9pulFt52IUQiTvbP2GkX4qd85U3LbI=
X-Gm-Gg: AY/fxX55rXPDK4RhgBskC1k7rcPk1a/D+HHvGkkZeaOH5KZuNrSxpMElZpseiC3MeAx
	cP7nETXVJnrwqR4DAtIQI6iMK4vSEqkRdJ+/fwD6jvBbovyW4yptXqSgI4GDczKtRGGRTuOOtlK
	JXJ/RcMhKQjx+erBVtxCOWtSMuUhwuhq81DWFhl5yHWTx4EHdibts6JSxl5s79dzY/IdKV87t/w
	1x2FpoC18oi+MLU94ZiJk6UDt6EN78UEtwzxxW8e0VdiglzLu6O6zYzWtmiVp2rWUxqfLsQ
X-Received: by 2002:a05:7022:f68a:b0:11e:3e9:3e91 with SMTP id
 a92af1059eb24-12336ace7a4mr2799488c88.26.1768390032943; Wed, 14 Jan 2026
 03:27:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114060430.1287640-1-saiaunghlyanhtet2003@gmail.com> <87h5so1n49.fsf@toke.dk>
In-Reply-To: <87h5so1n49.fsf@toke.dk>
From: Sai Aung Hlyan Htet <saiaunghlyanhtet2003@gmail.com>
Date: Wed, 14 Jan 2026 20:27:01 +0900
X-Gm-Features: AZwV_Qjjv2mgU3MAbDzDUxus_gdzmGv4n2OIWAE_fPClkKO4Y6-3eK2vn3SEat0
Message-ID: <CAGF5Uf48mRAuUZpTAGCGQtveDoDpF_1SKXFoBECqYzU4+dVwwg@mail.gmail.com>
Subject: Re: [bpf-next,v3] bpf: cpumap: report queue_index to xdp_rxq_info
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry. I did not know it as this is my first time contribution, and
did not check it.

What about introducing a structured metadata extension area between
xdp_frame and BPF metadata in packet headroom?

Below is the example memory layout:
Current (after redirect):
[xdp_frame 32B][BPF metadata][unused headroom][data]=E2=86=92

Proposed:
[xdp_frame 32B][kernel_metadata 48B][BPF metadata][unused headroom][data]=
=E2=86=92

But, the problem that comes to my mind while thinking about this
solution is that
additional 48 bytes of headroom beyond the 32-byte xdp_frame would be consu=
med.
WDYT?

-Sai

On Wed, Jan 14, 2026 at 7:53=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@kernel.org> wrote:
>
> saiaunghlyanhtet <saiaunghlyanhtet2003@gmail.com> writes:
>
> > When packets are redirected via cpumap, the original queue_index
> > information from xdp_rxq_info was lost. This is because the
> > xdp_frame structure did not include a queue_index field.
> >
> > This patch adds a queue_index field to struct xdp_frame and ensures
> > it is properly preserved during the xdp_buff to xdp_frame conversion.
> > Now the queue_index is reported to the xdp_rxq_info.
> >
> > Resolves the TODO comment in cpu_map_bpf_prog_run_xdp().
> >
> > Signed-off-by: saiaunghlyanhtet <saiaunghlyanhtet2003@gmail.com>
>
> This exact patch was submitted before by Lorenzo[0] and was rejected
> with the argument that we shouldn't be adding more fields to xdp_frame
> in an ad-hoc manner, but rather wait until we have a more general
> solution.
>
> -Toke
>
> [0] https://lore.kernel.org/r/1a22e7e9-e6ef-028f-dffa-e954207dc24d@redhat=
.com

