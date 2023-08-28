Return-Path: <netdev+bounces-31004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC36478A7BD
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 10:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF501C208BA
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 08:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC82440C;
	Mon, 28 Aug 2023 08:33:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBAB632
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 08:33:24 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB52E0
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 01:33:23 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so3862234a12.2
        for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 01:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1693211601; x=1693816401;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=KlU7prAFO78u6FO2NXinFlb1Ej3G0cvXArnnUWfJS1E=;
        b=OK+QfG5ztCrkWKZ2ZJut74sBKaxxBpKaTtp4698eRAv7/z/ZnPaOphiRZOD6lvxw3K
         ltSedaGtCqpu5GBCp0oPoLa8ZiwCyB8zrUiv/O/FqRGQFtLzQ4XLpyzBSaWB000Sc29d
         ETB+OT4we0h6TGYZJR+Wr37R3F080iqUtqgJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693211601; x=1693816401;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlU7prAFO78u6FO2NXinFlb1Ej3G0cvXArnnUWfJS1E=;
        b=Fdopi+n0O/GpmEAePGJjb8psT5/cf++zZdt9p/8rw78+izKt7udTrX/RSvlYlvu5gz
         C2LB76gZ5vdpMoV/Wcs4KeCFJxKKU8D1srceprNQiq7kaS2gy1Bdktb5V153NGm54Nux
         REW4WGKYZ7a0mt1yBoePAdHXpYWTa8ZhYYLMmwJA+oKM+1UbQY4Qn/aA62nD0C7n7p35
         6jwankRLDKprnteGCo2UqE2GEWF+5ODMutChhoToCriLv+/iO/iZmgGgYeNLn4Zriz68
         gi5UGsvlBnyCs9+qrLuc1f0zLB7JD7g3bCiu3l4QBizRgzm4jneD1JawgE8BgGuga5o/
         u/4Q==
X-Gm-Message-State: AOJu0Yxbf7wRmyD8zmIs0rGNCDQtBa3XM6/vZ9ya+LN0nZkiBuiDUg7s
	TEpB5jdo0wqqbTDxlGis0p874A==
X-Google-Smtp-Source: AGHT+IH/Pzn+oZ9rkbvwB6EgbaZHwI3oR3oayPWryQaegSwpBzxqD24I4U2U0WI2wP6mB9GBIeT2Lg==
X-Received: by 2002:aa7:c04c:0:b0:522:3a89:a79d with SMTP id k12-20020aa7c04c000000b005223a89a79dmr17861471edo.2.1693211601437;
        Mon, 28 Aug 2023 01:33:21 -0700 (PDT)
Received: from cloudflare.com (79.184.208.4.ipv4.supernova.orange.pl. [79.184.208.4])
        by smtp.gmail.com with ESMTPSA id v21-20020a056402185500b00528dc95ad4bsm4229378edy.95.2023.08.28.01.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 01:33:20 -0700 (PDT)
References: <20230824143959.1134019-1-liujian56@huawei.com>
 <20230824143959.1134019-2-liujian56@huawei.com>
 <87r0nr5j0a.fsf@cloudflare.com> <64e95611f1b33_1d0032088c@john.notmuch>
User-agent: mu4e 1.6.10; emacs 28.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: Liu Jian <liujian56@huawei.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/7] bpf, sockmap: add BPF_F_PERMANENT flag
 for skmsg redirect
Date: Mon, 28 Aug 2023 10:13:29 +0200
In-reply-to: <64e95611f1b33_1d0032088c@john.notmuch>
Message-ID: <87a5uba7n4.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 25, 2023 at 06:32 PM -07, John Fastabend wrote:
> Jakub Sitnicki wrote:

[...]

>> But as I wrote earlier, I don't think it's a good idea to ignore the
>> flag. We can detect this conflict at the time the bpf_msg_sk_redirect_*
>> helper is called and return an error.
>> 
>> Naturally that means that that bpf_msg_{cork,apply}_bytes helpers need
>> to be adjusted to return an error if BPF_F_PERMANENT has been set.
>
> So far we've not really done much to protect a user from doing
> rather silly things. The following will all do something without
> errors,
>
>   bpf_msg_apply_bytes()
>   bpf_msg_apply_bytes() <- reset apply bytes
>
>   bpf_msg_cork_bytes()
>   bpf_msg_cork_bytes() <- resets cork byte
>
> also,
>
>   bpf_msg_redirect(..., BPF_F_INGRESS);
>   bpf_msg_redirect(..., 0); <- resets sk_redir and flags
>
> maybe there is some valid reason to even do above if further parsing
> identifies some reason to redirect to a alert socket or something.
>
> My original thinking was in the interest of not having a bunch of
> extra checks for performance reasons we shouldn't add guard rails
> unless something really unexpected might happen like a kernel
> panic or what not.
>
> This does feel a bit different though because before we
> didn't have calls that could impact other calls. My best idea
> is to just create a precedence and follow it. I would propose,
>
> 'If BPF_F_PERMANENT is set apply_bytes and cork_bytes are
>  ignored.'
>
> The other direction (what is above?) has a bit of an inconsistency
> where these two flows are different?
>
>   bpf_apply_bytes()
>   bpf_msg_redirect(..., BPF_F_PERMANENT)
>
> and
>
>   bpf_msg_redirect(..., BPF_F_PERMANENT)
>   bpf_apply_bytes()
>
> It would be best if order of operations doesn't change the
> outcome because that starts to get really hard to reason about.
>
> This avoids having to add checks all over the place and then
> if users want we could give some mechanisms to read apply
> and cork bytes so people could write macros over those if
> they really want the hard error.
>
> WDYT?

These semantics sound sane to me. Easy to explain:

BPF_F_PERMANENT takes precedence over apply/cork_bytes.

Good point about order of operations.

