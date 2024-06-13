Return-Path: <netdev+bounces-103293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BA49076B5
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 17:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E645AB22BF1
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 15:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1019912D760;
	Thu, 13 Jun 2024 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y+F6lLP+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CCD12D74D
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718292659; cv=none; b=mREiI0W/FZb1rAlVN/PbtpJo54LcNyIbzFAkNIKQBM3mKeJJxBFi/Le0tQuMh42F8txyE7niRNd6vGQgaALikZKWQN5ve80h/Uo0OH5ba/b/hzR3rMsXIOx7rmqOoxMov5e/iLT8JZXXZZC2cyXOS+ZNBZ1n1c9Y2MfaF29jUek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718292659; c=relaxed/simple;
	bh=J0YXcS0yVLMlNmLhiJtHAS5nLbSv266GlVGAB6y80OQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnXS6ywmVCgv5tnFhekiQrAtVcNWudy8i2AVBXDKDpl/0UMgmdCavEIx5xWdAH5f2NjpXhXx1mkiGzhPZB7huDrcgzkDWthO4ictUW1lLYhVf3bzXrzCsOHfXa/3Sp9UWMQASSah8q9ozs6Magl6dX7l/CPzczB5h0VFiis98hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y+F6lLP+; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-35f2c9e23d3so1539822f8f.0
        for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 08:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718292652; x=1718897452; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pnKa8ZO6T2nbB0qZaG5vmw7Gy5VTMA26IvvfcD7IrPA=;
        b=Y+F6lLP+5YyXIdngfBKWGc+O9OfrEAlQ0zLuq0pAFY9H7mpx9jRxS38nf9AovDicg7
         KEVxjTvvkY4RJA3HzM6lrJmreid0Mg+HF0Jc4lkDjN2l88JSZM7oIGNFUmTc7nVK5hG7
         dlCEK5DjaO3JttQvM/7d0GXpGa9Am63ax++Gj7E5wvMTGDaPksQrI6pEg/BTQvsFhvHL
         26s2YM410pjwHmOzxMf9vv6nnASR+iq/X61hW1AsazoIMaoSJAFg99kOYFaBDb+bSzBB
         JmAWasWFTjTyXRImQS32T+dbhUw/h3eawvYuUyxRhQJ5gSfM6YQm++m2vtPF3wS7osec
         j06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718292652; x=1718897452;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pnKa8ZO6T2nbB0qZaG5vmw7Gy5VTMA26IvvfcD7IrPA=;
        b=vZ4XCcpsIiACJeOt7kBVyNhFGCBbDluTwNbOJ6kT7rqxTSwkVFPXkZYZFm9CCGWJ/n
         c8bn4JdzObm17RbhD/q9k8bi1P1wQI0VvnKgXnC0OcPRFvpwrBl8ARnZ2RD7DnWYgcZG
         JnX4ZzEnEANxDQztuYwvQXiv1XW0UjuuECiuCBYOVKR4z2lTH97RszJSFqpN6UwQeklS
         T/OmDfiOSxpaJEQz0SeRAIpM0aIFPkMoLZnT+Doxmm1Ac9W49xXCOcxbAYoEvCR9SMbh
         n0ofqyPNh8vB2NBkGgguL7b4zz+tlxTChfhpw2Ode8xZztSpBeLjbVx9LG/oDdBRx1eN
         7sbw==
X-Forwarded-Encrypted: i=1; AJvYcCWBS+iilTJsV/NnJ36NBfVgl3M0X93XQtrebQqabGrDhYXXArZIU64MoFoeICLQqiosyRWi3tkwTOzmM0MZAn8wfgNqmS7T
X-Gm-Message-State: AOJu0YzvEOFZQD8ajvttUeCd+z6neb8qljO57L9eHDx163kDbypDYgTN
	o45XNTb7nYuY1rkrwzyznWyy67ctChJZ8wyXDpHJRPI7ry+h6AfYpSwiDAqiuYs=
X-Google-Smtp-Source: AGHT+IHdGDo67hUjXR0SMeZfHO2H2rXgEJe/sKZPt6NpyDphZIL3XH2oN+tbU+tZS7QS7iimtevZhQ==
X-Received: by 2002:adf:f24d:0:b0:35f:3145:a097 with SMTP id ffacd0b85a97d-36071901378mr3135403f8f.23.1718292651885;
        Thu, 13 Jun 2024 08:30:51 -0700 (PDT)
Received: from u94a (61-227-71-100.dynamic-ip.hinet.net. [61.227.71.100])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b956a21836sm389708173.136.2024.06.13.08.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 08:30:51 -0700 (PDT)
Date: Thu, 13 Jun 2024 23:30:42 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
Cc: Maciej =?utf-8?Q?=C5=BBenczykowski?= <zenczykowski@gmail.com>, 
	Linux Network Development Mailing List <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	BPF Mailing List <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH bpf] bpf: fix UML x86_64 compile failure
Message-ID: <bv44ythtmj5sh7uqoo6ydvsdae6r4lamrpkn4gn3n2wx4jebs7@ek3vf4o3m64r>
References: <20240613112520.1526350-1-maze@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240613112520.1526350-1-maze@google.com>

On Thu, Jun 13, 2024 at 04:25:20AM GMT, Maciej Żenczykowski wrote:
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Fixes: 1ae6921009e5 ("bpf: inline bpf_get_smp_processor_id() helper")
> Signed-off-by: Maciej Żenczykowski <maze@google.com>
> ---
>  kernel/bpf/verifier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 36ef8e96787e..7a354b1e6197 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20313,7 +20313,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>  			goto next_insn;
>  		}
>  
> -#ifdef CONFIG_X86_64
> +#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
>  		/* Implement bpf_get_smp_processor_id() inline. */
>  		if (insn->imm == BPF_FUNC_get_smp_processor_id &&
>  		    prog->jit_requested && bpf_jit_supports_percpu_insn()) {

The patch needs a change description[1].

Maybe something along the line of why pcpu_hot.cpu_number not accessible
in User-mode Linux? (I don't know bpf_get_smp_processor_id() or UML that
well, just suggesting possible change description)

1: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

