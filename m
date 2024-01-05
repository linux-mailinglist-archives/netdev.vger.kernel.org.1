Return-Path: <netdev+bounces-62096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864B7825B90
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 21:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94B4C1C21020
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 20:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A862436090;
	Fri,  5 Jan 2024 20:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ODeaNIWx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795C235F12
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 20:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a27cd5850d6so208675366b.1
        for <netdev@vger.kernel.org>; Fri, 05 Jan 2024 12:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1704486359; x=1705091159; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jlHlTQ7UwNnsRaaZVTPe3koXZRT/RuAbWyf3puCIBE4=;
        b=ODeaNIWx2t7CashZkz1hXWkxYEfxBhKORMFfvuOacVhjq7OOMERQwGyQyCpQFcLp4h
         aLEf3Lcc26VivNBMcilEfeIkMOxm3T+1mGc1/bS0Jr9EfaunDbePXzKnRnyiljB71IBy
         EboFbe6nCFACPzykrGEaovL09sP3UfwrjIg7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704486359; x=1705091159;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jlHlTQ7UwNnsRaaZVTPe3koXZRT/RuAbWyf3puCIBE4=;
        b=WNuBB5q3k3st9ge5BbAtAyZrgqsCy3ehwmZECLmRT4lKXXXxTMIQdrNcqust4iW4C2
         qjcEYTVaVTDLKlqo32hmIcKrxqQ2BDuL96+YoYCTb3Mqyx1l1f5K/wwd8KtotDPN9ed2
         G++0CDG18K7Xej57kfcQ7UEdR+BXHiRH6xExUKkKJB99vCFh+9WL9D+fnG1fQs80UlMM
         Zg5KG8y5HRmFd8D6+RNSpWlJmMNOhh8d56EqzoxU6nSaxglmSQSOmWM2uwfvncgTkkIA
         CHdTCBNMSDbb9ECrmeC9a78YwSJg8kgeC7/cHnnP6pN5yqi0EMVcbtrhT8W98aLmYNst
         Ysxg==
X-Gm-Message-State: AOJu0YwY2VtrBz0jHg9zE3z23exolNW2C7kFxYuxNN21FwvUjOGY6SNi
	KpSMvZPe1/DDR99GmAGBhfECpcUcZQAHdEbkFnfS0GGhJUolQXab
X-Google-Smtp-Source: AGHT+IFVa2RMBMS8zKSkue/4AIOkdNUEv8H2jniNTlukPN8uBe9E1ukAlT7E+rsUmXFGTSuMcLurIg==
X-Received: by 2002:a17:907:c92:b0:a28:bcc0:57fe with SMTP id gi18-20020a1709070c9200b00a28bcc057femr1261160ejc.101.1704486359581;
        Fri, 05 Jan 2024 12:25:59 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id c23-20020a170906341700b00a28ee0680d1sm1228569ejb.214.2024.01.05.12.25.59
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 12:25:59 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a277339dcf4so208726066b.2
        for <netdev@vger.kernel.org>; Fri, 05 Jan 2024 12:25:59 -0800 (PST)
X-Received: by 2002:a17:906:25d4:b0:a27:9365:ef73 with SMTP id
 n20-20020a17090625d400b00a279365ef73mr1360283ejb.38.1704486358728; Fri, 05
 Jan 2024 12:25:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103222034.2582628-1-andrii@kernel.org> <20240103222034.2582628-4-andrii@kernel.org>
In-Reply-To: <20240103222034.2582628-4-andrii@kernel.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Fri, 5 Jan 2024 12:25:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi7=fQCgjnex_+KwNiAKuZYS=QOzfD_dSWys0SMmbYOtQ@mail.gmail.com>
Message-ID: <CAHk-=wi7=fQCgjnex_+KwNiAKuZYS=QOzfD_dSWys0SMmbYOtQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/29] bpf: introduce BPF token object
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

I'm still looking through the patches, but in the early parts I do
note this oddity:

On Wed, 3 Jan 2024 at 14:21, Andrii Nakryiko <andrii@kernel.org> wrote:
>
> +struct bpf_token {
> +       struct work_struct work;
> +       atomic64_t refcnt;
> +       struct user_namespace *userns;
> +       u64 allowed_cmds;
> +};

Ok, not huge, and makes sense, although I wonder if that

        atomic64_t refcnt;

should just be 'atomic_long_t' since presumably on 32-bit
architectures you can't create enough references for a 64-bit atomic
to make much sense.

Or are there references to tokens that might not use any memory?

Not a big deal, but 'atomic64_t' is very expensive on 32-bit
architectures, and doesn't seem to make much sense unless you really
specifically need 64 bits for some reason.

But regardless, this is odd:

> diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
> +
> +static void bpf_token_free(struct bpf_token *token)
> +{
> +       put_user_ns(token->userns);
> +       kvfree(token);
> +}

> +int bpf_token_create(union bpf_attr *attr)
> +{
> ....
> +       token = kvzalloc(sizeof(*token), GFP_USER);

Ok, so the kvzalloc() and kvfree() certainly line up, but why use them at all?

kvmalloc() and friends are for "use kmalloc, and fall back on vmalloc
for big allocations when that fails".

For just a structure, a plain 'kzalloc()/kfree()' pair would seem to
make much more sense.

Neither of these issues are at all important, but I mention them
because they made me go "What?" when reading through the patches.

                  Linus

