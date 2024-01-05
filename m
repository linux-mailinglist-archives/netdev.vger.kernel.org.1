Return-Path: <netdev+bounces-62115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5860825C35
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 22:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47723B239C4
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 21:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A26E225D3;
	Fri,  5 Jan 2024 21:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GOmZ2lDW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4FF225CF
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 21:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5574e188bedso18460a12.0
        for <netdev@vger.kernel.org>; Fri, 05 Jan 2024 13:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1704491153; x=1705095953; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yEXiwrq4KNUdt55Ouq+3g5whmUfNY0DSzzUMj+HSUwY=;
        b=GOmZ2lDWKJjz7amuXRF46WEwGTux/jfJdyxrGfZs9D3tuddraTjj2g2thlHTC1bxKG
         iKH3UEjQGy4sjb07GpYkX+ZLp1Yool2bhcaRpdqY0t9CJuDkz0nLHk8B+FdAn+nn7O4z
         9smLMcPHg1JtPUfYTzqHgsC9okA50zfkGbtY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704491153; x=1705095953;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yEXiwrq4KNUdt55Ouq+3g5whmUfNY0DSzzUMj+HSUwY=;
        b=LPLmGcwddrVxqOGxBJ9im2LOT+PWUWHu4WBWd0r41hVHEy/93f7+fBqhtXeeoFjXEx
         ewzAaETO664n5YVCtz5lNfspFsyuh9lzdkPHklnPa9/JNitG1rPM6FlIX4xEe6e2KN1E
         KLMOt4IOSTi+YGYtYfxeT2McB8k9HfUqFHqckEgcy81KQapQYgRihf0W5lITDH+KqTsT
         5lBOJk5AbHi9/OZLmdigyfCsoTZ4DPqcqtlZLMq8s7H3IKRF1rUTIbSA0ZE5ghY4ZwXo
         IgF6iOUyQSXi8N08rTImOzudyh+T3kdG8Syzy93+6a14HJ44JU0A0m+p6fCVX29ekMYS
         3/8g==
X-Gm-Message-State: AOJu0YxYqVoJoc63CokdFZLiSWrSHmtrRVfMIxjEb9uU2hbi07sTyOHN
	sBIxcUje5NR7ccjfhcGglruYvk4Fp+Zun9LBzYEaja4ys5c9TpxO
X-Google-Smtp-Source: AGHT+IErZKt0CSYk59mX1z4t7JCm+BFpTQZ9mWXBad3KiL9zjJwVzWpK2F0F9dfxJjPswGwxZOW+ZQ==
X-Received: by 2002:a17:906:e43:b0:a26:8c27:a6c6 with SMTP id q3-20020a1709060e4300b00a268c27a6c6mr10309eji.111.1704491152705;
        Fri, 05 Jan 2024 13:45:52 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id a5-20020a1709063a4500b00a28d309b063sm1275739ejf.220.2024.01.05.13.45.51
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 13:45:51 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3368b9bbeb4so24686f8f.2
        for <netdev@vger.kernel.org>; Fri, 05 Jan 2024 13:45:51 -0800 (PST)
X-Received: by 2002:a7b:c34d:0:b0:40d:4de8:222c with SMTP id
 l13-20020a7bc34d000000b0040d4de8222cmr35659wmj.252.1704491151463; Fri, 05 Jan
 2024 13:45:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103222034.2582628-1-andrii@kernel.org> <20240103222034.2582628-4-andrii@kernel.org>
In-Reply-To: <20240103222034.2582628-4-andrii@kernel.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Fri, 5 Jan 2024 13:45:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgmjr4nhxGheec1OwuYRk02d0+quUAViVk1v+w=Kvg15w@mail.gmail.com>
Message-ID: <CAHk-=wgmjr4nhxGheec1OwuYRk02d0+quUAViVk1v+w=Kvg15w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/29] bpf: introduce BPF token object
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

Ok, I've gone through the whole series now, and I don't find anything
objectionable.

Which may only mean that I didn't notice something, of course, but at
least there's nothing I'd consider obvious.

I keep coming back to this 03/29 patch, because it's kind of the heart
of it, and I have one more small nit, but it's also purely stylistic:

On Wed, 3 Jan 2024 at 14:21, Andrii Nakryiko <andrii@kernel.org> wrote:
>
> +bool bpf_token_capable(const struct bpf_token *token, int cap)
> +{
> +       /* BPF token allows ns_capable() level of capabilities, but only if
> +        * token's userns is *exactly* the same as current user's userns
> +        */
> +       if (token && current_user_ns() == token->userns) {
> +               if (ns_capable(token->userns, cap))
> +                       return true;
> +               if (cap != CAP_SYS_ADMIN && ns_capable(token->userns, CAP_SYS_ADMIN))
> +                       return true;
> +       }
> +       /* otherwise fallback to capable() checks */
> +       return capable(cap) || (cap != CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
> +}

This *feels* like it should be written as

    bool bpf_token_capable(const struct bpf_token *token, int cap)
    {
        struct user_namespace *ns = &init_ns;

        /* BPF token allows ns_capable() level of capabilities, but only if
         * token's userns is *exactly* the same as current user's userns
         */
        if (token && current_user_ns() == token->userns)
                ns = token->userns;
        return ns_capable(ns, cap) ||
                (cap != CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
    }

And yes, I realize that the function will end up later growing a

        security_bpf_token_capable(token, cap)

test inside that 'if (token ..)' statement, and this would change the
order of that test so that the LSM hook would now be done before the
capability checks are done, but that all still seems just more of an
argument for the simplification.

So the end result would be something like

    bool bpf_token_capable(const struct bpf_token *token, int cap)
    {
        struct user_namespace *ns = &init_ns;

        if (token && current_user_ns() == token->userns) {
                if (security_bpf_token_capable(token, cap) < 0)
                        return false;
                ns = token->userns;
        }
        return ns_capable(ns, cap) ||
                (cap != CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
    }

although I feel that with that LSM hook, maybe this all should return
the error code (zero or negative), not a bool for success?

Also, should "current_user_ns() != token->userns" perhaps be an error
condition, rather than a "fall back to init_ns" condition?

Again, none of this is a big deal. I do think you're dropping the LSM
error code on the floor, and are duplicating the "ns_capable()" vs
"capable()" logic as-is, but none of this is a deal breaker, just more
of my commentary on the patch and about the logic here.

And yeah, I don't exactly love how you say "ok, if there's a token and
it doesn't match, I'll not use it" rather than "if the token namespace
doesn't match, it's an error", but maybe there's some usability issue
here?

              Linus

