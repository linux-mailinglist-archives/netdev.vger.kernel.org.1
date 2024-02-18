Return-Path: <netdev+bounces-72741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA34859783
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 16:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 672F6281A26
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 15:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3246BFBE;
	Sun, 18 Feb 2024 15:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nok6Eciu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F306F6BB4D
	for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708268782; cv=none; b=F254NFLXCGbFU0+zZO3yV3x3AAvPEVWAC7z6ts+BwJWnkztXGLAiIetocSEfzOKZZt6ttLICBw5atLBn6vN/xSAWdTcoXrgvk0V8a3zHYS9ma6oERXKlCJEmdbIk4ZXhqgrmEl9wvUKc8GRXKZ+xsSYaegGmNDZVK5XLj2/cmZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708268782; c=relaxed/simple;
	bh=tGxXT1XhuS6erETM7SEYMuB1n/Ny+q6o/Kd1LNyFGkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WE5aYbVo2gOomwd1sKWt6uBBVQHg/2WHVUoiupttoDk5pJ7wM403KoDGsfOAWZO9lMVqgjCZXMO6a4wMiYVeU3v3nYP1VkiqRHXAf+ke0Mxbm4UOzgrrEvfMMCWxsHfnCexAISZ5nUPfsrLUPR6ZVPumTbK6hagnBsjMDn5SAjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Nok6Eciu; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso2839869a12.2
        for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 07:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708268780; x=1708873580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=weWvwdjLFnP8JZ5vKjO/UijVTnJpQLLncBhysMzZFhc=;
        b=Nok6EciuTdMz1z1pS6cwicCCDdDOCTlLLo8ABabxLV63CY9iqUxn64wyit7TOT0kaJ
         QX2hm83AMDkBl2NkOt5cVe4oG7h2l8B+qZVKbsRS73MoqmO7I6RX4K8TrcKX5jtJzLUk
         tI3z8QSxh8c2UaT8LapZMXo5PsTJA9g3cZCDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708268780; x=1708873580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weWvwdjLFnP8JZ5vKjO/UijVTnJpQLLncBhysMzZFhc=;
        b=eviR7sVqahrVdu32UV058XnCeHMogOgo3N644A65/06RMw0k4aECPDk7ROqabpp4i9
         1hYfMlWFRZW8rWb3afdCzloBr7Vsbm8lfyIadavT+bfW7/q8jAeavx6oKBSSBfEseGz6
         RZB71DYv1HIuXdsVpiSwbzR2inBSWf1veRBtZpPZH6DXqxO/nt6+kWXn9xiVfOIOEGa/
         lcw1PEDDVfseC1XGdUrZHnN56ynQGVrGQOb8B74HxsK3NfNp0RjKIwQwtILQEYcsjY0b
         6eO4crtO/s8pOHkU1peU75urXb/eLJ9aqvUdqd2NnWgZ7HWF67cPQtn1vs17Bf7LXlBD
         9ivg==
X-Forwarded-Encrypted: i=1; AJvYcCVTnXFQi8E3FQFU2BdEeNZLQRoLVWcE2iak6XpjivAVsS78piBCQy/plg3eRkPqAHBipCtipAU7O1jVYfWEWLGKILmRfjC9
X-Gm-Message-State: AOJu0YwnvF7z7lsnMFePE2/1Xs8bHSceHy42pYTazPy5YHYkPk/HN4u2
	940W0wX7C3qKPJvqvIRlFoRD4ORwK+InrPPgdLX+M2mYE2e8FtduZw5Vkp2p+Q==
X-Google-Smtp-Source: AGHT+IG/mO2zX6w/nhGHQ9iPPz8f+kIiHx6ka4l6BoesYRu+P37Fs580FgkZTJG8iwIS84D9OwUWXw==
X-Received: by 2002:a05:6a00:450e:b0:6e2:9bca:fdc4 with SMTP id cw14-20020a056a00450e00b006e29bcafdc4mr4640585pfb.21.1708268780315;
        Sun, 18 Feb 2024 07:06:20 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a30-20020aa78e9e000000b006e45fc20539sm598295pfr.123.2024.02.18.07.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 07:06:19 -0800 (PST)
Date: Sun, 18 Feb 2024 07:06:19 -0800
From: Kees Cook <keescook@chromium.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	"linux-hardening @ vger . kernel . org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: Take return from set_memory_ro() into
 account with bpf_prog_lock_ro()
Message-ID: <202402180701.FA42F70BE2@keescook>
References: <135feeafe6fe8d412e90865622e9601403c42be5.1708253445.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <135feeafe6fe8d412e90865622e9601403c42be5.1708253445.git.christophe.leroy@csgroup.eu>

On Sun, Feb 18, 2024 at 11:55:01AM +0100, Christophe Leroy wrote:
> set_memory_ro() can fail, leaving memory unprotected.
> 
> Check its return and take it into account as an error.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  include/linux/filter.h | 5 +++--
>  kernel/bpf/core.c      | 4 +++-
>  kernel/bpf/verifier.c  | 4 +++-
>  3 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index fee070b9826e..fc0994dc5c72 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -881,14 +881,15 @@ bpf_ctx_narrow_access_offset(u32 off, u32 size, u32 size_default)
>  
>  #define bpf_classic_proglen(fprog) (fprog->len * sizeof(fprog->filter[0]))
>  
> -static inline void bpf_prog_lock_ro(struct bpf_prog *fp)
> +static inline int __must_check bpf_prog_lock_ro(struct bpf_prog *fp)
>  {
>  #ifndef CONFIG_BPF_JIT_ALWAYS_ON
>  	if (!fp->jited) {
>  		set_vm_flush_reset_perms(fp);
> -		set_memory_ro((unsigned long)fp, fp->pages);
> +		return set_memory_ro((unsigned long)fp, fp->pages);
>  	}
>  #endif
> +	return 0;
>  }
>  
>  static inline void bpf_jit_binary_lock_ro(struct bpf_binary_header *hdr)
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 71c459a51d9e..c49619ef55d0 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2392,7 +2392,9 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
>  	}
>  
>  finalize:
> -	bpf_prog_lock_ro(fp);
> +	*err = bpf_prog_lock_ro(fp);
> +	if (*err)
> +		return fp;

Weird error path, but yes.

>  
>  	/* The tail call compatibility check can only be done at
>  	 * this late stage as we need to determine, if we deal
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c5d68a9d8acc..1f831a6b4bbc 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19020,7 +19020,9 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>  	 * bpf_prog_load will add the kallsyms for the main program.
>  	 */
>  	for (i = 1; i < env->subprog_cnt; i++) {
> -		bpf_prog_lock_ro(func[i]);
> +		err = bpf_prog_lock_ro(func[i]);
> +		if (err)
> +			goto out_free;
>  		bpf_prog_kallsyms_add(func[i]);
>  	}

Just to double-check if memory permissions being correctly restored on
this error path, I walked back through it and see that it ultimately
lands on vfree(), which appears to just throw the entire mapping away,
so I think that's safe. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

