Return-Path: <netdev+bounces-249653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EED7BD1BEAE
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 02:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C783A3022A9B
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 01:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB84296BA7;
	Wed, 14 Jan 2026 01:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2jGFA+F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF1F28CF42
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 01:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768353826; cv=none; b=lebPJ1dLo7shHQcBcgpQzHFoLoB3mlvtFaOdAsIKb49J9wZPTtH8sog/toIDGG3mHofuOQ8loBNmvRT06kZL1R0hVt3JexlG6tUoJhRGs4q2sM9yJP8H/zBytf+irZUUnK7wATQrciccM7olD/v+bl9XCgJWTBj6HRAl6OvTWSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768353826; c=relaxed/simple;
	bh=ijykEvQGSiIaTAZlysg8PO4CQBusHMugRnqZTrQnFN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZCIKXyBhiEholjKEbmD3P3Zq4i373KTiEEfPAM4oE30pcGIfMkzdiObVeyx7iCYmlnDCWlH/eKa674gBcScacIyR5fnePkT5fdar/CRe8bNOjbb4vcdxBbU7YWxFp665quinzZgyGvttXWYMeXMZT0GchArlybhugtilV7wJWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2jGFA+F; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b86f212c3b0so64474366b.0
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 17:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768353822; x=1768958622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NlyFcwZyRpcDosThA8F5NVUJa+yBeYcQ1mCq5w9CEo=;
        b=E2jGFA+FwygLzlz2Ymyd3b4/iPYEThAJBb3gXntmFXNRsiSZVBtm1yfYIOus6Qg8FY
         Y77XplbVuq2h10F1wxEkTDliuWU59inrEygIRSN+1d8CWI2jrdE5mYAiH/tEOc+JHWsD
         ba092p9cyoa0A/gkU/yham768mmZJj7QDoAS7VoDoAbIS/vkeXKe5gEoHZO3BkEBurhc
         uxwi82zyR9PKbNt18jV7vEeRn+IVpDjFl4DnTP2ESxEE+OEYgjcsUUhT1wvjtzYhaVYG
         gWYGEgVD8Lr4qQDAI7WqdkpC1kYL7/Hw4v+alaD8bdUblRjjlwL7/Cs2dKXh3px2jTNP
         GnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768353822; x=1768958622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2NlyFcwZyRpcDosThA8F5NVUJa+yBeYcQ1mCq5w9CEo=;
        b=J/akdXmw5vd0PubeINJAzxa7oMKbKyXHFiW3yt5UgbdnuIULpoYU5vHC3k45kFsihy
         BP3jzx3vqTc8LTcfIPEkfPup4ij9ZL8DvNy0LXQUR8iC2s0e9RAJ/785SMWzn4ATEE45
         7KoeRUrREHUFC+XnOTNb+x4PvcWfR8n8ownMI8AhS6J2JXHys2Hd/6hKKhIZ9eiO6SRZ
         ndRvWu+mHPyhdjFwBsUcor6h+za4NPzdzVql8Q1qQ7nhcjzwzOFhXGUfSl+8lxhTR1mJ
         TLHcUy2zNymc6hoFBV9zJLqV7jItm4LGGcm5YWo75CeFIh09FUrd1cFuWzOAOMwNn0iA
         A2dg==
X-Forwarded-Encrypted: i=1; AJvYcCUCH1gRahH2EPrrgG6srgVlGE1rwMy6dSvZEmfNAerfOKUIMrQBBq9OVwyN/KR9zsyjpnj/4SY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqXC0Z3J2PIEk95g0RsupPqkpy8WsxOK62VU32kZqjyavhO06K
	KHzesQ4EQ5Aw0QJIPAaYqsgIRLvJzxt7lCq6AUcNYtjrI1IVDimhEQTYcleA8nBJqkkW91Yck9T
	UFd3IseNCwJEvUPaXnH2nj+ng02S3A0E=
