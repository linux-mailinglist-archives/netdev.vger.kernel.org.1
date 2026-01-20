Return-Path: <netdev+bounces-251571-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AXzNDPfb2n8RwAAu9opvQ
	(envelope-from <netdev+bounces-251571-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 21:01:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 858A34AF23
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 21:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5295562C14D
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 17:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7E8449EBE;
	Tue, 20 Jan 2026 17:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdsDEYyp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860CE4418FB
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 17:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768931705; cv=none; b=Y66CWQhRMv05vdydYlSkCSqFsUip/mv7AsF0IzHKCWpMM/IaSX8YZDgTYDSQ6nRCxj1akv0kC8J/WmY4WWUwV5eok9ShVAvnZA4MplGVDp+H6jybMB5OPSGtHLY/cAo3YiOKrf9OMifAA6bgjbABibwOkr+vFrvDsdQkbbKAqkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768931705; c=relaxed/simple;
	bh=KS8mCNBYfPwO900RIuZ97F5SmyGc3OhWN2Izos81IfA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JTuZ7vVE5xe5VpMZH6KmckuHHaKyKuJHWqFyoS3BdJ0LMtZKF8hmhFj1B+e5DMdK8eSUXD+O0F97AX/sgY6Ga89uPkPVrgDDPLWKazj/mEUrYIRB018tjUK1/uGgViYr1QuV0w9OzVRVX981O6kusdt+LGWoFqu18ydg40zCxsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdsDEYyp; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2b4520f6b32so7774123eec.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 09:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768931704; x=1769536504; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1Zkk8Rbl5UtyAFvKLFxnlSYhtBzOt3i2r/yOWe3G6LM=;
        b=QdsDEYyp1nQu9i0VDh0MQvtMzZTlMZFk2coVgfRqGYRlBEY4B8dnMGIuA5hXrTxEC1
         JMcsTejg5t97f1JRitW3HI720QK129l4Z8qQ7Mwn7GPgBHyR0DjOzxBMlMqZLae2bgke
         HXRdYqR80d0rnZgaReH64BB24/LXONjR1AbbctU9XE9jWp7Xy8z2MTjCykKT8kOxN5wA
         jMdpdUaTRbeG1gsVjhb83WwWhWz+o1mymhF5fR6U28pIlBMT5nbMsdM0qwMwlJw1L4Gh
         tgrIknfldBiqB04DraAusko5duhzhR3ZP1504Yjl8kaT0iSIR0o1mCyFQE0RPjxBlawb
         yU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768931704; x=1769536504;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Zkk8Rbl5UtyAFvKLFxnlSYhtBzOt3i2r/yOWe3G6LM=;
        b=CNyF2TCT7KhH1w6IHYg1IpUizmmVi4AS3IvTuhuqeeHs0s+Ox29ohTcR82LaNF5Cbw
         h8PAP7Hi40oP2YWfmqc+mUm4KpZ8uazj/CmNpvul5yHYJM2Nfg4PJRQJt72IIAyTYEeR
         oDTFr46E/e2wBssnU5rzH592XtgcrSf3HThT1SE+BYq9AItS0IaAvcZC1x7G7v+Wdjvk
         Xu62l3AiV4HXjnsCR5iWdKGEQVb2mMuscZeijY/I4DIXsSrs4mgftO0ZDBWiLju4/3Sk
         ioWyP9TylK8iZbZChqS2ohjPkenOFheKjAp/H7i00BoG9CAAQ36y5PFQB/6N7FzqDznY
         MvsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWW2SAMdrcQY5mrVND17fecW0gF/d1W/OQXrPjvV9ZSS/nWGP0ie7o9zocv7ona5eZUDXpOHmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqILX4Cr6ykMkPtjZXbYUfFHl6WTpGEEJhT1Esbh8jfpK418zi
	W6JqMQDE3KXnoc9gow8kzSrYCiIwCTFUSDWGUAtHEA6FqezM16557X/w
X-Gm-Gg: AZuq6aJFNrqdjuqPgqylTnqr258X9b8e4duu9huz2MN865mXfi2jmstxLbbU13xO06C
	MsY0MGQNUfAbe4VnDGoIh2e13IfsZEtjQ8hJ5AWy1yLTV+coA958pAzKnYOhVfJCvtkAmb0LGH0
	kVX60x2yzvSh9GHhjdVNPZBgu1FCpxti8TcFbTAVXQR5zrzEVFZN0CFFWEJ6HCG1fj3vqC13WQ4
	LmCTegWQR0miH/nKowKEfF3PB4GBSaaaziIaSpniQahGlRxWV+Px7eVvFDYNflmKpiRtgwUOfmi
	k/TiU22X1vLaKj6I7TCYZAzpjKwyC86dFInvVUSY2bIhU70kDP+0spFcL09Drugw9BtwzhMDEYP
	v3AOx99hfT9mmQ55FUtFdlhESocQFHRgy4kOIVT4NaH+oyPTqxlfS8WkgaAybWgNWW8t8h7CtOI
	UY30NyEipHgO6hyNbXzEbVA9pWosbuhOj5hbcvd/tpoHcmYlLL0PXw0XJGjx8N/8dvv8/j
X-Received: by 2002:a05:7300:6ca1:b0:2b0:5a77:5753 with SMTP id 5a478bee46e88-2b6fd78df36mr1990065eec.21.1768931703406;
        Tue, 20 Jan 2026 09:55:03 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:b08c:bb3d:92b9:704d? ([2620:10d:c090:500::3:93b1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b34c0f7fsm17960598eec.3.2026.01.20.09.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 09:55:03 -0800 (PST)
Message-ID: <5ca8756f0387e5b2be47e9522b1f4b5fc149768d.camel@gmail.com>
Subject: Re: [PATCH bpf RESEND v2 1/2] bpf: Fix memory access flags in
 helper prototypes
From: Eduard Zingerman <eddyz87@gmail.com>
To: Zesen Liu <ftyghome@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh	 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo	
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski	
 <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Daniel Xu
 <dxu@dxuuu.xyz>, 	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, Shuran Liu	
 <electronlsr@gmail.com>, Peili Gao <gplhust955@gmail.com>, Haoran Ni	
 <haoran.ni.cs@gmail.com>
Date: Tue, 20 Jan 2026 09:54:59 -0800
In-Reply-To: <B91D5A7E-4967-416D-A2AC-CD3428F3C702@gmail.com>
References: <20260118-helper_proto-v2-0-ab3a1337e755@gmail.com>
	 <20260118-helper_proto-v2-1-ab3a1337e755@gmail.com>
	 <55f01664fc714615206cc8d100cabf4f310f2302.camel@gmail.com>
	 <B91D5A7E-4967-416D-A2AC-CD3428F3C702@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251571-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,goodmis.org,efficios.com,davemloft.net,redhat.com,dxuuu.xyz,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 858A34AF23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-01-20 at 11:39 +0800, Zesen Liu wrote:
> [...]
>=20
> > On Jan 20, 2026, at 04:24, Eduard Zingerman <eddyz87@gmail.com> wrote:
> >=20
> > Q: why ARG_PTR_TO_UNINIT_MEM here, but not for a previous function and
> >   not for snprintf variants?
>=20
> For bpf_get_stack_proto_raw_tp, I chose ARG_PTR_TO_UNINIT_MEM to be consi=
stent with its siblings:
>=20
> =E2=80=A2 bpf_get_stack_proto_tp (bpf_trace.c:1425)
> =E2=80=A2 bpf_get_stack_proto (stackmap.c:525)
> =E2=80=A2 bpf_get_stack_sleepable_proto (stackmap.c:541)
>=20
> All of these are wrappers around the same core function bpf_get_stack() /=
 __bpf_get_stack(), passing the buffer with identical semantics, and all us=
e ARG_PTR_TO_UNINIT_MEM.

Ack, makes sense, thank you for explaining.

