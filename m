Return-Path: <netdev+bounces-79334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6F5878C6F
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 02:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F8A91C2117F
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 01:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA12210E3;
	Tue, 12 Mar 2024 01:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="H+DBPEeS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A2A10782
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 01:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710207847; cv=none; b=fm0YMHdH1oNk7fw1P/nvjIN+4tQJp+1zc7g+zQTwjk+G+dv2v5fdAwAvl1ozmoqjkCee68C5yFu+/0G6OQAT8gUQ2YLapt8aUghyWESxd1mPZTjOwg+TqIyGwjQu7yBlbSXHqWrkB/93+g6s90/av4tm4CWF7TnLUTNQlqwBZdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710207847; c=relaxed/simple;
	bh=uFfJuhQfHN1jJpmCHkndoERuZP2CwvzUJu70xuEeI4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g54d+bjXeXcbccXlN5VbfE19zUUirav9ZP/GvbjGglZQdn3an6T2aG8DmJW2aBvGo0O5otEZDBhvGXlbHxAFrsUr98KwiNqJuzdEDUbAeqJYsdb+TpgL4KAWGeJ7XZww/YN8jfPRQX80cJQYF5w/pLMBjIFIexnVEr/WHijrYy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=H+DBPEeS; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dda8e5fa8dso9177015ad.2
        for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 18:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710207845; x=1710812645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=labtf93chunomZqW/vUnTTFsyT2Ay36RYxUH/Np39t8=;
        b=H+DBPEeS8Lo4eGaJw42yL0NKrh5JZqnsWD3PJpXg2WdV4On3zuOHa2pbKkEgp8KgwM
         E2gP8b13VIWjQYcoCeuhArpvokd5JPO5fsNtVwnB/qaxDMFcreS226XksmTrSa7JTv6E
         RPJWY/AtdnRcVYO86O+5aSQgsaFXt8B+isQzQ5Kg1o32qIEg8JYYvZ3TAG/7rYPTab1/
         5mqMlB9JV0TRkzsuiFWkAk9F+Lej9LlqyFzG6wJDAHCrsuroI4IN2wTKEI+oiiyU4JDN
         XgH4iScQ5bjCUuvNDlESAh3oT+EP13BKSPPpBl72W+mokQpqrdCAkiKQ68bb6nOnmir8
         O0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710207845; x=1710812645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=labtf93chunomZqW/vUnTTFsyT2Ay36RYxUH/Np39t8=;
        b=mqqsfeYCJK2WO6pBtiLqMHZuw8FOqNjhe8WDXs5iwT6YP8ObcmWJ5UqkB/r8XVL1Va
         430RcCCJRF37naicLt8VP9s5o1cix+y1Tv78N/F/CrdHgqG7dSn11Df1WUgNBMAlM8MX
         4LjvWeIg5k1Vu9WEp1XxNwegobKILhndEUAUKo69oB8RlpgNxBdn8R8I+d7WEdWfePB2
         dCF6d+TphQqD4W3zH/zPbTWt/1U/BtMH4oKwiJzWu1Va3pzpDyO5hh/EzCRbPJXNi819
         4t2/BR54fP8Wamn7KzJU/+cQ7ySW4OXaXcIPQqOos2t4H4erlzXDcKca9zUsi3pFHPO+
         AIxg==
X-Forwarded-Encrypted: i=1; AJvYcCWGynoChFYyM/wHyARu/wFnoDe8WmXZNYk6mMwa586SNFpwUg6asJAzcwLkbsStGISuqS6FoOomRno2KP5fJyG+wtCcb/1y
X-Gm-Message-State: AOJu0YwT3onrqk6YqsYbG2MdGX52oyJwep8Gn7tOyFrpUsQhIhc3HCYf
	w1dssKWLeIsOl/1ljg8GqkDqd1hUpsJxIVpuAtj6kdUY6Vais7ATCF4lqbBekhFkImy/A8GOzEs
	4EM0T7h8X6HpjTPlYjqDczfTGl1vXg7YlF+sNLw==
