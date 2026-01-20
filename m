Return-Path: <netdev+bounces-251572-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KD7gDkXFb2mgMQAAu9opvQ
	(envelope-from <netdev+bounces-251572-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:11:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C6D492A4
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B23E4884FE8
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 17:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F38A44A723;
	Tue, 20 Jan 2026 17:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gR8mMOvB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD775449EDC
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768931771; cv=none; b=bLneu9Sj6dVHb5p+Zqv6DxEl7ZZsoMHBDVNt88g/Dm/qykUSwN6jaXcm6urhk7gUG73y/D9csQGlNhK3ZoB/cWPRSATg7Fj4VoVB2BiMu3pOi+QurD9Oj7S8fBkrhCXvBA+z+0FZ8DlO+DsSN8rf56kgX/33eTzgVggTj7XQ5hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768931771; c=relaxed/simple;
	bh=bntCYoY/lWBskz/E4EMaSD5LphJe4tlIc8UXi+CQOYM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V2BzC503MOhw5nxTKHPu0vwW0ol86jH9fXxuhSOihgLYGbZIFnXTEyNF7U9XWJgGEQUgByUGgu8U4pe1rpu3Cghr5IW38o/Rm/9slXq6bcdRbzSiLLAaUw2f826lo3NUAtSeDB5WJgX9gz2yJp7MkAtq0IlS2+9hs/uTJbAU8uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gR8mMOvB; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1233b172f02so7002744c88.0
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 09:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768931768; x=1769536568; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bntCYoY/lWBskz/E4EMaSD5LphJe4tlIc8UXi+CQOYM=;
        b=gR8mMOvBYSYs4BDd+EuMw286bxsDrKO4AlPwF9KVstZhN1kymsTmbasIhsPF5of6di
         /O3mucE5owcpmwBrw7zrhAj1lRzUp8XrV9ZCsS2rwuBgIQeMu1COKMYVsC0+k+Y0q/tT
         f9VUsiVtLr/yo7A8DMvlBLZmmA2SqtXzYJ/r3tWtmvMXu+aEp5GO+b0oSCIOHkGqfAVG
         x9t5wmZligD8PQIeUCfahqpVz5NUaJYsGSKVU/cI+ojkRViUnncRrWh7467dLBmaNqNJ
         YzWzNewZPbM599cBMRIgs6K9lHlb1g+zUqoYmvRx3voaovo8RXtorooaS6vLoeh//FcJ
         68Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768931768; x=1769536568;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bntCYoY/lWBskz/E4EMaSD5LphJe4tlIc8UXi+CQOYM=;
        b=Fi726Z5863q/VofrkMW4X+3BR6X2h8YN1Xp6G/AjSIB9M4B9OZ85VnD7YZC+65pmHx
         5/9eYejfNYshS3NLIpQ9J6rsHqvR6lBAmcURrqV6RPKLkJXiDDr0by8dgMDl29eEbNs9
         yuiHLpztvQwzSoNfaREn0E/Nz6vkIf0XlsVpOq6pZqBjTm3TcBtQ4HQREAwh0qgCDXI3
         ax13HrczRilQvUyKX1aGs/AOnbA/zjG6vfYoXpGw+rPC7BgbmG/Q4jgwLtkn5oiTGVLZ
         SsALS1JqyF+Cm8cmm/pTFL6+0BgXvM5d7AS2mJw4RYK7gIfAr2ACG1ipySBgyygd7aL6
         eD7g==
X-Forwarded-Encrypted: i=1; AJvYcCVglthBSiGd0MM6sUFCcxDdSR/pj49M0tFYqELwFxvzOfhG+fGjJkTeduVqsaF7+6P2GvZAwxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd52sjQrcBg2f9QNHSUutcSovMbS6/jXqaqoKVyJQ5cvTxT6BD
	tJXKboqk7Eb37yP4VRks1qGgVhKlm9s7Qma25axjRUHpi0nlnv71BLYR
X-Gm-Gg: AZuq6aIFk+Wrgt1OLEBKoO6ms+a07rseUoZXDDMjpTDYhgs4UNCCAI8MBbXgDz6WQY5
	o0PSoBpH0aungC3r33RjbtCVZX509IQLqz89CVTTiejdYOhMK56Tviu7zkOrOxq1lbq7LgM/Bo7
	JxsNmhq9uzh5nxnmIaufTR9klEDOAFVv9qVLkrv0pgLrPyTZeueYz9ilsfEbQ6rX4S4owagrLDY
	psaxTIyJ/9ZuvXc+EAEG21srksHItN/sQCjr/UfHIDkjgPLfPFSEH+RFKklrO0paRkvGj2AUzlG
	EO5sthVQFLgVWJDrOvlobzj7JF1plS7S+DhHsY0pUywSUXayfRbubB+vMTHj/kgoIWQWAKNqJU6
	b0HeMEejWz5KoTtZtH6lhgi7s1czLkg3eL5aernhyl6JsgckW5KmCoA6Fs1ZO2tekpEgCaarzEx
	BYeJd5craIrVXAqnhD0asXnhZnRshDBj6vY/GC/AQY/k+tjP4nKJy5aZNPkqgruR6mCvEk
X-Received: by 2002:a05:7301:7c0e:b0:2b0:4c12:d74d with SMTP id 5a478bee46e88-2b6fd746d53mr1663983eec.15.1768931767667;
        Tue, 20 Jan 2026 09:56:07 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:b08c:bb3d:92b9:704d? ([2620:10d:c090:500::3:93b1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6c2de1f29sm16004104eec.15.2026.01.20.09.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 09:56:07 -0800 (PST)
Message-ID: <00d9e1ea7e4eef7a7891200a03e99083cdbd066c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Fix memory access flags in helper
 prototypes
From: Eduard Zingerman <eddyz87@gmail.com>
To: Zesen Liu <ftyghome@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Matt Bobrowski <mattbobrowski@google.com>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu	 <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,  "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, Shuran Liu
	 <electronlsr@gmail.com>, Peili Gao <gplhust955@gmail.com>, Haoran Ni
	 <haoran.ni.cs@gmail.com>
Date: Tue, 20 Jan 2026 09:56:03 -0800
In-Reply-To: <20260120-helper_proto-v3-1-27b0180b4e77@gmail.com>
References: <20260120-helper_proto-v3-0-27b0180b4e77@gmail.com>
	 <20260120-helper_proto-v3-1-27b0180b4e77@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-251572-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net,linux.dev,fomichev.me,google.com,goodmis.org,efficios.com,davemloft.net,redhat.com,dxuuu.xyz];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
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
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: E0C6D492A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-01-20 at 16:28 +0800, Zesen Liu wrote:
> After commit 37cce22dbd51 ("bpf: verifier: Refactor helper access type tr=
acking"),
> the verifier started relying on the access type flags in helper
> function prototypes to perform memory access optimizations.
>=20
> Currently, several helper functions utilizing ARG_PTR_TO_MEM lack the
> corresponding MEM_RDONLY or MEM_WRITE flags. This omission causes the
> verifier to incorrectly assume that the buffer contents are unchanged
> across the helper call. Consequently, the verifier may optimize away
> subsequent reads based on this wrong assumption, leading to correctness
> issues.
>=20
> For bpf_get_stack_proto_raw_tp, the original MEM_RDONLY was incorrect
> since the helper writes to the buffer. Change it to ARG_PTR_TO_UNINIT_MEM
> which correctly indicates write access to potentially uninitialized memor=
y.
>=20
> Similar issues were recently addressed for specific helpers in commit
> ac44dcc788b9 ("bpf: Fix verifier assumptions of bpf_d_path's output buffe=
r")
> and commit 2eb7648558a7 ("bpf: Specify access type of bpf_sysctl_get_name=
 args").
>=20
> Fix these prototypes by adding the correct memory access flags.
>=20
> Fixes: 37cce22dbd51 ("bpf: verifier: Refactor helper access type tracking=
")
> Co-developed-by: Shuran Liu <electronlsr@gmail.com>
> Signed-off-by: Shuran Liu <electronlsr@gmail.com>
> Co-developed-by: Peili Gao <gplhust955@gmail.com>
> Signed-off-by: Peili Gao <gplhust955@gmail.com>
> Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
> Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
> Signed-off-by: Zesen Liu <ftyghome@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