X-Gm-Gg: AY/fxX7XnNEUhVlE6Xj5CrLCKgy97rrqGx9vw7C8IgovmvkEbh/hTWlQdVbnOS2vwX8
	950UNBNRufcJdYSaTyeSysV4lK5aBsrk7ttj3MhwDNtOJ6mB6rMo4H/TP3Np2BQ3H0JMLUdMp/7
	lXXMYCnCpauLiqdyXvtfmL8+Rmg74UytYuXRRdyJvhNe3c6K866fM15h+uymZG3UiVTXvJNw0dE
	1gnu5vPInAiPStQ68xuMCiQIIXFdLgrPzNWht+l+Uvor4eKUstkv2NQ7nczy6wYAjyCtco6jHQC
	OFHVFWK4kg8=
X-Received: by 2002:a17:907:7288:b0:b76:3472:52df with SMTP id
 a640c23a62f3a-b8761c22084mr83731566b.10.1768353822219; Tue, 13 Jan 2026
 17:23:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110141115.537055-1-dongml2@chinatelecom.cn> <20260110141115.537055-4-dongml2@chinatelecom.cn>
In-Reply-To: <20260110141115.537055-4-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Jan 2026 17:22:48 -0800
X-Gm-Features: AZwV_QgyLOtjG3Jx55TRrPtsosRVCNp0IhR4LULmLvQwemr6cEdA33RlbTpC_bk
Message-ID: <CAEf4BzYid4WaAkNLBegeN5FLiLTjZ1scToA-Sdpz3tqL6iE=Tw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 03/11] bpf: change prototype of bpf_session_{cookie,is_return}
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 6:12=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Add the function argument of "void *ctx" to bpf_session_cookie() and
> bpf_session_is_return(), which is a preparation of the next patch.
>
> The two kfunc is seldom used now, so it will not introduce much effect
> to change their function prototype.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  kernel/trace/bpf_trace.c                             |  4 ++--
>  tools/testing/selftests/bpf/bpf_kfuncs.h             |  4 ++--
>  .../bpf/progs/kprobe_multi_session_cookie.c          | 12 ++++++------
>  .../selftests/bpf/progs/uprobe_multi_session.c       |  4 ++--
>  .../bpf/progs/uprobe_multi_session_cookie.c          | 12 ++++++------
>  .../bpf/progs/uprobe_multi_session_recursive.c       |  8 ++++----
>  6 files changed, 22 insertions(+), 22 deletions(-)
>

LGTM, let's do it

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 5f621f0403f8..297dcafb2c55 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3316,7 +3316,7 @@ static u64 bpf_uprobe_multi_entry_ip(struct bpf_run=
_ctx *ctx)
>
>  __bpf_kfunc_start_defs();
>
> -__bpf_kfunc bool bpf_session_is_return(void)
> +__bpf_kfunc bool bpf_session_is_return(void *ctx)
>  {
>         struct bpf_session_run_ctx *session_ctx;
>
> @@ -3324,7 +3324,7 @@ __bpf_kfunc bool bpf_session_is_return(void)
>         return session_ctx->is_return;
>  }
>
> -__bpf_kfunc __u64 *bpf_session_cookie(void)
> +__bpf_kfunc __u64 *bpf_session_cookie(void *ctx)
>  {
>         struct bpf_session_run_ctx *session_ctx;
>
> diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/sel=
ftests/bpf/bpf_kfuncs.h
> index e0189254bb6e..dc495cb4c22e 100644
> --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> @@ -79,8 +79,8 @@ extern int bpf_verify_pkcs7_signature(struct bpf_dynptr=
 *data_ptr,
>                                       struct bpf_dynptr *sig_ptr,
>                                       struct bpf_key *trusted_keyring) __=
ksym;
>
> -extern bool bpf_session_is_return(void) __ksym __weak;
> -extern __u64 *bpf_session_cookie(void) __ksym __weak;
> +extern bool bpf_session_is_return(void *ctx) __ksym __weak;
> +extern __u64 *bpf_session_cookie(void *ctx) __ksym __weak;
>

(and actually drop these, vmlinux.h will have them)

>  struct dentry;
>  /* Description

[...]