X-Google-Smtp-Source: AGHT+IErV3iMJSVZsOorpKVzsGY2UytkCGuC6pmqJE2LbhhD8namNE+eDxsMMlkkIxKkEYQlxwMbWYmXWufoMcMT79A=
X-Received: by 2002:a17:90a:8991:b0:29b:aee2:cc8f with SMTP id
 v17-20020a17090a899100b0029baee2cc8fmr6097802pjn.9.1710207845560; Mon, 11 Mar
 2024 18:44:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
 <20240311093526.1010158-9-dongmenglong.8@bytedance.com> <e8f37842-1ddf-4241-97f3-b83ffcb32ddc@isovalent.com>
In-Reply-To: <e8f37842-1ddf-4241-97f3-b83ffcb32ddc@isovalent.com>
From: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Date: Tue, 12 Mar 2024 09:43:54 +0800
Message-ID: <CALz3k9hDuUgT0bQWXRKVogJ9=UF0_zWu6dAJVYE380BHBy85JA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 8/9] libbpf: add support for
 the multi-link of tracing
To: Quentin Monnet <quentin@isovalent.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, davem@davemloft.net, 
	dsahern@kernel.org, dave.hansen@linux.intel.com, x86@kernel.org, 
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 11:29=E2=80=AFPM Quentin Monnet <quentin@isovalent.=
com> wrote:
>
> 2024-03-11 09:35 UTC+0000 ~ Menglong Dong <dongmenglong.8@bytedance.com>
> > Add support for the attach types of:
> >
> > BPF_TRACE_FENTRY_MULTI
> > BPF_TRACE_FEXIT_MULTI
> > BPF_MODIFY_RETURN_MULTI
> >
> > Signed-off-by: Menglong Dong <dongmenglong.8@bytedance.com>
> > ---
> >  tools/bpf/bpftool/common.c |   3 +
> >  tools/lib/bpf/bpf.c        |  10 +++
> >  tools/lib/bpf/bpf.h        |   6 ++
> >  tools/lib/bpf/libbpf.c     | 168 ++++++++++++++++++++++++++++++++++++-
> >  tools/lib/bpf/libbpf.h     |  14 ++++
> >  tools/lib/bpf/libbpf.map   |   1 +
> >  6 files changed, 199 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> > index cc6e6aae2447..ffc85256671d 100644
> > --- a/tools/bpf/bpftool/common.c
> > +++ b/tools/bpf/bpftool/common.c
> > @@ -1089,6 +1089,9 @@ const char *bpf_attach_type_input_str(enum bpf_at=
tach_type t)
> >       case BPF_TRACE_FENTRY:                  return "fentry";
> >       case BPF_TRACE_FEXIT:                   return "fexit";
> >       case BPF_MODIFY_RETURN:                 return "mod_ret";
> > +     case BPF_TRACE_FENTRY_MULTI:            return "fentry_multi";
> > +     case BPF_TRACE_FEXIT_MULTI:             return "fexit_multi";
> > +     case BPF_MODIFY_RETURN_MULTI:           return "mod_ret_multi";
> >       case BPF_SK_REUSEPORT_SELECT:           return "sk_skb_reuseport_=
select";
> >       case BPF_SK_REUSEPORT_SELECT_OR_MIGRATE:        return "sk_skb_re=
useport_select_or_migrate";
> >       default:        return libbpf_bpf_attach_type_str(t);
>
> Hi, please drop this part in bpftool.
>
> bpf_attach_type_input_str() is used for legacy attach type names that
> were used before bpftool switched to libbpf_bpf_attach_type_str(), and
> that are still supported today. The names for new attach types should
> just be retrieved with libbpf_bpf_attach_type_str(). And function
> bpf_attach_type_input_str() is also only used for attaching
> cgroup-related programs with "bpftool cgroup (at|de)tach".

Okay! I was confused about this function, which has reduplicated
information about the attach type name, and I understand it now.

Thanks!
Menglong Dong

>
> Thanks,
> Quentin
>

